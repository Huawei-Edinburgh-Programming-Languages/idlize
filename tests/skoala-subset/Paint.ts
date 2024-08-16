import { pointer, KNativePointer } from "@koalaui/interop"
// export { FinalizableBase } from "@koalaui/interop"
import { Finalizable } from "@koalaui/arkoala"
import { float32, int32 } from "@koalaui/common"
import { Myclass } from "./Canvas"

export declare class Paint extends Finalizable {
    constructor(ptr: pointer);
    tesT(myClass: Myclass): void
    test1(arg1: Finalizable): boolean
    test2(arg1: Paint): number
    test3(arg1: float32, arg2: int32): int32
    test4(): Paint
    test5(): Finalizable
    test6(aPaint: Paint, bPaint: Paint)
}
//# sourceMappingURL=Paint.d.ts.map