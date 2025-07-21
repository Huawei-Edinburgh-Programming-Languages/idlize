/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { TopLevelTypeConvertor } from "../TopLevelTypeConvertor"
import { Typechecker } from "../../../general/Typechecker"
import {
    IDLContainerType,
    IDLContainerUtils,
    IDLOptionalType,
    IDLReferenceType,
    IDLType,
    isInterface,
    isReferenceType,
    LanguageExpression,
    LanguageWriter, printType, throwException
} from "@idlizer/core"
import { PeersConstructions } from "../../../constuctions/PeersConstructions"
import { Config } from "../../../general/Config"
import { isDataClass, isReal } from "../../../general/common"

export class BindingReturnValueTypeConvertor extends TopLevelTypeConvertor<
    (writer: LanguageWriter, call: LanguageExpression) => LanguageExpression
> {
    constructor(
        typechecker: Typechecker
    ) {
        const plain = (type: IDLType) =>
            (writer: LanguageWriter, call: LanguageExpression) =>
                call
        const wrap = (wrapWith: string, ...args: string[]) =>
                (writer: LanguageWriter, call: LanguageExpression) =>
                    writer.makeFunctionCall(wrapWith, [call, ...args.map(arg => writer.makeString(arg))])

        super(typechecker, {
            sequence: (type: IDLContainerType) => {
                if (IDLContainerUtils.isSequence(type) && isReferenceType(type.elementType[0])) {
                    const elementType = this.typechecker.findRealDeclaration(type.elementType[0].name)
                    if (elementType && isInterface(elementType) && isDataClass(elementType)) {
                        return wrap(
                            'acceptNativeObjectArrayResult',
                            `(peer: KNativePointer) => new ${elementType.name}(peer)`
                        )
                    }
                }
                return wrap(PeersConstructions.arrayOfPointersToArrayOfPeers)
            },
            string: (type: IDLType) =>
                wrap(PeersConstructions.receiveString),
            reference: (type: IDLReferenceType) =>
                this.typechecker.isHeir(type.name, Config.astNodeCommonAncestor)
                    ? wrap(PeersConstructions.unpackNonNullable)
                    : wrap(type.name),
            optional: (type: IDLOptionalType) => {
                if (isReferenceType(type.type)) {
                    if (this.typechecker.isHeir(type.type.name, Config.astNodeCommonAncestor)) {
                        return wrap(PeersConstructions.unpackNullable)
                    }
                    return wrap(PeersConstructions.newOf(type.type.name))
                }
                throwException(`unexpected optional of non-reference type`)
            },
            enum: plain,
            number: plain,
            void: plain,
            pointer: plain,
            boolean: plain,
            undefined: plain
        })
    }
}
