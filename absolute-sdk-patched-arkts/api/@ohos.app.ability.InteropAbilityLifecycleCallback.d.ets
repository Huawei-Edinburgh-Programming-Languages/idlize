/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License"),
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
import window from './@ohos.window';
/**
 * The callback was called when only an ability is registered for listening.
 *
 * @typedef { function }
 * @param { Any } ability - Indicates the ability to register for listening.
 * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
 * @stagemodelonly
 * @since 21
 */
type AbilityCallbackFn = (ability: Any) => void;
/**
 * The callback was called when both ability and window stage are registered for listening.
 *
 * @typedef { function }
 * @param { Any } ability - Indicates the ability to register for listening.
 * @param { window.WindowStage } windowStage - Indicates the window stage to register for listening.
 * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
 * @stagemodelonly
 * @since 21
 */
type WindowStageCallbackFn = (ability: Any, windowStage: window.WindowStage) => void;
/**
 * The interop ability lifecycle callback.
 *
 * @typedef InteropAbilityLifecycleCallback
 * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
 * @stagemodelonly
 * @since 21
 */
declare interface InteropAbilityLifecycleCallback {
    /**
     * Called back when an ability is started for initialization.
     *
     * @type { AbilityCallbackFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 21
     */
    onAbilityCreate: AbilityCallbackFn;
    /**
     * Called back when a window stage is created.
     *
     * @type { WindowStageCallbackFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 21
     */
    onWindowStageCreate: WindowStageCallbackFn;
    /**
     * Called back when a window stage is destroyed.
     *
     * @type { WindowStageCallbackFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 21
     */
    onWindowStageDestroy: WindowStageCallbackFn;
    /**
     * Called back when an ability is destroyed.
     *
     * @type { AbilityCallbackFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 21
     */
    onAbilityDestroy: AbilityCallbackFn;
    /**
     * Called back when the state of an ability changes to foreground.
     *
     * @type { AbilityCallbackFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 21
     */
    onAbilityForeground: AbilityCallbackFn;
    /**
     * Called back when the state of an ability changes to background.
     *
     * @type { AbilityCallbackFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 21
     */
    onAbilityBackground: AbilityCallbackFn;
}
export default InteropAbilityLifecycleCallback;
