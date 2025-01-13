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

import { TypeConvertor } from "../peer-generation/LanguageWriters/nameConvertor"
import * as idl from "@idlize/core/idl"
import { throwException } from "../util"

export class NativeTypeConvertor implements TypeConvertor<string> {
    constructor(private library: PeerLibrary) {}

    convertOptional(type: IDLOptionalType): string {
        throw new Error("Method not implemented.")
    }
    convertUnion(type: IDLUnionType): string {
        throw new Error("Method not implemented.")
    }
    convertContainer(type: IDLContainerType): string {
        if (idl.IDLContainerUtils.isSequence(type)) return `KNativePointerArray`
        throwException(`Unexpected container`)
    }
    convertImport(type: IDLReferenceType, importClause: string): string {
        throw new Error("Method not implemented.")
    }
    convertTypeReference(type: IDLReferenceType): string {
        const declaration = this.library.resolveTypeReference(type)
        if (declaration !== undefined) console.warn(`WARNING: type reference with no declaration: ${type.name}`)
        if (declaration !== undefined && idl.isEnum(declaration)) {
            return `KInt`
        }
        return `KNativePointer`
    }
    convertTypeParameter(type: IDLTypeParameterType): string {
        throw new Error("Method not implemented.")
    }
    convertPrimitiveType(type: IDLPrimitiveType): string {
        switch (type) {
            case idl.IDLI32Type: return `KInt`
            case idl.IDLBooleanType: return `KBoolean`
            case idl.IDLStringType: return `KStringPtr&`
            case idl.IDLVoidType: return `KNativePointer`
        }
        throwException(`Unsupported primitive type: ${JSON.stringify(type)}`)
    }
}