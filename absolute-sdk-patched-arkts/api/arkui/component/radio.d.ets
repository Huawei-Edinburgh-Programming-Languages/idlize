'use static'
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
import { CommonMethod, ContentModifier, CommonConfiguration, Callback, Bindable } from './common';
import { CustomBuilder } from './builder';
import { ResourceColor } from './units';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Defines the IndicatorType of Radio component
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum RadioIndicatorType {
    /**
     * Tick shape.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TICK = 0,
    /**
     * Dot shape.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DOT = 1,
    /**
   * custom shape.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
    CUSTOM = 2
}
/**
 * Input parameter for creating a radio box.
 *
 * @interface RadioOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RadioOptions {
    /**
     * Radio group name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    group: string;
    /**
     * Radio name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: string;
    /**
     * Indicator Type.
     *
     * @type { ?RadioIndicatorType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    indicatorType?: RadioIndicatorType;
    /**
     * builder for IndicatorType.CUSTOM
     *
     * @type { ?CustomBuilder }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    indicatorBuilder?: CustomBuilder;
}
/**
 * Set radio Style.
 *
 * @interface RadioStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RadioStyle {
    /**
     * Set the background color when the radio box is checked.
     *
     * @type { ?ResourceColor } checkedBackgroundColor - the background color when the radio box is checked.
     * @default #007DFF
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    checkedBackgroundColor?: ResourceColor;
    /**
     * Set the bolder color when the radio box is unchecked.
     *
     * @type { ?ResourceColor } uncheckedBorderColor - the bolder color when the radio box is unchecked.
     * @default #182431
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    uncheckedBorderColor?: ResourceColor;
    /**
     * Set the indicator color when the radio box is checked.
     *
     * @type { ?ResourceColor } indicatorColor - the indicator color when the radio box is checked.
     * @default #FFFFFF
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    indicatorColor?: ResourceColor;
}
/**
 * Callback of radio box selection status changes event.
 *
 * @typedef {function} OnRadioChangeCallback
 * @param { boolean } isChecked
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnRadioChangeCallback = (isChecked: boolean) => void;
/**
 * Defines the Radio component attributes.
 *
 * @extends CommonMethod
 * @interface RadioAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RadioAttribute extends CommonMethod {
    /**
     * Called when the radio box is selected.
     *
     * @param { boolean | undefined | Bindable<boolean> } isChecked
     * @returns { RadioAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    checked(isChecked: boolean | undefined | Bindable<boolean>): this;
    /**
     * Called when the radio box selection status changes.
     *
     * @param { OnRadioChangeCallback | undefined } callback
     * @returns { RadioAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onChange(callback: OnRadioChangeCallback | undefined): this;
    /**
     * Set the radio style.
     *
     * @param { RadioStyle | undefined } [value] - the radio style.
     * @returns { RadioAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    radioStyle(value?: RadioStyle | undefined): this;
    /**
     * Set the Configuration of radio.
     *
     * @param { ContentModifier<RadioConfiguration> | undefined } modifier - The contentModifier of radio.
     * @returns { RadioAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
    */
    contentModifier(modifier: ContentModifier<RadioConfiguration> | undefined): this;
    /**
     * Set the attribute modifier of radio.
     *
     * @param { AttributeModifier<RadioAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     *     The attribute modifier of radio.
     * @returns { RadioAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    attributeModifier(modifier: AttributeModifier<RadioAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * RadioConfiguration used by radio Configuration
 *
 * @extends CommonConfiguration<RadioConfiguration>
 * @interface RadioConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RadioConfiguration extends CommonConfiguration<RadioConfiguration> {
    /**
   * Radio name.
   *
   * @type { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
    value: string;
    /**
   * Called when the radio box is selected.
   *
   * @type { boolean }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
    checked: boolean;
    /**
     * Called when the radio box selection status changes.
     *
     * @type { Callback<boolean> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    triggerChange: Callback<boolean>;
}

/**
 * Defines Radio Component.
 *
 * @param { RadioOptions } options - the options of Radio.
 * @param { function } [content_] - container
 * @returns { RadioAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Radio(
    options: RadioOptions,
    @memo
    content_?: () => void,
): RadioAttribute
