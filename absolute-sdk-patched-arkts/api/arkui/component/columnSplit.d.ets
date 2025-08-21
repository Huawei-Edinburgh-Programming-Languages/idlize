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
import { Dimension } from './units';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Provides an interface for the style of a divider including start margin and end margin
 *
 * @interface ColumnSplitDividerStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface ColumnSplitDividerStyle {
    /**
     * Define the start margin of the divider
     *
     * @type { ?Dimension }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    startMargin?: Dimension;
    /**
     * Define the end margin of the divider
     *
     * @type { ?Dimension }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    endMargin?: Dimension;
}
export declare interface ColumnSplitAttribute extends CommonMethod {
    /**
     * Indicates whether the split line can be dragged. The default value is false.
     *
     * @param { boolean } value
     * @returns { ColumnSplitAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default resizeable(value: boolean | undefined): this;
    /**
     * Called when the ColumnSplit split line style is set.
     * @param { ColumnSplitDividerStyle | null } value - indicates the style of the indicator.
     * if value is set to null, the value of startMargin and endMargin is set to 0.0 by default.
     * @returns { ColumnSplitAttribute } the attribute of the ColumnSplit
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default divider(value: ColumnSplitDividerStyle | null | undefined): this;
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<ColumnSplitAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { ColumnSplitAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<ColumnSplitAttribute>
        | AttributeModifier<CommonMethod> | undefined): this;
}

@memo
@ComponentBuilder
export declare function ColumnSplit(
    
    @memo
    content_?: () => void,
): ColumnSplitAttribute
