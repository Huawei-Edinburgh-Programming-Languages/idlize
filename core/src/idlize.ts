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

function readdir(dir: string): string[] {
    return fs.readdirSync(dir)
        .map(elem => path.join(dir, elem))
}

export function generate<T>(
    inputDirs: string[],
    inputFiles: string[],
    outputDir: string,
    visitorFactory: (sourceFile: ts.SourceFile, typeChecker: ts.TypeChecker) => GenericVisitor<T>,
    options: GenerateOptions<T>
): void {
    if (inputDirs.length === 0 && inputFiles.length === 0) {
        console.error("Error: No input specified (no directories and no files).")
        process.exit(1)
    }

    const resolvedInputDirs = inputDirs.map(dir => path.resolve(dir))

    let input: string[] = []

    if (resolvedInputDirs.length > 0) {
        resolvedInputDirs.forEach(dir => {
            if (fs.existsSync(dir) && fs.statSync(dir).isDirectory()) {
                console.log(`Processing all .d.ts from directory: ${dir}`)
                const files = readdir(dir).filter(file => file.endsWith(".d.ts"))
                input = input.concat(files)
            } else {
                console.warn(`Warning: Directory does not exist or is not a directory: ${dir}`)
            }
        })
    }

    if (inputFiles.length > 0) {
        inputFiles.forEach(file => {
            const fullPath = path.resolve(file)
            if (fs.existsSync(fullPath)) {
                console.log(`Including input file: ${fullPath}`)
                input.push(fullPath)
            } else {
                console.warn(`Warning: Input file does not exist: ${fullPath}`)
            }
        })
    }

    input = Array.from(new Set(input.map(p => path.resolve(p))))

    let program = ts.createProgram(
        input.concat([path.join(__dirname, "../stdlib.d.ts")]
    ), options.compilerOptions)

    program.getSourceFiles().forEach(f => console.log(f.fileName))

    // Get the checker, we will use it to find more about classes
    if (outputDir && !fs.existsSync(outputDir)) fs.mkdirSync(outputDir, { recursive: true })

    const typeChecker = program.getTypeChecker()
    options.onBegin?.(outputDir, typeChecker)

    for (const sourceFile of program.getSourceFiles()) {
        const resolvedSourceFile = path.resolve(sourceFile.fileName)
        
        const isInDir = resolvedInputDirs.some(dir => resolvedSourceFile.startsWith(dir))
        const isExplicitFile = input.some(f => path.resolve(f) === resolvedSourceFile)

        if (!isInDir && !isExplicitFile) {
            console.log(`Skipping file: ${resolvedSourceFile}`)
            continue
        }

        // Walk the tree to search for classes
        const visitor = visitorFactory(sourceFile, typeChecker)
        const output = visitor.visitWholeFile()

        options.onSingleFile?.(output, outputDir, sourceFile)
    }

    options.onEnd?.(outputDir)
}