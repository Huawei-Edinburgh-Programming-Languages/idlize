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
        const serializerName = 'serializer'
        const convertor = new ArgConvertor(ctx, E.v(serializerName), isNative)
        return D.class(makeSerializerName(node, isNative), [], [
          DD({ modifiers: [Md.static()] }).func('write', [
            { name: serializerName, type: T.c('SerializerBase') },
            { name: 'value', type: ctx.useManaged(node).reference() },
          ], Ts.prim.void, S.block(
            node.properties.map(prop => convertor.write(E.get(E.v('value'), prop.name), prop.type))
          )),
          DD({ modifiers: [Md.static()] }).func('read', [], Ts.prim.void, S.block([]))
        ])
      }
    }
  }
}
