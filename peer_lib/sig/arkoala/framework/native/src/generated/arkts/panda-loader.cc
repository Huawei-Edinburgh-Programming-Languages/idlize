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

struct CallbackMethod {
    int (*CallInt) (void* env, int methodId, uint8_t* data, int dataSize);
};

typedef void* (*InitVirtualMachineFunc)(
    int kind, const char* managedPath, const char* nativePath, void** env,
    CallbackMethod* callbacks);
typedef int (*RunVirtualMachineFunc)(void* jvmEnv, void* jsEnv, KInt what);

// Singleton for now.
struct VMControl {
    void* vm;
    RunVirtualMachineFunc runner;
} g_VM;

int CallInt(void* vmContext, int methodId, uint8_t* data, int length) {
    KOALA_INTEROP_CALL_INT(vmContext, methodId, length, data)
}

CallbackMethod g_callbacks {
    CallInt
};

KNativePointer impl_LoadVirtualMachine(
    const KStringPtr& libPath, const KStringPtr& classPath, KInt kind) {
    auto lib = std::string(libPath.c_str()) + "/" + libName("panda");
    fprintf(stderr, "would load from %s %s: %d\n", libPath.c_str(), lib.c_str(), kind);
    void* handle = loadLibrary(lib);
    if (!handle) {
        fprintf(stderr, "Cannot load library %s: %s\n", lib.c_str(), libraryError());
        return nullptr;
    }
    auto initFunc = (InitVirtualMachineFunc)findSymbol(handle, "InitVirtualMachine");
    if (!initFunc) {
        fprintf(stderr, "Cannot find InitVirtualMachine in %s\n", lib.c_str());
        return nullptr;
    }
    void* env = nullptr;
    g_VM.vm = initFunc(kind, classPath.c_str(), libPath.c_str(), &env, &g_callbacks);
    g_VM.runner = (RunVirtualMachineFunc)findSymbol(handle, "RunVirtualMachine");
    if (!g_VM.runner) {
        fprintf(stderr, "Cannot find RunVirtualMachine in %s\n", lib.c_str());
        return nullptr;
    }
    return env;
}
KOALA_INTEROP_3(LoadVirtualMachine, KNativePointer, KStringPtr, KStringPtr, KInt)

KInt impl_RunVirtualMachine(KVMContext vmContext, KNativePointer env, KInt what) {
     return g_VM.runner(env, vmContext, what);
}
KOALA_INTEROP_CTX_2(RunVirtualMachine, KInt, KNativePointer, KInt)

KInt impl_CallExternalAPI(KInt vm, KNativePointer envArg, KInt what, KByte* data, KInt length) {
    fprintf(stderr, "CallExternalVM: %d %d\n", what, length);
    switch (vm) {
    case 1: /* JS VM */
        KOALA_INTEROP_CALL_INT(envArg, what, length, data);
        return 0;
    case 2: /* ArkTS VM */
        fprintf(stderr, "CallExternalVM: ArkTS VM unsupported\n");
        return -1;
    case 3: /* JVM */
        fprintf(stderr, "CallExternalVM: JVM unsupported\n");
        return -1;
    default:
        return -1;
    }
}
KOALA_INTEROP_5(CallExternalAPI, KInt, KInt, KNativePointer, KInt, KByte*, KInt)