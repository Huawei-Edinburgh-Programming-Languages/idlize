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

import { An, D, E, S, T, Ts } from "../../../ost";
import { createProducer } from "../../engine/context"
import * as idl from "@idlizer/core/idl";
import { managedName, roles } from "../common";

const NATIVE_MODULE_NAME = managedName('engine.NativeModule')

export const nativeModuleProducer = createProducer(
  { is: idl.isMethod, role: roles.nativeModule },
  method => {
    const methodName = idl.getFQName(method).split('.').join('_')
    return {
      artifact: {
        reference: E.get(E.v(NATIVE_MODULE_NAME, [An.isType()]), methodName),
        implementationGenerator: () =>
          [D.class(NATIVE_MODULE_NAME, [], [
            D.func(methodName, [{ name: 'buffer', type: T.c('SerializerBase') }], Ts.prim.void, S.block([]))
          ])]
      }
    }
  }
)
