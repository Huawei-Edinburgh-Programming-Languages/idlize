/*
 * Copyright (c) 2022-2024 Huawei Device Co., Ltd.
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
 * @kit AbilityKit
 */
import contextConstant from "./@ohos.app.ability.contextConstant";
import image from "./@ohos.multimedia.image";
import bundleManager from './@ohos.bundle.bundleManager';

/**
 * StartOptions is the basic communication component of the system.
 *
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @stagemodelonly
 * @since 20
 */
export default class StartOptions {
    /**
     * The type of {@link ohos.app.ability.AbilityConstant#WindowMode}
     * {@link ohos.app.ability.AbilityConstant#WindowMode.WINDOW_MODE_SPLIT_PRIMARY} and
     * {@link ohos.app.ability.AbilityConstant#WindowMode.WINDOW_MODE_SPLIT_SECONDARY} are
     * valid only in intra-app redirection scenarios.
     *
     * @type { ?int }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    windowMode?: int;
    
    /**
     * The type of displayId
     *
     * @type { ?long }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    displayId?: long;
    /**
     * The target ability with animation or without
     *
     * @type { ?boolean }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    withAnimation?: boolean;
    /**
     * The left position of window rectangle
     *
     * @type { ?int }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    windowLeft?: int;
    /**
     * The top position of window rectangle
     *
     * @type { ?int }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    windowTop?: int;
    /**
     * The width of window rectangle
     *
     * @type { ?int }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    windowWidth?: int;
    /**
     * The height of window rectangle
     *
     * @type { ?int }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    windowHeight?: int;
    /**
     * Indicates the cold startup window is focused.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    windowFocused?: boolean;
    /**
     * The process mode.
     * This property only takes effect when calling UIAbilityContext.startAbility.
     * The properties processMode and startupVisibility must be set simultaneously.
     *
     * @type { ?contextConstant.ProcessMode }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    processMode?: contextConstant.ProcessMode;
    /**
     * The ability visibility after the new process startup.
     * This property only takes effect when calling UIAbilityContext.startAbility.
     * The properties processMode and startupVisibility must be set simultaneously.
     *
     * @type { ?contextConstant.StartupVisibility }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startupVisibility?: contextConstant.StartupVisibility;
    /**
     * The start window Icon.
     *
     * @type { ?image.PixelMap }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startWindowIcon?: image.PixelMap;
    /**
     * The start window backgroundColor.
     *
     * @type { ?string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startWindowBackgroundColor?: string;
    /**
     * The support window modes.
     *
     * @type { ?Array<bundleManager.SupportWindowMode> }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    supportWindowModes?: Array<bundleManager.SupportWindowMode>;
    /**
     * The min width of window rectangle.
     *
     * @type { ?int }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    minWindowWidth?: int;
    /**
     * The min height of window rectangle.
     *
     * @type { ?int }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    minWindowHeight?: int;
    /**
     * The max width of window rectangle.
     *
     * @type { ?int }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    maxWindowWidth?: int;
    /**
     * The max height of window rectangle.
     *
     * @type { ?int }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    maxWindowHeight?: int;
}
