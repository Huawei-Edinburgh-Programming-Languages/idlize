import { int32 } from "@koalaui/common"
import { pointer } from "@koalaui/interop"

export class Finalizable {
    constructor(public ptr: pointer) {
    }
}

export class NativePeerNode extends Finalizable {
}

export class PeerNode extends Finalizable {
    constructor(type: number, flags: int32) {
        // TODO: rework
        super(BigInt(42))
    }
    applyAttributes(attrs: Object) {}
}
