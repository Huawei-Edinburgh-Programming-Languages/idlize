#!/usr/bin/env node

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

import { spawnSync } from "child_process"
import { existsSync, readFileSync } from "fs"
import { resolve } from "path"

const [expectedFile] = process.argv.slice(2)

if (!expectedFile) {
    console.error("Usage: ./run_tests.mjs <expected-file>")
    process.exit(1)
}

if (!existsSync(expectedFile)) {
    console.error(`Error: File ${expectedFile} not found!`)
    process.exit(1)
}

const testTarget = "check:arkts"
let isTestFail = false
let summaryText = ""

for (const line of readFileSync(expectedFile, "utf-8").split("\n")) {
    const trimmed = line.trim()
    if (!trimmed) {
        continue
    }

    const [pkg, expected] = trimmed.split(/\s+/)
    if (!pkg || !expected) {
        continue
    }

    const pkgPath = resolve(pkg)
    let result = "FAIL"
    let message = ""

    if (!existsSync(pkgPath)) {
        message = "(directory not found)"
    } else {
        const install = spawnSync("npm", ["i", "-d"], {
            cwd: pkgPath,
            stdio: "ignore",
        })

        if (install.status !== 0) {
            message = "(npm install failed)"
        } else {
            const check = spawnSync("npm", ["run", testTarget], {
                cwd: pkgPath,
                stdio: "inherit",
            })
            result = check.status === 0 ? "PASS" : "FAIL"
        }
    }

    const output = `${pkg}: ${result}${message ? ` ${message}` : ""} (expected ${expected})`
    summaryText += output + "\n"

    if (result !== expected) {
        isTestFail = true
    }
}

console.log("---------------RESULT-----------------")
console.log(summaryText)
console.log("--------------------------------------")
console.log(`Test status=${isTestFail ? "FAIL" : "PASS"}`)
process.exit(isTestFail ? 1 : 0)
