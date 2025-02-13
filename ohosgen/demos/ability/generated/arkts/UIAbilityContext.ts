import { int32 } from "@koalaui/common"
import { KPointer, KInt, KStringPtr, pointer, nullptr, RuntimeType, runtimeType, NativeBuffer } from "@koalaui/interop"
import { Serializer } from "./uiabilitycontextSerializer"
import { Finalizable } from "@koalaui/interop"

import { AsyncCallback } from "./@ohos.base"
import { Want } from "./@ohos.app.ability.Want"
import { UIAbilityContextNativeModule } from "./uiabilitycontextNative"

export interface UIAbilityContextInterface {
    startAbility(want: Want, callback_: (() => void)): void 
    terminateSelf(callback_: (() => void)): void 
    terminateSelf(): Promise<void> 
}
export class UIAbilityContext {
    peer: Finalizable = new Finalizable(nullptr, nullptr)
     constructor() {
        this.peer = new Finalizable(UIAbilityContextNativeModule._UIAbilityContext_ctor(), UIAbilityContext.getFinalizer())
    }
    static getFinalizer(): KPointer {
        return UIAbilityContextNativeModule._UIAbilityContext_getFinalizer()
    }
    getPeer(): Finalizable | undefined {
        return this.peer
    }
    public startAbility(want: Want, callback_: (() => void)): void {
        const want_casted = want as (Want)
        const callback__casted = callback_ as ((() => void))
        this.startAbility_serialize(want_casted, callback__casted)
        return
    }
    public terminateSelf(callback_?: (() => void)): Promise<void> | undefined {
        const callback__type = runtimeType(callback_)
        if ((((RuntimeType.UNDEFINED == callback__type)))) {
            return this.terminateSelf1_serialize()
        }
        if ((((RuntimeType.FUNCTION == callback__type)))) {
            const callback__casted = callback_ as ((() => void))
            return this.terminateSelf0_serialize(callback__casted)
        }
        throw new Error("Can not select appropriate overload")
    }
    private startAbility_serialize(want: Want, callback_: (() => void)): void {
        const thisSerializer : Serializer = Serializer.hold()
        thisSerializer.writeWant(want)
        thisSerializer.holdAndWriteCallback(callback_)
        UIAbilityContextNativeModule._UIAbilityContext_startAbility(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private terminateSelf0_serialize(callback_: (() => void)): void {
        const thisSerializer : Serializer = Serializer.hold()
        thisSerializer.holdAndWriteCallback(callback_)
        UIAbilityContextNativeModule._UIAbilityContext_terminateSelf0(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
    }
    private terminateSelf1_serialize(): Promise<void> {
        const thisSerializer : Serializer = Serializer.hold()
        const retval  = thisSerializer.holdAndWriteCallbackForPromiseVoid()[0]
        UIAbilityContextNativeModule._UIAbilityContext_terminateSelf1(this.peer!.ptr, thisSerializer.asArray(), thisSerializer.length())
        thisSerializer.release()
        return retval
    }
}
export class UIAbilityContextInternal {
    public static fromPtr(ptr: KPointer): UIAbilityContext {
        const obj : UIAbilityContext = new UIAbilityContext()
        obj.peer = new Finalizable(ptr, UIAbilityContext.getFinalizer())
        return obj
    }
}
