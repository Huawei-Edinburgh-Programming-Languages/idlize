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
import { Length } from "./units";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";

/**
 * Defines the RadiusItem.
 * The first element is the width of the rounded corner, the second is the height of the rounded corner.
 *
 * @typedef { [Length, Length] } RadiusItem
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type RadiusItem = [
    Length,
    Length
];

/**
 * Define options used to construct a rectangle.
 *
 * @interface RectOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RectOptions {
    /**
     * Rectangle width.
     *
     * @type { ?(double | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    width?: double | string;
    /**
     * Rectangle height.
     *
     * @type { ?(double | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    height?: double | string;
    /**
     * Corner radius of the rectangle.
     *
     * @type { ?(Length | Array<RadiusItem>) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    radius?: Length | Array<RadiusItem>;
}

/**
 * Define options used to construct a rectangle with rounded corners.
 *
 * @interface RoundedRectOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RoundedRectOptions {
    /**
     * Rectangle width.
     *
     * @type { ?(double | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    width?: double | string;
    /**
     * Rectangle height.
     *
     * @type { ?(double | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    height?: double | string;
    /**
     * Width of the corner radius.
     *
     * @type { ?(double | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    radiusWidth?: double | string;
    /**
     * Height of the corner radius.
     *
     * @type { ?(double | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    radiusHeight?: double | string;
}

/**
 * rect attribute declaration.
 *
 * @extends CommonShapeMethod
 * @interface RectAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RectAttribute extends CommonShapeMethod {
    /**
     * Called when the fillet width is set.
     *
     * @param { double | string | undefined } value
     * @returns { RectAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default radiusWidth(value: double | string | undefined): this;
    /**
     * Called when the fillet height is set.
     *
     * @param { double | string | undefined } value
     * @returns { RectAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default radiusHeight(value: double | string | undefined): this;
    /**
     * Called when the fillet size is set.
     *
     * @param { Length | Array<RadiusItem> | undefined } value
     * @returns { RectAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default radius(value: Length | Array<RadiusItem> | undefined): this;
    /**
     * Call attributeModifier.
     *
     * @param { AttributeModifier<RectAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { RectAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<RectAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Rect is returned when the parameter is transferred.
 *
 * @param { RectOptions | RoundedRectOptions } [options] - The options to create a Rect
 * @param { function } [content_]
 * @returns { RectAttribute } The attribute of the Rect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Rect(
    options?: RectOptions | RoundedRectOptions, 
    @memo
    content_?: () => void,
): RectAttribute
