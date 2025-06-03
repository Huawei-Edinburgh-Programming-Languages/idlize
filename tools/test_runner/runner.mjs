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

import { execSync } from "node:child_process"
import { writeFileSync } from "node:fs"

const tsConfig = () => `
{
    "compilerOptions": {
        "target": "ESNext",
        "module": "ESNext",
        "moduleResolution": "node",
        "outDir": "build/ts",
        "baseUrl": ".",
    },
    "include": ["generated/ts/**/*.ts"],
}
`
const packageJson = () => `
{
    "name": "test",
    "private": true,
    "dependencies": {
        "@koalaui/interop": "next",
        "@koalaui/common": "next"
    }
}
`

function main() {
    const failed = []
    for (let i = 0; i < 100; ++i) {
        const testSign = `${i.toString().padStart(5, '0')}_interface_test`
        const idlFile = `${testSign}.idl`
        const outDirTS = `${testSign}_ts_generation`
        try {
            console.log(`>>> ${testSign}`)
            execSync(`mkdir -p out && node . > out/${idlFile}`, { cwd: '../../testgen', stdio: 'ignore' })
            execSync(`node . --idl2peer --input-files ../testgen/out/${idlFile} --output-dir out/${outDirTS}`, { cwd: '../../ohosgen', stdio: 'ignore' })
            writeFileSync(`../../ohosgen/out/${outDirTS}/package.json`, packageJson(), 'utf-8')
            writeFileSync(`../../ohosgen/out/${outDirTS}/tsconfig.json`, tsConfig(), 'utf-8')
            execSync('npx tsc', { cwd: `../../ohosgen/out/${outDirTS}`, stdio: 'inherit' })
            console.log('... DONE')
        } catch (ex) {
            console.log('... FAILED')
            failed.push(testSign)
        }
    }
    if (failed.length) {
        console.log('FAILED:')
        failed.forEach(sign => console.log(sign))
        process.exitCode = -42
    }
}
main()
