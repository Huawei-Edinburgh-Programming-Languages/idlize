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

import { D, lw, std, T, Ts } from "lws";
import { createProducer } from "../../context"
import * as idl from "@idlizer/core/idl";

export const containerProducer = createProducer(
  { is: idl.isContainerType },
  (node, ctx) => {
    return {
      recursive: () => {
        if (idl.IDLContainerUtils.isSequence(node)) {
          const elemRef = ctx.use({ node: node.elementType[0] }).reference()
          return {
            artifact: {
              reference: T.c('synthetic.mono.Array', elemRef),
            }
          }
        }
        if (idl.IDLContainerUtils.isRecord(node)) {
          const keyRef = ctx.use({ node: node.elementType[0] }).reference()
          const valRef = ctx.use({ node: node.elementType[1] }).reference()
          return {
            artifact: {
              reference: T.c('synthetic.mono.Map', keyRef, valRef)
            }
          }
        }
        throw new Error(`Unknown type "${idl.DebugUtils.debugPrintType(node)}"`)
      }
    }
  }
)
