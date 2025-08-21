/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
import { CommonMethod, Optional } from './common';
import { ColorMetrics, LengthMetrics } from './units';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Defines the LinearIndicator Controller.
 *
 * @interface LinearIndicatorController
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class LinearIndicatorController {
    /**
     * constructor.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor();
    /**
     * Sets the progress of indicator.
     *
     * @param { number } index - the index of current indicator,  value range: [0, count - 1].
     * If index value is out of range, do nothing.
     * @param { number } progress - current indicator progress value, value range: [0, 100].
     * If the progress value is out of range, do nothing.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setProgress(index: number, progress: number): void;
    /**
     * Start indicator auto play.
     *
     * @param { LinearIndicatorStartOptions } [options] - the options of indicator auto play.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    start(options?: LinearIndicatorStartOptions): void;
    /**
     * Pause indicator auto play.
     * Start auto play will be resumed from this paused position.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pause(): void;
    /**
     * Stop indicator auto play.
     * Start auto play will restart from the very beginning.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stop(): void;
}
/**
 * Provides options of indicator auto play.
 *
 * @interface LinearIndicatorAutoPlayOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LinearIndicatorStartOptions {
    /**
     * The interval between twice auto play. The unit is ms.
     *
     * @type { ?number }
     * @default The default value is 0. if value is less than 0, the value will be 0.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    interval?: number;
    /**
     * The animation curve duration. The unit is ms.
     *
     * @type { ?number }
     * @default 4000
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    duration?: number;
}
/**
 * Provides linear indicator style.
 *
 * @interface LinearIndicatorStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LinearIndicatorStyle {
    /**
     * The space of two linear indicator.
     *
     * @type { ?LengthMetrics }
     * @default The default value is 4.0vp. if value is less than 0, the value will be 4.0vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    space?: LengthMetrics;
    /**
     * Stroke width of the progress indicator.
     *
     * @type { ?LengthMetrics }
     * @default The default value is 2.0vp. if value is less than 0, the value will be 2.0vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    strokeWidth?: LengthMetrics;
    /**
     * The stroke radius of linear indicator.
     *
     * @type { ?LengthMetrics }
     * @default The default value is 1.0vp. if value is more than strokeWidth/2, the value will be strokeWidth/2.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    strokeRadius?: LengthMetrics;
    /**
     * The track background color of linear indicator.
     *
     * @type { ?ColorMetrics }
     * @default comp_background_tertiary
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    trackBackgroundColor?: ColorMetrics;
    /**
     * The track color of linear indicator.
     *
     * @type { ?ColorMetrics }
     * @default comp_background_emphasize
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    trackColor?: ColorMetrics;
}
export declare interface LinearIndicatorAttribute extends CommonMethod {
    /**
     * Sets the indicator style.
     *
     * @param { Optional<LinearIndicatorStyle> } style - the style of LinearIndicator
     * @returns { LinearIndicatorAttribute } return the instance of the LinearIndicatorAttribute
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    indicatorStyle(style: LinearIndicatorStyle | undefined): this;
    /**
     * Sets whether indicator supports loop, default is true.
     *
     * @param { Optional<boolean> } loop - indicate whether loop playback is supported
     * @returns { LinearIndicatorAttribute } return the instance of the LinearIndicatorAttribute
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    indicatorLoop(loop: boolean | undefined): this;
    /**
     * Called when progress value update.
     *
     * @param { Optional<OnLinearIndicatorChangeCallback> } callback - callback of the progress change event.
     * @returns { LinearIndicatorAttribute } return the instance of the LinearIndicatorAttribute
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onChange(callback: OnLinearIndicatorChangeCallback | undefined): this;
    attributeModifier(modifier: AttributeModifier<LinearIndicatorAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Defines the callback type used in  the indicator progress change event.
 *
 * @typedef { function } OnLinearIndicatorChangeCallback
 * @param { number } index - index of current indicator.
 * @param { number } progress - current indicator progress value.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnLinearIndicatorChangeCallback = (index: number, progress: number) => void;
/**
 * Constructor parameters
 *
 * @param { number } count - the number of progress in LinearIndicator. minimum value is 2(default is 5).
 * if count is less than 2, the value will be 2.
 * @param { LinearIndicatorController } controller - Controller of LinearIndicator.
 * @returns { LinearIndicatorAttribute } return the instance of the LinearIndicatorAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function LinearIndicator(
    count?: number, controller?: LinearIndicatorController, 
    @memo
    content_?: () => void,
): LinearIndicatorAttribute