/*
 * Copyright (c) 2023-2024 Huawei Device Co., Ltd.
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
import { ConnectOptions } from '../ability/connectOptions';
import { AbilityResult } from '../ability/abilityResult';
import type ConfigurationConstant from '../@ohos.app.ability.ConfigurationConstant';
import type { AsyncCallback } from '../@ohos.base';
import ExtensionContext from './ExtensionContext';
import type Want from '../@ohos.app.ability.Want';
import type StartOptions from '../@ohos.app.ability.StartOptions';
/**
 * The context of UI extension. It allows access to UIExtension-specific resources.
 *
 * @extends ExtensionContext
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @stagemodelonly
 * @since 20
 */
declare class UIExtensionContext extends ExtensionContext {
    
    
    /**
     * UI extension uses this method to start a specific ability.If the caller application is in foreground,
     * you can use this method to start ability; If the caller application is in the background,
     * you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     * If the target ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the ability to start.
     * @param { AsyncCallback<void> } callback - The callback of startAbility.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000010 - The call with the continuation and prepare continuation flag is forbidden.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000018 - Redirection to a third-party application is not allowed in API version greater than 11.
     * @throws { BusinessError } 16000019 - No matching ability is found.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @throws { BusinessError } 16000055 - Installation-free timed out.
     * @throws { BusinessError } 16000069 - The extension cannot start the third party application.
     * @throws { BusinessError } 16000070 - The extension cannot start the service.
     * @throws { BusinessError } 16000071 - App clone is not supported.
     * @throws { BusinessError } 16000072 - App clone or multi-instance is not supported.
     * @throws { BusinessError } 16000073 - The app clone index is invalid.
     * @throws { BusinessError } 16000076 - The app instance key is invalid.
     * @throws { BusinessError } 16000077 - The number of app instances reaches the limit.
     * @throws { BusinessError } 16000078 - The multi-instance is not supported.
     * @throws { BusinessError } 16000079 - The APP_INSTANCE_KEY cannot be specified.
     * @throws { BusinessError } 16000080 - Creating a new instance is not supported.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbility(want: Want, callback: AsyncCallback<void>): void;
    
    
    /**
     * UI extension uses this method to start a specific ability.If the caller application is in foreground,
     * you can use this method to start ability; If the caller application is in the background,
     * you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     * If the target ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the ability to start.
     * @param { StartOptions } options - Indicates the start options.
     * @param { AsyncCallback<void> } callback - The callback of startAbility.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000018 - Redirection to a third-party application is not allowed in API version greater than 11.
     * @throws { BusinessError } 16000019 - No matching ability is found.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @throws { BusinessError } 16000055 - Installation-free timed out.
     * @throws { BusinessError } 16000069 - The extension cannot start the third party application.
     * @throws { BusinessError } 16000070 - The extension cannot start the service.
     * @throws { BusinessError } 16000071 - App clone is not supported.
     * @throws { BusinessError } 16000072 - App clone or multi-instance is not supported.
     * @throws { BusinessError } 16000073 - The app clone index is invalid.
     * @throws { BusinessError } 16000076 - The app instance key is invalid.
     * @throws { BusinessError } 16000077 - The number of app instances reaches the limit.
     * @throws { BusinessError } 16000078 - The multi-instance is not supported.
     * @throws { BusinessError } 16000079 - The APP_INSTANCE_KEY cannot be specified.
     * @throws { BusinessError } 16000080 - Creating a new instance is not supported.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbility(want: Want, options: StartOptions, callback: AsyncCallback<void>): void;
    
    
    /**
     * UI extension uses this method to start a specific ability.If the caller application is in foreground,
     * you can use this method to start ability; If the caller application is in the background,
     * you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     * If the target ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the ability to start.
     * @param { StartOptions } [options] - Indicates the start options.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000010 - The call with the continuation and prepare continuation flag is forbidden.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000018 - Redirection to a third-party application is not allowed in API version greater than 11.
     * @throws { BusinessError } 16000019 - No matching ability is found.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @throws { BusinessError } 16000055 - Installation-free timed out.
     * @throws { BusinessError } 16000069 - The extension cannot start the third party application.
     * @throws { BusinessError } 16000070 - The extension cannot start the service.
     * @throws { BusinessError } 16000071 - App clone is not supported.
     * @throws { BusinessError } 16000072 - App clone or multi-instance is not supported.
     * @throws { BusinessError } 16000073 - The app clone index is invalid.
     * @throws { BusinessError } 16000076 - The app instance key is invalid.
     * @throws { BusinessError } 16000077 - The number of app instances reaches the limit.
     * @throws { BusinessError } 16000078 - The multi-instance is not supported.
     * @throws { BusinessError } 16000079 - The APP_INSTANCE_KEY cannot be specified.
     * @throws { BusinessError } 16000080 - Creating a new instance is not supported.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbility(want: Want, options?: StartOptions): Promise<void>;
    
    
    /**
     * Starts an ability and returns the execution result when the ability is destroyed.
     * If the caller application is in foreground, you can use this method to start ability; If the caller application
     * is in the background, you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     * If the target ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the ability to start.
     * @param { AsyncCallback<AbilityResult> } callback - The callback is used to return the result of startAbility.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000010 - The call with the continuation and prepare continuation flag is forbidden.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000018 - Redirection to a third-party application is not allowed in API version greater than 11.
     * @throws { BusinessError } 16000019 - No matching ability is found.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @throws { BusinessError } 16000055 - Installation-free timed out.
     * @throws { BusinessError } 16000069 - The extension cannot start the third party application.
     * @throws { BusinessError } 16000070 - The extension cannot start the service.
     * @throws { BusinessError } 16000071 - App clone is not supported.
     * @throws { BusinessError } 16000072 - App clone or multi-instance is not supported.
     * @throws { BusinessError } 16000073 - The app clone index is invalid.
     * @throws { BusinessError } 16000076 - The app instance key is invalid.
     * @throws { BusinessError } 16000077 - The number of app instances reaches the limit.
     * @throws { BusinessError } 16000078 - The multi-instance is not supported.
     * @throws { BusinessError } 16000079 - The APP_INSTANCE_KEY cannot be specified.
     * @throws { BusinessError } 16000080 - Creating a new instance is not supported.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbilityForResult(want: Want, callback: AsyncCallback<AbilityResult>): void;
    
    
    /**
     * Starts an ability and returns the execution result when the ability is destroyed.
     * If the caller application is in foreground, you can use this method to start ability; If the caller application
     * is in the background, you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     * If the target ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the ability to start.
     * @param { StartOptions } options - Indicates the start options.
     * @param { AsyncCallback<AbilityResult> } callback - The callback is used to return the result of startAbility.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000018 - Redirection to a third-party application is not allowed in API version greater than 11.
     * @throws { BusinessError } 16000019 - No matching ability is found.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @throws { BusinessError } 16000055 - Installation-free timed out.
     * @throws { BusinessError } 16000069 - The extension cannot start the third party application.
     * @throws { BusinessError } 16000070 - The extension cannot start the service.
     * @throws { BusinessError } 16000071 - App clone is not supported.
     * @throws { BusinessError } 16000072 - App clone or multi-instance is not supported.
     * @throws { BusinessError } 16000073 - The app clone index is invalid.
     * @throws { BusinessError } 16000076 - The app instance key is invalid.
     * @throws { BusinessError } 16000077 - The number of app instances reaches the limit.
     * @throws { BusinessError } 16000078 - The multi-instance is not supported.
     * @throws { BusinessError } 16000079 - The APP_INSTANCE_KEY cannot be specified.
     * @throws { BusinessError } 16000080 - Creating a new instance is not supported.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbilityForResult(want: Want, options: StartOptions, callback: AsyncCallback<AbilityResult>): void;
    
    
    /**
     * Starts an ability and returns the execution result when the ability is destroyed.
     * If the caller application is in foreground, you can use this method to start ability; If the caller application
     * is in the background, you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     * If the target ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the ability to start.
     * @param { StartOptions } [options] - Indicates the start options.
     * @returns { Promise<AbilityResult> } Returns the result of startAbility.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000010 - The call with the continuation and prepare continuation flag is forbidden.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000018 - Redirection to a third-party application is not allowed in API version greater than 11.
     * @throws { BusinessError } 16000019 - No matching ability is found.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @throws { BusinessError } 16000055 - Installation-free timed out.
     * @throws { BusinessError } 16000069 - The extension cannot start the third party application.
     * @throws { BusinessError } 16000070 - The extension cannot start the service.
     * @throws { BusinessError } 16000071 - App clone is not supported.
     * @throws { BusinessError } 16000072 - App clone or multi-instance is not supported.
     * @throws { BusinessError } 16000073 - The app clone index is invalid.
     * @throws { BusinessError } 16000076 - The app instance key is invalid.
     * @throws { BusinessError } 16000077 - The number of app instances reaches the limit.
     * @throws { BusinessError } 16000078 - The multi-instance is not supported.
     * @throws { BusinessError } 16000079 - The APP_INSTANCE_KEY cannot be specified.
     * @throws { BusinessError } 16000080 - Creating a new instance is not supported.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbilityForResult(want: Want, options?: StartOptions): Promise<AbilityResult>;
    
    /**
     * Starts a new ability using the original caller information, and returns the execution result when the ability
     * is destroyed.
     * If the caller application is in foreground, you can use this method to start ability; If the caller application
     * is in the background, you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     *
     * @param { Want } want - Indicates the ability to start.
     * @param { StartOptions } [options] - Indicates the start options.
     * @returns { Promise<AbilityResult> } Returns the result of startAbility.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 202 - Not System App. Interface caller is not a system app.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000069 - The extension cannot start the third party application.
     * @throws { BusinessError } 16000070 - The extension cannot start the service.
     * @throws { BusinessError } 16000071 - App clone is not supported.
     * @throws { BusinessError } 16000072 - App clone or multi-instance is not supported.
     * @throws { BusinessError } 16000073 - The app clone index is invalid.
     * @throws { BusinessError } 16000076 - The app instance key is invalid.
     * @throws { BusinessError } 16000077 - The number of app instances reaches the limit.
     * @throws { BusinessError } 16000078 - The multi-instance is not supported.
     * @throws { BusinessError } 16000079 - The APP_INSTANCE_KEY cannot be specified.
     * @throws { BusinessError } 16000080 - Creating a new instance is not supported.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    startAbilityForResultAsCaller(want: Want, options?: StartOptions): Promise<AbilityResult>;
    /**
     * Connects the current ability to an service extension ability.
     * If the target service extension ability is visible, you can connect the target service extension ability;
     * If the target service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to connect target invisible service extension ability.
     * If the target service extension ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - The element name of the service ability
     * @param { ConnectOptions } options - The remote object instance
     * @returns { long } Returns the number code of the ability connected
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @throws { BusinessError } 16000055 - Installation-free timed out.
     * @throws { BusinessError } 16000070 - The extension cannot start the service.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    connectServiceExtensionAbility(want: Want, options: ConnectOptions): long;
    /**
     * Disconnect an ability from a service extension, in contrast to {@link connectAbility}.
     *
     * @param { long } connection - The number code of the ability connected
     * @param { AsyncCallback<void> } callback - The callback of disconnectAbility.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    disconnectServiceExtensionAbility(connection: long, callback: AsyncCallback<void>): void;
    /**
     * Disconnect an ability from a service extension, in contrast to {@link connectAbility}.
     *
     * @param { long } connection - The number code of the ability connected
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    disconnectServiceExtensionAbility(connection: long): Promise<void>;
    /**
     * Report to system when the extension is drawn completed.
     *
     * @param { AsyncCallback<void> } callback - The callback of startUIExtensionAbility.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    reportDrawnCompleted(callback: AsyncCallback<void>): void;
    /**
     * Destroys the UI extension.
     *
     * @param { AsyncCallback<void> } callback - The callback of terminateSelf.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
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
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
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
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    terminateSelfWithResult(parameter: AbilityResult): Promise<void>;
    /**
     * Starts a new service extension ability.
     * If the target service extension ability is visible, you can start the target service extension ability;
     * If the target service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible service extension ability.
     * If the target service extension ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the want info to start.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 202 - The application is not system-app, can not use system-api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000019 - No matching ability is found.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    startServiceExtensionAbility(want: Want): Promise<void>;
    /**
     * Starts a new service extension ability with account.
     * If the target service extension ability is visible, you can start the target service extension ability;
     * If the target service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible service extension ability.
     * If the target service extension ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { Want } want - Indicates the want info to start.
     * @param { int } accountId - Indicates the account to start.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 202 - The application is not system-app, can not use system-api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000019 - No matching ability is found.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    startServiceExtensionAbilityWithAccount(want: Want, accountId: int): Promise<void>;
    /**
     * Set the uiextension to either not allow being covered by the host page or allow it.
     *
     * @param { boolean } isForbidden - Indicates the bool value of uiextension can be covered by host page.
     *                                  True indicates not allowing.
     *                                  False indicates allowing.
     * @throws { BusinessError } 202 - The application is not system-app, can not use system-api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    setHostPageOverlayForbidden(isForbidden: boolean): void;
    /**
     * Set colorMode of uiextension.
     *
     * @param { ConfigurationConstant.ColorMode } colorMode - Color mode.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    setColorMode(colorMode: ConfigurationConstant.ColorMode): void;
}
export default UIExtensionContext;
