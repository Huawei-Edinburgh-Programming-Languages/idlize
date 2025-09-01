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
import { AdvancedGeneratorContext, managedName, bridgeName } from "../common";
import { ProducerDescription } from "../../engine/context";
import { Hs, E, T, Ts } from "../../../ost";
import { ArgConvertor, materializedToPtr, ptrToMaterialized } from "./argConvertor";
import { Builders } from "../../../ost/builders";
import { LWType } from "../../../ost/lws";
import { isMaterialized } from "@idlizer/core";

function makeSerializerName(node: idl.IDLInterface, native: boolean) {
  const name = idl.getFQName(node) + 'Serializer'
    return native
      ? bridgeName(name)
      : managedName(name)
}

/**
 * For TS, produce serializer class with method implementations.
 * Native needs forward class declaration + separate method implementations.
 */
export function makeSerializer(
  native: boolean,
  node: idl.IDLInterface,
  ctx: AdvancedGeneratorContext
): ProducerDescription {
  return {
    artifact: {
      reference: E.v(makeSerializerName(node, native), [Hs.isType()]),
      implementationGenerator: () => {
        const valueType = (native ? ctx.useCApi(node) : ctx.useManaged(node)).reference()
        const clazz = makeSerializerClass(native, node, valueType)
        const write = makeSerializerWrite(native, node, valueType, ctx)
        const read = makeSerializerRead(native, node, valueType, ctx)
        if (native) {
          return [clazz, write, read]
        } else {
          clazz.methods[0].body = write.body
          clazz.methods[1].body = read.body
          return [clazz]
        }
      }
    }
  }
}

function makeSerializerClass(native: boolean, node: idl.IDLInterface, type: LWType) {
  return Builders.class(makeSerializerName(node, native))
    .method('write')
      .static()
      .param('serializer').type(Ts.ref(T.cc('SerializerBase'))).$()
      .param('value').type(type).$().$()
    .method('read')
      .static()
      .param('deserializer').type(Ts.ref(T.cc('DeserializerBase'))).$()
      .returns(type).$().$()
}

function makeSerializerWrite(native: boolean, node: idl.IDLInterface, type: LWType, ctx: AdvancedGeneratorContext) {
  const block = Builders.func(makeSerializerName(node, native) + '::write')
    .param('serializer').type(Ts.ref(T.cc('SerializerBase'))).$()
    .param('value').type(type).$()
    .block()
  if (isMaterialized(node, ctx.base.resolver.R)) {
    return block.call().receiverName('serializer').functionName('writePointer')
      .args([materializedToPtr('value', native)]).$().$().$()
  } else {
    const conv = new ArgConvertor(ctx, E.v('serializer'), native)
    return block.statements(node.properties.map(prop =>
      conv.write(E.get(E.v('value'), prop.name), prop.type))).$().$()
  }
}

function makeSerializerRead(native: boolean, node: idl.IDLInterface, type: LWType, ctx: AdvancedGeneratorContext) {
  const block = Builders.func(makeSerializerName(node, native) + '::read')
    .param('deserializer').type(Ts.ref(T.cc('DeserializerBase'))).$()
    .returns(type)
    .block()
  if (isMaterialized(node, ctx.base.resolver.R)) {
    return block
      .decl('ptr', Ts.prim.pointer).value()
        .call().receiverName('deserializer').functionName('readPointer').$().$().$()
      .return(type).valueExpr(ptrToMaterialized('ptr', type, native)).$().$().$()
  } else {
    const conv = new ArgConvertor(ctx, E.v('deserializer'), native)
    return block
      .decl('value', type).valueStr('{}').$()
      .statements(node.properties.map(prop =>
        Builders.stmt().binary('=')
          .left().access(E.v('value')).member(prop.name).$().$()
          .rightExpr(conv.read(E.v(prop.name), prop.type)[1]).$().$()))
      .return(type).valueStr('value').$().$().$()
  }
}
