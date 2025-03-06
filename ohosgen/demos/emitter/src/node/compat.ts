import { registerNativeModuleLibraryName, loadInteropNativeModule } from "@koalaui/interop"
import { emitter } from "../../generated/ts";

export { emitter };

declare const NATIVE_LIBRARY_NAME: string
export function init() {
    registerNativeModuleLibraryName("InteropNativeModule", NATIVE_LIBRARY_NAME)
    registerNativeModuleLibraryName("EMITTERNativeModule", NATIVE_LIBRARY_NAME)
    loadInteropNativeModule()
}
