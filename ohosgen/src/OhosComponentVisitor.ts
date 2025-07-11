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

import * as idl from '@idlizer/core/idl'
import { FieldModifier, getSuperType, IDLInterface, IDLMethod, IDLProperty, isClassSubkind, isInterface, LanguageWriter, LayoutNodeRole, LibraryInterface, linearizeNamespaceMembers, Method, MethodModifier, NativeModuleType } from "@idlizer/core";
import { allowsOverloads, collapseSameMethodsIDL, collectDeclDependencies, groupOverloadsIDL, groupSameSignatureMethodsIDL, ImportsCollector, peerGeneratorConfiguration, PrinterResult } from "@idlizer/libohos";

export function printComponentClasses(library: LibraryInterface): PrinterResult[] {
    return new OHOSComponentVisitor(library).print()
}

class OHOSComponentVisitor {
    constructor(private library: LibraryInterface) { }

    public print(): PrinterResult[] {
        const components: IDLInterface[] = this.library.files
            .flatMap(file => linearizeNamespaceMembers(file.entries))
            .filter(it => isInterface(it))
            .filter(it => isClassSubkind(it as IDLInterface))
            .filter(it => idl.hasExtAttribute(it, idl.IDLExtendedAttributes.Component)) as IDLInterface[]

        if (!components.length) return []

        return components.flatMap(entry => {
            const writer = this.library.createLanguageWriter()
            const collector = new ImportsCollector()

            collectDeclDependencies(this.library, entry, collector)
            collector.addFeatures(['NativeBuffer'], '@koalaui/interop')
            // collector.addFeatures([`${this.library.name.toUpperCase()}NativeModule`], `./${this.library.name.toLowerCase()}.INTERNAL`)

            const superClass = getSuperType(entry, this.library)
            const interfaces = entry.inheritance.filter(it => !idl.hasExtAttribute(it, idl.IDLExtendedAttributes.Extends)).map(it => it.name)
            writer.writeClass(
                entry.name,
                w => {
                    this.printClassBody(entry, w)
                },
                superClass?.name,
                interfaces.length ? interfaces : undefined
            )

            return [{
                collector,
                content: writer,
                over: {
                    node: entry,
                    role: LayoutNodeRole.INTERFACE
                }
            }]
        })
    }

    private printClassBody(entry: IDLInterface, printer: LanguageWriter): void {
        entry.properties.forEach(prop => {
            const defValue = peerGeneratorConfiguration().constants.get(`${entry.name}.${prop.name}`)
            const initExpr = defValue != undefined ? printer.makeString(defValue) : undefined
            printer.writeFieldDeclaration(prop.name, prop.type, toFieldModifiers(prop), prop.isOptional, initExpr)
        })

        const groupedMethods = groupOverloadsIDL(entry.methods, this.library.language)
        if (!allowsOverloads(this.library.language)) {
            groupedMethods.forEach(methods => {
                this.printClassMethod(entry.name, methods, printer)
            })
        } else {
            // Handle special case for same name AND same signature methods.
            // Collapse same signature methods
            groupedMethods.forEach(sameNameGroup => {
                let copy = Array.from([...sameNameGroup])
                const sameSignatureMethodsGroups = groupSameSignatureMethodsIDL([...copy])
                for (let sameSignatureGroup of sameSignatureMethodsGroups) {
                    this.printClassMethod(entry.name, sameSignatureGroup, printer)
                }
            })
        }
    }

    private printClassMethod(clazz: string, methods: IDLMethod[], printer: LanguageWriter) {
        const collapsedMethod = collapseSameMethodsIDL(methods, this.library.language)
        const method = new Method(collapsedMethod.name, printer.makeNamedSignature(collapsedMethod.returnType, collapsedMethod.parameters), [MethodModifier.PUBLIC])
        printer.writeMethodImplementation(method, writer => {
            writer.writeStatement(
                writer.makeReturn(
                    writer.makeNativeCall(
                        new NativeModuleType(`${this.library.name.toUpperCase()}NativeModule`),
                        `_${clazz}_${method.name}`,
                        [
                            writer.makeString(`this.ptr`),
                            ...collapsedMethod.parameters.map(it => writer.makeString(it.name))
                        ]
                    )
                )
            )
        })
    }
}

/////////////////////////////////////////////////

function toFieldModifiers(prop: IDLProperty) {
    const modifiers: FieldModifier[] = []
    if (prop.isReadonly) {
        modifiers.push(FieldModifier.READONLY)
    }
    if (prop.isStatic) {
        modifiers.push(FieldModifier.STATIC)
    }
    return modifiers
}
