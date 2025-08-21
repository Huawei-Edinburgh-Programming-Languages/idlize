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
import { CommonConfiguration, CommonMethod, ShadowOptions, ContentModifier, Optional, DateTimeOptions } from './common';
import { ResourceColor, Length, ResourceStr } from './units';
import { FontStyle, FontWeight } from "./enums";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Provides a way to control the textclock status.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class TextClockController {
    /**
     * constructor.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor();
    /**
     * Provides a start event for textclock.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    start(): void;
    /**
     * Provides a stop event for textclock.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stop(): void;
}
/**
 * TextClockConfiguration used by text clock content modifier
 *
 * @extends CommonConfiguration<TextClockConfiguration>
 * @interface TextClockConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextClockConfiguration extends CommonConfiguration<TextClockConfiguration> {
    /**
     * Specifies the current time zone.
     * The valid value is an integer ranging from - 14 to 12,
     * Where a negative value indicates the eastern time zone, for example, -8.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    timeZoneOffset: number;
    /**
     * TextClock is started or not.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    started: boolean;
    /**
     * The time of the TextClock.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    timeValue: number;
}
/**
 * Options to construct TextClock component.
 *
 * @interface TextClockOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextClockOptions {
    /**
     * Time zone offset.
     * Anonymous Object Rectification.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    timeZoneOffset?: number;
    /**
     * TextClock controller.
     * Anonymous Object Rectification.
     *
     * @type { ?TextClockController }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    controller?: TextClockController;
}
export declare interface TextClockAttribute extends CommonMethod {
    /**
     * set display time format,such as "yyyy/mm/dd","yyyy-mm-dd".
     * support time format：yyyy,mm,mmm(English month abbreviation),mmmm(Full name of the month in English),
     * dd,ddd(English Week abbreviation),dddd(Full name of the week in English),
     * HH/hh(24-hour clock/12-hour clock),MM/mm(minute),SS/ss(second).
     * The default value is "hh:mm:ss" when TextClock is not in a form.
     * The default value is "hh:mm" when TextClock is in a form.
     * If the value has second or millisecond, the value will be set to the default value.
     *
     * @param { ResourceStr } value
     * @returns { TextClockAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    format(value: ResourceStr | undefined): this;
    /**
     * Provides a date change callback.
     * The callback parameter is Unix Time Stamp,
     * The number of milliseconds that have elapsed since January 1, 1970 (UTC).
     * The minimum callback interval for this event default is seconds when TextClock is not in a form.
     * The minimum callback interval for this event is minutes when TextClock is in a form.
     * If visibility is Hidden the callback be disabled when TextClock is in a form.
     * You can listen to this callback,
     * Use the format attribute method to customize data display in the callback.
     *
     * @param { function } event - Listening date event callback.
     * @returns { TextClockAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDateChange(event: ((value: number) => void) | undefined): this;
    /**
     * Called when the value of TextClock fontColor is set
     *
     * @param { ResourceColor } value
     * @returns { TextClockAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontColor(value: ResourceColor | undefined): this;
    /**
     * Called when the value of TextClock fontSize is set
     *
     * @param { Length } value
     * @returns { TextClockAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontSize(value: Length | undefined): this;
    /**
     * Called when the value of TextClock fontStyle is set
     *
     * @param { FontStyle } value
     * @returns { TextClockAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontStyle(value: FontStyle | undefined): this;
    /**
     * Called when the value of TextClock fontWeight is set
     *
     * @param { number | FontWeight | string } value
     * @returns { TextClockAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontWeight(value: number | FontWeight | string | undefined): this;
    /**
     * Called when the value of TextClock fontFamily is set
     *
     * @param { ResourceStr } value
     * @returns { TextClockAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontFamily(value: ResourceStr | undefined): this;
    /**
     * Called when the text shadow is set.
     *
     * @param { ShadowOptions | Array<ShadowOptions> } value - The shadow options.
     * @returns { TextClockAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textShadow(value: ShadowOptions | Array<ShadowOptions> | undefined): this;
    /**
     * Called when the text fontFeature is set.
     *
     * @param { string } value - The fontFeature.
     * normal | <feature-tag-value>,
     * where <feature-tag-value> = <string> [ <integer> | on | off ], like: "ss01" 0
     * number of <feature-tag-value> can be single or multiple, and separated by comma ','.
     * @returns { TextClockAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontFeature(value: string | undefined): this;
    /**
     * Set the content modifier of textclock.
     *
     * @param { ContentModifier<TextClockConfiguration> } modifier - The content modifier of textclock.
     * @returns { TextClockAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    contentModifier(modifier: ContentModifier<TextClockConfiguration> | undefined): this;
    /**
     * Set hour format
     *
     * @param { Optional<DateTimeOptions> } dateTimeOptions - Indicates whether a leading 0 is required for the hour.
     * @returns { TextClockAttribute } the attribute of the text clock
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    dateTimeOptions(dateTimeOptions: DateTimeOptions | undefined): this;
    attributeModifier(modifier: AttributeModifier<TextClockAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Construct the text clock component.
 * Specifies the current time zone.
 * The valid value is an integer ranging from - 14 to 12,
 * Where a negative value indicates the eastern time zone, for example, -8.
 * Anonymous Object Rectification.
 *
 * @param { TextClockOptions } [options] - TextClock options.
 * @returns { TextClockAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function TextClock(
    options?: TextClockOptions, 
    @memo
    content_?: () => void,
): TextClockAttribute