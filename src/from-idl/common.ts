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

import * as fs from "fs"
import * as path from "path"
import { IDLEntry } from "../idl"
import * as webidl2 from "webidl2"
import { toIDLNode } from "./deserialize";
import { zip } from "../util";

export function getFilesRecursive(dirPath: string, ext?: string, arrayOfFiles: string[] = []): string[] {
    let files = fs.readdirSync(dirPath)
    arrayOfFiles = arrayOfFiles || []
    files
        .filter((fileName: string) => ext ? fileName.endsWith(ext) : true)
        .forEach((file: string) => {
            if (fs.statSync(dirPath + "/" + file).isDirectory()) {
                arrayOfFiles = getFilesRecursive(dirPath + "/" + file, ext, arrayOfFiles)
            } else {
                arrayOfFiles.push(path.join(dirPath, file))
            }
        })
    return arrayOfFiles
}

export function transformFromIDL(
    files: string[],
    transform: (name: string, content: string) => string
): string[] {
    return files.map((file: string) => transform(file, fs.readFileSync(file).toString()))
}

export function generateFromIDL(
    inputDir: string,
    inputFile: string | undefined,
    outputDir: string,
    extension: string,
    verbose: boolean,
    transform: (name: string, content: string) => string
): void {
    inputDir = path.resolve(inputDir)
    const files: string[] = inputFile
        ? [path.join(inputDir, inputFile)]
        : getFilesRecursive(inputDir, ".idl")

    const results = transformFromIDL(files, transform)

    zip(files, results)
        .forEach(([fileName, output]: [string, string]) => {
            fs.mkdirSync(outputDir, { recursive: true })
            console.log('producing', path.relative(inputDir, fileName))
            const outFile = path.join(
                outputDir,
                path.relative(inputDir, fileName).replace(".idl", extension)
            )
            if (verbose) console.log(output)
            if (!fs.existsSync(path.dirname(outFile))) {
                fs.mkdirSync(path.dirname(outFile), { recursive: true });
            }
            fs.writeFileSync(outFile, licence.concat(output))
            console.log("saved", outFile)
        })
}

export function scanIDL(
    inputDir: string,
    inputFile: string | undefined,
): Map<string, IDLEntry[]> {
    inputDir = path.resolve(inputDir)
    const files: string[] =
        inputFile
            ? [path.join(inputDir, inputFile)]
            : fs.readdirSync(inputDir)
                .map((elem: string) => path.join(inputDir, elem))

    const result = new Map<string, IDLEntry[]>()
    files.forEach((file: string) => {
        let content = fs.readFileSync(file).toString()
        let parsed = webidl2.parse(content)
        result.set(file, parsed.filter(it => !!it.type).map(it => toIDLNode(file, it)))
    })
    return result
}

export const licence =
`/*
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

`
