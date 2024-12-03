type KLong = number

export class NativeModuleEmptyIntegrated implements NativeModuleIntegrated {
%GENERATED_EMPTY_METHODS%
    _SetCallbackDispatcher(dispatcher: (id: int32, args: Uint8Array, length: int32) => int32): void {
        throw new Error("_SetCallbackDispatcher")
    }
    _CleanCallbackDispatcher(): void {
        throw new Error("_CleanCallbackDispatcher")
    }
    _MaterializeBuffer(buffer: { pointer: KPointer, length: number }): ArrayBuffer {
        throw new Error("_MaterializeBuffer")
    }
}

export class NativeModuleEmpty extends NativeModuleEmptyIntegrated implements NativeModule {}
