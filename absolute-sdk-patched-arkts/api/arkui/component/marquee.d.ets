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
import { ResourceColor, Length } from "./units";
import { CommonMethod, AttributeModifier } from "./common";
import { FontWeight, MarqueeUpdateStrategy } from "./enums";
import { Resource } from './../../../api/global/resource';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";

/**
 * Defines Marquee constructor options.
 *
 * Anonymous Object Rectification.
 * @interface MarqueeOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface MarqueeOptions {
    /**
     * Control whether the running lamp enters the playing state.
     *
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>:
     * <br><em>true</em>: Start scrolling.
     * <br><em>false</em>: Do not start scrolling.
     * <br>This parameter cannot be used to restart scrolling that has been completed.
     * </p>
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    start: boolean;
    /**
     * Scroll animation text scroll step, when step is larger than the text width of Marquee, take the default value.
     *
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value is greater than the text width of the marquee, the default value is used.
     * </p>
     *
     * @type { ?number } - The unit is vp.
     * @default 6
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    step?: number;
    /**
     * Set the number of times the scroll is repeated, infinite loop if it is less than or equal to zero.
     *
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value is less than or equal to 0, the marquee will scroll continuously.
     * <br>Regardless of the value, the marquee scrolls only once on an ArkTS widget.
     * </p>
     *
     * @type { ?number }
     * @default -1
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    loop?: number;
    /**
     * Set text to scroll from the beginning or backward.
     *
     * Anonymous Object Rectification.
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fromStart?: boolean;
    /**
     * Text that needs scrolling.
     *
     * Anonymous Object Rectification.
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    src: string;
}

/**
 * Declares marquee properties.
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface MarqueeAttribute extends CommonMethod {
    /**
     * Set marquee font Color.
     *
     * @param { ResourceColor | undefined } value
     * @returns { MarqueeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontColor(value: ResourceColor | undefined): this;
    /**
     * Set marquee font size.
     *
     * <p><strong>NOTE</strong>:
     * <br>If fontSize is of the number type, the unit fp is used. The default font size is 16 fp.
     * <br>This parameter cannot be set in percentage.
     * </p>
     *
     * @param { Length | undefined } value
     * @returns { MarqueeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontSize(value: Length | undefined): this;
    /**
     * Set marquee allow scale.
     *
     * <p><strong>NOTE</strong>:
     * <br>This parameter is effective only when fontSize is in fp units.
     * </p>
     *
     * @param { boolean | undefined } value - Default value is false.
     * @returns { MarqueeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default allowScale(value: boolean | undefined): this;
    /**
     * Set marquee font weight.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value is too large, the text may be clipped depending on the font.
     * <br>For the number type, the value range is [100, 900], at an interval of 100.
     * <br>The default value is 400.
     * <br>A larger value indicates a heavier font weight.
     * <br>For the string type, only strings that represent a number, for example, "400",
     * and the following enumerated values of FontWeight are supported: "bold", "bolder", "lighter", "regular", and "medium".
     * </p>
     *
     * @param { number | FontWeight | string | undefined } value - Default value is FontWeight.Normal.
     * @returns { MarqueeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontWeight(value: number | FontWeight | string | undefined): this;
    /**
     * Set marquee font family.
     *
     * <p><strong>NOTE</strong>:
     * <br>Default font: 'HarmonyOS Sans'
     * <br>The 'HarmonyOS Sans' font and registered custom fonts are supported for applications.
     * <br>Only the 'HarmonyOS Sans' font is supported for widgets.
     * </p>
     *
     * @param { string | Resource | undefined } value
     * @returns { MarqueeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontFamily(value: string | Resource | undefined): this;
    /**
     * Marquee scrolling strategy after text update.
     *
     * <p><strong>NOTE</strong>:
     * <br>This attribute takes effect when the marquee is in the playing state
     * and the text content width exceeds the width of the marquee component.
     * </p>
     *
     * @param { MarqueeUpdateStrategy | undefined } value - The scrolling strategy after text update.Default value is MarqueeUpdateStrategy.DEFAULT.
     * @returns { MarqueeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default marqueeUpdateStrategy(value: MarqueeUpdateStrategy | undefined): this;
    /**
     * Called when scrolling starts.
     *
     * @param { function | undefined } event
     * @returns { MarqueeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onStart(event: (() => void) | undefined): this;
    /**
     * Called when scrolling to the bottom.
     *
     * <p><strong>NOTE</strong>:
     * <br>This event will be triggered for multiple times if the loop attribute is not set to 1.
     * </p>
     *
     * @param { function | undefined } event
     * @returns { MarqueeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onBounce(event: (() => void) | undefined): this;
    /**
     * Called when scrolling is complete.
     *
     * @param { function | undefined } event
     * @returns { MarqueeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onFinish(event: (() => void) | undefined): this;
    /**
     * Sets the attribute modifier.
     *
     * @param { AttributeModifier<MarqueeAttribute> | AttributeModifier<CommonMethod> | undefined } modifier.
     * @returns { MarqueeAttribute } the attribute of the MarqueeAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<MarqueeAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines Marquee Component.
 *
 * @param { MarqueeOptions } options
 * @param { function } [content_]
 * @returns { MarqueeAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
@memo
@ComponentBuilder
export declare function Marquee(
    options: MarqueeOptions, 
    @memo
    content_?: () => void,
): MarqueeAttribute