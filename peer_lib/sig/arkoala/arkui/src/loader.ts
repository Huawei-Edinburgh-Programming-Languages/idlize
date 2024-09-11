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

export async function runEventLoop() {
    for (let i = 0; i < 5; i++) {
        nativeModule()._RunApplication(i, i * i)
        await waitVSync()
    }
}

export function checkLoader() {
    let res = 0
    if (process.argv[process.argv.length - 1] == 'java') {
        res = nativeModule()._LoadVirtualMachine(1, __dirname + "/../out/java-subset/bin", __dirname + "/../native");
    }
    if (process.argv[process.argv.length - 1] == 'panda') {
        res = nativeModule()._LoadVirtualMachine(2, __dirname + "/../build/abc/subset/sig/arkoala-arkts/arkui/src", __dirname + "/../native");
    }
    if (res == 0) {
        nativeModule()._StartApplication();
        setTimeout(async () => runEventLoop(), 0)
    }
}

checkLoader()