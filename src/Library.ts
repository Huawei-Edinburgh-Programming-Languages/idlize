import * as ts from "typescript"
import { Language } from "./util"
import { ArgConvertor } from "./peer-generation/Convertors"


export interface Library<FileType> {
    language: Language
    files: FileType[]
    findFileByOriginalFilename(filename: string): FileType | undefined 
}

export interface FieldInterface<T> {
    declaration: T
    type: ts.TypeNode | undefined
    name: string
    optional: boolean
}

export interface StructInterface<T> {
    addField(field: FieldInterface<T>): void
    getFields(): readonly FieldInterface<T>[]
    isEmpty(): boolean
}

export interface DeclTable<T> {
    language: Language
    computeTypeName(suggestedName: string | undefined, type: ts.TypeNode): string
    computeTargetName(target: T): string
    toTarget(node: ts.TypeNode): T

    targetStruct(target: T): StructInterface<T>

    serializerName(name: string): string
    deserializerName(name: string): string

    typeConvertor(param: string, type: ts.TypeNode): ArgConvertor
    declarationConvertor(param: string, type: ts.TypeReferenceNode, declaration?: ts.NamedDeclaration): ArgConvertor
}