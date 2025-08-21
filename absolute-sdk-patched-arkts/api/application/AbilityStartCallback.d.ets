/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
import { AbilityResult } from '../ability/abilityResult';
/**
 * Defines a onResult function.
 *
 * @typedef { function } OnResultFn
 * @param { AbilityResult } parameter - The Parameter returned if the UIExtensionAbility call terminateSelfWithResult.
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
type OnResultFn = (parameter: AbilityResult) => void;
/**
 * The callback of UIAbility or UIExtensionAbility.
 *
 * @typedef AbilityStartCallback
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @stagemodelonly
 * @since 20
 */
declare interface AbilityStartCallback {
    /**
     * Called when some error occurred except disconnected from UIAbility or UIExtensionAbility.
     *
     * @param { number } code - The code returned if the UIAbility or UIExtensionAbility failed to start.
     * @param { string } name - The name returned if the UIAbility or UIExtensionAbility failed to start.
     * @param { string } message - The message returned if the UIAbility or UIExtensionAbility failed to start.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    onError(code: number, name: string, message: string): void;
    /**
     * Called when UIExtensionAbility terminate with result.
     *
     * @type { ?OnResultFn }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    onResult?: OnResultFn;
}
export default AbilityStartCallback;
