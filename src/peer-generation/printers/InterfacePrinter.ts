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

import * as ts from 'typescript'
import * as path from 'path'
import { PeerLibrary } from "../PeerLibrary"
import { FieldModifier, LanguageWriter, createLanguageWriter, Type } from '../LanguageWriters'
import { mapType } from '../TypeNodeNameConvertor'
import { Language, removeExt, renameDtsToInterfaces } from '../../util'
import { ImportsCollector } from '../ImportsCollector'
import { EnumEntity, PeerFile } from '../PeerFile'
import { IndentedPrinter } from "../../IndentedPrinter"
import { TargetFile } from './TargetFile'
import { PrinterContext } from './PrinterContext'
import { ARK_OBJECTBASE, ARKOALA_PACKAGE, ARKOALA_PACKAGE_PATH } from './lang/Java'

interface InterfacesVisitor {
    getInterfaces(): Map<TargetFile, LanguageWriter>
    printInterfaces(): void
}

abstract class DefaultInterfacesVisitor implements InterfacesVisitor {
    protected readonly interfaces: Map<TargetFile, LanguageWriter> = new Map()
    getInterfaces(): Map<TargetFile, LanguageWriter> {
        return this.interfaces
    }
    abstract printInterfaces(): void
}

abstract class TypeConvertor {
    public convert(writer: LanguageWriter, node: ts.Declaration) {
        if (ts.isClassDeclaration(node)) this.convertClass(writer, node)
        else if (ts.isInterfaceDeclaration(node)) this.convertInterface(writer, node)
        else if (ts.isTypeAliasDeclaration(node)) this.convertTypeAlias(writer, node)
        else throw new Error("Unknown node")
    }
    abstract convertClass(writer: LanguageWriter, node: ts.ClassDeclaration): void
    abstract convertInterface(writer: LanguageWriter, node: ts.InterfaceDeclaration): void
    abstract convertTypeAlias(writer: LanguageWriter, node: ts.TypeAliasDeclaration): void
    convertEnum(writer: LanguageWriter, enumEntity: EnumEntity) {
        writer.writeStatement(writer.makeEnumEntity(enumEntity, true))
    }
}

export class TSTypeConvertor extends TypeConvertor {
    constructor(private readonly peerLibrary: PeerLibrary) {
        super();
    }
    convertClass(writer: LanguageWriter, node: ts.ClassDeclaration): void {
        writer.print(this.convertDeclaration(node))
    }
    convertInterface(writer: LanguageWriter, node: ts.InterfaceDeclaration): void {
        writer.print(this.convertDeclaration(node))
    }

    convertTypeAlias(writer: LanguageWriter, node: ts.TypeAliasDeclaration): void {
        const maybeTypeArguments = node.typeParameters?.length
            ? `<${node.typeParameters.map(it => it.getText()).join(', ')}>`
            : ''
        let type = mapType(node.type)
        writer.print(`export declare type ${node.name.text}${maybeTypeArguments} = ${type};`)
    }

    private replaceImportTypeNodes(text: string): string {
        for (const [stub, src] of [...this.peerLibrary.importTypesStubToSource.entries()].reverse()) {
            text = text.replaceAll(src, stub)
        }
        return text
    }

    private extendsClause(node: ts.ClassDeclaration | ts.InterfaceDeclaration): string {
        if (!node.heritageClauses?.length)
            return ``
        if (node.heritageClauses!.some(it => it.token !== ts.SyntaxKind.ExtendsKeyword))
            throw "Expected to have only extend clauses"
        if (this.peerLibrary.isComponentDeclaration(node))
            // do not extend parent component interface to provide smooth integration
            return ``

        let parent = node.heritageClauses[0]!.types[0]
        return `extends ${parent.getText()}`
    }

    protected declarationName(node: ts.ClassDeclaration | ts.InterfaceDeclaration): string {
        let name = ts.idText(node.name as ts.Identifier)
        let typeParams = node.typeParameters?.map(it => it.getText()).join(', ')
        let typeParamsClause = typeParams ? `<${typeParams}>` : ``
        return `${name}${typeParamsClause}`
    }

    private convertDeclaration(node: ts.ClassDeclaration | ts.InterfaceDeclaration): string {
        if (!this.peerLibrary.isComponentDeclaration((node))) {
            return 'export ' + this.replaceImportTypeNodes(node.getText())
        }
        let printer = new IndentedPrinter()
        let className = this.declarationName(node)
        let extendsClause = this.extendsClause(node)

        let classOrInterface = ts.isClassDeclaration(node) ? `class` : `interface`
        if (this.peerLibrary.isComponentDeclaration(node))
            // because we write `ArkBlank implements BlankAttributes`
            classOrInterface = `interface`
        printer.print(`export declare ${classOrInterface} ${className} ${extendsClause} {`)
        printer.pushIndent()
        this.declarationMembers(node)
            .forEach(it => {
                printer.print(`/** @memo */`)
                printer.print(it.getText())
            })
        printer.popIndent()
        printer.print(`}`)

        return this.replaceImportTypeNodes(printer.getOutput().join('\n'))
    }

    private declarationMembers(
        node: ts.ClassDeclaration | ts.InterfaceDeclaration
    ): readonly (ts.MethodDeclaration)[] {
        if (ts.isClassDeclaration(node)) {
            const members = node.members.filter(it => !ts.isConstructorDeclaration(it))
            if (members.every(ts.isMethodDeclaration))
                return members
        }
        if (ts.isInterfaceDeclaration(node) ) {
            const members = node.members.filter(it =>
                !ts.isConstructSignatureDeclaration(it) &&
                !ts.isCallSignatureDeclaration(it))
            if (members.length === 0)
                return []
        }
        throw new Error(`Encountered component with member that is not method: ${node}`)
    }
}

class TSInterfacesVisitor extends DefaultInterfacesVisitor {
    protected readonly typeConvertor = new TSTypeConvertor(this.peerLibrary)

    constructor(protected readonly peerLibrary: PeerLibrary) {
        super()
    }

    protected generateFileBasename(originalFilename: string): string {
        return renameDtsToInterfaces(path.basename(originalFilename), this.peerLibrary.declarationTable.language)
    }

    private printImports(writer: LanguageWriter, file: PeerFile) {
        const imports = new ImportsCollector()
        file.importFeatures.forEach(it => imports.addFeature(it.feature, it.module))
        imports.print(writer, removeExt(this.generateFileBasename(file.originalFilename)))
    }

    private printAssignEnumsToGlobalScope(writer: LanguageWriter, peerFile: PeerFile) {
        if (![Language.TS, Language.ARKTS].includes(writer.language)) return
        if (peerFile.enums.length != 0) {
            writer.print(`Object.assign(globalThis, {`)
            writer.pushIndent()
            for (const enumEntity of peerFile.enums) {
                writer.print(`${enumEntity.name}: ${enumEntity.name},`)
            }
            writer.popIndent()
            writer.print(`})`)
        }
    }

    printInterfaces() {
        for (const file of this.peerLibrary.files.values()) {
            const writer = createLanguageWriter(this.peerLibrary.declarationTable.language)
            this.printImports(writer, file)
            file.declarations.forEach(it => this.typeConvertor.convert(writer, it))
            file.enums.forEach(it => this.typeConvertor.convertEnum(writer, it))
            this.printAssignEnumsToGlobalScope(writer, file)
            this.interfaces.set(new TargetFile(this.generateFileBasename(file.originalFilename)), writer)
        }
    }
}

class JavaInterfacesVisitor {
    private readonly interfaces: Map<string, LanguageWriter> = new Map()

    constructor(
        private readonly peerLibrary: PeerLibrary,
        private readonly context: PrinterContext,
    ) {}

    private addInterface(name: string, writer: LanguageWriter) {
        this.interfaces.set(name, writer)
    }

    private getName(node: ts.NamedDeclaration): string {
        if (!node.name) {
            throw new Error(`Empty name for node\n${node}`)
        }
        return node.name.getText()
    }

    private getSuperClass(node: ts.ClassDeclaration | ts.InterfaceDeclaration): string | undefined {
        if (!node.heritageClauses) {
            return
        }

        for (const clause of node.heritageClauses) {
            if (clause.token == ts.SyntaxKind.ExtendsKeyword) {
                return clause.types[0].expression.getText()
            }
        }
    }

    private printPackage(writer: LanguageWriter): void {
        writer.print(`package ${ARKOALA_PACKAGE};\n`)
    }

    private printClassOrInterface(node: ts.ClassDeclaration | ts.InterfaceDeclaration, writer: LanguageWriter) {
        const superClass = this.getSuperClass(node) ?? ARK_OBJECTBASE
        writer.writeClass(this.getName(node), () => {
            for (const property of node.members) {
                if (!ts.isPropertyDeclaration(property) && !ts.isPropertySignature(property)) {
                    continue
                }

                if (!property.type) {
                    throw new Error(`Unexpected member type: ${property.type}`);
                }

                const propertyName = this.getName(property)
                const propertyDeclarationTarget = this.peerLibrary.declarationTable.toTarget(property.type)
                const optional = !!property.questionToken
                const propertyType = this.context.synthesizedTypes!.getTargetType(propertyDeclarationTarget, optional)

                writer.writeFieldDeclaration(propertyName, propertyType, [FieldModifier.PUBLIC], optional)
            }
        }, superClass)
    }

    getInterfaces(): Map<TargetFile, LanguageWriter> {
        const result =  new Map<TargetFile, LanguageWriter>()
        for (const [name, writer] of this.interfaces) {
            result.set(new TargetFile(name, ARKOALA_PACKAGE_PATH), writer)
        }
        return result
    }

    printInterfaces() {
        for (const file of this.peerLibrary.files.values()) {
            file.declarations.forEach(it => {
                if (!ts.isClassDeclaration(it) && !ts.isInterfaceDeclaration(it)) {
                    return
                }
                const writer = createLanguageWriter(Language.JAVA)
                this.printPackage(writer);
                this.printClassOrInterface(it, writer)
                this.addInterface(this.getName(it), writer)
            })
        }
    }
}

class ArkTSTypeConvertor extends TypeConvertor {
    constructor(private readonly peerLibrary: PeerLibrary) {
        super();
    }
    convertClass(writer: LanguageWriter, node: ts.ClassDeclaration): void {

    }
    convertInterface(writer: LanguageWriter, node: ts.InterfaceDeclaration): void {
        writer.writeInterface(this.declarationName(node), writer => {
            this.peerLibrary.declarationTable.targetStruct(node).getFields().map(it => {
                let type = ts.isTupleTypeNode(it.type!!) ? this.convertTuple(it.type) : mapType(it.type)
                if (type === "any") {
                    type = "object"
                }
                writer.writeFieldDeclaration(it.name, new Type(type, it.optional), undefined, it.optional)
            })
        })
    }
    convertTypeAlias(writer: LanguageWriter, node: ts.TypeAliasDeclaration): void {
        if (ts.isTypeLiteralNode(node.type)) {
            const members = node.type.members
            writer.writeInterface(node.name.text, writer => {
                members.map(it => {
                    if (ts.isPropertySignature(it)) {
                        writer.writeFieldDeclaration(it.name?.getText(),
                            new Type(mapType(it.type), it?.questionToken != undefined), undefined, it?.questionToken != undefined)
                    }
                })
            })
        } else {
            let typeName = this.getSynthesizedTypes(node).map(it => it.type).join('|')
            if (typeName.length == 0) {
                typeName = mapType(node.type)
            }
            const maybeTypeArguments = node.typeParameters?.length
                ? `<${node.typeParameters.map(it => it.name.text).join(', ')}>` : ''
            writer.print(`export declare type ${node.name.text}${maybeTypeArguments} = ${typeName.replaceAll("any", "Object")};`)
        }
    }
    private declarationName(node: ts.ClassDeclaration | ts.InterfaceDeclaration): string {
        let name = ts.idText(node.name as ts.Identifier)
        let typeParams = node.typeParameters?.map(it => it.name.text).join(', ')
        let typeParamsClause = typeParams ? `<${typeParams}>` : ``
        return `${name}${typeParamsClause}`
    }
    getSynthesizedTypes(node: ts.TypeAliasDeclaration): {type: string, needImport: boolean}[] {
        if (ts.isUnionTypeNode(node.type)) {
            return node.type.types.map(it => {
                if (ts.isTemplateLiteralTypeNode(it)) {
                    return {type: `TEMPLATE_LITERAL_${it.templateSpans
                            .map(it => `${mapType(it.type)}_${it.literal.text}`).join('_')}`, needImport: true}
                } else if (ts.isLiteralTypeNode(it)) {
                    return {type: `LITERAL_${mapType(it).replaceAll('"', '')}`, needImport: true}
                }
                return {type: mapType(it), needImport: false}
            })
        }
        if (ts.isImportTypeNode(node.type)) {
            return [{type: `IMPORT_${node.name.text}`, needImport: true}]
        } else if (ts.isTemplateLiteralTypeNode(node.type)) {
            return [{type: `TEMPLATE_LITERAL_${node.name.text}`, needImport: true}]
        }
        return []
    }
    private convertTuple(node: ts.TupleTypeNode): string {
        return mapType(node).replaceAll("?", " | undefined")
    }
}

class ArkTSInterfacesVisitor extends DefaultInterfacesVisitor {
    private readonly typeConvertor = new ArkTSTypeConvertor(this.peerLibrary)

    constructor(private readonly peerLibrary: PeerLibrary) {
        super()
    }

    private generateFileBasename(originalFilename: string): string {
        return renameDtsToInterfaces(path.basename(originalFilename), this.peerLibrary.declarationTable.language)
    }

    private printImports(writer: LanguageWriter, file: PeerFile) {
        const imports = new ImportsCollector()
        file.importFeatures.forEach(it => imports.addFeature(it.feature, it.module))
        imports.print(writer, removeExt(this.generateFileBasename(file.originalFilename)))
    }

    override printInterfaces() {
        for (const file of this.peerLibrary.files.values()) {
            const writer = createLanguageWriter(this.peerLibrary.declarationTable.language)
            file.declarations.forEach(it => {
                if (ts.isTypeAliasDeclaration(it)) {
                    this.typeConvertor
                        .getSynthesizedTypes(it)
                        .filter(it => it.needImport)
                        .forEach(it => this.addExtraImports(file, it.type))
                }
            })
            this.addExtraImports(file, "GestureRecognizer")
            this.printImports(writer, file)
            file.enums.forEach(it => this.typeConvertor.convertEnum(writer, it))
            file.declarations.forEach(it => this.typeConvertor.convert(writer, it))
            this.interfaces.set(new TargetFile(this.generateFileBasename(file.originalFilename)), writer)
        }
    }

    private addExtraImports(file: PeerFile, feature: string) {
        file.importFeatures.push({feature: feature, module: "./dts-exports.ets"})
    }
}

function getVisitor(peerLibrary: PeerLibrary, context: PrinterContext): InterfacesVisitor | undefined {
    if (context.language == Language.TS) {
        return new TSInterfacesVisitor(peerLibrary)
    }
    if (context.language == Language.JAVA) {
        return new JavaInterfacesVisitor(peerLibrary, context)
    }
    if (context.language == Language.ARKTS) {
        return new ArkTSInterfacesVisitor(peerLibrary)
    }
}

export function printInterfaces(peerLibrary: PeerLibrary, context: PrinterContext): Map<TargetFile, string> {
    const visitor = getVisitor(peerLibrary, context)
    if (!visitor) {
        return new Map()
    }

    visitor.printInterfaces()
    const result = new Map<TargetFile, string>()
    for (const [key, writer] of visitor.getInterfaces()) {
        if (writer.getOutput().length === 0) continue
        result.set(key, writer.getOutput().join('\n'))
    }
    return result
}
