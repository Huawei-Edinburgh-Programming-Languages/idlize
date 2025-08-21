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
import { CommonConfiguration, Callback, CommonMethod, ContentModifier, Optional, Bindable } from './common';
import { CustomBuilder } from './builder';
import { ResourceColor, MarkStyle } from './units';
import { CheckBoxShape } from './enums';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Defines the options of Checkbox.
 *
 * @interface CheckboxOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CheckboxOptions {
    /**
     * Current name of Checkbox.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    name?: string;
    /**
     * Sets the group of Checkbox.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    group?: string;
    /**
     * Custom builder function.
     *
     * @type { ?CustomBuilder }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    indicatorBuilder?: CustomBuilder;
}
/**
 * CheckBoxConfiguration used by content modifier.
 *
 * @extends CommonConfiguration<CheckBoxConfiguration>
 * @interface CheckBoxConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CheckBoxConfiguration extends CommonConfiguration<CheckBoxConfiguration> {
    /**
     * Current name of checkbox.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    name: string;
    /**
     * Indicates whether the checkbox is selected.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selected: boolean;
    /**
     * Trigger checkbox select change.
     *
     * @type { Callback<boolean> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    triggerChange: Callback<boolean>;
}
/**
 * Defines a Checkbox callback when onChange.
 * Anonymous Object Rectification.
 *
 * @typedef { function } OnCheckboxChangeCallback
 * @param { boolean } value - selected status
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnCheckboxChangeCallback = (value: boolean) => void;
/**
 * Defines the Checkbox component attributes.
 *
 * @extends CommonMethod
 * @interface CheckboxAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CheckboxAttribute extends CommonMethod {
    /**
     * setting whether checkbox is selected.
     *
     * @param { boolean | undefined | Bindable<boolean> } isSelected
     * @returns { CheckboxAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    select(isSelected: boolean | undefined | Bindable<boolean>): this;
    /**
     * setting the display color of checkbox.
     *
     * @param { ResourceColor | undefined } value
     * @returns { CheckboxAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedColor(value: ResourceColor | undefined): this;
    /**
    * setting the shape of checkbox.
    *
    * @param { CheckBoxShape | undefined } value - The configuration of checkbox shape.
    * @returns { CheckboxAttribute }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    shape(value: CheckBoxShape | undefined): this;
    /**
     * Set the display border color of unselected checkbox.
     *
     * @param { ResourceColor | undefined } value - The color of border when checkbox unselected.
     * @returns { CheckboxAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    unselectedColor(value: ResourceColor | undefined): this;
    /**
     * Set the mark style of checkbox.
     *
     * @param { MarkStyle | undefined } value - The style configuration of checkbox mark.
     * @returns { CheckboxAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    mark(value: MarkStyle | undefined): this;
    /**
     * Called when the selection status changes.
     * Anonymous Object Rectification.
     *
     * @param { OnCheckboxChangeCallback | undefined } callback
     * @returns { CheckboxAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onChange(callback: OnCheckboxChangeCallback | undefined): this;
    /**
     * Set the content modifier of checkbox.
     *
     * @param { ContentModifier<CheckBoxConfiguration> | undefined } modifier - The content modifier of checkbox.
     * @returns { CheckboxAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    contentModifier(modifier: ContentModifier<CheckBoxConfiguration> | undefined): this;
    /**
     * Set the attribute modifier of checkbox.
     *
     * @param { AttributeModifier<CheckboxAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     *     The attribute modifier of checkbox.
     * @returns { CheckboxAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    attributeModifier(
        modifier: AttributeModifier<CheckboxAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines Checkbox Component.
 *
 * @param { CheckboxOptions } [options] - the options of Checkbox.
 * @param { function } [content_] - container
 * @returns { CheckboxAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Checkbox(
    options?: CheckboxOptions,
    @memo
    content_?: () => void,
): CheckboxAttribute