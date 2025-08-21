/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
import type AbilityStartCallback from './application/AbilityStartCallback';
import type { AsyncCallback } from './@ohos.base';
import type uiExtensionHost from './@ohos.uiExtensionHost';
import type uiExtension from './@ohos.arkui.uiExtension';
import { AbilityResult } from './ability/abilityResult';
import { LocalStorage } from '@ohos.arkui.stateManagement';
/**
 * class of ui extension content session.
 *
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @stagemodelonly
 * @since 20
 */
declare class UIExtensionContentSession {
    
    /**
     * Send data from an ui extension to an ui extension component.
     *
     * @param { Record<string, Object> } data - Indicates the data send to ui extension component.
     * @throws { BusinessError } 202 - Not System App. Interface caller is not a system app.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    sendData(data: Record<string, Object>): void;
    /**
     * Sets the callback for the ui extension to receive data from an ui extension component.
     *
     * @param { function } callback - Indicates the receive data callback to set.
     * @throws { BusinessError } 202 - Not System App. Interface caller is not a system app.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    setReceiveDataCallback(callback: (data: Record<string, Object>) => void): void;
    /**
     * Sets the callback with return value for the ui extension to receive data from an ui extension component.
     *
     * @param { function } callback - Indicates the receive data callback to set.
     * @throws { BusinessError } 202 - Not System App. Interface caller is not a system app.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    setReceiveDataForResultCallback(callback: (data: Record<string, Object>) => Record<string, Object>): void;
    /**
     * Loads an UI extension content.
     *
     * @param { string } path - Path of the page to which the content will be loaded
     * @param { LocalStorage } [storage] - The data object shared within the content instance loaded by the page
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    loadContent(path: string, storage?: LocalStorage): void;
    /**
     * Destroys the UI extension.
     *
     * @param { AsyncCallback<void> } callback - The callback of terminateSelf.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    terminateSelf(callback: AsyncCallback<void>): void;
    /**
     * Destroys the UI extension.
     *
     * @returns { Promise<void> } The promise returned by the function.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    terminateSelf(): Promise<void>;
    /**
     * Destroys the UI extension while returning the specified result code and data to the caller.
     *
     * @param { AbilityResult } parameter - Indicates the result to return.
     * @param { AsyncCallback<void> } callback - The callback of terminateSelfWithResult.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    terminateSelfWithResult(parameter: AbilityResult, callback: AsyncCallback<void>): void;
    /**
     * Destroys the UI extension while returning the specified result code and data to the caller.
     *
     * @param { AbilityResult } parameter - Indicates the result to return.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    terminateSelfWithResult(parameter: AbilityResult): Promise<void>;
    /**
     * Sets the background color of the UI extension.
     *
     * @param { string } color - the specified color.
     * @throws { BusinessError } 202 - Not System App. Interface caller is not a system app.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    setWindowBackgroundColor(color: string): void;
    
    /**
     * Starts the UIAbility or UIExtensionAbility by type.
     * If the caller application is in the background, it is not allowed to call this interface.
     *
     * @param { string } type - The type of target ability.
     * @param { Record<string, Object> } wantParam - Indicates the want parameter.
     * @param { AbilityStartCallback } abilityStartCallback - Indicates the abilityStartCallback.
     * @param { AsyncCallback<void> } callback - The callback of startAbility.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbilityByType(type: string, wantParam: Record<string, Object>, abilityStartCallback: AbilityStartCallback, callback: AsyncCallback<void>): void;
    
    /**
     * Starts the UIAbility or UIExtensionAbility by type.
     * If the caller application is in the background, it is not allowed to call this interface.
     *
     * @param { string } type - The type of target ability.
     * @param { Record<string, Object> } wantParam - Indicates the want parameter.
     * @param { AbilityStartCallback } abilityStartCallback - Indicates the abilityStartCallback.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbilityByType(type: string, wantParam: Record<string, Object>, abilityStartCallback: AbilityStartCallback): Promise<void>;
    /**
     * Get the UIExtension Host Window proxy.
     *
     * @returns { uiExtensionHost.UIExtensionHostWindowProxy } Returns the UIExtension Host Window proxy.
     * @throws { BusinessError } 202 - Not System App. Interface caller is not a system app.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    getUIExtensionHostWindowProxy(): uiExtensionHost.UIExtensionHostWindowProxy;
    /**
     * Get the UIExtension Window proxy.
     *
     * @returns { uiExtension.WindowProxy } Returns the UIExtension Window proxy.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    getUIExtensionWindowProxy(): uiExtension.WindowProxy;
}
export default UIExtensionContentSession;
