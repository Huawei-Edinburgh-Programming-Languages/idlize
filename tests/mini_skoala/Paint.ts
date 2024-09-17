import { Finalizable } from "./Finalizable"
import { pointer, KNativePointer } from "@koalaui/interop"
import { nativeModule } from "@koalaui/arkoala"
import { int32 } from "@koalaui/common"

export class Paint extends Finalizable {
    constructor(ptr: pointer) { super(ptr, Paint.getFinalizer()) }

    public static getFinalizer(): KNativePointer {
        return nativeModule()._skoala_Paint__1nGetFinalizer()
    }

    public set antiAlias(value: boolean) {
        nativeModule()._skoala_Paint__1nSetAntiAlias(this.ptr, +value)
    }

    public set color(color: int32) {
        nativeModule()._skoala_Paint__1nSetColor(this.ptr, color)
    }

    public static make(): Paint {
        const ptr = nativeModule()._skoala_Paint__1nMake()
        if (!ptr) throw new TypeError("can not create an instance of type Paint")
        let result = new Paint(ptr)
        // We want antialiasing by default.
        result.antiAlias = true
        return result
    }
}