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
import { PrimitiveType } from "./DeclarationTable";
import { completeImplementations, dummyImplementations, modifierStructList, modifierStructs } from "./FileGenerators";
import { PeerClass } from "./PeerClass";
import { PeerLibrary } from "./PeerLibrary";
import { PeerMethod } from "./PeerMethod";
import { PeerGeneratorConfig } from "./PeerGeneratorConfig";

class ModifierVisitor {
    dummy = new IndentedPrinter()
    real = new IndentedPrinter()
    modifiers = new IndentedPrinter()
    modifierList = new IndentedPrinter()
    private prefix = PeerGeneratorConfig.cppPrefix()

    constructor(
        private library: PeerLibrary,
    ) { }

    printDummyImplFunctionBody(method: PeerMethod) {
        this.dummy.print(`string out("${method.methodName}(");`)
        method.argConvertors.forEach((argConvertor, index) => {
            if (index > 0) this.dummy.print(`out.append(", ");`)
            this.dummy.print(`WriteToString(&out, ${argConvertor.param});`)
        })
        this.dummy.print(`out.append(")");`)
        this.dummy.print(`appendGroupedLog(1, out);`)
        if (method.retType != "void") this.dummy.print(`return 0;`)
    }

    printModifierImplFunctionBody(method: PeerMethod) {
        const firstDeclarationTarget = method.declarationTargets[0]
        const firstArgConvertor = method.argConvertors[0]
        if (firstDeclarationTarget && !(firstDeclarationTarget instanceof PrimitiveType)) {
            const declarationTable = this.library.declarationTable
            declarationTable.generateFirstArgDestruct(firstArgConvertor, firstDeclarationTarget, this.real, firstArgConvertor.isPointerType())
        }
        if (method.retType != "void") this.real.print(`return 0;`)
    }

    printMethodProlog(printer: IndentedPrinter, method: PeerMethod) {
        const apiParameters = method.generateAPIParameters(method.argConvertors).join(", ")
        const signature = `${method.retType} ${method.implName}(${apiParameters}) {`
        printer.print(signature)
        printer.pushIndent()
    }

    printMethodEpilogue(printer: IndentedPrinter) {
        printer.popIndent()
        printer.print(`}`)
    }

    printRealAndDummyModifier(method: PeerMethod) {
        this.printMethodProlog(this.dummy, method)
        this.printMethodProlog(this.real, method)
        this.printDummyImplFunctionBody(method)
        this.printModifierImplFunctionBody(method)
        this.printMethodEpilogue(this.dummy)
        this.printMethodEpilogue(this.real)

        this.modifiers.print(`${method.implName},`)
    }

    printClassProlog(clazz: PeerClass) {
        const component = clazz.componentName
        const modifierStructImpl = `${this.prefix}ArkUI${component}ModifierImpl`

        this.modifiers.print(`${this.prefix}ArkUI${component}Modifier ${modifierStructImpl} {`)
        this.modifiers.pushIndent()

        this.modifierList.pushIndent()
        this.modifierList.print(`Get${component}Modifier,`)
        this.modifierList.popIndent()
    }

    printClassEpilogue(clazz: PeerClass) {
        this.modifiers.popIndent()
        this.modifiers.print(`};\n`)
        const name = clazz.componentName
        this.modifiers.print(`const ${this.prefix}ArkUI${name}Modifier* Get${name}Modifier() { return &${PeerGeneratorConfig.cppPrefix()}ArkUI${name}ModifierImpl; }\n\n`)
    }

    // TODO: have a proper Peer module visitor
    printRealAndDummyModifiers(prefix: string) {
        this.library.files.forEach(file => {
            file.peers.forEach(clazz => {
                this.printClassProlog(clazz, prefix)
                clazz.methods.forEach(method => {
                    this.printRealAndDummyModifier(method)
                })
                this.printClassEpilogue(clazz)
            })
        })
    }
}

export function printRealAndDummyModifiers(
    peerLibrary: PeerLibrary,
    prefix: string = ""
): {
    dummy: string,
    real: string
} {
    const visitor = new ModifierVisitor(peerLibrary)
    visitor.printRealAndDummyModifiers(prefix)

    const dummy =
        dummyImplementations(visitor.dummy.getOutput()) +
        modifierStructs(visitor.modifiers.getOutput()) +
        modifierStructList(visitor.modifierList.getOutput())

    const real =
        completeImplementations(visitor.real.getOutput()) +
        modifierStructs(visitor.modifiers.getOutput()) +
        modifierStructList(visitor.modifierList.getOutput())
    return { dummy, real }
}