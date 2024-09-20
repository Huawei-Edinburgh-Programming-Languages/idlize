import { pointer, KNativePointer } from "@koalaui/interop";
import { Bitmap } from "./Bitmap";
import { BlendMode } from "./BlendMode";
import { ClipMode } from "./ClipMode";
import { Drawable } from "./Drawable";
import { FilterMode } from "./FilterMode";
import { Font } from "./Font";
import { Image } from "./Image";
import { IRect } from "./IRect";
import { Paint } from "./Paint";
import { Path } from "./Path";
import { Picture } from "./Picture";
import { Rect, RRect } from "./Rect";
import { Region } from "./Region";
import { SamplingMode } from "./SamplingMode";
import { SurfaceProps } from "./SurfaceProps";
import { TextBlob } from "./TextBlob";
import { VertexMode } from "./VertexMode";
import { Finalizable } from "./Finalizable";
import { Matrix33, Matrix44, Point, int32, uint32, float32 } from "@koalaui/common";
/**
 * The mode to draw points.
 */
export declare enum CanvasPointMode {
    /**
     * Draws only points
     */
    Points = 0,
    /**
     * Draws line segments for each pair of points
     */
    Lines = 1,
    /**
     * Draws an open polygon based on the array of points
     */
    Polygon = 2
}
export declare enum SaveLayerFlagsSet {
    PreserveLCDText = 2,
    InitWithPrevious = 4,
    F16ColorType = 16
}
/**
 * Canvas provides the drawing interface. It supports the stack of transformation matrixes and clips.
 */
export declare class Canvas extends Finalizable {
    private owner?;
    constructor(ptr: pointer, managed?: boolean, owner?: object);
    static getFinalizer(): KNativePointer;
    /**
     * Creates an instance of Canvas that draws into the given bitmap.
     *
     * @param bitmap - bitmap to draw into
     * @param surfaceProps - device properties
     * @returns the new instance of Canvas to draw into bitmap
     *
     */
    static makeFromBitmap(bitmap: Bitmap, surfaceProps: SurfaceProps): Canvas;
    /**
     * Draws a point.
     *
     * @param x - x-coordinate of point
     * @param y - y-coordinate of point
     * @param paint - paint to draw with
     *
     */
    drawPoint(x: float32, y: float32, paint: Paint): void;
    /**
     * Draws points with given drawing mode.
     *
     * @param mode - points drawing mode
     * @param points - array of points to draw
     * @param paint - paint to draw with
     *
     */
    drawPoints(mode: CanvasPointMode, points: Array<Point>, paint: Paint): void;
    /**
     * Draws a line segment.
     *
     * @param x0 - x-coordinate of start segment point
     * @param y0 - y-coordinate of start segment point
     * @param x1 - x-coordinate of end segment point
     * @param y1 - y-coordinate of end segment point
     * @param paint - paint to draw with
     *
     */
    drawLine(x0: float32, y0: float32, x1: float32, y1: float32, paint: Paint): void;
    /**
     * Draws the arc which is part of the oval bounded by the given rectangle
     *
     * @param left - left of rectangle bounds
     * @param top - top of rectangle bounds
     * @param right - right of rectangle bounds
     * @param bottom - bottom of rectangle bounds
     * @param startAngle - angle in degrees the arc starts sweeping from
     * @param sweepAngle - angle in degrees to sweep from start. A positive value gives clockwise motion
     * @param includeCenter - true to draw a wedge connecting center with arc end points.
     * @param paint - paint to draw with
     *
     */
    drawArc(left: float32, top: float32, right: float32, bottom: float32, startAngle: float32, sweepAngle: float32, includeCenter: boolean, paint: Paint): void;
    /**
     * Draws a rectangle
     *
     * @param left - left of rectangle
     * @param top - top of rectangle
     * @param right - right of rectangle
     * @param bottom - bottom of rectangle
     * @param paint - paint to draw with
     *
     */
    drawRect(left: float32, top: float32, right: float32, bottom: float32, paint: Paint): void;
    /**
     * Draws the oval, bounded by the given rectangle
     *
     * @param left - left of rectangle bounds
     * @param top - top of rectangle bounds
     * @param right - right of rectangle bounds
     * @param bottom - bottom of rectangle bounds
     * @param paint - paint to draw with
     *
     */
    drawOval(left: float32, top: float32, right: float32, bottom: float32, paint: Paint): void;
    /**
     * Draws a circle
     *
     * @param x - x-coordinate of the center of the cirle
     * @param y - y-coordinate of the center of the cirle
     * @param radius - radius of the cirle
     * @param paint - paint to draw with
     *
     */
    drawCircle(x: float32, y: float32, radius: float32, paint: Paint): void;
    /**
     * Draws a rounded rectangle
     *
     * @param rect - rounded rectangle to draw
     * @param paint - paint to draw with
     *
     */
    drawRRect(rect: RRect, paint: Paint): void;
    /**
     * Draws the difference of two rounded rectangles (the subtraction of inner from outer).
     * The outer rectangle should contain the inner rectangle.
     *
     * @param outer - outer rounded rectangle
     * @param inner - inner rounded rectangle
     * @param paint - paint to draw with
     *
     */
    drawDRRect(outer: RRect, inner: RRect, paint: Paint): void;
    /**
     * Draws a path.
     *
     * @param path - path to draw
     * @param paint - paint to draw with
     *
     */
    drawPath(path: Path, paint: Paint): void;
    /**
     * Draws an image at the given point with default sampling mode.
     *
     * @param image - image to draw
     * @param left - x coordinate of image destination
     * @param top - y coordinate of image destination
     * @param paint - paint to draw with
     *
     */
    drawImage(image: Image, left: float32, top: float32, paint?: Paint): void;
    /**
     * Draws the part (source rectangle) of the given image into the destination rectangle.
     *
     * @param image - image to draw
     * @param src - source region to draw from image
     * @param dst - destination region to draw source region into
     * @param samplingMode - sampling mode to draw with
     * @param paint - paint to draw with
     * @param strict - source rectangle constraint.
     * If true the additional check is done to make sure that image doesn't sample outside source bounds.
     * The drawing is faster with false.
     *
     */
    drawImageRect(image: Image, src: Rect, dst: Rect, samplingMode?: SamplingMode, paint?: Paint, strict?: boolean): void;
    /**
     * Draws the stretched (as per nine-patch center rectangle) image into the destination rectangle.
     *
     * @param image - image to draw
     * @param center - nine-patch rectangle to describe image stretching
     * @param dst - destination region to draw stretched image
     * @param filterMode - filter mode to draw with
     * @param paint - paint to draw with
     *
     */
    drawImageNine(image: Image, center: IRect, dst: Rect, filterMode: FilterMode, paint: Paint): void;
    /**
     * Draws a region.
     *
     * @param region - region to draw
     * @param paint - paint to draw with
     *
     */
    drawRegion(region: Region, paint: Paint): void;
    /**
     * Draws a string.
     *
     * @param str - text to draw
     * @param x - x-coordinate of point to start drawing at
     * @param y - y-coordinate of point to start drawing at
     * @param font - text information
     * @param paint - paint to draw with
     *
     */
    drawString(str: string, x: float32, y: float32, font: Font, paint: Paint): void;
    /**
     * Draws a text blob.
     *
     * @param textBlob - text blob to draw
     * @param x - x-coordinate of point to start drawing at
     * @param y - y-coordinate of point to start drawing at
     * @param font - text information
     * @param paint - paint to draw with
     *
     */
    drawTextBlob(textBlob: TextBlob, x: float32, y: float32, paint: Paint): void;
    /**
     * Draws a picture.
     *
     * @param picture - picture to draw
     * @param matrix - transformation to apply to picture
     * @param paint - paint to draw with
     *
     */
    drawPicture(picture: Picture, matrix?: Matrix33, paint?: Paint): void;
    /**
     * Draws a triangle mesh.
     *
     * @param verticesMode - vertices triangles mode
     * @param vertices - array of vertices positions for the mesh
     * @param colors - array of colors for each vertex across the triangle.
     * If not undefined, must be the same size as positions array
     * @param texCoords - array of coordinates in texture space (not UV space) for each vertex.
     * If not undefined, must be the same size as positions array
     * @param indices - array of indices to reference into the vertex (texture coordinates, colors) array.
     * If not undefined, all values must be valid index values for positions (e.g. 0, 1, 2 for a simple triangle)
     * @param blendMode - blend mode to combine vertices colors if set with shader or paint color
     * @param paint - paint to draw with
     *
     */
    drawVertices(verticesMode: VertexMode, vertices: Array<Point>, colors: Int32Array | undefined, texCoords: Array<Point> | undefined, indices: Uint16Array | undefined, blendMode: BlendMode, paint: Paint): void;
    /**
     * Draws a Coons patch.
     *
     * @param cubics - Path cubic array of common points. Array size must be 12
     * @param colors - array of colors for each corner. If not undefined, array size must be 4
     * @param texCoords - array of texture coordinates. If not undefined, array size must be 4
     * @param blendMode - blend mode to combine corners colors (if set) with shader or paint color
     * @param paint - paint to draw with
     *
     */
    drawPatch(cubics: Array<Point>, colors: Int32Array | undefined, texCoords: Array<Point> | undefined, blendMode: BlendMode, paint: Paint): void;
    /**
     * Draws a drawable.
     *
     * @param drawable - drawable to draw
     * @param matrix - transformation to apply to drawable
     *
     */
    drawDrawable(drawable: Drawable, matrix: Matrix33 | undefined): void;
    /**
     * Fills with the given color.
     *
     * @param color - color to fill with
     *
     */
    clear(color: uint32): void;
    /**
     * Fills with the given paint.
     *
     * @param paint - paint to fill with
     *
     */
    drawPaint(paint: Paint): void;
    drawColor(color: int32): void;
    /**
     * Sets this canvas current transformation matrix to be applied to all canvas operations.
     *
     * @param matrix - matrix to set and replace existing one
     *
     */
    setMatrix(matrix: Matrix33): void;
    /**
     * Sets this canvas current matrix to identity.
     */
    resetMatrix(): void;
    /**
     * Returns transformation from local coordinates to device/pixels.
     *
     * @returns the new transformation matrix
     *
     */
    getLocalToDevice(): Matrix44;
    /**
     * Sets this canvas current clip to the given rectangle.
     * Updated clip settings will be applied for all drawing operations.
     *
     * @param left - left of clip rectangle
     * @param top - top of clip rectangle
     * @param right - right of clip rectangle
     * @param bottom - bottom of clip rectangle
     * @param mode - clip mode to apply
     * @param antiAlias - true if the clip should be smoothed
     *
     */
    clipRect(left: float32, top: float32, right: float32, bottom: float32, mode?: ClipMode, antiAlias?: boolean): void;
    /**
     * Sets this canvas current clip to the given rounded rectangle.
     * Updated clip settings will be applied for all drawing operations.
     *
     * @param rrect - rounded rectangle to use for clipping
     * @param mode - clip mode to apply
     * @param antiAlias - true if the clip should be smoothed
     *
     */
    clipRRect(rrect: RRect, mode?: ClipMode, antiAlias?: boolean): void;
    /**
     * Sets this canvas current clip to the given path.
     * Updated clip settings will be applied for all drawing operations.
     *
     * @param path - path to use for clipping
     * @param mode - clip mode to apply
     * @param antiAlias - true if the clip should be smoothed
     *
     */
    clipPath(path: Path, mode: ClipMode, antiAlias: boolean): void;
    /**
     * Sets this canvas current clip to the given region.
     * Updated clip settings will be applied for all drawing operations.
     *
     * @param region - region to use for clipping
     * @param mode - clip mode to apply
     * @param antiAlias - true if the clip should be smoothed
     *
     */
    clipRegion(region: Region, mode: ClipMode): void;
    /**
     * Pre-concatenates the given transformation matrix with the current transformation matrix.
     * Updated transformation settings will be applied for all drawing operations.
     *
     * @param matrix - matrix to premultiply with existing
     *
     */
    concat(matrix: Matrix33): void;
    /**
     * Pre-concatenates the given transformation matrix with the current transformation matrix.
     * Updated transformation settings will be applied for all drawing operations.
     *
     * @param matrix - matrix to premultiply with existing
     *
     */
    concat44(matrix: Matrix44): void;
    /**
     * Copies the part of canvas (rectangle started from the given coordinates) to the given bitmap.
     *
     * @param bitmap - bitmap to copy pixels to
     * @param srcX - left of canvas source rectangle to copy from
     * @param srcY - top of canvas source rectangle to copy from
     * @returns true if pixels are copied
     *
     */
    readPixels(bitmap: Bitmap, srcX: int32, srcY: int32): boolean;
    /**
     * Copies bitmap pixels into canvas rectangle starting with the given position.
     *
     * @param bitmap - bitmap to copy pixels from
     * @param x - canvas x-coordinate to copy to
     * @param y - canvas y-coordinate to copy to
     * @returns true if pixels are copied
     *
     */
    writePixels(bitmap: Bitmap, x: int32, y: int32): boolean;
    /**
     * Saves current transformation matrix and clip on the save stack. Call restore to pop saved state.
     *
     * @returns depth of saved stack
     *
     */
    save(): int32;
    /**
     * Saves the current canvas state (the same as save do) and additionally allocates an offscreen bitmap.
     * All drawing calls are redirected to offscreen bitmap of current layer.
     * On calling restore offscreen bitmap is transferred to canvas with applying the given paint.
     *
     * @param paint - paint to apply to offscreen bitmap on restoring
     * @returns depth of saved stack
     *
     */
    saveLayer(paint: Paint): int32;
    /**
     * Saves the current canvas state (the same as save do) and additionally allocates an offscreen bitmap.
     *
     * @param bounds - hint rectangle to limit the size of layer (offscreen bitmap)
     * @param paint - paint to apply to offscreen bitmap on restoring
     * @returns depth of saved stack
     *
     */
    saveLayerRect(bounds: Rect, paint: Paint, flag?: uint32): int32;
    /**
     * Returns the number of saved states (the number of items on the save stack).
     *
     * @returns depth of saved stack
     *
     */
    get saveCount(): int32;
    /**
     * Restores the canvas state to the top state of save stack.
     */
    restore(): void;
    /**
     * Restores the canvas state to the given layer of save stack.
     *
     * @param saveCount - number of layer (depth of saved stack returned from save) to restore from
     *
     */
    restoreToCount(saveCount: int32): void;
    xscale: float32;
    yscale: float32;
    /**
     * Pre-concatenates the current matrix with the specified scale.
     *
     * @param x - x-axis scale
     * @param y - y-axis scale
     *
     */
    scale(x: float32, y: float32): void;
    /**
     * Pre-concatenates the current matrix with the specified translate.
     *
     * @param dx - x-axis translate
     * @param dy - y-axis translate
     *
     */
    translate(dx: float32, dy: float32): void;
    /**
     * Pre-concatenates the current matrix with the specified rotate.
     *
     * @param deg - degrees to rotate
     * @param x - pivot x coordinate
     * @param y - pivot y coordinate
     *
     */
    rotate(deg: float32, x?: float32, y?: float32): void;
    /**
     * Pre-concatenates the current matrix with the specified skew.
     *
     * @param dx - x-axis skew
     * @param dy - y-axis skew
     *
     */
    skew(sx: float32, sy: float32): void;
}
//# sourceMappingURL=Canvas.d.ts.map