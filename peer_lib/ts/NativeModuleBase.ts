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

import { KPointer, KStringPtr, KInt, KUint8ArrayPtr, KInt32ArrayPtr } from "@koalaui/interop"

enum RuntimeType {
    UNEXPECTED = -1,
    NUMBER = 1,
    STRING = 2,
    OBJECT = 3,
    BOOLEAN = 4,
    UNDEFINED = 5,
    BIGINT = 6,
    FUNCTION = 7,
    SYMBOL = 8,
    MATERIALIZED = 9,
}

export class NativeModuleBase {
    _GetGroupedLog(index: KInt): KPointer {
        throw new Error("_GetResultString")
    }
    _StartGroupedLog(index: KInt): void  {
        throw new Error("_StartGroupedLog")
    }
    _StopGroupedLog(index: KInt): void  {
        throw new Error("_StopGroupedLog")
    }
    _GetStringFinalizer(): KPointer  {
        throw new Error("_GetStringFinalizer")
    }
    _InvokeFinalizer(ptr: KPointer, finalizer: KPointer): void  {
        throw new Error("_InvokeFinalizer")
    }
    _StringLength(ptr: KPointer): KInt  {
        throw new Error("_StringLength")
    }
    _StringData(ptr: KPointer, buffer: KUint8ArrayPtr, length: KInt): void  {
        throw new Error("_StringLength")
    }
    _StringMake(value: KStringPtr): KPointer {
        throw new Error("_StringMake")
    }
    _ManagedStringWrite(value: KStringPtr, buffer: KUint8ArrayPtr, offset: KInt): KInt {
        throw new Error("_ManagedStringWrite")
    }
    _Test_TextPicker_OnAccept(valueArray: Uint8Array, valueSerializerLength: KInt): void {
        throw new Error("_Test_TextPicker_OnAccept")
    }
    _TestPerfNumber(value: KInt): KInt { return 0 }
    _TestPerfNumberWithArray(value: KUint8ArrayPtr, length: KInt): void {}
    _StartPerf(traceName: KStringPtr): void {}
    _EndPerf(traceName: KStringPtr): void {}
    _DumpPerf(options: KInt): KPointer { return 0 }
    _RuntimeType(value: any): KInt {
        let type = typeof value
        if (type == "number") return RuntimeType.NUMBER
        if (type == "string") return RuntimeType.STRING
        if (type == "undefined") return RuntimeType.UNDEFINED
        if (type == "object") return RuntimeType.OBJECT
        if (type == "boolean") return RuntimeType.BOOLEAN
        if (type == "bigint") return RuntimeType.BIGINT
        if (type == "function") return RuntimeType.FUNCTION
        if (type == "symbol") return RuntimeType.SYMBOL
        throw new Error(`bug: ${value} is ${type}`)
    }
}