/*
 * Copyright (c) 2023-2024 Huawei Device Co., Ltd.
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


/**
 * This module provides functionality for component coordinates and sizes.
 * @namespace componentUtils
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
declare namespace componentUtils {
    
    
    /**
    * Component information.
    * @typedef ComponentInfo
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    export interface ComponentInfo {
        
        
        /**
        * component size.
        * @type {Size}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        size: Size;
        
        
        /**
        * Obtain attribute information relative to the local.
        * @type {Offset}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        localOffset: Offset;
        
        
        /**
        * Obtain attribute information relative to the window.
        * @type {Offset}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        windowOffset: Offset;
        
        
        /**
        * Obtain attribute information relative to the screen.
        * @type {Offset}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        screenOffset: Offset;
        
        
        /**
        * Obtain attribute information for translation.
        * @type {TranslateResult}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        translate: TranslateResult;
        
        
        /**
        * Obtain attribute information for scale.
        * @type {ScaleResult}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        scale: ScaleResult;
        
        
        /**
        * Obtain attribute information for rotate.
        * @type {RotateResult}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        rotate: RotateResult;
        
        
        /**
        * Obtain attribute information of the transformation matrix.
        * @type {Matrix4Result}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        transform: Matrix4Result;
    }
    
    
    /**
    * Defines the size property.
    * @typedef Size
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    export interface Size {
        
        
        /**
        * Defines the width property.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        width: number;
        
        
        /**
        * Defines the height property.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        height: number;
    }
    
    
    /**
    * Defines the offset property.
    * @typedef Offset
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    export interface Offset {
        
        
        /**
        * Coordinate x of the Position.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        x: number;
        
        
        /**
        * Coordinate y of the Position.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        y: number;
    }
    
    
    /**
    * Translation Result
    * @typedef TranslateResult
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    export interface TranslateResult {
        
        
        /**
        * Indicates the translation distance of the x-axis, in vp.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        x: number;
        
        
        /**
        * Indicates the translation distance of the y-axis, in vp.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        y: number;
        
        
        /**
        * Indicates the translation distance of the z-axis, in vp.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        z: number;
    }
    
    
    /**
    * Scale Result
    * @typedef ScaleResult
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    export interface ScaleResult {
        
        
        /**
        * Zoom factor of the x-axis.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        x: number;
        
        
        /**
        * Zoom factor of the y-axis.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        y: number;
        
        
        /**
        * Zoom factor of the z-axis.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        z: number;
        
        
        /**
        * Transform the x-axis coordinate of the center point.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        centerX: number;
        
        
        /**
        * Transform the y-axis coordinate of the center point.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        centerY: number;
    }
    
    
    /**
    * Rotation Result.
    * @typedef RotateResult
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    export interface RotateResult {
        
        
        /**
        * Axis of rotation vector x coordinate.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        x: number;
        
        
        /**
        * Axis of rotation vector y coordinate.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        y: number;
        
        
        /**
        * Axis of rotation vector z coordinate.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        z: number;
        
        
        /**
        * Transform the x-axis coordinate of the center point.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        centerX: number;
        
        
        /**
        * Transform the y-axis coordinate of the center point.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        centerY: number;
        
        
        /**
        * Rotation angle.
        * @type {number}
        * @syscap SystemCapability.ArkUI.ArkUI.Full
        * @since 20
        */
        angle: number;
    }
    
    
    /**
    * The matrix is column-first fourth-order matrix.
    * @typedef { [number, number, number, number, number, number, number, number, number, number, number, number,
    * number, number, number, number,] } Matrix4Result
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    export type Matrix4Result = [
        number,
        number,
        number,
        number,
        number,
        number,
        number,
        number,
        number,
        number,
        number,
        number,
        number,
        number,
        number,
        number
    ];
}
export default componentUtils;
