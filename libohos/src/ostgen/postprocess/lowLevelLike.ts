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

import { D, DD, IdentityTransformer, lw, Md, T, Ts } from "../../ost/main";
import { throwError } from "../library/utils";
import { zipStrip } from "@idlizer/core";

export function postprocess(decls: lw.LWDeclaration[]): lw.LWDeclaration[] {
    decls = removeInternal(decls)
    decls = introduceOptionalTypes(decls)
    decls = specializeGenerics(decls)
    decls = makeForwardDeclarations(decls)
    return decls
}

function removeInternal(decls: lw.LWDeclaration[]): lw.LWDeclaration[] {
    return decls.filter(it => !it.name.startsWith('capi.idlize.'))
}

class MakeOptional extends IdentityTransformer {
    override goStructureDeclaration(decl: lw.StructureDeclaration): lw.StructureDeclaration {
        decl.members.forEach(field => {
            if (field.modifiers?.includes(Md.optional()))
                field.type = T.c('idlize.Opt', field.type)
        })
        return decl
    }
    go(decls: lw.LWDeclaration[]) {
        return decls.map(decl => this.goDeclaration(decl))
    }
}

function introduceOptionalTypes(decls: lw.LWDeclaration[]): lw.LWDeclaration[] {
    return new MakeOptional().go(decls)
}

class MakeInstance extends IdentityTransformer {
    constructor(
        private subst: Map<string, lw.LWType>
    ) { super() }

    goConstType(type: lw.ConstType): lw.LWType {
        if (this.subst.has(type.name)) {
            return this.subst.get(type.name)!
        }
        return type
    }
    goDeclaration(decl: lw.LWDeclaration): lw.LWDeclaration {
        const processed = super.goDeclaration(decl)
        if (processed.kind === lw.LWKind.NamespaceDeclaration) {
            return processed
        }
        processed.generics = []
        return processed
    }
}

class MakeMono extends IdentityTransformer {
    private index = new Map<string, lw.LWDeclaration>()
    private newDecls: lw.LWDeclaration[] = []
    constructor(
        decls: lw.LWDeclaration[]
    ) {
        super()
        decls.forEach(decl => {
            this.index.set(decl.name, decl)
        })

        // known special types
        this.index.set(
            'idlize.Array',
            DD({ generics: [{ name: 'T' }] }).struct('synthetic.mono.Array', [
                { name: 'length', type: Ts.prim.i32 },
                { name: 'value', type: Ts.ptr(T.c('T')) }
            ])
        )
        this.index.set(
            'idlize.Map',
            DD({ generics: [{ name: 'K' }, { name: 'V' }] }).struct('synthetic.mono.Map', [
                { name: 'length', type: Ts.prim.i32 },
                { name: 'keys', type: Ts.ptr(T.c('K')) },
                { name: 'values', type: Ts.ptr(T.c('V')) },
            ])
        )
        this.index.set(
            'idlize.Opt',
            DD({ generics: [{ name: 'T' }] }).struct('synthetic.mono.Optional', [
                { name: 'tag', type: Ts.prim.tag },
                { name: 'value', type: T.c('T') },
            ])
        )
    }
    private makeSpecializedArgName(type: lw.LWType): string {
        switch (type.kind) {
            case lw.LWKind.ConstType: return type.name.split('.').pop()!
            case lw.LWKind.AppType: throw new Error("")
            case lw.LWKind.FuncType: throw new Error("")
        }
    }
    private makeSpecializedName(name: string, args: lw.LWType[]): string {
        return `synthetic.mono.instance.${name}_${args.map(it => this.makeSpecializedArgName(it)).join('_')}`
    }
    private specialize(name: string, args: lw.LWType[]): lw.LWType {
        const decl = this.index.get(name) ?? throwError(`Not found! "${name}"`)
        switch (decl.kind) {
            case lw.LWKind.StructureDeclaration: {
                const specialName = this.makeSpecializedName(name, args)
                if (!this.index.has(specialName)) {
                    const subst = new Map<string, lw.LWType>()
                    zipStrip(args, decl.generics).forEach(([arg, gen]) => {
                        subst.set(gen.name, arg)
                    })
                    const instance = this.goDeclaration(
                        new MakeInstance(subst).goStructureDeclaration(decl)
                    )
                    instance.name = specialName
                    this.newDecls.push(instance)
                    this.index.set(specialName, instance)
                }
                return T.c(specialName)
            }
        }
        throw new Error(`Unsupported generic declaration "${name}" of kind "${lw.LWKind[decl.kind]}"`)
    }

    goAppType(type: lw.AppType): lw.LWType {
        const processed = super.goAppType(type) as lw.AppType
        if (processed.head.startsWith('@') || processed.head.startsWith('#')) {
            return processed
        }
        return this.specialize(processed.head, processed.args)
    }

    go(decls:lw.LWDeclaration[]): lw.LWDeclaration[] {
        return decls.map(decl => this.goDeclaration(decl))
            .concat(this.newDecls)
    }
}

function specializeGenerics(decls: lw.LWDeclaration[]): lw.LWDeclaration[] {
    return new MakeMono(decls).go(decls)
}

function makeForwardDeclarations(decls: lw.LWDeclaration[]): lw.LWDeclaration[] {
    return decls
        .filter(it => it.kind === lw.LWKind.StructureDeclaration)
        .map(it => D.type(it.name, T.cc(it.name)) as lw.LWDeclaration)
        .concat(decls)
}