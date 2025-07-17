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

import { D, IdentityTransformer, lw } from "lws";

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

class RefSearcher extends IdentityTransformer {
    constructor(
        private registry: Map<string, string>,
        private imports: Set<string>
    ) { super() }

    goConstType(type: lw.ConstType): lw.LWType {
        if (!type.name.startsWith('@')) {
            const record = this.registry.get(type.name)
            if (record) {
                this.imports.add(record)
            }
        }
        return super.goConstType(type)
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

export function formFiles(knownPackages: Set<string>, declarations: lw.LWDeclaration[]): Map<string, lw.LWDeclaration[]> {

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
    const nsFiles = new Map<string, lw.LWDeclaration[]>()
    files.forEach((decls, name) => {
        const rowImports = new Set<string>()
        const refSearcher = new RefSearcher(refIndex, rowImports)
        nsFiles.set(name, putToNs(decls).map(it => refSearcher.goDeclaration(it)))
        const imports = Array.from(rowImports).filter(it => it !== name)
        console.error(name, imports)
    })

    return nsFiles
}
