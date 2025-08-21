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
import { CommonMethod, Bindable } from './common';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Defines the grid item style.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum GridItemStyle {
    /**
     * Show none style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NONE = 0,
    /**
     * Show plain style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PLAIN = 1
}
/**
 * Defines the grid item options.
 *
 * @interface GridItemOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GridItemOptions {
    /**
     * Describes the GridItem style.
     *
     * @type { ?GridItemStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style?: GridItemStyle;
}
/**
 * The GridItemAttribute.
 * 
 * @extends CommonMethod
 * @interface GridItemAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GridItemAttribute extends CommonMethod {
    /**
     * This parameter specifies the start line number of the current element.
     *
     * @param { numnumber | undefinedber } value
     * @returns { GridItemAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default rowStart(value: number | undefined): this;
    /**
     * Specifies the end line number of the current element.
     *
     * @param { number | undefined } value
     * @returns { GridItemAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default rowEnd(value: number | undefined): this;
    /**
     * This parameter specifies the start column number of the current element.
     *
     * @param { number | undefined } value
     * @returns { GridItemAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default columnStart(value: number | undefined): this;
    /**
     * This parameter specifies the end column number of the current element.
     *
     * @param { number | undefined } value
     * @returns { GridItemAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default columnEnd(value: number | undefined): this;
    /**
     * Called when judging whether it is selectable.
     *
     * @param { boolean | undefined } value
     * @returns { GridItemAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default selectable(value: boolean | undefined): this;
    /**
     * Called when judging whether it is selected.
     * This parameter supports $$ for two-way binding of variables.
     *
     * @param { boolean | Bindable<boolean> | undefined } value
     * @returns { GridItemAttribute } the attribute of the gridItem.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default selected(value: boolean | Bindable<boolean> | undefined): this;
    /**
     * Called when the gridItem is selected.
     *
     * @param { function | undefined } event
     * @returns { GridItemAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onSelect(event: ((isSelected: boolean) => void) | undefined): this;
    /**
     * Called attributeModifier.
     *
     * @param { AttributeModifier<GridItemAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<GridItemAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines GridItem Component.
 *
 * @param { GridItemOptions } [value] - options
 * @param { function } [content_] - container
 * @returns { GridItemAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function GridItem(
    value?: GridItemOptions, 
    @memo
    content_?: () => void,
): GridItemAttribute