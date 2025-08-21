/*
 * Copyright (c) 2023-2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * @file
 * @kit ArkGraphics2D
 */
import type image from './@ohos.multimedia.image';
import type common2D from './@ohos.graphics.common2D';
import type colorSpaceManager from './@ohos.graphics.colorSpaceManager';
import { Resource } from './global/resource';
/**
 * The common2D module defines some common data types in the 2D graphics field.
 *
 * @namespace drawing
 * @syscap SystemCapability.Graphics.Drawing
 * @since 20
 */
declare namespace drawing {
    /**
     * Enumerates the blend modes. A blend mode combines two colors (source color and destination color) in a specific way to create a new color.
     * This is commonly used in graphics operations like overlaying, filtering, and masking.
     * The blending process applies the same logic to the red, green, and blue color channels separately.
     * The alpha channel, however, is handled according to the specific definitions of each blend mode.
     *
     * For brevity, the following abbreviations are used:
     *
     * s: source.
     * d: destination.
     * sa: source alpha.
     * da: destination alpha.
     * The following abbreviations are used in the calculation result:
     *
     * r: used when the calculation method is the same for the four channels (alpha, red, green, and blue channels).
     * ra: used when only the alpha channel is manipulated.
     * rc: used when the other three color channels are manipulated.
     * The table below shows the effect of each blend mode, where the yellow rectangle is the source and the blue circle is the destination.
     *
     * @enum { int }
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    enum BlendMode {
        /**
         * r = 0, sets the the destination pixels to fully transparent.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        CLEAR = 0,
        /**
         * r = s (all channels of the result equal those of the source), replaces the destination pixels with the source pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        SRC = 1,
        /**
         * r = d (all channels of the result equal those of the destination), keeps the destination pixels unchanged.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        DST = 2,
        /**
         * r = s + (1 - sa) * d, draws the source pixels over the destination pixels, considering the source's transparency.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        SRC_OVER = 3,
        /**
         * r = d + (1 - da) * s, draws the destination pixels over the source pixels, considering the destination's transparency.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        DST_OVER = 4,
        /**
         * r = s * da, retains only the intersection of the source pixels with the opaque parts of the destination.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        SRC_IN = 5,
        /**
         * r = d * sa, retains only the intersection of the destination pixels with the opaque parts of the source.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        DST_IN = 6,
        /**
         * r = s * (1 - da), retains the parts of the source pixels that do not overlap with the destination.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        SRC_OUT = 7,
        /**
         * r = d * (1 - sa), retains the parts of the destination pixels that do not overlap with the source.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        DST_OUT = 8,
        /**
         * r = s * da + d * (1 - sa), covers the destination pixels with the source pixels, showing the source only in the opaque parts of the destination.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        SRC_ATOP = 9,
        /**
         * r = d * sa + s * (1 - da), covers the source pixels with the destination pixels, showing the destination only in the opaque parts of the source.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        DST_ATOP = 10,
        /**
         * r = s * (1 - da) + d * (1 - sa), shows only the non-overlapping parts of the source and destination pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        XOR = 11,
        /**
         * r = min(s + d, 1), adds the color values of the source and destination pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        PLUS = 12,
        /**
         * r = s * d, multiplies the color values of the source and destination pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        MODULATE = 13,
        /**
         * r = s + d - s * d, inverts the color values of the source and destination pixels, multiplies them,
         * and then inverts the result, typically producing a brighter outcome.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        SCREEN = 14,
        /**
         * Selectively applies MULTIPLY or SCREEN based on the brightness of the destination pixels, enhancing contrast.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        OVERLAY = 15,
        /**
         * rc = s + d - max(s * da, d * sa), ra = s + (1 - sa) * d, takes the darker color values between the source and destination pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        DARKEN = 16,
        /**
         * rc = s + d - min(s * da, d * sa), ra = s + (1 - sa) * d, takes the lighter color values between the source and destination pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        LIGHTEN = 17,
        /**
         * Brightens the destination pixels by reducing contrast to reflect the source pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        COLOR_DODGE = 18,
        /**
         * Darkens the destination pixels by increasing contrast to reflect the source pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        COLOR_BURN = 19,
        /**
         * Selectively applies MULTIPLY or SCREEN based on the brightness of the source pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        HARD_LIGHT = 20,
        /**
         * Softly brightens or darkens the destination pixels based on the brightness of the source pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        SOFT_LIGHT = 21,
        /**
         * rc = s + d - 2 * (min(s * da, d * sa)), ra = s + (1 - sa) * d, calculates the difference between the color values of the source and destination pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        DIFFERENCE = 22,
        /**
         * rc = s + d - two(s * d), ra = s + (1 - sa) * d, similar to DIFFERENCE but with lower contrast.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        EXCLUSION = 23,
        /**
         * r = s * (1 - da) + d * (1 - sa) + s * d, multiplies the color values of the source and destination pixels, typically resulting in a darker outcome.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        MULTIPLY = 24,
        /**
         * Uses the hue of the source pixels and the saturation and brightness of the destination pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        HUE = 25,
        /**
         * Uses the saturation of the source pixels and the hue and brightness of the destination pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        SATURATION = 26,
        /**
         * Uses the hue and saturation of the source pixels and the brightness of the destination pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        COLOR = 27,
        /**
         * Uses the brightness of the source pixels and the hue and saturation of the destination pixels.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        LUMINOSITY = 28
    }
    /**
     * Implements a rounded rectangle.
     *
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class RoundRect {
        
        /**
         * A constructor used to create a RoundRect object.
         * A rounded rectangle is created when both xRadii and yRadii are greater than 0.
         * Otherwise, only a rectangle is created.
         * @param { common2D.Rect } rect - Rectangle that encloses the rounded rectangle to create.
         * @param { double } xRadii - Radius of the rounded corner on the X axis.
         *     The value is a floating point number. A negative number is invalid.
         * @param { double } yRadii - Radius of the rounded corner on the Y axis.
         *     The value is a floating point number. A negative number is invalid.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         *     <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor(rect: common2D.Rect, xRadii: double, yRadii: double);
    }
    /**
     * Enumerates the path operation types. It is often used in path combination and clipping scenarios.
     * @enum { int }
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    enum PathOp {
        /**
         * Difference operation.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        DIFFERENCE = 0,
        /**
         * Intersection operation.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        INTERSECT = 1,
        /**
         * Union operation.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        UNION = 2,
        /**
         * XOR operation.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        XOR = 3,
        /**
         * Reverse difference operation.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        REVERSE_DIFFERENCE = 4
    }
    /**
     * Implements a path operation iterator. You can read path operation instructions by traversing the iterator.
     *
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class PathIterator {
        /**
         * Creates an iterator and binds it with a path.
         * @param { Path } path - Path object bound to the iterator.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor(path: Path);
    }
    /**
     * A compound geometric path consisting of line segments, arcs, quadratic Bezier curves, and cubic Bezier curves.
     *
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class Path {
        /**
         * Constructs a path.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor();
        /**
         * Constructs a copy of an existing path.
         * @param { Path } path - Path to copy.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor(path: Path);
        
        /**
         * Draws an arc to this path using angle arc mode.
         * This mode first defines a rectangle and takes its inscribed ellipse.
         * Then, it specifies a start angle and a sweep angle.
         * The arc is the portion of the ellipse's circumference defined by the start angle and the sweep angle. By default,
         * a line segment from the last point of the path to the start point of the arc is also added.
         * @param { double } x1 - X coordinate of the upper left corner of the rectangle.
         *     The value is a floating point number.
         * @param { double } y1 - Y coordinate of the upper left corner of the rectangle.
         *     The value is a floating point number.
         * @param { double } x2 - X coordinate of the lower right corner of the rectangle.
         *     The value is a floating point number.
         * @param { double } y2 - Y coordinate of the lower right corner of the rectangle.
         *     The value is a floating point number.
         * @param { double } startDeg - Start angle. The start direction (0°) of the angle is
         *     the positive direction of the X axis.
         * @param { double } sweepDeg - Angle to sweep, in degrees. A positive number indicates a clockwise sweep,
         *     and a negative value indicates a counterclockwise swipe.
         *     The actual swipe degree is the modulo operation result of the input parameter by 360.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         *     <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        arcTo(x1: double, y1: double, x2: double, y2: double, startDeg: double, sweepDeg: double): void;
        /**
         * Resets the path data.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        reset(): void;
    }
    /**
     * Enumerates the filter modes.
     * @enum { int }
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    enum FilterMode {
        /**
         * Nearest filter mode.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        FILTER_MODE_NEAREST = 0,
        /**
         * Linear filter mode.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        FILTER_MODE_LINEAR = 1
    }
    /**
     * Implements sampling options.
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class SamplingOptions {
        /**
         * Creates a SamplingOptions object. The default value of FilterMode is FILTER_MODE_NEAREST.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor();
        /**
         * Creates a SamplingOptions object.
         * @param { FilterMode } filterMode - Storage filter mode.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor(filterMode: FilterMode);
    }
    /**
     * A carrier that carries the drawn content and drawing status.
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class Canvas {
        /**
         * Creates a Canvas object that uses a PixelMap as the drawing target.
         * @param { image.PixelMap } pixelmap - PixelMap used to create the object.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor(pixelmap: image.PixelMap);
        
        /**
         * Draws a rectangle. By default, black is used for filling.
         * @param { common2D.Rect } rect - Rectangle to draw.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        drawRect(rect: common2D.Rect): void;
        
        /**
         * Draws a rectangle. By default, black is used for filling.
         * This API provides better performance than drawRect and is recommended.
         * @param { double } left - X coordinate of the upper left corner of the rectangle.
         *     The value is a floating point number.
         * @param { double } top - Y coordinate of the upper left corner of the rectangle.
         *     The value is a floating point number.
         * @param { double } right - X coordinate of the lower right corner of the rectangle.
         *     The value is a floating point number.
         * @param { double } bottom - Y coordinate of the lower right corner of the rectangle.
         *     The value is a floating point number.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         *     <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        drawRect(left: double, top: double, right: double, bottom: double): void;
        /**
         * Draws an image onto a specified area of the canvas.
         * @param { image.PixelMap } pixelmap - The source image.
         * @param { common2D.Rect } dstRect - Rectangle object, which specifies the area of the canvas onto which the image will be drawn.
         * @param { SamplingOptions } samplingOptions - Sampling options.
         * By default, the SamplingOptions object created using the no-argument constructor is used.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        drawImageRect(pixelmap: image.PixelMap, dstRect: common2D.Rect, samplingOptions?: SamplingOptions): void;
        
        /**
         * Draws a PixelMap based on a mesh, where mesh vertices are evenly distributed across the PixelMap.
         * @param { image.PixelMap } pixelmap - PixelMap to draw.
         * @param { int } meshWidth - Number of columns in the mesh. The value is an integer greater than 0.
         * @param { int } meshHeight - Number of rows in the mesh. The value is an integer greater than 0.
         * @param { Array<double> } vertices - Array of vertices, which specify the position to draw.
         *     The value is a floating-point array and the size must be ((meshWidth+1) * (meshHeight+1) + vertOffset) * 2.
         * @param { int } vertOffset - Number of vert elements to skip before drawing.
         *     The value is an integer greater than or equal to 0.
         * @param { Array<int> } colors - Array of colors, which specify the color at each vertex.
         *     The value is an integer array and can be null. The size must be (meshWidth+1) * (meshHeight+1) + colorOffset.
         * @param { int } colorOffset - Number of color elements to skip before drawing.
         *     The value is an integer greater than or equal to 0.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         *     <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        drawPixelMapMesh(pixelmap: image.PixelMap, meshWidth: int, meshHeight: int, vertices: Array<double>, vertOffset: int, colors: Array<int>, colorOffset: int): void;
        /**
         * Attaches a brush to the canvas. When you draw on the canvas, the brush's style is used to fill the interior of shapes.
         * @param { Brush } brush - Brush object.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        attachBrush(brush: Brush): void;
        /**
         * Detaches the brush from the canvas. When you draw on the canvas, the brush is no longer used to fill the interior of shapes.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        detachBrush(): void;
        
        /**
         * Saves the matrix and cropping region of the canvas, and allocates a PixelMap for subsequent drawing.
         * If you call restore, changes made to the matrix and clipping region are discarded, and the PixelMap is drawn.
         * @param { common2D.Rect | null} rect - Rect object, which is used to limit the size of the graphics layer.
         *     The default value is the current canvas size.
         * @param { Brush | null} brush - Brush object. The alpha value, filter effect,
         *     and blend mode of the brush are applied when the PixelMap is drawn.
         *     If null is passed in, no effect is applied.
         * @returns { long } Number of canvas statuses that have been saved. The value is a positive integer.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: Mandatory parameters are left unspecified.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        saveLayer(rect?: common2D.Rect | null, brush?: Brush | null): long;
        /**
         * Restores the canvas state (canvas matrix and clipping area) saved on the top of the stack.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        restore(): void;
        
        /**
         * Applies a rotation matrix on top of the current canvas matrix (identity matrix by default).
         * Subsequent drawing and clipping operations will automatically have a rotation effect applied to
         * their shapes and positions.
         * @param { double } degrees - Angle to rotate, in degrees. The value is a floating point number.
         *     A positive value indicates a clockwise rotation, and a negative value indicates a counterclockwise rotation.
         * @param { double } sx - X coordinate of the rotation center. The value is a floating point number.
         * @param { double } sy - Y coordinate of the rotation center. The value is a floating point number.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         *     <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        rotate(degrees: double, sx: double, sy: double): void;
    }
    /**
     * Enumerates the canvas clipping modes.
     *
     * @enum { int }
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    enum ClipOp {
        /**
         * Clips a specified area. That is, the difference set is obtained.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        DIFFERENCE = 0,
        /**
         * Retains a specified area. That is, the intersection is obtained.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        INTERSECT = 1
    }
    /**
     * Describes the style of a typeface, such as SimSun or KaiTi.
     *
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class Typeface {
        /**
         * Constructs a typeface from a file.
         * @param { string } filePath - file path for typeface.
         * @returns { Typeface } Typeface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        static makeFromFile(filePath: string): Typeface;
    }
    /**
     * Describes the attributes used for text rendering, such as size and typeface.
     *
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class Font {
        
        /**
         * Sets the font size.
         * @param { double } textSize - Font size. The value is a floating point number.
         * If a negative number is passed in, the size is set to 0. If the size is 0, the text drawn will not be displayed.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         *     <br>2. Incorrect parameter types; 3. Parameter verification failed.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        setSize(textSize: double): void;
        /**
         * Sets the typeface style (including attributes such as font name, weight, and italic) for the font.
         * @param { Typeface } typeface - Typeface style (including attributes such as font name, weight, and italic).
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        setTypeface(typeface: Typeface): void;
        /**
         * Obtains the font metrics of the typeface.
         * @returns { FontMetrics } The fontMetrics value returned to the caller.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        getMetrics(): FontMetrics;
    }
    /**
     * Describes the attributes that describe the font size and layout. A typeface has similar font metrics.
     * @typedef FontMetrics
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    interface FontMetrics {
        
        /**
         * Maximum distance from the baseline to the highest coordinate of the text. The value is a floating point number.
         * @type { double }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        top: double;
        
        /**
         * Distance from the baseline to the highest coordinate of the text. The value is a floating point number.
         * @type { double }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        ascent: double;
        
        /**
         * Distance from the baseline to the lowest coordinate of the text. The value is a floating point number.
         * @type { double }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        descent: double;
        
        /**
         * Maximum distance from the baseline to the lowest coordinate of the text. The value is a floating point number.
         * @type { double }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        bottom: double;
        
        /**
         * Interline spacing, that is, the distance from the descent of one line of text to the ascent of the next line.
         * The value is a floating point number.
         * @type { double }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        leading: double;
    }
    /**
     * Implements a lattice object, which is used to divide an image by lattice.
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class Lattice {
        
        /**
         * Divides the image into lattices. The lattices on both even columns and even rows are fixed,
         * and they are drawn at their original size if the target is large enough.
         * If the target is too small to hold the fixed lattices, all the fixed lattices are scaled down to fit the target,
         * and the lattices that are not on even columns and even rows are scaled to accommodate the remaining space.
         * @param { Array<int> } xDivs - Array of X coordinates used to divide the image. The value is an integer.
         * @param { Array<int> } yDivs - Array of Y coordinates used to divide the image. The value is an integer.
         * @param { int } fXCount - Size of the array that holds the X coordinates. The value range is [0, 5].
         * @param { int } fYCount - Size of the array that holds the Y coordinates. The value range is [0, 5].
         * @param { common2D.Rect | null } [fBounds] - Source bounds to draw. The rectangle parameter must be an integer.
         *     The default value is the rectangle size of the original image. If the rectangle parameter is a decimal,
         *     the decimal part is discarded and converted into an integer.
         * @param { Array<RectType> | null } [fRectTypes] - Array that holds the rectangle types. The default value is null.
         *     If this parameter is specified, the array size must be (fXCount + 1) * (fYCount + 1).
         * @param { Array<common2D.Color> | null } [fColors] - Array that holds the colors used to fill the lattices.
         *     The default value is null.
         *     If this parameter is specified, the array size must be (fXCount + 1) * (fYCount + 1).
         * @returns { Lattice } Lattice object.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         *     <br>2. Incorrect parameter types; 3. Parameter verification failed.
         * @static
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        static createImageLattice(xDivs: Array<int>, yDivs: Array<int>, fXCount: int, fYCount: int, fBounds?: common2D.Rect | null, fRectTypes?: Array<RectType> | null, fColors?: Array<common2D.Color> | null): Lattice;
    }
    /**
     * Enumerates the types of rectangles used to fill the lattices. This enum is used only in Lattice.
     * @enum { int }
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    enum RectType {
        /**
         * Draws an image into the lattice.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        DEFAULT = 0,
        /**
         * Sets the lattice to transparent.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        TRANSPARENT = 1,
        /**
         * Draws the colors in the fColors array in Lattice into the lattice.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        FIXEDCOLOR = 2
    }
    /**
     * Defines a color filter.
     *
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class ColorFilter {
        
        /**
         * Creates a ColorFilter object with a given color and blend mode.
         * @param { common2D.Color } color - Color in ARGB format. The value of each color channel is an integer ranging from 0 to 255.
         * @param { BlendMode } mode - Blend mode.
         * @returns { ColorFilter } Colorfilter object.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types; 3. Parameter verification failed.
         * @static
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        static createBlendModeColorFilter(color: common2D.Color, mode: BlendMode): ColorFilter;
        
        /**
         * Creates a ColorFilter object with a given color and blend mode.
         * @param { common2D.Color | int } color - Color, represented by an unsigned integer in hexadecimal ARGB format.
         * @param { BlendMode } mode - Blend mode.
         * @returns { ColorFilter } Colorfilter object.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types; 3. Parameter verification failed.
         * @static
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        static createBlendModeColorFilter(color: common2D.Color | int, mode: BlendMode): ColorFilter;
    }
    /**
     * Defines a pen, which is used to describe the style and color to outline a shape.
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class Pen {
        /**
         * A constructor used to create a Pen object.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor();
        /**
         * Copies a Pen object to create a new one.
         * @param { Pen } pen - Pen object to copy.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor(pen: Pen);
        /**
        * Sets a blend mode for this pen.
        *
        * @param { BlendMode } mode - Blend mode.
        * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
        * <br>2. Incorrect parameter types; 3. Parameter verification failed.
        * @syscap SystemCapability.Graphics.Drawing
        * @since 20
        */
        setBlendMode(mode: BlendMode): void;
        /**
         * Resets this pen to the initial state.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        reset(): void;
    }
    /**
     * Defines a brush, which is used to describe the style and color to fill in a shape.
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class Brush {
        /**
         * A constructor used to create a Brush object.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor();
        /**
         * Copies a Brush object to create a new one.
         * @param { Brush } brush - Indicates the Brush object.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor(brush: Brush);
        /**
         * Sets a blend mode for this brush. If this API is not called, the default blend mode is SRC_OVER.
         * @param { BlendMode } mode - Blend mode.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types; 3. Parameter verification failed.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        setBlendMode(mode: BlendMode): void;
        /**
         * Resets this brush to the initial state.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        reset(): void;
    }
    /**
     * Implements a matrix.
     *
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class Matrix {
        /**
         * Creates a Matrix object.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        constructor();
        /**
         * Resets this matrix to an identity matrix.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        reset(): void;
    }
    /**
     * Describes a region, which is used to describe the region where the shape can be drawn.
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    class Region {
    }
    /**
     * Enumerates the operations for combining two regions.
     * @enum { int }
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    enum RegionOp {
        /**
         * Difference operation.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        DIFFERENCE = 0,
        /**
         * Intersect operation.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        INTERSECT = 1,
        /**
         * Union operation.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        UNION = 2,
        /**
         * Xor operation.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        XOR = 3,
        /**
         * Reverse difference operation.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        REVERSE_DIFFERENCE = 4,
        /**
         * Replace operation.
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        REPLACE = 5
    }
}
export default drawing;
