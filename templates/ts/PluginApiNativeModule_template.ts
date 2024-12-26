import {
    int32,
} from "@koalaui/common"

import {
    registerNativeModule,
    KPointer,
    KInt,
    KBoolean,
    KNativePointer
} from "@koalaui/interop"

export class %NATIVE_MODULE_NAME%_NativeModule {
%NATIVE_FUNCTIONS%
}

registerNativeModule("%NATIVE_MODULE_NAME%NativeModule", %NATIVE_MODULE_NAME%_NativeModule)
