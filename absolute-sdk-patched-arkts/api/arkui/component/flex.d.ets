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
import { LengthMetrics } from '../Graphics';
import { FlexWrap, FlexDirection, ItemAlign, FlexAlign } from './enums';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Describes the layout and alignment of child components within the Flex component.
 *
 * @interface FlexOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface FlexOptions {
    /**
     * Direction in which child components are arranged in the Flex component.
     *
     * @type { ?FlexDirection }
     * @default FlexDirection.Row
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    direction?: FlexDirection;
    /**
     * Whether the Flex component has a single line or multiple lines.
     *
     * @type { ?FlexWrap }
     * @default FlexWrap.NoWrap
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    wrap?: FlexWrap;
    /**
     * Alignment mode of the child components in the Flex component along the main axis.
     *
     * @type { ?FlexAlign }
     * @default FlexAlign.Start
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    justifyContent?: FlexAlign;
    /**
     * Alignment mode of the child components in the Flex component along the cross axis.
     *
     * @type { ?ItemAlign }
     * @default ItemAlign.Start
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    alignItems?: ItemAlign;
    /**
     * Alignment mode of the child components in a multi-row Flex component along the cross axis.
     * This parameter is valid only when wrap is set to Wrap or WrapReverse.
     *
     * @type { ?FlexAlign }
     * @default FlexAlign.Start
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    alignContent?: FlexAlign;
    /**
     * Spacing between child components along the main axis or cross axis of the Flex component.
     *
     * @type { ?FlexSpaceOptions }
     * @default {main: LengthMetrics.px(0), cross: LengthMetrics.px(0)}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    space?: FlexSpaceOptions;
}
/**
 * Defines the spacing between child components along the main axis or cross axis of the Flex component.
 *
 * @interface FlexSpaceOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface FlexSpaceOptions {
    /**
     * Space on the main axis of the Flex component.
     *
     * @type { ?LengthMetrics }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    main?: LengthMetrics;
    /**
     * Space on the main axis of the Flex component.
     *
     * @type { ?LengthMetrics }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    cross?: LengthMetrics;
}
export declare interface FlexAttribute extends CommonMethod {
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<FlexAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { FlexAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<FlexAttribute> | AttributeModifier<CommonMethod>
        | undefined): this;
}

@memo
@ComponentBuilder
export declare function Flex(
    value?: FlexOptions, 
    @memo
    content_?: () => void,
): FlexAttribute
