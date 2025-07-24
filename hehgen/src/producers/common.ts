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

import { IdentityTransformer, lw } from "lws"

const MANAGED_PREFIX = 'managed.'
const C_API_PREFIX = 'capi.'
const NATIVE_PREFIX = 'native.'

export function managedName(name:string) {
    return MANAGED_PREFIX + name
}
export function cApiName(name:string) {
    return C_API_PREFIX + name
}
export function nativeName(name:string) {
    return NATIVE_PREFIX + name
}

function is(prefix:string, name:string) {
    return name.startsWith(prefix)
}
export function isManaged(name:string) {
    return is(MANAGED_PREFIX, name)
}
export function isCApi(name:string) {
    return is(C_API_PREFIX, name)
}
export function isNative(name:string) {
    return is(NATIVE_PREFIX, name)
}

export function dropBucketName(decl:lw.LWDeclaration): lw.LWDeclaration {
    const clone = new IdentityTransformer().goDeclaration(decl)
    clone.name = decl.name.split('.').slice(1).join('.')
    return clone
}
