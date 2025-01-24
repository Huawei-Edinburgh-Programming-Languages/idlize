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


import { IDLContainerUtils, IDLPrimitiveType, IDLType, isPrimitiveType } from "@idlize/core"

export function isString(node: IDLType): node is IDLPrimitiveType {
    return isPrimitiveType(node) && node.name === "String"
}

export function isSequence(node: IDLType): boolean {
    return IDLContainerUtils.isSequence(node)
}
