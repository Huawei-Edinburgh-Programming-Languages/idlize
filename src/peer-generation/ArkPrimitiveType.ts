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

import { PrimitiveType, PrimitiveTypes } from "@idlize/core"

export class ArkPrimitiveTypes extends PrimitiveTypes {
    readonly String: PrimitiveType = new ArkPrimitiveType(`String`, true)
    readonly Number = new ArkPrimitiveType(`Number`, true)
    readonly Int32 = new ArkPrimitiveType(`Int32`)
    readonly Int64 = new ArkPrimitiveType(`Int64`)
    readonly Date = new ArkPrimitiveType(`Date`)
    readonly RuntimeType = new ArkPrimitiveType(`RuntimeType`)
    readonly Boolean = new ArkPrimitiveType(`Boolean`)
    readonly Function = new ArkPrimitiveType(`Function`, false)
    readonly Undefined = new ArkPrimitiveType(`Undefined`)
    readonly Void = new ArkPrimitiveType(`Void`)
    readonly NativePointer = new ArkPrimitiveType(`NativePointer`)
    readonly Tag = new ArkPrimitiveType(`Tag`)
    readonly Materialized = new ArkPrimitiveType(`Materialized`, true)
    readonly ObjectHandle = new ArkPrimitiveType(`ObjectHandle`)
    readonly Length = new ArkPrimitiveType(`Length`, true)
    readonly CustomObject = new ArkPrimitiveType(`CustomObject`, true)
}

export class ArkPrimitiveType extends PrimitiveType {
    static Prefix = "Ark_"
    static LibraryPrefix = ""
    static OptionalPrefix = "Opt_"

    getText(): string {
        return ArkPrimitiveType.Prefix + this.name
    }

    static readonly Instance = new ArkPrimitiveTypes()
}