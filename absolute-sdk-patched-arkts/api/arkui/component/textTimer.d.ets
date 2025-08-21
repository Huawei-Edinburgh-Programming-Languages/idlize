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
import { CommonConfiguration, CommonMethod, ShadowOptions, ContentModifier } from './common';
import { ResourceColor, Length, ResourceStr } from './units';
import { FontStyle, FontWeight } from "./enums";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Provides a way to control the process.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class TextTimerController {
    /**
     * constructor.
     * A constructor used to create a TextTimerController object.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor();
    /**
     * Provides a start event for timer.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    start(): void;
    /**
     * Provides a pause event for timer.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pause(): void;
    /**
     * Provides an event to reset timer.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    reset(): void;
}
/**
 * TextTimerConfiguration used by content modifier.
 *
 * @extends CommonConfiguration<TextTimerConfiguration>
 * @interface TextTimerConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextTimerConfiguration extends CommonConfiguration<TextTimerConfiguration> {
    /**
     * Timer duration, in milliseconds.
     * It is effective only when isCountDown is true.
     * The maximum value is 86400000 ms (24 hours).
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value is between 0 and 86,400,000, it is used as the initial countdown time.
     * <br>Otherwise, the default value is used as the initial countdown time.
     * </p>
     *
     * @type { number }
     * @default 60000
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    count: number;
    /**
     * Whether the timer is a countdown.
     * The value true means that the timer counts down,
     * and false means that the timer counts up.
     *
     * @type { boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isCountDown: boolean;
    /**
     * Whether the timer has already started.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    started: boolean;
    /**
     * Elapsed time of the timer, in the minimum unit of the format.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    elapsedTime: number;
}
/**
 * Parameters of the TextTimer component.
 *
 * @interface TextTimerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface TextTimerOptions {
    /**
     * Whether the timer is a countdown.
     * The value true means that the timer counts down,
     * and false means that the timer counts up.
     *
     * @type { ?boolean } - Default value: false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isCountDown?: boolean;
    /**
     * Timer duration, in milliseconds.
     * It is effective only when isCountDown is true.
     * The maximum value is 86400000 ms (24 hours).
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value is between 0 and 86,400,000, it is used as the initial countdown time.
     * <br>Otherwise, the default value is used as the initial countdown time.
     * </p>
     *
     * @type { ?number } - Default value: 60000
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    count?: number;
    /**
     * TextTimer controller.
     *
     * @type { ?TextTimerController }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    controller?: TextTimerController;
}
export declare interface TextTimerAttribute extends CommonMethod {
    /**
     * Sets the custom format.
     * The value must contain at least one of the following keywords: HH, mm, ss, and SS.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the specified date format is yy, MM, or dd, the default value is used instead.
     * </p>
     *
     * @param { string } value - Custom format.Default value: 'HH:mm:ss.SS'
     * @returns { TextTimerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    format(value: string | undefined): this;
    /**
     * Sets the font color.
     *
     * @param { ResourceColor } value
     * @returns { TextTimerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontColor(value: ResourceColor | undefined): this;
    /**
     * Sets the font size.
     *
     * @param { Length } value - Font size.The default font size is 16 fp.
     * <br>If fontSize is of the number type, the unit fp is used.
     * <br>The value cannot be a percentage.
     * @returns { TextTimerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontSize(value: Length | undefined): this;
    /**
     * Sets the font style.
     *
     * @param { FontStyle } value - Font style.Default value: FontStyle.Normal
     * @returns { TextTimerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontStyle(value: FontStyle | undefined): this;
    /**
     * Sets the font weight.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value is too large, the text may be clipped depending on the font.
     * </p>
     *
     * @param { number | FontWeight | ResourceStr } value - Font weight.
     * <br>For the number type, Value range: [100, 900], at an interval of 100.The default value is 400.
     * <br>A larger value indicates a heavier font weight.
     * <br>For the string type, only strings that represent a number.
     * @returns { TextTimerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontWeight(value: number | FontWeight | ResourceStr | undefined): this;
    /**
     * Sets the font family.
     *
     * @param { ResourceStr } value - Font family. Default font: 'HarmonyOS Sans'
     * @returns { TextTimerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontFamily(value: ResourceStr | undefined): this;
    /**
     * Triggered when the time text changes.
     * This event is not triggered when the screen is locked or the application is running in the background.
     * When high-precision formats (such as SSS or SS) are used, the callback interval may vary.
     *
     * @param { function } event
     * @returns { TextTimerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onTimer(event: ((utc: number, elapsedTime: number) => void) | undefined): this;
    /**
     * Sets the text shadow.
     * It supports input parameters in an array to implement multiple text shadows.
     * This API does not work with the fill attribute or coloring strategy.
     *
     * @param { ShadowOptions | Array<ShadowOptions> } value - The shadow options.
     * @returns { TextTimerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textShadow(value: ShadowOptions | Array<ShadowOptions> | undefined): this;
    /**
     * Creates a content modifier.
     *
     * @param { ContentModifier<TextTimerConfiguration> } modifier - The content modifier of texttimer.
     * @returns { TextTimerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    contentModifier(modifier: ContentModifier<TextTimerConfiguration> | undefined): this;
    attributeModifier(modifier: AttributeModifier<TextTimerAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * A constructor used to create a TextTimerController object.
 *
 * @param { TextTimerOptions } options
 * @returns { TextTimerAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function TextTimer(
    options?: TextTimerOptions, 
    @memo
    content_?: () => void,
): TextTimerAttribute