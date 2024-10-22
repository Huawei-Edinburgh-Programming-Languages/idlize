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

import * as idl from '../../../idl'
import * as path from 'path'
import { IdlPeerLibrary } from "../IdlPeerLibrary"
import {
    createLanguageWriter,
    FieldModifier,
    LanguageWriter,
    Method,
    MethodModifier,
    MethodSignature,
    NamedMethodSignature,
    Type
} from '../../LanguageWriters'
import {
    indentedBy,
    isDefined,
    removeExt,
    renameDtsToInterfaces,
    stringOrNone,
    throwException
} from '../../../util'
import { ImportsCollector } from '../../ImportsCollector'
import { IdlPeerFile } from '../IdlPeerFile'
import { IndentedPrinter } from "../../../IndentedPrinter"
import { TargetFile } from '../../printers/TargetFile'
import { PrinterContext } from '../../printers/PrinterContext'
import { convertDeclaration, DeclarationConvertor } from "../IdlTypeConvertor";
import { makeSyntheticDeclarationsFiles } from '../IdlSyntheticDeclarations'
import { tsCopyrightAndWarning } from '../../FileGenerators'
import { EnumEntity } from '../../PeerFile'
import { ARK_OBJECTBASE, ARKOALA_PACKAGE, ARKOALA_PACKAGE_PATH, INT_VALUE_GETTER } from '../../printers/lang/Java'
import { printJavaImports } from '../../printers/lang/JavaPrinters'
import { collectJavaImports } from '../../printers/lang/JavaIdlUtils'
import { Language } from '../../../Language'
import { ArkTSTypeNameConvertor } from "../IdlNameConvertor";
import { escapeKeyword } from "../../../idl";
import { DefaultInterfacesVisitor } from '../InterfacePrinter'

class CJDeclaration {
    public readonly targetFile: TargetFile
    constructor(alias: string, public readonly writer: LanguageWriter) {
        this.targetFile = new TargetFile(alias + writer.language.extension, '')
    }
}

export class CJInterfacesVisitor extends DefaultInterfacesVisitor {
    constructor(protected readonly peerLibrary: IdlPeerLibrary) {
       super()
    }

    // here we write everything
    printInterfaces() {
        const declarationConverter = new CJDeclarationConvertor(this.peerLibrary, (declaration: CJDeclaration) => {
            this.interfaces.set(declaration.targetFile, declaration.writer)
        })

        
        for (const file of this.peerLibrary.files.values()) {
            file.declarations.forEach(it => convertDeclaration(declarationConverter, it))
        }
    }
}

export class CJDeclarationConvertor implements DeclarationConvertor<void> {
    constructor(private readonly peerLibrary: IdlPeerLibrary, private readonly onNewDeclaration: (declaration: CJDeclaration) => void) {}
    convertCallback(node: idl.IDLCallback): void {
    }
    convertEnum(node: idl.IDLEnum): void {
        throw new Error("Enums are processed separately")
    }
    convertTypedef(node: idl.IDLTypedef): void {
        this.convertTypedefTarget(node.name, node.type)
    }
    private convertTypedefTarget(name: string, type: idl.IDLEntry) {
        if (idl.isUnionType(type)) {
            this.onNewDeclaration(this.makeUnion(name, type))
            return
        }
        if (idl.isEnumType(type)) {
            this.onNewDeclaration(this.makeEnum(name, type))
            return
        }
        if (idl.isInterface(type) || idl.isAnonymousInterface(type)) {
            this.onNewDeclaration(this.makeInterface(name, type))
            return
        }
        if (idl.isTupleInterface(type)) {
            this.onNewDeclaration(this.makeTuple(name, type))
            return
        }
        if (idl.isReferenceType(type)) {
            const target = this.peerLibrary.resolveTypeReference(type)
            this.convertTypedefTarget(name, target!)
            return
        }
        if (idl.isPrimitiveType(type)) {
            return
        }
        // ignore imports since they are replaced with synthetic declarations
        const importAttr = idl.getExtAttribute(type, idl.IDLExtendedAttributes.Import)
        if (importAttr) {
            return
        }
        throw new Error(`Unsupported typedef: ${name}, kind=${type.kind}`)
    }
    convertInterface(node: idl.IDLInterface): void {
        const decl = node.kind == idl.IDLKind.TupleInterface
            ? this.makeTuple(node.name, node)
            : this.makeInterface(node.name, node)
        this.onNewDeclaration(decl)
    }

    private printPackage(writer: LanguageWriter): void {
        writer.print(`package idlize;\n`)
    }

    private makeUnion(alias: string, type: idl.IDLUnionType): CJDeclaration {
        const writer = createLanguageWriter(Language.CJ)
        this.printPackage(writer)


        writer.print('import std.collection.*')

        const members = type.types.map(it => new Type(this.peerLibrary.mapType(it), false) )
        writer.writeClass(alias, () => {
            const intType = new Type('Int32')
            const selector = 'selector'
            writer.writeFieldDeclaration(selector, intType, [FieldModifier.PRIVATE], false)
            writer.writeMethodImplementation(new Method('getSelector', new MethodSignature(intType, []), [MethodModifier.PUBLIC]), () => {
                writer.writeStatement(
                    writer.makeReturn(
                        writer.makeString(selector)
                    )
                )
            })

            const param = 'param'
            for (const [index, memberType] of members.entries()) {
                const memberName = `value${index}`
                writer.writeFieldDeclaration(memberName, memberType, [FieldModifier.PRIVATE], false)

                writer.writeConstructorImplementation(
                    'init',
                    new NamedMethodSignature(Type.Void, [memberType], [param]),
                    () => {
                        writer.writeStatement(
                            writer.makeAssign(memberName, undefined, writer.makeString(param), false)
                        )
                        writer.writeStatement(
                            writer.makeAssign(selector, undefined, writer.makeString(index.toString()), false)
                        )
                    }
                )

                writer.writeMethodImplementation(
                    new Method(`getValue${index}`, new MethodSignature(memberType, []), [MethodModifier.PUBLIC]),
                    () => {
                        writer.writeStatement(
                            writer.makeReturn(
                                writer.makeString(memberName)
                            )
                        )
                    }
                )
            }
        }, ARK_OBJECTBASE)

        return new CJDeclaration(alias, writer)
    }

    private makeTuple(alias: string, type: idl.IDLInterface): CJDeclaration {
        const writer = createLanguageWriter(Language.CJ)
        this.printPackage(writer)

        const members = type.properties.map(it => new Type(this.peerLibrary.mapType(it.type), it.isOptional))
        const memberNames: string[] = members.map((_, index) => `value${index}`)
        writer.writeClass(alias, () => {
            for (let i = 0; i < memberNames.length; i++) {
                writer.writeFieldDeclaration(memberNames[i], members[i], [FieldModifier.PUBLIC], false)
            }

            const signature = new MethodSignature(Type.Void, members)
            writer.writeConstructorImplementation(alias, signature, () => {
                for (let i = 0; i < memberNames.length; i++) {
                    writer.writeStatement(
                        writer.makeAssign(memberNames[i], members[i], writer.makeString(signature.argName(i)), false)
                    )
                }
            })
        }, ARK_OBJECTBASE)

        return new CJDeclaration(alias, writer)
    }

    private makeEnum(alias: string, type: idl.IDLEnumType): CJDeclaration {
        const writer = createLanguageWriter(Language.CJ)
        this.printPackage(writer)

        const enumDecl = this.peerLibrary.resolveTypeReference(type) as idl.IDLEnum
        const initializers = enumDecl.elements.map(it => {
            return {name: it.name, id: isNaN(parseInt(it.initializer as string, 10)) ? it.initializer : parseInt(it.initializer as string, 10)}
        })

        const isStringEnum = initializers.every(it => typeof it.id == 'string')
        // TODO: string enums
        if (isStringEnum) {
            throw new Error(`String enums (${alias}) not supported yet in CJ`)
        }

        let memberValue = 0
        const members: {
            name: string,
            stringId: string | undefined,
            numberId: number,
        }[] = []
        for (const initializer of initializers) {
            if (typeof initializer.id == 'string') {
                members.push({name: initializer.name, stringId: initializer.id, numberId: memberValue})
            }
            else if (typeof initializer.id == 'number') {
                memberValue = initializer.id
                members.push({name: initializer.name, stringId: undefined, numberId: memberValue})
            }
            else {
                members.push({name: initializer.name, stringId: undefined, numberId: memberValue})
            }
            memberValue += 1
        }

        writer.writeClass(alias, () => {
            const enumType = new Type(alias)
            members.forEach(it => {
                writer.writeFieldDeclaration(it.name, enumType, [FieldModifier.PUBLIC, FieldModifier.STATIC, FieldModifier.FINAL], false,
                    writer.makeString(`${alias}(${it.numberId})`)
                )
            })

            const value = 'value'
            const intType = new Type('int')
            writer.writeFieldDeclaration(value, intType, [FieldModifier.PUBLIC, FieldModifier.FINAL], false)

            const signature = new MethodSignature(Type.Void, [intType])
            writer.writeConstructorImplementation(alias, signature, () => {
                writer.writeStatement(
                    writer.makeAssign(value, undefined, writer.makeString(signature.argName(0)), false)
                )
            })

            const getIntValue = new Method('getIntValue', new MethodSignature(intType, []), [MethodModifier.PUBLIC])
            writer.writeMethodImplementation(getIntValue, () => {
                writer.writeStatement(
                    writer.makeReturn(writer.makeString(value))
                )
            })
        }, ARK_OBJECTBASE, [INT_VALUE_GETTER])

        return new CJDeclaration(alias, writer)
    }

    private makeInterface(alias: string, type: idl.IDLInterface): CJDeclaration {
        const writer = createLanguageWriter(Language.CJ)
        this.printPackage(writer)

        // TODO: *Attribute classes are empty for now
        const members = this.peerLibrary.isComponentDeclaration(type) ? []
            : type.properties.map(it => {
                return {name: it.name, type: new Type(this.peerLibrary.mapType(it.type), it.isOptional), modifiers: [FieldModifier.PUBLIC]}
            })
        writer.writeClass(alias, () => {
            members.forEach(it => {
                writer.writeFieldDeclaration(it.name, it.type, it.modifiers, false)
            })
        }, idl.getSuperType(type)?.name ?? ARK_OBJECTBASE)

        return new CJDeclaration(alias, writer)
    }
}
