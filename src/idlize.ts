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
import * as fs from "fs"
import * as path from "path"
import { GenerateOptions, GenericVisitor } from "./options"

export function readdir(dir: string): string[] {
    return fs.readdirSync(dir)
        .map(elem => path.join(dir, elem))
}

export function generate<T>(
    inputDirs: string[],
    inputFile: string | undefined,
    outputDir: string,
    visitorFactory: (sourceFile: ts.SourceFile, typeChecker: ts.TypeChecker) => GenericVisitor<T>,
    options: GenerateOptions<T>
): void {
    inputDirs = inputDirs.map(it => path.resolve(it))
    let input = inputFile ? [
        path.join(inputDirs[0], inputFile)
    ] : inputDirs.flatMap(it => readdir(path.resolve(it)))
    // Build a program using the set of root file names in fileNames
    let program = ts.createProgram(
        input.concat([path.join(__dirname, "../stdlib.d.ts")]
    ), options.compilerOptions)

    // Get the checker, we will use it to find more about classes
    if (outputDir && !fs.existsSync(outputDir)) fs.mkdirSync(outputDir, { recursive: true })

    const typeChecker = program.getTypeChecker()
    options.onBegin?.(outputDir, typeChecker)

    const sourceFiles = program.getSourceFiles()
        .filter(sourceFile => inputFile && path.basename(sourceFile.fileName) == inputFile)
        .filter(sourceFile => inputDirs.some(dir => path.resolve(sourceFile.fileName).indexOf(dir) >= 0))

    sourceFiles.forEach(sourceFile => {
        // Walk the tree to search for classes
        const visitor = visitorFactory(sourceFile, typeChecker)
        const output = visitor.visitWholeFile()
        options.onSingleFile?.(output, outputDir, sourceFile)
    })

    options.onEnd?.(outputDir)

    return
}
