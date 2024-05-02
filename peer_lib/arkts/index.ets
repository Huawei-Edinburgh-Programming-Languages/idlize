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

export class NativeModule {
    static {
        loadLibrary("NativeBridgeArk");
    }

    public native static hello(): String;

    public native static _StringMake(str: String): long;
    public native static _StringLength(ptr: long): int;

    public static run(): void {
        let value = NativeModule._StringMake("HELLO")
        console.log("make gave" + value)
        console.log("Native gave us " + NativeModule._StringLength(value))
    }
} 

export function main(): void {
    console.log("in main()")
    NativeModule.run()
}