import { Finalizable } from "./Finalizable"
import { pointer, KNativePointer, withIntArray, getPtr, Access } from "@koalaui/interop"
import { uint32, float32 } from "@koalaui/common"

import { Bitmap } from "./Bitmap"
import { SurfaceProps } from "./SurfaceProps"
import { Paint } from "./Paint"

declare class Canvas extends Finalizable {
    constructor(ptr: pointer, managed?: boolean)
    static getFinalizer(): KNativePointer 
    static makeFromBitmap(bitmap: Bitmap, surfaceProps: SurfaceProps): Canvas 

    clear(color: uint32): void
    drawRect(left: float32, top: float32, right: float32, bottom: float32, paint: Paint): void 
}