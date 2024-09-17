import { Finalizable } from "./Finalizable"
import { pointer, KNativePointer } from "@koalaui/interop"
import { int32 } from "@koalaui/common"

export class Paint extends Finalizable {
    constructor(ptr: pointer)

    public static getFinalizer(): KNativePointer

    public set antiAlias(value: boolean)

    public set color(color: int32)

    public static make(): Paint 
}