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
import { createCommand } from "commander"
import {
    findVersion,
    scanInputDirs
} from "@idlizer/core"
import { processInputOption, validatePaths, loadPeerConfiguration } from "@idlizer/libohos"
import { migrateFiles } from "./migrate"
import { readConfig } from "./config"
import { resolve } from "node:path"
import { cpSync } from "node:fs"

export function etsmigrate(argv:string[]) {
    const program = createCommand()
        .option('--input-dir <path>', 'Path to input dir(s), comma separated')
        .option('--output-dir <path>', 'Path to output dir')
        .option('--input-files <files...>', 'Comma-separated list of specific files to process')
        .option('--options-file <path>', 'Path to generator configuration options file (appends to defaults). Use --ignore-default-config to override default options.')
        .option('--ignore-default-config', 'Use with --options-file to override default generator configuration options.', false)
    const options = program
        .parse(argv, { from: 'user' })
        .opts()

    if (process.env.npm_package_version) {
        console.log(`IDLize version ${findVersion()}`)
    }

    const inputDirs = processInputOption(options.inputDir)
    const inputFiles = processInputOption(options.inputFiles)
    const outputDir = options.outputDir
    validatePaths(inputDirs, "dir")
    validatePaths(inputFiles, "file")
    migrateFiles(inputDirs, inputFiles, outputDir)
}
