import { Finalizable } from "./Finalizable"
import { pointer, KNativePointer } from "@koalaui/interop"

declare class Bitmap extends Finalizable {
    constructor(ptr: pointer)
    public static getFinalizer(): KNativePointer
    public static make(): Bitmap
}