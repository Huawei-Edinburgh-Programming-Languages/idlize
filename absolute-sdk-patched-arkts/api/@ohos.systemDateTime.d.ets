/*
 * Copyright (C) 2022 Huawei Device Co., Ltd.
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
 * @kit BasicServicesKit
 */
import { AsyncCallback } from './@ohos.base';

/**
 * System time and timezone.
 *
 * @namespace systemDateTime
 * @syscap SystemCapability.MiscServices.Time
 * @since 20
 */
declare namespace systemDateTime {
    /**
     * Sets the system time.
     *
     * @permission ohos.permission.SET_TIME
     * @param { long } time - Indicates the target timestamp(in milliseconds)
     * @param { AsyncCallback<void> } callback - The callback of setTime
     * @throws { BusinessError } 201 - Permission denied
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2.Incorrect parameter types;
     * @syscap SystemCapability.MiscServices.Time
     * @systemapi Hide this for inner system use
     * @since 20
     */
    function setTime(time: long, callback: AsyncCallback<void>): void;
    /**
     * Sets the system time.
     *
     * @permission ohos.permission.SET_TIME
     * @param { long } time - Indicates the target timestamp(in milliseconds)
     * @returns { Promise<void> } The promise returned by the function
     * @throws { BusinessError } 201 - Permission denied
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2.Incorrect parameter types;
     * @syscap SystemCapability.MiscServices.Time
     * @systemapi Hide this for inner system use
     * @since 20
     */
    function setTime(time: long): Promise<void>;
    
    /**
     * Obtains the number of timestamp that have elapsed since the Unix epoch.
     *
     * @param { boolean } [ isNanoseconds ] - True if the result is in nanoseconds, otherwise in milliseconds
     * @returns { long } The timestamp returned of getTime.
     * @syscap SystemCapability.MiscServices.Time
     * @since 20
     */
    function getTime(isNanoseconds?: boolean): long;
    
    /**
     * Indicates time type.
     *
     * @enum { int } TimeType
     * @syscap SystemCapability.MiscServices.Time
     * @since 20
     */
    enum TimeType {
        
        /**
         * Indicates the time elapsed since the system was booted, including deep sleep time.
         *
         * @syscap SystemCapability.MiscServices.Time
         * @since 20
         */
        STARTUP = 0,
        
        /**
         * Indicates the time elapsed since the system was booted, not including deep sleep time.
         *
         * @syscap SystemCapability.MiscServices.Time
         * @since 20
         */
        ACTIVE = 1
    }
    
    
    /**
     * Obtains the number of milliseconds since the system has been running.
     *
     * @param { TimeType } timeType - indicates the type of get uptime. It can only be `STARTUP` or `ACTIVE`.
     * @param { boolean } [ isNanoseconds ] - True if the result is in nanoseconds, otherwise in milliseconds
     * @returns { long } The timestamp returned of getUpTime.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     *     2. Incorrect parameter types; 3. Parameter verification failed. This error code was added due to missing
     *     issues.
     * @syscap SystemCapability.MiscServices.Time
     * @since 20
     */
    function getUptime(timeType: TimeType, isNanoseconds?: boolean): long;
    
    
    /**
     * Obtains the system time zone.
     *
     * @param { AsyncCallback<string> } callback - The callback of getTimezone
     * @syscap SystemCapability.MiscServices.Time
     * @since 20
     */
    function getTimezone(callback: AsyncCallback<string>): void;
    
    
    /**
     * Obtains the system time zone.
     *
     * @returns { Promise<string> } The promise returned by the function
     * @syscap SystemCapability.MiscServices.Time
     * @since 20
     */
    function getTimezone(): Promise<string>;
    
    /**
     * Obtains the system time zone.
     *
     * @returns { string } The timezone returned of getTimezoneSync.
     * @syscap SystemCapability.MiscServices.Time
     * @since 20
     */
    function getTimezoneSync(): string;
}
export default systemDateTime;
