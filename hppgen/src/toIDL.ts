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

import * as idl from "@idlizer/core/idl"
import { InterfaceNode, MethodNode, NodeKind } from "./toAST"

export function toIDLType(type:string): idl.IDLType {
    const unpacked = type.slice(1, type.length - 1)
    switch (unpacked) {
        case 'int': return idl.IDLI32Type
        case 'void *': return idl.IDLPointerType
    }

    // decay
    const pureName = unpacked
        .replaceAll('const ', '')
        .replaceAll(/[&*]/g, '')
        .trim()

    return idl.createReferenceType(pureName)
}
export function toIDLMethod(node:MethodNode): idl.IDLMethod {
    return idl.createMethod(
        node.name,
        node.parameters.map(param => {
            return idl.createParameter(
                param.name,
                toIDLType(param.type),
                false,
                false
            )
        }),
        toIDLType(node.returnType)
    )
}
export function toIDLInterface(node:InterfaceNode): idl.IDLInterface {
    return idl.createInterface(
        node.name,
        idl.IDLInterfaceSubkind.Interface,
        node.extends.map(toIDLType).map(x => x as idl.IDLReferenceType),
        [],
        [],
        [],
        node.members
            .filter(x => x.kind === NodeKind.Method)
            .map(x => x as MethodNode)
            .filter(x => !x.name.includes('operator='))
            .map(toIDLMethod)
    )
}
