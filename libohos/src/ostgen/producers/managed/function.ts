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
import { AdvancedGeneratorContext, createSpecialProducer, managedName, roles } from "../common";
import { E, T } from "../../../ost/builder";
import { Builders } from "../../../ost/builders";
import { ArgConvertor } from "../components/argConvertor";
import { generatorConfiguration } from "@idlizer/core";
import { An } from "../../../ost/stdlib";

export const functionProducer = createSpecialProducer(
  { is: idl.isMethod, role: roles.managed },
  (method, ctx) => {
    return {
      artifact: {
        reference: E.v(method.name),
        implementationGenerator: () => [
          generateFunction(method, ctx),
          generateGlobalScopeFunction(method, ctx),
        ]
      }
    }
  })

function generateFunction(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
  const returnType = ctx.useManaged(method.returnType).reference()
  return Builders.function(managedName(idl.getFQName(method)))
    .parameters(method.parameters.map(it => ({ name: it.name, type: ctx.useManaged(it.type).reference() })))
    .returns(returnType)
    .block()
      .return(returnType)
        .call().objectName(GLOBAL_SCOPE_NAME, [An.isType()]).function(method.name)
        .args(method.parameters.map(it => E.v(it.name))).$()
    .$().$().$()
}

const GLOBAL_SCOPE_NAME = managedName('engine.GlobalScope')

function generateGlobalScopeFunction(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
    ctx.useManagedNativeModule(method)
    const serializerName = 'thisSerializer'
    const convertor = new ArgConvertor(ctx, E.v(serializerName), false)
    const fieldWrites = method.parameters.map(param => convertor.write(E.v(param.name), param.type))
    const returnType = ctx.useManaged(method.returnType).reference();
    const params = method.parameters.map(it => ({ name: it.name, type: ctx.useManaged(it.type).reference() }));
    const nativeModuleName = generatorConfiguration().moduleName.toUpperCase() + 'NativeModule'
    return Builders.class(GLOBAL_SCOPE_NAME)
      .method(method.name)
        .static()
        .parameters(params)
        .returns(returnType)
        .block()
          .decl(serializerName, T.c('SerializerBase'))
            .value().call().objectName("SerializerBase").function("hold").$().$().$()
          .statements(fieldWrites)
          .call().objectName(nativeModuleName).function('_GlobalScope_' + method.name)
            .arg().call().objectName(serializerName).function('asBuffer').$().$()
            .arg().call().objectName(serializerName).function('length').$().$().$()
          .call().objectName(serializerName).function('release').$().$()
        .$().$()
}
