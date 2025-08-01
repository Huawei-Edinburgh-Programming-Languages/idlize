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

import * as path from 'node:path'
import {
    IDLBufferType,
    IDLI32Type,
    IDLUint8ArrayType,
    NamedMethodSignature,
    generatorConfiguration,
    Language,
    NativeModuleType,
    setDefaultConfiguration,
    PeerLibrary,
    Method,
    createReferenceType,
    IDLEntry,
    LayoutNodeRole,
    IDLPointerType,
    isMethod,
} from "@idlizer/core";
import {
    writeIntegratedFile,
    createMaterializedPrinter,
    printGlobal,
    readLangTemplate,
    NativeModule,
    TargetFile,
    install,
    printCJArkUIGeneratedNativeFunctions,
    PeerGeneratorConfiguration,
    createSerializerPrinter,
    createCallbackKindPrinter,
    PrinterResult,
    ImportsCollector,
    collectDeclItself,
    createDeserializeAndCallPrinter,
    createGeneratedNativeModulePrinter,
    printArkTSTypeChecker,
    createInterfacePrinter,
    createSpecialProducer,
    T,
} from '@idlizer/libohos'
import {
    printFiles as printFiles,
    installFiles,
    MakeSelector,
    producers,
    GeneratorContext,
    LWDeclaration,
    lw,
    moduleLike,
    OutputFile,
    processNPrintArkTS,
    lowLevelLike,
    processNPrintCXX,
    isManaged,
    isCApi,
    isNative,
    dumpToString,
    MANAGED_PREFIX,
    roles,
} from '@idlizer/libohos'
import { OhosInstall } from "./OhosInstall"
import { generateNativeOhos, suggestLibraryName } from './OhosNativeVisitor';
import { ohosLayout } from './OhosLayout';
import { printDataClasses } from './OhosDataClassVisitor';
import { EOL } from 'node:os';

export function generateOhos(outDir: string, peerLibrary: PeerLibrary, config: PeerGeneratorConfiguration) {
    const origGenConfig = generatorConfiguration()
    setDefaultConfiguration(config)
    peerLibrary.setFileLayout(ohosLayout(peerLibrary))

    const ohos = new OhosInstall(outDir, peerLibrary.language)

    const ohosManagedFiles: string[] = []

    // MANAGED
    /////////////////////////////////////////

    // install managed part
    const spreadIfLang = <T>(langs: Language[], ...data: T[]): T[] => {
        if (langs.includes(peerLibrary.language))
            return data
        return []
    }
    const printedFiles = printFiles(
        peerLibrary,
        [
            createCallbackKindPrinter(peerLibrary.language),
            createMaterializedPrinter(false),
            // createInterfacePrinter(false, false),
            printGlobal,
            printDataClasses,
            createSerializerPrinter(peerLibrary.language, ""),
            createDeserializeAndCallPrinter(peerLibrary.name, peerLibrary.language),
            createGeneratedNativeModulePrinter(NativeModule.Generated),
            ...spreadIfLang([Language.ARKTS], printArkTSTypeChecker),
        ]
    )
    const ostFiles = printOstFiles(peerLibrary)
    const installed = installFiles(ohos.managedDir(), mergeOutputFiles(printedFiles, ostFiles))

    // managed-index

    if ([Language.TS, Language.ARKTS].includes(peerLibrary.language)) {
        const generatedFiles = [...installed]
        ohosManagedFiles.forEach(it => {
            generatedFiles.push('./' + path.relative(ohos.managedDir(), it))
        })
        writeIntegratedFile(path.join(ohos.managedDir(), 'index.ts'),
            makeOhosModule(ohos.managedDir(), generatedFiles)
        )
    }

    // NATIVE
    /////////////////////////////////////////

    const native = generateNativeOhos(peerLibrary)
    for (const [ file, content ] of native) {
        writeIntegratedFile(ohos.native(file), content)
    }

    setDefaultConfiguration(origGenConfig)
}

function makeOhosModule(root:string, componentsFiles: string[]): string {
    return componentsFiles.map(file => {
        const relativePath = path.relative(root, file)
        const fileNameNoExt = relativePath.replaceAll(path.extname(file), "")
        return `export * from "./${fileNameNoExt}"`
    }).sort().join("\n")
}

function mergeOutputFiles(printedFiles: Map<string, OutputFile>, ostFiles: Map<string, OutputFile>): Map<string, OutputFile> {
    for (const [key, value] of printedFiles) {
        const ostValue = ostFiles.get(key) // ignore unknown files
        if (ostValue) {
            console.log("merging", key)
            value.imports.merge(ostValue.imports)
            value.content = value.content.concat(ostValue.content)
        }
    }
    return printedFiles
}

function printOstFiles(peerLibrary: PeerLibrary): Map<string, OutputFile> {
    const declarations = generateOstDeclarations(peerLibrary)
    const SPECIAL_PACKAGES = [
        [MANAGED_PREFIX, 'engine'].join('.')
      ]
    const knownPackages = peerLibrary.files.map(file => [MANAGED_PREFIX].concat(file.packageClause).join('.'))
    return printOstDeclarations(declarations, new Set(knownPackages.concat(SPECIAL_PACKAGES)))
}

function generateOstDeclarations(peerLibrary: PeerLibrary): LWDeclaration[] {
    const selector = new MakeSelector()

    selector.register(producers.native.serializerProducer)
    selector.register(producers.managed.serializerProducer)

    // selector.register(producers.native.structureProducer)
    // selector.register(producers.native.bridgeProducer)

    selector.register(producers.managed.fileProducer)
    selector.register(producers.managed.referenceProducer)
    selector.register(producers.managed.structureProducer)
    selector.register(producers.managed.primitiveProducer)
    selector.register(producers.managed.containerProducer)
    selector.register(producers.managed.nativeModuleProducer)

    /// fallback producers
    selector.register(createSpecialProducer(
        { is: isMethod, role: roles.managed },
        (method, ctx) => {
          return { artifact: { reference: T.cc("MANAGED_METHOD_FALLBACK") } }
        }))
    selector.register(createSpecialProducer(
        { is: isMethod, role: roles.native },
        (method, ctx) => {
          return { artifact: { reference: T.cc("NATIVE_METHOD_FALLBACK") } }
        }))

    const ctx = new GeneratorContext(peerLibrary.files, selector)
    return ctx.generate(peerLibrary.files)
}


function printOstDeclarations(decls: lw.LWDeclaration[], packages: Set<string>): Map<string, OutputFile> {
    const selectors = [ isManaged, isCApi, isNative ]
    const buckets = selectors.map(predicate => [predicate, [] as lw.LWDeclaration[]] as const)

    decls.forEach(decl => {
        for (const [predicate, bucket] of buckets) {
            if (predicate(decl.name)) {
                bucket.push(decl)
                return
            }
        }
        console.error(dumpToString(decl))
        throw new Error("Can not process generated code!")
    })
    const [ managed, cApi, native ] = buckets.map(e => e[1])

    const tsFiles = dumpTsLike(managed, packages)
    const cFiles = dumpCLike(cApi)
    const nativeFiles = dumpAsIs(native)
    return tsFiles /// ...cFiles, ...nativeFiles])
}

function mapOstFileName(name: string): string | undefined {
    return name
        .replace(/^managed\./, '')
        .replace(/^native\./, '')
        // .replace(/^engine/, generatorConfiguration().moduleName + ".INTERNAL")
}

function dumpTsLike(decls: lw.LWDeclaration[], packages: Set<string>): Map<string, OutputFile> {
    decls = moduleLike.postprocess(decls)
    const files = moduleLike.formFiles(packages, decls)
    const result: Map<string, OutputFile> = new Map()
    files.forEach((content, name) => {
        const mappedName = mapOstFileName(name)
        if (!mappedName)
            return
        const imports = new ImportsCollector()
        content.moduleLikeImports.forEach((vals, source) =>
            imports.addFeatures(Array.from(vals), `./${source}`))
        const printed = content.body.map(processNPrintArkTS)///langs
        result.set(mappedName, {
            imports,
            content: printed,
            extension: ".ets",
            exported: false,
        })
    })
    return result
}

function dumpCLike(decls: lw.LWDeclaration[]) {
    decls = lowLevelLike.postprocess(decls)
    console.log("===================== C-API =====================")
    decls.forEach(decl => {
        console.log(processNPrintCXX(decl))
    })
}

function dumpAsIs(decls: lw.LWDeclaration[]) {
    console.log("==================== NATIVE ====================")
    decls.forEach(decl => {
        console.log(processNPrintCXX(decl))
    })
}
