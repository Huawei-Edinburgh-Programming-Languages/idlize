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
import { int32 } from "@koalaui/common"
import { pointer, wrapCallback } from "@koalaui/interop"
import { Deserializer } from "./peers/Deserializer";

function waitVSync(): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, 100) )
}

export async function runEventLoop(vmEntry: pointer) {
    let cb = wrapCallback((data: Uint8Array, length: int32) => {
        console.log(`JS: length = ${length}`)
    }, false)
    for (let i = 0; i < 5; i++) {
        nativeModule()._RunApplication(vmEntry, i, cb)
        if (i == 1) {
            nativeModule()._CallIntCallbackOnHost(vmEntry, 1, new Uint8Array([1]), 1)
        }
        if (i == 2) {
            nativeModule()._CallIntCallbackOnGuest(vmEntry, 1, new Uint8Array([1, 2]), 2)
        }
        await waitVSync()
    }
}

export function checkLoader() {
    let vmEntry: pointer = 0
    if (process.argv[process.argv.length - 1] == 'java') {
        vmEntry = nativeModule()._LoadVirtualMachine(1, __dirname + "/../out/java-subset/bin", __dirname + "/../native");
        nativeModule()._StartApplication(vmEntry, "org/koalaui/arkoala/Application", "startApplication", "(J)Lorg/koalaui/arkoala/Application;",  "enter", "(JII)V");
    }
    if (process.argv[process.argv.length - 1] == 'panda') {
        vmEntry = nativeModule()._LoadVirtualMachine(2, __dirname + "/../build/abc/subset/sig/arkoala-arkts/arkui/src", __dirname + "/../native");
        nativeModule()._StartApplication(vmEntry, "Application", "startApplication", "J:LApplication;", "enter", "JII:V");
    }
    if (vmEntry != 0) {
        nativeModule()._ProvideCallbacksOnHost(vmEntry)
        setTimeout(async () => runEventLoop(vmEntry), 0)
    }
}

checkLoader()