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
import { AdvancedGeneratorContext, managedName, nativeName } from "../common";
import { ProducerDescription } from "../../context";
import { An, D, DD, E, Md, S, T, Ts } from "../../../ost/main";
import { ArgConvertor } from "./argConvertor";
import { Builders } from "../../../ost/builders";

function makeSerializerName(node:idl.IDLInterface, native:boolean) {
  const name = idl.getFQName(node) + 'Serializer'
    return native
      ? nativeName(name)
      : managedName(name)
}

export function makeSerializer(
  isNative: boolean,
  node: idl.IDLInterface,
  ctx: AdvancedGeneratorContext
): ProducerDescription {
  return {
    artifact: {
      reference: E.v(makeSerializerName(node, isNative), [An.isType()]),
      implementationGenerator: () => {
        const valueType = (isNative ? ctx.useCApi(node) : ctx.useManaged(node)).reference()
        const sconv = new ArgConvertor(ctx, E.v('serializer'), isNative)
        const dconv = new ArgConvertor(ctx, E.v('deserializer'), isNative)
        return [Builders.class(makeSerializerName(node, isNative))
          .method('write')
            .static()
            .param('serializer').type(Ts.ref(T.cc('SerializerBase'))).$()
            .param('value').type(valueType).$()
            .block().statements(node.properties.map(prop =>
              sconv.write(E.get(E.v('value'), prop.name), prop.type))).$().$()
          .method('read')
            .static()
            .param('deserializer').type(Ts.ref(T.cc('DeserializerBase'))).$()
            .returns(valueType)
            .block()
              .decl('value', valueType).valueStr('{}').$()
              .statements(node.properties.map(prop =>
                Builders.stmt()
                  .binary('=')
                    .left().access(E.v('value')).member(prop.name).$().$()
                    .rightExpr(dconv.read(E.v(prop.name), prop.type)[1]).$().$()))
              .return(valueType).valueStr('value').$().$().$().$()
        ]
      }
    }
  }
}
