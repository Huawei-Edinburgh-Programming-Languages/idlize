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
import { CommonMethod } from './common';
import { Length, Font, ResourceColor, Dimension, BorderRadiuses, DividerStyleOptions } from './units';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Declare SubMenuExpandingMode
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SubMenuExpandingMode {
    /**
     * Sub-menu will expand besides main menu
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SIDE_EXPAND = 0,
    /**
     * Sub-menu will expand embedded in main menu
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    EMBEDDED_EXPAND = 1,
    /**
     * Sub-menu will expand over main menu
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    STACK_EXPAND = 2
}

/**
 * Defines the Menu component attribute functions.
 *
 * @extends CommonMethod
 * @interface MenuAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface MenuAttribute extends CommonMethod {
    /**
     * Sets the font style.
     * Family and style are not supported currently and will be fixed in future.
     *
     * @param { Font | undefined } value - Indicates the font style of menu item.
     * @returns { MenuAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    font(value: Font | undefined): this;
    /**
     * Sets the Menu font color.
     *
     * @param { ResourceColor | undefined } value - Indicates the font color of menu item.
     * @returns { MenuAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontColor(value: ResourceColor | undefined): this;
    /**
     * Sets the radius of the corner around the menu.
     * When the radius is less than the menu width, the default border radius is used.
     *
     * @param { Dimension | BorderRadiuses | undefined } value - the border radius.
     * @returns { MenuAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    radius(value: Dimension | BorderRadiuses | undefined): this;
    /**
     * Set the divider of menu item
     *
     * @param { DividerStyleOptions | undefined } options
     * @returns { MenuAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    menuItemDivider(options: DividerStyleOptions | undefined): this;
    /**
     * Set the divider of menu item group
     *
     * @param { DividerStyleOptions | undefined } options
     * @returns { MenuAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    menuItemGroupDivider(options: DividerStyleOptions | undefined): this;
    /**
     * Set the expanding mode of sub-menu
     *
     * @param { SubMenuExpandingMode | undefined } mode
     * @returns { MenuAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    subMenuExpandingMode(mode: SubMenuExpandingMode | undefined): this;
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<MenuAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { MenuAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    attributeModifier(modifier: AttributeModifier<MenuAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines Menu Component.
 *
 * @param { function } [content_] - container
 * @returns { MenuAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Menu(
    
    @memo
    content_?: () => void,
): MenuAttribute