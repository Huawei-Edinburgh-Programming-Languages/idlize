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

#include "common-interop.h"
#include "dynamic-loader.h"

typedef void* (*InitVirtualMachineFunc)(int kind, void** env);
typedef int (*RunVirtualMachineFunc)(void* env, KInt what, KByte* data, KInt length);

// Singleton for now.
struct VMControl {
    void* vm;
    RunVirtualMachineFunc runner;
} g_VM;

KNativePointer impl_LoadVirtualMachine(const KStringPtr& path, KInt kind) {
    auto lib = std::string(path.c_str()) + "/" + libName("panda");
    fprintf(stderr, "would load from %s %s: %d\n", path.c_str(), lib.c_str(), kind);
    void* handle = loadLibrary(lib);
    fprintf(stderr, "got %p\n", handle);
    if (!handle) return nullptr;
    auto initFunc = (InitVirtualMachineFunc)findSymbol(handle, "InitVirtualMachine");
    fprintf(stderr, "got %p\n", initFunc);
    if (!initFunc) return nullptr;
    void* env = nullptr;
    g_VM.vm = initFunc(kind, &env);
    g_VM.runner = (RunVirtualMachineFunc)findSymbol(handle, "RunVirtualMachine");
    return env;
}
KOALA_INTEROP_2(LoadVirtualMachine, KNativePointer, KStringPtr, KInt)

KInt impl_RunVirtualMachine(KNativePointer env, KInt what, KByte* data, KInt length) {
     return g_VM.runner(env, what, data, length);
}
KOALA_INTEROP_4(RunVirtualMachine, KInt, KNativePointer, KInt, KByte*, KInt)