/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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
 * @kit LocationKit
 */
import { AsyncCallback, Callback } from './@ohos.base';
import { WantAgent } from '@ohos.app.ability.wantAgent';
import { NotificationRequest } from './notification/notificationRequest';

/**
 * Provides interfaces for acquiring location information, managing location switches,
 * geocoding, reverse geocoding, country code, fencing and other functions.
 *
 * @namespace geoLocationManager
 * @syscap SystemCapability.Location.Location.Core
 * @since 20
 */
declare namespace geoLocationManager {
    
    
    
    /**
     * Subscribe location changed.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'locationChange' } type - Indicates the location service event to be subscribed to.
     * @param { LocationRequest | ContinuousLocationRequest } request - Indicates the location request parameters.
     * @param { Callback<Location> } callback - Indicates the callback for reporting the location result.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.on('locationChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function on(type: 'locationChange', request: LocationRequest | ContinuousLocationRequest, callback: Callback<Location>): void;
    
    
    /**
     * Unsubscribe location changed.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'locationChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<Location> } [callback] - Indicates the callback for reporting the location result.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.off('locationChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function off(type: 'locationChange', callback?: Callback<Location>): void;
    /**
     * Subscribe continuous location error changed.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'locationError' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<LocationError> } callback - Indicates the callback for reporting the continuous location error.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.on('locationError')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function on(type: 'locationError', callback: Callback<LocationError>): void;
    /**
     * Unsubscribe continuous location error changed.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'locationError' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<LocationError> } [callback] - Indicates the callback for reporting the continuous location error.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.off('locationError')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function off(type: 'locationError', callback?: Callback<LocationError>): void;
    /**
     * Subscribe location switch changed.
     *
     * @param { 'locationEnabledChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<boolean> } callback - Indicates the callback for reporting the location switch status.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.on('locationEnabledChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function on(type: 'locationEnabledChange', callback: Callback<boolean>): void;
    /**
     * Unsubscribe location switch changed.
     *
     * @param { 'locationEnabledChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<boolean> } [callback] - Indicates the callback for reporting the location switch status.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.off('locationEnabledChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function off(type: 'locationEnabledChange', callback?: Callback<boolean>): void;
    
    /**
     * Subscribe to cache GNSS locations update messages.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'cachedGnssLocationsChange' } type - Indicates the location service event to be subscribed to.
     * @param { CachedGnssLocationsRequest } request - Indicates the cached GNSS locations request parameters.
     * @param { Callback<Array<Location>> } callback - Indicates the callback for reporting the cached GNSS locations.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.on('cachedGnssLocationsChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @syscap SystemCapability.Location.Location.Gnss
     * @since 20
     */
    function on(type: 'cachedGnssLocationsChange', request: CachedGnssLocationsRequest, callback: Callback<Array<Location>>): void;
    
    /**
     * Unsubscribe to cache GNSS locations update messages.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'cachedGnssLocationsChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<Array<Location>> } [callback] - Indicates the callback for reporting the cached gnss locations.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.off('cachedGnssLocationsChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @syscap SystemCapability.Location.Location.Gnss
     * @since 20
     */
    function off(type: 'cachedGnssLocationsChange', callback?: Callback<Array<Location>>): void;
    /**
     * Subscribe satellite status changed.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'satelliteStatusChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<SatelliteStatusInfo> } callback - Indicates the callback for reporting the satellite status.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.on('satelliteStatusChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @syscap SystemCapability.Location.Location.Gnss
     * @since 20
     */
    function on(type: 'satelliteStatusChange', callback: Callback<SatelliteStatusInfo>): void;
    /**
     * Unsubscribe satellite status changed.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'satelliteStatusChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<SatelliteStatusInfo> } [callback] - Indicates the callback for reporting the satellite status.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.off('satelliteStatusChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @syscap SystemCapability.Location.Location.Gnss
     * @since 20
     */
    function off(type: 'satelliteStatusChange', callback?: Callback<SatelliteStatusInfo>): void;
    /**
     * Subscribe nmea message changed.
     *
     * @permission ohos.permission.LOCATION and ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'nmeaMessage' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<string> } callback - Indicates the callback for reporting the nmea message.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.on('nmeaMessage')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @syscap SystemCapability.Location.Location.Gnss
     * @since 20
     */
    function on(type: 'nmeaMessage', callback: Callback<string>): void;
    /**
     * Unsubscribe nmea message changed.
     *
     * @permission ohos.permission.LOCATION and ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'nmeaMessage' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<string> } [callback] - Indicates the callback for reporting the nmea message.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.off('nmeaMessage')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @syscap SystemCapability.Location.Location.Gnss
     * @since 20
     */
    function off(type: 'nmeaMessage', callback?: Callback<string>): void;
    /**
     * Registering the callback function for listening to country code changes.
     *
     * @param { 'countryCodeChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<CountryCode> } callback - Indicates the callback for reporting country code changes.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.on('countryCodeChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301500 - Failed to query the area information.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function on(type: 'countryCodeChange', callback: Callback<CountryCode>): void;
    /**
     * Unregistering the callback function for listening to country code changes.
     *
     * @param { 'countryCodeChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<CountryCode> } [callback] - Indicates the callback for reporting country code changes.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.off('countryCodeChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301500 - Failed to query the area information.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function off(type: 'countryCodeChange', callback?: Callback<CountryCode>): void;
    /**
     * Subscribe to changes in WiFi/BT scanning information,
     * and use the WiFi/BT scanning information for localization.
     *
     * @permission ohos.permission.LOCATION and ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'locatingRequiredDataChange' } type - Indicates the location service event to be subscribed to.
     * @param { LocatingRequiredDataConfig } config - Indicates the locating required data configuration parameters.
     * @param { Callback<Array<LocatingRequiredData>> } [callback] - Indicates the callback for reporting WiFi/BT scan info.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.on('locatingRequiredDataChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301800 - Failed to start WiFi or Bluetooth scanning.
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    function on(type: 'locatingRequiredDataChange', config: LocatingRequiredDataConfig, callback: Callback<Array<LocatingRequiredData>>): void;
    /**
     * Stop WiFi/BT scanning and unsubscribe from WiFi/BT scanning information changes.
     *
     * @permission ohos.permission.LOCATION and ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'locatingRequiredDataChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<Array<LocatingRequiredData>> } [callback] - Indicates the callback for reporting WiFi/BT scan info.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.off('locatingRequiredDataChange')} due to limited device capabilities.
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    function off(type: 'locatingRequiredDataChange', callback?: Callback<Array<LocatingRequiredData>>): void;
    /**
     * Subscribe location icon status changed.
     *
     * @param { 'locationIconStatusChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<LocationIconStatus> } callback - Indicates the callback for reporting the location icon status.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.on('locationIconStatusChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    function on(type: 'locationIconStatusChange', callback: Callback<LocationIconStatus>): void;
    /**
     * Unsubscribe location icon status changed.
     *
     * @param { 'locationIconStatusChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<LocationIconStatus> } [callback] - Indicates the callback for reporting the location icon status.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.off('locationIconStatusChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    function off(type: 'locationIconStatusChange', callback?: Callback<LocationIconStatus>): void;
    /**
     * Registers and listens to bluetooth scanning results for location services.
     *
     * @permission ohos.permission.LOCATION and ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'bluetoothScanResultChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<BluetoothScanResult> } callback - Indicates the callback for reporting Bluetooth scan info.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.on('bluetoothScanResultChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function on(type: 'bluetoothScanResultChange', callback: Callback<BluetoothScanResult>): void;
    /**
     * Stop bluetooth scanning and unregister to listen to bluetooth scanning result changes.
     *
     * @permission ohos.permission.LOCATION and ohos.permission.APPROXIMATELY_LOCATION
     * @param { 'bluetoothScanResultChange' } type - Indicates the location service event to be subscribed to.
     * @param { Callback<BluetoothScanResult> } [callback] - Indicates the callback for reporting Bluetooth scan info.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.off('bluetoothScanResultChange')} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function off(type: 'bluetoothScanResultChange', callback?: Callback<BluetoothScanResult>): void;
    
    
    /**
     * Obtain current location.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @param { CurrentLocationRequest | SingleLocationRequest } request - Indicates the location request parameters.
     * @param { AsyncCallback<Location> } callback - Indicates the callback for reporting the location result.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.getCurrentLocation} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @throws { BusinessError } 3301200 - Failed to obtain the geographical location.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function getCurrentLocation(request: CurrentLocationRequest | SingleLocationRequest, callback: AsyncCallback<Location>): void;
    
    /**
     * Obtain current location.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @param { AsyncCallback<Location> } callback - Indicates the callback for reporting the location result.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.getCurrentLocation} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @throws { BusinessError } 3301200 - Failed to obtain the geographical location.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function getCurrentLocation(callback: AsyncCallback<Location>): void;
    
    
    /**
     * Obtain current location.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @param { CurrentLocationRequest | SingleLocationRequest } [request] - Indicates the location request parameters.
     * @returns { Promise<Location> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.getCurrentLocation} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @throws { BusinessError } 3301200 - Failed to obtain the geographical location.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function getCurrentLocation(request?: CurrentLocationRequest | SingleLocationRequest): Promise<Location>;
    
    /**
     * Obtain last known location.
     *
     * @permission ohos.permission.APPROXIMATELY_LOCATION
     * @returns { Location } The last known location information.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.getLastLocation} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301100 - The location switch is off.
     * @throws { BusinessError } 3301200 - Failed to obtain the geographical location.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function getLastLocation(): Location;
    
    /**
     * Obtain current location switch status.
     *
     * @returns { boolean } Returns {@code true} if the location switch on, returns {@code false} otherwise.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.isLocationEnabled} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    function isLocationEnabled(): boolean;
    
    /**
     * Enable location switch.
     *
     * @permission ohos.permission.MANAGE_SECURE_SETTINGS and ohos.permission.CONTROL_LOCATION_SWITCH
     * @param { AsyncCallback<void> } callback - Indicates the callback for reporting the error message.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.enableLocation} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    function enableLocation(callback: AsyncCallback<void>): void;
    
    /**
     * Enable location switch.
     *
     * @permission ohos.permission.MANAGE_SECURE_SETTINGS and ohos.permission.CONTROL_LOCATION_SWITCH
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.enableLocation} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    function enableLocation(): Promise<void>;
    
    /**
     * Disable location switch.
     *
     * @permission ohos.permission.MANAGE_SECURE_SETTINGS and ohos.permission.CONTROL_LOCATION_SWITCH
     * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission required to call the API.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.disableLocation} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    function disableLocation(): void;
    /**
     * Obtain address info from location.
     *
     * @param { ReverseGeoCodeRequest } request - Indicates the reverse geocode query parameters.
     * @param { AsyncCallback<Array<GeoAddress>> } callback - Indicates the callback for reporting the address info.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.getAddressesFromLocation} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301300 - Reverse geocoding query failed.
     * @syscap SystemCapability.Location.Location.Geocoder
     * @since 20
     */
    function getAddressesFromLocation(request: ReverseGeoCodeRequest, callback: AsyncCallback<Array<GeoAddress>>): void;
    /**
     * Obtain address info from location.
     *
     * @param { ReverseGeoCodeRequest } request - Indicates the reverse geocode query parameters.
     * @returns { Promise<Array<GeoAddress>> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.getAddressesFromLocation} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @throws { BusinessError } 3301300 - Reverse geocoding query failed.
     * @syscap SystemCapability.Location.Location.Geocoder
     * @since 20
     */
    function getAddressesFromLocation(request: ReverseGeoCodeRequest): Promise<Array<GeoAddress>>;
    /**
     * Querying location privacy protocol confirmation status.
     *
     * @param { LocationPrivacyType } type - Indicates location privacy protocol type.
     * @returns { boolean } Returns {@code true} if the location privacy protocol has been confirmed, returns {@code false} otherwise.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported. Failed to call ${geoLocationManager.isLocationPrivacyConfirmed} due to limited device capabilities.
     * @throws { BusinessError } 3301000 - The location service is unavailable.
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    function isLocationPrivacyConfirmed(type: LocationPrivacyType): boolean;
    /**
     * Satellite status information.
     *
     * @typedef SatelliteStatusInfo
     * @syscap SystemCapability.Location.Location.Gnss
     * @since 20
     */
    export interface SatelliteStatusInfo {
        /**
         * Number of satellites.
         *
         * @type { int }
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        satellitesNumber: int;
        /**
         * Satellite ID array.
         *
         * @type { Array<int> }
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        satelliteIds: Array<int>;
        /**
         * Carrier to noise density array.
         *
         * @type { Array<double> }
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        carrierToNoiseDensitys: Array<double>;
        /**
         * Satellite altitude array.
         *
         * @type { Array<double> }
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        altitudes: Array<double>;
        /**
         * Satellite azimuth array.
         *
         * @type { Array<double> }
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        azimuths: Array<double>;
        /**
         * Satellite carrier frequency array.
         *
         * @type { Array<double> }
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        carrierFrequencies: Array<double>;
        /**
         * Satellite constellation type array.
         *
         * @type { ?Array<SatelliteConstellationCategory> }
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        satelliteConstellation?: Array<SatelliteConstellationCategory>;
        /**
         * Satellite additional information array.
         *
         * @type { ?Array<int> }
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        satelliteAdditionalInfo?: Array<int>;
    }
    /**
     * Parameters for requesting to report cache location information.
     *
     * @typedef CachedGnssLocationsRequest
     * @syscap SystemCapability.Location.Location.Gnss
     * @since 20
     */
    export interface CachedGnssLocationsRequest {
        /**
         * GNSS cache location report period.
         *
         * @type { int }
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        reportingPeriodSec: int;
        /**
         * Indicates whether to wake up the listener when the GNSS cache location queue is full.
         *
         * @type { boolean }
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        wakeUpCacheQueueFull: boolean;
    }
    /**
     * Configuring parameters in reverse geocode requests.
     *
     * @typedef ReverseGeoCodeRequest
     * @syscap SystemCapability.Location.Location.Geocoder
     * @since 20
     */
    export interface ReverseGeoCodeRequest {
        /**
         * Indicates the language area information.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        locale?: string;
        /**
         * Indicates the country information.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        country?: string;
        /**
         * Latitude for reverse geocoding query.
         *
         * @type { double }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        latitude: double;
        /**
         * Longitude for reverse geocoding query.
         *
         * @type { double }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        longitude: double;
        /**
         * Indicates the maximum number of addresses returned by reverse geocoding query.
         *
         * @type { ?int }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        maxItems?: int;
    }
    /**
     * Configuring parameters in geocode requests.
     *
     * @typedef GeoCodeRequest
     * @syscap SystemCapability.Location.Location.Geocoder
     * @since 20
     */
    export interface GeoCodeRequest {
        /**
         * Indicates the language area information.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        locale?: string;
        /**
         * Indicates the country information.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        country?: string;
        /**
         * Address information.
         *
         * @type { string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        description: string;
        /**
         * Indicates the maximum number of geocode query results.
         *
         * @type { ?int }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        maxItems?: int;
        /**
         * Indicates the minimum latitude for geocoding query results.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        minLatitude?: double;
        /**
         * Indicates the minimum longitude for geocoding query results.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        minLongitude?: double;
        /**
         * Indicates the maximum latitude for geocoding query results.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        maxLatitude?: double;
        /**
         * Indicates the maximum longitude for geocoding query results.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        maxLongitude?: double;
    }
    /**
     * Data struct describes geographic locations.
     *
     * @typedef GeoAddress
     * @syscap SystemCapability.Location.Location.Geocoder
     * @since 20
     */
    export interface GeoAddress {
        /**
         * Indicates latitude information.
         * A positive value indicates north latitude,
         * and a negative value indicates south latitude.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        latitude?: double;
        /**
         * Indicates longitude information.
         * A positive value indicates east longitude ,
         * and a negative value indicates west longitude.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        longitude?: double;
        /**
         * Indicates language used for the location description.
         * zh indicates Chinese, and en indicates English.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        locale?: string;
        /**
         * Indicates detailed address information.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        placeName?: string;
        /**
         * Indicates country code.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        countryCode?: string;
        /**
         * Indicates country name.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        countryName?: string;
        /**
         * Indicates administrative region name.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        administrativeArea?: string;
        /**
         * Indicates sub-administrative region name.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        subAdministrativeArea?: string;
        /**
         * Indicates locality information.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        locality?: string;
        /**
         * Indicates sub-locality information.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        subLocality?: string;
        /**
         * Indicates road name.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        roadName?: string;
        /**
         * Indicates auxiliary road information.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        subRoadName?: string;
        /**
         * Indicates house information.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        premises?: string;
        /**
         * Indicates postal code.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        postalCode?: string;
        /**
         * Indicates phone number.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        phoneNumber?: string;
        /**
         * Indicates website URL.
         *
         * @type { ?string }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        addressUrl?: string;
        /**
         * Indicates additional information.
         *
         * @type { ?Array<string> }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        descriptions?: Array<string>;
        /**
         * Indicates the amount of additional descriptive information.
         *
         * @type { ?int }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @since 20
         */
        descriptionsSize?: int;
        /**
         * Indicates whether it is an mock GeoAddress
         *
         * @type { ?Boolean }
         * @syscap SystemCapability.Location.Location.Geocoder
         * @systemapi
         * @since 20
         */
        isFromMock?: Boolean;
    }
    
    /**
     * Configuring parameters in location requests.
     *
     * @typedef LocationRequest
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export interface LocationRequest {
        
        /**
         * Priority of the location request.
         *
         * @type { ?LocationRequestPriority }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        priority?: LocationRequestPriority;
        
        /**
         * User scenario of the location request.
         *
         * @type { ?LocationRequestScenario }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        scenario?: LocationRequestScenario;
        
        /**
         * Location report interval.
         *
         * @type { ?int }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        timeInterval?: int;
        
        /**
         * Location report distance interval.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        distanceInterval?: double;
        
        /**
         * Accuracy requirements for reporting locations.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        maxAccuracy?: double;
    }
    
    /**
     * Configuring parameters in current location requests.
     *
     * @typedef CurrentLocationRequest
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export interface CurrentLocationRequest {
        
        /**
         * Priority of the location request.
         *
         * @type { ?LocationRequestPriority }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        priority?: LocationRequestPriority;
        
        /**
         * User scenario of the location request.
         *
         * @type { ?LocationRequestScenario }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        scenario?: LocationRequestScenario;
        
        /**
         * Accuracy requirements for reporting locations.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        maxAccuracy?: double;
        
        /**
         * Timeout interval of a single location request.
         *
         * @type { ?int }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        timeoutMs?: int;
    }
    /**
     * Configuring parameters in continuous location requests.
     *
     * @typedef ContinuousLocationRequest
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export interface ContinuousLocationRequest {
        /**
         * Location report interval, in seconds.
         *
         * @type { int }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        interval: int;
        /**
         * Location scenario. You can select a user activity scenario or power consumption scenario.
         *
         * @type { UserActivityScenario | PowerConsumptionScenario }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        locationScenario: UserActivityScenario | PowerConsumptionScenario;
        /**
         * Indicates the type of sports.
         * This parameter is valid only when locationScenario is set to UserActivityScenario.SPORT.
         *
         * @type { SportsType }
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        sportsType?: SportsType;
    }
    /**
     * Configuring parameters in single location requests.
     *
     * @typedef SingleLocationRequest
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export interface SingleLocationRequest {
        /**
         * Priority of the location request.
         *
         * @type { LocatingPriority }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        locatingPriority: LocatingPriority;
        /**
         * Timeout of a single location request, in milliseconds.
         *
         * @type { int }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        locatingTimeoutMs: int;
    }
    
    /**
     * Provides information about geographic locations.
     *
     * @typedef Location
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export interface Location {
        
        /**
         * Indicates latitude information.
         * A positive value indicates north latitude,
         * and a negative value indicates south latitude.
         *
         * @type { double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        latitude: double;
        
        /**
         * Indicates Longitude information.
         * A positive value indicates east longitude ,
         * and a negative value indicates west longitude.
         *
         * @type { double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        longitude: double;
        
        /**
         * Indicates location altitude, in meters.
         *
         * @type { double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        altitude: double;
        
        /**
         * Indicates location accuracy, in meters.
         *
         * @type { double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        accuracy: double;
        
        /**
         * Indicates speed, in m/s.
         *
         * @type { double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        speed: double;
        
        /**
         * Indicates location timestamp in the UTC format.
         *
         * @type { long }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        timeStamp: long;
        
        /**
         * Indicates direction information.
         *
         * @type { double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        direction: double;
        
        /**
         * Indicates location timestamp since boot.
         *
         * @type { long }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        timeSinceBoot: long;
        
        /**
         * Indicates additional information.
         *
         * @type { ?Array<string> }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        additions?: Array<string>;
        /**
         * Indicates additional information map.
         *
         * @type { ?Map<string, string> }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        additionsMap?: Map<string, string>;
        
        /**
         * Indicates the amount of additional descriptive information.
         *
         * @type { ?int }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        additionSize?: int;
        /**
         * Indicates whether it is an mock location.
         *
         * @type { ?Boolean }
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        isFromMock?: Boolean;
        /**
         * Indicates vertical position accuracy in meters.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        altitudeAccuracy?: double;
        /**
         * Indicates speed accuracy in meter per seconds.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        speedAccuracy?: double;
        /**
         * Indicates direction accuracy in degrees.
         *
         * @type { ?double }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        directionAccuracy?: double;
        /**
         * Time uncertainty Of timeSinceBoot in nanosecond.
         *
         * @type { ?long }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        uncertaintyOfTimeSinceBoot?: long;
        /**
         * Indicates the source of the location.
         *
         * @type { ?LocationSourceType }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        sourceType?: LocationSourceType;
    }
    /**
     * Describes the request parameters for obtaining the data required for locating.
     * @typedef LocatingRequiredDataConfig
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    export interface LocatingRequiredDataConfig {
        /**
         * Indicates the type of locating required data.
         *
         * @type {LocatingRequiredDataType}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        type: LocatingRequiredDataType;
        /**
         * Indicates whether to start scanning.
         *
         * @type {boolean}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        needStartScan: boolean;
        /**
         * Indicates the interval between scans. The unit is millisecond.
         * This parameter needs to be set only when scanning information is continuously monitored.
         *
         * @type {?int}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        scanInterval?: int;
        /**
         * Indicates the timeout period of a single scan. The unit is millisecond. The default value is 10000.
         * This parameter needs to be set only when getLocatingRequiredData is used.
         *
         * @type {?int}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        scanTimeout?: int;
    }
    /**
     * Describes the structure of the data required for locating.
     * @typedef LocatingRequiredData
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    export interface LocatingRequiredData {
        /**
         * WiFi scan info.
         *
         * @type {?WifiScanInfo}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        wifiData?: WifiScanInfo;
        /**
         * Bluetooth scan info.
         *
         * @type {?BluetoothScanInfo}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        bluetoothData?: BluetoothScanInfo;
    }
    /**
     * Describes the scanned WiFi information.
     * @typedef WifiScanInfo
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    export interface WifiScanInfo {
        /**
         * WiFi SSID: the maximum length is 32.
         *
         * @type {string}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        ssid: string;
        /**
         * WiFi bssid(MAC): the length is 6.
         *
         * @type {string}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        bssid: string;
        /**
         * Received signal strength indicator (RSSI).
         *
         * @type {int}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        rssi: int;
        /**
         * Frequency
         *
         * @type {int}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        frequency: int;
        /**
         * Time stamp.
         *
         * @type {long}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        timestamp: long;
    }
    /**
     * Describes the contents of the Bluetooth scan results.
     *
     * @typedef BluetoothScanInfo
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    export interface BluetoothScanInfo {
        /**
         * The local name of the device.
         *
         * @type {string}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        deviceName: string;
        /**
         * Mac address of the scanned device.
         *
         * @type {string}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        macAddress: string;
        /**
         * RSSI of the remote device.
         *
         * @type {int}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        rssi: int;
        /**
         * Time stamp.
         *
         * @type {long}
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        timestamp: long;
    }
    /**
     * Describes the contents of the bluetooth scan results.
     *
     * @typedef BluetoothScanResult
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export interface BluetoothScanResult {
        /**
         * Address of the scanned device
         *
         * @type { string }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        deviceId: string;
        /**
         * RSSI of the scanned device
         *
         * @type { int }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        rssi: int;
        /**
         * The raw data of broadcast packet
         *
         * @type { ?ArrayBuffer }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        data?: ArrayBuffer;
        /**
         * The local name of the scanned device
         *
         * @type { string }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        deviceName: string;
        /**
         * Connectable of the scanned device
         *
         * @type { boolean }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        connectable: boolean;
    }
    /**
     * Enum for the source of the location.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export enum LocationSourceType {
        /**
         * The location is obtained from the GNSS.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        GNSS = 1,
        /**
         * The location comes from the network positioning technology.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        NETWORK = 2,
        /**
         * The location comes from the indoor positioning technology.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        INDOOR = 3,
        /**
         * The location comes from the GNSS RTK technology.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        RTK = 4
    }
    /**
     * Enum for coordinate system type.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Geofence
     * @since 20
     */
    export enum CoordinateSystemType {
        /**
         * WGS84 coordinates system.
         *
         * @syscap SystemCapability.Location.Location.Geofence
         * @since 20
         */
        WGS84 = 1,
        /**
         * GCJ-02 coordinates system.
         *
         * @syscap SystemCapability.Location.Location.Geofence
         * @since 20
         */
        GCJ02 = 2
    }
    /**
     * Enum for location icon status.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    export enum LocationIconStatus {
        /**
         * The locating service is not started.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        LOCATING_NOT_STARTED = 0,
        /**
         * The normal locating service is started.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        LOCATING_STARTED = 1,
        /**
         * The HD locating service(RTK) is started.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        HD_LOCATING_STARTED = 2
    }
    /**
     * Enum for location error code.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export enum LocationError {
        /**
         * Default cause for location failure.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        LOCATING_FAILED_DEFAULT = -1,
        /**
         * Locating failed because the location permission fails to be verified.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        LOCATING_FAILED_LOCATION_PERMISSION_DENIED = -2,
        /**
         * Locating failed because the app is in the background and the background location permission verification failed.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        LOCATING_FAILED_BACKGROUND_PERMISSION_DENIED = -3,
        /**
         * Locating failed because the location switch is turned off.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        LOCATING_FAILED_LOCATION_SWITCH_OFF = -4,
        /**
         * Locating failed because internet access failure.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        LOCATING_FAILED_INTERNET_ACCESS_FAILURE = -5
    }
    /**
     * Enum for satellite constellation category.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Gnss
     * @since 20
     */
    export enum SatelliteConstellationCategory {
        /**
         * Invalid value.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        CONSTELLATION_CATEGORY_UNKNOWN = 0,
        /**
         * GPS.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        CONSTELLATION_CATEGORY_GPS = 1,
        /**
         * SBAS.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        CONSTELLATION_CATEGORY_SBAS = 2,
        /**
         * GLONASS.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        CONSTELLATION_CATEGORY_GLONASS = 3,
        /**
         * QZSS.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        CONSTELLATION_CATEGORY_QZSS = 4,
        /**
         * BEIDOU.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        CONSTELLATION_CATEGORY_BEIDOU = 5,
        /**
         * GALILEO.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        CONSTELLATION_CATEGORY_GALILEO = 6,
        /**
         * IRNSS.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        CONSTELLATION_CATEGORY_IRNSS = 7
    }
    /**
     * Enum for satellite additional information.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Gnss
     * @since 20
     */
    export enum SatelliteAdditionalInfo {
        /**
         * Default value.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        SATELLITES_ADDITIONAL_INFO_NULL = 0,
        /**
         * Ephemeris data exist.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        SATELLITES_ADDITIONAL_INFO_EPHEMERIS_DATA_EXIST = 1,
        /**
         * Almanac data exist.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        SATELLITES_ADDITIONAL_INFO_ALMANAC_DATA_EXIST = 2,
        /**
         * This satellite is being used in location fix.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        SATELLITES_ADDITIONAL_INFO_USED_IN_FIX = 4,
        /**
         * Carrier frequency exist.
         *
         * @syscap SystemCapability.Location.Location.Gnss
         * @since 20
         */
        SATELLITES_ADDITIONAL_INFO_CARRIER_FREQUENCY_EXIST = 8
    }
    /**
     * Enum for user activity scenario.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export enum UserActivityScenario {
        /**
         * Navigation scenario. High positioning precision and real-time performance are required.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        NAVIGATION = 0x401,
        /**
         * Sport scenario. High positioning precision is required.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        SPORT = 0x402,
        /**
         * Transport scenario. High positioning precision and real-time performance are required.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        TRANSPORT = 0x403,
        /**
         * Daily life scenarios. Low requirements on positioning precision.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        DAILY_LIFE_SERVICE = 0x404
    }
    /**
     * Enum for locating priority.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export enum LocatingPriority {
        /**
         * Preferentially ensure the highest locating accuracy.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        PRIORITY_ACCURACY = 0x501,
        /**
         * Preferentially ensure the fastest locating speed.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        PRIORITY_LOCATING_SPEED = 0x502
    }
    
    /**
     * Enum for location priority.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export enum LocationRequestPriority {
        
        /**
         * Default priority.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        UNSET = 0x200,
        
        /**
         * Preferentially ensure the locating accuracy.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        ACCURACY,
        
        /**
         * Preferentially ensure low power consumption for locating.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        LOW_POWER,
        
        /**
         * Preferentially ensure that the first location is time-consuming.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        FIRST_FIX
    }
    
    /**
     * Enum for location scenario.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export enum LocationRequestScenario {
        
        /**
         * Default scenario.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        UNSET = 0x300,
        
        /**
         * Navigation scenario. High positioning precision and real-time performance are required.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        NAVIGATION,
        
        /**
         * Trajectory tracking scenario. High positioning precision is required.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        TRAJECTORY_TRACKING,
        
        /**
         * Car hailing scenario. High positioning precision and real-time performance are required.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        CAR_HAILING,
        
        /**
         * Daily life scenarios. Low requirements on positioning precision and real-time performance.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        DAILY_LIFE_SERVICE,
        
        /**
         * Power saving scenarios.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        NO_POWER
    }
    /**
     * Enum for power consumption scenario.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export enum PowerConsumptionScenario {
        /**
         * High power consumption mode.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        HIGH_POWER_CONSUMPTION = 0x601,
        /**
         * Low power consumption mode.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        LOW_POWER_CONSUMPTION = 0x602,
        /**
         * Power saving scenarios.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        NO_POWER_CONSUMPTION = 0x603
    }
    /**
     * Enum for location privacy type.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    export enum LocationPrivacyType {
        /**
         * Other scenarios.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        OTHERS = 0,
        /**
         * Privacy agreement for the startup wizard scenario.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        STARTUP,
        /**
         * Privacy agreement pop-up when network location is enabled.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        CORE_LOCATION
    }
    /**
     * Enum for sports type
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export enum SportsType {
        /**
         * Indicates running.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        RUNNING = 1,
        /**
         * Indicates walking.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        WALKING,
        /**
         * Indicates cycling.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        CYCLING
    }
    /**
     * Country code structure.
     *
     * @typedef CountryCode
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export interface CountryCode {
        /**
         * Country code character string.
         *
         * @type { string }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        country: string;
        /**
         * Country code source.
         *
         * @type { CountryCodeType }
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        type: CountryCodeType;
    }
    /**
     * Enum for country code type.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @since 20
     */
    export enum CountryCodeType {
        /**
         * Country code obtained from the locale setting.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        COUNTRY_CODE_FROM_LOCALE = 1,
        /**
         * Country code obtained from the SIM information.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        COUNTRY_CODE_FROM_SIM,
        /**
         * Query the country code information from the reverse geocoding result.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        COUNTRY_CODE_FROM_LOCATION,
        /**
         * Obtain the country code from the cell registration information.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @since 20
         */
        COUNTRY_CODE_FROM_NETWORK
    }
    /**
     * Enum for locating required data type.
     *
     * @enum { int }
     * @syscap SystemCapability.Location.Location.Core
     * @systemapi
     * @since 20
     */
    export enum LocatingRequiredDataType {
        /**
         * Obtains WiFi scanning information for locating.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        WIFI = 1,
        /**
         * Obtains BT scanning information for locating.
         *
         * @syscap SystemCapability.Location.Location.Core
         * @systemapi
         * @since 20
         */
        BLUETOOTH
    }
}
export default geoLocationManager;
