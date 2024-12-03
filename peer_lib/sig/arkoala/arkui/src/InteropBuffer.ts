import { KPointer } from '@koalaui/interop';
import { Finalizable } from './Finalizable'
import { nativeModule } from "@koalaui/arkoala";

export class InteropBuffer implements ArrayBuffer {

    private constructor(
        private buffer: ArrayBuffer,
        // private _finalizable: Finalizable
    ) {}

    get byteLength(): number {
        return this.buffer.byteLength
    }
    slice(begin: number, end?: number): ArrayBuffer {
        return this.buffer.slice(begin, end)
    }
    get [Symbol.toStringTag](): string {
        return this.buffer[Symbol.toStringTag]
    }

    static create(pointer:KPointer, length:number, finalizer: KPointer) {
        return new InteropBuffer(nativeModule()._MaterializeBuffer({ pointer, length }), /* new Finalizable(pointer, finalizer) */)
    }
}
