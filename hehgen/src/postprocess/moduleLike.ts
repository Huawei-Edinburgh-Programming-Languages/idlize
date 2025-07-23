/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { D, E, IdentityTransformer, lw, std, T, utils } from "lws";

export function postprocess(decls: lw.LWDeclaration[]): lw.LWDeclaration[] {
    decls = mergeTheSameNamespaces(decls)
    decls = mergeTheSameClasses(decls)
    return decls
}

function mergeTheSameNamespaces(decls: lw.LWDeclaration[]): lw.LWDeclaration[] {
    const index = new Map<string, lw.NamespaceDeclaration[]>()
    const others: lw.LWDeclaration[] = []
    decls.forEach(decl => {
        if (decl.kind !== lw.LWKind.NamespaceDeclaration) {
            others.push(decl)
            return
        }
        if (!index.has(decl.name)) {
            index.set(decl.name, [])
        }
        index.get(decl.name)?.push(decl)
    })

    const result: lw.LWDeclaration[] = others
    index.forEach((records, name) => {
        if (records.length === 0) {
            return
        }
        if (records.length === 1) {
            result.push(records[0])
            return
        }
        result.push(D.ns(name, mergeTheSameNamespaces(records.map(r => r.members).flat())))
    })
    return result
}

function mergeTheSameClasses(decls: lw.LWDeclaration[]): lw.LWDeclaration[] {
    const index = new Map<string, lw.ClassDeclaration[]>()
    const others: lw.LWDeclaration[] = []
    decls.forEach(decl => {
        if (decl.kind !== lw.LWKind.ClassDeclaration) {
            others.push(decl)
            return
        }
        if (decl.generics.length > 0) {
            return
        }
        if (!index.has(decl.name)) {
            index.set(decl.name, [])
        }
        index.get(decl.name)?.push(decl)
    })

    const result: lw.LWDeclaration[] = others
    index.forEach((records, name) => {
        if (records.length === 0) {
            return
        }
        if (records.length === 1) {
            result.push(records[0])
            return
        }
        const tmp = D.class(name, [], [])
        records.forEach(rec => {
            tmp.fields.push(...rec.fields)
            tmp.methods.push(...rec.methods)
        })
        result.push(tmp)
    })
    return result
}

/////////////////////////////////////////////////////

interface ResultFile {
    moduleLikeImports: Map<string, Set<string>>
    body: lw.LWDeclaration[]
}

class RefSearcher extends IdentityTransformer {
    constructor(
        private registry: Map<string, string>,
        private imports: Map<string, Set<string>>
    ) { super() }

    private nsStack: string[] = []
    private trimNs(name:string): string {
        const prefix = this.nsStack.join('.') + '.'
        if (name.startsWith(prefix)) {
            return name.substring(prefix.length)
        }
        return name
    }
    goNamespaceDeclaration(decl: lw.NamespaceDeclaration): lw.NamespaceDeclaration {
        this.nsStack.push(decl.name)
        const r = super.goNamespaceDeclaration(decl)
        this.nsStack.pop()
        return r
    }

    private getBase(name:string) {
        return name.split('.').at(0)!
    }

    goConstType(type: lw.ConstType): lw.LWType {
        if (!type.name.startsWith('@')) {
            const record = this.registry.get(type.name)
            if (record) {
                if (!this.imports.has(record)) {
                    this.imports.set(record, new Set())
                }
                let val = type.name
                if (val.startsWith(record)) {
                    val = val.substring(record.length)
                    while (val.startsWith('.')) {
                        val = val.substring(1)
                    }
                }
                this.imports.get(record)?.add(this.getBase(val))
                return T.c(this.trimNs(val))
            }
            return T.c(this.trimNs(type.name))
        }
        return super.goConstType(type)
    }
    goVariableExpression(expr: lw.VariableExpression): lw.VariableExpression {
        if (utils.hasAnnotation(expr, std.names.annotations.isType)) {
            const r = this.goConstType(T.cc(expr.name)) as lw.ConstType
            return E.v(r.name, expr.annotations)
        }
        return super.goVariableExpression(expr)
    }
}

function putToNs(declarations:lw.LWDeclaration[]): lw.LWDeclaration[] {
    const index = new Map<string, lw.LWDeclaration[]>()
    const result: lw.LWDeclaration[] = []
    declarations.forEach(decl => {
        const clause = decl.name.split('.')
        if (clause.length === 1) {
            result.push(decl)
            return
        }
        const [base, ...rest] = clause
        if (!index.has(base)) {
            index.set(base, [])
        }
        // TODO: clone!!!
        decl.name = rest.join('.')
        index.get(base)?.push(decl)
    })

    index.forEach((decls, name) => {
        result.push(D.ns(name, putToNs(decls)))
    })
    return result
}

export function formFiles(knownPackages: Set<string>, declarations: lw.LWDeclaration[]): Map<string, ResultFile> {

    // form files
    const files = new Map<string, lw.LWDeclaration[]>()
    const refIndex = new Map<string, string>()
    declarations.forEach(decl => {
        const chunks = decl.name.split('.')
        const clause: string[] = []
        while (chunks.length) {
            clause.push(chunks.shift()!)
            const prefix = clause.join('.')
            if (knownPackages.has(prefix)) {
                if (!files.has(prefix)) {
                    files.set(prefix, [])
                }
                // TODO: clone!!!!
                refIndex.set(decl.name, prefix)
                decl.name = chunks.join('.')
                files.get(prefix)?.push(decl)
                return
            }
        }

        if (!files.has('other')) {
            files.set('other', [])
        }
        files.get('other')?.push(decl)
    })

    // do namespace stuff
    const nsFiles = new Map<string, ResultFile>()
    files.forEach((decls, name) => {
        const rowImports = new Map<string, Set<string>>()
        const refSearcher = new RefSearcher(refIndex, rowImports)
        const nsDecls = putToNs(decls).map(it => refSearcher.goDeclaration(it))
        const imports = new Map<string, Set<string>>()
        rowImports.forEach((vals, imp) => {
            if (imp !== name) {
                imports.set(imp, vals)
            }
        })
        nsFiles.set(name, {
            moduleLikeImports: imports,
            body: nsDecls
        })
    })

    return nsFiles
}
