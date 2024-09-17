import { Finalizable } from "./Finalizable"
import { pointer } from "@koalaui/interop"

export class RefCounted extends Finalizable {
    private static _finalizerHolder?: pointer
    static get finalizerHolder(): pointer
    constructor(ptr: pointer, allowClose: boolean)
}