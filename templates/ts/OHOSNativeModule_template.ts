import { int32 } from "@koalaui/common"
import { pointer, KPointer } from "@koalaui/interop"

%NATIVE_MODULE_CONTENT%

export class %NATIVE_MODULE_NAME%NativeModule {
%NATIVE_FUNCTIONS%

%INTEROP_FUNCTIONS%
}
