/*
 * Copyright (c) 2022-2024 Huawei Device Co., Ltd.
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
import { AsyncCallback } from './@ohos.base';
import { ElementName } from './bundleManager/ElementName';
import { AbilityRunningInfo as _AbilityRunningInfo } from './application/AbilityRunningInfo';
import { ExtensionRunningInfo as _ExtensionRunningInfo } from './application/ExtensionRunningInfo';
import Context from './application/Context';
import _AbilityForegroundStateObserver from './application/AbilityForegroundStateObserver';
import _AbilityStateData from './application/AbilityStateData';

/**
 * The class of an ability manager.
 *
 * @namespace abilityManager
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
declare namespace abilityManager {
    /**
     * Enum for the ability state.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    export enum AbilityState {
        /**
         * Ability is initialized.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @since 20
         */
        INITIAL = 0,
        /**
         * Ability is in the state of getting focus.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @since 20
         */
        FOCUS = 2,
        /**
         * Ability is in the foreground state.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @since 20
         */
        FOREGROUND = 9,
        /**
         * Ability is in the background state.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @since 20
         */
        BACKGROUND = 10,
        /**
         * Ability is in the process of scheduling at the foreground.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @since 20
         */
        FOREGROUNDING = 11,
        /**
         * Ability is in the process of scheduling in the background.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @since 20
         */
        BACKGROUNDING = 12
    }
    /**
     * Enum for the user status.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    export enum UserStatus {
        /**
         * Indicates the status of the operation that the user clicks to terminate.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        ASSERT_TERMINATE = 0,
        /**
         * Indicates the status of the operation that the user clicks to continue.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        ASSERT_CONTINUE = 1,
        /**
         * Indicates the status of the operation that the user clicks to retry.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        ASSERT_RETRY = 2
    }
    /**
     * Register Ability foreground or background state observer.
     *
     * @permission ohos.permission.RUNNING_STATE_OBSERVER
     * @param { 'abilityForegroundState' } type - ability foreground or background state.
     * @param { AbilityForegroundStateObserver } observer - The ability foreground state observer.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function on(type: 'abilityForegroundState', observer: AbilityForegroundStateObserver): void;
    /**
     * Unregister Ability foreground or background state observer.
     *
     * @permission ohos.permission.RUNNING_STATE_OBSERVER
     * @param { 'abilityForegroundState' } type - ability foreground or background state.
     * @param { AbilityForegroundStateObserver } [observer] - The ability foreground state observer.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function off(type: 'abilityForegroundState', observer?: AbilityForegroundStateObserver): void;
    /**
     * If you apply for permission, you can obtain information about all abilities. If you do not apply, you can only
     * obtain information about the current ability.
     *
     * @permission ohos.permission.GET_RUNNING_INFO
     * @returns { Promise<Array<AbilityRunningInfo>> } Returns the array of AbilityRunningInfo.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function getAbilityRunningInfos(): Promise<Array<AbilityRunningInfo>>;
    /**
     * If you apply for permission, you can obtain information about all abilities. If you do not apply, you can only
     * obtain information about the current ability.
     *
     * @permission ohos.permission.GET_RUNNING_INFO
     * @param { AsyncCallback<Array<AbilityRunningInfo>> } callback - The callback is used to return the array of
     *                                                                AbilityRunningInfo.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getAbilityRunningInfos(callback: AsyncCallback<Array<AbilityRunningInfo>>): void;
    /**
     * Get the top ability information of the display.
     *
     * @returns { Promise<ElementName> } Returns the elementName info of the top ability.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getTopAbility(): Promise<ElementName>;
    /**
     * Get the top ability information of the display.
     *
     * @param { AsyncCallback<ElementName> } callback - The callback is used to return elementName info of top ability.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getTopAbility(callback: AsyncCallback<ElementName>): void;
    /**
     * Get the foreground ui abilities.
     *
     * @permission ohos.permission.GET_RUNNING_INFO
     * @param { AsyncCallback<Array<AbilityStateData>> } callback - The callback is used to return the list of AbilityStateDatas.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getForegroundUIAbilities(callback: AsyncCallback<Array<AbilityStateData>>): void;
    /**
     * Get the foreground ui abilities.
     *
     * @permission ohos.permission.GET_RUNNING_INFO
     * @returns { Promise<Array<AbilityStateData>> } Returns the list of AbilityStateDatas.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getForegroundUIAbilities(): Promise<Array<AbilityStateData>>;
    /**
     * Querying whether to allow embedded startup of atomic service.
     *
     * @param { Context } context - The context that initiates the query request.
     * @param { string } appId - Globally unique identifier of an application, which is allocated by the cloud.
     * @returns { Promise<boolean> } Returns the result in the form of callback.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @StageModelOnly
     * @since 20
     */
    function isEmbeddedOpenAllowed(context: Context, appId: string): Promise<boolean>;
    /**
     * The class of an ability running information.
     *
     * @typedef { _AbilityRunningInfo }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    export type AbilityRunningInfo = _AbilityRunningInfo;
    /**
     * The ability state data.
     *
     * @typedef { _AbilityStateData }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    export type AbilityStateData = _AbilityStateData;
    /**
     * The class of an extension running information.
     *
     * @typedef { _ExtensionRunningInfo }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    export type ExtensionRunningInfo = _ExtensionRunningInfo;
    /**
     * The ability foreground state observer.
     *
     * @typedef { _AbilityForegroundStateObserver }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    export type AbilityForegroundStateObserver = _AbilityForegroundStateObserver;
}
export default abilityManager;
