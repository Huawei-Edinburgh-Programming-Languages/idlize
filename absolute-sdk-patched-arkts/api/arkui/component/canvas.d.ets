/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
 * @kit ArkUI
 * @arkts 1.2
 */
import { CommonMethod, Callback, PixelMap } from './common';
import { FrameNode } from '../FrameNode';
import { ImageAIOptions, ImageAnalyzerConfig } from './imageCommon';
import { Matrix2D } from './matrix2d';
import { VoidCallback, LengthMetricsUnit, LengthMetrics } from './units';
import { Size } from '../Graphics';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';

/**
 * Filling style algorithm, which determines whether a point is within or outside the path. The following
 *    two configurations are supported:
 * 'evenodd': odd and even round rule
 * 'nonzero': (Default) Non-zero Wrap Rules
 *
 * @typedef { 'evenodd' | 'nonzero' } CanvasFillRule
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type CanvasFillRule = 'evenodd' | 'nonzero';

/**
 * Specifies the attribute of drawing the end of each line segment. The following configurations are supported:
 * 'butt': (Default) Segment Ends in Square
 * 'round': Segment ends in a circle
 * 'square': The end of the segment ends in a square, but a rectangular area is added that is the same width
 *    as the segment and is half the thickness of the segment.
 *
 * @typedef { 'butt' | 'round' | 'square' } CanvasLineCap
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type CanvasLineCap = 'butt' | 'round' | 'square';

/**
 * Sets the attribute of how two connected parts (line segments, arcs, and curves) whose length is not 0
 *    are connected together. The following three configurations are supported:
 * 'bevel': Fill the ends of the connected sections with an additional triangle-base area,
 *    each with its own independent rectangular corner.
 * 'miter': (Default) An additional diamond region is formed by extending the outer edges of the connected portions
 *    so that they intersect at a point.
 * 'round': Draw the shape of the corner by filling in an additional sector with the center at the end of the
 *    connected section. The radius of the fillet is the width of the segment.
 *
 * @typedef { 'bevel' | 'miter' | 'round' } CanvasLineJoin
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type CanvasLineJoin = 'bevel' | 'miter' | 'round';

/**
 * Indicates the attribute of the current text direction. The options are as follows:
 * 'inherit': (Default) Inherit current Canvas component settings
 * 'ltr': The text direction is left to right.
 * 'rtl': The text direction is from right to left.
 *
 * @typedef { 'inherit' | 'ltr' | 'rtl' } CanvasDirection
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type CanvasDirection = 'inherit' | 'ltr' | 'rtl';

/**
 * Describes the alignment mode for drawing text. The options are as follows:
 * 'center': The text is centered.
 * 'end': Where text aligns lines end (Left alignment refers to the local from left to right,
 *    and right alignment refers to the local from right to left)
 * 'left': (Default) The text is left-aligned.
 * 'right': The text is right-aligned.
 * 'start': Where the text snap line begins (Left alignment refers to the local from left to right,
 *    and right alignment refers to the local from right to left)
 *
 * @typedef { 'center' | 'end' | 'left' | 'right' | 'start' } CanvasTextAlign
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type CanvasTextAlign = 'center' | 'end' | 'left' | 'right' | 'start';

/**
 * Text baseline, which supports the following configurations:
 * 'alphabetic': (Default) The text baseline is the standard letter baseline.
 * 'bottom': The text baseline is at the bottom of the text block. The difference between the ideographic baseline
 *    and the ideographic baseline is that the ideographic baseline does not need to consider downlink letters.
 * 'hanging': The text baseline is a hanging baseline.
 * 'ideographic': The text baseline is the ideographic baseline; If the character itself exceeds the alphabetic
 *    baseline, the ideographic baseline is at the bottom of the character itself.
 * 'middle': The text baseline is in the middle of the text block.
 * 'top': The text baseline is at the top of the text block.
 *
 * @typedef { 'alphabetic' | 'bottom' | 'hanging' | 'ideographic' | 'middle' | 'top' } CanvasTextBaseline
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type CanvasTextBaseline = 'alphabetic' | 'bottom' | 'hanging' | 'ideographic' | 'middle' | 'top';

/**
 * Sets the image smoothness attribute. The options are as follows:
 * 'high': height
 * 'low': (default)low
 * 'medium': medium
 *
 * @typedef { 'high' | 'low' | 'medium' } ImageSmoothingQuality
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type ImageSmoothingQuality = 'high' | 'low' | 'medium';

/**
 * Opaque objects that describe gradients, created by createLinearGradient() or createRadialGradient()
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class CanvasGradient {
  /**
   * Add a breakpoint defined by offset and color to the gradient
   *
   * @param { number } offset - Value between 0 and 1, out of range throws INDEX_SIZE_ERR error
   * @param { string } color - Set the gradient color.
   *     a SYNTAX_ERR error is thrown.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  addColorStop(offset: number, color: string): void;
}

/**
 * Path object, which provides basic methods for drawing paths.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class CanvasPath {
  /**
   * Draw an arc path
   *
   * @param { number } x - The x-axis coordinate of the center (center of the circle) of the arc.
   * @param { number } y - The y-axis coordinate of the center (center of the circle) of the arc.
   * @param { number } radius - Radius of the arc.
   * @param { number } startAngle - Start point of an arc, which starts to be calculated in the x-axis direction.
   *     The unit is radian.
   * @param { number } endAngle - The end point of the arc, in radians.
   * @param { boolean } [counterclockwise] - If the value is true, the arc is drawn counterclockwise. Otherwise,
   *     the arc is drawn clockwise. The default value is false.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  arc(x: number, y: number, radius: number, startAngle: number, endAngle: number, counterclockwise?: boolean): void;
  /**
   * Draw arc paths based on control points and radius
   *
   * @param { number } x1 - The x-axis coordinate of the first control point.
   * @param { number } y1 - The y-axis coordinate of the first control point.
   * @param { number } x2 - The x-axis coordinate of the second control point.
   * @param { number } y2 - The y-axis coordinate of the second control point.
   * @param { number } radius - Radius of the arc.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  arcTo(x1: number, y1: number, x2: number, y2: number, radius: number): void;
  /**
   * Drawing Cubic Bessel Curve Paths
   *
   * @param { number } cp1x - The x-axis coordinate of the first control point.
   * @param { number } cp1y - The y-axis coordinate of the first control point.
   * @param { number } cp2x - The x-axis coordinate of the second control point.
   * @param { number } cp2y - The y-axis coordinate of the second control point.
   * @param { number } x - x-axis coordinate of the end point.
   * @param { number } y - y-axis coordinate of the end point.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bezierCurveTo(cp1x: number, cp1y: number, cp2x: number, cp2y: number, x: number, y: number): void;
  /**
   * Returns the pen point to the start point of the current sub-path
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  closePath(): void;
  /**
   * Draw an Elliptic Path
   *
   * @param { number } x - x-axis coordinate of the center of the ellipse.
   * @param { number } y - y-axis coordinate of the center of the ellipse.
   * @param { number } radiusX - Radius of the major axis of the ellipse.
   * @param { number } radiusY - Radius of the minor axis of the ellipse.
   * @param { number } rotation - The rotation angle of the ellipse, in radians (not angular degrees).
   * @param { number } startAngle - The angle of the starting point to be drawn, measured from the x-axis in radians
   *     (not angular degrees).
   * @param { number } endAngle - The angle, in radians, at which the ellipse is to be drawn (not angular degrees).
   * @param { boolean } [counterclockwise] - If the value is true, the ellipse is drawn counterclockwise. Otherwise,
   *     the ellipse is drawn clockwise. The default value is false.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  ellipse(x: number, y: number, radiusX: number, radiusY: number, rotation: number, startAngle: number,
    endAngle: number, counterclockwise?: boolean): void;
  /**
   * Connect sub-path using straight lines
   *
   * @param { number } x - The x-axis coordinate of the end point of the line.
   * @param { number } y - The y-axis coordinate of the end point of the line.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  lineTo(x: number, y: number): void;
  /**
   * Moves the start point of a new sub-path to the (x, y) coordinate.
   *
   * @param { number } x - The x-axis coordinate of the point.
   * @param { number } y - The y-axis coordinate of the point.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  moveTo(x: number, y: number): void;
  /**
   * Draw quadratic Bezier curve paths
   *
   * @param { number } cpx - The x-axis coordinate of the control point.
   * @param { number } cpy - The y-axis coordinate of the control point.
   * @param { number } x - x-axis coordinate of the end point.
   * @param { number } y - y-axis coordinate of the end point.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  quadraticCurveTo(cpx: number, cpy: number, x: number, y: number): void;
  /**
   * Draw Rectangular Paths
   *
   * @param { number } x - The x-axis coordinate of the start point of the rectangle.
   * @param { number } y - The y-axis coordinate of the start point of the rectangle.
   * @param { number } w - Width of the rectangle.
   * @param { number } h - Height of the rectangle.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  rect(x: number, y: number, w: number, h: number): void;
}

/**
 * 2D path object for path drawing
 *
 * @extends CanvasPath
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class Path2D extends CanvasPath {
  /**
   * Adds a path according to the specified path variable.
   *
   * @param { Path2D } path - Indicates the path object to be added.
   * @param { Matrix2D } [transform] - Transformation matrix of the new trail. The default value is null.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  addPath(path: Path2D, transform?: Matrix2D): void;
  /**
   * Create an empty path object.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor();
  /**
   * Create an empty path object.
   *
   * @param { LengthMetricsUnit } unit - the unit mode
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(unit: LengthMetricsUnit);
  /**
   * Create a copy of a path object
   *
   * @param { Path2D } path - Path object to be copied
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(path: Path2D);
  /**
   * Create a copy of a path object
   *
   * @param { Path2D } path - Path object to be copied
   * @param { LengthMetricsUnit } unit - the unit mode
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(path: Path2D, unit: LengthMetricsUnit);
  /**
   * Create a new path according to the description.
   *
   * @param { string } d - Indicates the path string that compiles with the SVG path description specifications.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(d: string);
  /**
   * Create a new path according to the description.
   *
   * @param { string } description - Indicates the path string that compiles with
   *     the SVG path description specifications.
   * @param { LengthMetricsUnit } unit - the unit mode
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(description: string, unit: LengthMetricsUnit);
}

/**
 * Describes an opaque object of a template, which is created using the createPattern() method.
 *
 * @interface CanvasPattern
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CanvasPattern {
  /**
   * Adds the matrix transformation effect to the current template.
   *
   * @param { Matrix2D } [transform] - transformation matrix. The default value is null.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  setTransform(transform?: Matrix2D): void;
}

/**
 * Size information of the text
 *
 * @interface TextMetrics
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextMetrics {
  /**
   * Double, the distance from the horizontal line indicated by the textBaseline property to the top of
   *    the rectangular boundary of the rendered text.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly actualBoundingBoxAscent: number;
  /**
   * Double, the distance from the horizontal line indicated by the textBaseline property to the bottom of
   *    the rectangular boundary of the rendered text.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly actualBoundingBoxDescent: number;
  /**
   * Double, parallel to the baseline, distance from the alignment point determined by the textAlign property to
   *    the left of the text rectangle boundary.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly actualBoundingBoxLeft: number;
  /**
   * Double, parallel to the baseline, distance from the alignment point determined by the textAlign property to
   *    the right of the text rectangle boundary.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly actualBoundingBoxRight: number;
  /**
   * Double, the distance from the horizontal line indicated by the textBaseline property to the alphabetic baseline of
   *    the wireframe.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly alphabeticBaseline: number;
  /**
   * Double, the distance from the horizontal line indicated by the textBaseline property to the top of the
   *    em square in the wireframe.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly emHeightAscent: number;
  /**
   * Double, distance from the horizontal line indicated by the textBaseline property to the bottom of the
   *    em box in the wireframe.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly emHeightDescent: number;
  /**
   * Double, distance from the horizontal line indicated by the textBaseline property to the top of the
   *    highest rectangle boundary of all fonts rendering text.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly fontBoundingBoxAscent: number;
  /**
   * Double, distance from the horizontal line indicated by the textBaseline property to the bottom of the
   *   rectangular boundary of all fonts rendering text.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly fontBoundingBoxDescent: number;
  /**
   * Double, distance from the horizontal line indicated by the textBaseline property to
   *    the hanging baseline of the wireframe.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly hangingBaseline: number;
  /**
   * Double, distance from the horizontal line indicated by the textBaseline property to
   *    the ideographic baseline of the wireframe.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly ideographicBaseline: number;
  /**
   * Indicates the width of a character string. The value is of the double type.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly width: number;
  /**
   * Indicates the height of a character string. The value is of the double type.
   *
   * @type { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  readonly height: number;
}

/**
 * Bitmap image object that can be drawn onto the current Canvas
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class ImageBitmap {
  /**
   * Indicates the height of the CSS pixel unit of ImageData.
   *
   * @return { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get height(): number;
  /**
   * Indicates the width of the CSS pixel unit of ImageData.
   *
   * @return { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get width(): number;
  /**
   * Releases all graphics resources associated with an ImageBitmap.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  close(): void;
  /**
   * Create an ImageBitmap object based on the transferred image path or PixelMap object.
   *
   * @param { PixelMap | string } src - image path or PixelMap object
   * @param { LengthMetricsUnit } [unit] - the unit mode
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(src: PixelMap | string, unit?: LengthMetricsUnit);
}

/**
 * Image data object
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class ImageData {
  /**
   * Array containing image pixel data
   *
   * @return { Uint8ClampedArray }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get data(): Uint8ClampedArray;
  /**
   * Height of the image.
   *
   * @return { int }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get height(): int;
  /**
   * Width of the image.
   *
   * @return { int }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get width(): int;
  /**
   * Create an ImageData object based on the input parameters.
   *
   * @param { number } width - Width of the image.
   * @param { number } height - Height of the image.
   * @param { Uint8ClampedArray } [data] - Data of the image. 
   *     If this parameter is not specified, the default value is a black rectangular image.
   * @param { LengthMetricsUnit } [unit] - the unit mode
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(width: number, height: number, data?: Uint8ClampedArray, unit?: LengthMetricsUnit);
}

/**
 * This object allows you to set properties when creating a rendering context
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class RenderingContextSettings {
  /**
   * Get the status whether anti-aliasing is enabled for canvas. The default value is false.
   *
   * @return { boolean | undefined }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get antialias(): boolean | undefined;
  /**
   * Set the status whether anti-aliasing is enabled for canvas. The default value is false.
   *
   * @param { boolean | undefined }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set antialias(antialias: boolean | undefined);
  /**
   * Create an RenderingContextSettings object based on the antialias and alpha.
   *
   * @param { boolean } [antialias] - Indicates whether anti-aliasing is enabled for canvas
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(antialias?: boolean);
}

/**
 * Canvas renderer for drawing shapes, text, images and other objects
 *
 * @extends CanvasPath
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class CanvasRenderer extends CanvasPath {
  /**
   * Get spacing for letter.
   *
   * @return { LengthMetrics | string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get letterSpacing(): LengthMetrics | string;
  /**
   * Set spacing for letter.
   *
   * @param { LengthMetrics | string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set letterSpacing(letterSpacing: LengthMetrics | string);
  /**
   * Get transparency. The value ranges from 0.0 (completely transparent) to 1.0 (completely opaque).
   *    If the value is out of range, the assignment is invalid.
   *
   * @return { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get globalAlpha(): number;
  /**
 * Set transparency. The value ranges from 0.0 (completely transparent) to 1.0 (completely opaque).
 *    If the value is out of range, the assignment is invalid.
 *
 * @param { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
  set globalAlpha(globalAlpha: number);
  /**
   * Get the type of composition operation applied when drawing a new shape. The following types are supported:
   * source-over: (Default) Draws a new drawing on top of an existing canvas context.
   * source-in: The new drawing is drawn only where the new drawing overlaps the target canvas.
   *    Everything else is transparent.
   * source-out: Draws a new drawing where it does not overlap with the existing canvas content.
   * source-atop: The new drawing is drawn only where it overlaps the content of the existing canvas.
   * destination-over: Draws a new graphic behind the existing canvas content.
   * destination-in: Existing canvas content remains where the new drawing overlaps the existing canvas content.
   *    Everything else is transparent.
   * destination-out: Existing content remains where the new drawing does not overlap.
   * destination-atop: The existing canvas retains only the part that overlaps with the new drawing,
   *    which is drawn behind the canvas content.
   * lighter: The color of two overlapping shapes is determined by adding the color values.
   * copy: Only new graphics are displayed.
   * xor: In the image, those overlaps and other places outside of the normal drawing are transparent.
   *
   * @return { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get globalCompositeOperation(): string;
  /**
   * Set the type of composition operation applied when drawing a new shape. The following types are supported:
   * source-over: (Default) Draws a new drawing on top of an existing canvas context.
   * source-in: The new drawing is drawn only where the new drawing overlaps the target canvas.
   *    Everything else is transparent.
   * source-out: Draws a new drawing where it does not overlap with the existing canvas content.
   * source-atop: The new drawing is drawn only where it overlaps the content of the existing canvas.
   * destination-over: Draws a new graphic behind the existing canvas content.
   * destination-in: Existing canvas content remains where the new drawing overlaps the existing canvas content.
   *    Everything else is transparent.
   * destination-out: Existing content remains where the new drawing does not overlap.
   * destination-atop: The existing canvas retains only the part that overlaps with the new drawing,
   *    which is drawn behind the canvas content.
   * lighter: The color of two overlapping shapes is determined by adding the color values.
   * copy: Only new graphics are displayed.
   * xor: In the image, those overlaps and other places outside of the normal drawing are transparent.
   *
   * @param { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set globalCompositeOperation(globalCompositeOperation: string);
  /**
   * Draw an image on a canvas
   *
   * @param { ImageBitmap | PixelMap } image - Picture objects drawn to the canvas.
   * @param { number } dx - x-axis coordinate of the upper left corner of the image on the target canvas.
   * @param { number } dy - y-axis coordinate of the upper left corner of the image on the target canvas.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  drawImage(image: ImageBitmap | PixelMap, dx: number, dy: number): void;
  /**
   * Draw an image on a canvas
   *
   * @param { ImageBitmap | PixelMap } image - Picture objects drawn to the canvas.
   * @param { number } dx - x-axis coordinate of the upper left corner of the image on the target canvas.
   * @param { number } dy - y-axis coordinate of the upper left corner of the image on the target canvas.
   * @param { number } dw - Specifies the drawing width of the image on the target canvas.
   *     The width of the drawn image will be scaled.
   * @param { number } dh - Specifies the drawing height of the image on the target canvas.
   *     The height of the drawn image will be scaled.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  drawImage(image: ImageBitmap | PixelMap, dx: number, dy: number, dw: number, dh: number): void;
  /**
   *Draw an image on a canvas
   *
   * @param { ImageBitmap | PixelMap } image - Picture objects drawn to the canvas.
   * @param { number } sx - x coordinate of the upper left corner of
   *     the rectangle (cropping) selection box of the image.
   * @param { number } sy - y coordinate of the upper left corner of
   *     the rectangle (cropping) selection box of the image.
   * @param { number } sw - Width of the rectangle (cropping) selection box of the image.
   * @param { number } sh - Height of the rectangle (cropping) selection box of the image.
   * @param { number } dx - x-axis coordinate of the upper left corner of the image on the target canvas.
   * @param { number } dy - y-axis coordinate of the upper left corner of the image on the target canvas.
   * @param { number } dw - Specifies the drawing width of the image on the target canvas.
   *     The width of the drawn image will be scaled.
   * @param { number } dh - Specifies the drawing height of the image on the target canvas.
   *     The height of the drawn image will be scaled.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  drawImage(image: ImageBitmap | PixelMap, sx: number, sy: number, sw: number, sh: number, dx: number, dy: number,
    dw: number, dh: number): void;
  /**
   * Clear the sub-path list and start a new path.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  beginPath(): void;
  /**
   * Sets the currently created path as the current clipping path
   *
   * @param { CanvasFillRule } [fillRule] - Algorithm rule. For details, see {@link CanvasFillRule}.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  clip(fillRule?: CanvasFillRule): void;
  /**
   * Tailoring according to the specified path
   *
   * @param { Path2D } path - Path to be cut.
   * @param { CanvasFillRule } [fillRule] - Algorithm rule. For details, see {@link CanvasFillRule}.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  clip(path: Path2D, fillRule?: CanvasFillRule): void;
  /**
   * Fills existing paths according to the current fill style.
   *
   * @param { CanvasFillRule } [fillRule] - Algorithm rule. For details, see {@link CanvasFillRule}.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  fill(fillRule?: CanvasFillRule): void;
  /**
   * Fills the specified path according to the current fill style
   *
   * @param { Path2D } path - Path to be filled.
   * @param { CanvasFillRule } [fillRule] - Algorithm rule. For details, see {@link CanvasFillRule}.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  fill(path: Path2D, fillRule?: CanvasFillRule): void;
  /**
   * Draws the specified path according to the current stroke style
   *
   * @param { Path2D } [path] - Specified stroke path object
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  stroke(path?: Path2D): void;
  /**
   * Get the attributes specifie the color, gradient, or pattern to use inside shapes. The options are as follows:
   *
   * @return { string | int | CanvasGradient | CanvasPattern }
   * string: Color String.
   * int: Indicates the color with number.
   * CanvasGradient: Color gradient object. For details, see {@link CanvasGradient}.
   * CanvasPattern: Template object. For details, see {@link CanvasPattern}.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get fillStyle(): string | int | CanvasGradient | CanvasPattern;
  /**
   * Set the attributes specifie the color, gradient, or pattern to use inside shapes. The options are as follows:
   *
   * @param { string | int | CanvasGradient | CanvasPattern }
   * string: Color String.
   * int: Indicates the color with number.
   * CanvasGradient: Color gradient object. For details, see {@link CanvasGradient}.
   * CanvasPattern: Template object. For details, see {@link CanvasPattern}.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set fillStyle(fillStyle: string | int | CanvasGradient | CanvasPattern);
  /**
   * Get the attributes specifie the color, gradient, or pattern to use for the strokes (outlines) around shapes.
   * The options are as follows:
   *
   * @return { string | int | CanvasGradient | CanvasPattern }
   * string: Color String.
   * int: Indicates the color with number.
   * CanvasGradient: Color gradient object. For details, see {@link CanvasGradient}.
   * CanvasPattern: Template object. For details, see {@link CanvasPattern}.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get strokeStyle(): string | int | CanvasGradient | CanvasPattern;
  /**
   * Set the attributes specifie the color, gradient, or pattern to use for the strokes (outlines) around shapes.
   * The options are as follows:
   *
   * @param { string | int | CanvasGradient | CanvasPattern }
   * string: Color String.
   * int: Indicates the color with number.
   * CanvasGradient: Color gradient object. For details, see {@link CanvasGradient}.
   * CanvasPattern: Template object. For details, see {@link CanvasPattern}.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set strokeStyle(strokeStyle: string | int | CanvasGradient | CanvasPattern);
  /**
   * Creates a linear gradient object that is specified along the parameter coordinates
   *
   * @param { number } x0 - The x-axis coordinate of the start point.
   * @param { number } y0 - The y-axis coordinate of the start point.
   * @param { number } x1 - x-axis coordinate of the end point.
   * @param { number } y1 - y-axis coordinate of the end point.
   * @returns { CanvasGradient }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  createLinearGradient(x0: number, y0: number, x1: number, y1: number): CanvasGradient;
  /**
   * Creates a template object using the specified image
   *
   * @param { ImageBitmap } image - Objects as duplicate image sources
   * @param { string | null } repetition - Specifies how to repeat images. The following four modes are supported:
   *     "repeat": Repeated images in both X and Y directions
   *     "repeat-x": Repeated images in the X-axis direction but not in the Y-axis direction
   *     "repeat-y": Repeated images in the Y axis direction, but not in the X axis direction.
   *     "no-repeat": Non-repeating images in both X and Y directions
   *     "clamp": Replicate the edge color if the shader draws outside of its original bounds.
   *     "mirror": Repeat the shader's image horizontally and vertically,
   *         alternating mirror images so that adjacent images always seam.
   * @returns { CanvasPattern | null }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  createPattern(image: ImageBitmap, repetition: string | null): CanvasPattern | null;
  /**
   * Creates a radioactive gradient object based on parameters that determine the coordinates of two circles
   *
   * @param { number } x0 - The x-axis coordinate of the start circle.
   * @param { number } y0 - The y-axis coordinate of the start circle.
   * @param { number } r0 - Radius of the starting circle.
   * @param { number } x1 - The x-axis coordinate of the end circle.
   * @param { number } y1 - The y-axis coordinate of the end circle.
   * @param { number } r1 - Radius of the end circle.
   * @returns { CanvasGradient }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  createRadialGradient(x0: number, y0: number, r0: number, x1: number, y1: number, r1: number): CanvasGradient;
  /**
   * Creates a gradient around a point with given coordinates.
   *
   * @param { number } startAngle - The angle at which to begin the gradient, in radians.
   *     Angle measurements start horizontally the right of the center and move around clockwise.
   * @param { number } x - The x-axis coordinate of the center of the gradient.
   * @param { number } y - The y-axis coordinate of the center of the gradient.
   * @returns { CanvasGradient } A CanvasGradient object that draws a conic gradient around the given coordinates.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  createConicGradient(startAngle: number, x: number, y: number): CanvasGradient;
  /**
   * Provides filter effects such as blur and grayscale. You can get the following filter effects:
   * blur(<length>): Adds a Gaussian blur effect to the drawing
   * brightness(<percentage>): Provides a linear multiplication for the drawing and adjusts the brightness level.
   * contrast(<percentage>): Adjusts the contrast of the image. 
   *     When the value is 0%, the image is completely black.
   *     When the value is 100%, there is no change in the image.
   * grayscale(<percentage>): Converts the image to a gray image. 
   *     When the value is 100%, the image is completely gray.
   *     When the value is 0%, there is no change in the image.
   * hue-rotate(<degree>): Perform color rotation on an image. 
   *     When the value is 0 degrees, there is no change in the image.
   * invert(<percentage>): Inverted image (representing the effect of a photographic negative). 
   *     When the value is 100%,the image is completely inverted.
   *     When the value is 0%, there is no change in the image.
   * opacity(<percentage>): Transparency of the image. 
   *     When the value is 0%, the image is completely transparent.
   *     When the value is 100%, there is no change in the image.
   * saturate(<percentage>): Perform saturation processing on the image. 
   *     When the value is 0%, the image is completely un-saturated.
   *     When the value is 100%, there is no change in the image.
   * sepia(<percentage>): The image is sepia (nostalgic style). 
   *     When the value is 100%, the image turns completely sepia.
   *     When the value is 0%, there is no change in the image.
   * none: Turn off filter effects.
   *
   * @return { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get filter(): string;
  /**
   * Provides filter effects such as blur and grayscale. You can set the following filter effects:
   * blur(<length>): Adds a Gaussian blur effect to the drawing
   * brightness(<percentage>): Provides a linear multiplication for the drawing and adjusts the brightness level.
   * contrast(<percentage>): Adjusts the contrast of the image. When the value is 0%, the image is completely black.
   *     When the value is 100%, there is no change in the image.
   * grayscale(<percentage>): Converts the image to a gray image.
   *     When the value is 100%, the image is completely gray.
   *     When the value is 0%, there is no change in the image.
   * hue-rotate(<degree>): Perform color rotation on an image.
   *     When the value is 0 degrees, there is no change in the image.
   * invert(<percentage>): Inverted image (representing the effect of a photographic negative).
   *     When the value is 100%, the image is completely inverted.
   *     When the value is 0%, there is no change in the image.
   * opacity(<percentage>): Transparency of the image. At 0%, the image is completely transparent.
   *     When the value is 100%, there is no change in the image.
   * saturate(<percentage>): Perform saturation processing on the image. At 0%, the image is completely un-saturated.
   *     When the value is 100%, there is no change in the image.
   * sepia(<percentage>): The image is sepia (nostalgic style). At 100%, the image turns completely sepia.
   *     When the value is 0%, there is no change in the image.
   * none: Turn off filter effects
   *
   * @param { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set filter(filter: string);
  /**
   * Creates a new, empty ImageData object of the specified size
   *
   * @param { number } sw - Width of the ImageData object.
   * @param { number } sh - Height of the ImageData object.
   * @returns { ImageData }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  createImageData(sw: number, sh: number): ImageData;
  /**
   * From an existing ImageData object, copy an object with the same width and height as the image.
   *    The image content is not copied.
   *
   * @param { ImageData } imagedata - ImageData object to be copied.
   * @returns { ImageData }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  createImageData(imagedata: ImageData): ImageData;
  /**
   * Obtains the pixel data of a specified area on the current canvas.
   *
   * @param { number } sx - x coordinate of the upper left corner of the rectangular area
   *     of the image data to be extracted.
   * @param { number } sy - y coordinate of the upper left corner of the rectangular area
   *     of the image data to be extracted.
   * @param { number } sw - The width of the rectangular area of the image data to be extracted.
   * @param { number } sh - The height of the rectangular area of the image data to be extracted.
   * @returns { ImageData }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getImageData(sx: number, sy: number, sw: number, sh: number): ImageData;
  /**
   * Obtains the PixelMap of a specified area on the current canvas.
   *
   * @param { number } sx - x coordinate of the upper left corner of the rectangular area of the PixelMap
   *     to be extracted.
   * @param { number } sy - y coordinate of the upper left corner of the rectangular area of the PixelMap
   *     to be extracted.
   * @param { number } sw - The width of the rectangular area of the PixelMap to be extracted.
   * @param { number } sh - The height of the rectangular area of the PixelMap to be extracted.
   * @returns { PixelMap }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getPixelMap(sx: number, sy: number, sw: number, sh: number): PixelMap;
  /**
   * Draws the specified ImageData object onto the canvas
   *
   * @param { ImageData } imagedata - ImageData object to be drawn.
   * @param { number | string } dx - Position offset of the source image data
   *     in the target canvas (the offset in the x-axis direction).
   * @param { number | string } dy - Position offset of the source image data
   *     in the target canvas (the offset in the y-axis direction).
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  putImageData(imagedata: ImageData, dx: number | string, dy: number | string): void;
  /**
   * Draws the specified ImageData object onto the canvas
   *
   * @param { ImageData } imagedata - ImageData object to be drawn.
   * @param { number | string } dx - Position offset of the source image data
   *     in the target canvas (the offset in the x-axis direction).
   * @param { number | string } dy - Position offset of the source image data
   *     in the target canvas (the offset in the y-axis direction).
   * @param { number | string } dirtyX - Position of the upper left corner of the rectangular area
   *     in the source image data.
   *     The default is the upper left corner (x coordinate) of the entire image data.
   * @param { number | string } dirtyY - Position of the upper left corner of the rectangular area
   *     in the source image data.
   *     The default is the upper left corner (y coordinate) of the entire image data.
   * @param { number | string } dirtyWidth - Width of the rectangular area in the source image data.
   *     The default is the width of the image data.
   * @param { number | string } dirtyHeight - Height of the rectangular area in the source image data.
   *     The default is the height of the image data.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  putImageData(imagedata: ImageData, dx: number | string, dy: number | string, dirtyX: number | string,
    dirtyY: number | string, dirtyWidth: number | string, dirtyHeight: number | string): void;
  /**
   * Get the status whether to smooth the image. The value true indicates that the image is smooth.
   *    The value false indicates that the image is not smooth.
   *
   * @return { boolean }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get imageSmoothingEnabled(): boolean;
  /**
   * Set the status whether to smooth the image. The value true indicates that the image is smooth.
   *    The value false indicates that the image is not smooth.
   *
   * @param { boolean }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set imageSmoothingEnabled(imageSmoothingEnabled: boolean);
  /**
   * Get the smoothness level of the current image. For details, see {@link ImageSmoothingQuality}.
   *
   * @return { ImageSmoothingQuality }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get imageSmoothingQuality(): ImageSmoothingQuality;
  /**
   * Set the smoothness level of the current image. For details, see {@link ImageSmoothingQuality}.
   *
   * @param { ImageSmoothingQuality }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set imageSmoothingQuality(imageSmoothingQuality: ImageSmoothingQuality);
  /**
   * Get the line segment endpoint attribute. For details, see {@link CanvasLineCap}.
   *
   * @return { CanvasLineCap }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get lineCap(): CanvasLineCap;
  /**
   * Set the line segment endpoint attribute. For details, see {@link CanvasLineCap}.
   *
   * @param { CanvasLineCap }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set lineCap(lineCap: CanvasLineCap);
  /**
   * Get the dotted line offset attribute.
   *
   * @return { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get lineDashOffset(): number;
  /**
   * Set the dotted line offset attribute.
   *
   * @param { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set lineDashOffset(lineDashOffset: number);
  /**
   * Get the line segment connection point attribute. For details, see {@link CanvasLineJoin}.
   *
   * @return { CanvasLineJoin }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get lineJoin(): CanvasLineJoin;
  /**
   * Set the line segment connection point attribute. For details, see {@link CanvasLineJoin}.
   *
   * @param { CanvasLineJoin }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set lineJoin(lineJoin: CanvasLineJoin);
  /**
   * Get the line thickness attribute. The value cannot be 0 or a negative number.
   *
   * @return { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get lineWidth(): number;
  /**
   * Set the line thickness attribute. The value cannot be 0 or a negative number.
   *
   * @param { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set lineWidth(lineWidth: number);
  /**
   * Get the value of this parameter cannot be 0 or a negative number.
   *
   * @return { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get miterLimit(): number;
  /**
   * Set the value of this parameter cannot be 0 or a negative number.
   *
   * @param { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set miterLimit(miterLimit: number);
  /**
   * Gets the current segment style.
   *
   * @returns { number[] }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getLineDash(): number[];
  /**
   * Sets the dashed line mode for line drawing.
   *
   * @param { number[] } segments - A set of numbers that describe the length of alternating drawn lines segments and
   *     spacing (coordinate space units).
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  setLineDash(segments: number[]): void;
  /**
   * Clears the drawing content of a rectangular area.
   *
   * @param { number } x - The x-axis coordinate of the start point of the rectangle.
   * @param { number } y - The y-axis coordinate of the start point of the rectangle.
   * @param { number } w - Width of the rectangle.
   * @param { number } h - Height of the rectangle.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  clearRect(x: number, y: number, w: number, h: number): void;
  /**
   * Fills a specified rectangular area
   *
   * @param { number } x - The x-axis coordinate of the start point of the rectangle.
   * @param { number } y - The y-axis coordinate of the start point of the rectangle.
   * @param { number } w - Width of the rectangle.
   * @param { number } h - Height of the rectangle.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  fillRect(x: number, y: number, w: number, h: number): void;
  /**
   * Stroke Specify Rectangular Area
   *
   * @param { number } x - The x-axis coordinate of the start point of the rectangle.
   * @param { number } y - The y-axis coordinate of the start point of the rectangle.
   * @param { number } w - Width of the rectangle.
   * @param { number } h - Height of the rectangle.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  strokeRect(x: number, y: number, w: number, h: number): void;
  /**
   * Get the shadow blur radius. The value cannot be a negative number.
   *
   * @return { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get shadowBlur(): number;
  /**
   * Set the shadow blur radius. The value cannot be a negative number.
   *
   * @param { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set shadowBlur(shadowBlur: number);
  /**
   * Get the shadow color.
   *
   * @return { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get shadowColor(): string;
  /**
   * Set the shadow color.
   *
   * @param { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set shadowColor(shadowColor: string);
  /**
   * Get the horizontal offset distance of the shadow.
   *
   * @return { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get shadowOffsetX(): number;
  /**
   * Set the horizontal offset distance of the shadow.
   *
   * @param { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set shadowOffsetX(shadowOffsetX: number);
  /**
   * Get the vertical offset distance of the shadow.
   *
   * @return { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get shadowOffsetY(): number;
  /**
   * Set the vertical offset distance of the shadow.
   *
   * @param { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set shadowOffsetY(shadowOffsetY: number);
  /**
   * Top of the stack pop-up state in the drawing state stack
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  restore(): void;
  /**
   * Saves the current drawing state to the drawing state stack
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  save(): void;
  /**
   * Fills the specified text at the specified location
   *
   * @param { string } text - Text string to be drawn.
   * @param { number } x - The x-axis coordinate of the start point of the text.
   * @param { number } y - The y-axis coordinate of the start point of the text.
   * @param { number } [maxWidth] - Maximum width of the drawing.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  fillText(text: string, x: number, y: number, maxWidth?: number): void;
  /**
   * Measure the size of a specified text. For details about the return value, see {@link TextMetrics}.
   *
   * @param { string } text - Text string to be measured.
   * @returns { TextMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  measureText(text: string): TextMetrics;
  /**
   * Stroke specified text at specified position
   *
   * @param { string } text - Text string to be stroked.
   * @param { number } x - The x-axis coordinate of the start point of the text.
   * @param { number } y - The y-axis-axis coordinate of the start point of the text.
   * @param { number } [maxWidth] - Maximum width of the stroke.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  strokeText(text: string, x: number, y: number, maxWidth?: number): void;
  /**
   * Get the text drawing direction. For details, see {@link CanvasDirection}.
   *
   * @return { CanvasDirection }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get direction(): CanvasDirection;
  /**
   * Set the text drawing direction. For details, see {@link CanvasDirection}.
   *
   * @param { CanvasDirection }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set direction(direction: CanvasDirection);
  /**
   * Get the font style.
   *
   * @return { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get font(): string;
  /**
   * Set the font style.
   *
   * @param { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set font(font: string);
  /**
   * Get the text alignment mode. For details, see {@link CanvasTextAlign}.
   *
   * @return { CanvasTextAlign }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get textAlign(): CanvasTextAlign;
  /**
   * Set the text alignment mode. For details, see {@link CanvasTextAlign}.
   *
   * @param { CanvasTextAlign }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set textAlign(textAlign: CanvasTextAlign);
  /**
   * Get the text baseline. For details, see {@link CanvasTextBaseline}.
   *
   * @return { CanvasTextBaseline }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get textBaseline(): CanvasTextBaseline;
  /**
   * Set the text baseline. For details, see {@link CanvasTextBaseline}.
   *
   * @param { CanvasTextBaseline }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set textBaseline(textBaseline: CanvasTextBaseline);
  /**
   * Obtains the currently applied transformation matrix.
   *
   * @returns { Matrix2D }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getTransform(): Matrix2D;
  /**
   * Resets the current transformation matrix using the identity matrix
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  resetTransform(): void;
  /**
   * Adds the effect of a rotation
   *
   * @param { number } angle - The radian of clockwise rotation, 
   *     which can be converted to an angle value using the formula: degree * Math.PI / 180.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  rotate(angle: number): void;
  /**
   * Increases the scaling effect of the X and Y axes.
   *
   * @param { number } x - Horizontal scaling factor
   * @param { number } y - Vertical scaling factor
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  scale(x: number, y: number): void;
  /**
   * Adds 2D transformation effects, including rotation, translation, and scaling.
   *    The current transformation matrix will not be overwritten. Multiple transformations will be superimposed.
   *
   * @param { number } a - Horizontal Zoom
   * @param { number } b - Vertical Tilt
   * @param { number } c - Horizontal Tilt
   * @param { number } d - Vertical Zoom
   * @param { number } e - Horizontal movement
   * @param { number } f - Vertical movement
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  setTransform(a: number, b: number, c: number, d: number, e: number, f: number): void;
  /**
   * The 2D transformation effect is added. The current transformation matrix is not overwritten and
   *    the transformations are superimposed for multiple times.
   *
   * @param { Matrix2D } [transform] - 2D transformation matrix. For details, see {@link Matrix2D}.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  setTransform(transform?: Matrix2D): void;
  /**
   * Adds the 2D transformation effect, including rotation, translation, and scaling,
   *    and overwrites the current transformation matrix.
   *
   * @param { number } a - Horizontal Zoom
   * @param { number } b - Vertical Tilt
   * @param { number } c - Horizontal Tilt
   * @param { number } d - Vertical Zoom
   * @param { number } e - Horizontal movement
   * @param { number } f - Vertical movement
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  transform(a: number, b: number, c: number, d: number, e: number, f: number): void;
  /**
   * Increases the translation effect of the X and Y axes
   *
   * @param { number } x - Horizontal movement distance
   * @param { number } y - Vertical travel distance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  translate(x: number, y: number): void;
  /**
   * Set a PixelMap to the current context. The drawing content is synchronized to the PixelMap.
   *
   * @param { PixelMap } [value] - PixelMap object
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  setPixelMap(value?: PixelMap): void;
  /**
   * transfer ImageBitmap to content.
   *
   * @param { ImageBitmap } bitmap
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  transferFromImageBitmap(bitmap: ImageBitmap): void;
  /**
   * Allocate a layer for subsequent drawing.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  saveLayer(): void;
  /**
   * Remove changes to transform and clip since saveLayer was last called and draw the layer on canvas.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  restoreLayer(): void;
  /**
   * Clear the backing buffer, drawing state stack, any defined paths, and styles.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  reset(): void;
}

/**
 * Draw context object for the Canvas component.
 *
 * @extends CanvasRenderer
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class CanvasRenderingContext2D extends CanvasRenderer {
  /**
   * The default value is 0, which is bound to the height of the specified canvas. The value is read-only.
   *
   * @return { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get height(): number;
  /**
   * The default value is 0, which is bound to the width of the specified canvas. The value is read-only.
   *
   * @return { number }
   * @readonly
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get width(): number;
  /**
   * Frame node of the canvas. The default value is null.
   *
   * @return { FrameNode }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get canvas(): FrameNode;
  /**
   * Generate a character string in the data url format.
   *
   * @param { string } [type] - Image format. The default value is image/png.
   * @param { number } [quality] - If the image format is image/jpeg or image/webp,
   *     you can select the image quality from 0 to 1.
   *     If the value is out of the range, the default value 0.92 is used.
   * @returns { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  toDataURL(type?: string, quality?: number): string;
  /**
   * Start image analyzer.
   *
   * @param { ImageAnalyzerConfig } config - Image analyzer config.
   * @returns { Promise<void> } The promise returned by the function.
   * @throws { BusinessError } 110001 - Image analysis feature is not supported.
   * @throws { BusinessError } 110002 - Image analysis is currently being executed.
   * @throws { BusinessError } 110003 - Image analysis is stopped.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  startImageAnalyzer(config: ImageAnalyzerConfig): Promise<void>;
  /**
   * Stop image analyzer.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  stopImageAnalyzer(): void;
  /**
   * Constructor of the canvas drawing context object, which is used to create a drawing context object.
   *
   * @param { RenderingContextSettings } [settings] - Drawing attribute.
   *     For details, see {@link RenderingContextSettings}.
   * @param { LengthMetricsUnit } [unit] - the unit mode
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(settings?: RenderingContextSettings, unit?: LengthMetricsUnit);
  /**
   * Register the listener that watches if the canvasrenderingcontext2d attached to the Canvas frameNode.
   *
   * @param { 'onAttach' } type Indicates the type of event.
   * @param { Callback<void> } callback Indicates the listener.
   * @throws { BusinessError } 401 - Input parameter error. Possible causes:
   *     1. Mandatory parameters are left unspecified;
   *     2. Incorrect parameter types;
   *     3. Parameter verification failed.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  on(type: 'onAttach', callback: Callback<void>): void;
  /**
   * Unregister the listener that watches if the canvasrenderingcontext2d attached to the Canvas frameNode.
   *
   * @param { 'onAttach' } type Indicates the type of event.
   * @param { Callback<void> } [callback] Indicates the listener.
   * @throws { BusinessError } 401 - Input parameter error. Possible causes:
   *     1. Mandatory parameters are left unspecified;
   *     2. Incorrect parameter types;
   *     3. Parameter verification failed.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  off(type: 'onAttach', callback?: Callback<void>): void;
  /**
   * Register the listener that watches if the canvasrenderingcontext2d detached from the Canvas frameNode.
   *
   * @param { 'onDetach' } type Indicates the type of event.
   * @param { Callback<void> } callback Indicates the listener.
   * @throws { BusinessError } 401 - Input parameter error. Possible causes:
   *     1. Mandatory parameters are left unspecified;
   *     2. Incorrect parameter types;
   *     3. Parameter verification failed.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  on(type: 'onDetach', callback: Callback<void>): void;
  /**
   * Unregister the listener that watches if the canvasrenderingcontext2d detached from the Canvas frameNode.
   *
   * @param { 'onDetach' } type Indicates the type of event.
   * @param { Callback<void> } [callback] Indicates the listener.
   * @throws { BusinessError } 401 - Input parameter error. Possible causes:
   *     1. Mandatory parameters are left unspecified;
   *     2. Incorrect parameter types;
   *     3. Parameter verification failed.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  off(type: 'onDetach', callback?: Callback<void>): void;
}

/**
 * Draw context object for the OffscreenCanvas component.
 *
 * @extends CanvasRenderer
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class OffscreenCanvasRenderingContext2D extends CanvasRenderer {
  /**
   * Generate a character string in the data url format.
   *
   * @param { string } [type] - Image format. The default value is image/png.
   * @param { number } [quality] - If the image format is image/jpeg or image/webp,
   *     you can select the image quality from 0 to 1.
   *     If the value is out of the range, the default value 0.92 is used.
   * @returns { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  toDataURL(type?: string, quality?: number): string;
  /**
   * transfer the content to ImageBitmap
   *
   * @returns { ImageBitmap }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  transferToImageBitmap(): ImageBitmap;
  /**
   * Constructor of the canvas drawing context object, which is used to create a drawing context object.
   *
   * @param { number } width - the width of the OffscreenCanvas
   * @param { number } height - the height of the OffscreenCanvas
   * @param { RenderingContextSettings } [settings] - Drawing attribute.
   *     For details, see {@link RenderingContextSettings}.
   * @param { LengthMetricsUnit } [unit] - the unit mode
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(width: number, height: number, settings?: RenderingContextSettings, unit?: LengthMetricsUnit);
}
/**
 * Draw an object off the screen. The drawing content is not directly displayed on the screen.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class OffscreenCanvas {
  /**
   * Get the height of the off-screen canvas.
   *
   * @return { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get height(): number;
  /**
   * Set the height of the off-screen canvas.
   *
   * @param { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set height(height: number);
  /**
   * Get the width of the off-screen canvas.
   *
   * @return { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get width(): number;
  /**
   * Set the width of the off-screen canvas.
   *
   * @param { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  set width(width: number);
  /**
   * Exports rendered content as an ImageBitmap object
   *
   * @returns { ImageBitmap }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  transferToImageBitmap(): ImageBitmap;
  /**
   * Creates the context from the current OffscreenCanvas.
   *
   * @param { '2d' } contextType - The context type, only '2d' be supported now.
   *     '2d': Creates a {@link OffscreenCanvasRenderingContext2D} object representing
   *     a two-dimensional rendering context.
   * @param { RenderingContextSettings } [options] - Drawing attribute.
   *     For details, see {@link RenderingContextSettings}.
   * @returns { OffscreenCanvasRenderingContext2D } The rendering context of offscreen canvas,
   *     see {@link OffscreenCanvasRenderingContext2D}.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getContext(contextType: '2d', options?: RenderingContextSettings): OffscreenCanvasRenderingContext2D;
  /**
   * Constructor of the off-screen canvas, which is used to create an off-screen canvas object.
   *
   * @param { number } width - Width of the off-screen canvas.
   * @param { number } height - Height of the off-screen canvas.
   * @param { LengthMetricsUnit } [unit] - the unit mode
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(width: number, height: number, unit?: LengthMetricsUnit);
}

/**
 * Defines DrawingRenderingContext.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class DrawingRenderingContext {
  /**
   * Get size of the DrawingRenderingContext.
   *
   * @returns { Size } The size of the DrawingRenderingContext.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  get size(): Size;
  /**
   * Invalidate the component, which will cause a re-render of the component.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  invalidate(): void;
  /**
   * Create DrawingRenderingContext with setting LengthMetricsUnit.
   *
   * @param { LengthMetricsUnit } [unit] - the unit mode
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(unit?: LengthMetricsUnit);
}

/**
 * Provides attribute for Canvas.
 *
 * @extends CommonMethod
 * @interface CanvasAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CanvasAttribute extends CommonMethod {
  /**
   * Event notification after the canvas component is constructed. You can draw the canvas at this time.
   *
   * @param { VoidCallback | undefined } event
   * @returns { CanvasAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onReady(event: VoidCallback | undefined): this;
  /**
   * Enable image analyzer for Canvas.
   *
   * @param { boolean | undefined } enable - If enable image analyzer for Canvas. The default value is false.
   * @returns { CanvasAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  enableAnalyzer(enable: boolean | undefined): this;
  /**
   * Call attributeModifier.
   *
   * @param { AttributeModifier<CanvasAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
   * @returns { CanvasAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  attributeModifier(modifier: AttributeModifier<CanvasAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Canvas is returned when the parameter is transferred.
 *
 * @param { CanvasRenderingContext2D | DrawingRenderingContext } [context] - Canvas context object.
 * @param { ImageAIOptions } [imageAIOptions] - Options for AI analyzer.
 * @param { function } [content_]
 * @returns { CanvasAttribute } The attribute of the Canvas.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Canvas(
  context?: CanvasRenderingContext2D | DrawingRenderingContext, imageAIOptions?: ImageAIOptions,
  @memo
  content_?: () => void,
): CanvasAttribute
