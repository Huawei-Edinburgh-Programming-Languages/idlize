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
import {
    createVoidType, IDLConstant, 
    IDLEntry, IDLEnum, IDLInterface, IDLKind, IDLMethod, 
    IDLTypedef, IDLModuleType
} from "./idl"
import { GenericVisitor } from "./options"

export class SKOALAVisitor implements GenericVisitor<IDLEntry[]> {
    private output: IDLEntry[] = []

    constructor(
        private sourceFile: ts.SourceFile,
    ) { }

    visitWholeFile(): IDLEntry[] {
        return []
    }

    visit(node: ts.Node) { }

    serializeAmbientModuleDeclaration(node: ts.ModuleDeclaration): IDLModuleType {
        return { kind: IDLKind.ModuleType, name: "", extendedAttributes: [] }
    }

    serializeTypeAlias(node: ts.TypeAliasDeclaration): IDLTypedef {
        return { kind: IDLKind.Typedef, name: "", extendedAttributes: [], type: createVoidType() }
    }

    serializeClass(node: ts.ClassDeclaration): IDLInterface {
        return { kind: IDLKind.Class, name: "", extendedAttributes: [], inheritance: [], constructors: [], constants: [], properties: [], methods: [], callables: [], scope: [] }
    }

    serializeInterface(node: ts.InterfaceDeclaration): IDLInterface {
        return { kind: IDLKind.Interface, name: "", extendedAttributes: [], inheritance: [], constructors: [], constants: [], properties: [], methods: [], callables: [], scope: [] }
    }

    serializeEnum(node: ts.EnumDeclaration): IDLEnum {
        return { kind: IDLKind.Enum, name: "", extendedAttributes: [], elements: [] }
    }

    serializeMethod(method: ts.MethodDeclaration | ts.MethodSignature | ts.IndexSignatureDeclaration | ts.FunctionDeclaration): IDLMethod {
        return { kind: IDLKind.Method, name: "", extendedAttributes: [], parameters: [], returnType: createVoidType(), isStatic: false, isOptional: false, scope: [] }
    }

    serializeConstants(stmt: ts.VariableStatement): IDLConstant[] {
        return []
    }
}
