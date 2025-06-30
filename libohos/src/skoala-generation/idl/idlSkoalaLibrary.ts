/*
 * Copyright (c) 2024-2025 Huawei Device Co., Ltd.
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

import * as idl from '@idlizer/core/idl'
import { posix as path } from "path"
import { ImportsCollector } from '../../peer-generation/ImportsCollector'
import {
    capitalize,
    throwException,
    Language,
    CustomPrintVisitor,
    DeclarationNameConvertor,
    addSyntheticType,
    resolveSyntheticType,
    generatorConfiguration,
    LibraryInterface,
    PrimitiveTypesInstance,
    getSuper,
    LibraryBase,
    MaterializedClass,
    NativeModuleType,
    createOutArgConvertor
} from '@idlizer/core'
import { WrapperClass, WrapperField, WrapperMethod } from "../WrapperClass";
import { Skoala } from "../utils";
import { Field, FieldModifier, LanguageExpression, LanguageStatement, LanguageWriter, Method, MethodModifier, NamedMethodSignature } from "@idlizer/core";
import { BaseArgConvertor, ExpressionAssigner, RuntimeType,
    convertDeclaration, convertType, DeclarationConvertor, IdlNameConvertor, TypeConvertor
} from "@idlizer/core"
import { DependenciesCollector } from "../../peer-generation/idl/IdlDependenciesCollector";

export class IldSkoalaOutFile {
    readonly wrapperClasses: Map<string, [WrapperClass, any|undefined]> = new Map()
    readonly baseName: string
    readonly importsCollector: ImportsCollector
    readonly declarations: Set<idl.IDLEntry>

    processedDeclarationsList: Array<idl.IDLEntry> | undefined
    get entries(): idl.IDLEntry[] {
        return this.processedDeclarationsList!
    }

    constructor(
        public file: idl.IDLFile
    ) {
        this.baseName = path.basename(file.fileName!)
        this.importsCollector = new ImportsCollector()
        this.declarations = new Set(file.entries)
    }

    addImportFeature(module: string, ...features: string[]) {
        this.importsCollector.addFeatures(features, module)
    }
}

export class IdlSkoalaLibrary extends LibraryBase implements LibraryInterface {
    constructor(
        language: Language,
        interopNativeModule: NativeModuleType
    ) { 
        super(language, interopNativeModule)
    }

    public readonly serializerDeclarations: Set<idl.IDLInterface> = new Set()
    public name: string = ""
    get libraryPrefix(): string {
        return this.name
    }

    getCurrentContext(): string | undefined {
        return ""
    }

    public get orderedMaterialized(): MaterializedClass[] {
        function accessorName(decl: idl.IDLEntry): string {
            return idl.getQualifiedName(decl, "namespace.name")
        }
        return Array.from(this.materializedClasses.values()).filter(it => it.needBeGenerated)
            .sort((a, b) => accessorName(a.decl).localeCompare(accessorName(b.decl)))
    }
}

export const CustomObject: idl.IDLPrimitiveType = idl.IDLCustomObjectType
export const Function: idl.IDLPrimitiveType = idl.IDLFunctionType

export class IdlWrapperProcessor {
    constructor(public library: IdlSkoalaLibrary) { }

    private findHeritageClasses(declaration: idl.IDLInterface, heritageClasses: string[] = []): string[] | undefined {
        const superClassType = getSuper(declaration, this.library)
        if (superClassType) {
            let superClassName = superClassType.name
            heritageClasses.push(superClassName)

            if (Skoala.isBaseClass(superClassName)) {
                return heritageClasses
            } else {
                if (idl.isReferenceType(superClassType)) {
                    let superClassDecl = this.library.resolveTypeReference(superClassType)
                    if (superClassDecl && (idl.isInterface(superClassDecl))) {
                        return this.findHeritageClasses(superClassDecl, heritageClasses)
                    }
                }
            }
        }

        return undefined
    }

    isWrapper(node: idl.IDLInterface): boolean {
        return !!this.findHeritageClasses(node)
    }
}
