package idlize

import std.collection.*

%NATIVE_MODULE_CONTENT%

foreign {
%NATIVE_FUNCTIONS%
}

public class NativeModule {

%CJ_NATIVE_FUNCTIONS%
}
