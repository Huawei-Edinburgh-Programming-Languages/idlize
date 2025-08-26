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
import { AdvancedGeneratorContext, cApiName, createSpecialProducer, managedName, nativeName, roles } from "../common";
import { E, T } from "../../../ost/builder";
import { Builders } from "../../../ost/builders";
import { ArgConvertor } from "../components/argConvertor";
import { generatorConfiguration } from "@idlizer/core";
import { An, Op, Ts } from "../../../ost/stdlib";
import { LWType } from "../../../ost/lws";

export const functionProducer = createSpecialProducer(
  { is: idl.isMethod, role: roles.managed },
  (method, ctx) => {
    return {
      artifact: {
        reference: E.v(method.name),
        implementationGenerator: () => [
          generateFunction(method, ctx),
          generateGlobalScopeFunction(method, ctx),
          generateModifier(method, ctx),
          generateBridge(method, ctx),
          generateMacroCall(method, ctx),
        ]
      }
    }
  })

const GLOBAL_SCOPE_NAME = managedName('engine.GlobalScope')

function generateFunction(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
  const returnType = ctx.useManaged(method.returnType).reference()
  return Builders.function(managedName(idl.getFQName(method)))
    .parameters(method.parameters.map(it => ({ name: it.name, type: ctx.useManaged(it.type).reference() })))
    .returns(returnType)
    .block()
      .return(returnType)
        .call().receiverName(GLOBAL_SCOPE_NAME, [An.isType()]).functionName(method.name)
        .args(method.parameters.map(it => E.v(it.name))).$()
    .$().$().$()
}

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
            .value().call().receiverName('SerializerBase').functionName('hold').$().$().$()
          .statements(fieldWrites)
          .call().receiverName(nativeModuleName).functionName('_GlobalScope_' + method.name)
            .arg().call().receiverName(serializerName).functionName('asBuffer').$().$()
            .arg().call().receiverName(serializerName).functionName('length').$().$().$()
          .call().receiverName(serializerName).functionName('release').$().$()
        .$().$()
}

function generateModifier(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
  const returnType = ctx.useCApi(method.returnType).reference();
  const params: [string, LWType][] = method.parameters.map(it =>
    [it.name, Ts.const(Ts.ptr(ctx.useCApi(it.type).reference()))])
  return Builders.struct(cApiName('GlobalScopeModifier'))
    .field(method.name)
      .funcType().parameters(params).returns(returnType).$().$().$()
}

function generateBridge(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
  const convertor = new ArgConvertor(ctx, E.v('deserializer'), true)
  const returnType = ctx.useCApi(method.returnType).reference();
  const argReads = method.parameters.map(it =>
    Builders.stmt()
      .decl(it.name, ctx.useCApi(it.type).reference())
        .valueExpr(convertor.read(E.v(it.name), it.type)[1]).$().$())
  const modulePrefix = generatorConfiguration().moduleName.toUpperCase();
  return Builders.function(nativeName('impl_GlobalScope_' + method.name))
    .param('thisArray').type(Ts.prim.serializerBuffer).$()
    .param('thisLength').type(Ts.prim.i32).$()
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
                  .functionName(('Get' + generatorConfiguration().TypePrefix + modulePrefix + '_API'))
                  .arg(modulePrefix + '_API_VERSION').$().$().$()
              .member('GlobalScope')
              .ptr().$().$().$().$()
          .member(method.name)
          .ptr().$().$()
        .args(method.parameters.map(it => E.unary(Op.ref, E.v(it.name)))).$().$().$().$()
}

function generateMacroCall(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
  return Builders.stmt().call()
    .functionName('KOALA_INTEROP_DIRECT_V2')
    .args([
      E.v('GlobalScope_' + method.name),
      E.v(Ts.prim.serializerBuffer.name, [An.isType()]),
      E.v(Ts.prim.i32.name, [An.isType()])]).$()
    .$decl(nativeName('koala.interop.macro' + method.name))
}
