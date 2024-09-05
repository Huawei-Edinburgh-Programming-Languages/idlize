import { Finalizable } from "@koalaui/arkoala"
import { pointer } from "@koalaui/interop";
export declare class RefCounted extends Finalizable {
    private static _finalizerHolder?;
    static get finalizerHolder(): pointer;
    constructor(ptr: pointer, allowClose?: boolean);
}
//# sourceMappingURL=RefCounted.d.ts.map