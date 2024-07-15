import { int32 } from "@koalaui/common"
import { pointer } from "@koalaui/interop"
import { Finalizable } from "./Finalizable"
import { nativeModule } from "@koalaui/arkoala";

export class NativePeerNode extends Finalizable {
}

export abstract class PeerNode {
    peer: NativePeerNode
    protected get nodeType(): number { throw new Error("not implemented") }
    constructor(flags: int32) {
        const id = 0 // TODO: use id
        const ptr = nativeModule()._CreateNode(this.nodeType, id, flags)
        this.peer = new NativePeerNode(ptr, getNodeFinalizer())
    }
    applyAttributes(attrs: Object) {}
}


function getNodeFinalizer() : pointer {
    return nativeModule()._GetNodeFinalizer()
}
