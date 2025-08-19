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
import { createSpecialProducer, managedName, roles } from "../common";
import { E, T } from "../../../ost/builder";
import { Builders } from "../../../ost/builders";
import { ArgConvertor } from "../components/argConvertor";

export const functionProducer = createSpecialProducer(
  { is: idl.isMethod, role: roles.managed },
  (method, ctx) => {
    return {
      artifact: {
        reference: T.cc("///MANAGED_METHOD_FALLBACK"),
        implementationGenerator: () => {
          ctx.useManagedNativeModule(method)///not here, in GS
          const returnType = ctx.useManaged(method.returnType).reference()
          return Builders.function()
            .name(managedName(idl.getFQName(method)))
            .parameters(method.parameters.map(it => ({ name: it.name, type: ctx.useManaged(it.type).reference() })))
            .returns(returnType)
            .block()
              .return(returnType)
                .call().objectName("GlobalScope").function(method.name)
                .arguments(method.parameters.map(it => E.v(it.name))).$()
            .$().$().$()
        }
      }
    }
  })

// const GLOBAL_SCOPE_NAME = managedName('engine.GlobalScope')

// export const globalScopeProducer = createSpecialProducer(
//   { is: idl.isMethod, role: roles.globalScope },
//   (method, ctx) => {
//     const serializerName = 'thisSerializer'
//     const convertor = new ArgConvertor(ctx, E.v(serializerName), true)
//     const stmts = method.parameters.map(param => convertor.write(E.v(param.name), param.type))
//     const returnType = ctx.useManaged(method.returnType).reference();
//     const params = method.parameters.map(it => ({ name: it.name, type: ctx.useManaged(it.type).reference() }));
//     return {
//       artifact: {
//         reference: E.get(E.v(GLOBAL_SCOPE_NAME), method.name),
//         implementationGenerator: () =>
//           Builders.class()
//             .name(GLOBAL_SCOPE_NAME)
//             .method()
//               .static()
//               .name(method.name)
//               .parameters(params)
//               .returns(returnType)
//               .block()
//                 .return(returnType)
//                   .call().object("GlobalScope").function(method.name + '_serialize')
//                   .args(method.parameters.map(it => E.v(it.name))).$()
//               .$().$().$()
//             .method()
//               .static()
//               .name(method.name + '_serialize')
//               .parameters(params)
//               .returns(returnType)
//               .block()
//                 .return(returnType)
//                   .call().object('NativeModule').function('_GlobalScope_' + method.name)
//                   .args(method.parameters.map(it => E.v(it.name))).$()
//               .$().$().$().$()
//       }
//     }
//   })
