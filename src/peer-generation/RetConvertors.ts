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

import * as idl from "../idl"
import { LibraryInterface } from "../LibraryInterface"
import { ArgConvertor, BaseArgConvertor, CallbackConvertor, RuntimeType, ExpressionAssigneer } from "./ArgConvertors"
import { LanguageStatement, LanguageWriter } from "./LanguageWriters"
import { Language } from "../Language"


export interface RetConvertor {
    readonly nativeType: string
    readonly interopType: string
    readonly isVoid: boolean
}

class RegularRetConvertor implements RetConvertor {
    readonly interopType: string
    readonly throughOutArg = false
    get isVoid() { return this.nativeType === "void" }

    constructor(readonly nativeType: string, interopType?: string) {
        this.interopType = interopType ?? nativeType
    }
}

export function createVoidRetConvertor(): RetConvertor {
    return new RegularRetConvertor("void")
}

export function createRegularRetConvertor(nativeType: string, interopType?: string): RetConvertor {
    return new RegularRetConvertor(nativeType, interopType)
}

export function createRetConvertor(type: idl.IDLType|undefined, mapNativeRetType: (type: idl.IDLType) => string): RetConvertor {
    if (!type)
        return new RegularRetConvertor("void")
    return new RegularRetConvertor(mapNativeRetType(type!))
}