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
 * @kit ConnectivityKit
 */
import type { AsyncCallback, Callback } from './@ohos.base';
import type constant from './@ohos.bluetooth.constant';

/**
 * Provides basic profile methods.
 *
 * @namespace baseProfile
 * @syscap SystemCapability.Communication.Bluetooth.Core
 * @since 20
 */
declare namespace baseProfile {
    
    /**
     * Indicate the profile connection state.
     *
     * @typedef { constant.ProfileConnectionState } ProfileConnectionState
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    type ProfileConnectionState = constant.ProfileConnectionState;
    
    /**
     * Profile state change parameters.
     *
     * @typedef StateChangeParam
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    export interface StateChangeParam {
        
        /**
         * The address of device
         *
         * @type { string }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        deviceId: string;
        
        /**
         * Profile state value
         *
         * @type { ProfileConnectionState }
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        state: ProfileConnectionState;
    }
    
    /**
     * Base interface of profile.
     *
     * @typedef BaseProfile
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    export interface BaseProfile {
    }
}
export default baseProfile;
