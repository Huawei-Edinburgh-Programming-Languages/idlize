/*
 * Copyright (C) 2023-2024 Huawei Device Co., Ltd.
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
 * @kit ConnectivityKit
 */
import type { AsyncCallback, Callback } from './@ohos.base';
import type constant from './@ohos.bluetooth.constant';


/**
 * Provides methods to operate or manage Bluetooth.
 *
 * @namespace connection
 * @syscap SystemCapability.Communication.Bluetooth.Core
 * @since 20
 */
declare namespace connection {
    
    /**
     * Indicate the major class of a bluetooth device.
     *
     * @typedef { constant.MajorClass } MajorClass
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    type MajorClass = constant.MajorClass;
    
    /**
     * Indicate the major minor class of a bluetooth device.
     *
     * @typedef { constant.MajorMinorClass } MajorMinorClass
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    type MajorMinorClass = constant.MajorMinorClass;
    
    
    /**
     * Obtains the name of a peer Bluetooth device.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { string } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
     * @returns { string } Returns the device name in character string format.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900001 - Service stopped.
     * @throws { BusinessError } 2900003 - Bluetooth disabled.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function getRemoteDeviceName(deviceId: string): string;
    /**
     * Obtains the name or alias of the Bluetooth peer device.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { string } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
     * @param { boolean } [alias] - Indicates whether to obtain the device alias. If the parameter is not provided, the device alias is obtained by default.
     * @returns { string } Returns the device name in character string format.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * 2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900001 - Service stopped.
     * @throws { BusinessError } 2900003 - Bluetooth disabled.
     * @throws { BusinessError } 2900099 - Failed to obtain the name or alias of the peer Bluetooth device.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function getRemoteDeviceName(deviceId: string, alias?: boolean): string;
    
    
    /**
     * Obtains the class of a peer Bluetooth device.
     *
     * @param { string } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
     * @returns { DeviceClass } The class of the remote device.
     * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900001 - Service stopped.
     * @throws { BusinessError } 2900003 - Bluetooth disabled.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function getRemoteDeviceClass(deviceId: string): DeviceClass;
    
    
    /**
     * Obtains the list of Bluetooth devices that have been paired with the current device.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @returns { Array<string> } Returns a list of paired Bluetooth devices's address.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900001 - Service stopped.
     * @throws { BusinessError } 2900003 - Bluetooth disabled.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function getPairedDevices(): Array<string>;
    /**
     * Sets the Bluetooth scan mode for a device.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { ScanMode } mode - Indicates the Bluetooth scan mode to set.
     * @param { int } duration - Indicates the duration in seconds, in which the host is discoverable.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900001 - Service stopped.
     * @throws { BusinessError } 2900003 - Bluetooth disabled.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function setBluetoothScanMode(mode: ScanMode, duration: int): void;
    
    /**
     * Obtains the product ID of a remote device.
     *
     * @param { string } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
     * @returns { string } Returns the remote device's product ID.
     * @throws { BusinessError } 202 - Non-system applications are not allowed to use system APIs.
     * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900001 - Service stopped.
     * @throws { BusinessError } 2900003 - Bluetooth disabled.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @systemapi
     * @since 20
     */
    function getRemoteProductId(deviceId: string): string;
    
    
    /**
     * Subscribe the event reported when a remote Bluetooth device is discovered.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { 'bluetoothDeviceFind' } type - Type of the discovering event to listen for.
     * @param { Callback<Array<string>> } callback - Callback used to listen for the discovering event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function on(type: 'bluetoothDeviceFind', callback: Callback<Array<string>>): void;
    
    
    /**
     * Unsubscribe the event reported when a remote Bluetooth device is discovered.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { 'bluetoothDeviceFind' } type - Type of the discovering event to listen for.
     * @param { Callback<Array<string>> } callback - Callback used to listen for the discovering event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function off(type: 'bluetoothDeviceFind', callback?: Callback<Array<string>>): void;
    
    /**
     * Subscribe the event reported when a remote Bluetooth device is discovered.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { 'discoveryResult' } type - Type of the discovering event to listen for.
     * @param { Callback<Array<DiscoveryResult>> } callback - Callback used to listen for the discovering event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function on(type: 'discoveryResult', callback: Callback<Array<DiscoveryResult>>): void;
    
    /**
     * Unsubscribe the event reported when a remote Bluetooth device is discovered.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { 'discoveryResult' } type - Type of the discovering event to listen for.
     * @param { Callback<Array<DiscoveryResult>> } callback - Callback used to listen for the discovering event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function off(type: 'discoveryResult', callback?: Callback<Array<DiscoveryResult>>): void;
    
    /**
     * Subscribe the event reported when a remote Bluetooth device is bonded.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { 'bondStateChange' } type - Type of the bond state event to listen for.
     * @param { Callback<BondStateParam> } callback - Callback used to listen for the bond state event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function on(type: 'bondStateChange', callback: Callback<BondStateParam>): void;
    
    /**
     * Unsubscribe the event reported when a remote Bluetooth device is bonded.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { 'bondStateChange' } type - Type of the bond state event to listen for.
     * @param { Callback<BondStateParam> } callback - Callback used to listen for the bond state event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function off(type: 'bondStateChange', callback?: Callback<BondStateParam>): void;
    /**
     * Subscribe the event of a pairing request from a remote Bluetooth device.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { 'pinRequired' } type - Type of the pairing request event to listen for.
     * @param { Callback<PinRequiredParam> } callback - Callback used to listen for the pairing request event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function on(type: 'pinRequired', callback: Callback<PinRequiredParam>): void;
    /**
     * Unsubscribe the event of a pairing request from a remote Bluetooth device.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { 'pinRequired' } type - Type of the pairing request event to listen for.
     * @param { Callback<PinRequiredParam> } callback - Callback used to listen for the pairing request event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function off(type: 'pinRequired', callback?: Callback<PinRequiredParam>): void;
    /**
     * Subscribe the event of battery state changed from a remote device.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { 'batteryChange' } type - Type of the battery event to listen for.
     * @param { Callback<BatteryInfo> } callback - Callback used to listen.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function on(type: 'batteryChange', callback: Callback<BatteryInfo>): void;
    /**
     * Unsubscribe the event of battery state changed from a remote device.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @param { 'batteryChange' } type - Type of the battery event to listen for.
     * @param { Callback<BatteryInfo> } callback - Callback used to listen.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function off(type: 'batteryChange', callback?: Callback<BatteryInfo>): void;
    
    /**
     * Describes the class of a bluetooth device.
     *
     * @typedef BondStateParam
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface BondStateParam {
        
        /**
         * Address of a Bluetooth device.
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId: string;
        
        /**
         * Profile connection state of the device.
         *
         * @type { BondState }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        state: BondState;
    }
    /**
     * Describes the bond key param.
     *
     * @typedef PinRequiredParam
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface PinRequiredParam {
        /**
         * ID of the device to pair.
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId: string;
    }
    
    /**
     * Describes the class of a bluetooth device.
     *
     * @typedef DeviceClass
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface DeviceClass {
        
        /**
         * Major classes of Bluetooth devices.
         *
         * @type { MajorClass }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        majorClass: MajorClass;
        
        /**
         * Major and minor classes of Bluetooth devices.
         *
         * @type { MajorMinorClass }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        majorMinorClass: MajorMinorClass;
    }
    
    /**
     * The enum of BR scan mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    enum ScanMode {
        
        /**
         * Indicates the scan mode is connectable and general discoverable
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        SCAN_MODE_CONNECTABLE_GENERAL_DISCOVERABLE = 4
    }
    
    
    /**
     * The enum of bond state.
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    enum BondState {
        
        
        /**
         * Indicate the bond state is bonded
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        BOND_STATE_BONDED = 2
    }
    
    /**
     * Describes the contents of the discovery results
     *
     * @typedef DiscoveryResult
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface DiscoveryResult {
        
        /**
         * Identify of the discovery device
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId: string;
    }
    /**
     * Describes the contents of the battery information.
     *
     * @typedef BatteryInfo
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface BatteryInfo {
        /**
         * Identify of the discovery device.
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @systemapi
         * @since 20
         */
        deviceId: string;
    }
}
export default connection;
