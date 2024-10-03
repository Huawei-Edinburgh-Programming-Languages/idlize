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
import { capitalize, isDefined, Language, stringOrNone } from "../util";
import {
    AggregateConvertor,
    ArgConvertor,
    ArrayConvertor,
    BaseArgConvertor,
    CustomTypeConvertor,
    EnumConvertor,
    MapConvertor,
    OptionConvertor,
    StringConvertor,
    TupleConvertor,
    UnionConvertor
} from "./Convertors";
import { FieldRecord, PrimitiveType } from "./DeclarationTable";
import { RuntimeType } from "./PeerGeneratorVisitor";
import { createLiteralDeclName, mapType, TSTypeNodeNameConvertor } from "./TypeNodeNameConvertor";

import * as ts from "typescript"
import * as fs from "fs"
import { EnumEntity } from "./PeerFile";
import { CJKeywords, cppKeywords } from "../languageSpecificKeywords";
import { convertJavaOptional } from "./printers/lang/Java";
import { createPrimitiveTypeMapper } from "../idl";

export class Type {
    constructor(public name: string, public nullable = false) {}
    static Int32 = new Type('int32')
    static Boolean = new Type('boolean')
    static Number = new Type('number')
    static Pointer = new Type('KPointer')
    static This = new Type('this')
    static Void = new Type('void')

    private static PRIMITIVE_TYPES = new Set(
        [Type.Boolean, Type.Int32, Type.Number, Type.Pointer, Type.Void]
            .map(it => it.name)
    )

    toString(): string {
        return `${this.name}${this.nullable ? "?" : ""}`
    }

    isPrimitive(): boolean {
        return Type.PRIMITIVE_TYPES.has(this.name)
    }
}

export enum FieldModifier {
    READONLY,
    PRIVATE,
    PUBLIC,
    STATIC,
    PROTECTED,
    FINAL,
    VOLATILE,
    INTERNAL,
}

export enum MethodModifier {
    PUBLIC,
    PRIVATE,
    STATIC,
    NATIVE,
    INLINE,
    GETTER,
    SETTER,
    PROTECTED
}

export interface LanguageStatement {
    write(writer: LanguageWriter): void
}

export interface LanguageExpression {
    asString(): string
}

export class AssignStatement implements LanguageStatement {
    constructor(public variableName: string,
                public type: Type | undefined,
                public expression: LanguageExpression | undefined,
                public isDeclared: boolean = true,
                protected isConst: boolean = true) { }
    write(writer: LanguageWriter): void {
        if (this.isDeclared) {
            const typeSpec = this.type ? `: ${writer.mapType(this.type)}${this.type.nullable ? "|undefined" : ""}` : ""
            const initValue = this.expression ? `= ${this.expression.asString()}` : ""
            const constSpec = this.isConst ? "const" : "let"
            writer.print(`${constSpec} ${this.variableName}${typeSpec} ${initValue}`)
        } else {
            writer.print(`${this.variableName} = ${this.expression?.asString()}`)
        }
    }
}

export class DeclareStatement implements LanguageStatement {
    constructor(public variableName: string,
                public type: Type,
                public expression: LanguageExpression | undefined = undefined) { }
    write(writer: LanguageWriter): void {
        const type = this.type ? `: ${this.type.name}` : ""
        if (this.expression) {
            writer.print(`const ${this.variableName}${type} = ${this.expression.asString()}`)
        } else {
            writer.print(`let ${this.variableName}${type}`)
        }
    }
}

export class JavaAssignStatement extends AssignStatement {
    constructor(public variableName: string,
                public type: Type | undefined,
                public expression: LanguageExpression,
                public isDeclared: boolean = true,
                protected isConst: boolean = true) {
        super(variableName, type, expression, isDeclared, isConst)
     }
     write(writer: LanguageWriter): void{
        if (this.isDeclared) {
            const typeSpec = this.type ? writer.mapType(this.type) : "var"
            writer.print(`${typeSpec} ${this.variableName} = ${this.expression.asString()};`)
        } else {
            writer.print(`${this.variableName} = ${this.expression.asString()};`)
        }
    }
}

export class EtsAssignStatement implements LanguageStatement {
    constructor(public variableName: string,
                public type: Type | undefined,
                public expression: LanguageExpression,
                public isDeclared: boolean = true,
                protected isConst: boolean = true) { }
    write(writer: LanguageWriter): void {
        if (this.isDeclared) {
            const typeSpec = ""
            writer.print(`${this.isConst ? "const" : "let"} ${this.variableName}${typeSpec} = ${this.expression.asString()}`)
        } else {
            writer.print(`${this.variableName} = ${this.expression.asString()}`)
        }
    }
}

export class CppAssignStatement extends AssignStatement {
    constructor(public variableName: string,
                public type: Type | undefined,
                public expression: LanguageExpression | undefined,
                public isDeclared: boolean = true,
                public isConst: boolean = true) {
        super(variableName, type, expression, isDeclared, isConst)
     }
     write(writer: LanguageWriter): void{
        if (this.isDeclared) {
            const typeSpec = this.type ? writer.mapType(this.type) : "auto"
            const initValue = this.expression ? this.expression.asString() : "{}"
            const constSpec = this.isConst ? "const " : ""
            writer.print(`${constSpec}${typeSpec} ${this.variableName} = ${initValue};`)
        } else {
            writer.print(`${this.variableName} = ${this.expression!.asString()};`)
        }
    }
}

export class CJAssignStatement extends AssignStatement {
    constructor(public variableName: string,
        public type: Type | undefined,
        public expression: LanguageExpression,
        public isDeclared: boolean = true,
        public isConst: boolean = true) {
            super(variableName, type, expression, isDeclared, isConst)
        }

        write(writer: LanguageWriter): void {
            if (this.isDeclared) {
                const typeSpec = this.type ? ': ' + writer.mapType(this.type) : ''
                writer.print(`${this.isConst ? "let" : "var"} ${this.variableName}${typeSpec} = ${this.expression.asString()}`)
            } else {
                writer.print(`${this.variableName} = ${this.expression.asString()}`)
            }
        }
}

export class CDefinedExpression implements LanguageExpression {
    constructor(private value: string) { }
    asString(): string {
        return `${this.value} != ARK_TAG_UNDEFINED`
    }
}

export class CheckDefinedExpression implements LanguageExpression {
    constructor(private value: string) { }
    asString(): string {
        return `${this.value} != "undefined"`
    }
}

export class JavaCheckDefinedExpression implements LanguageExpression {
    constructor(private value: string) { }
    asString(): string {
        return `${this.value} != null`
    }
}

export class CJCheckDefinedExpression implements LanguageExpression {
    constructor(private value: string) { }
    asString(): string {
        return `${this.value}.isNotNone()}`
    }
}

export class NewObjectExpression implements LanguageExpression {
    constructor(
        private objectName: string,
        private params: LanguageExpression[]) { }
    asString(): string {
        return `new ${this.objectName}(${this.params.map(it => it.asString()).join(", ")})`
    }
}

export class FunctionCallExpression implements LanguageExpression {
    constructor(
        private name: string,
        private params: LanguageExpression[]) { }
    asString(): string {
        return `${this.name}(${this.params.map(it => it.asString()).join(", ")})`
    }
}

export class MethodCallExpression extends FunctionCallExpression {
    constructor(
        public receiver: string,
        method: string,
        params: LanguageExpression[],
        public nullable = false)
    {
        super(method, params)
    }
    asString(): string {
        return `${this.receiver}${this.nullable ? "?" : ""}.${super.asString()}`
    }
}

abstract class LambdaExpression implements LanguageExpression {
    constructor(
        protected signature: MethodSignature,
        private body?: LanguageStatement[]) { }

    protected abstract get statementHasSemicolon(): boolean
    abstract asString(): string

    bodyAsString(): string {
        const writer = new TSLanguageWriter(new IndentedPrinter(), Language.TS)
        if (this.body) {
            for (const stmt of this.body) {
                stmt.write(writer)
            }
        }

        return writer.printer.getOutput()
            .map(line => line.trim())
            .filter(line => line !== "")
            .map(line => line === "{" || line === "}" || this.statementHasSemicolon ? line : `${line};`)
            .join(" ")
    }
}

class TSLambdaExpression extends LambdaExpression {
    constructor(
        signature: MethodSignature,
        body?: LanguageStatement[]) {
        super(signature, body)
    }
    protected get statementHasSemicolon(): boolean {
        return false
    }
    asString(): string {
        const params = this.signature.args.map((it, i) => `${this.signature.argName(i)}: ${it.name}`)
        return `(${params.join(", ")}) => { ${this.bodyAsString()} }`
    }
}

class JavaLambdaExpression extends LambdaExpression {
    constructor(
        signature: MethodSignature,
        body?: LanguageStatement[]) {
        super(signature, body)
    }
    protected get statementHasSemicolon(): boolean {
        return true
    }
    asString(): string {
        const params = this.signature.args.map((it, i) => `${it.name} ${this.signature.argName(i)}`)
        return `(${params.join(", ")}) -> { ${this.bodyAsString()} }`
    }
}

class TSThrowErrorStatement implements LanguageStatement {
    constructor(public message: string) { }
    write(writer: LanguageWriter): void {
        writer.print(`throw new Error("${this.message}")`)
    }
}

class CLikeThrowErrorStatement implements LanguageStatement {
    constructor(public message: string) { }
    write(writer: LanguageWriter): void {
        writer.print(`throw new Error("${this.message}");`)
    }
}

export class ExpressionStatement implements LanguageStatement {
    constructor(public expression: LanguageExpression) { }
    write(writer: LanguageWriter): void {
        const text = this.expression.asString()
        if (text.length > 0) {
            writer.print(`${this.expression.asString()}`)
        }
    }
}

export class CLikeExpressionStatement extends ExpressionStatement {
    constructor(public expression: LanguageExpression) { super(expression) }
    write(writer: LanguageWriter): void {
        const text = this.expression.asString()
        if (text.length > 0) {
            writer.print(`${this.expression.asString()};`)
        }
    }
}

export class ReturnStatement implements LanguageStatement {
    constructor(public expression?: LanguageExpression) { }
    write(writer: LanguageWriter): void {
        writer.print(this.expression ? `return ${this.expression.asString()}` : "return")
    }
}

export class TSReturnStatement extends ReturnStatement {
    constructor(public expression: LanguageExpression) { super(expression) }
}

export class CLikeReturnStatement extends ReturnStatement {
    constructor(public expression: LanguageExpression) { super(expression) }
    write(writer: LanguageWriter): void {
        writer.print(this.expression ? `return ${this.expression.asString()};` : "return;")
    }
}

export class TSCastExpression implements LanguageExpression {
    constructor(public value: LanguageExpression, public type: Type, private unsafe = false) {}
    asString(): string {
        return this.unsafe
            ? `unsafeCast<${this.type.name}>(${this.value.asString()})`
            : `(${this.value.asString()} as ${this.type.name})`
    }
}

export class JavaCastExpression implements LanguageExpression {
    constructor(public value: LanguageExpression, public type: string, private unsafe = false) {}
    asString(): string {
        return `(${this.type})(${this.value.asString()})`
    }
}

export class CppCastExpression implements LanguageExpression {
    constructor(public value: LanguageExpression, public type: Type, private unsafe = false) {}
    asString(): string {
        if (this.type.name === PrimitiveType.Tag.getText()) {
            return `${this.value.asString()} == ARK_RUNTIME_UNDEFINED ? ARK_TAG_UNDEFINED : ARK_TAG_OBJECT`
        }
        return this.unsafe
            ? `reinterpret_cast<${this.type.name}>(${this.value.asString()})`
            : `static_cast<${this.type.name}>(${this.value.asString()})`
    }
}

class TSLoopStatement implements LanguageStatement {
    constructor(private counter: string, private limit: string, private statement: LanguageStatement | undefined) {}
    write(writer: LanguageWriter): void {
        writer.print(`for (let ${this.counter} = 0; ${this.counter} < ${this.limit}; ${this.counter}++) {`)
        if (this.statement) {
            writer.pushIndent()
            this.statement.write(writer)
            writer.popIndent()
            writer.print("}")
        }
    }
}

class CLikeLoopStatement implements LanguageStatement {
    constructor(private counter: string, private limit: string, private statement: LanguageStatement | undefined) {}
    write(writer: LanguageWriter): void {
        writer.print(`for (int ${this.counter} = 0; ${this.counter} < ${this.limit}; ${this.counter}++) {`)
        if (this.statement) {
            writer.pushIndent()
            this.statement.write(writer)
            writer.popIndent()
            writer.print("}")
        }
    }
}

class CJLoopStatement implements LanguageStatement {
    constructor(private counter: string, private limit: string, private statement: LanguageStatement | undefined) {}
    write(writer: LanguageWriter): void {
        writer.print(`for (${this.counter} in 0..${this.limit}) {`)
        if (this.statement) {
            writer.pushIndent()
            this.statement.write(writer)
            writer.popIndent()
            writer.print("}")
        }
    }
}

class TSMapForEachStatement implements LanguageStatement {
    constructor(private map: string, private key: string, private value: string, private op: () => void) {}
    write(writer: LanguageWriter): void {
        writer.print(`for (const [${this.key}, ${this.value}] of ${this.map}) {`)
        writer.pushIndent()
        this.op()
        writer.popIndent()
        writer.print(`}`)
    }
}

class ArkTSMapForEachStatement implements LanguageStatement {
    constructor(private map: string, private key: string, private value: string, private op: () => void) {}
    write(writer: LanguageWriter): void {
        writer.print(`// TODO: map serialization not implemented`)
    }
}


class JavaMapForEachStatement implements LanguageStatement {
    constructor(private map: string, private key: string, private value: string, private op: () => void) {}
    write(writer: LanguageWriter): void {
        const entryVar = `${this.map}Entry`
        writer.print(`for (var ${entryVar}: ${this.map}.entrySet()) {`)
        writer.pushIndent()
        writer.print(`var ${this.key} = ${entryVar}.getKey();`)
        writer.print(`var ${this.value} = ${entryVar}.getValue();`)
        this.op()
        writer.popIndent()
        writer.print(`}`)
    }
}

class CppMapForEachStatement implements LanguageStatement {
    constructor(private map: string, private key: string, private value: string, private op: () => void) {}
    write(writer: LanguageWriter): void {
        writer.print(`for (int32_t i = 0; i < ${this.map}.size; i++) {`)
        writer.pushIndent()
        writer.print(`auto ${this.key} = ${this.map}.keys[i];`)
        writer.print(`auto ${this.value} = ${this.map}.values[i];`)
        this.op()
        writer.popIndent()
        writer.print(`}`)
    }
}

class CJMapForEachStatement implements LanguageStatement {
    constructor(private map: string, private key: string, private value: string, private op: () => void) {}
    write(writer: LanguageWriter): void {
        writer.print(`for ((key, value) in ${this.map}) {`)
        writer.pushIndent()
        this.op()
        writer.popIndent()
        writer.print(`}`)
    }
}

class CppArrayResizeStatement implements LanguageStatement {
    constructor(private array: string, private length: string, private deserializer: string) {}
    write(writer: LanguageWriter): void {
        writer.print(`${this.deserializer}.resizeArray<std::decay<decltype(${this.array})>::type,
        std::decay<decltype(*${this.array}.array)>::type>(&${this.array}, ${this.length});`)
    }
}

class CppMapResizeStatement implements LanguageStatement {
    constructor(private keyType: string, private valueType: string, private map: string, private size: string, private deserializer: string) {}
    write(writer: LanguageWriter): void {
        writer.print(`${this.deserializer}.resizeMap<Map_${this.keyType.replace(PrimitiveType.ArkPrefix, "")}_${this.valueType.replace(PrimitiveType.ArkPrefix, "")}, ${this.keyType}, ${this.valueType}>(&${this.map}, ${this.size});`)
    }
}

class TsTupleAllocStatement implements LanguageStatement {
    constructor(private tuple: string) {}
    write(writer: LanguageWriter): void {
        writer.writeStatement(writer.makeAssign(this.tuple, undefined, writer.makeString("[]"), false, false))
    }
}

class TsObjectAssignStatement implements LanguageStatement {
    constructor(private object: string, private type: Type | undefined, private isDeclare: boolean) {}
    write(writer: LanguageWriter): void {
        writer.writeStatement(writer.makeAssign(this.object,
            this.type,
            writer.makeString(`{}`),
            this.isDeclare,
            false))
    }
}

class TsObjectDeclareStatement implements LanguageStatement {
    constructor(private object: string, private type: Type | undefined, private fields: readonly FieldRecord[]) {}
    write(writer: LanguageWriter): void {
        const nameConvertor = new TsObjectDeclareNodeNameConvertor()
        // Constructing a new type with all optional fields
        const objectType = new Type(`{${this.fields.map(it => {
            return `${it.name}?: ${nameConvertor.convert(it.type)}`
        }).join(",")}}`)
        new TsObjectAssignStatement(this.object, objectType, true).write(writer)
    }
}

export class BlockStatement implements LanguageStatement {
    constructor(public statements: LanguageStatement[], private inScope: boolean = true) { }
    write(writer: LanguageWriter): void {
        if (this.inScope) {
            writer.print("{")
            writer.pushIndent()
        }
        this.statements.forEach(s => s.write(writer))
        if (this.inScope) {
            writer.popIndent()
            writer.print("}")
        }
    }
}

export class IfStatement implements LanguageStatement {
    constructor(public condition: LanguageExpression,
        public thenStatement: LanguageStatement,
        public elseStatement: LanguageStatement | undefined,
        public insideIfOp: (() => void) | undefined,
        public insideElseOp: (() => void) | undefined
    ) { }
    write(writer: LanguageWriter): void {
        writer.print(`if (${this.condition.asString()}) {`)
        writer.pushIndent()
        this.thenStatement.write(writer)
        if (this.insideIfOp) { this.insideIfOp!() }
        writer.popIndent()
        if (this.elseStatement !== undefined) {
            writer.print("} else {")
            writer.pushIndent()
            this.elseStatement.write(writer)
            if (this.insideElseOp) { this.insideElseOp!() }
            writer.popIndent()
            writer.print("}")
        } else {
            writer.print("}")
        }

    }
}

export type BranchStatement = {expr: LanguageExpression, stmt: LanguageStatement}

export class MultiBranchIfStatement implements LanguageStatement {
    constructor(private readonly statements: BranchStatement[],
                private readonly elseStatement: LanguageStatement | undefined) { }
    write(writer: LanguageWriter): void {
        this.statements.forEach((value, index) => {
            const {expr, stmt}= value
            if (index == 0) {
                writer.print(`if (${expr.asString()}) {`)
            } else {
                writer.print(`else if (${expr.asString()}) {`)
            }
            writer.pushIndent()
            stmt.write(writer)
            writer.popIndent()
            writer.print("}")
        })

        if (this.elseStatement !== undefined) {
            writer.print(" else {")
            writer.pushIndent()
            this.elseStatement.write(writer)
            writer.popIndent()
            writer.print("}")
        }
    }
}

export class TernaryExpression implements LanguageExpression {
    constructor(public condition: LanguageExpression,
        public trueExpression: LanguageExpression,
        public falseExpression: LanguageExpression) {}
    asString(): string {
        return `(${this.condition.asString()}) ? (${this.trueExpression.asString()}) : (${this.falseExpression.asString()})`
    }
}

export class NaryOpExpression implements LanguageExpression {
    constructor(public op: string, public args: LanguageExpression[]) { }
    asString(): string {
        return `${this.args.map(arg => `(${arg.asString()})`).join(` ${this.op} `)}`
    }
}

export class StringExpression implements LanguageExpression {
    constructor(public value: string) { }
    asString(): string {
        return this.value
    }
}

export class MethodSignature {
    constructor(public returnType: Type, public args: Type[], public defaults: stringOrNone[]|undefined = undefined) {}

    argName(index: number): string {
        return `arg${index}`
    }
    argDefault(index: number): string|undefined {
        return this.defaults?.[index]
    }

    toString(): string {
        return `${this.args.map(it => it.name)} => ${this.returnType}`
    }
}

export class NamedMethodSignature extends MethodSignature {
    constructor(returnType: Type, args: Type[] = [], public argsNames: string[] = [], defaults: stringOrNone[]|undefined = undefined) {
        super(returnType, args, defaults)
    }

    static make(returnType: string, args: {name: string, type: string}[]): NamedMethodSignature {
        return new NamedMethodSignature(new Type(returnType), args.map(it => new Type(it.type)), args.map(it => it.name))
    }

    argName(index: number): string {
        return this.argsNames[index]
    }
}

export class TsEnumEntityStatement implements LanguageStatement {
    constructor(private readonly enumEntity: EnumEntity, private readonly isExport: boolean) {}

    write(writer: LanguageWriter) {
        writer.print(this.enumEntity.comment.length > 0 ? this.enumEntity.comment : undefined)
        writer.print(`${this.isExport ? "export " : ""}enum ${this.enumEntity.name} {`)
        writer.pushIndent()
        this.enumEntity.members.forEach((member, index) => {
            writer.print(member.comment.length > 0 ? member.comment : undefined)
            const commaOp = index < this.enumEntity.members.length - 1 ? ',' : ''
            const initValue = member.initializerText ? ` = ${member.initializerText}` : ``
            writer.print(`${member.name}${initValue}${commaOp}`)
        })
        writer.popIndent()
        writer.print(`}`)
    }
}

export class ArkTSEnumEntityStatement implements LanguageStatement {
    constructor(private readonly enumEntity: EnumEntity, private readonly isExport: boolean) {}

    write(writer: LanguageWriter) {
        writer.print(this.enumEntity.comment.length > 0 ? this.enumEntity.comment : undefined)
        writer.writeClass(this.enumEntity.name, (writer) => {
            let isTypeString = true
            this.enumEntity.members.forEach((member, index) => {
                writer.print(member.comment.length > 0 ? member.comment : undefined)
                const initText = member.initializerText ?? `${index}`
                isTypeString &&= isNaN(Number(initText))
                writer.writeFieldDeclaration(member.name, new Type(this.enumEntity.name), [FieldModifier.STATIC], false,
                    writer.makeString(`new ${this.enumEntity.name}(${initText}${isTypeString ? `,${index}` : ""})`))
            })
            const typeName = isTypeString ? "string" : "KInt"
            let argTypes = [new Type(typeName)]
            let argNames = ["value"]
            if (isTypeString) {
                argTypes.push(new Type("KInt"))
                argNames.push("ordinal")
            }
            writer.writeConstructorImplementation(this.enumEntity.name,
                new NamedMethodSignature(Type.Void, argTypes, argNames), (writer) => {
                    writer.writeStatement(writer.makeAssign("this.value", undefined, writer.makeString("value"), false))
                    if (isTypeString) {
                        writer.writeStatement(writer.makeAssign("this.ordinal", undefined, writer.makeString("ordinal"), false))
                    }
            })
            writer.writeFieldDeclaration("value", new Type(typeName), [FieldModifier.PUBLIC, FieldModifier.READONLY], false)
            if (isTypeString) {
                writer.writeFieldDeclaration("ordinal", new Type("KInt"), [FieldModifier.PUBLIC, FieldModifier.READONLY], false)
            }
            writer.writeMethodImplementation(new Method("of", new MethodSignature(new Type(this.enumEntity.name), [argTypes[0]]), [MethodModifier.PUBLIC, MethodModifier.STATIC]),
                (writer)=> {
                    this.enumEntity.members.forEach((member) => {
                        const memberName = `${this.enumEntity.name}.${member.name}`
                        writer.writeStatement(
                            writer.makeCondition(
                                writer.makeEquals([writer.makeString('arg0'), writer.makeString(`${memberName}.value`)]),
                                writer.makeReturn(writer.makeString(memberName)))
                        )
                    })
                    writer.print("throw new Error(`Enum member '$\{arg0\}' not found`)")
            })
        })
    }
}

export class CJEnumEntityStatement implements LanguageStatement {
    constructor(private readonly enumEntity: EnumEntity, private readonly isExport: boolean) {}

    write(writer: LanguageWriter) {
        writer.print(this.enumEntity.comment.length > 0 ? this.enumEntity.comment : undefined)
        writer.print(`${this.isExport ? "public " : ""}enum ${this.enumEntity.name} {`)
        writer.pushIndent()
        this.enumEntity.members.forEach((member, index) => {
            writer.print(member.comment.length > 0 ? member.comment : undefined)
            const varticalBar = index < this.enumEntity.members.length - 1 ? '|' : ''
            const initValue = member.initializerText ? ` = ${member.initializerText}` : ``
            writer.print(`${member.name}${initValue}${varticalBar}`)
        })
        writer.popIndent()
        writer.print(`}`)
    }
}

export class Field {
    constructor(
        public name: string,
        public type: Type,
        public modifiers: FieldModifier[] = []
    ) {}
}

export class Method {
    constructor(
        public name: string,
        public signature: MethodSignature,
        public modifiers: MethodModifier[]|undefined = undefined,
        public generics?: string[],
    ) {}
}

export function mangleMethodName(method: Method, id?: number): string {
    return `${method.name}${id ?? ""}`
}

export function copyMethod(method: Method, overrides: {
    name?: string,
    signature?: MethodSignature,
    modifiers?: MethodModifier[],
    generics?: string[],
 }) {
    return new Method(
        overrides.name ?? method.name,
        overrides.signature ?? method.signature,
        overrides.modifiers ?? method.modifiers,
        overrides.generics ?? method.generics,
    )
 }

export interface ObjectArgs {
    [name: string]: string
}

export interface PrinterLike {
    getOutput(): string[]
}

export abstract class LanguageWriter {
    constructor(public printer: IndentedPrinter, public language: Language) {}

    indentDepth(): number {
        return this.printer.indentDepth()
    }

    abstract writeClass(name: string, op: (writer: LanguageWriter) => void, superClass?: string, interfaces?: string[], generics?: string[], isDeclared?: boolean): void
    abstract writeInterface(name: string, op: (writer: LanguageWriter) => void, superInterfaces?: string[], isDeclared?: boolean): void
    abstract writeFieldDeclaration(name: string, type: Type, modifiers: FieldModifier[]|undefined, optional: boolean, initExpr?: LanguageExpression): void
    abstract writeMethodDeclaration(name: string, signature: MethodSignature, modifiers?: MethodModifier[]): void
    abstract writeConstructorImplementation(className: string, signature: MethodSignature, op: (writer: LanguageWriter) => void, superCall?: Method, modifiers?: MethodModifier[]): void
    abstract writeMethodImplementation(method: Method, op: (writer: LanguageWriter) => void): void
    abstract makeAssign(variableName: string, type: Type | undefined, expr: LanguageExpression | undefined, isDeclared: boolean, isConst?: boolean): LanguageStatement;
    abstract makeLambda(signature: MethodSignature, body?: LanguageStatement[]): LanguageExpression;
    abstract makeThrowError(message: string): LanguageStatement;
    abstract makeReturn(expr?: LanguageExpression): LanguageStatement;
    abstract makeRuntimeType(rt: RuntimeType): LanguageExpression
    abstract getObjectAccessor(convertor: ArgConvertor, value: string, args?: ObjectArgs): string
    abstract makeCast(value: LanguageExpression, type: Type): LanguageExpression
    abstract makeCast(value: LanguageExpression, type: Type, unsafe: boolean): LanguageExpression
    abstract writePrintLog(message: string): void
    abstract makeUndefined(): LanguageExpression
    abstract makeMapKeyTypeName(c: MapConvertor): string
    abstract makeMapValueTypeName(c: MapConvertor): string
    abstract makeMapInsert(keyAccessor: string, key: string, valueAccessor: string, value: string): LanguageStatement
    abstract makeLoop(counter: string, limit: string): LanguageStatement
    abstract makeLoop(counter: string, limit: string, statement: LanguageStatement): LanguageStatement
    abstract makeMapForEach(map: string, key: string, value: string, op: () => void): LanguageStatement
    abstract getTagType(): Type
    abstract getRuntimeType(): Type
    abstract makeTupleAssign(receiver: string, tupleFields: string[]): LanguageStatement
    abstract get supportedModifiers(): MethodModifier[]
    abstract get supportedFieldModifiers(): FieldModifier[]
    abstract enumFromOrdinal(value: LanguageExpression, enumType: string): LanguageExpression
    abstract ordinalFromEnum(value: LanguageExpression, enumType: string): LanguageExpression


    concat(other: PrinterLike): this {
        other.getOutput().forEach(it => this.print(it))
        return this
    }
    printTo(file: string): void {
        fs.writeFileSync(file, this.getOutput().join("\n"))
    }
    writeLines(lines: string): void {
        lines.split("\n").forEach(it => this.print(it))
    }
    writeGetterImplementation(method: Method, op: (writer: LanguageWriter) => void): void {
        this.writeMethodImplementation(new Method(method.name, method.signature, [MethodModifier.GETTER].concat(method.modifiers ?? [])), op)
    }
    writeSetterImplementation(method: Method, op: (writer: LanguageWriter) => void): void {
        this.writeMethodImplementation(new Method(method.name, method.signature, [MethodModifier.SETTER].concat(method.modifiers ?? [])), op)
    }
    writeSuperCall(params: string[]): void {
        this.printer.print(`super(${params.join(", ")});`)
    }
    writeMethodCall(receiver: string, method: string, params: string[], nullable = false): void {
        this.printer.print(`${receiver}${nullable ? "?" : ""}.${method}(${params.join(", ")})`)
    }
    writeStatement(stmt: LanguageStatement) {
        //this.printer.print(stmt.asString())
        stmt.write(this)
    }
    makeCastEnumToInt(convertor: EnumConvertor, enumName: string, unsafe?: boolean): string {
        if (unsafe) {
            return this.makeUnsafeCast(convertor, enumName)
        }
        return enumName
    }
    makeTag(tag: string): string {
        return "Tag." + tag
    }
    makeRef(varName: string): string {
        return varName
    }
    makeThis(): LanguageExpression {
        return new StringExpression("this")
    }
    makeNull(): LanguageExpression {
        return new StringExpression("null")
    }
    makeRuntimeTypeCondition(typeVarName: string, equals: boolean, type: RuntimeType, varName?: string): LanguageExpression {
        const op = equals ? "==" : "!="
        return this.makeNaryOp(op, [this.makeRuntimeType(type), this.makeString(typeVarName)])
    }
    makeValueFromOption(value: string, destinationConvertor: ArgConvertor): LanguageExpression {
        return this.makeString(`${value}!`)
    }
    makeNewObject(objectName: string, params: LanguageExpression[] = []): LanguageExpression {
        return new NewObjectExpression(objectName, params)
    }
    makeFunctionCall(name: string, params: LanguageExpression[]): LanguageExpression {
        return new FunctionCallExpression(name, params)
    }
    makeMethodCall(receiver: string, method: string, params: LanguageExpression[], nullable?: boolean): LanguageExpression {
        return new MethodCallExpression(receiver, method, params, nullable)
    }
    makeNativeCall(method: string, params: LanguageExpression[], nullable?: boolean): LanguageExpression {
        return new MethodCallExpression(this.nativeReceiver(), method, params, nullable)
    }
    makeBlock(statements: LanguageStatement[], inScope: boolean = true) {
        return new BlockStatement(statements, inScope)
    }
    nativeReceiver(): string { return 'nativeModule()' }
    makeDefinedCheck(value: string): LanguageExpression {
        return new CheckDefinedExpression(value)
    }
    makeRuntimeTypeDefinedCheck(runtimeType: string): LanguageExpression {
        return this.makeRuntimeTypeCondition(runtimeType, false, RuntimeType.UNDEFINED)
    }
    makeCondition(condition: LanguageExpression, thenStatement: LanguageStatement, elseStatement?: LanguageStatement, insideIfOp?: () => void, insideElseOp?: () => void): LanguageStatement {
        return new IfStatement(condition, thenStatement, elseStatement, insideIfOp, insideElseOp)
    }
    makeMultiBranchCondition(conditions: BranchStatement[], elseStatement?: LanguageStatement): LanguageStatement {
        return new MultiBranchIfStatement(conditions, elseStatement)
    }
    makeTernary(condition: LanguageExpression, trueExpression: LanguageExpression, falseExpression: LanguageExpression): LanguageExpression {
        return new TernaryExpression(condition, trueExpression, falseExpression)
    }
    makeArrayLength(array: string, length?: string): LanguageExpression {
        return this.makeString(`${array}.length`)
    }
    makeArrayAccess(value: string, indexVar: string) {
        return this.makeString(`${value}[${indexVar}]`)
    }
    makeTupleAccess(value: string, index: number): LanguageExpression {
        return this.makeString(`${value}[${index}]`)
    }
    makeUnionSelector(value: string, valueType: string): LanguageStatement {
        return this.makeAssign(valueType, undefined, this.makeString(`runtimeType(${value})`), false)
    }
    makeUnionVariantCondition(_convertor: ArgConvertor, _valueName: string, valueType: string, type: string, index?: number): LanguageExpression {
        return this.makeString(`RuntimeType.${type.toUpperCase()} == ${valueType}`)
    }
    makeUnionVariantCast(value: string, type: Type, convertor: ArgConvertor, index?: number): LanguageExpression {
        return this.makeString(`unsafeCast<${type.name}>(${value})`)
    }
    makeUnionTypeDefaultInitializer() {
        return this.makeRuntimeType(RuntimeType.UNDEFINED)
    }
    makeRuntimeTypeGetterCall(value: string): LanguageExpression {
        return this.makeFunctionCall("runtimeType", [ this.makeString(value) ])
    }
    makeArrayResize(array: string, typeName: string, length: string, deserializer: string): LanguageStatement {
        return new ExpressionStatement(this.makeString(`${array} = [] as ${typeName}`))
    }
    makeMapResize(keyType: string, valueType: string, map: string, size: string, deserializer: string): LanguageStatement {
        return new ExpressionStatement(new StringExpression("// TODO: TS map resize"))
    }
    makeMapSize(map: string): LanguageExpression {
        return this.makeString(`${map}.size`)
    }
    makeTupleAlloc(option: string): LanguageStatement {
        return new ExpressionStatement(new StringExpression(""))
    }
    makeObjectAlloc(object: string, fields: readonly FieldRecord[]): LanguageStatement {
        return new ExpressionStatement(new StringExpression(""))
    }
    makeSetUnionSelector(value: string, index: string): LanguageStatement {
        // empty expression
        return new ExpressionStatement(new StringExpression(""))
    }
    makeSetOptionTag(value: string, tag: LanguageExpression): LanguageStatement {
        // empty expression
        return new ExpressionStatement(new StringExpression(""))
    }
    makeString(value: string): LanguageExpression {
        return new StringExpression(value)
    }
    makeNaryOp(op: string, args: LanguageExpression[]): LanguageExpression {
        return new NaryOpExpression(op, args)
    }
    makeStatement(expr: LanguageExpression): LanguageStatement {
        return new ExpressionStatement(expr)
    }
    writeNativeMethodDeclaration(name: string, signature: MethodSignature, isNative?: boolean): void {
        this.writeMethodDeclaration(name, signature)
    }
    writeUnsafeNativeMethodDeclaration(name: string, signature: MethodSignature): void {
        return
    }
    pushIndent() {
        this.printer.pushIndent()
    }
    popIndent() {
        this.printer.popIndent()
    }
    print(string: stringOrNone) {
        this.printer.print(string)
    }
    getOutput(): string[] {
        return this.printer.getOutput()
    }
    mapType(type: Type, convertor?: ArgConvertor): string {
        return type.name
    }
    mapFieldModifier(modifier: FieldModifier): string {
        return `${FieldModifier[modifier].toLowerCase()}`
    }
    mapMethodModifier(modifier: MethodModifier): string {
        return `${MethodModifier[modifier].toLowerCase()}`
    }
    makeObjectDeclare(name: string, type: Type | undefined, fields: readonly FieldRecord[]): LanguageStatement {
        return this.makeAssign(name, type, this.makeString("{}"), true, false)
    }
    makeType(typeName: string, nullable: boolean, receiver?: string): Type {
        return new Type(typeName, nullable)
    }
    makeUnsafeCast(convertor: ArgConvertor, param: string): string {
        return `unsafeCast<int32>(${param})`
    }
    runtimeType(param: ArgConvertor, valueType: string, value: string) {
        this.writeStatement(this.makeAssign(valueType, Type.Int32,
            this.makeFunctionCall("runtimeType", [this.makeString(value)]), false))
    }