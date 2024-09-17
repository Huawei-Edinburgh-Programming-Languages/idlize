import { pointer } from "@koalaui/interop";
import { Canvas } from "./Canvas";
import { Rect } from "./Rect";
import { RefCounted } from "./RefCounted";
import { int32, Matrix33 } from "@koalaui/common";
import { Paint } from "./Paint"


export declare class Drawable extends RefCounted {
    constructor(ptr: pointer);
    draw(canvas: Canvas, matrix: Matrix33 | undefined): void;
    get generationId(): int32;
    notifyDrawingChanged(): void;
}

export declare abstract class CustomDrawable extends Drawable {
    boundsRect?: Rect;
    abstract onDraw(canvas: Canvas): void;
    abstract onGetBounds(): Rect;
    constructor(ptr: pointer);
    onDrawCallback(this: CustomDrawable): void;
    onGetBoundsCallback(this: CustomDrawable): void;
    get bounds(): Rect | undefined;
    static makeRectDrawable(drawableType: int32): RectCustomDrawable
    notifyDrawingChanged(): void;
}

declare class RectCustomDrawable extends CustomDrawable {
    public onDraw(canvas: Canvas): void
    public onGetBounds(): Rect
}
//# sourceMappingURL=Drawable.d.ts.map