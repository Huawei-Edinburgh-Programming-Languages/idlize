'use static';
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

import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
import { Callback } from '../../@ohos.base';

/**
 * Profiler tools for inspectors.
 *
 * @namespace Profiler
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 * @test
 */
export declare namespace Profiler {
    /**
     * Registers vsync callback for profiler.
     * AnonyMous Object Rectification.
     * @param { Callback<string> } callback - the callback info is json string with ui update info.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     * @test
     */
    function registerVsyncCallback(callback: Callback<string>): void;
    /**
     * Unregisters vsync callback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     * @test
     */
    function unregisterVsyncCallback(): void;
}
/**
 * Set app background color.
 *
 * @param { string } value
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 * @test
 */
export declare function setAppBgColor(value: string): void;
