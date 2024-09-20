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

import { nativeModule } from "@koalaui/arkoala"
import { Worker, isMainThread, parentPort } from "node:worker_threads"

type int32 = number

function waitVSync(): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, 100) )
}

export async function runEventLoop() {
    for (let i = 0; i < 5; i++) {
        nativeModule()._RunApplication(i, i * i)
        await waitVSync()
    }
}

function runEs2Panda(msg: { kind: string, id: int32, files: string[]}):
    { id: int32, result: int32 } {
    console.log(`JS: es2panda ${msg.files}`)
    return {
        id: msg.id,
        result: nativeModule()._LoadVirtualMachine(3, msg.files.join(","), "")
    }
}

let workers = new Array<Worker>()
let requests = new Map<int32, (result: int32) => void>()
let requestId = 0

function compile(worker: Worker, index: int32): Promise<int32> {
    return new Promise(resolve => {
        let id = requestId++
        requests.set(id, (result: int32) => {
            resolve(result)
            requests.delete(id)
        })
        worker.postMessage({
            kind: "compile",
            id: id,
            files: [`file${index}.sts`, `shmile${index}.sts`]
        })
    })
}

function runEs2PandaMain(): int32 {
    if (!isMainThread) return 0

    for (let i = 0; i < 10; i++) {
        workers.push(new Worker(__filename))
        workers[i].on("message", (response: {id: int32, result: int32}) => {
            requests.get(response.id)!(response.result)
        })
    }
    setTimeout(async () => {
        await Promise.all(
            workers.map((worker, index) => compile(worker, index)))
    })
    return 0
}

export function initWorker() {
    // Here we're in the worker.
    parentPort!.addListener("message", (request: any) => {
        procesWorkerRequest(request)
            .then((response) => {
                parentPort!.postMessage(response, response.transferList())
            })
    })

    function procesWorkerRequest(request: { kind: string, id: int32, files: string[]}): Promise<any> {
        return new Promise((resolve, reject) => {
            if (request.kind == "compile") {
                resolve(runEs2Panda(request))
            } else {
                reject(`Unknown request: ${request}`)
            }
        })
    }
}

export function checkLoader(variant: string): int32 {
    let vm = -1
    let classPath = ""
    let nativePath = __dirname + "/../native"

    switch (variant) {
        case 'java': {
            vm = 1
            classPath = __dirname + "/../out/java-subset/bin"
            break
        }
        case 'panda': {
            vm = 2
            classPath = __dirname + "/../build/abc/subset/sig/arkoala-arkts/arkui/src/generated"
            break
        }
        case 'es2panda': {
            return runEs2PandaMain()
        }
    }
    let result = nativeModule()._LoadVirtualMachine(vm, classPath, nativePath)

    if (result == 0) {
        nativeModule()._StartApplication();
        setTimeout(async () => runEventLoop(), 0)
    } else {
        throw new Error(`Cannot start VM: ${result}`)
    }

    return result
}

if (isMainThread) {
    checkLoader(process.argv.length >= 1 ? process.argv[process.argv.length - 1] : "java")
} else {
    initWorker()
}