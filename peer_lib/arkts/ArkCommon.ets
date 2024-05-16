import { NativePeerNode } from "./arkoala"
import { BackgroundBlurStyleOptions, BlurOptions, BlurStyle, CommonAttribute, CommonMethod, DragInteractionOptions, DragPreviewOptions, Length, SheetOptions, StateStyles } from "./dts-exports"

export class ArkCommon implements CommonMethod<CommonAttribute> {
  protected peer?: NativePeerNode
  setPeer(peer: NativePeerNode) {
  }
  /** @memo:intrinsic */
  protected checkPriority(
      name: string
  ): boolean { throw new Error("not implemented") }
  protected applyAttributesFinish(): void { throw new Error("not implemented") }

  stateStyles(value: StateStyles): this { throw new Error("not implemented"); }
  backdropBlur(value: number, options?: BlurOptions): this { throw new Error("not implemented"); }
  width(value: Length): this { throw new Error("not implemented"); }
  height(value: Length): this { throw new Error("not implemented"); }
  bindSheet(isShow: boolean, builder: () => void, options?: SheetOptions): this { throw new Error("not implemented"); }
  backgroundBlurStyle(value: BlurStyle, options?: BackgroundBlurStyleOptions): this { throw new Error("not implemented"); }
  dragPreviewOptions(value: DragPreviewOptions, options?: DragInteractionOptions): this { throw new Error("not implemented"); }
}

export class ArkStructCommon extends ArkCommon {
  build(): void { throw new Error("not implemented"); }
  aboutToAppear(): void { throw new Error("not implemented"); }
  aboutToDisappear(): void { throw new Error("not implemented"); }
  aboutToReuse(): void { throw new Error("not implemented"); }
  aboutToRecycle(): void { throw new Error("not implemented"); }
}
