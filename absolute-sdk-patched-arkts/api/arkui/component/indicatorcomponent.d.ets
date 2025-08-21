'use static'
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

import { CommonMethod, Callback } from './common';
import { DotIndicator, DigitIndicator } from './swiper';
import { memo, ComponentBuilder } from './../stateManagement/runtime';

/**
 * Provides methods for switching components.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class IndicatorComponentController {
  /**
   * constructor.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor();

  /**
   * Called when the next child component is displayed.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  showNext(): void;

  /**
   * Called when the previous subcomponent is displayed.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  showPrevious(): void;

  /**
   * Controlling IndicatorComponent to change to the specified subcomponent.
   *
   * @param { number } index - The index of item to be redirected.
   * @param { boolean } [useAnimation] - If true, swipe to index item with animation. If false, swipe to index item without animation.
   *      The default value is false.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  changeIndex(index: number, useAnimation?: boolean): void;
}

/**
 * Defines the IndicatorComponent attribute functions.
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface IndicatorComponentAttribute extends CommonMethod {
  /**
   * Called when the index value of the displayed subcomponent is set in the container.
   *
   * @param { number | undefined } index
   * @returns { IndicatorComponentAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  initialIndex(index: number | undefined): this;

  /**
   * Sets the total number of indicator.
   *
   * @param { number | undefined } totalCount
   * @returns { IndicatorComponentAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  count(totalCount: number | undefined): this;

  /**
   * Sets the indicator style.
   *
   * @param { DotIndicator | DigitIndicator | undefined } indicatorStyle - the style value
   * @returns { IndicatorComponentAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  style(indicatorStyle: DotIndicator | DigitIndicator | undefined): this;

  /**
   * Called when setting whether to turn on cyclic sliding.
   *
   * @param { boolean | undefined } isLoop
   * @returns { IndicatorComponentAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  loop(isLoop: boolean | undefined): this;

  /**
   * Called when setting whether to slide vertically.
   *
   * @param { boolean | undefined } isVertical
   * @returns { IndicatorComponentAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  vertical(isVertical: boolean | undefined): this;

  /**
   * Called when the index value changes.
   *
   * @param { Callback<number> | undefined } event
   * @returns { IndicatorComponentAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onChange(event: Callback<number> | undefined): this;
}

@memo
@ComponentBuilder
export declare function IndicatorComponent(
  controller?: IndicatorComponentController,
  @memo
  content_?: () => void,
): IndicatorComponentAttribute
