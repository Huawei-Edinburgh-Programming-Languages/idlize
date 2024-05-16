/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { PeerFile } from "./PeerFile"
import { PeerMethod } from "./PeerMethod"
import { DeclarationTable } from "./DeclarationTable"
import { Method, NamedMethodSignature, Type } from "./LanguageWriters"
import { Language } from "../util"

export interface PeerClassBase {
    setGenerationContext(context: string| undefined): void
    generatedName(isCallSignature: boolean): string
}

export class PeerClass implements PeerClassBase {
    constructor(
        public readonly file: PeerFile,
        public readonly componentName: string,
        public readonly originalFilename: string,
        public readonly declarationTable: DeclarationTable
    ) { }

    private nameMap = new Map<string, Array<PeerMethod>>()

    setGenerationContext(context: string| undefined): void {
        this.declarationTable.setCurrentContext(context)
    }

    generatedName(isCallSignature: boolean): string{
        return isCallSignature ? this.originalInterfaceName! : this.originalClassName!
    }

    analyze() {
        if (this.file.declarationTable.language != Language.TS) return
        // Find name overrides.
        for (let method of this.methods) {
            let name = method.method.name
            const list = this.nameMap.get(name)
            if (list) {
                list.push(method)
            } else {
                this.nameMap.set(name, [method])
            }
        }
        for (let methods of this.nameMap.values()) {
            if (methods.length > 1) {
                let syntheticOverrideTarget = this.createSyntheticOverrideTarget(methods)
                methods.forEach((method, index) => {
                    method.isNameOverride = true
                    method.method.name = `${method.method.name}_${index}`
                })
                this.methods.push(syntheticOverrideTarget)
            }
        }
    }

    private createSyntheticOverrideTarget(methods: Array<PeerMethod>): PeerMethod {
        let argCount = Math.max(... methods.map(method => method.method.signature.args.length))
        let types: Type[][] = []
        for (let i = 0; i < argCount; i++) {
            let variants: Type[] = []
            methods.forEach(method => {
                if (i < method.method.signature.args.length) {
                    let type = method.method.signature.args[i]
                    if (!variants.find(it => type.name == it.name)) {
                        variants.push(type)
                    }
                    if (type.nullable && !variants.find(it => it.name == 'undefined')) {
                        variants.push(Type.Undefined)
                    }
                }
            })
            types.push(variants)
        }
        let name = methods[0].method.name
        let signature = new NamedMethodSignature(
            methods[0].method.signature.returnType,
            types.map(it => new Type(it.map(it => it.name).join("|"))),
            types.map((it, index) => `arg${index}`)
        )
        let method = new Method(name, signature, methods[0].method.modifiers)
        let result = new PeerMethod(methods[0].originalParentName, methods[0].declarationTargets,
            methods[0].argConvertors, methods[0].retConvertor, methods[0].isCallSignature, method)
        result.isSyntheticOverrideTarget = true
        return result
    }

    methods: PeerMethod[] = []
    get callableMethod(): PeerMethod {
        return this.methods.find(method => method.isCallSignature)!
    }

    originalClassName: string | undefined = undefined
    originalInterfaceName: string | undefined = undefined
    originalParentName: string | undefined = undefined
    originalParentFilename: string | undefined = undefined
    parentComponentName: string | undefined = undefined
    attributesFields: string[] = []
    attributesTypes: string[] = []
    usedImportTypesStubs: string[] = []
    hasTransitiveGenericType: boolean = false
}