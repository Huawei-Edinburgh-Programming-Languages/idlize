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

#include "common.h"

#ifdef KOALA_WINDOWS
#include <windows.h>
// Here we need to find module where GetArkUINodeAPI()
// function is implemented.
void* loadLibrary(const std::string& libPath) {
    return GetModuleHandle(libPath.c_str());
}

const char* libraryError() {
    return "";
}

void* findSymbol(void* library, const char* name) {
    return (void*)GetProcAddress(reinterpret_cast<HMODULE>(library), name);
}

std::string libName(const char* lib) {
    return std::string(lib) + ".dll";
}

#elif defined(KOALA_LINUX) || defined(KOALA_MACOS)
#include <dlfcn.h>

void* loadLibrary(const std::string& libPath) {
    return dlopen(libPath.c_str(), RTLD_LOCAL | RTLD_NOW);
}

const char* libraryError() {
    return dlerror();
}

void* findSymbol(void* library, const char* name) {
    return dlsym(library, name);
}

std::string libName(const char* lib) {
    std::string result;
    std::string suffix =
#ifdef KOALA_MACOS
    ".dylib"
#else
    ".so"
#endif
    ;
    result = "lib" + std::string(lib) + suffix;
    return result;
}

#else
#error "Unknown platform"
#endif
