import { int32 } from "peer_lib/ts/@koalaui/common"
import { pointer } from "peer_lib/ts/@koalaui/interop"

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
