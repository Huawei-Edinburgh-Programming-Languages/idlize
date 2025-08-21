/*
 * Copyright (C) 2022-2023 Huawei Device Co., Ltd.
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
import { AsyncCallback, Callback } from './@ohos.base';


/**
 * Provides methods to operate or manage Wi-Fi.
 * @namespace wifiManager
 * @syscap SystemCapability.Communication.WiFi.STA
 * @since 20
 */
declare namespace wifiManager {
    /**
     * Enable Wi-Fi.
     * @permission ohos.permission.SET_WIFI_INFO and (ohos.permission.MANAGE_WIFI_CONNECTION or
     *  ohos.permission.MANAGE_ENTERPRISE_WIFI_CONNECTION)
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @throws {BusinessError} 2501003 - Operation failed because the service is being closed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function enableWifi(): void;
    /**
     * Disable Wi-Fi.
     * @permission ohos.permission.SET_WIFI_INFO and (ohos.permission.MANAGE_WIFI_CONNECTION or ohos.permission.MANAGE_ENTERPRISE_WIFI_CONNECTION)
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @throws {BusinessError} 2501004 - Operation failed because the service is being opened.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function disableWifi(): void;
    /**
     * Enable semi - Wifi.
     * @permission ohos.permission.SET_WIFI_INFO and ohos.permission.MANAGE_WIFI_CONNECTION
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @throws {BusinessError} 2501004 - Operation failed because the service is being opened.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function enableSemiWifi(): void;
    
    
    
    /**
     * Query the Wi-Fi status
     * @returns { boolean } Returns {@code true} if the Wi-Fi is active, returns {@code false} otherwise.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function isWifiActive(): boolean;
    /**
     * Obtains information about a Wi-Fi detail state.
     * @permission ohos.permission.GET_WIFI_INFO and ohos.permission.MANAGE_WIFI_CONNECTION
     * @returns { WifiDetailState } Returns information about wifi state.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getWifiDetailState(): WifiDetailState;
    
    /**
     * Obtain the scanned station list. If does't have the permission of ohos.permission.GET_WIFI_PEERS_MAC, return random bssid.
     * @permission ohos.permission.GET_WIFI_INFO
     * @returns { Array<WifiScanInfo> } Returns information about scanned Wi-Fi hotspot if any.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function getScanInfoList(): Array<WifiScanInfo>;
    /**
     * Calculate the Wi-Fi signal level based on the Wi-Fi RSSI and frequency band.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { int } rssi - Indicates the Wi-Fi RSSI.
     * @param { int } band - Indicates the Wi-Fi frequency band.
     * @returns { int } Returns Wi-Fi signal level ranging from 0 to 4.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function getSignalLevel(rssi: int, band: int): int;
    
    /**
     * Obtain connection information about the Wi-Fi connection. If does't have the permission of ohos.permission.GET_WIFI_PEERS_MAC, return random bssid.
     * @permission ohos.permission.GET_WIFI_INFO
     * @returns { Promise<WifiLinkedInfo> } Returns Wi-Fi linked information.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @throws {BusinessError} 2501001 - Wi-Fi STA disabled.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function getLinkedInfo(): Promise<WifiLinkedInfo>;
    
    /**
     * Obtain connection information about the Wi-Fi connection.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { AsyncCallback<WifiLinkedInfo> } callback - Indicates callback of function.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @throws {BusinessError} 2501001 - Wi-Fi STA disabled.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function getLinkedInfo(callback: AsyncCallback<WifiLinkedInfo>): void;
    /**
     * Obtain connection information about the Wi-Fi connection.this apireturns the result syncchronously.
     * If does't have the permission of ohos.permission.GET_WIFI_PEERS_MAC, return random bssid.
     * @permission ohos.permission.GET_WIFI_INFO
     * @returns { WifiLinkedInfo } Returns Wi-Fi linked information.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @throws {BusinessError} 2501001 - Wi-Fi STA disabled.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function getLinkedInfoSync(): WifiLinkedInfo;
    
    /**
     * Check whether the Wi-Fi connection has been set up.
     * @permission ohos.permission.GET_WIFI_INFO
     * @returns { boolean } Returns {@code true} if a Wi-Fi connection has been set up, returns {@code false} otherwise.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function isConnected(): boolean;
    /**
     * Obtain the IPv4 information of the Wi-Fi connection.
     * The IP information includes the host IP address, gateway address, and DNS information.
     * @permission ohos.permission.GET_WIFI_INFO
     * @returns { IpInfo } Returns the IP information of the Wi-Fi connection.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function getIpInfo(): IpInfo;
    /**
     * Obtain the IPv6 information of the Wi-Fi connection.
     * The IPv6 information includes the host IP address, gateway address, and DNS information.
     * @permission ohos.permission.GET_WIFI_INFO
     * @returns { Ipv6Info } Returns the IPv6 information of the Wi-Fi connection.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function getIpv6Info(): Ipv6Info;
    /**
     * Whether the hotspot is metered hotspot or not.
     * @permission ohos.permission.GET_WIFI_INFO
     * @returns { boolean } Returns {@code true} if the hotspot is metered hotspot, returns {@code false} otherwise.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @throws {BusinessError} 2501001 - Wi-Fi STA disabled.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function isMeteredHotspot(): boolean;
    /**
     * Check whether Wi-Fi hotspot is can be operated under some situation. When the airplane mode is turned on
     * and does not support the coexistence of softap and sta, nor does it support signal bridge,
     * the hotspot switch cannot be operated.
     * @permission ohos.permission.GET_WIFI_INFO and ohos.permission.MANAGE_WIFI_HOTSPOT
     * @returns { boolean } {@code true} if Wi-Fi hotspot can be operated, returns {@code false} otherwise.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2601000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.AP.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function isOpenSoftApAllowed(): boolean;
    
    /**
     * Obtain the list of stations that are connected to the Wi-Fi hotspot.
     * This method can only be used on a device that serves as a Wi-Fi hotspot.
     * @permission ohos.permission.GET_WIFI_INFO and ohos.permission.MANAGE_WIFI_HOTSPOT
     * @returns { Array<StationInfo> } the list of clients that are connected to the Wi-Fi hotspot.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2601000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.AP.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getStations(): Array<StationInfo>;
    
    /**
     * Subscribe Wi-Fi status change events.
     * When the service exits, call off(type: 'wifiStateChange', callback?: Callback&lt;number&gt;) to unregister the callback registered.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'wifiStateChange' } type - event name.
     * @param { Callback<int> } callback - the callback of on, 0: inactive, 1: active, 2: activating, 3: de-activating
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function on(type: 'wifiStateChange', callback: Callback<int>): void;
    
    /**
     * Unsubscribe Wi-Fi status change events.
     *
     * <p>All callback functions will be deregistered If there is no specific callback parameter.</p>
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'wifiStateChange' } type - event name.
     * @param { Callback<int> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function off(type: 'wifiStateChange', callback?: Callback<int>): void;
    
    /**
     * Subscribe Wi-Fi connection change events.
     * When the service exits, call off(type: 'wifiConnectionChange', callback?: Callback&lt;number&gt;) to unregister the callback registered.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'wifiConnectionChange' } type - event name.
     * @param { Callback<int> } callback - the callback of on, 0: disconnected, 1: connected
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function on(type: 'wifiConnectionChange', callback: Callback<int>): void;
    
    /**
     * Unsubscribe Wi-Fi connection change events.
     * All callback functions will be deregistered If there is no specific callback parameter.</p>
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'wifiConnectionChange' } type - event name.
     * @param { Callback<int> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function off(type: 'wifiConnectionChange', callback?: Callback<int>): void;
    
    /**
     * Subscribe Wi-Fi scan status change events.
     * When the service exits, call off(type: 'wifiScanStateChange', callback?: Callback&lt;number&gt;) to unregister the callback registered.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'wifiScanStateChange' } type - event name.
     * @param { Callback<int> } callback - the callback of on, 0: scan fail, 1: scan success
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function on(type: 'wifiScanStateChange', callback: Callback<int>): void;
    
    /**
     * Unsubscribe Wi-Fi scan status change events.
     * All callback functions will be deregistered If there is no specific callback parameter.</p>
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'wifiScanStateChange' } type - event name.
     * @param { Callback<int> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function off(type: 'wifiScanStateChange', callback?: Callback<int>): void;
    /**
     * Subscribe Wi-Fi rssi change events.
     * When the service exits, call off(type: 'wifiRssiChange', callback?: Callback&lt;number&gt;) to unregister the callback registered.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'wifiRssiChange' } type - event name.
     * @param { Callback<int> } callback - the callback of on
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function on(type: 'wifiRssiChange', callback: Callback<int>): void;
    /**
     * Unsubscribe Wi-Fi rssi change events.
     * All callback functions will be deregistered If there is no specific callback parameter.</p>
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'wifiRssiChange' } type - event name.
     * @param { Callback<int> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    function off(type: 'wifiRssiChange', callback?: Callback<int>): void;
    /**
     * Subscribe Wi-Fi stream change events.
     * @permission ohos.permission.MANAGE_WIFI_CONNECTION
     * @param { 'streamChange' } type - event name.
     * @param { Callback<int> } callback - the callback of on, 1: stream down, 2: stream up, 3: stream bidirectional
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'streamChange', callback: Callback<int>): void;
    /**
     * Unsubscribe Wi-Fi stream change events.
     * All callback functions will be deregistered If there is no specific callback parameter.</p>
     * @permission ohos.permission.MANAGE_WIFI_CONNECTION
     * @param { 'streamChange' } type - event name.
     * @param { Callback<int> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'streamChange', callback?: Callback<int>): void;
    /**
     * Subscribe Wi-Fi device config change events.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'deviceConfigChange' } type - event name.
     * @param { Callback<int> } callback - the callback of on, 0: config is added, 1: config is changed, 2: config is removed.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'deviceConfigChange', callback: Callback<int>): void;
    /**
     * Subscribe Wi-Fi device config change events.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'deviceConfigChange' } type - event name.
     * @param { Callback<int> } callback - the callback of off, 0: config is added, 1: config is changed, 2: config is removed.
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2501000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.STA
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'deviceConfigChange', callback?: Callback<int>): void;
    /**
     * Subscribe Wi-Fi hotspot state change events.
     * When the service exits, call off(type: 'hotspotStateChange', callback?: Callback&lt;number&gt;) to unregister the callback registered.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'hotspotStateChange' } type - event name.
     * @param { Callback<int> } callback - the callback of on, 0: inactive, 1: active, 2: activating, 3: de-activating
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2601000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.AP.Core
     * @since 20
     */
    function on(type: 'hotspotStateChange', callback: Callback<int>): void;
    /**
     * Unsubscribe Wi-Fi hotspot state change events.
     * All callback functions will be deregistered If there is no specific callback parameter.</p>
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'hotspotStateChange' } type - event name.
     * @param { Callback<int> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2601000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.AP.Core
     * @since 20
     */
    function off(type: 'hotspotStateChange', callback?: Callback<int>): void;
    /**
     * Subscribe Wi-Fi hotspot sta join events.
     * @permission ohos.permission.MANAGE_WIFI_HOTSPOT
     * @param { 'hotspotStaJoin' } type - event name.
     * @param { Callback<StationInfo> } callback - the callback of on
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2601000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.AP.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'hotspotStaJoin', callback: Callback<StationInfo>): void;
    /**
     * Unsubscribe Wi-Fi hotspot sta join events.
     * All callback functions will be deregistered If there is no specific callback parameter.</p>
     * @permission ohos.permission.MANAGE_WIFI_HOTSPOT
     * @param { 'hotspotStaJoin' } type - event name.
     * @param { Callback<StationInfo> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2601000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.AP.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'hotspotStaJoin', callback?: Callback<StationInfo>): void;
    /**
     * Subscribe Wi-Fi hotspot sta leave events.
     * @permission ohos.permission.MANAGE_WIFI_HOTSPOT
     * @param { 'hotspotStaLeave' } type - event name.
     * @param { Callback<StationInfo> } callback - the callback of on
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2601000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.AP.Core
  
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'hotspotStaLeave', callback: Callback<StationInfo>): void;
    /**
     * Unsubscribe Wi-Fi hotspot sta leave events.
     * @permission ohos.permission.MANAGE_WIFI_HOTSPOT
     * @param { 'hotspotStaLeave' } type - event name.
     * @param { Callback<StationInfo> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 202 - System API is not allowed called by Non-system application.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2601000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.AP.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'hotspotStaLeave', callback?: Callback<StationInfo>): void;
    /**
     * Subscribe P2P status change events.
     * When the service exits, call off(type: 'p2pStateChange', callback?: Callback&lt;number&gt;) to unregister the callback registered.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'p2pStateChange' } type - event name.
     * @param { Callback<int> } callback - the callback of on, 1: idle, 2: starting, 3:started, 4: closing, 5: closed
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function on(type: 'p2pStateChange', callback: Callback<int>): void;
    /**
     * Unsubscribe P2P status change events.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'p2pStateChange' } type - event name.
     * @param { Callback<int> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function off(type: 'p2pStateChange', callback?: Callback<int>): void;
    /**
     * Subscribe P2P connection change events.
     * When the service exits, call off(type: 'p2pConnectionChange', callback?: Callback&lt;WifiP2pLinkedInfo&gt;) to unregister the callback registered.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'p2pConnectionChange' } type - event name.
     * @param { Callback<WifiP2pLinkedInfo> } callback - the callback of on
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function on(type: 'p2pConnectionChange', callback: Callback<WifiP2pLinkedInfo>): void;
    /**
     * Unsubscribe P2P connection change events.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'p2pConnectionChange' } type - event name.
     * @param { Callback<WifiP2pLinkedInfo> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function off(type: 'p2pConnectionChange', callback?: Callback<WifiP2pLinkedInfo>): void;
    
    /**
     * Subscribe P2P local device change events.
     * When the service exits, call off(type: 'p2pDeviceChange', callback?: Callback&lt;WifiP2pDevice&gt;) to unregister the callback registered.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'p2pDeviceChange' } type - event name.
     * @param { Callback<WifiP2pDevice> } callback - the callback of on
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function on(type: 'p2pDeviceChange', callback: Callback<WifiP2pDevice>): void;
    
    /**
     * Unsubscribe P2P local device change events.
     * @param { 'p2pDeviceChange' } type - event name.
     * @param { Callback<WifiP2pDevice> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function off(type: 'p2pDeviceChange', callback?: Callback<WifiP2pDevice>): void;
    
    /**
     * Subscribe P2P peer device change events.
     * When the service exits, call off(type: 'p2pPeerDeviceChange', callback?: Callback&lt;WifiP2pDevice[]&gt;) to unregister the callback registered.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'p2pPeerDeviceChange' } type - event name.
     * @param { Callback<WifiP2pDevice[]> } callback - the callback of on
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function on(type: 'p2pPeerDeviceChange', callback: Callback<WifiP2pDevice[]>): void;
    
    /**
     * Unsubscribe P2P peer device change events.
     * @param { 'p2pPeerDeviceChange' } type - event name.
     * @param { Callback<WifiP2pDevice[]> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function off(type: 'p2pPeerDeviceChange', callback?: Callback<WifiP2pDevice[]>): void;
    /**
     * Subscribe P2P persistent group change events.
     * When the service exits, call off(type: 'p2pPersistentGroupChange', callback?: Callback&lt;void&gt;) to unregister the callback registered.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'p2pPersistentGroupChange' } type - event name.
     * @param { Callback<void> } callback - the callback of on
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function on(type: 'p2pPersistentGroupChange', callback: Callback<void>): void;
    /**
     * Unsubscribe P2P persistent group change events.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'p2pPersistentGroupChange' } type - event name.
     * @param { Callback<void> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Invalid parameters. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function off(type: 'p2pPersistentGroupChange', callback?: Callback<void>): void;
    /**
     * Subscribe P2P discovery events.
     * When the service exits, call off(type: 'p2pDiscoveryChange', callback?: Callback&lt;number&gt;) to unregister the callback registered.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'p2pDiscoveryChange' } type - event name.
     * @param { Callback<int> } callback - the callback of on
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function on(type: 'p2pDiscoveryChange', callback: Callback<int>): void;
    /**
     * Unsubscribe P2P discovery events.
     * @permission ohos.permission.GET_WIFI_INFO
     * @param { 'p2pDiscoveryChange' } type - event name.
     * @param { Callback<int> } callback - the callback of off
     * @throws {BusinessError} 201 - Permission denied.
     * @throws {BusinessError} 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws {BusinessError} 801 - Capability not supported.
     * @throws {BusinessError} 2801000 - Operation failed.
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    function off(type: 'p2pDiscoveryChange', callback?: Callback<int>): void;
    
    /**
     * Wi-Fi device address( mac / bssid ) type.
     * @enum { int }
     * @syscap SystemCapability.Communication.WiFi.Core
     * @since 20
     */
    enum DeviceAddressType {
        
        /**
         * random device address
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        RANDOM_DEVICE_ADDRESS,
        
        /**
         * real device address
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        REAL_DEVICE_ADDRESS
    }
    /**
     * Wi-Fi detail state.
     * @enum { int } WifiDetailState
     * @syscap SystemCapability.Communication.WiFi.STA
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    enum WifiDetailState {
        /**
         * state is unknown
         * @syscap SystemCapability.Communication.WiFi.STA
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        UNKNOWN = -1,
        /**
         * wifi is closed
         * @syscap SystemCapability.Communication.WiFi.STA
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        INACTIVE = 0,
        /**
         * wifi is opened
         * @syscap SystemCapability.Communication.WiFi.STA
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        ACTIVATED = 1,
        /**
         * wifi is opening
         * @syscap SystemCapability.Communication.WiFi.STA
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        ACTIVATING = 2,
        /**
         * wifi is closing
         * @syscap SystemCapability.Communication.WiFi.STA
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DEACTIVATING = 3,
        /**
         * wifi sta is entering semi active
         * @syscap SystemCapability.Communication.WiFi.STA
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SEMI_ACTIVATING = 4,
        /**
         * wifi sta is semi active
         * @syscap SystemCapability.Communication.WiFi.STA
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SEMI_ACTIVE = 5
    }
    /**
     * Wi-Fi Category.
     * @enum { int }
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    enum WifiCategory {
        /**
         * Default.
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        DEFAULT = 1,
        /**
         * Wifi6.
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        WIFI6 = 2,
        /**
         * Wifi6+.
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        WIFI6_PLUS = 3,
        /**
         * Wifi7.
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        WIFI7 = 4,
        /**
         * Wifi7+.
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        WIFI7_PLUS = 5
    }
    
    /**
     * Wi-Fi device configuration information.
     * @typedef WifiDeviceConfig
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    interface WifiDeviceConfig {
        
        /**
         * Wi-Fi SSID: the maximum length is 32.
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        ssid: string;
        
        /**
         * Wi-Fi bssid(MAC): the length is 6.
         * @type { ?string }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        bssid?: string;
        
        /**
         * Wi-Fi key: maximum length is 64.
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        preSharedKey: string;
        
        /**
         * Security type: reference definition of WifiSecurityType
         * @type { WifiSecurityType }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        securityType: WifiSecurityType;
    }
    
    /**
     * Describes the scanned Wi-Fi information.
     * @typedef WifiScanInfo
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    interface WifiScanInfo {
        
        /**
         * Wi-Fi SSID: the maximum length is 32
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        ssid: string;
        
        /**
         * Wi-Fi bssid(MAC): the length is 6
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        bssid: string;
        
        /**
         * Security type: reference definition of WifiSecurityType
         * @type { WifiSecurityType }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        securityType: WifiSecurityType;
        
        /**
         * Received signal strength indicator (RSSI)
         * @type { int }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        rssi: int;
        /**
         * Frequency band, 1: 2.4G, 2: 5G
         * @type { int }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        band: int;
        /**
         * Supported wifi category
         * @type { WifiCategory }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        supportedWifiCategory: WifiCategory;
    }
    
    /**
     * Describes the wifi security type.
     * @enum { int }
     * @syscap SystemCapability.Communication.WiFi.Core
     * @since 20
     */
    enum WifiSecurityType {
        /**
         * Invalid security type
         *
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        WIFI_SEC_TYPE_INVALID = 0,
        
        /**
         * Open
         *
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        WIFI_SEC_TYPE_OPEN = 1,
        /**
         * Wired Equivalent Privacy (WEP)
         *
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        WIFI_SEC_TYPE_WEP = 2,
        /**
         * Pre-shared key (PSK)
         *
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        WIFI_SEC_TYPE_PSK = 3,
        /**
         * Simultaneous Authentication of Equals (SAE)
         *
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        WIFI_SEC_TYPE_SAE = 4,
        /**
         * EAP authentication.
         *
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        WIFI_SEC_TYPE_EAP = 5,
        /**
         * SUITE_B_192 192 bit level.
         *
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        WIFI_SEC_TYPE_EAP_SUITE_B = 6,
        /**
         * Opportunistic Wireless Encryption.
         *
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        WIFI_SEC_TYPE_OWE = 7,
        /**
         * WAPI certificate to be specified.
         *
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        WIFI_SEC_TYPE_WAPI_CERT = 8,
        /**
         * WAPI pre-shared key to be specified.
         *
         * @syscap SystemCapability.Communication.WiFi.Core
         * @since 20
         */
        WIFI_SEC_TYPE_WAPI_PSK = 9
    }
    
    /**
     * Wi-Fi connection information.
     * @typedef WifiLinkedInfo
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    interface WifiLinkedInfo {
        
        /**
         * The SSID of the Wi-Fi hotspot
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        ssid: string;
        
        /**
         * The BSSID of the Wi-Fi hotspot
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        bssid: string;
        
        /**
         * The RSSI(dBm) of a Wi-Fi access point.
         * @type { int }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        rssi: int;
        /**
         * The frequency band of a Wi-Fi access point.
         * @type { int }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        band: int;
        /**
         * The Wi-Fi MAC address of a device.
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        macAddress: string;
        /**
         * The state of this Wi-Fi connection.
         * @type { ConnState }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        connState: ConnState;
        /**
         * Supported wifi category
         * @type { WifiCategory }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        supportedWifiCategory: WifiCategory;
    }
    /**
     * Wi-Fi IP information.
     * @typedef IpInfo
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    interface IpInfo {
        /**
         * The IP address of the Wi-Fi connection
         * @type { int }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        ipAddress: int;
    }
    /**
     * Wi-Fi IPv6 information.
     * @typedef Ipv6Info
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    interface Ipv6Info {
        /**
         * The link IPv6 address of the Wi-Fi connection
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        linkIpv6Address: string;
    }
    /**
     * Wi-Fi hotspot configuration information.
     * @typedef HotspotConfig
     * @syscap SystemCapability.Communication.WiFi.AP.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface HotspotConfig {
        /**
         * The SSID of the Wi-Fi hotspot
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.AP.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        ssid: string;
        /**
         * The encryption mode of the Wi-Fi hotspot
         * @type { WifiSecurityType }
         * @syscap SystemCapability.Communication.WiFi.AP.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        securityType: WifiSecurityType;
        /**
         * The frequency band of the Wi-Fi hotspot
         * @type { int }
         * @syscap SystemCapability.Communication.WiFi.AP.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        band: int;
        /**
         * The password of the Wi-Fi hotspot
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.AP.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        preSharedKey: string;
    }
    /**
     * Wi-Fi station information.
     * @typedef StationInfo
     * @syscap SystemCapability.Communication.WiFi.AP.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface StationInfo {
        /**
         * The MAC address of the Wi-Fi client
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.AP.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        macAddress: string;
    }
    /**
     * The state of Wi-Fi connection enumeration.
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.WiFi.STA
     * @since 20
     */
    export enum ConnState {
        /**
         * The device is searching for an available AP.
         *
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        SCANNING,
        /**
         * The Wi-Fi connection is being set up.
         *
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        CONNECTING,
        /**
         * The Wi-Fi connection is being authenticated.
         *
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        AUTHENTICATING,
        /**
         * The IP address of the Wi-Fi connection is being obtained.
         *
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        OBTAINING_IPADDR,
        /**
         * The Wi-Fi connection has been set up.
         *
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        CONNECTED,
        /**
         * The Wi-Fi connection is being torn down.
         *
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        DISCONNECTING,
        /**
         * The Wi-Fi connection has been torn down.
         *
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        DISCONNECTED,
        /**
         * Failed to set up the Wi-Fi connection.
         *
         * @syscap SystemCapability.Communication.WiFi.STA
         * @since 20
         */
        UNKNOWN
    }
    /**
     * P2P device information.
     *
     * @typedef WifiP2pDevice
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    interface WifiP2pDevice {
        /**
         * Device name
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        deviceName: string;
        /**
         * Device mac address
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        deviceAddress: string;
        /**
         * Device mac address type
         * @type { ?DeviceAddressType }
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        deviceAddressType?: DeviceAddressType;
        /**
         * Primary device type
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        primaryDeviceType: string;
        /**
         * Device status
         * @type { P2pDeviceStatus }
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        deviceStatus: P2pDeviceStatus;
        /**
         * Device group capabilities
         * @type { int }
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        groupCapabilities: int;
    }
    /**
     * P2P connection status.
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    enum P2pConnectState {
        /**
         * p2p is disconnected
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        DISCONNECTED = 0,
        /**
         * p2p is connected
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        CONNECTED = 1
    }
    /**
     * P2P linked information.
     *
     * @typedef WifiP2pLinkedInfo
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    interface WifiP2pLinkedInfo {
        /**
         * Connection status
         * @type { P2pConnectState }
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        connectState: P2pConnectState;
        /**
         * Indicates whether it is group owner
         * @type { boolean }
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        isGroupOwner: boolean;
        /**
         * Group owner address
         * @type { string }
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        groupOwnerAddr: string;
    }
    /**
     * P2P device status.
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.WiFi.P2P
     * @since 20
     */
    enum P2pDeviceStatus {
        /**
         * Indicate p2p device is connected.
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        CONNECTED = 0,
        /**
         * Indicate p2p device is invited.
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        INVITED = 1,
        /**
         * Indicate p2p device is failed.
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        FAILED = 2,
        /**
         * Indicate p2p device is available.
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        AVAILABLE = 3,
        /**
         * Indicate p2p device is unavailable.
         * @syscap SystemCapability.Communication.WiFi.P2P
         * @since 20
         */
        UNAVAILABLE = 4
    }
}
export default wifiManager;
