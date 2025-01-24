import { registerNativeModuleLibraryName, loadInteropNativeModule } from "@koalaui/interop"

registerNativeModuleLibraryName("InteropNativeModule", "./native/NativeBridgeNapi")
registerNativeModuleLibraryName("TestNativeModule", "./native/NativeBridgeNapi")
registerNativeModuleLibraryName("ArkUINativeModule", "./native/NativeBridgeNapi")
registerNativeModuleLibraryName("ArkUIGeneratedNativeModule", "./native/NativeBridgeNapi")
loadInteropNativeModule()