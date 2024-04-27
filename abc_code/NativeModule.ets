import {
    int32,
    float32
} from "@koalaui/common"
import {
    KInt,
    KBoolean,
    KStringPtr,
    KPointer,
    KNativePointer,
    KInt32ArrayPtr,
    KUint8ArrayPtr,
    pointer
} from "@types"

export type NodePointer = pointer

let theModule: PandaModule | undefined = undefined

export class PandaModule {
    static {
        loadLibrary("PandaModule");
    }

    public native static hello(): String;

    public run(): void throws {
        if (!("Hello" == PandaModule.hello())) {
            throw new Exception("ERROR: error return value from ETSNAPI");
        }
    }
} 

export function main(): void {
    let a = new PandaModule
    console.log('hello')
}
