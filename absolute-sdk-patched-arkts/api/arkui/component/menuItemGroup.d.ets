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
import { CustomBuilder } from './builder';
import { ResourceStr } from './units';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Defines the option of MenuItemGroup.
 *
 * @interface MenuItemGroupOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface MenuItemGroupOptions {
    /**
     * Defines the header display info.
     *
     * @type { ?(ResourceStr | CustomBuilder) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    header?: ResourceStr | CustomBuilder;
    /**
     * Defines the footer display info.
     *
     * @type { ?(ResourceStr | CustomBuilder) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    footer?: ResourceStr | CustomBuilder;
}

/**
 * Defines the MenuItemGroup component attribute functions.
 *
 * @extends CommonMethod
 * @interface MenuItemGroupAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface MenuItemGroupAttribute extends CommonMethod {
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<MenuItemGroupAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { MenuItemGroupAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    attributeModifier(
        modifier: AttributeModifier<MenuItemGroupAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines MenuItem Component.
 *
 * @param { MenuItemGroupOptions } [value] - The options
 * @param { function } [content_] - container
 * @returns { MenuItemGroupAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function MenuItemGroup(
    value?: MenuItemGroupOptions, 
    @memo
    content_?: () => void,
): MenuItemGroupAttribute