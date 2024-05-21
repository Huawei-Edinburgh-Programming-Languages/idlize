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

import { IndentedPrinter } from "../IndentedPrinter";
import { DeclarationTable, FieldRecord } from "./DeclarationTable";
import { modifierStructList, modifierStructs } from "./FileGenerators";
import { PeerClass } from "./PeerClass";
import { PeerLibrary } from "./PeerLibrary";
import { MethodSeparatorVisitor, PeerMethod } from "./PeerMethod";
import { DelegateSignatureBuilder } from "./DelegatePrinter";
import { PeerFile } from "./PeerFile";
import { AccessorVisitor } from "./AccessorPrinter";

class MethodSeparatorPrinter extends MethodSeparatorVisitor {
    public readonly printer = new IndentedPrinter()
    constructor(
        declarationTable: DeclarationTable,
        method: PeerMethod,
    ) {
        super(declarationTable, method)
        this.delegateSignatureBuilder = new DelegateSignatureBuilder(declarationTable, method)
        this.accessChain = method.argConvertors.map(convertor => [{
            name: convertor.param,
            access: convertor.isPointerType() ? '->' : '.'
        }])
    }

    private readonly delegateSignatureBuilder: DelegateSignatureBuilder
    private readonly accessChain: {name: string, access: string}[][]
    private generateAccessTo(argIndex: number, fieldName?: string) {
        const argAccessChain = this.accessChain[argIndex]
        let access = argAccessChain[0].name
        for (let i = 1; i < argAccessChain.length; i++)
            access += `${argAccessChain[i-1].access}${argAccessChain[i].name}`
        if (fieldName)
            access += `${argAccessChain[argAccessChain.length-1].access}${fieldName}`
        return access
    }

    onPushUnionScope(argIndex: number, field: FieldRecord, selectorValue: number): void {
        super.onPushUnionScope(argIndex, field, selectorValue)
        this.printer.print(`if (${this.generateAccessTo(argIndex, 'selector')} == ${selectorValue}) {`)
        this.printer.pushIndent()
        this.accessChain[argIndex].push({
            name: field.name,
            access: '.'
        })
        this.delegateSignatureBuilder.pushUnionScope(argIndex, field)
    }

    onPopUnionScope(argIndex: number): void {
        super.onPopUnionScope(argIndex)
        this.accessChain[argIndex].pop()
        this.printer.popIndent()
        this.printer.print('}')
        this.delegateSignatureBuilder.popScope(argIndex)
    }

    protected generateInseparableFieldName(argIndex: number) {
        return `arg${argIndex}_inseparable_value`
    }

    onVisitInseparableArg(argIndex: number): void {
        super.onVisitInseparableArg(argIndex)
        this.printer.print(`const auto &${this.generateInseparableFieldName(argIndex)} = ${this.generateAccessTo(argIndex)};`)
    }

    onVisitInseparable(): void {
        super.onVisitInseparable()
        const delegateIdentifier = this.delegateSignatureBuilder.buildIdentifier()
        let delegateArgs = Array.from({length: this.method.argConvertors.length}, (_, argIndex) => {
            return this.generateInseparableFieldName(argIndex)
        })
        if (this.method.hasReceiver())
            delegateArgs = [this.method.generateReceiver()!.argName, ...delegateArgs]
        this.printer.print(`${delegateIdentifier}(${delegateArgs.join(', ')});`)        
    }
}

export type DummyAndReal<T> = {
    dummy: T,
    real: T
}

export abstract class ModifierLikeVisitor {
    dummy = new IndentedPrinter()
    real = new IndentedPrinter()
    modifierLikes = new IndentedPrinter()
    modifierLikeList = new IndentedPrinter()

    constructor(
        protected declarationTable: DeclarationTable
    ) { }

    protected abstract listTemplate: (lines: string[]) => string
    protected abstract printRealAndDummyModifierLikes(peerFile: PeerFile): DummyAndReal<string[]>

    public getDummyAndRealModifiers(peerFile: PeerFile): DummyAndReal<string> {
        this.printRealAndDummyModifierLikes(peerFile)

        const dummy =
            this.dummy.getOutput().join("\n")
            // modifierStructs(this.modifierLikes.getOutput()) +
            // modifierStructList(this.modifierLikeList.getOutput())

        const real =
            this.real.getOutput().join("\n")
            // modifierStructs(this.modifierLikes.getOutput()) +
            // this.listTemplate(this.modifierLikeList.getOutput())

        return {dummy, real}
    }

    public getAllModifiers(library: PeerLibrary): DummyAndReal<string> {
        library.files.forEach(it => this.printRealAndDummyModifierLikes(it))
        const dummy =
            // this.dummy.getOutput().join("\n")
            modifierStructs(this.modifierLikes.getOutput()) +
            this.listTemplate(this.modifierLikeList.getOutput())

        const real =
            // this.real.getOutput().join("\n")
            modifierStructs(this.modifierLikes.getOutput()) +
            this.listTemplate(this.modifierLikeList.getOutput())

        return {dummy, real}
    }

    protected printMethodProlog(printer: IndentedPrinter, method: PeerMethod) {
        const apiParameters = method.generateAPIParameters().join(", ")
        const signature = `${method.retType} ${method.implName}(${apiParameters}) {`
        printer.print(signature)
        printer.pushIndent()
    }

    protected printMethodEpilog(printer: IndentedPrinter) {
        printer.popIndent()
        printer.print(`}`)
    }

    protected printDummyImplFunctionBody(method: PeerMethod) {
        this.dummy.print(`string out("${method.method.name}(");`)
        method.argConvertors.forEach((argConvertor, index) => {
            if (index > 0) this.dummy.print(`out.append(", ");`)
            this.dummy.print(`WriteToString(&out, ${argConvertor.param});`)
        })
        this.dummy.print(`out.append(")");`)
        this.dummy.print(`appendGroupedLog(1, out);`)
        this.printReturnStatement(this.dummy, method)
    }

    protected printModifierImplFunctionBody(method: PeerMethod) {
        const visitor = new MethodSeparatorPrinter(
            this.declarationTable,
            method
        )
        visitor.visit()
        visitor.printer.getOutput().forEach(it => this.real.print(it))
        this.printReturnStatement(this.real, method)
    }

    private printReturnStatement(printer: IndentedPrinter, method: PeerMethod) {
        if (!method.retConvertor.isVoid) {
            const retValue = method.retConvertor.isStruct ? "{}" : "0"
            printer.print(`return ${retValue};`)
        }
    }
}

export class ModifierVisitor extends ModifierLikeVisitor {
    override listTemplate = modifierStructList

    constructor(declarationTable: DeclarationTable) {
        super(declarationTable)
    }

    private printRealAndDummyModifier(method: PeerMethod) {
        this.printMethodProlog(this.dummy, method)
        this.printMethodProlog(this.real, method)
        this.printDummyImplFunctionBody(method)
        this.printModifierImplFunctionBody(method)
        this.printMethodEpilog(this.dummy)
        this.printMethodEpilog(this.real)

        this.modifierLikes.print(`${method.implName},`)
    }

    private printClassProlog(clazz: PeerClass) {
        const component = clazz.componentName
        const modifierStructImpl = `ArkUI${component}ModifierImpl`

        this.modifierLikes.print(`ArkUI${component}Modifier ${modifierStructImpl} {`)
        this.modifierLikes.pushIndent()

        this.modifierLikeList.pushIndent()
        this.modifierLikeList.print(`Get${component}Modifier,`)
        this.modifierLikeList.popIndent()
    }

    private printClassEpilog(clazz: PeerClass) {
        this.modifierLikes.popIndent()
        this.modifierLikes.print(`};\n`)
        const name = clazz.componentName
        this.modifierLikes.print(`const ArkUI${name}Modifier* Get${name}Modifier() { return &ArkUI${name}ModifierImpl; }\n\n`)
    }

    override printRealAndDummyModifierLikes(peerFile: PeerFile) {
        peerFile.peers.forEach(peerClass => {
            this.printClassProlog(peerClass)
            peerClass.methods.forEach(method => this.printRealAndDummyModifier(method))
            this.printClassEpilog(peerClass)
        })
        return {
            dummy: this.dummy.getOutput(),
            real: this.real.getOutput()
        }
    }
}
