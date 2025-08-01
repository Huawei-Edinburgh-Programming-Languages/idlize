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

import * as idl from "@idlizer/core/idl"
import { createProducer, GeneratorContext, MakeSelectorPattern, MakeSelectorQuery, Producer, ProducerBox, ProducerDescription } from "../context"

export const MANAGED_PREFIX = 'managed'
export const C_API_PREFIX = 'capi'
export const NATIVE_PREFIX = 'native'

export const roles = {
    managed: MANAGED_PREFIX,
    cApi: C_API_PREFIX,
    native: NATIVE_PREFIX,
    nativeModule: "managed.nativeModule",
    serializerManaged: "managed.serializer",
    serializerNative: "native.serializer",
}

export function managedName(name:string) {
    return MANAGED_PREFIX + '.' + name
}
export function cApiName(name:string) {
    return C_API_PREFIX + '.' + name
}
export function nativeName(name:string) {
    return NATIVE_PREFIX + '.' + name
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

///////////////////////////////////////////////////////////

export class AdvancedGeneratorContext {

    constructor(
        public base: GeneratorContext
    ) { }

    useManaged(node:idl.IDLNode) {
        return this.base.use({ node, role: roles.managed })
    }
    useCApi(node:idl.IDLNode) {
        return this.base.use({ node, role: roles.cApi })
    }
    useManagedNativeModule(method:idl.IDLMethod) {
        return this.base.use({ node: method, role: roles.nativeModule })
    }
    useBridge(node:idl.IDLMethod) {
        return this.base.use({ node, role: roles.native })
    }

    useNativeSerializer(node:idl.IDLNode) {
        return this.base.use({ node, role: roles.serializerNative })
    }
    useManagedSerializer(node:idl.IDLNode) {
        return this.base.use({ node, role: roles.serializerManaged })
    }
}
export interface AdvancedProducer<N extends idl.IDLNode = idl.IDLNode> {
    (node: N, ctx: AdvancedGeneratorContext, query: MakeSelectorQuery): ProducerDescription
}
export function createSpecialProducer<N extends idl.IDLNode>(pattern: MakeSelectorPattern<N>, producer: AdvancedProducer<N>): ProducerBox<N> {
    return createProducer(pattern, (n, ctx, query) => {
        return producer(n, new AdvancedGeneratorContext(ctx), query)
    })
}

