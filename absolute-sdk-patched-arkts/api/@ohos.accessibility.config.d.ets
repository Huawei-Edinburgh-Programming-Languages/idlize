/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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
 * @kit AccessibilityKit
 */
import type accessibility from './@ohos.accessibility';
import type { AsyncCallback, Callback } from './@ohos.base';
/**
 * Configuration of the accessibility.
 *
 * @namespace config
 * @syscap SystemCapability.BarrierFree.Accessibility.Core
 * @systemapi
 * @since 20
 */
declare namespace config {
    /**
     * Indicates the configuration of high-contrast text.
     *
     * @type { Config<boolean> }
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @systemapi
     * @since 20
     */
    let highContrastText: Config<boolean>;
    /**
     * Indicates setting, getting, and listening to changes in configuration.
     *
     * @typedef Config<T>
     * @syscap SystemCapability.BarrierFree.Accessibility.Core
     * @systemapi
     * @since 20
     */
    interface Config<T> {
        /**
         * Setting configuration value.
         *
         * @permission ohos.permission.WRITE_ACCESSIBILITY_CONFIG
         * @param { T } value Indicates the value.
         * @returns { Promise<void> }
         * @throws { BusinessError } 201 - Permission verification failed.
         *     The application does not have the permission required to call the API.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @systemapi
         * @since 20
         */
        setReturnsPromise(value: T): Promise<void>;
        /**
         * Setting configuration value.
         *
         * @permission ohos.permission.WRITE_ACCESSIBILITY_CONFIG
         * @param { T } value Indicates the value.
         * @param { AsyncCallback<void> } callback
         * @throws { BusinessError } 201 - Permission verification failed.
         *     The application does not have the permission required to call the API.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @systemapi
         * @since 20
         */
        setWithCallback(value: T, callback: AsyncCallback<void>): void;
        /**
         */
        overload set {
            setReturnsPromise,
            setWithCallback
        };
        /**
         * Getting configuration value.
         *
         * @returns { Promise<T> }
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @systemapi
         * @since 20
         */
        getReturnsPromise(): Promise<T>;
        /**
         * Getting configuration value.
         *
         * @param { AsyncCallback<T> } callback
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.BarrierFree.Accessibility.Core
         * @systemapi
         * @since 20
         */
        getWithCallback(callback: AsyncCallback<T>): void;
        /**
         */
        overload get {
            getReturnsPromise,
            getWithCallback
        };
    }
}
export default config;
