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

import {
    collectPeersForFile,
    componentToPeerClass,
    findComponentByType,
    groupOverloads,
    ImportsCollector,
    OverloadsPrinter,
    PrinterResult,
    TargetFile
} from "@idlizer/libohos"
import * as idl from "@idlizer/core"

function generateComponentName(component: string) {
    return `Sk${component}Component`
}

function componentToAttributesInterface(component: string) {
    return `${component}`
}

interface ComponentFileVisitor {
    visit(): PrinterResult[]
}

class TSComponentFileVisitor implements ComponentFileVisitor {
    constructor(
        protected readonly library: idl.LibraryInterface,
        protected readonly file: idl.IDLFile,
        protected readonly options: {
            isDeclared: boolean,
        }
    ) { }

    visit(): PrinterResult[] {
        const result: PrinterResult[] = []
        collectPeersForFile(this.library, this.file).forEach(peer => {
            if (!this.options.isDeclared)
                result.push(...this.printComponent(peer))
            result.push(...this.printComponentFunction(peer))
        })
        return result
    }

    private printImports(
        peer: idl.PeerClass,
        // component:IdlComponentDeclaration
    ): ImportsCollector {
        const imports = new ImportsCollector()
        return imports
    }

    private overloadsPrinter(printer: idl.LanguageWriter) {
        return new OverloadsPrinter(this.library, printer, this.library.language, true)
    }

    private printComponent(peer: idl.PeerClass): PrinterResult[] {
        const imports = this.printImports(peer)
        const printer = this.library.createLanguageWriter()

        const componentClassName = generateComponentName(peer.componentName)
        const parentComponentClassName = peer.parentComponentName
        const peerClassName = componentToPeerClass(peer.componentName)

        const component = findComponentByType(this.library, idl.createReferenceType(peer.originalClassName!))!

        if (!idl.isRoot(peer.componentName)) {
            printer.writeClass(componentClassName, (writer) => {
                writer.writeMethodImplementation(
                    new idl.Method('getPeer',
                        new idl.MethodSignature(idl.createReferenceType(peerClassName), []
                        ), [idl.MethodModifier.PROTECTED], []),
                    writer => writer.writeStatement(
                        writer.makeReturn(
                            writer.makeCast(
                                writer.makeFieldAccess("this", "peer"),
                                idl.createReferenceType(peerClassName),
                                { optional: true }
                            )
                        )
                    )
                )
                for (const grouped of groupOverloads(peer.methods, this.library.language)) {
                    this.overloadsPrinter(printer).printGroupedComponentOverloads(peer.originalClassName!, grouped)
                }

                const attributesFinishSignature = new idl.MethodSignature(idl.IDLVoidType, [])
                const applyAttributesFinish = 'applyAttributesFinish'
                writer.writeMethodImplementation(new idl.Method(applyAttributesFinish, attributesFinishSignature, [idl.MethodModifier.PUBLIC]), (writer) => {
                    writer.print('// we call this function outside of class, so need to make it public')
                    writer.writeMethodCall('super', applyAttributesFinish, [])
                })
            }, parentComponentClassName, [componentToAttributesInterface(peer.originalClassName!)])
        }

        return [{
            collector: imports,
            content: printer,
            over: {
                node: component.attributeDeclaration,
                role: idl.LayoutNodeRole.COMPONENT,
                hint: 'component.implementation'
            }
        }]
    }

    protected printComponentFunction(peer: idl.PeerClass): PrinterResult[] {
        const imports = this.printImports(peer)
        const printer = this.library.createLanguageWriter()

        const component = findComponentByType(this.library, idl.createReferenceType(peer.originalClassName!))!

        return [{
            collector: imports,
            content: printer,
            over: {
                node: component.attributeDeclaration,
                role: idl.LayoutNodeRole.COMPONENT,
                hint: 'component.function'
            }
        }]
    }
}

class ComponentsVisitor {
    readonly components: Map<TargetFile, idl.LanguageWriter> = new Map()
    private readonly language: idl.Language

    constructor(
        private readonly peerLibrary: idl.LibraryInterface,
        private options: {
            isDeclared: boolean
        }
    ) {
        this.language = this.peerLibrary.language
    }

    printComponents(): PrinterResult[] {
        const result: PrinterResult[] = []
        for (const file of this.peerLibrary.files.values()) {
            if (!collectPeersForFile(this.peerLibrary, file).length)
                continue
            let visitor: ComponentFileVisitor
            if (this.language == idl.Language.TS) {
                visitor = new TSComponentFileVisitor(this.peerLibrary, file, this.options)
            } else {
                throw new Error(`ComponentsVisitor not implemented for ${this.language.toString()}`)
            }
            result.push(...visitor.visit())
        }
        return result
    }
}

export function printComponents(peerLibrary: idl.LibraryInterface): PrinterResult[] {
    return new ComponentsVisitor(peerLibrary, { isDeclared: false }).printComponents()
}

export function printComponentsDeclarations(peerLibrary: idl.LibraryInterface): PrinterResult[] {
    if (![idl.Language.TS, idl.Language.ARKTS, idl.Language.JAVA].includes(peerLibrary.language))
        return []

    return new ComponentsVisitor(peerLibrary, { isDeclared: true }).printComponents()
}
