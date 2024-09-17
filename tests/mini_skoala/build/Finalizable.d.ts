import { pointer, nullptr, isNullPtr } from "@koalaui/interop"
import { nativeModule } from "@koalaui/arkoala";
import { Thunk } from "./Finalization";

export abstract class FinalizableBase {
    createHandle(): string | undefined
    close(): void
    release(): pointer
    resetPeer(pointer: pointer): void
    use<R>(body: (value: FinalizableBase) => R): R
}

export class Finalizable extends FinalizableBase {
    makeNativeThunk(ptr: pointer, finalizer: pointer, handle: string | undefined): NativeThunk 
}

export abstract class NativeThunk implements Thunk {
    ptr:pointer
    finalizer: pointer
    name?: string
    clean(): void
    abstract destroyNative(ptr: pointer, finalizer: pointer): void
}

declare class NativeThunkImpl extends NativeThunk {
    destroyNative(ptr: pointer, finalizer: pointer): void
}