/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
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

package idlize

import std.collection.*

foreign {
    func StringData(ptr: Int64, data: CPointer<UInt8>, arg2: Int32): Unit
%GENERATED_NATIVE_FUNCTIONS%
}

public open class NativeModule {

    public static func _StringData(ptr: Int64, data: ArrayList<UInt8>, arg2: Int32): ArrayList<UInt8> {
        unsafe {
            let handle_1 = acquireArrayRawData(data.toArray())
            StringData(ptr, handle_1.pointer, arg2)
            let outputData = ArrayList<UInt8>(handle_1.array)
            releaseArrayRawData(handle_1)
            return outputData
        }
    }

%GENERATED_METHODS%

%GENERATED_COMMON_InteropOps%
%GENERATED_COMMON_GraphicsOps%
%GENERATED_COMMON_LoaderOps%
%GENERATED_COMMON_NodeOps%
%GENERATED_COMMON_TestOps%
}
