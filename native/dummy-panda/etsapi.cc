#include "etsapi.h"
#include "common.h"

// Emulator of Panda VM to simplify development on other platforms.

typedef ets_int ETS_CALL (*EtsNapiOnLoad_t)(EtsEnv *env);

ets_int registerNatives(EtsEnv *env, ets_class cls, const EtsNativeMethod *methods, ets_int nMethods) {
    fprintf(stderr, "registerNatives: %d\n", nMethods);
    for (int i = 0; i < nMethods; i++) {
        fprintf(stderr, "registerNative: %s %s %p\n", methods[i].name, methods[i].signature, methods[i].func);
    }
    return 0;
}

ets_class dummyNativeModule = (ets_class)42;

ets_class findClass(EtsEnv *env, const char *name) {
    fprintf(stderr, "findClass: %s\n", name);
    return dummyNativeModule;
}

int loadEtsNativeLib(const char* path, const char* name) {
    std::string libPath = std::string(path) + libName(name);
    void* lib = loadLibrary(libPath);
    if (!lib) {
        fprintf(stderr, "Cannot load library %s: %s\n", libPath.c_str(), libraryError());
        return 1;
    }
    EtsNapiOnLoad_t onLoad = reinterpret_cast<EtsNapiOnLoad_t>(findSymbol(lib, "EtsNapiOnLoad"));
    if (!onLoad) {
        fprintf(stderr, "Cannot find entry point\n");
        return 0;
    }

    EtsEnv env;
    ETS_NativeInterface* native_interface = new ETS_NativeInterface();
    native_interface->RegisterNatives = registerNatives;
    native_interface->FindClass = findClass;

    env.native_interface = native_interface;

    onLoad(&env);
    return 0;
}