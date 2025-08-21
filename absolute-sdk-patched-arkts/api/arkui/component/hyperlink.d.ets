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
import { Resource } from './../../../api/global/resource';
import { CommonMethod, AttributeModifier } from "./common";
import { Color } from "./enums";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";

/**
 * Defines the hyperlink attribute functions
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface HyperlinkAttribute extends CommonMethod {
    /**
     * Set Color
     *
     * @param { Color | number | string | Resource } value
     * @returns { HyperlinkAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default color(value: Color | number | string | Resource | undefined): this;
    /**
     * Sets the attribute modifier.
     *
     * @param { AttributeModifier<HyperlinkAttribute> | AttributeModifier<CommonMethod> | undefined } modifier.
     * @returns { HyperlinkAttribute } the attribute of the HyperlinkAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<HyperlinkAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines Hyperlink Component.
 *
 * @param { string | Resource } address
 * @param { string | Resource } [content]
 * @param { function } [content_]
 * @returns { HyperlinkAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
@memo
@ComponentBuilder
export declare function Hyperlink(
    address: string | Resource, content?: string | Resource, 
    @memo
    content_?: () => void,
): HyperlinkAttribute