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
import { ResourceColor } from './units';
import { LineCapStyle } from './enums';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
export declare interface DividerAttribute extends CommonMethod {
    /**
     * Indicates whether to use a horizontal splitter or a vertical splitter.
     * The options are as follows: false: horizontal splitter; true: vertical splitter.
     *
     * @param { boolean } value
     * @returns { DividerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default vertical(value: boolean | undefined): this;
    /**
     * Sets the color of the divider line.
     *
     * @param { ResourceColor } value
     * @returns { DividerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default color(value: ResourceColor | undefined): this;
    /**
     * Sets the width of the dividing line.
     *
     * @param { number | string } value
     * @returns { DividerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default strokeWidth(value: number | string | undefined): this;
    /**
     * Sets the end style of the split line. The default value is Butt.
     *
     * @param { LineCapStyle } value
     * @returns { DividerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default lineCap(value: LineCapStyle | undefined): this;
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<DividerAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { DividerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<DividerAttribute>
        | AttributeModifier<CommonMethod> | undefined): this;
}

@memo
@ComponentBuilder
export declare function Divider(
    
    @memo
    content_?: () => void,
): DividerAttribute
