import { int32 } from "@koalaui/common"
import { pointer, KPointer, KInt, KStringPtr, KUint8ArrayPtr, loadNativeModuleLibrary } from "@koalaui/interop"

export enum CallbackKind {
    Kind_AsyncCallback_Void = 1075219926,
    Kind_Callback_Opt_Array_String_Void = -543655128,
    Kind_Callback_Void = -1867723152
}

export class UIAbilityContextNativeModule {
    static {
        loadNativeModuleLibrary("UIAbilityContext_NativeBridgeArk")
    }

    static callCallbackFromNative(id: KInt, args: KUint8ArrayPtr, length: KInt): KInt {
        // TODO implement callCallbackFromNative
        return 0
    }    

    // demo
    native static _AllocateNativeBuffer(length: KInt, retBuffer: KUint8ArrayPtr, init:KUint8ArrayPtr): void;

    native static _UIAbilityContext_ctor(): KPointer 
    native static _UIAbilityContext_getFinalizer(): KPointer 
    native static _UIAbilityContext_startAbility(self: KPointer, thisArray: KUint8ArrayPtr, thisLength: int32): void 
    native static _UIAbilityContext_terminateSelf0(self: KPointer, thisArray: KUint8ArrayPtr, thisLength: int32): void 
    native static _UIAbilityContext_terminateSelf1(self: KPointer, thisArray: KUint8ArrayPtr, thisLength: int32): void 


}
