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

import { callCallback } from "../CallbackRegistry"
import { int32 } from "@koalaui/common"
import { 
  KInt, 
  KUInt,
  KFloat,
  KLong, 
  KBoolean,
  KPointer, 
  KStringPtr, 
  KUint8ArrayPtr,
  KInt32ArrayPtr,
  KFloat32ArrayPtr,
  pointer
} from "@koalaui/interop"

export type NodePointer = pointer
export type PipelineContext = pointer

let theModule: NativeModule

export function nativeModule(): NativeModule {
    if (theModule) return theModule
    // todo: is this code actually reachable?
    theModule = new NativeModule()
    return theModule
}

export class NativeModule {
  static {
    loadLibrary("NativeBridgeArk")
    NativeModule.init();
  }

  static native init(): void;

  static callCallbackFromNative(id: KInt, args: KUint8ArrayPtr, length: KInt): KInt {
    return callCallback(id, args, length)
  }

  // Generated part
%GENERATED_METHODS%

  // Common part
%GENERATED_COMMON_InteropOps%
%GENERATED_COMMON_GraphicsOps%
%GENERATED_COMMON_LoaderOps%
%GENERATED_COMMON_NodeOps%
%GENERATED_COMMON_TestOps%
}