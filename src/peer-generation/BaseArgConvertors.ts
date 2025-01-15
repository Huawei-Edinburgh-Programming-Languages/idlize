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

import * as idl from "@idlize/core/idl"
import { Language, warn } from "@idlize/core"
import { LanguageExpression, LanguageStatement, LanguageWriter } from "./LanguageWriters"
import { IDLNodeToStringConvertor } from "./LanguageWriters/convertors/InteropConvertor"
import { CppIDLNodeToStringConvertor } from "./LanguageWriters/convertors/CppConvertors"
import { createEmptyReferenceResolver } from "./ReferenceResolver"

export enum RuntimeType {
    UNEXPECTED = -1,
    NUMBER = 1,
    STRING = 2,
    OBJECT = 3,
    BOOLEAN = 4,
    UNDEFINED = 5,
    BIGINT = 6,
    FUNCTION = 7,
    SYMBOL = 8,
    MATERIALIZED = 9,
}

export type ExpressionAssigneer = (expression: LanguageExpression) => LanguageStatement

export interface ArgConvertor { // todo:
    param: string
    idlType: idl.IDLType
    isScoped: boolean
    useArray: boolean
    runtimeTypes: RuntimeType[]
    isOut?: true
    convertorArg(param: string, writer: LanguageWriter): string
    convertorSerialize(param: string, value: string, writer: LanguageWriter): void
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement
    interopType(): idl.IDLType
    nativeType(): idl.IDLType
    targetType(writer: LanguageWriter): string
    isPointerType(): boolean
    unionDiscriminator(value: string, index: number, writer: LanguageWriter, duplicates: Set<string>): LanguageExpression|undefined
    getMembers(): string[]
    getObjectAccessor(languge: Language, value: string, args?: Record<string, string>, writer?: LanguageWriter): string
}

export abstract class BaseArgConvertor implements ArgConvertor {
    constructor(
        public idlType: idl.IDLType,
        public runtimeTypes: RuntimeType[],
        public isScoped: boolean,
        public useArray: boolean,
        public param: string
    ) { }

    nativeType(): idl.IDLType {
        throw new Error("Define")
    }
    isPointerType(): boolean {
        throw new Error("Define")
    }
    interopType(): idl.IDLType {
        throw new Error("Define")
    }
    targetType(writer: LanguageWriter): string {
        return writer.getNodeName(this.idlType)
    }
    abstract convertorArg(param: string, writer: LanguageWriter): string
    abstract convertorSerialize(param: string, value: string, writer: LanguageWriter): void
    abstract convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement
    unionDiscriminator(value: string, index: number, writer: LanguageWriter, duplicates: Set<string>): LanguageExpression|undefined {
        return undefined
    }
    getMembers(): string[] { return [] }
    getObjectAccessor(language: Language, value: string, args?: Record<string, string>, writer?: LanguageWriter): string {
        if (writer) return writer.getObjectAccessor(this, value, args)
        return this.useArray && args?.index ? `${value}[${args.index}]` : value
    }
    protected discriminatorFromFields<T>(value: string,
                                         writer: LanguageWriter,
                                         uniqueFields: T[] | undefined,
                                         nameAccessor: (field: T) => string,
                                         optionalAccessor: (field: T) => boolean,
                                         duplicates: Set<string>){
        if (!uniqueFields || uniqueFields.length === 0) return undefined
        const firstNonOptional = uniqueFields.find(it => !optionalAccessor(it))
        return writer.discriminatorFromExpressions(value, RuntimeType.OBJECT, [
            writer.makeDiscriminatorFromFields(this,
                value,
                firstNonOptional ? [nameAccessor(firstNonOptional)] : uniqueFields.map(it => nameAccessor(it)),
                duplicates)
        ])
    }
}

export class ProxyConvertor extends BaseArgConvertor {
    constructor(public convertor: ArgConvertor, suggestedName?: string) {
        super(suggestedName ? idl.createReferenceType(suggestedName) : convertor.idlType, convertor.runtimeTypes, convertor.isScoped, convertor.useArray, convertor.param)
    }
    convertorArg(param: string, writer: LanguageWriter): string {
        return this.convertor.convertorArg(param, writer)
    }
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        return this.convertor.convertorDeserialize(bufferName, deserializerName, assigneer, writer)
    }
    convertorSerialize(param: string, value: string, printer: LanguageWriter): void {
        this.convertor.convertorSerialize(param, value, printer)
    }
    nativeType(): idl.IDLType {
        return this.convertor.nativeType()
    }
    interopType(): idl.IDLType {
        return this.convertor.interopType()
    }
    isPointerType(): boolean {
        return this.convertor.isPointerType()
    }
    unionDiscriminator(value: string, index: number, writer: LanguageWriter, duplicates: Set<string>): LanguageExpression | undefined {
        return this.convertor.unionDiscriminator(value, index, writer, duplicates)
    }
    getMembers(): string[] {
        return this.convertor.getMembers()
    }
}

export class BooleanConvertor extends BaseArgConvertor {
    constructor(param: string) {
        super(idl.IDLBooleanType, [RuntimeType.BOOLEAN], false, false, param)
    }
    convertorArg(param: string, writer: LanguageWriter): string {
        return writer.castToBoolean(param)
    }
    convertorSerialize(param: string, value: string, printer: LanguageWriter): void {
        printer.writeMethodCall(`${param}Serializer`, "writeBoolean", [value])
    }
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        return assigneer(writer.makeString(`${deserializerName}.readBoolean()`))
    }
    nativeType(): idl.IDLType {
        return idl.IDLBooleanType
    }
    interopType(): idl.IDLType {
        return idl.IDLBooleanType
    }
    isPointerType(): boolean {
        return false
    }
}

export class UndefinedConvertor extends BaseArgConvertor {
    constructor(param: string) {
        super(idl.IDLUndefinedType, [RuntimeType.UNDEFINED], false, false, param)
    }
    convertorArg(param: string, writer: LanguageWriter): string {
        return writer.makeUndefined().asString()
    }
    convertorSerialize(param: string, value: string, printer: LanguageWriter): void {}
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        return assigneer(writer.makeUndefined())
    }
    nativeType(): idl.IDLType {
        return idl.IDLUndefinedType
    }
    interopType(): idl.IDLType {
        return idl.IDLUndefinedType
    }
    isPointerType(): boolean {
        return false
    }
}

export class VoidConvertor extends UndefinedConvertor {
    convertorArg(param: string, writer: LanguageWriter): string {
        return writer.makeVoid().asString()
    }
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        return assigneer(writer.makeVoid())
    }
    nativeType(): idl.IDLType {
        return idl.IDLVoidType
    }
}

export class NumberConvertor extends BaseArgConvertor {
    private readonly cppNameConvertor = new CppIDLNodeToStringConvertor(createEmptyReferenceResolver())
    constructor(param: string) {
        // TODO: as we pass tagged values - request serialization to array for now.
        // Optimize me later!
        super(idl.IDLNumberType, [RuntimeType.NUMBER], false, false, param)
    }
    convertorArg(param: string, writer: LanguageWriter): string {
        const nativeType = this.cppNameConvertor.convert(this.idlType)
        return writer.language == Language.CPP ?  `(const ${nativeType}*)&${param}` : param
    }
    convertorSerialize(param: string, value: string, printer: LanguageWriter): void {
        printer.writeMethodCall(`${param}Serializer`, "writeNumber", [value])
    }
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        return assigneer(writer.makeCast(
            writer.makeString(`${deserializerName}.readNumber()`),
            this.idlType, { optional: false })
        )
    }
    nativeType(): idl.IDLType {
        return idl.IDLNumberType
    }
    interopType(): idl.IDLType {
        return idl.IDLNumberType
    }
    isPointerType(): boolean {
        return true
    }
}

export class NumericConvertor extends BaseArgConvertor {
    private readonly interopNameConvertor = new IDLNodeToStringConvertor(createEmptyReferenceResolver())
    constructor(param: string, type: idl.IDLPrimitiveType) {
        // check numericPrimitiveTypes.include(type)
        super(type, [RuntimeType.NUMBER], false, false, param)
    }
    convertorArg(param: string, writer: LanguageWriter): string {
        return param
    }
    convertorSerialize(param: string, value: string, printer: LanguageWriter): void {
        printer.writeMethodCall(`${param}Serializer`, `write${this.interopNameConvertor.convert(this.idlType)}`, [value])
    }
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        return assigneer(
            writer.makeString(`${deserializerName}.read${this.interopNameConvertor.convert(this.idlType)}()`)
        )
    }
    nativeType(): idl.IDLType {
        return this.idlType
    }
    interopType(): idl.IDLType {
        return this.idlType
    }
    isPointerType(): boolean {
        return false
    }
}

export class PointerConvertor extends BaseArgConvertor {
    constructor(param: string) {
        // check numericPrimitiveTypes.include(type)
        super(idl.IDLPointerType, [RuntimeType.NUMBER, RuntimeType.OBJECT], false, false, param)
    }
    convertorArg(param: string, writer: LanguageWriter): string {
        return param
    }
    convertorSerialize(param: string, value: string, printer: LanguageWriter): void {
        printer.writeMethodCall(`${param}Serializer`, `writePointer`, [value])
    }
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        return assigneer(
            writer.makeString(`${deserializerName}.readPointer()`)
        )
    }
    nativeType(): idl.IDLType {
        return this.idlType
    }
    interopType(): idl.IDLType {
        return this.idlType
    }
    isPointerType(): boolean {
        return false
    }
}

export class BufferConvertor extends BaseArgConvertor {
    constructor(param: string) {
        super(idl.IDLBufferType, [RuntimeType.OBJECT], false, true, param)
    }
    convertorArg(param: string, _: LanguageWriter): string {
        return param
    }
    convertorSerialize(param: string, value: string, printer: LanguageWriter): void {
        printer.writeMethodCall(`${param}Serializer`, "writeBuffer", [value])
    }
    convertorDeserialize(_: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        return assigneer(writer.makeCast(
            writer.makeString(`${deserializerName}.readBuffer()`),
            this.idlType, { optional: false })
        )
    }
    nativeType(): idl.IDLType {
        return idl.IDLBufferType
    }
    interopType(): idl.IDLType {
        return idl.IDLBufferType
    }
    isPointerType(): boolean {
        return true
    }
    override unionDiscriminator(value: string, index: number, writer: LanguageWriter, duplicates: Set<string>): LanguageExpression | undefined {
        return writer.instanceOf(this, value);
    }
}

export class StringConvertor extends BaseArgConvertor {
    private literalValue?: string
    private readonly cppNameConvertor = new CppIDLNodeToStringConvertor(createEmptyReferenceResolver())
    constructor(param: string) {
        super(idl.IDLStringType, [RuntimeType.STRING], false, false, param)
    }
    convertorArg(param: string, writer: LanguageWriter): string {
        const nativeType = this.cppNameConvertor.convert(this.idlType)
        return writer.language == Language.CPP ? `(const ${nativeType}*)&${param}` : param
    }
    convertorSerialize(param: string, value: string, writer: LanguageWriter): void {
        writer.writeMethodCall(`${param}Serializer`, `writeString`, [value])
    }
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        return assigneer(writer.makeCast(
            writer.makeString(`${deserializerName}.readString()`),
            this.idlType, { optional: false }
        ))
    }
    nativeType(): idl.IDLType {
        return idl.IDLStringType
    }
    interopType(): idl.IDLType {
        return idl.IDLStringType
    }
    isPointerType(): boolean {
        return true
    }
    override unionDiscriminator(value: string, index: number, writer: LanguageWriter, duplicates: Set<string>): LanguageExpression | undefined {
        return this.literalValue
            ? writer.makeString(`${value} === "${this.literalValue}"`)
            : undefined
    }
    targetType(writer: LanguageWriter): string {
        if (this.literalValue) {
            return writer.getNodeName(idl.IDLStringType)
        }
        return super.targetType(writer);
    }
}

export class EnumConvertor extends BaseArgConvertor { //
    constructor(param: string,
                public enumEntry: idl.IDLEnum,
                public readonly isStringEnum: boolean) {
        super(idl.createReferenceType(enumEntry.name),
            [isStringEnum ? RuntimeType.STRING : RuntimeType.NUMBER],
            false, false, param)
    }
    convertorArg(param: string, writer: LanguageWriter): string {
        return writer.makeEnumCast(param, false, this)
    }
    convertorSerialize(param: string, value: string, writer: LanguageWriter): void {
        value =
            this.isStringEnum
                ? writer.ordinalFromEnum(writer.makeString(value), idl.createReferenceType(this.enumEntry.name)).asString()
                : writer.makeEnumCast(value, false, this)
        writer.writeMethodCall(`${param}Serializer`, "writeInt32", [value])
    }
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        const readExpr = writer.makeMethodCall(`${deserializerName}`, "readInt32", [])
        const enumExpr = this.isStringEnum
            ? writer.enumFromOrdinal(readExpr, idl.createReferenceType(this.enumEntry.name))
            : writer.makeCast(readExpr, idl.createReferenceType(this.enumEntry.name))
        return assigneer(enumExpr)
    }
    nativeType(): idl.IDLType {
        return idl.createReferenceType(this.enumEntry.name)
    }
    interopType(): idl.IDLType {
        return idl.IDLI32Type
    }
    isPointerType(): boolean {
        return false
    }
    targetType(writer: LanguageWriter): string {
        return writer.getNodeName(this.idlType) // this.enumTypeName(writer.language)
    }
    override unionDiscriminator(value: string, index: number, writer: LanguageWriter, duplicates: Set<string>): LanguageExpression | undefined {
        return writer.makeDiscriminatorConvertor(this, value, index)
    }
    extremumOfOrdinals(): {low: number, high: number} {
        let low: number = 0
        let high: number = 0
        this.enumEntry.elements.forEach((member, index) => {
            let value = index
            if ((typeof member.initializer === 'number') && !this.isStringEnum) {
                value = member.initializer
            }
            if (low > value) low = value
            if (high < value) high = value
        })
        return {low, high}
    }
}

export class DateConvertor extends BaseArgConvertor { //
    constructor(param: string) {
        super(idl.IDLBigintType, [RuntimeType.NUMBER], false, false, param)
    }

    convertorArg(param: string, writer: LanguageWriter): string {
        if (writer.language === Language.CPP) {
            return param
        }
        return `${param}.getTime()`
    }
    convertorSerialize(param: string, value: string, writer: LanguageWriter): void {
        if (writer.language === Language.CPP) {
            writer.writeMethodCall(`${param}Serializer`, "writeInt64", [value])
        } else {
            writer.writeMethodCall(`${param}Serializer`, "writeInt64", [
                writer.makeCast(writer.makeString(`${value}.getTime()`), idl.IDLI64Type).asString()
            ])
        }
    }
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        const deserializeTime = writer.makeMethodCall(`${deserializerName}`, "readInt64", [])
        if (writer.language === Language.CPP) {
            return assigneer(deserializeTime)
        }
        return assigneer(writer.makeString(`new Date(${deserializeTime.asString()})`))
    }
    nativeType(): idl.IDLType {
        return idl.createReferenceType('Date')
    }
    interopType(): idl.IDLType {
        return idl.IDLDate
    }
    isPointerType(): boolean {
        return false
    }
}

const customObjects = new Set<string>()
export function warnCustomObject(type: string, msg?: string) {
    if (!customObjects.has(type)) {
        warn(`Use CustomObject for ${msg ? `${msg} ` : ``}type ${type}`)
        customObjects.add(type)
    }
}

export class CustomTypeConvertor extends BaseArgConvertor {
    constructor(param: string,
                public readonly customTypeName: string,
                private readonly isGenericType: boolean = false,
                tsType?: string) {
        super(idl.createReferenceType(tsType ?? "Object"), [RuntimeType.OBJECT], false, true, param)
        warnCustomObject(`${tsType}`)
    }
    convertorArg(param: string, writer: LanguageWriter): string {
        throw new Error("Must never be used")
    }
    /** todo: check */
    convertorSerialize(param: string, value: string, printer: LanguageWriter): void {
        printer.writeMethodCall(
            `${param}Serializer`,
            `writeCustomObject`,
            [`"${this.customTypeName}"`, printer.makeCastCustomObject(value, this.isGenericType).asString()]
        )
    }
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigneer, writer: LanguageWriter): LanguageStatement {
        const type = writer.language === Language.CPP
            ? this.nativeType()
            : this.idlType
        return assigneer(writer.makeCast(
            writer.makeMethodCall(`${deserializerName}`,
                "readCustomObject",
                [writer.makeString(`"${this.customTypeName}"`)]),
            type, { optional: false }))
    }
    nativeType(): idl.IDLType {
        return idl.IDLCustomObjectType
    }
    interopType(): idl.IDLType {
        throw new Error("Must never be used")
    }
    isPointerType(): boolean {
        return true
    }
}

