/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
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
import AbilityConstant from './@ohos.app.ability.AbilityConstant';
import AbilityStageContext from './application/AbilityStageContext';
import Want from './@ohos.app.ability.Want';
import { Configuration } from './@ohos.app.ability.Configuration';


/**
 * AbilityStage is a runtime class for HAP files.
 * AbilityStage notifies you of when you can perform HAP initialization such as resource pre-loading and thread
 * creation during the HAP loading.
 *
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @stagemodelonly
 * @since 20
 */
declare class AbilityStage {
    
    
    /**
     * Defines the context of AbilityStage.
     * The context is obtained in the callback invoked when initialization is performed during ability startup.
     *
     * @type { AbilityStageContext }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    context: AbilityStageContext;
    
    
    /**
     * Called when the application is created.
     *
     * <p>**NOTE**:
     * <br>This API returns the result synchronously and does not support asynchronous callbacks.
     * </p>
     *
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    onCreate(): void;
    
    /**
     * Called when a specified ability is started.
     *
     * <p>**NOTE**:
     * <br>This API returns the result synchronously and does not support asynchronous callbacks.
     * </p>
     *
     * @param { Want } want - Want information about the target ability, such as the ability name and bundle name.
     * @returns { string } Ability ID. If the ability with this ID has been started, no new instance is created and the
     * ability is placed at the top of the stack. Otherwise, a new instance is created and started.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    onAcceptWant(want: Want): string;
    /**
    * Called back asynchronously upon starting specified ability.
    *
    * @param { Want } want - Indicates the want info of the started ability.
    * @returns { Promise<string> }  The user returns an ability string ID. If the ability of this ID has been started before,
    *         do not create a new instance and pull it back to the top of the stack.
    *         Otherwise, create a new instance and start it.
    * @syscap SystemCapability.Ability.AbilityRuntime.Core
    * @stagemodelonly
    * @since 20
    */
    onAcceptWantAsync(want: Want): Promise<string>;
    
    /**
     * Called when UIAbility or configured with the isolationProcess field UIExtensionAbility in the specified process is started.
     *
     * <p>**NOTE**:
     * <br>This API returns the result synchronously and does not support asynchronous callbacks.
     * </p>
     *
     * @param { Want } want - Want information about the target ability, such as the ability name and bundle name.
     * @returns { string } Custom process identifier. If the process with this identifier has been created, the ability
     * runs in the process. Otherwise, a new process is created and the ability runs in it.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    onNewProcessRequest(want: Want): string;
    /**
    * Called back asynchronously upon starting UIAbility or UIExtensionAbility in specified process.
    *
    * @param { Want } want - Indicates the want info of the started ability.
    * @returns { Promise<string> }  The user returns an ability string ID. If the ability of this ID has been started before,
    *         let the ability run in this process. Otherwise, create a new process.
    * @syscap SystemCapability.Ability.AbilityRuntime.Core
    * @stagemodelonly
    * @since 20
    */
    onNewProcessRequestAsync(want: Want): Promise<string>;
    
    
    /**
     * Called when the global configuration is updated.
     *
     * <p>**NOTE**:
     * <br>This API returns the result synchronously and does not support asynchronous callbacks.
     * </p>
     *
     * @param { Configuration } newConfig - Callback invoked when the global configuration is updated. The global
     * configuration indicates the configuration of the environment where the application is running and includes
     * the language and color mode.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    onConfigurationUpdate(newConfig: Configuration): void;
    /**
     * Called when the application is destroyed. This API is called during the normal lifecycle.
     * If the application exits abnormally or is terminated, this API is not called.
     *
     * <p>**NOTE**:
     * <br>This API returns the result synchronously and does not support asynchronous callbacks.
     * </p>
     *
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    onDestroy(): void;
}
export default AbilityStage;
