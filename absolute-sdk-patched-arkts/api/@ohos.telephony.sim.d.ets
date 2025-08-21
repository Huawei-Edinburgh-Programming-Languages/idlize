/*
 * Copyright (C) 2021-2024 Huawei Device Co., Ltd.
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
 * @kit TelephonyKit
 */
import type { AsyncCallback } from './@ohos.base';
/**
 * Provides applications with APIs for obtaining SIM card status, card file information, and card specifications.
 * SIM cards include SIM, USIM, and CSIM cards.
 *
 * @namespace sim
 * @syscap SystemCapability.Telephony.CoreService
 * @since 20
 */
declare namespace sim {
    /**
     * Checks whether the SIM card in a specified slot is activated.
     *
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from {@code 0} to the maximum card slot index number supported by the device.
     * @param { AsyncCallback<boolean> } callback - Indicates the callback for checking
     * whether the SIM card in a specified slot is activated.
     * Returns {@code true} if the SIM card is activated; returns {@code false} otherwise.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function isSimActive(slotId: int, callback: AsyncCallback<boolean>): void;
    /**
     * Checks whether the SIM card in a specified slot is activated.
     *
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from {@code 0} to the maximum card slot index number supported by the device.
     * @returns { Promise<boolean> } Returns {@code true} if the SIM card is activated; returns {@code false} otherwise.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function isSimActive(slotId: int): Promise<boolean>;
    /**
     * Checks whether the SIM card in a specified slot is activated.
     *
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slots supported by the device.
     * @returns { boolean } Returns {@code true} if the SIM card is activated; returns {@code false} otherwise.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function isSimActiveSync(slotId: int): boolean;
    /**
     * Obtains the default card slot for the voice service.
     *
     * @param { AsyncCallback<int> } callback - Indicates the callback for getting
     * the default card slot for the voice service.
     * Returns {@code 0} if card 1 is used as the default card slot for the voice service;
     * returns {@code 1} if card 2 is used as the default card slot for the voice service;
     * returns {@code -1} if no card is available for the voice service.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getDefaultVoiceSlotId(callback: AsyncCallback<int>): void;
    /**
     * Obtains the default card slot for the voice service.
     *
     * @returns { Promise<int> } Returns {@code 0} if card 1 is used as the default card slot for the voice service;
     * returns {@code 1} if card 2 is used as the default card slot for the voice service;
     * returns {@code -1} if no card is available for the voice service.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getDefaultVoiceSlotId(): Promise<int>;
    /**
     * Obtains the ISO country code of the SIM card in a specified slot.
     *
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @param { AsyncCallback<string> } callback - Indicates the callback for getting the country code defined
     * in ISO 3166-2; returns an empty string if no SIM card is inserted.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getISOCountryCodeForSim(slotId: int, callback: AsyncCallback<string>): void;
    /**
     * Obtains the ISO country code of the SIM card in a specified slot.
     *
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @returns { Promise<string> } Returns the country code defined in ISO 3166-2;
     * returns an empty string if no SIM card is inserted.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getISOCountryCodeForSim(slotId: int): Promise<string>;
    /**
     * Obtains the state of the SIM card in a specified slot.
     *
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from {@code 0} to the maximum card slot index number supported by the device.
     * @param { AsyncCallback<SimState> } callback - Indicates the callback for getting one of the following SIM card states:
     * <ul>
     * <li>{@code SimState#SIM_STATE_UNKNOWN}
     * <li>{@code SimState#SIM_STATE_NOT_PRESENT}
     * <li>{@code SimState#SIM_STATE_LOCKED}
     * <li>{@code SimState#SIM_STATE_NOT_READY}
     * <li>{@code SimState#SIM_STATE_READY}
     * <li>{@code SimState#SIM_STATE_LOADED}
     * </ul>
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getSimState(slotId: int, callback: AsyncCallback<SimState>): void;
    /**
     * Obtains the state of the SIM card in a specified slot.
     *
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from {@code 0} to the maximum card slot index number supported by the device.
     * @returns { Promise<SimState> } Returns one of the following SIM card states:
     * <ul>
     * <li>{@code SimState#SIM_STATE_UNKNOWN}
     * <li>{@code SimState#SIM_STATE_NOT_PRESENT}
     * <li>{@code SimState#SIM_STATE_LOCKED}
     * <li>{@code SimState#SIM_STATE_NOT_READY}
     * <li>{@code SimState#SIM_STATE_READY}
     * <li>{@code SimState#SIM_STATE_LOADED}
     * </ul>
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getSimState(slotId: int): Promise<SimState>;
    /**
     * Obtains the state of the SIM card in a specified slot.
     *
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slots supported by the device.
     * @returns { SimState } Returns one of the following SIM card states:
     * <ul>
     * <li>{@code SimState#SIM_STATE_UNKNOWN}
     * <li>{@code SimState#SIM_STATE_NOT_PRESENT}
     * <li>{@code SimState#SIM_STATE_LOCKED}
     * <li>{@code SimState#SIM_STATE_NOT_READY}
     * <li>{@code SimState#SIM_STATE_READY}
     * <li>{@code SimState#SIM_STATE_LOADED}
     * </ul>
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getSimStateSync(slotId: int): SimState;
    /**
     * Obtains the maximum number of SIM cards that can be used simultaneously on the device,
     * that is, the maximum number of SIM card slots.
     *
     * @returns { int } Returns the maximum number of SIM card slots.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getMaxSimCount(): int;
    /**
     * Checks whether a SIM card is inserted in a specified slot.
     *
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @param { AsyncCallback<boolean> } callback - Indicates the callback for hasSimCard.
     * Returns {@code true} if a SIM card is inserted; return {@code false} otherwise.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function hasSimCard(slotId: int, callback: AsyncCallback<boolean>): void;
    /**
     * Checks whether a SIM card is inserted in a specified slot.
     *
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @returns { Promise<boolean> } Returns {@code true} if a SIM card is inserted; return {@code false} otherwise.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function hasSimCard(slotId: int): Promise<boolean>;
    /**
     * Get account information of SIM card.
     *
     * @permission ohos.permission.GET_TELEPHONY_STATE
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @param { AsyncCallback<IccAccountInfo> } callback - Indicates the callback for
     * getting a {@code IccAccountInfo} object. The ICCID and phone number will be null
     * if has no ohos.permission.GET_TELEPHONY_STATE.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @throws { BusinessError } 8301002 - The SIM card failed to read or update data.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getSimAccountInfo(slotId: int, callback: AsyncCallback<IccAccountInfo>): void;
    /**
     * Get account information of SIM card.
     *
     * @permission ohos.permission.GET_TELEPHONY_STATE
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @returns { Promise<IccAccountInfo> } Returns a {@code IccAccountInfo} object. The ICCID and phone number
     * will be null if has no ohos.permission.GET_TELEPHONY_STATE.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @throws { BusinessError } 8301002 - The SIM card failed to read or update data.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getSimAccountInfo(slotId: int): Promise<IccAccountInfo>;
    /**
     * Get the list of active SIM card account information.
     *
     * @permission ohos.permission.GET_TELEPHONY_STATE
     * @param { AsyncCallback<Array<IccAccountInfo>> } callback - The callback is used to
     * return the array of {@link IccAccountInfo}. The ICCID and phone number will be null
     * if has no ohos.permission.GET_TELEPHONY_STATE.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getActiveSimAccountInfoList(callback: AsyncCallback<Array<IccAccountInfo>>): void;
    /**
     * Get the list of active SIM card account information.
     *
     * @permission ohos.permission.GET_TELEPHONY_STATE
     * @returns { Promise<Array<IccAccountInfo>> } Returns the array of {@link IccAccountInfo}. The ICCID
     * and phone number will be null if has no ohos.permission.GET_TELEPHONY_STATE.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    function getActiveSimAccountInfoList(): Promise<Array<IccAccountInfo>>;
    /**
     * Obtains the operatorconfigs of the SIM card in a specified slot.
     *
     * @permission ohos.permission.GET_TELEPHONY_STATE
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @param { AsyncCallback<Array<OperatorConfig>> } callback - Indicates the callback for
     * getting the operatorconfigs in a specified slot;
     * returns empty OperatorConfig if no SIM card is inserted.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getOperatorConfigs(slotId: int, callback: AsyncCallback<Array<OperatorConfig>>): void;
    /**
     * Obtains the operatorconfigs of the SIM card in a specified slot.
     *
     * @permission ohos.permission.GET_TELEPHONY_STATE
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @returns { Promise<Array<OperatorConfig>> } Returns the operatorconfigs in a specified slot;
     * returns empty OperatorConfig if no SIM card is inserted.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getOperatorConfigs(slotId: int): Promise<Array<OperatorConfig>>;
    /**
     * Unlock the SIM card password of the specified card slot.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @param { string } pin - Indicates the password of the SIM card.
     * @param { AsyncCallback<LockStatusResponse> } callback - Indicates the callback for getting
     * the response to obtain the SIM card lock status of the specified card slot.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @throws { BusinessError } 8301002 - The SIM card failed to read or update data.
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function unlockPin(slotId: int, pin: string, callback: AsyncCallback<LockStatusResponse>): void;
    /**
     * Unlock the SIM card password of the specified card slot.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @param { string } pin - Indicates the password of the SIM card.
     * @returns { Promise<LockStatusResponse> } Returns the response to obtain
     * the SIM card lock status of the specified card slot.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @throws { BusinessError } 8301002 - The SIM card failed to read or update data.
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function unlockPin(slotId: int, pin: string): Promise<LockStatusResponse>;
    /**
     * Unlock the SIM card password in the specified card slot.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @param { string } newPin - Indicates to reset the SIM card password.
     * @param { string } puk - Indicates the unlock password of the SIM card password.
     * @param { AsyncCallback<LockStatusResponse> } callback - Indicates the callback for getting
     * the response to obtain the SIM card lock status of the specified card slot.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @throws { BusinessError } 8301002 - The SIM card failed to read or update data.
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function unlockPuk(slotId: int, newPin: string, puk: string, callback: AsyncCallback<LockStatusResponse>): void;
    /**
     * Unlock the SIM card password in the specified card slot.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @param { string } newPin - Indicates to reset the SIM card password.
     * @param { string } puk - Indicates the unlock password of the SIM card password.
     * @returns { Promise<LockStatusResponse> } Returns the response to obtain
     * the SIM card lock status of the specified card slot.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @throws { BusinessError } 8301002 - The SIM card failed to read or update data.
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function unlockPuk(slotId: int, newPin: string, puk: string): Promise<LockStatusResponse>;
    /**
     * Get the lock status of the SIM card in the specified slot.
     *
     * @permission ohos.permission.GET_TELEPHONY_STATE
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @param { LockType } lockType - Indicates the lock type.
     * @param { AsyncCallback<LockState> } callback - Indicates the callback for getting the sim card lock status.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @throws { BusinessError } 8301002 - The SIM card failed to read or update data.
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getLockState(slotId: int, lockType: LockType, callback: AsyncCallback<LockState>): void;
    /**
     * Get the lock status of the SIM card in the specified slot.
     *
     * @permission ohos.permission.GET_TELEPHONY_STATE
     * @param { int } slotId - Indicates the card slot index number,
     * ranging from 0 to the maximum card slot index number supported by the device.
     * @param { LockType } lockType - Indicates the lock type.
     * @returns { Promise<LockState> } Returns the sim card lock status.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Service connection failed.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300004 - No SIM card found.
     * @throws { BusinessError } 8300999 - Unknown error.
     * @throws { BusinessError } 8301002 - The SIM card failed to read or update data.
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getLockState(slotId: int, lockType: LockType): Promise<LockState>;
    /**
     * Defines the carrier configuration.
     *
     * @interface OperatorConfig
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface OperatorConfig {
        /**
         * Indicates the field.
         *
         * @type { string }
         * @syscap SystemCapability.Telephony.CoreService
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        field: string;
        /**
         * Indicates the value.
         *
         * @type { string }
         * @syscap SystemCapability.Telephony.CoreService
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        value: string;
    }
    /**
     * Defines the ICC account information.
     *
     * @interface IccAccountInfo
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    export interface IccAccountInfo {
        /**
         * Indicates the sim Id for card.
         *
         * @type { int }
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        simId: int;
        /**
         * Indicates the card slot index number,
         * ranging from 0 to the maximum card slot index number supported by the device.
         *
         * @type { int }
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        slotIndex: int;
        /**
         * Indicates the mark card is eSim or not.
         *
         * @type { boolean }
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        isEsim: boolean;
        /**
         * Indicates the active status for card.
         *
         * @type { boolean }
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        isActive: boolean;
        /**
         * Indicates the iccId for card.
         *
         * @type { string }
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        iccId: string;
        /**
         * Indicates the display name for card.
         *
         * @type { string }
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        showName: string;
        /**
         * Indicates the display number for card.
         *
         * @type { string }
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        showNumber: string;
    }
    /**
     * Defines the personalized lock information.
     *
     * @interface LockStatusResponse
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface LockStatusResponse {
        /**
         * Indicates the current operation result.
         *
         * @type { int }
         * @syscap SystemCapability.Telephony.CoreService
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        result: int;
        /**
         * Indicates the operations remaining.
         *
         * @type { ?int }
         * @syscap SystemCapability.Telephony.CoreService
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        remain?: int;
    }
    /**
     * Indicates the lock types.
     *
     * @enum { int }
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum LockType {
        /**
         * Indicates the SIM card password lock.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        PIN_LOCK = 1,
        /**
         * Indicates the fixed dialing lock.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        FDN_LOCK = 2
    }
    /**
     * Indicates the SIM card types.
     *
     * @enum { int }
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    export enum CardType {
        /**
         * Icc card type: unknown type Card.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        UNKNOWN_CARD = -1,
        /**
         * Icc card type: Single sim card type.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        SINGLE_MODE_SIM_CARD = 10,
        /**
         * Icc card type: Single usim card type.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        SINGLE_MODE_USIM_CARD = 20,
        /**
         * Icc card type: Single ruim card type.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        SINGLE_MODE_RUIM_CARD = 30,
        /**
         * Icc card type: Double card C+G.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        DUAL_MODE_CG_CARD = 40,
        /**
         * Icc card type: China Telecom Internal Roaming Card (Dual Mode).
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        CT_NATIONAL_ROAMING_CARD = 41,
        /**
         * Icc card type: China Unicom Dual Mode Card.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        CU_DUAL_MODE_CARD = 42,
        /**
         * Icc card type: China Telecom LTE Card (Dual Mode).
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        DUAL_MODE_TELECOM_LTE_CARD = 43,
        /**
         * Icc card type: Double card U+G.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        DUAL_MODE_UG_CARD = 50,
        /**
         * Icc card type: Single isim card type.
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        SINGLE_MODE_ISIM_CARD = 60
    }
    /**
     * Indicates the SIM card states.
     *
     * @enum { int }
     * @syscap SystemCapability.Telephony.CoreService
     * @since 20
     */
    export enum SimState {
        /**
         * Indicates unknown SIM card state, that is, the accurate status cannot be
         * obtained.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        SIM_STATE_UNKNOWN,
        /**
         * Indicates that the SIM card is in the <b>not present</b> state, that is,
         * no SIM card is inserted into the card slot.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        SIM_STATE_NOT_PRESENT,
        /**
         * Indicates that the SIM card is in the <b>locked</b> state, that is, the
         * SIM card is locked by the personal identification number (PIN)/PIN
         * unblocking key (PUK) or network.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        SIM_STATE_LOCKED,
        /**
         * Indicates that the SIM card is in the <b>not ready</b> state, that is,
         * the SIM card is in position but cannot work properly.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        SIM_STATE_NOT_READY,
        /**
         * Indicates that the SIM card is in the <b>ready</b> state, that is, the
         * SIM card is in position and is working properly.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        SIM_STATE_READY,
        /**
         * Indicates that the SIM card is in the <b>loaded</b> state, that is, the
         * SIM card is in position and is working properly.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @since 20
         */
        SIM_STATE_LOADED
    }
    /**
     * Indicates the lock states.
     *
     * @enum { int }
     * @syscap SystemCapability.Telephony.CoreService
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum LockState {
        /**
         * Indicates that the lock state card is in the <b>off</b> state.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        LOCK_OFF = 0,
        /**
         * Indicates that the lock state card is in the <b>on</b> state.
         *
         * @syscap SystemCapability.Telephony.CoreService
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        LOCK_ON = 1
    }
}
export default sim;
