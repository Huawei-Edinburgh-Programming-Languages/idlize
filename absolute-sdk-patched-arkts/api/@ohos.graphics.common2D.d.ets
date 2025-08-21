/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
/**
 * The date structure that provides the basis for graphics.
 *
 * @namespace common2D
 * @syscap SystemCapability.Graphics.Drawing
 * @since 20
 */
declare namespace common2D {
    /**
     * Describes a color in ARGB format.
     * @typedef Color
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    interface Color {
        
        /**
         * Alpha component of the color. The value is an integer ranging from 0 to 255.
         * @type { int }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        alpha: int;
        
        /**
         * Red component of the color. The value is an integer ranging from 0 to 255.
         * @type { int }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        red: int;
        
        /**
         * Green component of the color. The value is an integer ranging from 0 to 255.
         * @type { int }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        green: int;
        
        /**
         * Blue component of the color. The value is an integer ranging from 0 to 255.
         * @type { int }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        blue: int;
    }
    /**
     * Describes a rectangle, which can be defined by two coordinate points: upper left corner point and lower right corner point.
     * @typedef Rect
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    interface Rect {
        
        /**
         * X coordinate of the upper left corner of the rectangle. The value is a floating point number.
         * @type { double }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        left: double;
        
        /**
         * Y coordinate of the upper left corner of the rectangle. The value is a floating point number.
         * @type { double }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        top: double;
        
        /**
         * X coordinate of the lower right corner of the rectangle. The value is a floating point number.
         * @type { double }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        right: double;
        
        /**
         * Y coordinate of the lower right corner of the rectangle. The value is a floating point number.
         * @type { double }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        bottom: double;
    }
    /**
     * Describes a coordinate point.
     * @typedef Point
     * @syscap SystemCapability.Graphics.Drawing
     * @since 20
     */
    interface Point {
        
        /**
         * Horizontal coordinate. The value is a floating point number.
         * @type { double }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        x: double;
        
        /**
         * Vertical coordinate. The value is a floating point number.
         * @type { double }
         * @syscap SystemCapability.Graphics.Drawing
         * @since 20
         */
        y: double;
    }
}
export default common2D;
