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

import { D, S, T } from "lws";
import { createProducer } from "../context";
import * as idl from "@idlizer/core/idl"

export const structureProducer = createProducer(
  idl.isInterface,
  (node, ctx) => {
    return {
      artifact: {
        reference: T.cc(idl.getFQName(node)),
        implementationGenerator: () => {
          if (node.methods.length > 0) {
            return D.class(node.name,
              node.properties.map(prop => {
                return {
                  name: prop.name,
                  type: ctx.use(prop.type).reference()
                }
              }),
              node.methods.map(method => {
                return D.func(method.name,
                  method.parameters.map(param => ({ name: param.name, type: ctx.use(param.type).reference() })),
                  ctx.use(method.returnType).reference(),
                  S.block([])
                )
              })
            )
          }
          return D.struct(node.name, node.properties.map(prop => {
            return {
              name: prop.name,
              type: ctx.use(prop.type).reference()
            }
          }))
        },
      }
    }
  }
)
