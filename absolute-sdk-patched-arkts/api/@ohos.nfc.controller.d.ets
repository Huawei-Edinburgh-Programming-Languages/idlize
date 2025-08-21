/*
 * Copyright (c) 2021-2022 Huawei Device Co., Ltd.
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
import { Callback } from './@ohos.base';

/**
 * Provides methods to operate or manage NFC.
 *
 * @namespace nfcController
 * @syscap SystemCapability.Communication.NFC.Core
 * @since 20
 */
declare namespace nfcController {
    
    /**
     * NFC changed states.
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.NFC.Core
     * @since 20
     */
    enum NfcState {
        
        /**
         * Indicates that NFC is disabled.
         *
         * @syscap SystemCapability.Communication.NFC.Core
         * @since 20
         */
        STATE_OFF = 1,
        
        /**
         * Indicates that NFC is being enabled.
         *
         * @syscap SystemCapability.Communication.NFC.Core
         * @since 20
         */
        STATE_TURNING_ON = 2,
        
        /**
         * Indicates that NFC is enabled.
         *
         * @syscap SystemCapability.Communication.NFC.Core
         * @since 20
         */
        STATE_ON = 3,
        
        /**
         * Indicates that NFC is being disabled.
         *
         * @syscap SystemCapability.Communication.NFC.Core
         * @since 20
         */
        STATE_TURNING_OFF = 4
    }
    
    /**
     * register nfc state changed event.
     *
     * @param { 'nfcStateChange' } type The type to register.
     * @param { Callback<NfcState> } callback Callback used to listen to the nfc state changed event.
     * @syscap SystemCapability.Communication.NFC.Core
     * @since 20
     */
    function on(type: 'nfcStateChange', callback: Callback<NfcState>): void;
    
    /**
     * unregister nfc state changed event.
     *
     * @param { 'nfcStateChange' } type The type to unregister.
     * @param { Callback<NfcState> }  callback Callback used to listen to the nfc state changed event.
     * @syscap SystemCapability.Communication.NFC.Core
     * @since 20
     */
    function off(type: 'nfcStateChange', callback?: Callback<NfcState>): void;
    /**
     * Enables NFC.
     * This API can be called only by system applications
     *
     * @permission ohos.permission.MANAGE_SECURE_SETTINGS
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 3100101 - The NFC state is abnormal in the service.
     * @syscap SystemCapability.Communication.NFC.Core
     * @since 20
     */
    function enableNfc(): void;
    /**
     * Disables NFC.
     * This API can be called only by system applications
     *
     * @permission ohos.permission.MANAGE_SECURE_SETTINGS
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 3100101 - The NFC state is abnormal in the service.
     * @syscap SystemCapability.Communication.NFC.Core
     * @since 20
     */
    function disableNfc(): void;
    
    /**
     * Checks whether NFC is enabled.
     *
     * @returns { boolean } Returns {@code true} if NFC is enabled; returns {@code false} otherwise.
     * @syscap SystemCapability.Communication.NFC.Core
     * @since 20
     */
    function isNfcOpen(): boolean;
    
    /**
     * Obtains the NFC status.
     * <p>The NFC status can be any of the following: <ul><li>{@link #STATE_OFF}: Indicates that NFC
     * is disabled. <li>{@link #STATE_TURNING_ON}: Indicates that NFC is being enabled.
     * <li>{@link #STATE_ON}: Indicates that NFC is enabled. <li>{@link #STATE_TURNING_OFF}: Indicates
     * that NFC is being disabled.</ul>
     *
     * @returns { NfcState } Returns the NFC status.
     * @syscap SystemCapability.Communication.NFC.Core
     * @since 20
     */
    function getNfcState(): NfcState;
}
export default nfcController;
