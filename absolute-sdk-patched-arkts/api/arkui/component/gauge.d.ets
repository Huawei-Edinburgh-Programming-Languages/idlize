/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
 */
import { CommonMethod, CommonConfiguration, ContentModifier, MultiShadowOptions, Optional } from './common';
import { CustomBuilder } from './builder';
import { ResourceStr, Dimension, ResourceColor, Length } from './units';
import { LinearGradient } from "./dataPanel";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Defines Gauge constructor options.
 *
 * @interface GaugeOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface GaugeOptions {
    /**
     * Set current data value.
     * Anonymous Object Rectification.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: number;
    /**
     * Set current segment minimum value.
     * Anonymous Object Rectification.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    min?: number;
    /**
     * Set current segment maximum value.
     * Anonymous Object Rectification.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    max?: number;
}
/**
 * Defines the options of gauge track shadow.
 *
 * @extends MultiShadowOptions
 * @interface GaugeShadowOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GaugeShadowOptions extends MultiShadowOptions {
}
/**
 * Defines the options of gauge indicator.
 *
 * @interface GaugeIndicatorOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GaugeIndicatorOptions {
    /**
     * Current indicator icon path.
     *
     * @type { ?ResourceStr } option type - the current option type.
     * @default system style.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    icon?: ResourceStr;
    /**
     * Current indicator space.
     *
     * @type { ?Dimension } indicator space - the current indicator space.
     * @default 8
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    space?: Dimension;
}
/**
 * GaugeConfiguration used by content modifier
 *
 * @extends CommonConfiguration<GaugeConfiguration>
 * @interface GaugeConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GaugeConfiguration extends CommonConfiguration<GaugeConfiguration> {
    /**
     * Current data value.
     *
     * @type { number } data value - the current data value.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: number;
    /**
     * Current Segment Minimum Value.
     *
     * @type { number } segment minimum value - the current segment minimum value.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    min: number;
    /**
     * Current Segment Maximum Value.
     *
     * @type { number } segment maximum value - the current segment maximum value.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    max: number;
}
export declare interface GaugeAttribute extends CommonMethod {
    /**
     * Sets the value for the current profile.
     *
     * @param { number } value
     * @returns { GaugeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value(value: number | undefined): this;
    /**
     * Set the start angle. Clock 0 is 0 degrees and clockwise is positive.
     *
     * @param { number } angle
     * @returns { GaugeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    startAngle(angle: number | undefined): this;
    /**
     * Sets the end angle position. Clock 0 is 0 degrees and clockwise is positive.
     *
     * @param { number } angle
     * @returns { GaugeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    endAngle(angle: number | undefined): this;
    /**
     * Set the color of the chart. You can set the solid color and segmented gradient color.
     *
     * @param { ResourceColor | LinearGradient | Array<[ResourceColor | LinearGradient, number]> } colors - section colors of gauge drawing.
     * @returns { GaugeAttribute } returns the instance of the GaugeAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    colors(colors: ResourceColor | LinearGradient | Array<[
        ResourceColor | LinearGradient,
        number
    ]> | undefined): this;
    /**
     * Sets the thickness of the ring chart.
     *
     * @param { Length } length
     * @returns { GaugeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    strokeWidth(length: Length | undefined): this;
    /**
     * Sets description content of the ring chart.
     *
     * @param { CustomBuilder } value - description content builder of the gauge drawing.
     * @returns { GaugeAttribute } returns the instance of the GaugeAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    description(value: CustomBuilder | undefined): this;
    /**
     * Sets track shadow of the ring chart.
     *
     * @param { GaugeShadowOptions } value - track shadow options of the gauge drawing.
     * @returns { GaugeAttribute } returns the instance of the GaugeAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    trackShadow(value: GaugeShadowOptions | undefined): this;
    /**
     * Sets indicator options of the ring chart.
     *
     * @param { GaugeIndicatorOptions } value - indicator options of the gauge drawing.
     * @returns { GaugeAttribute } returns the instance of the GaugeAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    indicator(value: GaugeIndicatorOptions | undefined): this;
    /**
     * Sets if mark to privacy sensitive.
     *
     * @param { Optional<boolean> } isPrivacySensitiveMode - indicates if mark to  privacy sensitive .
     * @returns { GaugeAttribute } returns the instance of the GaugeAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    privacySensitive(isPrivacySensitiveMode: boolean | undefined): this;
    /**
     * Set the content modifier of gauge.
     *
     * @param { ContentModifier<GaugeConfiguration> } modifier - The content modifier of gauge.
     * @returns { GaugeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    contentModifier(modifier: ContentModifier<GaugeConfiguration> | undefined): this;
    attributeModifier(modifier: AttributeModifier<GaugeAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Called when the gauge component is used.
 * Anonymous Object Rectification.
 *
 * @param { GaugeOptions } options - Gauge options.
 * @returns { GaugeAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Gauge(
    options: GaugeOptions, 
    @memo
    content_?: () => void,
): GaugeAttribute