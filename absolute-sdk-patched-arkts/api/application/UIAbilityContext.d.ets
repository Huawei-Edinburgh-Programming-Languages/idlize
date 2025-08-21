/*
 * Copyright (c) 2021-2024 Huawei Device Co., Ltd.
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
import { AsyncCallback } from '../@ohos.base';
import type AbilityStartCallback from './AbilityStartCallback';
import Want from '../@ohos.app.ability.Want';
import StartOptions from '../@ohos.app.ability.StartOptions';
import { Configuration } from '../@ohos.app.ability.Configuration';
import Context from './Context';
import { AbilityResult } from '../ability/abilityResult';
import window from '../@ohos.window';
import { AbilityInfo } from '../bundleManager/AbilityInfo';
import { ConnectOptions } from '../ability/connectOptions';
import { HapModuleInfo } from '../bundleManager/HapModuleInfo';
import OpenLinkOptions from '../@ohos.app.ability.OpenLinkOptions';
import { Caller } from '../@ohos.app.ability.UIAbility';
import type ConfigurationConstant from '../@ohos.app.ability.ConfigurationConstant';
import type AtomicServiceOptions from '../@ohos.app.ability.AtomicServiceOptions';
import image from '../@ohos.multimedia.image';
import { LocalStorage } from '@ohos.arkui.stateManagement';


/**
 * The context of an ability. It allows access to ability-specific resources.
 *
 * @extends Context
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @stagemodelonly
 * @since 20
 */
declare class UIAbilityContext extends Context {
    
    
    /**
     * Indicates configuration information about an ability.
     *
     * @type { AbilityInfo }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    abilityInfo: AbilityInfo;
    
    
    /**
     * Indicates configuration information about the module.
     *
     * @type { HapModuleInfo }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    currentHapModuleInfo: HapModuleInfo;
    
    
    /**
     * Indicates configuration information.
     *
     * @type { Configuration }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    config: Configuration;
    /**
     * Indicates windowStage information.
     * Exists from onWindowStageCreate lifecycle, does not exist from onWindowStageDestroy lifecycle.
     *
     * @type { window.WindowStage }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    windowStage: window.WindowStage;
    
    
    
    
    /**
     * Starts a new ability. If the caller application is in foreground, you can use this method to start ability;
     * If the caller application is in the background, you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
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
     * Starts a new ability. If the caller application is in foreground, you can use this method to start ability;
     * If the caller application is in the background, you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     * If the target ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the ability to start.
     * @param { StartOptions } options - Indicates the start options.
     * @param { AsyncCallback<void> } callback - The callback of startAbility.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 801 - Capability not support.
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
     * @throws { BusinessError } 16000067 - The StartOptions check failed.
     * @throws { BusinessError } 16000068 - The ability is already running.
     * @throws { BusinessError } 16000071 - App clone is not supported.
     * @throws { BusinessError } 16000072 - App clone or multi-instance is not supported.
     * @throws { BusinessError } 16000073 - The app clone index is invalid.
     * @throws { BusinessError } 16000076 - The app instance key is invalid.
     * @throws { BusinessError } 16000077 - The number of app instances reaches the limit.
     * @throws { BusinessError } 16000078 - The multi-instance is not supported.
     * @throws { BusinessError } 16000079 - The APP_INSTANCE_KEY cannot be specified.
     * @throws { BusinessError } 16000080 - Creating a new instance is not supported.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @throws { BusinessError } 16300003 - The target application is not the current application.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbility(want: Want, options: StartOptions, callback: AsyncCallback<void>): void;
    
    
    
    
    
    /**
     * Starts a new ability. If the caller application is in foreground, you can use this method to start ability;
     * If the caller application is in the background, you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     * If the target ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the ability to start.
     * @param { StartOptions } [options] - Indicates the start options.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 801 - Capability not support.
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
     * @throws { BusinessError } 16000067 - The StartOptions check failed.
     * @throws { BusinessError } 16000068 - The ability is already running.
     * @throws { BusinessError } 16000071 - App clone is not supported.
     * @throws { BusinessError } 16000072 - App clone or multi-instance is not supported.
     * @throws { BusinessError } 16000073 - The app clone index is invalid.
     * @throws { BusinessError } 16000076 - The app instance key is invalid.
     * @throws { BusinessError } 16000077 - The number of app instances reaches the limit.
     * @throws { BusinessError } 16000078 - The multi-instance is not supported.
     * @throws { BusinessError } 16000079 - The APP_INSTANCE_KEY cannot be specified.
     * @throws { BusinessError } 16000080 - Creating a new instance is not supported.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @throws { BusinessError } 16300003 - The target application is not the current application.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbility(want: Want, options?: StartOptions): Promise<void>;
    /**
     * Starts a new ability by implicit want. If the caller application is in foreground, you can use this method to start ability;
     * If the caller application is in the background, you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     * If the target ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { string } link - Indicates the ability to start.
     * @param { OpenLinkOptions } [options] - Indicates the open link options.
     * @param { AsyncCallback<AbilityResult> } [callback] - The callback is used to return the ability result.
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
     * @throws { BusinessError } 16000019 - No matching ability is found.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    openLink(link: string, options?: OpenLinkOptions, callback?: AsyncCallback<AbilityResult>): Promise<void>;
    
    
    
    
    /**
     * Get the caller object of the startup capability in cross-device.
     *
     * If the caller application is in foreground, you can use this method to start ability;
     * If the caller application is in the background, you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     * If the target ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @permission ohos.permission.DISTRIBUTED_DATASYNC
     * @param { Want } want - Indicates the ability to start.
     * @returns { Promise<Caller> } Returns the Caller interface.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000018 - Redirection to a third-party application is not allowed in API version greater than 11.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000071 - App clone is not supported.
     * @throws { BusinessError } 16000072 - App clone or multi-instance is not supported.
     * @throws { BusinessError } 16000073 - The app clone index is invalid.
     * @throws { BusinessError } 16000076 - The app instance key is invalid.
     * @throws { BusinessError } 16000077 - The number of app instances reaches the limit.
     * @throws { BusinessError } 16000078 - The multi-instance is not supported.
     * @throws { BusinessError } 16000079 - The APP_INSTANCE_KEY cannot be specified.
     * @throws { BusinessError } 16000080 - Creating a new instance is not supported.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbilityByCall(want: Want): Promise<Caller>;
    
    
    
    
    
    /**
     * Starts an ability and returns the execution result when the ability is destroyed. If the caller application is in foreground,
     * you can use this method to start ability; If the caller application is in the background,
     * you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
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
     * Starts an ability and returns the execution result when the ability is destroyed. If the caller application is in foreground,
     * you can use this method to start ability; If the caller application is in the background,
     * you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
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
     * Starts an ability and returns the execution result when the ability is destroyed. If the caller application is in foreground,
     * you can use this method to start ability; If the caller application is in the background,
     * you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
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
     * Starts a new service extension ability.
     * If the target service extension ability is visible, you can start the target service extension ability;
     * If the target service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible service extension ability.
     * If the target service extension ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the want info to start.
     * @param { AsyncCallback<void> } callback - The callback of startServiceExtensionAbility.
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
    startServiceExtensionAbility(want: Want, callback: AsyncCallback<void>): void;
    
    
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
     * @param { AsyncCallback<void> } callback - The callback of startServiceExtensionAbilityWithAccount.
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
    startServiceExtensionAbilityWithAccount(want: Want, accountId: int, callback: AsyncCallback<void>): void;
    
    
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
     * Stops other service extension ability.
     * If the target service extension ability is visible, you can stop the target service extension ability;
     * If the target service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to stop target invisible service extension ability.
     * If the target service extension ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the want info to start.
     * @param { AsyncCallback<void> } callback - The callback of stopServiceExtensionAbility.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 202 - The application is not system-app, can not use system-api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    stopServiceExtensionAbility(want: Want, callback: AsyncCallback<void>): void;
    
    /**
     * Stops other service extension ability.
     * If the target service extension ability is visible, you can stop the target service extension ability;
     * If the target service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to stop target invisible service extension ability.
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
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    stopServiceExtensionAbility(want: Want): Promise<void>;
    
    /**
     * Stops other service extension ability with account.
     * If the target service extension ability is visible, you can stop the target service extension ability;
     * If the target service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to stop target invisible service extension ability.
     * If the target service extension ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { Want } want - Indicates the want info to start.
     * @param { int } accountId - Indicates the accountId to start.
     * @param { AsyncCallback<void> } callback - The callback of stopServiceExtensionAbilityWithAccount.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 202 - The application is not system-app, can not use system-api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    stopServiceExtensionAbilityWithAccount(want: Want, accountId: int, callback: AsyncCallback<void>): void;
    
    /**
     * Stops other service extension ability with account.
     * If the target service extension ability is visible, you can stop the target service extension ability;
     * If the target service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to stop target invisible service extension ability.
     * If the target service extension ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { Want } want - Indicates the want info to start.
     * @param { int } accountId - Indicates the accountId to start.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 202 - The application is not system-app, can not use system-api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    stopServiceExtensionAbilityWithAccount(want: Want, accountId: int): Promise<void>;
    
    
    /**
     * Destroys this Page ability.
     *
     * @param { AsyncCallback<void> } callback - The callback of terminateSelf.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    terminateSelf(callback: AsyncCallback<void>): void;
    
    
    /**
     * Destroys this Page ability.
     *
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    terminateSelf(): Promise<void>;
    
    
    /**
     * Destroys the Page ability while returning the specified result code and data to the caller.
     *
     * @param { AbilityResult } parameter - Indicates the result to return.
     * @param { AsyncCallback<void> } callback - The callback of terminateSelfWithResult.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    terminateSelfWithResult(parameter: AbilityResult, callback: AsyncCallback<void>): void;
    
    
    /**
     * Destroys the Page ability while returning the specified result code and data to the caller.
     *
     * @param { AbilityResult } parameter - Indicates the result to return.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    terminateSelfWithResult(parameter: AbilityResult): Promise<void>;
    
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
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    connectServiceExtensionAbility(want: Want, options: ConnectOptions): long;
    
    /**
     * Connects the current ability to an service extension ability with account.
     * If the target service extension ability is visible, you can connect the target service extension ability;
     * If the target service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to connect target invisible service extension ability.
     * If the target service extension ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { Want } want - The element name of the service ability
     * @param { int } accountId - The account to connect
     * @param { ConnectOptions } options - The remote object instance
     * @returns { long } Returns the number code of the ability connected
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
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @throws { BusinessError } 16000055 - Installation-free timed out.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    connectServiceExtensionAbilityWithAccount(want: Want, accountId: int, options: ConnectOptions): long;
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
     * Set mission label of current ability.
     *
     * @param { string } label - The label of ability that showed in recent missions.
     * @param { AsyncCallback<void> } callback - The callback of setMissionLabel.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    setMissionLabel(label: string, callback: AsyncCallback<void>): void;
    
    /**
     * Set mission label of current ability.
     *
     * @param { string } label - The label of ability that showed in recent missions.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    setMissionLabel(label: string): Promise<void>;
    
    /**
     * Set mission icon of current ability.
     *
     * @param { image.PixelMap } icon - The icon of ability that showed in recent missions.
     * @param { AsyncCallback<void> } callback - The callback of setMissionIcon.
     * @throws { BusinessError } 202 - The application is not system-app, can not use system-api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    setMissionIcon(icon: image.PixelMap, callback: AsyncCallback<void>): void;
    
    /**
     * Set mission icon of current ability.
     *
     * @param { image.PixelMap } icon - The icon of ability that showed in recent missions.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 202 - The application is not system-app, can not use system-api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    setMissionIcon(icon: image.PixelMap): Promise<void>;
    
    /**
     * Restore window stage data in ability continuation
     *
     * @param { LocalStorage } localStorage - the storage data used to restore window stage
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    restoreWindowStage(localStorage: LocalStorage): void;
    
    /**
     * Check to see ability is in terminating state.
     *
     * @returns { boolean } Returns true when ability is in terminating state, else returns false.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    isTerminating(): boolean;
    
    
    /**
     * Report to system when the ability is drawn completed.
     *
     * @param { AsyncCallback<void> } callback - The callback of startAbility.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    reportDrawnCompleted(callback: AsyncCallback<void>): void;
    
    /**
    * Starts the UIAbility or UIExtensionAbility by type.
    * If the caller application is in the background, it is not allowed to call this interface.
    *
    * @param { string } type - The type of target ability.
    * @param { Record<string, Object> } wantParam - Indicates the want parameter.
    * @param { AbilityStartCallback } abilityStartCallback - Indicates the abilityStartCallback.
    * @param { AsyncCallback<void> } callback - The callback of startAbility.
    * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
    * <br>2.Incorrect parameter types.
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
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAbilityByType(type: string, wantParam: Record<string, Object>, abilityStartCallback: AbilityStartCallback): Promise<void>;
    
    /**
     * Requests the specified foreground application to start the UIExtensionAbility of the corresponding type. The foreground
     * application is specified by bundleName in want.parameters. If bundleName is left unspecified, or if the application
     * specified by bundleName is not running in the foreground or does not exist, the UIExtensionAbility is directly started
     * on the system interface. The UIExtensionAbility to start is determined by the combination of the bundleName, abilityName,
     * and moduleName fields in want, and its type is determined by the ability.want.params.uiExtensionType field in want.parameters.
     * If the target UIExtensionAbility is visible, you can start the target UIExtensionAbility; If the target UIExtensionAbility is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible UIExtensionAbility.
     *
     * @param { Want } pickerWant - Indicates the UIExtensionAbility to start.
     * @param { AsyncCallback<void> } callback - The callback of requestModalUIExtension.
     * @throws { BusinessError } 202 - The application is not system-app, can not use system-api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    requestModalUIExtension(pickerWant: Want, callback: AsyncCallback<void>): void;
    
    /**
     * Requests the specified foreground application to start the UIExtensionAbility of the corresponding type. The foreground
     * application is specified by bundleName in want.parameters. If bundleName is left unspecified, or if the application
     * specified by bundleName is not running in the foreground or does not exist, the UIExtensionAbility is directly started
     * on the system interface. The UIExtensionAbility to start is determined by the combination of the bundleName, abilityName,
     * and moduleName fields in want, and its type is determined by the ability.want.params.uiExtensionType field in want.parameters.
     * If the target UIExtensionAbility is visible, you can start the target UIExtensionAbility; If the target UIExtensionAbility is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible UIExtensionAbility.
     *
     * @param { Want } pickerWant - Indicates the UIExtensionAbility to start.
     * @returns { Promise<void> } The promise returned by the requestModalUIExtension.
     * @throws { BusinessError } 202 - The application is not system-app, can not use system-api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    requestModalUIExtension(pickerWant: Want): Promise<void>;
    /**
     * Full-screen pop-us startup atomic service.
     *
     * @param { string } appId - Globally unique identifier of an application, which is allocated by the cloud.
     * @param { AtomicServiceOptions } [options] - Indicates the atomic service start options.
     * @returns { Promise<AbilityResult> } Returns the result of openAtomicService.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000003 - The specified ID does not exist.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @throws { BusinessError } 16000055 - Installation-free timed out.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    openAtomicService(appId: string, options?: AtomicServiceOptions): Promise<AbilityResult>;
    /**
     * Move current ability to background.
     *
     * @returns { Promise<void> } Returns the result of moveAbilityToBackground.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000061 - Operation not supported.
     * @throws { BusinessError } 16000065 - The API can be called only when the ability is running in the foreground.
     * @throws { BusinessError } 16000066 - An ability cannot switch to the foreground or background in Wukong mode.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    moveAbilityToBackground(): Promise<void>;
    /**
     * Show current ability. The ability needs to be started by UIAbilityContext.startAbility
     * with input parameter options.processMode setting to NEW_PROCESS_ATTACH_TO_STATUS_BAR_ITEM.
     *
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 801 - Capability not support.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000067 - The StartOptions check failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    showAbility(): Promise<void>;
    /**
     * Hide current ability. The ability needs to be started by UIAbilityContext.startAbility
     * with input parameter options.processMode setting to NEW_PROCESS_ATTACH_TO_STATUS_BAR_ITEM.
     *
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 801 - Capability not support.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000067 - The StartOptions check failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    hideAbility(): Promise<void>;
    /**
     * Set label and icon for current ability instance.
     * You need to apply for permission:ohos.permission.SET_ABILITY_INSTANCE_INFO to call this function.
     *
     * @permission ohos.permission.SET_ABILITY_INSTANCE_INFO
     * @param { string } label - The label of ability to be displayed in the Task Center and shortcut bar.
     * @param { image.PixelMap } icon - The icon of ability to be displayed in the Task Center and shortcut bar.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    setAbilityInstanceInfo(label: string, icon: image.PixelMap): Promise<void>;
    /**
     * Revoke delegator.
     *
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 801 - Capability not support.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000065 - The API can be called only when the ability is running in the foreground.
     * @throws { BusinessError } 16000084 - Only DelegatorAbility is allowed to call this API, and only once.
     * @throws { BusinessError } 16000085 - An error occurred during the interaction between the ability and window.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    revokeDelegator(): Promise<void>;
    /**
     * Set colorMode of uiability.
     *
     * @param { ConfigurationConstant.ColorMode } colorMode - Color mode.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    setColorMode(colorMode: ConfigurationConstant.ColorMode): void;
    /**
     * Starts a new app service extension ability.
     * If the target app service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible app service extension ability.
     *
     * @param { Want } want - Indicates the want info to start.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 801 - Capability not supported.
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
     * @throws { BusinessError } 16000200 - The caller is not in the appIdentifierAllowList of the target application.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    startAppServiceExtensionAbility(want: Want): Promise<void>;
    /**
     * Stops an app service extension ability.
     * If the target app service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to stop target invisible app service extension ability.
     *
     * @param { Want } want - Indicates the want info to start.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000200 - The caller is not in the appIdentifierAllowList of the target application.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    stopAppServiceExtensionAbility(want: Want): Promise<void>;
    /**
     * Connects current ability to an app service extension ability.
     * If the target app service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to connect target invisible app service extension ability.
     *
     * @param { Want } want - The element name of the app service ability
     * @param { ConnectOptions } callback - The callback for obtaining the connection result
     * @returns { long } Returns the number code of the ability connected
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000201 - The target service has not been started yet.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    connectAppServiceExtensionAbility(want: Want, callback: ConnectOptions): long;
    /**
     * Disconnect current ability from an app service extension, in contrast to {@link connectAppServiceExtensionAbility}.
     *
     * @param { long } connection - The number code of the ability connected
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    disconnectAppServiceExtensionAbility(connection: long): Promise<void>;
}
export default UIAbilityContext;
