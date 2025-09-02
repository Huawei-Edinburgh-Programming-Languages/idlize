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
import { AdvancedGeneratorContext, cApiName, createSpecialProducer, managedName, bridgeName, roles, implName } from "../common";
import { E, S, T } from "../../../ost/builder";
import { Builders } from "../../../ost/builders";
import { ArgConvertor } from "../components/argConvertor";
import { generatorConfiguration } from "@idlizer/core";
import { Hs, Op, Ts } from "../../../ost/stdlib";
import { LWType } from "../../../ost/lws";
import { fqName, moduleName, nativeModuleName } from "../../engine";

export const functionProducer = createSpecialProducer(
  { is: idl.isMethod, role: roles.managed },
  (method, ctx) => {
    return {
      artifact: {
        reference: E.v(method.name),
        implementationGenerator: () => [
          generateFunction(method, ctx),
          generateGlobalScopeFunction(method, ctx),
          ...generateModifiers(method, ctx),
          generateBridge(method, ctx),
        ]
      }
    }
  })

const GLOBAL_SCOPE_NAME = managedName('engine.GlobalScope')

function generateFunction(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
  const returnType = ctx.useManaged(method.returnType).reference()
  return Builders.func(managedName(idl.getFQName(method)))
    .parameters(method.parameters.map(it => ({ name: it.name, type: ctx.useManaged(it.type).reference() })))
    .returns(returnType)
    .block()
      .return(returnType)
        .call().receiverName(GLOBAL_SCOPE_NAME, [Hs.isType()]).functionName(fqName(method))
        .args(method.parameters.map(it => E.v(it.name))).$()
    .$().$().$()
}

function generateGlobalScopeFunction(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
    ctx.useManagedNativeModule(method)
    const serializerName = 'thisSerializer'
    const returnType = ctx.useManaged(method.returnType).reference();
    const params = method.parameters.map(it => ({ name: it.name, type: ctx.useManaged(it.type).reference() }));
    const convertor = new ArgConvertor(ctx, E.v(serializerName), false)
    const fieldWrites = method.parameters.map(param => convertor.write(E.v(param.name), param.type))
    const nativeModuleCall = Builders.call()
      .receiverExpr(E.v(nativeModuleName(), [Hs.isType()]))
      .functionName(fqName(method, '_'))
      .arg().call().receiverName(serializerName).functionName('asBuffer').$().$()
      .arg().call().receiverName(serializerName).functionName('length').$().$().$()
    const releaseCall = Builders.stmt().call().receiverName(serializerName).functionName('release').$().$()
    const statements = [
      Builders.decl(serializerName, T.c('SerializerBase'))
        .value().call().receiverName('SerializerBase').functionName('hold').$().$().$(),
      ...fieldWrites]
    if (method.returnType !== idl.IDLVoidType) {
      statements.push(
        Builders.decl('result', returnType).valueExpr(nativeModuleCall).$(),
        releaseCall,
        Builders.return(returnType).valueStr('result').$())
    } else {
      statements.push(S.e(nativeModuleCall), releaseCall)
    }
    return Builders.class(GLOBAL_SCOPE_NAME)
      .method(fqName(method)).static()
        .parameters(params)
        .returns(returnType)
        .block().statements(statements).$().$().$()
}

function generateModifiers(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
  const returnType = ctx.useCApi(method.returnType).reference();
  const params: [string, LWType][] = method.parameters.map(it =>
    [it.name, Ts.ptr(ctx.useCApi(it.type).reference())])
  return [
    // C API modifier function
    Builders.struct(cApiName('modifier.GlobalScopeModifier'))
      .field(fqName(method))
        .funcType().parameters(params).returns(returnType).$().$().$(),
    // implementation declaration
    Builders.func(implName(fqName(method, 'modifier.', 'Impl')))
      .parameters(params.map(([name, type]) => ({ name, type })))
      .returns(returnType).$()
  ]
}

function generateBridge(method: idl.IDLMethod, ctx: AdvancedGeneratorContext) {
  const returnType = ctx.useCApi(method.returnType).reference();
  const convertor = new ArgConvertor(ctx, E.v('deserializer'), true)
  const argReads = method.parameters.map(it =>
    Builders
      .decl(it.name, ctx.useCApi(it.type).reference())
        .valueExpr(convertor.read(E.v(it.name), it.type)[1]).$())
  const macroParams = [fqName(method)]
  let v = 'V'
  if (method.returnType !== idl.IDLVoidType) {
    v = ''
    macroParams.push('KInteropNumber')///
  }
  return Builders.func(bridgeName(fqName(method, 'modifier.impl_')))
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
                  .functionName(('Get' + generatorConfiguration().TypePrefix + moduleName('_API')))
                  .arg(moduleName('_API_VERSION')).$().$().$()
              .member('GlobalScope')
              .ptr().$().$().$().$()
          .member(fqName(method))
          .ptr().$().$()
        .args(method.parameters.map(it => E.unary(Op.ref, E.v(it.name)))).$().$().$()
    .macro(`KOALA_INTEROP_DIRECT_${v}2`, ...macroParams, Ts.prim.serializerBuffer, Ts.prim.i32)
    .$()
}
