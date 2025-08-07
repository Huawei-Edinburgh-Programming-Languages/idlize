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
} from '@idlizer/libohos'
import {
    printFiles as printFiles,
    installFiles,
    OutputFile,
} from '@idlizer/libohos'
import { OhosInstall } from "./OhosInstall"
import { generateNativeOhos } from './OhosNativeVisitor';
import { ohosLayout } from './OhosLayout';
import { printDataClasses } from './OhosDataClassVisitor';
import { printOstFiles } from './ohos-ost';

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

function mergeOutputFiles(files0: Map<string, OutputFile>, files1: Map<string, OutputFile>): Map<string, OutputFile> {
    for (const [key, value] of files0) {
        const value1 = files1.get(key) // ignore unknown files
        if (value1) {
            console.log("merging", key)
            value.imports.merge(value1.imports)
            value.content = value.content.concat(value1.content)
        }
    }
    return files0
}
