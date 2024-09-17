import { pointer, getPtr, isNullPtr, registerCallback, withFloatArray, Access } from "@koalaui/interop"
import { nativeModule } from "@koalaui/arkoala"
import { Canvas } from "./Canvas"
import { Rect } from "./Rect"
import { RefCounted } from "./RefCounted"
import { int32, Matrix33 } from "@koalaui/common"
import { Paint } from "./Paint"

/**
 * The base abstraction for object which can draw into canvas.
 */
export class Drawable extends RefCounted {
    constructor(ptr: pointer) {
        super(ptr)
    }

    public draw(canvas: Canvas, matrix: Matrix33|undefined): void {
        withFloatArray(matrix?.array, Access.READ, ptr => {
            nativeModule()._skoala_Drawable__1nDraw(this.ptr, getPtr(canvas), ptr)
        })
    }

    public get generationId(): int32 {
        return nativeModule()._skoala_Drawable__1nGetGenerationId(this.ptr)
    }

    public notifyDrawingChanged(): void {
        nativeModule()._skoala_Drawable__1nNotifyDrawingChanged(this.ptr)
    }
}

/**
 * Base class for custom drawable.
 * onDraw and onGetBounds should be implemented for custom drawing
 */
export abstract class CustomDrawable extends Drawable {
    boundsRect?: Rect

    public abstract onDraw(canvas: Canvas): void

    public abstract onGetBounds(): Rect

    constructor(ptr: pointer) {
        super(ptr)
    }

    onDrawCallback(this: CustomDrawable) {
        const ptr = nativeModule()._skoala_CustomDrawable__1nGetOnDrawCanvas(this.ptr)
        if (!isNullPtr(ptr)) {
            this.onDraw(new Canvas(ptr, false))
        }
    }

    onGetBoundsCallback(this: CustomDrawable) {
        this.boundsRect = this.onGetBounds()
        nativeModule()._skoala_CustomDrawable__1nSetBounds(this.ptr,
            this.boundsRect.left, this.boundsRect.top, this.boundsRect.right, this.boundsRect.bottom
        )
    }

    public get bounds(): Rect|undefined {
        if (this.boundsRect === undefined) {
            this.boundsRect = this.onGetBounds()
        }
        return this.boundsRect
    }

    public static makeRectDrawable(drawableType: int32): RectCustomDrawable {
        const ptr = nativeModule()._skoala_CustomDrawable__1nMake()
        if (!ptr) throw new TypeError("can not create an instance of type Drawable")
        let drawable = new RectCustomDrawable(ptr)
        nativeModule()._skoala_CustomDrawable__1nInit(getPtr(drawable),
            registerCallback(drawable.onGetBoundsCallback, drawable),
            registerCallback(drawable.onDrawCallback, drawable)
        )
        return drawable
    }

    public notifyDrawingChanged(): void {
        super.notifyDrawingChanged()
        this.boundsRect = undefined
    }
}

class RectCustomDrawable extends CustomDrawable {
    public onDraw(canvas: Canvas): void {
        let paint = Paint.make()
        canvas.drawRect(0, 0, 8, 8, paint)
    }

    public onGetBounds(): Rect {
        return Rect.makeLTRB(0, 0, 8, 8)
    }
}
