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

export class PluginApiPrinter extends IndentedPrinter {
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
        node.methods.map(it => this.printMethod(it))
    }

    printMethod(node: IDLMethod) {
        if (!common.isValidType(node.returnType)) {
            throw new Error(`Type expected to be reference: ${node.returnType.kind}`)
        }
        this.print(`${PluginApiPrinter.printTypeForC(node.returnType)} impl_${node.name}(`)
        this.pushIndent()
        node.parameters.forEach(
            (param: IDLParameter, index) => {
                const maybeComma = (index !== node.parameters.length - 1) ? ',' : ''
                this.print(`${this.printParam(param)}${maybeComma}`)
            }
        )
        this.popIndent()
        this.print(`) {`)
        this.pushIndent()
        node.parameters.forEach(
            (param: IDLParameter) => {
                this.print(`auto _${param.name} = ${PluginApiPrinter.getCastClause(param.type!)}(${param.name});`)
            }
        )
        if (common.getIrType(node.returnType) !== 'void') {
            this.print(`return GetImpl()->${node.name}(${node.parameters.map(param => `_${param.name}`).join(', ')});`)
        } else {
            this.print(`GetImpl()->${node.name}(${node.parameters.map(param => `_${param.name}`).join(', ')});`)
            this.print(`return nullptr;`)
        }
        this.popIndent()
        this.print(`}`)
        if (node.parameters.length > 0) {
            this.print(`KOALA_INTEROP_${node.parameters.length}(${node.name}, ${PluginApiPrinter.printTypeForC(node.returnType)}, ${node.parameters.map(param => PluginApiPrinter.printTypeForC(param.type)).join(', ')});`)
        } else {
            this.print(`KOALA_INTEROP_0(${node.name}, ${PluginApiPrinter.printTypeForC(node.returnType)});`)
        }
        this.print(``)
    }

    printParam(param: IDLParameter): string {
        if (!common.isValidType(param.type)) {
            throw new Error(`Type expected to be reference: ${param.type?.kind}`)
        }
        return `${PluginApiPrinter.printTypeForC(param.type)} ${param.name}`
    }

    private static printTypeForC(type: IDLType | undefined): string {
        if (!common.isValidType(type)) {
            throw new Error(`Type expected to be reference: ${type?.kind}`)
        }
        const irType = common.getIrType(type)
        switch (irType) {
            case '_*': return 'KNativePointer'
            case '_**': return 'KNativePointerArray'
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
            case 'char*': return 'KStringPtr'
            case 'char**': return 'KStringArray'
            case 'char***': return 'KNativePointer' // TODO: unsupported
            case 'void': return 'KNativePointer'
            case 'void_ptr': return 'KNativePointer'
        }
        if (common.enumNames.includes(irType)) {
            return `KInt`
        }
        throw new Error(`Unsupported type: ${irType}, ${type.name}`)
    }

    private static getCastClause(type: IDLType): string {
        if (!common.isValidType(type)) {
            throw new Error(`Type expected to be reference: ${type.kind}`)
        }
        const irType: string = common.getIrType(type)
        switch (irType) {
            case '_*': return `reinterpret_cast<${type.name}*>`
            case '_**': return `reinterpret_cast<${type.name}**>`
            case '_***': return `reinterpret_cast<${type.name}***>`

            case 'bool': return 'static_cast<bool>'
            case 'bool*': return 'reinterpret_cast<bool*>'
            case 'int': return 'static_cast<int>'
            case 'int8_t': return 'static_cast<int8_t>'
            case 'uint8_t': return 'static_cast<uint8_t>'
            case 'int16_t': return 'static_cast<int16_t>'
            case 'uint16_t': return 'static_cast<uint16_t>'
            case 'int32_t': return 'static_cast<int32_t>'
            case 'uint32_t': return 'static_cast<uint32_t>'
            case 'int64_t': return 'static_cast<int64_t>'
            case 'uint64_t': return 'static_cast<uint64_t>'
            case 'char16_t': return 'static_cast<char16_t>'
            case 'double': return 'static_cast<double>'
            case 'float': return 'static_cast<float>'
            case 'size_t': return 'static_cast<std::size_t>'
            case 'size_t*': return 'reinterpret_cast<std::size_t*>'
            case 'char*': return 'getStringCopy' // returns char*
            case 'char**': return 'reinterpret_cast<char**>'
            case 'char***': return 'reinterpret_cast<char***>'
            case 'void_ptr': return 'reinterpret_cast<void*>'
        }
        if (common.enumNames.includes(irType)) {
            return `static_cast<${irType}>`
        }
        throw new Error(`Unsupported type: ${irType}`)
    }
}

export function idl2pluginApi(name: string, content: string): string {
    let printer = new PluginApiPrinter()
    webidl2.parse(content)
        .filter(it => !!it.type)
        .map(it => toIDLNode(name, it))
        .forEach(it => {
            printer.visit(it)
        })
    return printer.getOutput().join('\n')
}
