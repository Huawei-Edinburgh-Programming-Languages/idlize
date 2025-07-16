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

import { D, E, lw, S, T, Ts } from "lws";
import { createProducer } from "../context"
import * as idl from "@idlizer/core/idl";
import { mkName } from "../library/utils";

const NATIVE_MODULE_NAME = 'NativeModule'

export const nativeModuleProducer = createProducer(
  { is: idl.isMethod, role: 'native' },
  node => {
    const methodName = idl.getFQName(node).split('.').join('_')
    return {
      artifact: {
        reference: E.v(mkName(NATIVE_MODULE_NAME, methodName)),
        implementationGenerator: () => {
          return D.class(NATIVE_MODULE_NAME, [], [
            D.func(methodName, [{ name: 'buffer', type: T.c('SerializerBase') }], Ts.prim.void, S.block([]))
          ])
        }
      }
    }
  }
)
