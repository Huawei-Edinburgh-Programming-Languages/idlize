export namespace Skoala {
    export enum BaseClasses {
        Finalizable = "Finalizable",
        RefCounted = "RefCounted"
    }
    export const NativeModuleImportFeature = {
        module: "@koalaui/arkoala",
        features: ["nativeModule"]
    }
    export const getFinalizer = "getFinalizer"
    export function nativeMethod(className: string, methodName: string) {
        return `_skoala_${className}_${methodName}`
    }
}
