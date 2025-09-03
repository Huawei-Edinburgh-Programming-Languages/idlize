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
import { cApiName, createSpecialProducer, roles } from "../common";
import { E } from "../../../ost/builder";
import { Builders } from "../../../ost/builders";
import { fqName, modifierClassName } from "../../engine";
import { Ts } from "../../../ost/stdlib";
import { LWType } from "../../../ost/lws";

export const functionProducer = createSpecialProducer(
  { is: idl.isMethod, role: roles.cApi },
  (method, ctx) => {
    const funcName = fqName(method);
    return {
      artifact: {
        reference: E.v(funcName),
        implementationGenerator: () => {
          const returnType = ctx.useCApi(method.returnType).reference()
          const params: [string, LWType][] = method.parameters.map(it =>
            [it.name, Ts.const(Ts.ptr(ctx.useCApi(it.type).reference()))])
          if (!method.isFree)
            params.unshift(['thisPtr', Ts.prim.pointer])
          return [
            Builders.struct(cApiName(`modifier.${modifierClassName(method)}Modifier`))
              .field(funcName)
                .funcType()
                .parameters(params)
                .returns(returnType).$().$().$(),
          ]
        }
      }
    }
  }
)
