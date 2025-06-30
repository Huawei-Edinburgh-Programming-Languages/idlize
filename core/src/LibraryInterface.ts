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

import * as idl from "./idl"
import { Language } from "./Language";
import { createLanguageWriter, IdlNameConvertor } from "./LanguageWriters";
import { ReferenceResolver } from "./peer-generation/ReferenceResolver";
import { AggregateConvertor, ArgConvertor, ArrayConvertor, BigIntToU64Convertor, BooleanConvertor, BufferConvertor, CallbackConvertor, ClassConvertor, CustomTypeConvertor, DateConvertor, EnumConvertor, ExternalTypeConvertor, FunctionConvertor, ImportTypeConvertor, InterfaceConvertor, MapConvertor, MaterializedClassConvertor, NumberConvertor, NumericConvertor, ObjectConvertor, OptionConvertor, PointerConvertor, StringConvertor, TupleConvertor, TypeAliasConvertor, UndefinedConvertor, UnionConvertor, VoidConvertor } from "./LanguageWriters/ArgConvertors";
import { generatorConfiguration } from "./config";
import { generateSyntheticFunctionName, isImportAttr } from "./peer-generation/idl/common";
import { warn } from "./util";
import { isExternalType } from "./peer-generation/isExternalType";
import { isMaterialized } from "./peer-generation/isMaterialized";
import { BuilderClass, isBuilderClass } from "./peer-generation/BuilderClass";
import { resolveNamedNode } from "./resolveNamedNode";
import { TSTypeNameConvertor } from "./LanguageWriters/convertors/TSConvertors";
import { ETSTypeNameConvertor } from "./LanguageWriters/convertors/ETSConvertors";
import { JavaTypeNameConvertor } from "./LanguageWriters/convertors/JavaConvertors";
import { CJTypeNameConvertor } from "./LanguageWriters/convertors/CJConvertors";
import { CppConvertor, CppNameConvertor } from "./LanguageWriters/convertors/CppConvertors";
import { KotlinTypeNameConvertor } from "./LanguageWriters/convertors/KotlinConvertors";
import { LanguageWriter } from "./LanguageWriters/LanguageWriter";
import { MaterializedClass } from "./peer-generation/Materialized";
import { GlobalScopeDeclarations } from "./peer-generation/PeerLibrary";
import { LayoutManager, LayoutManagerStrategy } from "./peer-generation/LayoutManager";
import { isInIdlizeInternal } from "./idlize";
import { NativeModuleType } from "./LanguageWriters/common";

export interface LibraryInterface extends ReferenceResolver {
    language: Language
    name: string
    get libraryPrefix(): string
    get files(): idl.IDLFile[]
    auxFiles: idl.IDLFile[]
    globals: GlobalScopeDeclarations[]
    layout: LayoutManager
    setFileLayout(strategy: LayoutManagerStrategy): void
    useMemoM3: boolean
    interopNativeModule: NativeModuleType

    materializedClasses: Map<string, MaterializedClass>
    orderedMaterialized: MaterializedClass[]

    builderClasses: Map<string, BuilderClass>
    get buildersToGenerate(): BuilderClass[]

    mapType(type: idl.IDLType): string
    typeConvertor(param: string, type: idl.IDLType, isOptionalParam?: boolean): ArgConvertor
    declarationConvertor(param: string, type: idl.IDLReferenceType, declaration: idl.IDLEntry | undefined): ArgConvertor
    resolveTypeReference(type: idl.IDLReferenceType, singleStep?: boolean): idl.IDLEntry | undefined

    getInteropName(node: idl.IDLNode): string
    createLanguageWriter(language?: Language): LanguageWriter
    createTypeNameConvertor(language: Language): IdlNameConvertor
    getCurrentContext(): string | undefined
    setCurrentContext(value: string | undefined): void
    initSyntheticEntries(file: idl.IDLFile): void
    // createContinuationCallbackReference(continuationType: idl.IDLType): idl.IDLReferenceType
    findFileByOriginalFilename(filename: string): idl.IDLFile | undefined
}

export class LibraryBase implements LibraryInterface {
    constructor(public language: Language, 
        public interopNativeModule: NativeModuleType,
        public useMemoM3: boolean = true
    ) { }
    
    public readonly files: idl.IDLFile[] = []
    public readonly auxFiles: idl.IDLFile[] = []
    public name = "LibraryBase"
    get libraryPrefix(): string {
        return this.name + "_"
    }
    public layout: LayoutManager = LayoutManager.Empty()
    protected readonly targetNameConvertorInstance: IdlNameConvertor = this.createTypeNameConvertor(this.language)
    protected readonly interopNameConvertorInstance: IdlNameConvertor = new CppNameConvertor(this)

    public materializedClasses = new Map<string, MaterializedClass>()
    public readonly builderClasses: Map<string, BuilderClass> = new Map()
    
    public get buildersToGenerate(): BuilderClass[] {
        return Array.from(this.builderClasses.values())
    }

    public get orderedMaterialized(): MaterializedClass[] {
        return Array.from(this.materializedClasses.values())
    }

    private _globals: GlobalScopeDeclarations[] = []
    public get globals(): GlobalScopeDeclarations[] {
        return this._globals
    }

    initSyntheticEntries(file: idl.IDLFile): void {
        return
    }

    setFileLayout(strategy: LayoutManagerStrategy) {
        this.layout = new LayoutManager(strategy)
    }
    
    createLanguageWriter(language?: Language): LanguageWriter {
        return createLanguageWriter(language ?? this.language, this)
    }

    findFileByOriginalFilename(filename: string): idl.IDLFile | undefined {
        return this.files.find(it => it.fileName === filename)
    }

    createTypeNameConvertor(language: Language): IdlNameConvertor {
        switch (language) {
            case Language.TS: return new TSTypeNameConvertor(this)
            case Language.ARKTS: return new ETSTypeNameConvertor(this)
            case Language.JAVA: return new JavaTypeNameConvertor(this)
            case Language.CJ: return new CJTypeNameConvertor(this)
            case Language.CPP: return new CppConvertor(this)
            case Language.KOTLIN: return new KotlinTypeNameConvertor(this)
        }
        throw new Error(`IdlNameConvertor for ${language} is not implemented`)
    }

    mapType(type: idl.IDLType): string {
        return this.targetNameConvertorInstance.convert(type)
    }

    toDeclaration(type: idl.IDLType | idl.IDLTypedef | idl.IDLCallback | idl.IDLEnum | idl.IDLInterface): idl.IDLEntry | idl.IDLType {
        switch (type) {
            case idl.IDLAnyType: return idl.IDLCustomObjectType
            case idl.IDLVoidType: return idl.IDLVoidType
            case idl.IDLUndefinedType: return idl.IDLUndefinedType
            case idl.IDLUnknownType: return idl.IDLCustomObjectType
        }
        const typeName = idl.isNamedNode(type) ? type.name : undefined
        switch (typeName) {
            case "object":
            case "Object": return idl.IDLObjectType
        }
        if (idl.isReferenceType(type)) {
            const decl = this.resolveTypeReference(type)
            if (!decl) {
                warn(`undeclared type ${idl.DebugUtils.debugPrintType(type)}`)
            }
            if (decl && idl.isTypedef(decl) && isCyclicTypeDef(decl)) {
                warn(`Cyclic typedef: ${idl.DebugUtils.debugPrintType(type)}`)
                return idl.IDLCustomObjectType
            }
            return !decl ? idl.IDLCustomObjectType  // assume some builtin type
                : idl.isTypedef(decl) ? this.toDeclaration(decl.type)
                    : decl
        }
        if (isImportAttr(type)) {
            return idl.IDLCustomObjectType
        }
        return type
    }

    resolveTypeReference(type: idl.IDLReferenceType, singleStep?: boolean): idl.IDLEntry | undefined {
        let result = this.resolveNamedNode(type.name.split("."), type.parent)
        if (!singleStep) {
            const seen = new Set<idl.IDLEntry>
            while (result) {
                let nextResult: idl.IDLEntry | undefined = undefined
                if (idl.isImport(result))
                    nextResult = this.resolveImport(result)
                else if (idl.isReferenceType(result))
                    nextResult = this.resolveNamedNode(result.name.split("."))
                else if (idl.isTypedef(result) && idl.isReferenceType(result.type))
                    nextResult = this.resolveNamedNode(result.type.name.split("."))

                if (!nextResult)
                    break;

                if (seen.has(nextResult)) {
                    console.warn(`Cyclic referenceType: ${type.name}, seen: [${[...seen.values()].map(idl.getFQName).join(", ")}]`)
                    break;
                }
                seen.add(nextResult)
                result = nextResult
            }
        }
        if (result && (idl.isImport(result) || idl.isNamespace(result)))
            result = undefined

        return result
    }

    protected resolveNamedNode(target: string[], pov: idl.IDLNode | undefined = undefined): idl.IDLEntry | undefined {
        const qualifiedName = target.join(".")

        if (1 === target.length) {
            const predefined = this.files.flatMap(it => it.entries).filter(isInIdlizeInternal)
            const found = predefined.find(it => it.name === target.at(-1)) // here is Serializer
            if (found)
                return found;
        }

        // const corpus = this.files
        const corpus = this.files.concat(this.auxFiles)

        let result = resolveNamedNode(target, pov, corpus)
        if (result && idl.isEntry(result))
            return result

        // TODO: remove the next block after namespaces out of quarantine
        {
            const povAsReadableString = pov
                ? `'${idl.getFQName(pov)}'`
                : "[root]"

            // retry from root
            if (pov) {
                pov = undefined
                for (let file of this.files) {
                    result = resolveNamedNode([...file.packageClause, ...target], pov, corpus)
                    if (result && idl.isEntry(result)) {
                        // too much spam
                        // console.log(`WARNING: Type reference '${type.name}' is not resolved from ${povAsReadableString} but resolved from some package '${file.packageClause().join(".")}'`)
                        return result
                    }
                }
            }

            // and from each namespace
            const resolveds: idl.IDLNode[] = []
            const traverseNamespaces = (entry: idl.IDLEntry) => {
                if (entry && idl.isNamespace(entry) && entry.members.length) {
                    const resolved = resolveNamedNode([...idl.getNamespacesPathFor(entry).map(it => it.name), ...target], pov, corpus)
                    if (resolved)
                        resolveds.push(resolved)
                    entry.members.forEach(traverseNamespaces)
                }
            }
            this.files.forEach(file => file.entries.forEach(traverseNamespaces))

            for (const resolved of resolveds)
                console.log(`WARNING: Name '${qualifiedName}' is not resolved from ${povAsReadableString} but resolved from some namespace: '${idl.getNamespacesPathFor(resolved).map(obj => obj.name).join(".")}'`)

            for (const resolved of resolveds)
                if (idl.isEntry(resolved))
                    return resolved
        }// end of block to remove

        return undefined
    }

    protected resolveImport(target: idl.IDLImport): idl.IDLEntry | undefined {
        let result = this.resolveNamedNode(target.clause)
        if (result) {
            if (idl.isReferenceType(result))
                return this.resolveTypeReference(result)
            if (idl.isImport(result)) {
                if (result == target) {
                    console.log("Self-targeted Import?")
                    return undefined
                }
                return this.resolveImport(result)
            }
            if (idl.isEntry(result))
                return result
        }
        return undefined
    }

    typeConvertor(param: string, type: idl.IDLType, isOptionalParam = false): ArgConvertor {
        if (isOptionalParam) {
            return new OptionConvertor(this, param, idl.maybeUnwrapOptionalType(type))
        }
        if (idl.isOptionalType(type)) {
            return new OptionConvertor(this, param, type.type)
        }
        if (idl.isPrimitiveType(type)) {
            switch (type) {
                case idl.IDLI8Type: return new NumericConvertor(param, type)
                case idl.IDLU8Type: return new NumericConvertor(param, type)
                case idl.IDLI16Type: return new NumericConvertor(param, type)
                case idl.IDLU16Type: return new NumericConvertor(param, type)
                case idl.IDLI32Type: return new NumericConvertor(param, type)
                case idl.IDLU32Type: return new NumericConvertor(param, type)
                case idl.IDLI64Type: return new NumericConvertor(param, type)
                case idl.IDLU64Type: return new NumericConvertor(param, type)
                case idl.IDLF16Type: return new NumericConvertor(param, type)
                case idl.IDLF32Type: return new NumericConvertor(param, type)
                case idl.IDLF64Type: return new NumericConvertor(param, type)
                case idl.IDLBigintType: return new BigIntToU64Convertor(param)
                case idl.IDLSerializerBuffer: new PointerConvertor(param)
                case idl.IDLPointerType: return new PointerConvertor(param)
                case idl.IDLBufferType: return new BufferConvertor(param)
                case idl.IDLBooleanType: return new BooleanConvertor(param)
                case idl.IDLStringType: return new StringConvertor(param)
                case idl.IDLNumberType: return new NumberConvertor(param)
                case idl.IDLUndefinedType: return new UndefinedConvertor(param)
                case idl.IDLVoidType: return new VoidConvertor(param)
                case idl.IDLUnknownType:
                case idl.IDLObjectType:
                case idl.IDLAnyType: return new ObjectConvertor(param, idl.IDLAnyType)
                case idl.IDLDate: return new DateConvertor(param)

                case idl.IDLFunctionType: return new FunctionConvertor(this, param)
                default: throw new Error(`Unconverted primitive ${idl.DebugUtils.debugPrintType(type)}`)
            }
        }
        if (idl.isReferenceType(type)) {
            if (generatorConfiguration().forceResource.includes(type.name)) {
                return new ObjectConvertor(param, type)
            }
            const decl = this.resolveTypeReference(type)
            if (decl && isImportAttr(decl) || !decl && isImportAttr(type))
                return new ImportTypeConvertor(param, this.targetNameConvertorInstance.convert(type))
            return this.declarationConvertor(param, type, decl)
        }
        if (idl.isUnionType(type)) {
            return new UnionConvertor(this, param, type)
        }
        if (idl.isContainerType(type)) {
            if (idl.IDLContainerUtils.isSequence(type))
                return new ArrayConvertor(this, param, type, type.elementType[0])
            if (idl.IDLContainerUtils.isRecord(type))
                return new MapConvertor(this, param, type, type.elementType[0], type.elementType[1])
        }
        if (idl.isTypeParameterType(type)) {
            // TODO: unlikely correct.
            return new CustomTypeConvertor(param, this.targetNameConvertorInstance.convert(type), true, `<${type.name}>`)
        }
        throw new Error(`Cannot convert: ${type.kind}`)
    }

    declarationConvertor(param: string, type: idl.IDLReferenceType, declaration: idl.IDLEntry | undefined): ArgConvertor {
        if (generatorConfiguration().forceResource.includes(type.name)) {
            return new ObjectConvertor(param, type)
        }
        if (!declaration) {
            return new CustomTypeConvertor(param, this.targetNameConvertorInstance.convert(type), false, this.targetNameConvertorInstance.convert(type)) // assume some predefined type
        }

        const declarationName = declaration.name!
        if (isImportAttr(declaration)) {
            return new ImportTypeConvertor(param, this.targetNameConvertorInstance.convert(type))
        }
        if (idl.isImport(declaration)) {
            const target = this.resolveImport(declaration)
            if (target && idl.isEntry(target))
                return this.declarationConvertor(param, type, target)
            else {
                warn(`Unable to resolve Import ${declaration.clause.join(".")} as ${declaration.name}`)
                return new CustomTypeConvertor(param, declaration.name, false, declaration.name)
            }
        }
        if (idl.isEnum(declaration)) {
            return new EnumConvertor(param, declaration)
        }
        if (idl.isEnumMember(declaration)) {
            return new EnumConvertor(param, declaration.parent)
        }
        if (idl.isCallback(declaration)) {
            return new CallbackConvertor(this, param, declaration, this.interopNativeModule)
        }
        if (idl.isTypedef(declaration)) {
            if (isCyclicTypeDef(declaration)) {
                warn(`Cyclic typedef: ${idl.DebugUtils.debugPrintType(type)}`)
                return new CustomTypeConvertor(param, declaration.name, false, declaration.name)
            }
            return new TypeAliasConvertor(this, param, declaration)
        }
        if (idl.isInterface(declaration)) {
            if (isExternalType(declaration, this)) {
                return new ExternalTypeConvertor(this, param, declaration)
            }
            if (isMaterialized(declaration, this)) {
                return new MaterializedClassConvertor(this, param, declaration)
            }
            if (isBuilderClass(declaration)) {
                return new ClassConvertor(this, declarationName, param, declaration)
            }
            switch (declaration.subkind) {
                case idl.IDLInterfaceSubkind.Interface:
                case idl.IDLInterfaceSubkind.Class:
                    return new InterfaceConvertor(this, declarationName, param, declaration)
                case idl.IDLInterfaceSubkind.AnonymousInterface:
                    return new AggregateConvertor(this, param, type, declaration as idl.IDLInterface)
                case idl.IDLInterfaceSubkind.Tuple:
                    return new TupleConvertor(this, param, type, declaration as idl.IDLInterface)
            }
        }
        throw new Error(`Unknown decl ${declarationName} of kind ${declaration.kind}`)
    }

    // createContinuationCallbackReference(continuationType: idl.IDLType): idl.IDLReferenceType {
    //     if (idl.isContainerType(continuationType) && idl.IDLContainerUtils.isPromise(continuationType))
    //         return this.createContinuationCallbackReference(continuationType.elementType[0])
    //     const continuationParameters = idl.isVoidType(continuationType) ? [] : [idl.createParameter('value', continuationType)]
    //     const syntheticName = generateSyntheticFunctionName(
    //         continuationParameters,
    //         idl.IDLVoidType,
    //     )
    //     return idl.createReferenceType(syntheticName)
    // }

    protected context: string | undefined = ""
    getCurrentContext(): string | undefined {
        return this.context
    }

    setCurrentContext(value: string | undefined): void {
        this.context = value
    }

    getInteropName(node: idl.IDLNode): string {
        return this.interopNameConvertorInstance.convert(node)
    }
}

function isCyclicTypeDef(decl: idl.IDLTypedef): boolean {
    return idl.isReferenceType(decl.type) && idl.isNamedNode(decl.type) && decl.type.name == decl.name
}
