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

import { IndentedPrinter } from "../IndentedPrinter"
import * as common from "./common"
import {
    IDLEntry,
    IDLInterface,
    IDLKind,
    IDLMethod,
    IDLParameter,
    IDLPrimitiveType,
    IDLReferenceType,
    IDLType,
    isInterface,
    isMethod,
    isPrimitiveType,
    isReferenceType,
} from "../idl"
import * as webidl2 from "webidl2"
import { toIDLNode } from "../from-idl/deserialize"

export class NativeModulePrinter extends IndentedPrinter {
    constructor() {
        super()
    }

    visit(node: IDLEntry) {
        if (!isInterface(node)) {
            throw new Error(`Unexpected node kind: ${IDLKind[node.kind]}`)
        }
        this.printInterface(node)
    }

    printInterface(node: IDLInterface) {
        this.print(`import { KNativePointer, KInt, KBoolean, KUShort, KUInt, KLong, KDouble, KFloat, KStringArray } from "@koalaui/interop"`)
        this.print(``)
        this.print(`export interface NativeModule {`)
        this.pushIndent()
        node.methods.map(it => this.printMethod(it))
        this.popIndent()
        this.print(`}`)
        this.print(``)
    }

    printMethod(node: IDLMethod) {
        if (!common.isValidType(node.returnType)) {
            throw new Error(`Type of param expected to be reference: ${node.returnType.kind}`)
        }
        this.print(`_${node.name}(${node.parameters.map((param: IDLParameter) => this.printParam(param)).join(', ')}): ${NativeModulePrinter.printTypeForTS(node.returnType)}`)
    }

    printParam(param: IDLParameter): string {
        if (!common.isValidType(param.type)) {
            throw new Error(`Type of param expected to be reference: ${param.type?.kind}`)
        }
        return `_${param.name}: ${NativeModulePrinter.printTypeForTS(param.type)}`
    }

    private static printTypeForTS(type: IDLReferenceType | IDLPrimitiveType): string {
        const irType = common.getIrType(type)
        switch (irType) {
            case '_*': return 'KNativePointer'
            case '_**': return 'BigUint64Array'
            case '_***': return 'KNativePointer' // TODO: unsupported

            case 'bool': return 'KBoolean'
            case 'bool*': return 'KNativePointer'
            case 'int': return 'KInt'
            case 'int8_t': return 'KInt'
            case 'uint8_t': return 'KInt'
            case 'int16_t': return 'KInt'
            case 'uint16_t': return 'KUShort'
            case 'int32_t': return 'KInt'
            case 'uint32_t': return 'KUInt'
            case 'int64_t': return 'KLong'
            case 'uint64_t': return 'KInt'
            case 'char16_t': return 'KUInt'
            case 'double': return 'KDouble'
            case 'float': return 'KFloat'
            case 'size_t': return 'KInt'
            case 'size_t*': return 'KNativePointer'
            case 'char*': return 'String'
            case 'char**': return 'KStringArray'
            case 'char***': return 'KNativePointer' // TODO: unsupported
            case 'void': return 'KNativePointer'
            case 'void_ptr': return 'void'
        }
        if (common.enumNames.includes(irType)) {
            return `KInt`
        }
        throw new Error(`Unsupported type: ${irType}, ${type.name}`)
    }
}

export function idl2nativeModule(name: string, content: string): string {
    let printer = new NativeModulePrinter()
    webidl2.parse(content)
        .filter(it => !!it.type)
        .map(it => toIDLNode(name, it))
        .forEach(it => {
            printer.visit(it)
        })
    return printer.getOutput().join('\n')
}
