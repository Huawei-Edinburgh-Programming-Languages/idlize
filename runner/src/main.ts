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

import { arkgen, defaultConfigPath as arkgenConfigPath } from "@idlizer/arkgen/app"
import { etsgen } from "@idlizer/etsgen/app"
import { copyFileSync, existsSync, mkdirSync, rmSync } from "node:fs"
import { dirname, join, relative, resolve } from "node:path"
import { flat, scan } from "./utils"
import { Command } from "commander"

/////////////////////////////////////////////////
// CONSTANTS

const WORKING_DIR = resolve(__dirname, '..', 'out')
const GENERATED_IDL_DIR = join(WORKING_DIR, 'idl')
const GENERATED_PEER_DIR = join(WORKING_DIR, 'peers')
const GENERATED_PEER_SIG = join(GENERATED_PEER_DIR, 'sig')
const GENERATED_PEER_LIBACE = join(GENERATED_PEER_DIR, 'libace')
const ADDITIONAL_FILES = [
    ['global', 'resource.d.ets']
]
const REFERENCE_CONFIG_PATH = resolve(arkgenConfigPath(), 'references', 'ets-sdk.refs.json')

/////////////////////////////////////////////////

function main(argv:string[]) {

    const program = new Command()
        .name("@idlizer/runner")
        .arguments("<sdk-path> <install-path>")
        .option('--target <target>', 'sig | libace | all', 'sig')
        .parse(argv, { from: 'user' })

    const [sdkPath, installPath] = program.args
    const options = program.opts()

    // 0. prepare
    if (existsSync(WORKING_DIR)) {
        rmSync(WORKING_DIR, { recursive: true })
    }
    mkdirSync(WORKING_DIR, { recursive: true })
    mkdirSync(GENERATED_IDL_DIR, { recursive: true })
    mkdirSync(GENERATED_PEER_DIR, { recursive: true })

    // 1. d.ets -> idl
    const sdkApiPath = join(sdkPath, 'api')
    const additionalFiles = ADDITIONAL_FILES.map(it => join(sdkApiPath, join(...it)))
    etsgen(
        flat([
            '--ets2idl',
            '--use-component-stubs',
            ['--output-dir', GENERATED_IDL_DIR],
            ['--base-dir', sdkApiPath],
            ['--input-dir', join(sdkApiPath, 'arkui', 'component')],
            ['--input-files', additionalFiles],
        ])
    )
    // 2. idl -> peer
    const idlFiles = scan(GENERATED_IDL_DIR)
    arkgen(
        flat([
            '--idl2peer',
            ['--reference-names', REFERENCE_CONFIG_PATH],
            ['--input-files', idlFiles],
            ['--output-dir', GENERATED_PEER_DIR],
            ['--language', 'arkts'],
            '--only-integrated'
        ])
    )
    // 3. Install
    let installSourceDir = GENERATED_PEER_DIR
    switch (options.target) {
        case 'sig': { installSourceDir = GENERATED_PEER_SIG; break }
        case 'libace': { installSourceDir = GENERATED_PEER_LIBACE; break }
        case 'all': { installSourceDir = GENERATED_PEER_DIR; break }
    }
    const peerFiles = scan(installSourceDir)
    peerFiles.forEach(file => {
        const relativeFile = relative(GENERATED_PEER_DIR, file)
        const destinationFile = join(installPath, relativeFile)
        const destinationDir = dirname(destinationFile)
        if (!existsSync(destinationDir)) {
            mkdirSync(destinationDir, { recursive: true })
        }
        copyFileSync(file, join(installPath, relativeFile))
    })
}

main(process.argv.slice(2))
