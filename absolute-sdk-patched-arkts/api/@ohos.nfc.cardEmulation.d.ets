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
import { AsyncCallback } from './@ohos.base';
import { ElementName } from './bundleManager/ElementName';
import type { AbilityInfo } from './bundleManager/AbilityInfo';

/**
 * Provides methods to operate or manage NFC card emulation.
 *
 * @namespace cardEmulation
 * @syscap SystemCapability.Communication.NFC.CardEmulation
 * @since 20
 */
declare namespace cardEmulation {
    
    /**
     * Define the card emulation type, payment or other.
     *
     * @enum { string }
     * @syscap SystemCapability.Communication.NFC.CardEmulation
     * @since 20
     */
    enum CardType {
        
        /**
         * Payment type of card emulation
         *
         * @syscap SystemCapability.Communication.NFC.CardEmulation
         * @since 20
         */
        PAYMENT = 'payment',
        
        /**
         * Other type of card emulation
         *
         * @syscap SystemCapability.Communication.NFC.CardEmulation
         * @since 20
         */
        OTHER = 'other'
    }
    
    /**
     * Checks whether Host Card Emulation(HCE) capability is supported.
     *
     * @permission ohos.permission.NFC_CARD_EMULATION
     * @returns { boolean } Returns true if HCE is supported, otherwise false.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 801 - Capability not supported.
     * @syscap SystemCapability.Communication.NFC.CardEmulation
     * @since 20
     */
    function hasHceCapability(): boolean;
    
    /**
     * Checks whether a service is default for given type.
     *
     * @permission ohos.permission.NFC_CARD_EMULATION
     * @param { ElementName } elementName - The element name of the service ability
     * @param { CardType } type - The type to query, payment or other.
     * @returns { boolean } Returns true if the service is default, otherwise false.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - The parameter check failed. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @syscap SystemCapability.Communication.NFC.CardEmulation
     * @since 20
     */
    function isDefaultService(elementName: ElementName, type: CardType): boolean;
    /**
     * Gets all payment services.
     *
     * @permission ohos.permission.NFC_CARD_EMULATION
     * @returns { AbilityInfo[] } Returns all payment services.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 801 - Capability not supported.
     * @syscap SystemCapability.Communication.NFC.CardEmulation
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getPaymentServices(): AbilityInfo[];
    
    /**
     * A class for NFC host application.
     * <p>The NFC host application use this class, then Nfc service can access the application
     * installation information and connect to services of the application.
     *
     * @syscap SystemCapability.Communication.NFC.CardEmulation
     * @since 20
     */
    export class HceService {
        
        /**
         * Starts the HCE, register more aids and allows this application to be preferred while in foreground.
         *
         * @permission ohos.permission.NFC_CARD_EMULATION
         * @param { ElementName } elementName - The element name of the service ability
         * @param { string[] } aidList - The aid list to be registered by this service, allowed to be empty.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes:
         * <br> 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameters types.
         * <br> 3. Parameter verification failed.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 3100301 - Card emulation running state is abnormal in service.
         * @syscap SystemCapability.Communication.NFC.CardEmulation
         * @since 20
         */
        start(elementName: ElementName, aidList: string[]): void;
        
        /**
         * Stops the HCE, and unset the preferred service while in foreground.
         *
         * @permission ohos.permission.NFC_CARD_EMULATION
         * @param { ElementName } elementName - The element name of the service ability
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes:
         * <br> 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameters types.
         * <br> 3. Parameter verification failed.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 3100301 - Card emulation running state is abnormal in service.
         * @syscap SystemCapability.Communication.NFC.CardEmulation
         * @since 20
         */
        stop(elementName: ElementName): void;
        
        /**
         * register HCE event to receive the APDU data.
         *
         * @permission ohos.permission.NFC_CARD_EMULATION
         * @param { 'hceCmd' } type The type to register.
         * @param { AsyncCallback<int[]> } callback Callback used to listen to HCE data that local device received.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - Invalid parameter.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Communication.NFC.CardEmulation
         * @since 20
         */
        on(type: 'hceCmd', callback: AsyncCallback<int[]>): void;
        /**
         * Unsubscribe the event to receive the APDU data.
         *
         * @permission ohos.permission.NFC_CARD_EMULATION
         * @param { 'hceCmd' } type - The type to unregister event.
         * @param { AsyncCallback<int[]> } callback - The callback used to listen for the event.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Communication.NFC.CardEmulation
         * @since 20
         */
        off(type: 'hceCmd', callback?: AsyncCallback<int[]>): void;
        
        /**
         * Sends a response APDU to the remote device.
         *
         * @permission ohos.permission.NFC_CARD_EMULATION
         * @param { int[] } response Indicates the response to send, which is a byte array.
         * @returns { Promise<void> } The void
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes:
         * <br> 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameters types.
         * <br> 3. Parameter verification failed.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 3100301 - Card emulation running state is abnormal in service.
         * @syscap SystemCapability.Communication.NFC.CardEmulation
         * @since 20
         */
        transmit(response: int[]): Promise<void>;
        
        /**
         * Sends a response APDU to the remote device.
         *
         * @permission ohos.permission.NFC_CARD_EMULATION
         * @param { int[] } response Indicates the response to send, which is a byte array.
         * @param { AsyncCallback<void> } callback The callback
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - The parameter check failed. Possible causes:
         * <br> 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameters types.
         * <br> 3. Parameter verification failed.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 3100301 - Card emulation running state is abnormal in service.
         * @syscap SystemCapability.Communication.NFC.CardEmulation
         * @since 20
         */
        transmit(response: int[], callback: AsyncCallback<void>): void;
    }
}
export default cardEmulation;
