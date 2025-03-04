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

import { program } from "commander"
import { throwException, toIDLFile } from "@idlizer/core"
import { DynamicEmitter } from "./emitters/DynamicEmitter"
import { Config } from "./Config"
import { Options } from "./Options"
import * as path from "node:path"
import { StaticEmitter } from "./emitters/StaticEmitter"

const cliOptions: {
    pandaSdkPath?: string
    outputDir?: string
    files?: string
    optionsFile?: string
    debug?: boolean
    noInitialize?: boolean
} = program
    .option('--panda-sdk-path <path>', 'Path to panda sdk')
    .option('--output-dir <path>', 'Path to output dir')
    .option('--files <string>', 'Types of files to be emitted [bridges|bindings|enums], comma separated, no space')
    .option('--options-file <path>', 'Path to file which determines what to generate')
    .option('--debug', 'Generate intermediate versions of IDL IR')
    .option('--no-initialize', 'Do not emit static part of sources')
    .parse()
    .opts()

function main() {
    const outDir = cliOptions.outputDir ?? throwException(`output-dir is mandatory parameter`)
    const pandaSdkPath = cliOptions.pandaSdkPath ?? throwException(`panda-sdk-path is mandatory parameter`)
    const inputFile = path.join(pandaSdkPath, `ohos_arm64/include/tools/es2panda/generated/es2panda_lib/es2panda_lib.idl`)
    const files = cliOptions.files?.split(`,`)
    const optionsFile = cliOptions.optionsFile ?? path.join(__dirname, `../input/ignore.json5`)
    const isDebug = cliOptions.debug ?? false
    const noInitialize = cliOptions.noInitialize ?? false

    new DynamicEmitter(
        outDir,
        toIDLFile(inputFile),
        new Config(
            new Options(optionsFile),
            files
        ),
        isDebug
    ).emit()

    new StaticEmitter(
        outDir,
        noInitialize,
        pandaSdkPath
    ).emit()
}

main()
