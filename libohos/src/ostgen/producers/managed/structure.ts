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

import { D, Md, T, Ts } from "../../../ost";
import * as idl from "@idlizer/core/idl"
import { makePeerMethod } from "../components/peerMethod";
import { createSpecialProducer, managedName, roles } from "../common";
import { getSuperType, isMaterialized } from "@idlizer/core";

export const structureProducer = createSpecialProducer(
  { is: idl.isInterface, role: roles.managed },
  (node, ctx) => {
    if (node.subkind === idl.IDLInterfaceSubkind.Tuple) {
      return {
        recursive: () => {///native
          return {
            artifact: {
              reference: Ts.intersection(
                node.properties.map(prop => ctx.useManaged(prop.type).reference()))
            }
          }
        }
      }
    }

    const generatedDeclName = managedName(idl.getFQName(node))

    const implementationGenerator = isMaterialized(node, ctx.base.resolver.R)
      ? undefined
      : () => {
        ctx.useCApi(node)
        const superType = getSuperType(node, ctx.base.resolver.R)
        return [D.class(generatedDeclName,
          node.properties.map(prop => {
            const modifiers = [
              ...prop.isOptional ? [Md.optional()] : [],
              ...prop.isReadonly ? [Md.readonly()] : [],
              ...prop.isStatic ? [Md.static()] : [],
            ]
            return {
              name: prop.name,
              type: ctx.useManaged(prop.type).reference(),
              modifiers,
            }
          }),
          node.methods.map(method => makePeerMethod(method, ctx)), {
          kind: idl.isClassSubkind(node) ? 'class' : 'interface',
          base: superType ? ctx.useManaged(superType).reference() : undefined
          })]
      }
    return {
      artifact: {
        reference: T.cc(generatedDeclName),
        implementationGenerator
      }
    }
  }
)
