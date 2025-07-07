// /*
//  * Copyright (c) 2024 Huawei Device Co., Ltd.
//  * Licensed under the Apache License, Version 2.0 (the "License");
//  * you may not use this file except in compliance with the License.
//  * You may obtain a copy of the License at
//  *
//  * http://www.apache.org/licenses/LICENSE-2.0
//  *
//  * Unless required by applicable law or agreed to in writing, software
//  * distributed under the License is distributed on an "AS IS" BASIS,
//  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  * See the License for the specific language governing permissions and
//  * limitations under the License.
//  */

// import * as idl from "@idlizer/core/idl"
// import { DeclarationConvertor, getSuper, Language, LanguageWriter, LibraryInterface, stringOrNone } from "@idlizer/core"
// import { collapseIdlPeerMethods, collectPeers, findComponentByDeclaration, groupOverloads, InterfacesVisitor, isComponentDeclaration, PrinterFunction, TSDeclConvertor, TSInterfacesVisitor } from "@idlizer/libohos"

// function componentToAttributesInterface(component: string) {
//     return `${component}`
// }

// class SkoalaTSDeclConvertor extends TSDeclConvertor {
//     protected printComponent(idlInterface: idl.IDLInterface): stringOrNone[] {
//         const component = findComponentByDeclaration(this.peerLibrary, idlInterface)
//         if (idlInterface !== component?.attributeDeclaration)
//             return []
//         const peer = collectPeers(this.peerLibrary).find(it => it.componentName === component.name)
//         if (!peer) throw new Error(`Peer for component ${component.name} was not found`)
//         const printer = this.peerLibrary.createLanguageWriter()
//         const declaredPrefix = this.isDeclared ? "declare " : ""
//         const superType = getSuper(idlInterface, this.peerLibrary)
//         const extendsClause = superType ? `extends ${componentToAttributesInterface(superType.name)} ` : ""

//         printer.print(`export ${declaredPrefix}interface ${componentToAttributesInterface(idlInterface.name)} ${extendsClause}{`)
//         printer.pushIndent()
//         const filteredMethods = peer!.methods
//             .filter(it => !it.isCallSignature)
//         const collapsedMethods = groupOverloads(filteredMethods, this.peerLibrary.language)
//             .map(group => collapseIdlPeerMethods(this.peerLibrary, group))
//         collapsedMethods.forEach(method =>
//             printer.writeMethodDeclaration(method.method.name, method.method.signature))
//         printer.popIndent()            
//         printer.print('}')
        
//         return printer.getOutput()
//     }

//     convertInterface(node: idl.IDLInterface) {
//         if (this.seenInterfaceNames.has(node.name)) {
//             console.log(`interface name: '${node.name}' already exists`)
//             return
//         }
//         if (isComponentDeclaration(this.peerLibrary, node)) {
//             this.seenInterfaceNames.add(node.name)
//             this.writer.writeLines(this.printComponent(node).join("\n"))
//             return
//         }
//         return super.convertInterface(node)
//     }
// }

// class SkoalaTSInterfacesVisitor extends TSInterfacesVisitor {
//     protected override getDeclConvertor(writer: LanguageWriter, seenNames: Set<string>, library: LibraryInterface, isDeclared: boolean): DeclarationConvertor<void> {
//         return new SkoalaTSDeclConvertor(writer, seenNames, library, isDeclared)
//     }
// }

// function getVisitor(peerLibrary: LibraryInterface): InterfacesVisitor {
//     if (peerLibrary.language == Language.TS) {
//         return new SkoalaTSInterfacesVisitor(peerLibrary, true)
//     }
//     throw new Error(`Need to implement InterfacesVisitor for ${peerLibrary.language} language`)
// }

// export function createInterfacePrinter(isDeclarations: boolean): PrinterFunction {
//     return (library: LibraryInterface) => getVisitor(library).printInterfaces()
// }
