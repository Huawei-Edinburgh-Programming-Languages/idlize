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
import type { AsyncCallback } from './@ohos.base';
import type baseProfile from './@ohos.bluetooth.baseProfile';

/**
 * Provides methods to accessing bluetooth audio related capabilities.
 *
 * @namespace a2dp
 * @syscap SystemCapability.Communication.Bluetooth.Core
 * @since 20
 */
declare namespace a2dp {
    /**
     * Base interface of profile.
     *
     * @typedef { baseProfile.BaseProfile } BaseProfile
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    type BaseProfile = baseProfile.BaseProfile;
    
    /**
     * create the instance of a2dp profile.
     *
     * @returns { A2dpSourceProfile } Returns the instance of profile.
     * @throws { BusinessError } 401 - Invalid parameter.Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    function createA2dpSrcProfile(): A2dpSourceProfile;
    
    /**
     * Manager a2dp source profile.
     *
     * @extends BaseProfile
     * @typedef A2dpSourceProfile
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    interface A2dpSourceProfile extends BaseProfile {
    }
}
export default a2dp;
