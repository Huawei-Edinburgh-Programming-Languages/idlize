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
import { CommonMethod, Optional, Bindable } from './common';
import { ResourceColor, MarkStyle } from './units';
import { CheckBoxShape } from './enums';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * CheckboxGroup SelectStatus
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SelectStatus {
    /**
     * All checkboxes are selected.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    All,
    /**
     * Part of the checkbox is selected.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Part,
    /**
     * None of the checkbox is selected.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None
}
/**
 * Defines the options of CheckboxGroup.
 *
 * @interface CheckboxGroupOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CheckboxGroupOptions {
    /**
     * Setting the group of CheckboxGroup.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    group?: string;
}
/**
 * Defines the options of CheckboxGroupResult.
 *
 * @interface CheckboxGroupResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CheckboxGroupResult {
    /**
     * Checkbox name.
     *
     * @type { Array<string> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    name: Array<string>;
    /**
     * Set the group of status.
     *
     * @type { SelectStatus }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    status: SelectStatus;
}
/**
 * Defines a CheckboxGroup callback when onChange.
 * Anonymous Object Rectification.
 *
 * @typedef { function } OnCheckboxGroupChangeCallback
 * @param { CheckboxGroupResult } value - checkbox group result
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnCheckboxGroupChangeCallback = (value: CheckboxGroupResult) => void;
/**
 * Defines the CheckboxGroup component attributes.
 *
 * @extends CommonMethod
 * @interface CheckboxGroupAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CheckboxGroupAttribute extends CommonMethod {
    /**
     * setting whether all checkbox is selected.
     *
     * @param { boolean| undefined|Bindable<boolean> } isAllSelected
     * @returns { CheckboxGroupAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectAll(isAllSelected: boolean | undefined | Bindable<boolean>): this;
    /**
     * setting the display color of checkbox.
     *
     * @param { ResourceColor | undefined } value
     * @returns { CheckboxGroupAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedColor(value: ResourceColor | undefined): this;
    /**
     * Set the display border color of unselected checkbox.
     *
     * @param { ResourceColor | undefined } value - The color of border when checkboxgroup unselected.
     * @returns { CheckboxGroupAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    unselectedColor(value: ResourceColor | undefined): this;
    /**
     * Set the mark style of checkbox.
     *
     * @param { MarkStyle | undefined } value - The style configuration of checkboxgroup mark.
     * @returns { CheckboxGroupAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    mark(value: MarkStyle | undefined): this;
    /**
     * Called when the selection status changes.
     * Anonymous Object Rectification.
     *
     * @param { OnCheckboxGroupChangeCallback | undefined } callback
     * @returns { CheckboxGroupAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onChange(callback: OnCheckboxGroupChangeCallback | undefined): this;
    /**
     * Setting the shape of checkbox group.
     *
     * @param { CheckBoxShape | undefined } value - The configuration of checkbox group shape.
     * @returns { CheckboxGroupAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    checkboxShape(value: CheckBoxShape | undefined): this;
    /**
     * Set the attribute modifier of checkbox group.
     *
     * @param { AttributeModifier<CheckboxGroupAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     *     The attribute modifier of checkbox group.
     * @returns { CheckboxGroupAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    attributeModifier(
        modifier: AttributeModifier<CheckboxGroupAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines CheckboxGroup Component.
 *
 * @param { CheckboxGroupOptions } [options] - the options of CheckboxGroup.
 * @param { function } [content_] - container
 * @returns { CheckboxGroupAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function CheckboxGroup(
    options?: CheckboxGroupOptions,
    @memo
    content_?: () => void,
): CheckboxGroupAttribute
