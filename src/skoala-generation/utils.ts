export namespace Skoala {
    export const Finalizable = "Finalizable"
    export const RefCounted = "RefCounted"
    export const NativeModuleImport = `import { nativeModule } from "@koalaui/arkoala"`
    export const getFinalizer = "getFinalizer"
    export function nativeMethod(className: string, methodName: string) {
        return `_skoala_${className}_${methodName}`
    }
}
