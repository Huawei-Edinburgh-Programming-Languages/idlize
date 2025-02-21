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

import { createUpdatedInterface, createUpdatedMethod, IDLFile, isSequence, Typechecker } from "../utils/idl"
import {
    createContainerType,
    createMethod,
    createParameter,
    createReferenceType, IDLExtendedAttribute,
    IDLInterface,
    IDLMethod,
    IDLParameter,
    IDLType,
    isContainerType,
    isDefined,
    isInterface,
    isReferenceType, serializerBaseMethods, toIDLString
} from "@idlizer/core"

export class PrefixTransformer {
    constructor(
        private file: IDLFile
    ) {
        this.seen = new Map()
        file.entries.forEach(it => {
            this.seen.set(
                this.erasedPrefix(it.name),
                this.occurred(it.name) + 1
            )
        })
    }

    private seen: Map<string, number>

    private occurred(name: string): number {
        return this.seen.get(this.erasedPrefix(name)) ?? 0
    }

    transformed(): IDLFile {
        return new IDLFile(
            this.file.entries
                .map(it => {
                    if (isInterface(it)) {
                        return this.transformInterface(it)
                    }
                    return it
                })
                .filter(isDefined)
        )
    }

    private transformInterface(node: IDLInterface): IDLInterface | undefined {
        if (this.hasPrefix(node.name)) {
            if (this.occurred(node.name) === 1) {
                return createUpdatedInterface(
                    node,
                    undefined,
                    this.erasedPrefix(node.name),
                    undefined,
                    node.extendedAttributes
                        ?.concat({
                            name: `hadPrefix`,
                            value: `es2panda_`
                        })
                )
            }
            return undefined
        }
        return createUpdatedInterface(
            node,
            node.methods.map(it => this.transformMethod(it)),
        )
    }

    private transformMethod(node: IDLMethod): IDLMethod {
        return createUpdatedMethod(
            node,
            this.erasedPrefix(node.name),
            node.parameters.map(it => this.transformParameter(it)),
            this.transformType(node.returnType),
            node.extendedAttributes
                ?.concat(
                    this.hasPrefix(node.name)
                        ? { name: `hadPrefix`, value: `es2panda_` }
                        : []
                )
        )
    }

    private transformParameter(node: IDLParameter): IDLParameter {
        return createParameter(
            this.erasedPrefix(node.name),
            this.transformType(node.type),
            node.isOptional,
            node.isVariadic
        )
    }

    private transformType(node: IDLType): IDLType {
        if (isContainerType(node)) {
            if (isSequence(node)) {
                return createContainerType(
                    `sequence`,
                    [this.transformType(node.elementType[0])]
                )
            }
        }
        if (isReferenceType(node)) {
            return createReferenceType(
                this.erasedPrefix(node.name),
                node.typeArguments,
            )
        }
        return node
    }

    private erasedPrefix(name: string): string {
        if (name.startsWith(`es2panda_`)) {
            return name.slice(`es2panda_`.length)
        }
        return name
    }

    private hasPrefix(name: string): boolean {
        return name.startsWith(`es2panda_`)
    }

    private withAddedHadPrefix(attributes: IDLExtendedAttribute[]): IDLExtendedAttribute[] {
        return attributes
            .concat()
    }
}
