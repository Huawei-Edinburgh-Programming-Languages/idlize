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
import { AsyncCallback } from '../@ohos.base';
import { ConnectOptions } from '../ability/connectOptions';
import ExtensionContext from './ExtensionContext';
import StartOptions from '../@ohos.app.ability.StartOptions';
import Want from '../@ohos.app.ability.Want';
/**
 * The context of service extension. It allows access to
 * serviceExtension-specific resources.
 *
 * @extends ExtensionContext
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @systemapi
 * @stagemodelonly
 * @since 20
 */
declare class ServiceExtensionContext extends ExtensionContext {
    
    
    
    /**
     * Service extension uses this method to start a specific ability. If the caller application is in foreground,
     * you can use this method to start ability; If the caller application is in the background,
     * you need to apply for permission:ohos.permission.START_ABILITIES_FROM_BACKGROUND.
     * If the target ability is visible, you can start the target ability; If the target ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to start target invisible ability.
     * If the target ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     *
     * @param { Want } want - Indicates the ability to start.
     * @param { AsyncCallback<void> } callback - The callback of startAbility.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
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
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    startAbility(want: Want, callback: AsyncCallback<void>): void;
    
    
    
    /**
     * Service extension uses this method to start a specific ability. If the caller application is in foreground,
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
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
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
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    startAbility(want: Want, options: StartOptions, callback: AsyncCallback<void>): void;
    
    
    
    /**
     * Service extension uses this method to start a specific ability. If the caller application is in foreground,
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
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
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
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    startAbility(want: Want, options?: StartOptions): Promise<void>;
    
    
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
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
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
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
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
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
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
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
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
     * Destroys this service extension.
     *
     * @param { AsyncCallback<void> } callback - The callback of terminateSelf.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    terminateSelf(callback: AsyncCallback<void>): void;
    
    /**
     * Destroys this service extension.
     *
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    terminateSelf(): Promise<void>;
    
    /**
     * Connects an ability to a service extension ability.
     * If the target service extension ability is visible, you can connect the target service extension ability;
     * If the target service extension ability is invisible,
     * you need to apply for permission:ohos.permission.START_INVISIBLE_ABILITY to connect target invisible service extension ability.
     * If the target service extension ability is in cross-device, you need to apply for permission:ohos.permission.DISTRIBUTED_DATASYNC.
     * <p>This method can be called by an ability or service extension, but the destination of the connection must be a
     * service extension. You must implement the {@link ConnectOptions} interface to obtain the proxy of the target
     * service extension when the Service extension is connected.</p>
     *
     * @param { Want } want - Indicates the service extension to connect.
     * @param { ConnectOptions } options - Indicates the callback of connection.
     * @returns { long } Returns the connection id.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
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
    connectServiceExtensionAbility(want: Want, options: ConnectOptions): long;
    /**
     * Disconnect an ability from a service extension, in contrast to {@link connectAbility}.
     *
     * @param { long } connection - the connection id returned from connectAbility api.
     * @param { AsyncCallback<void> } callback - The callback of disconnectAbility.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    disconnectServiceExtensionAbility(connection: long, callback: AsyncCallback<void>): void;
    /**
     * Disconnect an ability from a service extension, in contrast to {@link connectAbility}.
     *
     * @param { long } connection - the connection id returned from connectAbility api.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    disconnectServiceExtensionAbility(connection: long): Promise<void>;
}
export default ServiceExtensionContext;
