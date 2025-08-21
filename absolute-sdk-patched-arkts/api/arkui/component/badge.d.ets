/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
 */
import { ResourceColor, Length, Position, Resource, ResourceStr } from './units';
import { FontWeight } from "./enums";
import { CommonMethod } from './common';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Defines the badge position property.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum BadgePosition {
    /**
     * The badge is displayed in the upper right corner of the parent component.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RightTop,
    /**
     * The badge is vertically centered on the right of the parent component.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Right,
    /**
     * The badge is vertically centered on the left of the parent component.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Left
}
/**
 * BadgeStyle object
 *
 * @interface BadgeStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface BadgeStyle {
    /**
     * Font color.
     *
     * @type { ?ResourceColor }
     * @default Color.White
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    color?: ResourceColor;
    /**
     * Font size.
     * For the string type, only numeric string values with optional units.
     * The value must be greater than or equal to 0. If the value is less than 0, the default value is used.
     * Unit: fp
     *
     * <p><strong>NOTE</strong>:
     * <br>This parameter cannot be set in percentage.
     * </p>
     *
     * @type { ?(number | ResourceStr) }
     * @default 10
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontSize?: number | ResourceStr;
    /**
     * Badge size.
     * For the string type, numeric string values with optional units.
     * The value must be greater than or equal to 0. If the value is less than 0, the default value is used.
     * Unit: vp
     *
     * <p><strong>NOTE</strong>:
     * <br>This parameter cannot be set in percentage.
     * <br>If it is set to an invalid value, the default value is used.
     * </p>
     *
     * @type { ?(number | ResourceStr) }
     * @default 16
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    badgeSize?: number | ResourceStr;
    /**
     * Badge color.
     *
     * @type { ?ResourceColor }
     * @default Color.Red
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    badgeColor?: ResourceColor;
    /**
     * Border color of the background.
     *
     * @type { ?ResourceColor }
     * @default Color.Red
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderColor?: ResourceColor;
    /**
     * Border width of the background.
     * This parameter cannot be set in percentage.
     * Unit: vp
     *
     * @type { ?Length }
     * @default 1
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderWidth?: Length;
    /**
     * Font weight of the text.
     * For the number type, the value ranges from 100 to 900, at an interval of 100. Default value: 400
     * A larger value indicates a heavier font weight.
     * For the string type, only strings that represent a number. Default value: FontWeight.Normal
     *
     * <p><strong>NOTE</strong>:
     * <br>This parameter cannot be set in percentage.
     * </p>
     *
     * @type { ?(number | FontWeight | ResourceStr) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontWeight?: number | FontWeight | ResourceStr;
}
/**
 * Provides basic parameters for creating a badge.
 *
 * @interface BadgeParam
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface BadgeParam {
    /**
     * Position to display the badge relative to the parent component.
     *
     * <p><strong>NOTE</strong>:
     * <br>With the Position type, percentage values are not supported.
     * <br>If an invalid value is set, the default value (0,0),
     * which indicates the upper left corner of the component, will be used.
     * <br>With the BadgePosition type, the position is mirrored based on the Direction property.
     * </p>
     *
     * @type { ?(BadgePosition | Position) }
     * @default BadgePosition.RightTop
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    position?: BadgePosition | Position;
    /**
     * Style of the badge, including the font color, font size, badge color, and badge size.
     *
     * @type { BadgeStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style: BadgeStyle;
}
/**
 * Inherits from BadgeParam and has all attributes of BadgeParam.
 *
 * @extends BadgeParam
 * @interface BadgeParamWithNumber
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface BadgeParamWithNumber extends BadgeParam {
    /**
     * Number of notifications.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value is less than or equal to 0 and less than the value of maxCount, no badge is displayed.
     * <br>Value range: [-2147483648, 2147483647]
     * <br>If the value is out of the range,
     * it will be adjusted by adding or subtracting 4294967296 to bring it back within the range.
     * <br>If the value is not an integer, it is rounded off to the nearest integer.
     * </p>
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    count: number;
    /**
     * Maximum number of notifications. When the maximum number is reached, only maxCount+ is displayed.
     *
     * <p><strong>NOTE</strong>:
     * <br>Value range: [-2147483648, 2147483647]
     * <br>If the value is out of the range,
     * it will be adjusted by adding or subtracting 4294967296 to bring it back within the range.
     * <br>If the value is not an integer, it is rounded off to the nearest integer.
     * </p>
     *
     * @type { ?number }
     * @default 99
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    maxCount?: number;
}
/**
 * Inherits from BadgeParam and has all attributes of BadgeParam.
 *
 * @extends BadgeParam
 * @interface BadgeParamWithString
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface BadgeParamWithString extends BadgeParam {
    /**
     * Prompt content.
     *
     * @type { ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: ResourceStr;
}
export declare interface BadgeAttribute extends CommonMethod {
    attributeModifier(modifier: AttributeModifier<BadgeAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * position: Set the display position of the prompt point.
 * maxCount: Maximum number of messages. If the number of messages exceeds the maximum, only maxCount+ is displayed.
 * count: Set the number of reminder messages.
 * style: You can set the style of the Badge component, including the text color, size, dot color, and size.
 *
 * @param { BadgeParamWithNumber } value
 * @returns { BadgeAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Badge(
    value: BadgeParamWithNumber, 
    @memo
    content_?: () => void,
): BadgeAttribute
/**
 * value: Text string of the prompt content.
 * position: Set the display position of the prompt point.
 * maxCount: Maximum number of messages. If the number of messages exceeds the maximum, only maxCount+ is displayed.
 * style: You can set the style of the Badge component, including the text color, size, dot color, and size.
 *
 * @param { BadgeParamWithString } value
 * @returns { BadgeAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Badge(
    value: BadgeParamWithString, 
    @memo
    content_?: () => void,
): BadgeAttribute