import { Finalizable } from "./Finalizable"
import { pointer, KNativePointer } from "@koalaui/interop"
import { nativeModule } from "@koalaui/arkoala"

export class Bitmap extends Finalizable {
    constructor(ptr: pointer) {
        super(ptr, Bitmap.getFinalizer())
    }

    public static getFinalizer(): KNativePointer {
        return nativeModule()._skoala_Bitmap__1nGetFinalizer()
    }

    /**
     * Makes an empty object.
     * The new bitmap has ColorType.UNKNOWN, ColorAlphaType.UNKNOWN,
     * zero with and height. Pixel memory is not allocated.
     * @returns the new bitmap.
     */
    public static make(): Bitmap {
        const ptr = nativeModule()._skoala_Bitmap__1nMake()
        return new Bitmap(ptr)
    }
}