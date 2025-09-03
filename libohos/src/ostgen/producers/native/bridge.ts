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
import { AdvancedGeneratorContext, createSpecialProducer, bridgeName, roles, implName } from "../common";
import { E, T } from "../../../ost/builder";
import { Builders } from "../../../ost/builders";
import { ArgConvertor } from "../components/argConvertor";
import { generatorConfiguration } from "@idlizer/core";
import { Op, Ts } from "../../../ost/stdlib";
import { fqName, modifierClassName, moduleName } from "../../engine";
import { LWExpression, VariableExpression } from "../../../ost/lws";

export const bridgeProducer = createSpecialProducer(
  { is: idl.isMethod, role: roles.bridge },
  (method, ctx) => {
    const declName = bridgeName(fqName(method))
    return {
      artifact: {
        reference: E.v(declName),
        implementationGenerator: () => [
          generateBridge(method, ctx),
          generateImpl(method, ctx)
        ]
      }
    }
  })

function generateBridge(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
  const funcName = (ctx.useCApi(method).name() as VariableExpression).name
  const returnType = ctx.useCApi(method.returnType).reference();
  const params = [
    { name: 'thisArray', type: Ts.prim.serializerBuffer },
    { name: 'thisLength', type: Ts.prim.i32 },
  ]
  const convertor = new ArgConvertor(ctx, E.v('deserializer'), true)
  const argReads = method.parameters.map(it =>
    Builders
      .decl(it.name, ctx.useCApi(it.type).reference())
        .valueExpr(convertor.read(E.v(it.name), it.type)[1]).$())
  const callArgs: LWExpression[] = method.parameters.map(it => E.unary(Op.ref, E.v(it.name)));
  const macroParams = [funcName]
  let v = ''
  switch (method.returnType) {
    case idl.IDLVoidType: v = 'V'; break
    case idl.IDLNumberType: macroParams.push('KInteropNumber'); break
    case idl.IDLStringType: macroParams.push('KStringPtr'); break
  }
  if (!method.isFree) {
    params.unshift({ name: 'thisPtr', type: Ts.prim.pointer })
    callArgs.unshift(E.v('thisPtr'))
    macroParams.push('OH_NativePointer')
  }
  return Builders.func(bridgeName(fqName(method, 'modifier.impl_')))
    .parameters(params)
    .returns(returnType)
    .block()
      .decl('deserializer', T.c('DeserializerBase')).value()
        .ctor('DeserializerBase').stack().args([E.v('thisArray'), E.v('thisLength')]).$().$().$()
      .statements(argReads)
      .return(returnType)
        .call().function().access()
          .object()
            .call().function().access()
              .object()
                .call()
                  .functionName(('Get' + generatorConfiguration().TypePrefix + moduleName('_API')))
                  .arg(moduleName('_API_VERSION')).$().$().$()
              .member(modifierClassName(method))
              .ptr().$().$().$().$()
          .member(funcName)
          .ptr().$().$()
        .args(callArgs).$().$().$()
    .macro(`KOALA_INTEROP_DIRECT_${v}${macroParams.length}`,
      ...macroParams, Ts.prim.serializerBuffer, Ts.prim.i32)
    .$()
}

function generateImpl(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
  const returnType = ctx.useCApi(method.returnType).reference();
  const params = method.parameters.map(it => ({
    name: it.name,
    type: Ts.const(Ts.ptr(ctx.useCApi(it.type).reference()))
  }))
  if (!method.isFree)
    params.unshift({ name: 'thisPtr', type: Ts.prim.pointer })
  return Builders.func(implName(fqName(method, 'modifier.', 'Impl')))
    .returns(returnType)
    .parameters(params).$()
}
