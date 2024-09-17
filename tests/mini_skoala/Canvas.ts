import { Finalizable } from "./Finalizable"
import { pointer, KNativePointer, withIntArray, getPtr, Access } from "@koalaui/interop"
import { nativeModule } from "@koalaui/arkoala"
import { uint32, float32 } from "@koalaui/common"

import { Bitmap } from "./Bitmap"
import { SurfaceProps } from "./SurfaceProps"
import { Paint } from "./Paint"

export class Canvas extends Finalizable {
    // private owner?: object
    constructor(ptr: pointer, managed: boolean = true) {
        super(ptr, Canvas.getFinalizer(), managed)
    }

    static getFinalizer(): KNativePointer {
        return nativeModule()._skoala_Canvas__1nGetFinalizer()
    }

    /**
     * Creates an instance of Canvas that draws into the given bitmap.
     *
     * @param bitmap - bitmap to draw into
     * @param surfaceProps - device properties
     * @returns the new instance of Canvas to draw into bitmap
     *
     */
    public static makeFromBitmap(bitmap: Bitmap, surfaceProps: SurfaceProps): Canvas {
        const ptr = withIntArray(surfaceProps.flattenToInt32Array(), Access.READ, (propsPtr) =>
            nativeModule()._skoala_Canvas__1nMakeFromBitmap(getPtr(bitmap), propsPtr))
        if (!ptr) throw new TypeError("can not create an instance of type Canvas")
        return new Canvas(ptr)
    }

    public clear(color: uint32): void {
        nativeModule()._skoala_Canvas__1nClear(this.ptr, color)
    }

    public drawRect(left: float32, top: float32, right: float32, bottom: float32, paint: Paint): void {
        nativeModule()._skoala_Canvas__1nDrawRect(this.ptr, left, top, right, bottom, getPtr(paint))
    }
}