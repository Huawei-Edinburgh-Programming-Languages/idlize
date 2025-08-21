/*
 * Copyright (c) 2023-2024 Huawei Device Co., Ltd.
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
import type Want from './@ohos.app.ability.Want';
import type image from './@ohos.multimedia.image';
/**
 * This module provides the capability to manage the security of the enterprise devices.
 *
 * @namespace securityManager
 * @syscap SystemCapability.Customization.EnterpriseDeviceManager
 * @stagemodelonly
 * @since 20
 */
declare namespace securityManager {
    /**
     * Gets the password policy of the device.
     *
     * @returns { PasswordPolicy } the password policy of the device.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @syscap SystemCapability.Customization.EnterpriseDeviceManager
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function getPasswordPolicy(): PasswordPolicy;
    /**
     * Password policy.
     *
     * @typedef PasswordPolicy
     * @syscap SystemCapability.Customization.EnterpriseDeviceManager
     * @stagemodelonly
     * @since 20
     */
    export interface PasswordPolicy {
        /**
         * The regex of complexity
         *
         * @type { ?string }
         * @syscap SystemCapability.Customization.EnterpriseDeviceManager
         * @stagemodelonly
         * @since 20
         */
        complexityRegex?: string;
        /**
         * Period of validity
         *
         * @type { ?long }
         * @syscap SystemCapability.Customization.EnterpriseDeviceManager
         * @stagemodelonly
         * @since 20
         */
        validityPeriod?: long;
        /**
         * Other supplementary description
         *
         * @type { ?string }
         * @syscap SystemCapability.Customization.EnterpriseDeviceManager
         * @stagemodelonly
         * @since 20
         */
        additionalDescription?: string;
    }
}
export default securityManager;
