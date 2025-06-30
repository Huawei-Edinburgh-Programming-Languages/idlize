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

import * as idl from '../idl'
import { resolveNamedNode } from '../resolveNamedNode'
import { Language } from '../Language'
import { LibraryInterface, LibraryBase } from '../LibraryInterface'
import { BuilderClass, isBuilderClass } from './BuilderClass'
import { generateSyntheticFunctionName, isImportAttr, qualifiedName } from './idl/common'
import { MaterializedClass } from './Materialized'
import { LayoutManager, LayoutManagerStrategy } from './LayoutManager'
import { IDLLibrary, lib, query } from '../library'
import { isInIdlizeInternal } from '../idlize'
import { isInCurrentModule } from './modules'
import { generatorConfiguration } from '../config'
import { isExternalType } from './isExternalType'
import { KotlinTypeNameConvertor } from '../LanguageWriters/convertors/KotlinConvertors'
import { NativeModuleType } from '../LanguageWriters/common'
import { ArgConvertor, BooleanConvertor, CustomTypeConvertor, DateConvertor, FunctionConvertor, NumberConvertor, NumericConvertor, ObjectConvertor, OptionConvertor, PointerConvertor, StringConvertor } from '../LanguageWriters/ArgConvertors'

export interface GlobalScopeDeclarations {
    methods: idl.IDLMethod[]
    constants: idl.IDLConstant[]
}

export const lenses = {
    globals: lib.lens(lib.select.files())
        .pipe(lib.select.nodes())
        .pipe(lib.req('globals', (nodes: idl.IDLNode[]): GlobalScopeDeclarations[] => {
            const result: GlobalScopeDeclarations[] = []
            const queue: idl.IDLNode[][] = [nodes]
            while (queue.length) {
                const line: GlobalScopeDeclarations = {
                    constants: [],
                    methods: []
                }
                const next = queue.pop()!
                next.forEach(node => {
                    if (!isInCurrentModule(node))
                        return
                    if (idl.isNamespace(node)) {
                        queue.push(node.members)
                    }
                    if (idl.isConstant(node)) {
                        line.constants.push(node)
                    }
                    if (idl.isMethod(node)) {
                        line.methods.push(node)
                    }

                })
                if (line.constants.length || line.methods.length) {
                    result.push(line)
                }
            }
            return result
        }))
}

export class PeerLibrary extends LibraryBase implements LibraryInterface {
    private _cachedIdlLibrary?: IDLLibrary
    asIDLLibrary(): IDLLibrary {
        if (this._cachedIdlLibrary) {
            return this._cachedIdlLibrary
        }
        this._cachedIdlLibrary = {
            files: this.files.map(file => file)
        }
        return this._cachedIdlLibrary
    }

    public get globals() {
        return query(this.asIDLLibrary(), lenses.globals)
    }

    public layout: LayoutManager = LayoutManager.Empty()

    private _syntheticFile: idl.IDLFile = idl.createFile([])
    public initSyntheticEntries(file: idl.IDLFile) {
        this._syntheticFile = file
    }
    public getSyntheticData() {
        return this._syntheticFile.entries.filter(it => idl.isInterface(it)) as idl.IDLInterface[]
    }

    public readonly auxFiles: idl.IDLFile[] = []
    public readonly builderClasses: Map<string, BuilderClass> = new Map()
    public get buildersToGenerate(): BuilderClass[] {
        return Array.from(this.builderClasses.values()).filter(it => it.needBeGenerated)
    }

    public readonly materializedClasses: Map<string, MaterializedClass> = new Map()
    public get orderedMaterialized(): MaterializedClass[] {
        function accessorName(decl: idl.IDLEntry): string {
            return idl.getQualifiedName(decl, "namespace.name")
        }
        return Array.from(this.materializedClasses.values()).filter(it => it.needBeGenerated)
            .sort((a, b) => accessorName(a.decl).localeCompare(accessorName(b.decl)))
    }

    constructor(
        language: Language,
        interopNativeModule: NativeModuleType,
        useMemoM3: boolean = false,
    ) {
        super(language, interopNativeModule, useMemoM3)
    }

    public name: string = ""

    get libraryPrefix(): string {
        return this.name ? this.name + "_" : ""
    }

    toDeclaration(type: idl.IDLType | idl.IDLTypedef | idl.IDLCallback | idl.IDLEnum | idl.IDLInterface): idl.IDLEntry | idl.IDLType {
        if (idl.isReferenceType(type)) {
            // TODO: remove all this!
            if (type.name === 'Date') {
                return idl.IDLDate
            }
            if (type.name === 'AnimationRange') {
                return idl.IDLCustomObjectType
            }
            if (type.name === 'Function') {
                return idl.IDLFunctionType
            }
            if (type.name === 'Optional') {
                return this.toDeclaration((type as idl.IDLReferenceType).typeArguments![0])
            }
        }

        return super.toDeclaration(type)
    }

    typeConvertor(param: string, type: idl.IDLType, isOptionalParam = false): ArgConvertor {
        if (idl.isReferenceType(type)) {
            // TODO: special cases for interop types.
            // TODO: this types are not references! NativeModulePrinter must be fixed
            switch (type.name.replaceAll('%TEXT%:', '')) { // this is really bad stub, to fix legacy references
                case 'KBoolean': return new BooleanConvertor(param)
                case 'KInt': return new NumericConvertor(param, idl.IDLI32Type)
                case 'KFloat': return new NumericConvertor(param, idl.IDLF32Type)
                case 'KLong': return new NumericConvertor(param, idl.IDLI64Type)
                case 'KDouble': return new NumericConvertor(param, idl.IDLF64Type)
                case 'KStringPtr': return new StringConvertor(param)
                case 'number': return new NumberConvertor(param)
                case 'KPointer': return new PointerConvertor(param)
            }
        }

        return super.typeConvertor(param, type, isOptionalParam)
    }

    protected customConvertor(param: string, typeName: string, type: idl.IDLReferenceType): ArgConvertor | undefined {
        switch (typeName) {
            case `Object`:
                return new ObjectConvertor(param, idl.IDLObjectType)
            case `Date`:
                return new DateConvertor(param)
            case `Function`:
                return new FunctionConvertor(this, param)
            case `Record`:
                return new CustomTypeConvertor(param, "Record", false, "Record<string, string>")
            case `Optional`:
                return new OptionConvertor(this, param, type.typeArguments![0])
        }
        return undefined
    }

    declarationConvertor(param: string, type: idl.IDLReferenceType, declaration: idl.IDLEntry | undefined): ArgConvertor {
        let customConv = this.customConvertor(param, type.name, type)
        if (customConv)
            return customConv

        return super.declarationConvertor(param, type, declaration)
    }

    createContinuationParameters(continuationType: idl.IDLType): idl.IDLParameter[] {
        const continuationParameters: idl.IDLParameter[] = []
        if (idl.isContainerType(continuationType) && idl.IDLContainerUtils.isPromise(continuationType)) {
            const errorType = idl.createOptionalType(idl.createContainerType("sequence", [idl.IDLStringType]))
            continuationParameters.push(idl.createParameter("error", errorType, true))
            const promise = continuationType as idl.IDLContainerType
            if (!idl.isVoidType(promise.elementType[0])) {
                const valueType = idl.createOptionalType(promise.elementType[0])
                continuationParameters.unshift(idl.createParameter("value", valueType, true))
            }
        } else if (!idl.isVoidType(continuationType))
            continuationParameters.push(idl.createParameter('value', continuationType))
        return continuationParameters
    }

    // override createContinuationCallbackReference(continuationType: idl.IDLType): idl.IDLReferenceType {
    //     const continuationParameters = this.createContinuationParameters(continuationType)
    //     const syntheticName = generateSyntheticFunctionName(
    //         continuationParameters,
    //         idl.IDLVoidType,
    //     )
    //     return idl.createReferenceType(syntheticName)
    // }

    // private context: string | undefined
    // getCurrentContext(): string | undefined {
    //     return this.context
    // }

    // setCurrentContext(context: string | undefined) {
    //     this.context = context
    // }

    // findFileByOriginalFilename(filename: string): idl.IDLFile | undefined {
    //     return this.files.find(it => it.fileName === filename)
    // }

    // mapType(type: idl.IDLType): string {
    //     return this.targetNameConvertorInstance.convert(type)
    // }

    private referenceCache: Map<idl.IDLReferenceType | string, idl.IDLEntry | undefined> | undefined
    public enableCache() {
        this.referenceCache = new Map()
    }

    override resolveTypeReference(type: idl.IDLReferenceType, singleStep?: boolean): idl.IDLEntry | undefined {
        const key = type.parent ? type : type.name // does entry have resolve context or just FQN
        let result: idl.IDLEntry | undefined = this.referenceCache?.has(key)
            ? this.referenceCache.get(key)
            : this.resolveTypeReferenceUncached(type, singleStep)
        this.referenceCache?.set(key, result)
        return result
    }

    private resolveTypeReferenceUncached(type: idl.IDLReferenceType, singleStep?: boolean): idl.IDLEntry | undefined {
        if (this.referenceCache?.has(type))
            return this.referenceCache.get(type)
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

        this.referenceCache?.set(type, result)
        return result
    }

    private _useFallback = true
    disableFallback() {
        this._useFallback = false
    }

    protected override resolveNamedNode(target: string[], pov: idl.IDLNode | undefined = undefined): idl.IDLEntry | undefined {
        const qualifiedName = target.join(".")
        const entry = this._syntheticFile.entries.find(it => it.name === qualifiedName)
        if (entry)
            return entry

        if (1 === target.length) {
            const predefined = this.files.flatMap(it => it.entries).filter(isInIdlizeInternal)
            const found = predefined.find(it => it.name === target.at(-1))
            if (found) // here
                return found;
        }

        const corpus = this.files.concat(this.auxFiles)

        let result = resolveNamedNode(target, pov, corpus)
        if (result && idl.isEntry(result))
            return result

        if (1 == target.length) {
            const stdScopes = generatorConfiguration().globalPackages.map(it => it.split('.'))
            for (const stdScope of stdScopes) {
                result = resolveNamedNode([...stdScope, ...target], undefined, corpus)
                if (result && idl.isEntry(result))
                    return result
            }
        }

        // TODO: remove the next block after namespaces out of quarantine
        if (this._useFallback) {
            const povAsReadableString = pov
                ? `'${idl.getFQName(pov)}'`
                : "[root]"

            // retry from root
            pov = undefined
            const resolveds: idl.IDLNode[] = []
            for (let file of this.files) {
                result = resolveNamedNode([...file.packageClause, ...target], pov, corpus)
                if (result && idl.isEntry(result)) {
                    // too much spam
                    // console.warn(`WARNING: Type reference '${qualifiedName}' is not resolved from ${povAsReadableString} but resolved from some package '${file.packageClause().join(".")}'`)
                    resolveds.push(result)
                }
            }

            // and from each namespace
            const traverseNamespaces = (entry: idl.IDLEntry) => {
                if (entry && idl.isNamespace(entry) && entry.members.length) {
                    const resolved = resolveNamedNode([...idl.getNamespacesPathFor(entry).map(it => it.name), ...target], pov, corpus)
                    if (resolved) {
                        console.warn(`WARNING: Name '${qualifiedName}' is not resolved from ${povAsReadableString} but resolved from some namespace: '${idl.getNamespacesPathFor(resolved).map(obj => obj.name).join(".")}'`)
                        resolveds.push(resolved)
                    }
                    entry.members.forEach(traverseNamespaces)
                }
            }
            this.files.forEach(file => file.entries.forEach(traverseNamespaces))

            for (const resolved of resolveds)
                if (idl.isEntry(resolved))
                    return resolved
        }// end of block to remove

        return undefined
    }

    setFileLayout(strategy: LayoutManagerStrategy) {
        this.layout = new LayoutManager(strategy)
    }
}
