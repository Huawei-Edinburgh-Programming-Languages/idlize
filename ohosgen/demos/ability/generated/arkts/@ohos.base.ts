import { int32 } from "@koalaui/common"
import { KPointer, KInt, KStringPtr, pointer, nullptr, RuntimeType, runtimeType, NativeBuffer } from "@koalaui/interop"
import { Serializer } from "./uiabilitycontextSerializer"
import { Finalizable } from "@koalaui/interop"



export interface AsyncCallback {
}
export interface BusinessError {
    code: number
    // data?: T
}
export interface AsyncCallbackInterface {
}
export interface BusinessErrorInterface { // extends ErrorInterface {
    code: number
    // data: T
}
