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

export abstract class PrimitiveType {
    constructor(protected name: string, protected isPointer: boolean = false) {
    }

    abstract getText(): string

    toString(): string { return this.getText() }
}


export abstract class PrimitiveTypes {
    public static get UndefinedTag() {
        return "INTEROP_TAG_UNDEFINED"
    }

    public static get UndefinedRuntime() {
        return "INTEROP_RUNTIME_UNDEFINED"
    }

    public static get ObjectTag() {
        return "INTEROP_TAG_OBJECT"
    }

    abstract String: PrimitiveType
    abstract Number: PrimitiveType
    abstract Int32: PrimitiveType
    abstract Int64: PrimitiveType
    abstract Date: PrimitiveType
    abstract RuntimeType: PrimitiveType
    abstract Boolean: PrimitiveType
    abstract Function: PrimitiveType
    abstract Undefined: PrimitiveType
    abstract Void: PrimitiveType
    abstract NativePointer: PrimitiveType
    abstract Tag: PrimitiveType
    abstract CustomObject: PrimitiveType
}