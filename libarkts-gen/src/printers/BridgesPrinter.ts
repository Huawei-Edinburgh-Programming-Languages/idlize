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

import {
    IDLContainerType,
    IDLContainerUtils,
    IDLKind,
    IDLMethod,
    IDLReferenceType,
    IndentedPrinter,
    isTypedef,
    isVoidType,
    throwException
} from "@idlize/core"
import {
    IDLEntry,
    IDLInterface,
    IDLParameter,
    IDLType,
    isInterface,
    isContainerType,
    isEnum,
    isPrimitiveType,
    isReferenceType,
} from "@idlize/core/idl"
import { NativeTypeConvertor } from "../NativeTypeConvertor"
import { convertType } from "@idlize/core"
import { IDLFile } from "../Es2PandaTransformer"
import { Config } from "../Config"

export class BridgesPrinter {
    constructor(
        private idl: IDLFile,
        private config: Config
    ) { }

    private printer = new IndentedPrinter()
    private convertor = new NativeTypeConvertor(this.idl.entries)

    print(): string {
        this.idl.entries.forEach(it => this.visit(it))
        return this.printer.getOutput().join('\n')
    }

    private visit(node: IDLEntry): void {
        if (isInterface(node)) return this.visitInterface(node)
        if (isEnum(node)) return
        if (isTypedef(node)) return

        throwException(`Unexpected top-level node: ${IDLKind[node.kind]}`)
    }

    private visitInterface(node: IDLInterface): void {
        if (!this.config.shouldEmitInterface(node.name)) return
        node.methods
            .filter(it => !this.config.paramArray(`handwrittenMethods`).includes(it.name))
            .forEach(it => this.printMethod(node.name, it))
    }

    private printParameters(parameters: IDLParameter[]): void {
        parameters.forEach((it, index, array) => {
            const comma = index === array.length - 1 ? `` : `,`
            this.printer.print(`${this.mapType(it.type)} ${it.name}${comma}`)
        })
    }

    private printInteropMacro(constructorName: string, returnType: IDLType, parameters: IDLParameter[]): void {
        if (isVoidType(returnType)) return this.printVoidInteropMacro(constructorName, parameters)

        const args = [
            constructorName,
            this.mapType(returnType),
            ...parameters.map(it => this.mapType(it.type))
        ].join(`, `)
        this.printer.print(`${this.config.interopMacroPrefix(false)}${parameters.length}(${args})`)
    }

    private printVoidInteropMacro(constructorName: string, parameters: IDLParameter[]): void {
        const args = [
            constructorName,
            ...parameters.map(it => this.mapType(it.type))
        ]
        this.printer.print(`${this.config.interopMacroPrefix(true)}${parameters.length}(${args})`)
    }

    private printBody(constructorName: string, parameters: IDLParameter[]): void {
        this.printer.print(`return GetImpl()->${constructorName}(`)
        this.printer.withIndent(() =>
            parameters.forEach((it, index, array) => {
                const comma = index !== array.length - 1
                    ? `,`
                    : ``
                this.printer.print(`${this.casted(it)}${comma}`)
            })
        )
        this.printer.print(`);`)
    }

    private casted(node: IDLParameter): string {
        if (isPrimitiveType(node.type)) return node.name
        if (isReferenceType(node.type) || isContainerType(node.type)) {
            const castTo = this.castTo(node.type)
            return castTo === undefined
                ? node.name
                : `reinterpret_cast<${castTo}>(${node.name})`
        }
        throw new Error(`Unsupported type: ${node.type}`)
    }

    private castTo(node: IDLReferenceType | IDLContainerType): string | undefined {
        if (isPrimitiveType(node)) return undefined
        if (isReferenceType(node)) {
            /* Temporary workaround until .idl is fixed */
            if (node.name === `es2panda_Context`) return `${node.name}*`
            return `${this.config.typePrefix}${node.name}*`
        }
        if (isContainerType(node)) {
            if (IDLContainerUtils.isSequence(node)) {
                const typeParam = node.elementType[0]
                if (isContainerType(typeParam)) {
                    console.warn(`Warning: doing nothing for sequence<sequence<T>>`)
                    return undefined
                }
                if (!isReferenceType(typeParam)) throwException(
                    `Sequence of non-reference type: ${JSON.stringify(typeParam)}`
                )
                return `${this.config.typePrefix}${typeParam.name}**`
            }
        }

        throwException(`Unexpected type: ${IDLKind[node.kind]}`)
    }

    private mapType(node: IDLType): string {
        return convertType(this.convertor, node)
    }

    private printMethod(astNodeName: string, node: IDLMethod): void {
        if (!this.config.shouldEmitMethod(node.name)) return
        this.printFunction(`${this.config.methodFunction(astNodeName, node.name)}`, node.parameters, node.returnType)
    }

    private printFunction(name: string, parameters: IDLParameter[], returnType: IDLType): void {
        this.printer.print(`${this.mapType(returnType)} ${this.config.implFunction(name)}(`)
        this.printer.withIndent(() =>
            this.printParameters(parameters)
        )
        this.printer.print(`) {`)
        this.printer.withIndent(() =>
            this.printBody(name, parameters)
        )
        this.printer.print(`}`)

        this.printInteropMacro(name, returnType, parameters)
        this.printer.print(``)
    }
}
