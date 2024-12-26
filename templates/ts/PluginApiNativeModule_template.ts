type int32 = number
import { pointer, KPointer, registerNativeModule } from "../../../external/interop/src/interop"

%NATIVE_MODULE_CONTENT%

export class %NATIVE_MODULE_NAME%NativeModule {
%NATIVE_FUNCTIONS%

%ARKUI_FUNCTIONS%
}

registerNativeModule("%NATIVE_MODULE_NAME%NativeModule", %NATIVE_MODULE_NAME%NativeModule)
