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
import { CommonShapeMethod, AttributeModifier, CommonMethod } from "./common";
import { ShapePoint } from "./line";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";

/**
 * Define options used to construct a polyline.
 *
 * @interface PolylineOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface PolylineOptions {
    /**
     * Polyline width.
     *
     * @type { ?(string | double) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    width?: string | double;
    /**
     * Polyline height.
     *
     * @type { ?(string | double) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    height?: string | double;
}

/**
 * Defines Polyline attribute
 * @extends CommonShapeMethod
 * @interface PolylineAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface PolylineAttribute extends CommonShapeMethod {
    /**
     * Called when the polyline is set to pass through the coordinate point list.
     *
     * @param { Array<ShapePoint> | undefined } value
     * @returns { PolylineAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default points(value: Array<ShapePoint> | undefined): this;
    /**
     * Call attributeModifier.
     *
     * @param { AttributeModifier<PolylineAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { PolylineAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<PolylineAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Polyline is returned when the parameter is transferred.
 *
 * @param { PolylineOptions } [options] - The options to create a Polyline
 * @param { function } [content_]
 * @returns { PolylineAttribute } The attribute of the Polyline.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Polyline(
    options?: PolylineOptions, 
    @memo
    content_?: () => void,
): PolylineAttribute
