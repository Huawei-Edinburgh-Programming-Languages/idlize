import { registerNativeModule, registerLoadedLibrary } from "@koalaui/interop"

const NativeModule = {}
registerNativeModule("NativeModule", NativeModule)
registerNativeModule("InteropNativeModule", NativeModule)

const module = { exports: {} }
dlopen(module, fileURLToPath(new URL('Xml_NativeBridgeNapi.node', import.meta.url)), constants.dlopen.RTLD_NOW)
registerLoadedLibrary(module)

export default NativeModule