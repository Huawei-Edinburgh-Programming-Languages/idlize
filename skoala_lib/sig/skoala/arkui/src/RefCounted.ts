import { nativeModule } from "@koalaui/arkoala"
import { Finalizable } from "./Finalizable"
import { pointer } from "@koalaui/interop"

export class RefCounted extends Finalizable {
    private static _finalizerHolder?: pointer

    static get finalizerHolder(): pointer {
        return RefCounted._finalizerHolder ??
            (RefCounted._finalizerHolder = nativeModule()._skoala_impl_RefCnt__getFinalizer())
    }

    constructor(ptr: pointer, allowClose = true) {
        super(ptr, RefCounted.finalizerHolder, allowClose)
    }
}