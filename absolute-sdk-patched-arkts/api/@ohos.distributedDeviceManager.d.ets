/*
 * Copyright (c) 2023-2025 Huawei Device Co., Ltd.
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
 * @kit DistributedServiceKit
 */
import type { AsyncCallback, Callback } from './@ohos.base';
/**
 * Providers interfaces to create a {@link deviceManager} instances.
 *
 * @namespace distributedDeviceManager
 * @syscap SystemCapability.DistributedHardware.DeviceManager
 * @since 20
 */
declare namespace distributedDeviceManager {
    /**
     * Basic description information of a distributed device.
     * @interface DeviceBasicInfo
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @since 20
     */
    interface DeviceBasicInfo {
        /**
         * Device identifier. The actual value is udid-hash confused with appid and salt value based on sha256.
         * This id remains unchanged after application installation. If the application is uninstalled and reinstalled,
         * the obtained ID will change.
         * @type { string }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        deviceId: string;
        /**
         * Device name.
         * @type { string }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        deviceName: string;
        /**
         * Obtains the device type represented by a string,
         * which can be {@code phone}, {@code tablet}, {@code tv}, {@code smartVision}, {@code car}.
         * @type { string }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        deviceType: string;
        /**
         * Device network id.
         * @type { ?string }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        networkId?: string;
    }
    /**
     * The state of the nearby devices.
     * @enum { int }
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @since 20
     */
    enum DeviceStateChange {
        /**
         * This state indicates the device is online but the state is unknown,The distributed function cannot used until
         * state changes to AVAILABLE.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        UNKNOWN = 0,
        /**
         * This state indicates the device has been synchronized to the database, Now the distributed function can be used.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        AVAILABLE = 1,
        /**
         * This state indicates the device is offline.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        UNAVAILABLE = 2
    }
    /**
     * Device status change result.
     * @interface DeviceStateChangeResult
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @since 20
     */
    interface DeviceStateChangeResult {
        /**
         * The state of the nearby devices.
         * @type { DeviceStateChange }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        action: DeviceStateChange;
        /**
         * Basic description information of a distributed device.
         * @type { DeviceBasicInfo }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        device: DeviceBasicInfo;
    }
    /**
     * Device name change result.
     * @interface DeviceNameChangeResult
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @since 20
     */
    interface DeviceNameChangeResult {
        /**
         * Device name.
         * @type { string }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        deviceName: string;
    }
    /**
     * Discovery failure result.
     * @interface DiscoveryFailureResult
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @since 20
     */
    interface DiscoveryFailureResult {
        /**
         * Discovery failure cause code.
         * @type { int }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        reason: int;
    }
    /**
     * Discovery successful result.
     * @interface DiscoverySuccessResult
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @since 20
     */
    interface DiscoverySuccessResult {
        /**
         * Basic description information of a distributed device.
         * @type { DeviceBasicInfo }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        device: DeviceBasicInfo;
    }
    /**
     * Reply result.
     * @interface ReplyResult
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @systemapi
     * @since 20
     */
    interface ReplyResult {
        /**
         * Param of ui state changes.
         * @type { string }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @systemapi
         * @since 20
         */
        param: string;
    }
    /**
     * ServiceDie data.
     * @interface ServiceDieData
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @since 20
     */
    interface ServiceDieData {
    }
    /**
     * Service profile information.
     * @interface ServiceProfileInfo
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @systemapi
     * @since 20
     */
    interface ServiceProfileInfo {
        /**
         * Device ID.
         * @type { string }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @systemapi
         * @since 20
         */
        deviceId: string;
    }
    /**
     * Device profile information.
     * @interface DeviceProfileInfo
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @systemapi
     * @since 20
     */
    interface DeviceProfileInfo {
        /**
         * Device ID.
         * @type { string }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @systemapi
         * @since 20
         */
        deviceId: string;
        /**
         * Device type.
         * @type { string }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @systemapi
         * @since 20
         */
        deviceType: string;
        /**
         * Device name.
         * @type { string }
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @systemapi
         * @since 20
         */
        deviceName: string;
    }
    /**
     * Creates an {@code DeviceManager} instance.
     *
     * To manage devices, you must first call this method to obtain a {@code DeviceManager} instance and then
     * use this instance to call other device management methods.
     *
     * @param { string } bundleName - Indicates the bundle name of the application.
     * @returns { DeviceManager } - Return the DeviceManager object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                                  1. Mandatory parameters are left unspecified;
     *                                                  2. Incorrect parameter type;
     *                                                  3. Parameter verification failed.
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @since 20
     */
    function createDeviceManager(bundleName: string): DeviceManager;
    /**
     * Provides methods for managing devices.
     *
     * @interface DeviceManager
     * @syscap SystemCapability.DistributedHardware.DeviceManager
     * @since 20
     */
    interface DeviceManager {
        /**
         * Get the network id of the local device.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @returns { string } - Returns local device network id.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
         * @throws { BusinessError } 11600101 - Failed to execute the function.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        getLocalDeviceNetworkId(): string;
        /**
         * Get the device id of the local device.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @returns { string } - Device identifier. The actual value is udid-hash confused with appid and salt value based on sha256.
         * This id remains unchanged after application installation. If the application is uninstalled and reinstalled,
         * the obtained ID will change.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
         * @throws { BusinessError } 11600101 - Failed to execute the function.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        getLocalDeviceId(): string;
        /**
         * Get the device name by network id.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { string } networkId - Device network id.
         * @returns { string } - Returns device name.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified networkId is greater than 255.
         * @throws { BusinessError } 11600101 - Failed to execute the function.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        getDeviceName(networkId: string): string;
        /**
         * Get the device type by network id.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { string } networkId - Device network id.
         * @returns { int } - Returns device type.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified networkId is greater than 255.
         * @throws { BusinessError } 11600101 - Failed to execute the function.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        getDeviceType(networkId: string): int;
        /**
         * Unbind the specified target.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { string } deviceId - id of device to unbind
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified deviceId is greater than 255.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
         * @throws { BusinessError } 11600101 - Failed to execute the function.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        unbindTarget(deviceId: string): void;
        
        /**
         * Register a device state callback so that the application can be notified upon device state changes based on
         * the application bundle name.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { 'deviceStateChange' } type - Device state change.
         * @param { Callback<DeviceStateChangeResult> } callback
         * Indicates the device state callback to register.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        on(type: 'deviceStateChange', callback: Callback<DeviceStateChangeResult>): void;
        
        /**
         * UnRegister device state callback based on the application bundle name.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { 'deviceStateChange' } type - Device state change.
         * @param { Callback<DeviceStateChangeResult> } [callback]
         * Indicates the device state callback to unregister.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        off(type: 'deviceStateChange', callback?: Callback<DeviceStateChangeResult>): void;
        
        /**
         * Register a device discovery result callback so that the application can be notified when discovery success.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { 'discoverSuccess' } type - Successfully discovered device.
         * @param { Callback<DiscoverySuccessResult> } callback - Indicates the device discovery callback to register.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        on(type: 'discoverSuccess', callback: Callback<DiscoverySuccessResult>): void;
        
        /**
         * UnRegister the device discovery result callback.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { 'discoverSuccess' } type - Successfully discovered device.
         * @param { Callback<DiscoverySuccessResult> } [callback] - Indicates the device discovery callback to unregister.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        off(type: 'discoverSuccess', callback?: Callback<DiscoverySuccessResult>): void;
        
        /**
         * Register a device name change callback so that the application can be notified when discovery success.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { 'deviceNameChange' } type - Changed device name.
         * @param { Callback<DeviceNameChangeResult> } callback - Indicates the device name change callback to register.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        on(type: 'deviceNameChange', callback: Callback<DeviceNameChangeResult>): void;
        
        /**
         * UnRegister the device name change result callback.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { 'deviceNameChange' } type - Changed device name.
         * @param { Callback<DeviceNameChangeResult> } [callback] - Indicates the device name change callback to unregister.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        off(type: 'deviceNameChange', callback?: Callback<DeviceNameChangeResult>): void;
        
        /**
         * Register a device discovery result callback so that the application can be notified when discover failed.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { 'discoverFailure' } type - Discovery Device Failure.
         * @param { Callback<DiscoveryFailureResult> } callback
         * Indicates the device found result callback to register.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        on(type: 'discoverFailure', callback: Callback<DiscoveryFailureResult>): void;
        
        /**
         * UnRegister the device discovery result callback.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { 'discoverFailure' } type - Discovery Device Failure.
         * @param { Callback<DiscoveryFailureResult> } [callback]
         * Indicates the device found result callback to unregister.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        off(type: 'discoverFailure', callback?: Callback<DiscoveryFailureResult>): void;
        
        /**
         * Register a serviceError callback so that the application can be notified when devicemanager service died
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { 'serviceDie' } type - Service death.
         * @param { Callback<ServiceDieData> } [callback] - Indicates the service error callback to register.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        on(type: 'serviceDie', callback?: Callback<ServiceDieData>): void;
        
        /**
         * UnRegister the service error callback.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { 'serviceDie' } type - Service death.
         * @param { Callback<ServiceDieData> } [callback] - Indicates the service error callback to unregister.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @since 20
         */
        off(type: 'serviceDie', callback?: Callback<ServiceDieData>): void;
        
        /**
         * Register a callback from deviceManager service so that the devicemanager ui can be notified when uiStateChanges.
         *
         * @permission ohos.permission.ACCESS_SERVICE_DM
         * @param { 'replyResult' } type - Ui reply result to register.
         * @param { Callback<ReplyResult> } callback - Indicates the devicemanager ui state to register.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @systemapi this method can be used only by system applications.
         * @since 20
         */
        on(type: 'replyResult', callback: Callback<ReplyResult>): void;
        
        /**
         * Unregister uiStateChange, this interface can only be used by devicemanager ui.
         *
         * @permission ohos.permission.ACCESS_SERVICE_DM
         * @param { 'replyResult' } type - Ui reply result to unregister.
         * @param { Callback<ReplyResult> } [callback] - Indicates the devicemanager ui state to unregister.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         *                                                  1. Mandatory parameters are left unspecified;
         *                                                  2. Incorrect parameter type;
         *                                                  3. Parameter verification failed;
         *                                                  4. The size of specified type is greater than 255.
         * @throws { BusinessError } 201 - Permission verification failed.
         *                                 The application does not have the permission required to call the API.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedHardware.DeviceManager
         * @systemapi this method can be used only by system applications.
         * @since 20
         */
        off(type: 'replyResult', callback?: Callback<ReplyResult>): void;
    }
}
export default distributedDeviceManager;
