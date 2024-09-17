import * as ts from "typescript"
import { Language } from "./util"
import { ArgConvertor } from "./peer-generation/Convertors"
import { TypeNodeConvertor } from "./peer-generation/TypeNodeConvertor"
import { DeclarationTarget, StructDescriptor } from "./peer-generation/DeclarationTable"


export interface Library<FileType> {
    language: Language
    files: FileType[]
    findFileByOriginalFilename(filename: string): FileType | undefined 
}

export interface TypeProcessor {
    language: Language
    typeChecker: ts.TypeChecker | undefined
    computeTypeName(suggestedName: string | undefined, type: ts.TypeNode, optional?: boolean, prefix?: string): string
    serializerName(name: string): string
    deserializerName(name: string): string
    typeConvertor(paramName: string, 
        type: ts.TypeNode, 
        isOptional?: boolean, 
        nodeConv?: TypeNodeConvertor<string>
    ): ArgConvertor
    declarationConvertor(paramName: string, 
        type: ts.TypeReferenceNode, 
        declaration?: ts.NamedDeclaration, 
        nodeConv?: TypeNodeConvertor<string>
    ): ArgConvertor

    targetStruct(target: DeclarationTarget): StructDescriptor

    computeTargetName(target: DeclarationTarget, optional: boolean): string
    getTypeName(type: ts.TypeNode, optional?: boolean): string
    toTarget(node: ts.TypeNode): DeclarationTarget
}