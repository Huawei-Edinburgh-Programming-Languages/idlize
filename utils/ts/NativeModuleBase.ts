import { int32, KPointer, pointer, KStringPtr, KInt, NodePointer, KUint8ArrayPtr } from "./types"

export interface NativeModuleBase {
    _GetResultString(kind: KInt): pointer
    _ClearResultString(kind: KInt): void
    _AppendResultString(kind: KInt): void
    
    _GetStringFinalizer(): pointer

    _InvokeFinalizer(ptr: NodePointer, finalizer: NodePointer): void

    _StringLength(ptr: pointer): KInt;
    _StringData(ptr: pointer, buffer: KUint8ArrayPtr, length: KInt): void;
    _StringMake(value: KStringPtr): pointer;
}