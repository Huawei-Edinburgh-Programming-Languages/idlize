/*
 * Copyright (c) 2022-2024 Huawei Device Co., Ltd.
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
 * @kit MDMKit
 */
import type { AsyncCallback } from './@ohos.base';
import type Want from './@ohos.app.ability.Want';
import common from '@ohos.app.ability.common';
/**
 * This module provides the capability to manage the administrator of the enterprise devices.
 *
 * @namespace adminManager
 * @syscap SystemCapability.Customization.EnterpriseDeviceManager
 * @since 20
 */
declare namespace adminManager {
    /**
     * Provides the enterprise information.
     *
     * @typedef EnterpriseInfo
     * @syscap SystemCapability.Customization.EnterpriseDeviceManager
     * @systemapi
     * @since 20
     */
    export interface EnterpriseInfo {
        /**
         * The name of enterprise.
         *
         * @type { string }
         * @syscap SystemCapability.Customization.EnterpriseDeviceManager
         * @systemapi
         * @since 20
         */
        name: string;
        /**
         * The description of enterprise.
         *
         * @type { string }
         * @syscap SystemCapability.Customization.EnterpriseDeviceManager
         * @systemapi
         * @since 20
         */
        description: string;
    }
    /**
     * Get information of the administrator's enterprise.
     *
     * @param { Want } admin - admin indicates the administrator ability information.
     * @param { AsyncCallback<EnterpriseInfo> } callback - callback contained the enterprise info of administrator.
     * @throws { BusinessError } 9200001 - The application is not an administrator application of the device.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     *                                 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Customization.EnterpriseDeviceManager
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function getEnterpriseInfo(admin: Want, callback: AsyncCallback<EnterpriseInfo>): void;
    /**
     * Get information of the administrator's enterprise.
     *
     * @param { Want } admin - admin indicates the administrator ability information.
     * @returns { Promise<EnterpriseInfo> } promise contained the enterprise info of administrator.
     * @throws { BusinessError } 9200001 - The application is not an administrator application of the device.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     *                                 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Customization.EnterpriseDeviceManager
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function getEnterpriseInfo(admin: Want): Promise<EnterpriseInfo>;
    /**
     * Get the super administrator of device.
     *
     * @returns { Promise<Want> } promise contained the want indicates the super administrator of the device.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @syscap SystemCapability.Customization.EnterpriseDeviceManager
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function getSuperAdmin(): Promise<Want>;
}
export default adminManager;
