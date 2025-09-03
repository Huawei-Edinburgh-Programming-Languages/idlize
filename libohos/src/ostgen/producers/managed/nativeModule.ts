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

import * as idl from "@idlizer/core/idl";
import { Hs, E, Ts } from "../../../ost";
import { createSpecialProducer, roles } from "../common";
import { fqName, nativeModuleName } from "../../engine";
import { Builders } from "../../../ost/builders";

export const nativeModuleProducer = createSpecialProducer(
  { is: idl.isMethod, role: roles.nativeModule },
  (method, ctx) => {
    const methodName = fqName(method, '_')
    const className = nativeModuleName();
    return {
      artifact: {
        reference: E.get(E.v(className, [Hs.isType()]), methodName),
        implementationGenerator: () => {
          ctx.useBridge(method)
          const nativeModule = Builders.class(className)
            .method(methodName)
              .native().static().annotation('ani.unsafe.Direct')
              .param('buffer').type(Ts.prim.serializerBuffer).$()
              .param('length').type(Ts.prim.i32).$()
              .returns(ctx.useManaged(method.returnType).reference()).$().$()
          if (!method.isFree)
            nativeModule.methods[0].parameters.unshift(
              { name: 'ptr', type: Ts.prim.pointer })
          return [nativeModule]
        }
      }
    }
  }
)
