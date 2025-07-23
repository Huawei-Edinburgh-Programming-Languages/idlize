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
import { createProducer } from "../../context";
import * as idl from "@idlizer/core/idl"
import { makePeerMethod } from "./components/peerMethod";

export const structureProducer = createProducer(
  { is: idl.isInterface },
  (node, ctx) => {
    return {
      artifact: {
        reference: T.cc(idl.getFQName(node)),
        implementationGenerator: () => {
          if (node.methods.length > 0) {
            return D.class(idl.getFQName(node),
              node.properties.map(prop => {
                return {
                  name: prop.name,
                  type: ctx.use({ node: prop.type}).reference()
                }
              }),
              node.methods.map(method => {
                return makePeerMethod(method, ctx)
              })
            )
          }
          return D.struct(idl.getFQName(node), node.properties.map(prop => {
            return {
              name: prop.name,
              type: ctx.use({ node: prop.type}).reference()
            }
          }))
        },
      }
    }
  }
)
