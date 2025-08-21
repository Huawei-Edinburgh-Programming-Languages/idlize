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
import { VerticalAlign, FlexAlign } from './enums';
import { SpaceType } from './column';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Define options used to construct a row.
 *
 * @interface RowOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RowOptions {
    /**
     * Row spacing.
     *
     * Anonymous Object Rectification
     * @type { ?(string | number) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    space?: string | number;
}
/**
 * Define options used to construct a row.
 *
 * @interface RowOptionsV2
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface RowOptionsV2 {
    /**
     * Vertical layout element spacing.
     *
     * @type { ?SpaceType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    space?: SpaceType;
}
export declare interface RowAttribute extends CommonMethod {
    /**
     * Called when the vertical alignment is set.
     *
     * @param { VerticalAlign } value
     * @returns { RowAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default alignItems(value: VerticalAlign | undefined): this;
    /**
     * Called when the horizontal alignment is set.
     *
     * @param { FlexAlign } value
     * @returns { RowAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default justifyContent(value: FlexAlign | undefined): this;
    /**
     * Called when the Main-Axis's direction is set reversed or not
     *
     * @param { boolean | undefined } isReversed - If the main axis is reversed.
     * @returns { RowAttribute } The attribute of the row.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default reverse(isReversed: boolean | undefined): this;
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<RowAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { RowAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<RowAttribute> | AttributeModifier<CommonMethod>
        | undefined): this;
}

@memo
@ComponentBuilder
export declare function Row(
    options?: RowOptions | RowOptions | RowOptionsV2, 
    @memo
    content_?: () => void,
): RowAttribute
