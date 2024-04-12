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

import * as ts from "typescript"
import { asString, findRealDeclarations, getDeclarationsByNode, getNameWithoutQualifiersRight, identName, mapType, throwException, typeEntityName } from "../util"
import { IndentedPrinter } from "../IndentedPrinter"
import { PeerGeneratorConfig } from "./PeerGeneratorConfig"
import { AggregateConvertor, ArgConvertor, ArrayConvertor, BooleanConvertor, CustomTypeConvertor, EnumConvertor, FunctionConvertor, ImportTypeConvertor, InterfaceConvertor, LengthConvertor, NumberConvertor, OptionConvertor, PredefinedConvertor, StringConvertor, TupleConvertor, UndefinedConvertor, UnionConvertor } from "./Convertors"

class PrimitiveType {
    constructor(public name: string) {}
    getText(): string { return this.name }
}

type DeclarationTarget =
    ts.ClassDeclaration | ts.InterfaceDeclaration | ts.EnumDeclaration
    | ts.UnionTypeNode | ts.TypeLiteralNode | ts.ImportTypeNode | ts.FunctionTypeNode | ts.TupleTypeNode
    | ts.ArrayTypeNode
    | PrimitiveType

class DeclarationRecord {
    public nameBasic: string = ""
    public nameOptional: string = ""

    constructor (public target: DeclarationTarget, private table: DeclarationTable) {}
    requestVariant(name: string, optional: boolean) {
        if (optional) {
            if (this.nameOptional.length == 0)
                this.nameOptional = name
        } else {
            if (this.nameBasic.length == 0) {
                this.nameBasic = name
            }
        }
    }
    getVariantName(optional: boolean): string {
        if (optional) {
            if (this.nameOptional.length == 0) {
                this.nameOptional = this.table.computeTargetName(this.target, optional)
            }
            // throw new Error(`Not defined optional name for ${this.target.getText()}`)
            return this.nameOptional
        } else {
            if (this.nameBasic.length == 0)
                throw new Error(`Not defined basic name ${this.target.getText()}`)
            return this.nameBasic
        }
    }
}

export class DeclarationTable {
    declarations = new Set<DeclarationTarget>()
    typeMap = new Map<ts.TypeNode, DeclarationRecord>()
    typeChecker: ts.TypeChecker | undefined = undefined
    constructor() {}

    getTypeName(type: ts.TypeNode, optional: boolean = false) {
        let declaration: DeclarationRecord|undefined = this.typeMap.get(type)
        if (!declaration) {
            this.requestType(undefined, type, optional)
        }
        declaration = this.typeMap.get(type)!
        return declaration.getVariantName(optional)
    }

    requestType(name: string|undefined, type: ts.TypeNode, optional: boolean = false) {
        let declaration: DeclarationRecord|undefined = this.typeMap.get(type)
        if (!name) name = this.computeTypeName(type, optional)
        if (declaration) {
            declaration.requestVariant(name, optional)
            return
        }
        let target = this.findDeclaration(type)
        if (!target) throw new Error(`Cannot find declaration: ${type.getText()}`)
        this.declarations.add(target)
        let record = new DeclarationRecord(target, this)
        record.requestVariant(name, optional)
        this.typeMap.set(type, record)
    }

    findDeclaration(type: ts.TypeNode): DeclarationTarget | undefined {
        if (ts.isUnionTypeNode(type)) return type
        if (ts.isTypeLiteralNode(type)) return type
        if (ts.isImportTypeNode(type)) return type
        if (ts.isTupleTypeNode(type)) return type
        if (ts.isArrayTypeNode(type)) return type
        if (ts.isTypeReferenceNode(type)) {
            let declarations = getDeclarationsByNode(this.typeChecker!, type.typeName)
            while (declarations.length > 0 && ts.isTypeAliasDeclaration(declarations[0])) {
                type = declarations[0].type
                declarations = getDeclarationsByNode(this.typeChecker!, declarations[0].type) ?? []
            }
            if (ts.isUnionTypeNode(type)) return type
            if (ts.isTypeLiteralNode(type)) return type
            if (ts.isImportTypeNode(type)) return type
            if (ts.isFunctionTypeNode(type)) return type
            if (declarations.length == 0) throw new Error(`Cannot find declaration for ${type.getText()}: ${type.kind}`)
            let decl = declarations[0]
            if (ts.isClassDeclaration(decl) ||
                ts.isInterfaceDeclaration(decl) ||
                ts.isEnumDeclaration(decl)) return decl
            throw new Error(`Wrong declaration: ${decl.getText()}`)
        }
        if (type.kind == ts.SyntaxKind.BooleanKeyword)
            return new PrimitiveType(`Boolean`)
        if (type.kind == ts.SyntaxKind.NumberKeyword)
            return new PrimitiveType(`Number`)
        if (type.kind == ts.SyntaxKind.StringKeyword)
            return new PrimitiveType(`String`)
        if (ts.isFunctionTypeNode(type))
            return new PrimitiveType(`Function`)
        throw new Error(`Unknown type: ${type.getText()} ${asString(type)}`)
    }

    computeTypeName(type: ts.TypeNode, optional: boolean = false): string {
        let name = this.computeTypeNameImpl(type, optional)
        this.requestType(name, type, optional)
        return name
    }

    computeTargetName(target: DeclarationTarget, optional: boolean): string {
        const prefix = optional ? "Optional_" : ""
        if (target instanceof PrimitiveType) {
            return prefix + target.getText()
        }
        if (ts.isTypeLiteralNode(target)) {
            return prefix + `Literal_${target.members.map(member => {
                if (ts.isPropertySignature(member)) {
                    return this.computeTypeNameImpl(member.type!, member.questionToken != undefined)
                } else {
                    return undefined
                }
            })
            .filter(it => it != undefined)
            .join("_")}`
        }
        if (ts.isUnionTypeNode(target)) {
            return prefix + `Union_${target.types.map(it => this.computeTypeNameImpl(it, optional)).join("_")}`
        }
        if (ts.isInterfaceDeclaration(target) || ts.isClassDeclaration(target)) {
            return prefix + identName(target.name)
        }
        throw new Error(`Cannot compute target name: ${target.getText()}`)
    }

    private computeTypeNameImpl(type: ts.TypeNode, optional: boolean): string {
        const prefix = optional ? "Optional_" : ""
        if (ts.isImportTypeNode(type)) {
            return prefix + identName(type.qualifier)!
        }
        if (ts.isTypeReferenceNode(type)) {
            return prefix + identName(type.typeName)!
        }
        if (ts.isUnionTypeNode(type)) {
            return prefix + `Union_${type.types.map(it => this.computeTypeNameImpl(it, optional)).join("_")}`
        }
        if (ts.isOptionalTypeNode(type)) {
            return "Optional_" +  this.computeTypeNameImpl(type.type, false)
        }
        if (ts.isTupleTypeNode(type)) {
            return prefix + `Tuple_${type.elements.map(it => this.computeTypeNameImpl(it, optional)).join("_")}`
        }
        if (ts.isParenthesizedTypeNode(type)) {
            return this.computeTypeNameImpl(type.type!, optional)
        }
        if (ts.isTypeLiteralNode(type)) {
            return prefix + `Literal_${type.members.map(member => {
                if (ts.isPropertySignature(member)) {
                    return this.computeTypeNameImpl(member.type!, member.questionToken != undefined)
                } else {
                    return undefined
                }
            })
            .filter(it => it != undefined)
            .join("_")}`
        }
        if (ts.isFunctionTypeNode(type)) {
            return prefix + "Function"
        }
        if (ts.isArrayTypeNode(type)) {
            return prefix + `Array_` + this.computeTypeNameImpl(type.elementType, false)
        }
        if (type.kind == ts.SyntaxKind.NumberKeyword) {
            return prefix + `Number`
        }
        if (type.kind == ts.SyntaxKind.UndefinedKeyword) {
            return `Undefined`
        }
        if (type.kind == ts.SyntaxKind.StringKeyword) {
            return prefix + `String`
        }
        if (type.kind == ts.SyntaxKind.BooleanKeyword) {
            return prefix + `Boolean`
        }
        throw new Error(`Cannot compute type name: ${type.getText()}`)
    }

    serializerName(name: string, type: ts.TypeNode): string {
        this.requestType(name, type)
        return `write${name}`
    }

    deserializerName(name: string, type: ts.TypeNode): string {
        this.requestType(name, type)
        return `read${name}`
    }

    typeConvertor(param: string, type: ts.TypeNode, isOptionalParam = false): ArgConvertor {
        if (isOptionalParam) {
            return new OptionConvertor(param, this, type)
        }
        if (type.kind == ts.SyntaxKind.ObjectKeyword) {
            return new CustomTypeConvertor(param, "Object")
        }
        if (type.kind == ts.SyntaxKind.UndefinedKeyword || type.kind == ts.SyntaxKind.VoidKeyword) {
            return new UndefinedConvertor(param)
        }
        if (type.kind == ts.SyntaxKind.NullKeyword) {
            throw new Error("Unsupported null")
        }
        if (type.kind == ts.SyntaxKind.NumberKeyword) {
            return new NumberConvertor(param)
        }
        if (type.kind == ts.SyntaxKind.StringKeyword) {
            return new StringConvertor(param)
        }
        if (type.kind == ts.SyntaxKind.BooleanKeyword) {
            return new BooleanConvertor(param)
        }
        if (ts.isImportTypeNode(type)) {
            return new ImportTypeConvertor(param, this, type)
        }
        if (ts.isTypeReferenceNode(type)) {
            const declaration = getDeclarationsByNode(this.typeChecker!, type.typeName)[0]
            return this.declarationConvertor(param, type, declaration)
        }
        if (ts.isUnionTypeNode(type)) {
            return new UnionConvertor(param, this, type)
        }
        if (ts.isTypeLiteralNode(type)) {
            return new AggregateConvertor(param, this, type)
        }
        if (ts.isArrayTypeNode(type)) {
            return new ArrayConvertor(param, this, type.elementType)
        }
        if (ts.isLiteralTypeNode(type)) {
            if (type.literal.kind == ts.SyntaxKind.NullKeyword) {
                return new UndefinedConvertor(param)
            }
            if (type.literal.kind == ts.SyntaxKind.StringLiteral) {
                return new StringConvertor(param)
            }
            throw new Error(`Unsupported literal type: ${type.literal.kind}` + type.getText())
        }
        if (ts.isTupleTypeNode(type)) {
            return new TupleConvertor(param, this, type)
        }
        if (ts.isFunctionTypeNode(type)) {
            return new FunctionConvertor(param, this)
        }
        if (ts.isParenthesizedTypeNode(type)) {
            return this.typeConvertor(param, type.type)
        }
        if (ts.isOptionalTypeNode(type)) {
            return new OptionConvertor(param, this, type.type)
        }
        if (ts.isTemplateLiteralTypeNode(type)) {
            return new StringConvertor(param)
        }
        if (ts.isNamedTupleMember(type)) {
            return this.typeConvertor(param, type.type)
        }
        if (type.kind == ts.SyntaxKind.AnyKeyword) {
            return new CustomTypeConvertor(param, "Any")
        }
        console.log(type)
        throw new Error(`Cannot convert: ${asString(type)} ${type.getText()}`)
    }

    customConvertor(typeName: ts.EntityName | undefined, param: string, type: ts.TypeReferenceNode | ts.ImportTypeNode): ArgConvertor | undefined {
        let name = getNameWithoutQualifiersRight(typeName)
        if (name === "Length") return new LengthConvertor(param)
        if (name === "AnimationRange")
            return new PredefinedConvertor(param, "AnimationRange<number>", "AnimationRange", "Compound<Number, Number>")
        if (name === "AttributeModifier")
            return new PredefinedConvertor(param, "AttributeModifier<any>", "AttributeModifier", "Tagged<CustomObject>")
        if (name === "ContentModifier")
            return new PredefinedConvertor(param, "ContentModifier<any>", "ContentModifier", "Tagged<CustomObject>")
        if (name === "Array")
            return new ArrayConvertor(param, this, type.typeArguments![0])
        if (name === "Callback")
            return new CustomTypeConvertor(param, "Callback")
        if (name === "Optional")
            return new CustomTypeConvertor(param, "Optional")
        return undefined
    }

    declarationConvertor(param: string, type: ts.TypeReferenceNode, declaration: ts.NamedDeclaration | undefined): ArgConvertor {
        const entityName = typeEntityName(type)
        if (!declaration) {
            return this.customConvertor(entityName, param, type) ?? throwException(`Declaration not found for: ${type.getText()}`)
        }
        const declarationName = ts.idText(declaration.name as ts.Identifier)

        let customConvertor = this.customConvertor(entityName, param, type)
        if (customConvertor) {
            return customConvertor
        }
        if (ts.isTypeReferenceNode(type) && entityName && ts.isQualifiedName(entityName)) {
            const typeOuter = ts.factory.createTypeReferenceNode(entityName.left)
            return new EnumConvertor(param, typeOuter, this)
        }
        if (ts.isEnumDeclaration(declaration)) {
            return new EnumConvertor(param, type, this)
        }
        if (ts.isTypeAliasDeclaration(declaration)) {
            this.requestType(declarationName, type)
            return this.typeConvertor(param, declaration.type)
        }
        if (ts.isInterfaceDeclaration(declaration)) {
            return new InterfaceConvertor(declarationName, param, this, type)
        }
        if (ts.isClassDeclaration(declaration)) {
            return new InterfaceConvertor(declarationName, param, this, type)
        }
        if (ts.isTypeParameterDeclaration(declaration)) {
            console.log(declaration.getText())
            return new CustomTypeConvertor(param, identName(declaration.name)!)
        }
        console.log(`${declaration.getText()}`)
        throw new Error(`Unknown kind: ${declaration.kind}`)
    }

    generateSerializers(printer: IndentedPrinter) {
        let seenNames = new Set<string>()
        for (let x of this.typeMap.values()) {
            if (seenNames.has(x.nameBasic)) continue
            seenNames.add(x.nameBasic)
            this.generateSerializer(x.nameBasic, x.target, printer)
        }
    }

    private generateSerializer(name: string, target: DeclarationTarget, printer: IndentedPrinter) {
        if (PeerGeneratorConfig.ignoreSerialization.includes(name)) return
        if (target instanceof PrimitiveType) return
        if (ts.isEnumDeclaration(target)) return
        printer.pushIndent()
        printer.print(`write${name}(value: ${name}|undefined) {`)
        printer.pushIndent()
        printer.print(`const valueSerializer = this`)
        printer.print(`if (undefined === value) { valueSerializer.writeInt8(Tags.UNDEFINED); return }`)
        if (ts.isInterfaceDeclaration(target) || ts.isClassDeclaration(target)) {

        } else {
            printer.print(`valueSerializer.writeInt8(Tags.OBJECT)`)
            let typeConvertor = this.typeConvertor("value", target, false)
            typeConvertor.convertorToTSSerial(`value`, `value`, printer)
        }
        printer.popIndent()
        printer.print(`}`)
        printer.popIndent()
    }
}