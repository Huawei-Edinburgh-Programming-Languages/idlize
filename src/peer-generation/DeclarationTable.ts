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
import { SortingEmitter } from "./SortingEmitter"

class PrimitiveType {
    constructor(public name: string) {}
    getText(): string { return this.name }
}

export type DeclarationTarget =
    ts.ClassDeclaration | ts.InterfaceDeclaration | ts.EnumDeclaration
    | ts.UnionTypeNode | ts.TypeLiteralNode | ts.ImportTypeNode | ts.FunctionTypeNode | ts.TupleTypeNode
    | ts.ArrayTypeNode
    | PrimitiveType

class DeclarationRecord {
    public nameBasic: string
    public nameOptional: string

    constructor (public target: DeclarationTarget, private table: DeclarationTable) {
        this.nameBasic = table.computeTargetName(target, false)
        this.nameOptional = table.computeTargetName(target, true)
    }
    getVariantName(optional: boolean): string {
        if (optional) {
            return this.nameOptional
        } else {
            return this.nameBasic
        }
    }
}

class FieldRecord {
    constructor(public typeName: string, public type: ts.TypeNode | undefined, public name: string, public optional: boolean = false) {}
}

export class DeclarationTable {
    declarations = new Map<DeclarationTarget, DeclarationRecord>()
    typeMap = new Map<ts.TypeNode, [DeclarationTarget, string]>()
    typeChecker: ts.TypeChecker | undefined = undefined
    constructor() {}

    getTypeName(type: ts.TypeNode, optional: boolean = false) {
        let declaration  = this.typeMap.get(type)
        if (!declaration) {
            this.requestType(undefined, type, optional)
        }
        declaration = this.typeMap.get(type)!
        return declaration[1]
    }

    requestType(name: string|undefined, type: ts.TypeNode, optional: boolean = false) {
        let declaration = this.typeMap.get(type)
        if (declaration) {
            if (name && name != declaration[1])
                throw new Error(`Mismatch of names${optional ? "[optional]" : ""}: ${name} ${declaration[1]}`)
            return
        }
        name = this.computeTypeName(name, type, optional)
        let target = this.findDeclaration(type)
        if (!target) throw new Error(`Cannot find declaration: ${type.getText()}`)
        this.declarations.set(target, new DeclarationRecord(target, this))
        this.typeMap.set(type, [target, name])
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
            return new PrimitiveType(`Object`)
        throw new Error(`Unknown type: ${type.getText()} ${asString(type)}`)
    }

    computeTypeName(suggestedName: string|undefined, type: ts.TypeNode, optional: boolean = false): string {
        let name = this.computeTypeNameImpl(suggestedName, type, optional)
        //this.requestType(name, type, optional)
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
                    return this.computeTypeNameImpl(undefined, member.type!, member.questionToken != undefined)
                } else {
                    return undefined
                }
            })
            .filter(it => it != undefined)
            .join("_")}`
        }
        if (ts.isEnumDeclaration(target)) {
            return prefix + identName(target.name)
        }
        if (ts.isUnionTypeNode(target)) {
            return prefix + `Union_${target.types.map(it => this.computeTypeNameImpl(undefined, it, optional)).join("_")}`
        }
        if (ts.isInterfaceDeclaration(target) || ts.isClassDeclaration(target)) {
            return prefix + identName(target.name)
        }
        if (ts.isFunctionTypeNode(target)) {
            return "Function"
        }
        if (ts.isTupleTypeNode(target)) {
            return prefix + `Tuple_${target.elements.map(it => {
                if (ts.isNamedTupleMember(it)) {
                    return this.computeTypeNameImpl(undefined, it, it.questionToken != undefined)
                } else {
                    return this.computeTypeNameImpl(undefined, it, false)
                }
            }).join("_")}`
        }
        if (ts.isArrayTypeNode(target)) {
            return prefix + `Array_` + this.computeTypeNameImpl(undefined, target.elementType, false)
        }
        if (ts.isImportTypeNode(target)) {
            return prefix + identName(target.qualifier)!
        }

        throw new Error(`Cannot compute target name: ${target}`)
    }

    private computeTypeNameImpl(suggestedName: string|undefined, type: ts.TypeNode, optional: boolean): string {
        const prefix = optional ? "Optional_" : ""
        if (ts.isImportTypeNode(type)) {
            return prefix + identName(type.qualifier)!
        }
        if (ts.isTypeReferenceNode(type)) {
            return prefix + identName(type.typeName)!
        }
        if (ts.isUnionTypeNode(type)) {
            if (suggestedName) return suggestedName
            return prefix + `Union_${type.types.map(it => this.computeTypeNameImpl(undefined, it, optional)).join("_")}`
        }
        if (ts.isOptionalTypeNode(type)) {
            if (suggestedName) return suggestedName
            return "Optional_" +  this.computeTypeNameImpl(undefined, type.type, false)
        }
        if (ts.isTupleTypeNode(type)) {
            if (suggestedName) return suggestedName
            return prefix + `Tuple_${type.elements.map(it => this.computeTypeNameImpl(undefined, it, optional)).join("_")}`
        }
        if (ts.isParenthesizedTypeNode(type)) {
            return this.computeTypeNameImpl(suggestedName, type.type!, optional)
        }
        if (ts.isTypeLiteralNode(type)) {
            if (suggestedName) return suggestedName
            return prefix + `Literal_${type.members.map(member => {
                if (ts.isPropertySignature(member)) {
                    return this.computeTypeNameImpl(undefined, member.type!, member.questionToken != undefined)
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
            if (suggestedName) return suggestedName
            return prefix + `Array_` + this.computeTypeNameImpl(undefined, type.elementType, false)
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

    generateDeserializers(printer: IndentedPrinter, structs: SortingEmitter) {
        let seenNames = new Set<string>()
        printer.print(`class Deserializer : public ArgDeserializerBase {`)
        printer.print(` public:`)
        printer.pushIndent()
        printer.print(`Deserializer(uint8_t *data, int32_t length) : ArgDeserializerBase(data, length) {}`)

        for (let x of this.declarations.values()) {
            if (seenNames.has(x.nameBasic)) continue
            seenNames.add(x.nameBasic)
            this.generateDeserializer(x.nameBasic, x.target, printer)
        }
        printer.popIndent()
        printer.print(`};`)
        seenNames.clear()
        for (let x of this.declarations.values()) {
            if (seenNames.has(x.nameBasic)) continue
            if (this.ignoreTarget(x.target)) continue
            seenNames.add(x.nameBasic)
            structs.startEmit(this, x.target)
            structs.print(`struct ${x.nameBasic} {`)
            structs.pushIndent()
            this.targetFields(x.target).forEach((it, index) => {
                structs.print(`${it.typeName} ${it.name};`)
            })
            structs.popIndent()
            structs.print(`};`)
            structs.print(`struct ${x.nameOptional} {`)
            structs.pushIndent()
            structs.print(`int32_t tag;`)
            this.targetFields(x.target).forEach((it, index) => {
                structs.print(`${it.typeName} ${it.name};`)
            })
            structs.popIndent()
            structs.print(`};`)
        }
        for (let x of this.typeMap.values()) {
            let record = this.declarations.get(x[0])!
            if (seenNames.has(x[1])) continue
            if (PeerGeneratorConfig.ignoreSerialization.includes(x[1])) continue
            seenNames.add(x[1])
            structs.print(`typedef ${record.nameBasic} ${x[1]};`)
        }
    }

    generateSerializers(printer: IndentedPrinter) {
        let seenNames = new Set<string>()
        printer.print(`export class Serializer extends SerializerBase {`)
        printer.pushIndent()
        for (let x of this.declarations.values()) {
            if (seenNames.has(x.nameBasic)) continue
            seenNames.add(x.nameBasic)
            if (x.target instanceof PrimitiveType) continue
            if (ts.isInterfaceDeclaration(x.target) || ts.isClassDeclaration(x.target))
                this.generateSerializer(x.nameBasic, x.target, printer)
        }
        printer.popIndent()
        printer.print(`}`)
    }


    private targetFields(target: DeclarationTarget): FieldRecord[] {
        let result: FieldRecord[]  = []
        if (target instanceof PrimitiveType) {
            result.push(new FieldRecord(target.name, undefined, "value"))
            return result
        }
        if (ts.isInterfaceDeclaration(target)) {
            target
                .members
                .filter(ts.isPropertySignature)
                .forEach(it => {
                    let typeName = this.computeTypeName(undefined, it.type!, false)
                    result.push(new FieldRecord(typeName, it.type!, identName(it.name)!, it.questionToken != undefined))
                })
        }
        if (ts.isClassDeclaration(target)) {
            target
                .members
                .filter(ts.isPropertyDeclaration)
                .forEach(it => {
                    let typeName = this.computeTypeName(undefined, it.type!, false)
                    result.push(new FieldRecord(typeName, it.type!, identName(it.name)!, it.questionToken != undefined))
                })
        }
        if (ts.isUnionTypeNode(target)) {
            result.push(new FieldRecord("int32_t", undefined, `selector`, false))
            target
                .types
                .forEach((it, index) => {
                    let typeName = this.computeTypeName(undefined, it, false)
                    result.push(new FieldRecord(typeName, it, `value${index}`, false))
                })
        }
        if (ts.isTypeLiteralNode(target)) {
            target
                .members
                .filter(ts.isPropertySignature)
                .forEach(it => {
                    let typeName = this.computeTypeName(undefined, it.type!, false)
                    result.push(new FieldRecord(typeName, it.type, identName(it.name)!, it.questionToken != undefined))
                })
        }
        if (ts.isTupleTypeNode(target)) {
            target
                .elements
                .forEach((it, index) => {
                    if (ts.isNamedTupleMember(it)) {
                        let typeName = this.computeTypeName(undefined, it.type!, false)
                        result.push(new FieldRecord(typeName, it.type!, identName(it.name)!, it.questionToken != undefined))
                    } else {
                        let typeName = this.computeTypeName(undefined, it, false)
                        result.push(new FieldRecord(typeName, it, `value${index}`, false))
                    }
                })
        }
        return result
    }

    private generateSerializer(name: string, target: DeclarationTarget, printer: IndentedPrinter) {
        if (this.ignoreTarget(target)) return
        printer.pushIndent()
        printer.print(`write${name}(value: ${name}|undefined) {`)
        printer.pushIndent()
        printer.print(`const valueSerializer = this`)
        printer.print(`if (undefined === value) { valueSerializer.writeInt8(Tags.UNDEFINED); return }`)
        printer.print(`valueSerializer.writeInt8(Tags.OBJECT)`)
        if (ts.isInterfaceDeclaration(target) || ts.isClassDeclaration(target)) {
            let fields = this.targetFields(target)
            fields.forEach(it => {
                let field = `value_${it.name}`
                printer.print(`let ${field} = value.${it.name}`)
                let typeConvertor = this.typeConvertor(`value`, it.type!, it.optional)
                typeConvertor.convertorToTSSerial(`value`, field, printer)
            })
        } else {
            let typeConvertor = this.typeConvertor("value", target, false)
            typeConvertor.convertorToTSSerial(`value`, `value`, printer)
        }
        printer.popIndent()
        printer.print(`}`)
        printer.popIndent()
    }

    private ignoreTarget(target: DeclarationTarget): boolean {
        if (PeerGeneratorConfig.ignoreSerialization.includes(this.computeTargetName(target, false))) return true
        if (target instanceof PrimitiveType) return true
        if (ts.isEnumDeclaration(target)) return true
        return false
    }

    private generateDeserializer(name: string, target: DeclarationTarget, printer: IndentedPrinter) {
        if (this.ignoreTarget(target)) return
        printer.print(`${name} read${name}() {`)
        printer.pushIndent()
        printer.print(`auto valueSerializer = *this;`)
        if (ts.isInterfaceDeclaration(target) || ts.isClassDeclaration(target)) {
            let fields = this.targetFields(target)
            fields.forEach(it => {
                let typeConvertor = this.typeConvertor(`value`, it.type!, it.optional)
                typeConvertor.convertorToCDeserial(`value`, `value.${it.name}`, printer)
            })
        } else {
            let typeConvertor = this.typeConvertor("value", target, false)
            typeConvertor.convertorToCDeserial(`value`, `value`, printer)
        }
        printer.print(`return value;`)
        printer.popIndent()
        printer.print(`}`)
    }
}