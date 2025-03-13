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

import { IDLEntry, LayoutNodeRole, PeerLibrary } from "@idlizer/core";
import { join } from "node:path";
import { writeIntegratedFile } from "./common";
import { SourceFile } from "./printers/SourceFile";

export interface PrinterResult {
    over: {
        node: IDLEntry
        role: LayoutNodeRole
    }
    sourceFile: SourceFile
    private?: boolean
    weight?: number
}

export interface PrinterClass {
    print(library:PeerLibrary): PrinterResult[]
}
export interface PrinterFunction {
    (library:PeerLibrary): PrinterResult[]
}
export type Printer = PrinterClass | PrinterFunction

export function install(outDir:string, library:PeerLibrary, printers:Printer[], options?: { fileExtension?: string }): string[] {
    const storage = new Map<string, PrinterResult[]>()

    // groupBy
    printers.flatMap(it => typeof it === 'function' ? it(library) : it.print(library)).forEach(it => {
        const filePath = library.layout.resolve(it.over.node, it.over.role)
        if (!storage.has(filePath)) {
            storage.set(filePath, [])
        }
        storage.get(filePath)!.push(it)
    })

    // print
    const installedToExport: string[] = []
    for (const [filePath, results] of storage) {
        const installPath = join(outDir, filePath) + (options?.fileExtension ?? library.language.extension)
        if (!results.every(it => !!it.private)) {
            installedToExport.push(installPath)
        }
        results.sort((a, b) => (a.weight ?? 0) - (b.weight ?? 0))
        let resultFile = results.reduce((a, b) => (a.sourceFile.merge(b.sourceFile), a)).sourceFile
        writeIntegratedFile(installPath, resultFile.printToString(), 'producing')
    }

    return installedToExport
}
