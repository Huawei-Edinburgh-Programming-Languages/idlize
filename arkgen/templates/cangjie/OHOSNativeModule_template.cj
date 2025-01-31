package idlize

import Interop.*

%NATIVE_MODULE_CONTENT%

public class %NATIVE_MODULE_NAME%NativeModule {
    static func callCallbackFromNative(id: KInt, args: KPointer, length: KInt): KInt {
        // TODO implement callCallbackFromNative
        return 0
    }    

%NATIVE_FUNCTIONS%
}
