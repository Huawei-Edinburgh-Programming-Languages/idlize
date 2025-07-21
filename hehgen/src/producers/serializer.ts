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
import { createProducer } from "../context"
import { An, D, DD, E, Md, S, T, Ts } from "lws";
import { ArgConvertor } from "./components/argConvertor";

function makeSerializerName(node:idl.IDLInterface) {
    return idl.getFQName(node) + 'Serializer'
}

export const serializerProducer = createProducer(
  { is: idl.isInterface, role: 'serializer' },
  (node, ctx) => {
    return {
      artifact: {
        reference: E.v(makeSerializerName(node), [An.isType()]),
        implementationGenerator: () => {
            const serializerName = 'serializer'
            const convertor = new ArgConvertor(ctx, E.v(serializerName))
            return D.class(makeSerializerName(node), [], [
                DD({ modifiers: [Md.static()] }).func('write', [
                    { name: serializerName, type: T.c('SerializerBase') },
                    { name: 'value', type: ctx.use({ node }).reference() },
                ], Ts.prim.void, S.block(
                    node.properties.map(prop => convertor.write(E.get(E.v('value'), prop.name), prop.type))
                )),
                DD({ modifiers: [Md.static()] }).func('read', [], Ts.prim.void, S.block([]))
            ])
        }
      }
    }
  }
)
