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

import { D, Md, T, Ts } from "../../../ost"
import * as idl from "@idlizer/core/idl"
import { AdvancedGeneratorContext, cApiName, createSpecialProducer, roles } from "../common"
import { LWDeclaration } from "../../../ost/lws"
import { isMaterialized } from "@idlizer/core"

export const structureProducer = createSpecialProducer(
  { is: idl.isInterface, role: roles.cApi },
  (node, ctx) => {
    const name = cApiName(idl.getFQName(node))
    return {
      artifact: {
        reference: T.cc(name),
        implementationGenerator: () => [
          isMaterialized(node, ctx.base.library)
            ? makeMaterialized(name)
            : makeInterface(node, name, ctx)]
      }
    }
  }
)

function makeInterface(node: idl.IDLInterface, name: string, ctx: AdvancedGeneratorContext): LWDeclaration {
  return D.struct(name, node.properties.map(prop => {
    const modifiers = [
      ...prop.isOptional ? [Md.optional()] : [],
      ...prop.isReadonly ? [Md.readonly()] : [],
      ...prop.isStatic ? [Md.static()] : [],
    ]
    return {
      name: prop.name,
      type: ctx.useCApi(prop.type).reference(),
      modifiers,
    }
  }))
}

function makeMaterialized(name: string): LWDeclaration {
  return D.type(name, Ts.ptr(Ts.prim.void))
}
