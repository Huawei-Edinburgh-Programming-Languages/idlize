import { LanguageExpression, LanguageStatement, LanguageWriter, Type } from "../peer-generation/LanguageWriters"
import { Language } from "../util"

export interface ArgConvertor {
    param: string
    tsTypeName: string
    isScoped: boolean
    useArray: boolean
    scopeStart?(param: string, language: Language): string
    scopeEnd?(param: string, language: Language): string
    convertorArg(param: string, writer: LanguageWriter): string
    convertorSerialize(param: string, value: string, writer: LanguageWriter): void
    convertorDeserialize(param: string, value: string, writer: LanguageWriter): LanguageStatement
    interopType(language: Language): string
    nativeType(impl: boolean): string
    targetType(writer: LanguageWriter): Type
    isPointerType(): boolean
    unionDiscriminator(value: string, index: number, writer: LanguageWriter, duplicates: Set<string>): LanguageExpression | undefined
    getMembers(): string[]
}

export interface RetConvertor {
    isVoid: boolean
    nativeType: () => string
    macroSuffixPart: () => string
}