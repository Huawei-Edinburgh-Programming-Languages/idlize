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

import { lw, Ts } from "lws";
import { createProducer } from "../context"
import * as idl from "@idlizer/core/idl";

function selectType(type:idl.IDLPrimitiveType): lw.LWType {
    switch (type) {
        case idl.IDLI32Type: return Ts.prim.int
        case idl.IDLStringType: return Ts.prim.str
        case idl.IDLVoidType: return Ts.prim.void
    }
    throw new Error(`Can not map ${idl.DebugUtils.debugPrintType(type)}`)
}

export const primitiveProducer = createProducer(
  idl.isPrimitiveType,
  node => {
    return {
      artifact: {
        reference: selectType(node),
      }
    }
  }
)
