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

import { CommonMethod } from './common';
import { memo, ComponentBuilder } from './../stateManagement/runtime';

/**
 * ItemState
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ItemState {
  /**
   * Default State
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  Normal,

  /**
   * Disabled State
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  Disabled,

  /**
   * Waiting State
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  Waiting,

  /**
   * Skip State
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  Skip
}

/**
 * Defines the stepper item attribute functions.
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface StepperItemAttribute extends CommonMethod {
  /**
   * Called when the value of stepperItem prevLabel is set
   *
   * @param { string | undefined } value
   * @returns { StepperItemAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  prevLabel(value: string | undefined): this;

  /**
   * Called when the value of stepperItem nextLabel is set
   *
   * @param { string | undefined } value
   * @returns { StepperItemAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  nextLabel(value: string | undefined): this;

  /**
   * Called when the value of stepperItem status is set
   *
   * @param { ItemState | undefined } value
   * @returns { StepperItemAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  status(value?: ItemState | undefined): this;
}

@memo
@ComponentBuilder
export declare function StepperItem(

  @memo
  content_?: () => void,
): StepperItemAttribute
