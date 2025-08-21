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
 * @namespace ble
 * @syscap SystemCapability.Communication.Bluetooth.Core
 * @since 20
 */
declare namespace ble {
    
    
    /**
     * Indicate the profile connection state.
     *
     * @typedef { constant.ProfileConnectionState } ProfileConnectionState
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    type ProfileConnectionState = constant.ProfileConnectionState;
    
    
    /**
     * create a Gatt server instance.
     *
     * @returns { GattServer } Returns a Gatt server instance {@code GattServer}.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function createGattServer(): GattServer;
    
    
    /**
     * create a Gatt client device instance.
     *
     * @param { string } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
     * @returns { GattClientDevice } Returns a Gatt client device instance {@code GattClientDevice}.
     * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function createGattClientDevice(deviceId: string): GattClientDevice;
    
    
    /**
     * Stops BLE scanning.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900001 - Service stopped.
     * @throws { BusinessError } 2900003 - Bluetooth disabled.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function stopBLEScan(): void;
    
    
    /**
     * Stops BLE advertising.
     *
     * @permission ohos.permission.ACCESS_BLUETOOTH
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 2900001 - Service stopped.
     * @throws { BusinessError } 2900003 - Bluetooth disabled.
     * @throws { BusinessError } 2900099 - Operation failed.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function stopAdvertising(): void;
    
    
    /**
     * Manages GATT server. Before calling an Gatt server method, you must use {@link createGattServer} to create an GattServer instance.
     *
     * @typedef GattServer
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface GattServer {
        
        
        /**
         * Closes this {@code GattServer} object and unregisters its callbacks.
         *
         * @permission ohos.permission.ACCESS_BLUETOOTH
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 2900001 - Service stopped.
         * @throws { BusinessError } 2900003 - Bluetooth disabled.
         * @throws { BusinessError } 2900099 - Operation failed.
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        close(): void;
    }
    
    
    /**
     * Manages GATT client. Before calling an Gatt client method, you must use {@link createGattClientDevice} to create an GattClientDevice instance.
     *
     * @typedef GattClientDevice
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface GattClientDevice {
        
        
        /**
         * Connects to a BLE peripheral device.
         * <p>The 'BLEConnectionStateChange' event is subscribed to return the connection state.
         *
         * @permission ohos.permission.ACCESS_BLUETOOTH
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 2900001 - Service stopped.
         * @throws { BusinessError } 2900003 - Bluetooth disabled.
         * @throws { BusinessError } 2900099 - Operation failed.
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        connect(): void;
        
        
        /**
         * Disconnects from or stops an ongoing connection to a BLE peripheral device.
         *
         * @permission ohos.permission.ACCESS_BLUETOOTH
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 2900001 - Service stopped.
         * @throws { BusinessError } 2900003 - Bluetooth disabled.
         * @throws { BusinessError } 2900099 - Operation failed.
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        disconnect(): void;
        
        
        /**
         * Disables a BLE peripheral device.
         * <p> This method unregisters the device and clears the registered callbacks and handles.
         *
         * @permission ohos.permission.ACCESS_BLUETOOTH
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 2900001 - Service stopped.
         * @throws { BusinessError } 2900003 - Bluetooth disabled.
         * @throws { BusinessError } 2900099 - Operation failed.
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        close(): void;
        
        
        /**
         * Set the mtu size of a BLE peripheral device.
         *
         * @permission ohos.permission.ACCESS_BLUETOOTH
         * @param { int } mtu - The maximum transmission unit.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - Invalid parameter. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3. Parameter verification failed.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 2900001 - Service stopped.
         * @throws { BusinessError } 2900099 - Operation failed.
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        setBLEMtuSize(mtu: int): void;
    }
    
    
    /**
     * Describes the Gatt service.
     *
     * @typedef GattService
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface GattService {
        
        
        /**
         * The UUID of a GattService instance
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceUuid: string;
        
        
        /**
         * Indicates whether the GattService instance is primary or secondary.
         *
         * @type { boolean }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        isPrimary: boolean;
        
        
        /**
         * The {@link BLECharacteristic} list belongs to this GattService instance
         *
         * @type { Array<BLECharacteristic> }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        characteristics: Array<BLECharacteristic>;
    }
    
    
    /**
     * Describes the Gatt characteristic.
     *
     * @typedef BLECharacteristic
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface BLECharacteristic {
        
        
        /**
         * The UUID of the {@link GattService} instance to which the characteristic belongs
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceUuid: string;
        
        
        /**
         * The UUID of a BLECharacteristic instance
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        characteristicUuid: string;
        
        
        /**
         * The value of a BLECharacteristic instance
         *
         * @type { ArrayBuffer }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        characteristicValue: ArrayBuffer;
        
        
        /**
         * The list of {@link BLEDescriptor} contained in the characteristic
         *
         * @type { Array<BLEDescriptor> }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        descriptors: Array<BLEDescriptor>;
        
        
        /**
         * The properties of a BLECharacteristic instance
         *
         * @type { ?GattProperties }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        properties?: GattProperties;
    }
    
    
    /**
     * Describes the Gatt descriptor.
     *
     * @typedef BLEDescriptor
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface BLEDescriptor {
        
        
        /**
         * The UUID of the {@link GattService} instance to which the descriptor belongs
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceUuid: string;
        
        
        /**
         * The UUID of the {@link BLECharacteristic} instance to which the descriptor belongs
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        characteristicUuid: string;
        
        
        /**
         * The UUID of the BLEDescriptor instance
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        descriptorUuid: string;
        
        
        /**
         * The value of the BLEDescriptor instance
         *
         * @type { ArrayBuffer }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        descriptorValue: ArrayBuffer;
    }
    
    
    /**
     * Describes the value of the indication or notification sent by the Gatt server.
     *
     * @typedef NotifyCharacteristic
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface NotifyCharacteristic {
        
        
        /**
         * The UUID of the {@link GattService} instance to which the characteristic belongs
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceUuid: string;
        
        
        /**
         * The UUID of a NotifyCharacteristic instance
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        characteristicUuid: string;
        
        
        /**
         * The value of a NotifyCharacteristic instance
         *
         * @type { ArrayBuffer }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        characteristicValue: ArrayBuffer;
        
        /**
         * Specifies whether to request confirmation from the BLE peripheral device (indication) or
         * send a notification. Value {@code true} indicates the former and {@code false} indicates the latter.
         *
         * @type { boolean }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        confirm: boolean;
    }
    
    
    /**
     * Describes the parameters of the Gatt client's characteristic read request.
     *
     * @typedef CharacteristicReadRequest
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface CharacteristicReadRequest {
        
        
        /**
         * Indicates the address of the client that initiates the read request
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId: string;
        
        
        /**
         * The Id of the read request
         *
         * @type { int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        transId: int;
        
        /**
         * Indicates the byte offset of the start position for reading characteristic value
         *
         * @type { int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        offset: int;
        
        
        /**
         * The UUID of a CharacteristicReadRequest instance
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        characteristicUuid: string;
        
        
        /**
         * The UUID of the service to which the characteristic belongs
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceUuid: string;
    }
    
    
    /**
     * Describes the parameters of the of the Gatt client's characteristic write request.
     *
     * @typedef CharacteristicWriteRequest
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface CharacteristicWriteRequest {
        
        
        /**
         * Indicates the address of the client that initiates the write request
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId: string;
        
        
        /**
         * The Id of the write request
         *
         * @type { int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        transId: int;
        
        /**
         * Indicates the byte offset of the start position for writing characteristic value
         *
         * @type { int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        offset: int;
        
        
        /**
         * Indicates the value to be written
         *
         * @type { ArrayBuffer }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        value: ArrayBuffer;
        
        
        /**
         * The UUID of a CharacteristicWriteRequest instance
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        characteristicUuid: string;
        
        
        /**
         * The UUID of the service to which the characteristic belongs
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceUuid: string;
    }
    
    
    /**
     * Describes the parameters of the Gatt client's descriptor read request.
     *
     * @typedef DescriptorReadRequest
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface DescriptorReadRequest {
        
        
        /**
         * Indicates the address of the client that initiates the read request
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId: string;
        
        
        /**
         * The Id of the read request
         *
         * @type { int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        transId: int;
        
        /**
         * Indicates the byte offset of the start position for reading characteristic value
         *
         * @type { int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        offset: int;
        
        
        /**
         * The UUID of a DescriptorReadRequest instance
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        descriptorUuid: string;
        
        
        /**
         * The UUID of the characteristic to which the descriptor belongs
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        characteristicUuid: string;
        
        
        /**
         * The UUID of the service to which the descriptor belongs
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceUuid: string;
    }
    
    
    /**
     * Describes the parameters of the Gatt client's characteristic write request.
     *
     * @typedef DescriptorWriteRequest
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface DescriptorWriteRequest {
        
        
        /**
         * Indicates the address of the client that initiates the write request
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId: string;
        
        
        /**
         * The Id of the write request
         *
         * @type { int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        transId: int;
        
        /**
         * Indicates the byte offset of the start position for writing characteristic value
         *
         * @type { int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        offset: int;
        
        
        /**
         * Indicates the value to be written
         *
         * @type { ArrayBuffer }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        value: ArrayBuffer;
        
        
        /**
         * The UUID of a DescriptorWriteRequest instance
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        descriptorUuid: string;
        
        
        /**
         * The UUID of the characteristic to which the descriptor belongs
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        characteristicUuid: string;
        
        
        /**
         * The UUID of the service to which the descriptor belongs
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceUuid: string;
    }
    
    
    /**
     * Describes the parameters of a response send by the server to a specified read or write request.
     *
     * @typedef ServerResponse
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface ServerResponse {
        
        
        /**
         * Indicates the address of the client to which to send the response
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId: string;
        
        
        /**
         * The Id of the write request
         *
         * @type { int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        transId: int;
        
        
        /**
         * Indicates the status of the read or write request, set this parameter to '0' in normal cases
         *
         * @type { int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        status: int;
        
        /**
         * Indicates the byte offset of the start position for reading or writing operation
         *
         * @type { int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        offset: int;
        
        
        /**
         * Indicates the value to be sent
         *
         * @type { ArrayBuffer }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        value: ArrayBuffer;
    }
    
    
    /**
     * Describes the Gatt profile connection state.
     *
     * @typedef BLEConnectionChangeState
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface BLEConnectionChangeState {
        
        
        /**
         * Indicates the peer device address
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId: string;
        
        
        /**
         * Connection state of the Gatt profile
         *
         * @type { ProfileConnectionState }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        state: ProfileConnectionState;
    }
    
    
    /**
     * Describes the contents of the scan results.
     *
     * @typedef ScanResult
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface ScanResult {
        
        
        /**
         * Address of the scanned device
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId: string;
        
        
        /**
         * The raw data of broadcast packet
         *
         * @type { ArrayBuffer }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        data: ArrayBuffer;
        
        
        /**
         * Connectable of the remote device
         *
         * @type { boolean }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        connectable: boolean;
    }
    
    
    /**
     * Describes the settings for BLE advertising.
     *
     * @typedef AdvertiseSetting
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface AdvertiseSetting {
        
        /**
         * Minimum slot value for the advertising interval, which is {@code 32} (20 ms)
         * Maximum slot value for the advertising interval, which is {@code 16777215} (10485.759375s)
         * Default slot value for the advertising interval, which is {@code 1600} (1s)
         *
         * @type { ?int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        interval?: int;
        
        /**
         * Minimum transmission power level for advertising, which is {@code -127}
         * Maximum transmission power level for advertising, which is {@code 1}
         * Default transmission power level for advertising, which is {@code -7}
         *
         * @type { ?int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        txPower?: int;
        
        
        /**
         * Indicates whether the BLE is connectable, default is {@code true}
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        connectable?: boolean;
    }
    
    
    /**
     * Describes the advertising data.
     *
     * @typedef AdvertiseData
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface AdvertiseData {
        
        
        /**
         * The specified service UUID list to this advertisement
         *
         * @type { Array<string> }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceUuids: Array<string>;
        
        
        /**
         * The specified manufacturer data list to this advertisement
         *
         * @type { Array<ManufactureData> }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        manufactureData: Array<ManufactureData>;
        
        
        /**
         * The specified service data list to this advertisement
         *
         * @type { Array<ServiceData> }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceData: Array<ServiceData>;
    }
    
    /**
     * Describes the advertising parameters.
     *
     * @typedef AdvertisingParams
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface AdvertisingParams {
        
        /**
         * Indicates the advertising settings.
         *
         * @type { AdvertiseSetting }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        advertisingSettings: AdvertiseSetting;
        
        /**
         * Indicates the advertising data.
         *
         * @type { AdvertiseData }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        advertisingData: AdvertiseData;
        
        /**
         * Indicates the advertising response.
         *
         * @type { ?AdvertiseData }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        advertisingResponse?: AdvertiseData;
        /**
         * Indicates the duration for advertising continuously.
         * The duration, in 10ms unit. Valid range is from 1 (10ms) to 65535 (655,350 ms).
         * If this parameter is not specified or is set to 0, advertisement is continuously sent.
         *
         * @type { ?int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        duration?: int;
    }
    
    /**
     * Advertising state change information.
     *
     * @typedef AdvertisingStateChangeInfo
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface AdvertisingStateChangeInfo {
        
        /**
         * Indicates the advertising state.
         *
         * @type { AdvertisingState }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        state: AdvertisingState;
    }
    
    
    /**
     * Describes the manufacturer data.
     *
     * @typedef ManufactureData
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface ManufactureData {
    }
    
    
    /**
     * Describes the service data.
     *
     * @typedef ServiceData
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface ServiceData {
        
        
        /**
         * Indicates the UUID of the service data to add
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceUuid: string;
    }
    
    
    /**
     * Describes the criteria for filtering scanning results can be set.
     *
     * @typedef ScanFilter
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface ScanFilter {
        
        
        /**
         * The address of a BLE peripheral device
         *
         * @type { ?string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId?: string;
        
        
        /**
         * The service UUID of a BLE peripheral device
         *
         * @type { ?string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceUuid?: string;
        
        
        /**
         * Service data.
         *
         * @type { ?ArrayBuffer }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        serviceData?: ArrayBuffer;
        
        
        /**
         * Manufacture data.
         *
         * @type { ?ArrayBuffer }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        manufactureData?: ArrayBuffer;
    }
    
    
    /**
     * Describes the parameters for scan.
     *
     * @typedef ScanOptions
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface ScanOptions {
        
        
        /**
         * Time of delay for reporting the scan result
         *
         * @type { ?int }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        interval?: int;
        
        
        /**
         * Bluetooth LE scan mode
         *
         * @type { ?ScanDuty }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        dutyMode?: ScanDuty;
        
        /**
         * Match mode for Bluetooth LE scan filters hardware match
         *
         * @type { ?MatchMode }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        matchMode?: MatchMode;
    }
    
    
    /**
     * Describes the properties of a gatt characteristic.
     *
     * @typedef GattProperties
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface GattProperties {
        
        
        /**
         * Support write property of the characteristic.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        write?: boolean;
        
        
        /**
         * Support write no response property of the characteristic.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        writeNoResponse?: boolean;
        
        
        /**
         * Support read property of the characteristic.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        read?: boolean;
        
        
        /**
         * Support notify property of the characteristic.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        notify?: boolean;
        
        /**
         * Support indicate property of the characteristic.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        indicate?: boolean;
    }
    
    
    /**
     * The enum of gatt characteristic write type
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    enum GattWriteType {
        
        
        /**
         * Write characteristic with response.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        WRITE = 1,
        
        
        /**
         * Write characteristic without response.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        WRITE_NO_RESPONSE = 2
    }
    
    
    /**
     * The enum of scan duty.
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    enum ScanDuty {
        
        
        /**
         * low power mode
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        SCAN_MODE_LOW_POWER = 0
    }
    
    /**
     * The enum of BLE match mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    enum MatchMode {
        
        /**
         * aggressive mode
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        MATCH_MODE_AGGRESSIVE = 1,
        
        /**
         * sticky mode
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        MATCH_MODE_STICKY = 2
    }
    
    /**
     * The enum of BLE advertising state.
     *
     * @enum { number }
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    enum AdvertisingState {
        
        /**
         * advertising started.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        STARTED = 1,
        /**
         * advertising temporarily enabled.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        ENABLED = 2,
        /**
         * advertising temporarily disabled.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        DISABLED = 3,
        
        /**
         * advertising stopped.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        STOPPED = 4
    }
}
export default ble;
