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

import { Hs, D, E, Md, T, Ts } from "../../../ost";
import * as idl from "@idlizer/core/idl"
import { makePeerMethod } from "../components/peerMethod";
import { AdvancedGeneratorContext, createSpecialProducer, managedName, roles } from "../common";
import { getSuperType, isMaterialized } from "@idlizer/core";
import { mangleName, nativeModuleName, ProducerDescription } from "../../engine";
import { LWDeclaration } from "../../../ost/lws";
import { Builders } from "../../../ost/builders";
import { generateFunction } from "./function";

export const structureProducer = createSpecialProducer(
  { is: idl.isInterface, role: roles.managed },
  (node, ctx) => {
    if (node.subkind === idl.IDLInterfaceSubkind.Tuple)
      return makeTuple(node, ctx)
    const declName = managedName(idl.getFQName(node))
    const generator = isMaterialized(node, ctx.base.library)
      ? makeMaterialized
      : makeInterface
    return {
      artifact: {
        reference: T.cc(declName),
        implementationGenerator: () => {
          if (declName.startsWith('managed.idlize.'))///
            return []
          ctx.useCApi(node)
          return generator(node, declName, ctx)
        }
      }
    }
  }
)

function makeTuple(node: idl.IDLInterface, ctx: AdvancedGeneratorContext): ProducerDescription {
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

function makeInterface(node: idl.IDLInterface, name: string, ctx: AdvancedGeneratorContext): LWDeclaration[] {
  const superType = getSuperType(node, ctx.base.library)
  return [D.class(name,
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

function makeMaterialized(node: idl.IDLInterface, name: string, ctx: AdvancedGeneratorContext): LWDeclaration[] {
  const nativeModuleClassName = nativeModuleName();
  const peerType = Ts.union([T.cc('Finalizable'), T.cc('undefined')])
  const thisType = ctx.useManaged(node).reference();
  const nativeModule = E.v(nativeModuleClassName, [Hs.isType()])
  const intClass = Builders.class(name + 'Internal')
    .method('fromPtr').static()
      .returns(thisType)
      .param('ptr').type(Ts.prim.pointer).$().block()
        .return(thisType).ctor(name).args([E.v('ptr')]).$().$().$().$()
  const matClass = Builders.class(name).implements(T.cc('MaterializedBase'))
  const nativeModuleClass = Builders.class(nativeModuleClassName)

  // peer
  matClass
    .field('peer').type(peerType).$()
    .method('getPeer').returns(peerType).block()
      .return(peerType).access(E.v('this')).member('peer').$().$().$().$()
    .method('setPeer').param('peerPtr').type(Ts.prim.pointer).$().block()
      .binary('=')
        .left().access(E.v('this')).member('peer').$().$()
        .right().ctor('Finalizable')
          .arg('peerPtr').$()
          .arg().call().receiverExpr(E.v(name, [Hs.isType()])).functionName('getFinalizer').$().$().$().$().$().$().$()

  // getFinalizer
  const getFinalizer = 'getFinalizer';
  matClass.method(getFinalizer).static()
    .returns(Ts.prim.pointer).block()
      .return(Ts.prim.pointer).call().function().access(nativeModule).member(mangleName(name, getFinalizer)).$().$().$().$().$().$()
  nativeModuleClass.method(mangleName(name, getFinalizer))
    .native().static().annotation('ani.unsafe.Direct')
    .returns(Ts.prim.pointer).$()

  // constructors
  node.constructors.forEach(ctor => {
    matClass.ctor().parameters(ctor.parameters.map(it => ({ name: it.name, type: ctx.useManaged(it.type).reference() })))
      .block()
        .call().receiverName('this').functionName('setPeer').arg()
          .call().function().access(nativeModule).member(mangleName(name, 'construct')).$().$()
            .args(ctor.parameters.map(it => E.v(it.name))).$().$().$().$().$()
    nativeModuleClass.method(mangleName(name, 'construct'))
      .native().static().annotation('ani.unsafe.Direct')
      .parameters(ctor.parameters.map(it => ({ name: it.name, type: ctx.useManaged(it.type).reference() })))
      .returns(Ts.prim.pointer).$()
  })

  // methods
  const mc = matClass.$()///lame
  mc.methods.push(...node.methods.map(it => generateFunction(it, ctx)))
  return [intClass.$(), mc, nativeModuleClass.$()]
}
