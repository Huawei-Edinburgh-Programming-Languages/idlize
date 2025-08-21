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
import { HorizontalAlign, FlexAlign } from './enums';
import { Resource } from './../../global/resource';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Defines the space property with string, number and resource unit.
 *
 * @typedef { string | number | Resource } SpaceType
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type SpaceType = string | number | Resource;
/**
 * Column constructor options.
 *
 * @interface ColumnOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface ColumnOptions {
    /**
     * Vertical layout element spacing.
     *
     * @type { ?(string | number) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    space?: string | number;
}
/**
 * Column constructor options.
 *
 * @interface ColumnOptionsV2
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface ColumnOptionsV2 {
    /**
     * Vertical layout element spacing.
     *
     * @type { ?SpaceType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    space?: SpaceType;
}
export declare interface ColumnAttribute extends CommonMethod {
    /**
     * Sets the alignment format of the subassembly in the horizontal direction.
     *
     * @param { HorizontalAlign } value
     * @returns { ColumnAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default alignItems(value: HorizontalAlign | undefined): this;
    /**
     * Sets the alignment format of the subassembly in the vertical direction.
     *
     * @param { FlexAlign } value
     * @returns { ColumnAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default justifyContent(value: FlexAlign | undefined): this;
    /**
     * Called when the Main-Axis's direction is set reversed or not
     *
     * @param { boolean | undefined } isReversed - If the main axis is reversed.
     * @returns { ColumnAttribute } The attribute of the column.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default reverse(isReversed: boolean | undefined): this;
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<ColumnAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { ColumnAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<ColumnAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

@memo
@ComponentBuilder
export declare function Column(
    options?: ColumnOptions | ColumnOptions | ColumnOptionsV2, 
    @memo
    content_?: () => void,
): ColumnAttribute
