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

let theModule: PandaNativeModule | undefined = undefined

export class PandaNativeModule {
    static {
        loadLibrary("PandaModule");
    }

    public native static hello(): String;

    public run(): void throws {
        if (!("Hello" == PandaNativeModule.hello())) {
            throw new Exception("ERROR: error return value from ETSNAPI");
        }
    }
} 

export function main(): void {
    let a = new PandaNativeModule
    // console.log(PandaNativeModule.hello())c
    console.log('hello')
}
