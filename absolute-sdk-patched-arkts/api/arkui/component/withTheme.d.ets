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
 * @file Defines WithTheme component.
 * @kit ArkUI
 * @arkts 1.2
 */

import { CustomTheme } from '../../@ohos.arkui.theme';
import { ThemeColorMode, AttributeModifier, CommonMethod } from './common';
import { memo, ComponentBuilder } from './../stateManagement/runtime';

/**
 * Defines the struct of WithThemeOptions.
 *
 * @interface WithThemeOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface WithThemeOptions {
  /**
   * Custom Theme.
   *
   * @type { ?CustomTheme }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  theme?: CustomTheme;

  /**
   * Theme Color Mode.
   *
   * @type { ?ThemeColorMode }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  colorMode?: ThemeColorMode;
}

/**
 * Defines the WithTheme attribute functions..
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface WithThemeAttribute {}

/**
 * Defines WithTheme Component
 *
 * @param { WithThemeOptions } options - options of WithTheme.
 * @param { function } [content_] - container
 * @returns { WithThemeAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function WithTheme(
    options: WithThemeOptions, 
    @memo
    content_?: () => void,
): WithThemeAttribute
