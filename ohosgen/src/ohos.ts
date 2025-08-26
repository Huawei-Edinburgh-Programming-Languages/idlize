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
    generatorConfiguration,
    Language,
    setDefaultConfiguration,
    PeerLibrary,
    createReferenceType,
    IDLEntry,
    LayoutNodeRole,
} from "@idlizer/core";
import {
    writeIntegratedFile,
    createMaterializedPrinter,
    printGlobal,
    readLangTemplate,
    NativeModule,
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
    TargetFile,
} from '@idlizer/libohos'
import {
    printFiles,
    installFiles,
    OutputFile,
} from '@idlizer/libohos'
import { OhosInstall } from "./OhosInstall"
import { generateNativeOhos } from './OhosNativeVisitor';
import { ohosLayout } from './OhosLayout';
import { printDataClasses } from './OhosDataClassVisitor';
import { printOstFiles } from './ohos-ost';

function printCallbackChecker(peerLibrary: PeerLibrary): PrinterResult[] {
    const content = peerLibrary.createLanguageWriter(peerLibrary.language)
    content.writeLines(readLangTemplate('CallbacksChecker', peerLibrary.language))
    const imports = new ImportsCollector()
    imports.addFeatures(["InteropNativeModule", "ResourceHolder", "KBuffer"], "@koalaui/interop")
    collectDeclItself(peerLibrary, createReferenceType("DeserializerBase"), imports)
    collectDeclItself(peerLibrary, createReferenceType("deserializeAndCallCallback"), imports)
    return [{
        over: {
            node: peerLibrary.resolveTypeReference(createReferenceType("checkArkoalaCallbacks")) as IDLEntry,
            role: LayoutNodeRole.PEER
        },
        collector: imports,
        content: content,
    }]
}

export function generateOhos(outDir: string, peerLibrary: PeerLibrary, useOst: boolean, config: PeerGeneratorConfiguration) {
    const origGenConfig = generatorConfiguration()
    setDefaultConfiguration(config)
    peerLibrary.setFileLayout(ohosLayout(peerLibrary))

    const ohos = new OhosInstall(outDir, peerLibrary.language)

    // MANAGED
    /////////////////////////////////////////

    // install managed part
    const spread = <T>(cond: boolean, ...data: T[]): T[] => {
        return cond ? data : []
    }
    let printedFiles = printFiles(
        peerLibrary,
        [
            createCallbackKindPrinter(peerLibrary.language),
            createMaterializedPrinter(false),
            ...spread(!useOst,
                createInterfacePrinter(false, false),
                printDataClasses,
                printGlobal,
                createSerializerPrinter(peerLibrary.language, "")),
            printCallbackChecker,
            createDeserializeAndCallPrinter(peerLibrary.name, peerLibrary.language),
            createGeneratedNativeModulePrinter(NativeModule.Generated),
            ...spread(!useOst && peerLibrary.language === Language.ARKTS, printArkTSTypeChecker),
        ]
    )
    let nativeFiles: Map<TargetFile, string> | undefined
    if (useOst) {
        const [tsFiles, cFiles] = printOstFiles(peerLibrary)
        printedFiles = mergeOutputFiles(printedFiles, tsFiles)
        nativeFiles = cFiles
    }
    const installed = installFiles(ohos.managedDir(), printedFiles)

    // managed-index

    if ([Language.TS, Language.ARKTS].includes(peerLibrary.language)) {
        writeIntegratedFile(path.join(ohos.managedDir(), 'index.ts'),
            makeOhosModule(ohos.managedDir(), installed)
        )
    }

    // NATIVE
    /////////////////////////////////////////

    nativeFiles ??= generateNativeOhos(peerLibrary)
    for (const [ file, content ] of nativeFiles) {
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

function mergeOutputFiles(files0: Map<string, OutputFile>, files1: Map<string, OutputFile>): Map<string, OutputFile> {
    for (const [file, output] of files1) {
        // ignore junk
        if (file.startsWith('idlize.'))
            continue
        /// probably need to take useFoldersLayout and moduleName into account somewhere else
        const output0 = files0.get(file)
        if (output0) { // ignore unknown files
            console.log('[ merged ]', file)
            output0.imports.merge(output.imports)
            output0.content.push(...output.content)
        } else {
            console.log('[ ostgen ]', file)
            files0.set(file, output)
        }
    }
    return files0
}
