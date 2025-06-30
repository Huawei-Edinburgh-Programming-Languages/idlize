import { NativeModuleType } from "@idlizer/core"
import { NativeModule } from "@idlizer/libohos"

NativeModule.Interop = new NativeModuleType("InteropNativeModule")
NativeModule.Generated = new NativeModuleType("SkoalaGeneratedNativeModule")