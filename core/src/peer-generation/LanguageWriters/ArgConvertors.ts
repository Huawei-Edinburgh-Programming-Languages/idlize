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

import * as idl from "../../idl";
import { Language } from "../../Language";
import { LanguageExpression, LanguageStatement, LanguageWriter, ExpressionAssigner } from "./LanguageWriter";
import { RuntimeType } from "./common";

export interface ArgConvertor {
    param: string
    idlType: idl.IDLType
    isScoped: boolean
    useArray: boolean
    runtimeTypes: RuntimeType[]
    isOut?: true
    scopeStart?(param: string, language: Language): string
    scopeEnd?(param: string, language: Language): string
    convertorArg(param: string, writer: LanguageWriter): string
    convertorSerialize(param: string, value: string, writer: LanguageWriter): void
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigner, writer: LanguageWriter): LanguageStatement
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
    scopeStart?(param: string, language: Language): string
    scopeEnd?(param: string, language: Language): string
    abstract convertorArg(param: string, writer: LanguageWriter): string
    abstract convertorSerialize(param: string, value: string, writer: LanguageWriter): void
    abstract convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigner, writer: LanguageWriter): LanguageStatement
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
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigner, writer: LanguageWriter): LanguageStatement {
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
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigner, writer: LanguageWriter): LanguageStatement {
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
    convertorDeserialize(bufferName: string, deserializerName: string, assigneer: ExpressionAssigner, writer: LanguageWriter): LanguageStatement {
        return assigneer(writer.makeVoid())
    }
    nativeType(): idl.IDLType {
        return idl.IDLVoidType
    }
}
