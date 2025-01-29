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

import {
    createInterface,
    IDLContainerUtils,
    IDLEntry,
    IDLInterface,
    IDLMethod,
    IDLPrimitiveType,
    IDLReferenceType,
    IDLType,
    isEnum,
    isInterface,
    isPrimitiveType,
    isReferenceType
} from "@idlize/core"

export function isString(node: IDLType): node is IDLPrimitiveType {
    return isPrimitiveType(node) && node.name === "String"
}

export function isSequence(node: IDLType): boolean {
    return IDLContainerUtils.isSequence(node)
}

export function withUpdatedMethods(node: IDLInterface, methods: IDLMethod[]): IDLInterface {
    return createInterface(
        node.name,
        node.subkind,
        node.inheritance,
        node.constructors,
        node.constants,
        node.properties,
        methods,
        node.callables,
        node.typeParameters
    )
}

export class Typechecker {
    constructor(private idl: IDLEntry[]) {}

    private static incorrectDeclarations = new Set<string>()

    private findRealDeclaration(name: string): IDLEntry | undefined {
        const declarations = this.idl.filter(it => name === it.name)
        if (declarations.length === 1) {
            return declarations[0]
        }
        if (Typechecker.incorrectDeclarations.has(name)) {
            return undefined
        }
        Typechecker.incorrectDeclarations.add(name)
        console.warn(`Expected reference type "${name}" to have exactly one declaration, got: ${declarations.length}`)
        return undefined
    }

    isHeir(name: string, ancestor: string): boolean {
        if (name === ancestor) {
            return true
        }
        console.log(`looking for ancestor for ${name}`)
        const declaration = this.findRealDeclaration(name)
        if (declaration === undefined || !isInterface(declaration)) {
            console.log(`quiting: found no interface declaration for ${name}`)
            return false
        }
        const parent = declaration.inheritance[0]
        if (parent === undefined) {
            console.log(`quiting: ${declaration.name}, ${ancestor}`)
            return declaration.name === ancestor
        }
        console.log(`going recursive for: ${parent.name}`)
        return this.isHeir(parent.name, ancestor)
    }

    isEnumReference(type: IDLType): type is IDLReferenceType {
        if (!isReferenceType(type)) {
            return false
        }
        const declaration = this.findRealDeclaration(type.name)
        return declaration !== undefined && isEnum(declaration)
    }
}