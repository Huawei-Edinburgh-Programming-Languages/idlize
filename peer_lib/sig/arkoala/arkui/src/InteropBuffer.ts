import { KPointer } from '@koalaui/interop';
import { Finalizable } from './Finalizable'
import { nativeModule } from "@koalaui/arkoala";

export class InteropBuffer {
    static create(pointer:KPointer, length:number, finalizer: KPointer): ArrayBuffer {
        const buffer = nativeModule()._MaterializeBuffer({ pointer, length })
        const cheat = buffer as any
        cheat.finalizer = new Finalizable(pointer, finalizer);
        return buffer
    }
}
