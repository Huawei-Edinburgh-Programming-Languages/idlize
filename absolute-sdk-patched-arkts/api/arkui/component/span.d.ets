/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License"),
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
import { ResourceColor, Dimension, BorderRadiuses, Length, Font } from "./units";
import { CommonMethod, ShadowOptions, AttributeModifier } from "./common";
import { LengthMetrics } from './../Graphics';
import { Resource } from './../../../api/global/resource';
import { FontStyle, FontWeight, TextCase } from "./enums";
import { DecorationStyleInterface } from "./styledString";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
/**
 * Define the background style of span.
 *
 * @interface TextBackgroundStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextBackgroundStyle {
    /**
     * Background color of span.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    color?: ResourceColor;
    /**
     * Background radius of span.
     *
     * @type { ?(Dimension | BorderRadiuses) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    radius?: Dimension | BorderRadiuses;
}
/**
 * Define the BaseSpan interface, contains the common methods of span.
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface BaseSpan extends CommonMethod {
    /**
     * Span background style.
     *
     * @param { TextBackgroundStyle | undefined } style - The background style of span.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textBackgroundStyle(style: TextBackgroundStyle | undefined): this;
    /**
     * Base line offset of the Span.
     *
     * @param { LengthMetrics | undefined } value - The base line offset of the Span.
     * @returns { T } The attribute of the Span.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default baselineOffset(value: LengthMetrics | undefined): this;
}
/**
 * Define the Span attribute functions.
 *
 * @extends BaseSpan
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface SpanAttribute extends BaseSpan {
    /**
     * Called when the font is set.
     *
     * @param { Font | undefined } value - the span font size and weight and family and style.
     * @returns { SpanAttribute } The attribute of the span.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default font(value: Font | undefined): this;
    /**
     * Called when the font color is set.
     *
     * @param { ResourceColor | undefined } value
     * @returns { SpanAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontColor(value: ResourceColor | undefined): this;
    /**
     * Called when the font size is set.
     *
     * @param { number | string | Resource | undefined } value
     * @returns { SpanAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontSize(value: number | string | Resource | undefined): this;
    /**
     * Called when the font style of a font is set.
     *
     * @param { FontStyle | undefined } value
     * @returns { SpanAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontStyle(value: FontStyle | undefined): this;
    /**
    * Called when the font weight is set.
    *
    * @param { number | FontWeight | string | undefined } value
    * @returns { SpanAttribute }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    default fontWeight(value: number | FontWeight | string | undefined): this;
    /**
     * Called when the font list of text is set.
     *
     * @param { string | Resource | undefined } value
     * @returns { SpanAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontFamily(value: string | Resource | undefined): this;
    /**
     * Called when the text decoration of the text is set.
     *
     * @param { DecorationStyleInterface | undefined } value
     * @returns { SpanAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default decoration(value: DecorationStyleInterface | undefined): this;
    /**
    * Called when the distance between text fonts is set.
    *
    * @param { number | string | undefined } value
    * @returns { SpanAttribute }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    default letterSpacing(value: number | string | undefined): this;
    /**
     * Called when the type of letter in the text font is set.
     *
     * @param { TextCase | undefined } value
     * @returns { SpanAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textCase(value: TextCase | undefined): this;
    /**
     * Called when the line height of the span is set.
     *
     * @param { Length | undefined } value - The line height of the span.
     * @returns { SpanAttribute } The attribute of the span.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default lineHeight(value: Length | undefined): this;
    /**
     * Called when the text shadow is set.
     *
     * @param { ShadowOptions | Array<ShadowOptions> | undefined } value - The shadow options.
     * @returns { SpanAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textShadow(value: ShadowOptions | Array<ShadowOptions> | undefined): this;
    /**
     * Sets the attribute modifier.
     *
     * @param { AttributeModifier<SpanAttribute> | AttributeModifier<CommonMethod> | undefined } modifier.
     * @returns { SpanAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<SpanAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines Span Component.
 *
 * @param { string | Resource } value
 * @param { function } [content_]
 * @returns { SpanAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
@memo
@ComponentBuilder
export declare function Span(
    value: string | Resource, 
    @memo
    content_?: () => void,
): SpanAttribute
