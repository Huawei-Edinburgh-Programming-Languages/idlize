/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import * as path from "path"
import * as fs from "fs"
import { Language, LibraryInterface } from "@idlizer/core";
import { copyFile, createGeneratedNativeModulePrinter, createInterfacePrinter, createMaterializedPrinter, createSerializerPrinter, install, NativeModule, printGlobal } from "@idlizer/libohos";
import { skoalaLayout } from "./SkoalaLayout";
import { printComponents } from "./printers/ComponentsPrinter"
import { createSkoalaInstall, SkoalaInstall } from "./SkoalaInstall";
import { createPeersPrinter } from "./printers/PeerPrinter";

const Subset = path.join(__dirname, "../subset")

function copySkoalaFiles(config: {
    onlyIntegrated: boolean | undefined
}, skoala: SkoalaInstall) {
    const subsetJson = path.join(Subset, 'subset.json')
    const subsetData = JSON.parse(fs.readFileSync(subsetJson).toString())
    if (!subsetData) throw new Error(`Cannot parse ${subsetJson}`)
    const copyFiles = (files: string, ...fromFallbacks: string[]) => {
        for (const file of files) {
            let found = false
            for (const from of fromFallbacks) {
                const fromPath = path.join(from, file)
                if (fs.existsSync(fromPath)) {
                    found = true
                    copyFile(fromPath, path.join(skoala.root, file))
                    break
                }
            }
            if (!found) {
                throw new Error(`Template for file ${file} was not found in paths ${fromFallbacks.join(':')}`)
            }
        }
        return
    }

    if (config.onlyIntegrated) {
        copyFiles(subsetData.generatedSubset, Subset)
        return
    }

    if (fs.existsSync(Subset)) {
        copyFiles(subsetData.subset, Subset)
    }
}

export function generateSkoalaFromIdl(
    config: {
        outDir: string,
        arkoalaDestination: string | undefined,
        nativeBridgeFile: string | undefined,
        lang: Language,
        apiVersion: number,
        onlyIntegrated: boolean,
        dumpSerialized: boolean,
        callLog: boolean,
        verbose: boolean,
        useTypeChecker: boolean,
    },
    library: LibraryInterface
) {
    const skoala = createSkoalaInstall({ outDir: config.outDir, lang: Language.TS })

    library.setFileLayout(skoalaLayout(library, 'Sk'))

    install(
        path.join(config.outDir, "./skoala-ts/generated"),
        library,
        [
            printGlobal,
            createSerializerPrinter(library.language, ""),
            createInterfacePrinter(false, false),
            createMaterializedPrinter(config.dumpSerialized),
            createPeersPrinter(config.dumpSerialized),
            printComponents,
            createGeneratedNativeModulePrinter(NativeModule.Generated),
        ], {}
    )

    copySkoalaFiles({ onlyIntegrated: config.onlyIntegrated }, skoala)
}