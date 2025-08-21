/*
 * Copyright (C) 2021-2023 Huawei Device Co., Ltd.
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
import type { AsyncCallback, Callback } from './@ohos.base';
import type Context from './application/BaseContext';
import type image from './@ohos.multimedia.image';

/**
 * Provides methods related to call management.
 *
 * @namespace call
 * @syscap SystemCapability.Telephony.CallManager
 * @since 20
 */
declare namespace call {
    
    /**
     * Go to the dial screen and the called number is displayed.
     *
     * @param { string } phoneNumber - Indicates the called number.
     * @param { AsyncCallback<void> } callback - The callback of makeCall.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Applications.Contacts
     * @since 20
     */
    function makeCall(phoneNumber: string, callback: AsyncCallback<void>): void;
    
    /**
     * Go to the dial screen and the called number is displayed.
     *
     * @param { string } phoneNumber - Indicates the called number.
     * @returns { Promise<void> } The promise returned by the makeCall.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Applications.Contacts
     * @since 20
     */
    function makeCall(phoneNumber: string): Promise<void>;
    /**
     * Go to the dial screen and the called number is displayed.
     *
     * @param { Context } context - Indicates the context.
     * @param { string } phoneNumber - Indicates the called number.
     * @returns { Promise<void> } The promise returned by the makeCall.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @syscap SystemCapability.Applications.Contacts
     * @since 20
     */
    function makeCall(context: Context, phoneNumber: string): Promise<void>;
    /**
     * Checks whether a call is ongoing.
     *
     * @returns { boolean } Returns {@code true} if at least one call is not in the {@link CallState#CALL_STATE_IDLE}
     * state; returns {@code false} otherwise.
     * @syscap SystemCapability.Telephony.CallManager
     * @since 20
     */
    function hasCallSync(): boolean;
    /**
     * Obtains the call state.
     *
     * If an incoming call is ringing or waiting, the system returns {@code CallState#CALL_STATE_RINGING}.
     * If at least one call is in the active, hold, or dialing state, the system returns
     * {@code CallState#CALL_STATE_OFFHOOK}. In other cases, the system returns {@code CallState#CALL_STATE_IDLE}.
     *
     * @returns { CallState } Returns the call state.
     * @syscap SystemCapability.Telephony.CallManager
     * @since 20
     */
    function getCallStateSync(): CallState;
    /**
     * Checks whether a device supports voice calls.
     *
     * The system checks whether the device has the capability to initiate a circuit switching (CS) or IP multimedia
     * subsystem domain (IMS) call on a telephone service network. If the device supports only packet switching
     * (even if the device supports OTT calls), {@code false} is returned.
     *
     * @returns { boolean } Returns {@code true} if the device supports voice calls; returns {@code false} otherwise.
     * @syscap SystemCapability.Telephony.CallManager
     * @since 20
     */
    function hasVoiceCapability(): boolean;
    /**
     * Formats a phone number according to the Chinese Telephone Code Plan. Before the formatting,
     * a phone number is in the format of country code (if any) + 3-digit service provider code
     * + 4-digit area code + 4-digit subscriber number. After the formatting,
     * each part is separated by a space.
     *
     * @param { string } phoneNumber - Indicates the phone number to format.
     * @param { NumberFormatOptions } options - Indicates the country code option.
     * @param { AsyncCallback<string> } callback - Indicates the callback to obtain a formatted phone number.
     * Returns an empty string if the input phone number is invalid.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @since 20
     */
    function formatPhoneNumber(phoneNumber: string, options: NumberFormatOptions, callback: AsyncCallback<string>): void;
    /**
     * Formats a phone number according to the Chinese Telephone Code Plan. Before the formatting,
     * a phone number is in the format of country code (if any) + 3-digit service provider code
     * + 4-digit area code + 4-digit subscriber number. After the formatting,
     * each part is separated by a space.
     *
     * @param { string } phoneNumber - Indicates the phone number to format.
     * @param { NumberFormatOptions } options - Indicates the country code option.
     * @returns { Promise<string> } Returns the phone number after being formatted.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @since 20
     */
    function formatPhoneNumber(phoneNumber: string, options?: NumberFormatOptions): Promise<string>;
    /**
     * Formats a phone number according to the Chinese Telephone Code Plan. Before the formatting,
     * a phone number is in the format of country code (if any) + 3-digit service provider code
     * + 4-digit area code + 4-digit subscriber number. After the formatting,
     * each part is separated by a space.
     *
     * @param { string } phoneNumber - Indicates the phone number to format.
     * @param { AsyncCallback<string> } callback - Indicates the callback to obtain a formatted phone number.
     * Returns an empty string if the input phone number is invalid.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @since 20
     */
    function formatPhoneNumber(phoneNumber: string, callback: AsyncCallback<string>): void;
    /**
     * Subscribe to the callDetailsChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'callDetailsChange' } type - Event type. Indicates the callDetailsChange event to be subscribed to.
     * @param { Callback<CallAttributeOptions> } callback - Indicates the callback for getting the result of call details.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'callDetailsChange', callback: Callback<CallAttributeOptions>): void;
    /**
     * Unsubscribe from the callDetailsChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'callDetailsChange' } type - Event type. Indicates the callDetailsChange event to unsubscribe from.
     * @param { Callback<CallAttributeOptions> } callback - Indicates the callback to unsubscribe from
     * the callDetailsChange event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'callDetailsChange', callback?: Callback<CallAttributeOptions>): void;
    /**
     * Subscribe to the callEventChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'callEventChange' } type - Event type. Indicates the callEventChange event to be subscribed to.
     * @param { Callback<CallEventOptions> } callback - Indicates the callback for getting the call event id.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'callEventChange', callback: Callback<CallEventOptions>): void;
    /**
     * Unsubscribe from the callEventChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'callEventChange' } type - Event type. Indicates the callEventChange event to unsubscribe from.
     * @param { Callback<CallEventOptions> } callback - Indicates the callback to unsubscribe from the callEventChange event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'callEventChange', callback?: Callback<CallEventOptions>): void;
    /**
     * Subscribe to the callDisconnectedCause event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'callDisconnectedCause' } type - Event type. Indicates the callDisconnectedCause event to be subscribed to.
     * @param { Callback<DisconnectedDetails> } callback - Indicates the callback for getting the call disconnection reason.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'callDisconnectedCause', callback: Callback<DisconnectedDetails>): void;
    /**
     * Unsubscribe from the callDisconnectedCause event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'callDisconnectedCause' } type - Event type. Indicates the callDisconnectedCause event to unsubscribe from.
     * @param { Callback<DisconnectedDetails> } callback - Indicates the callback used to cancel
     * the registration monitoring for obtaining the call end reason.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'callDisconnectedCause', callback?: Callback<DisconnectedDetails>): void;
    /**
     * Subscribe to the mmiCodeResult event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'mmiCodeResult' } type - Event type. Indicates the mmiCodeResult event to be subscribed to.
     * @param { Callback<MmiCodeResults> } callback - Indicates the callback for getting the result of MMI code.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'mmiCodeResult', callback: Callback<MmiCodeResults>): void;
    /**
     * Unsubscribe from the mmiCodeResult event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'mmiCodeResult' } type - Event type. Indicates the mmiCodeResult event to unsubscribe from.
     * @param { Callback<MmiCodeResults> } callback - Indicates the callback used to cancel getting mmicode registered listening.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'mmiCodeResult', callback?: Callback<MmiCodeResults>): void;
    /**
     * Subscribe to the audioDeviceChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'audioDeviceChange' } type - Event type. Indicates the audioDeviceChange event to be subscribed to.
     * @param { Callback<AudioDeviceCallbackInfo> } callback - Indicates the callback for getting the result of Current AudioDevice.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'audioDeviceChange', callback: Callback<AudioDeviceCallbackInfo>): void;
    /**
     * Unsubscribe from the audioDeviceChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'audioDeviceChange' } type - Event type. Indicates the audioDeviceChange event to unsubscribe from.
     * @param { Callback<AudioDeviceCallbackInfo> } callback - Indicates the callback for getting the result of Current AudioDevice.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'audioDeviceChange', callback?: Callback<AudioDeviceCallbackInfo>): void;
    /**
     * Subscribe to the postDialDelay event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'postDialDelay' } type - Event type. Indicates the postDialDelay event to be subscribed to.
     * @param { Callback<string> } callback - Indicates the callback for getting the result of post-dial string.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'postDialDelay', callback: Callback<string>): void;
    /**
     * Unsubscribe from the postDialDelay event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'postDialDelay' } type - Event type. Indicates the postDialDelay event to unsubscribe from.
     * @param { Callback<string> } callback - Indicates the callback for getting the result of post-dial string.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'postDialDelay', callback?: Callback<string>): void;
    /**
     * Subscribe to the imsCallModeChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'imsCallModeChange' } type - Event type. Indicates the imsCallModeChange event to be subscribed to.
     * @param { Callback<ImsCallModeInfo> } callback - Indicates the callback for
     * getting the result of ImsCallModeInfo details.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'imsCallModeChange', callback: Callback<ImsCallModeInfo>): void;
    /**
     * Unsubscribe from the imsCallModeChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'imsCallModeChange' } type - Event type. Indicates the imsCallModeChange event to unsubscribe from.
     * @param { Callback<ImsCallModeInfo> } callback - Indicates the callback to unsubscribe from
     * the imsCallModeChange event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'imsCallModeChange', callback?: Callback<ImsCallModeInfo>): void;
    /**
     * Subscribe to the callSessionEvent.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'callSessionEvent' } type - Event type. Indicates the callSessionEvent
     * event to be subscribed to.
     * @param { Callback<CallSessionEvent> } callback - Indicates the callback for
     * getting the result of CallSessionEvent.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'callSessionEvent', callback: Callback<CallSessionEvent>): void;
    /**
     * Unsubscribe from the callSessionEvent.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'callSessionEvent' } type - Event type. Indicates the callSessionEventChange event to
     * unsubscribe from.
     * @param { Callback<CallSessionEvent> } callback - Indicates the callback to unsubscribe from
     * the CallSessionEvent event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'callSessionEvent', callback?: Callback<CallSessionEvent>): void;
    /**
     * Subscribe to the peerDimensionsChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'peerDimensionsChange' } type - Event type. Indicates the peerDimensionsChange event
     * to be subscribed to.
     * @param { Callback<PeerDimensionsDetail> } callback - Indicates the callback for
     * getting the result of PeerDimensionsDetail details.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'peerDimensionsChange', callback: Callback<PeerDimensionsDetail>): void;
    /**
     * Unsubscribe from the peerDimensionsChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'peerDimensionsChange' } type - Event type. Indicates the peerDimensionsChange event to
     * unsubscribe from.
     * @param { Callback<PeerDimensionsDetail> } callback - Indicates the callback to unsubscribe from
     * peerDimensionsChange event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'peerDimensionsChange', callback?: Callback<PeerDimensionsDetail>): void;
    /**
     * Subscribe to the cameraCapabilitiesChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'cameraCapabilitiesChange' } type - Event type. Indicates the cameraCapabilitiesChange event
     * to be subscribed to.
     * @param { Callback<CameraCapabilities> } callback - Indicates the callback for
     * getting the result of CameraCapabilities details.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'cameraCapabilitiesChange', callback: Callback<CameraCapabilities>): void;
    /**
     * Unsubscribe from the cameraCapabilitiesChange event.
     *
     * @permission ohos.permission.SET_TELEPHONY_STATE
     * @param { 'cameraCapabilitiesChange' } type - Event type. Indicates the cameraCapabilitiesChange event
     * to unsubscribe from.
     * @param { Callback<CameraCapabilities> } callback - Indicates the callback to unsubscribe from
     * cameraCapabilitiesChange event.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
     * 2. Incorrect parameters types;
     * @throws { BusinessError } 8300001 - Invalid parameter value.
     * @throws { BusinessError } 8300002 - Operation failed. Cannot connect to service.
     * @throws { BusinessError } 8300003 - System internal error.
     * @throws { BusinessError } 8300999 - Unknown error code.
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'cameraCapabilitiesChange', callback?: Callback<CameraCapabilities>): void;
    /**
     * Indicates the device type of the audio device.
     *
     * @enum { number }
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum AudioDeviceType {
        /**
         * Indicates the audio device is earpiece.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DEVICE_EARPIECE,
        /**
         * Indicates the audio device is speaker.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DEVICE_SPEAKER,
        /**
         * Indicates the audio device is wired headset.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DEVICE_WIRED_HEADSET,
        /**
         * Indicates the audio device is bluetooth headset.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DEVICE_BLUETOOTH_SCO,
        /**
         * Indicates the audio device is distributed automotive device.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DEVICE_DISTRIBUTED_AUTOMOTIVE
    }
    /**
     * Indicates the audio device.
     *
     * @interface AudioDevice
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface AudioDevice {
        /**
         * Indicates the device type of the audio device.
         *
         * @type { AudioDeviceType }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        deviceType: AudioDeviceType;
        /**
         * Indicates the address of the audio device.
         *
         * @type { ?string }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        address?: string;
        /**
         * Indicates the name of the audio device.
         *
         * @type { ?string }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        deviceName?: string;
    }
    /**
     * Indicates the information of the audio device.
     *
     * @interface AudioDeviceCallbackInfo
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface AudioDeviceCallbackInfo {
        /**
         * Indicates the list of support audio device.
         *
         * @type { Array<AudioDevice> }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        audioDeviceList: Array<AudioDevice>;
        /**
         * Indicates the type of current audio device.
         *
         * @type { AudioDevice }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        currentAudioDevice: AudioDevice;
        /**
         * Indicates the status of mute.
         *
         * @type { boolean }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        isMuted: boolean;
    }
    /**
     * Indicates the options of call attribute.
     *
     * @interface CallAttributeOptions
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface CallAttributeOptions {
        /**
         * Indicates the type of call.
         *
         * @type { CallType }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        callType: CallType;
        /**
         * Indicates the id of call.
         *
         * @type { number }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        callId: number;
        /**
         * Indicates the detailed state of call.
         *
         * @type { DetailedCallState }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        callState: DetailedCallState;
    }
    /**
     * Indicates the type of call.
     *
     * @enum { number }
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum CallType {
        /**
         * Indicates the call type is CS.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        TYPE_CS = 0,
        /**
         * Indicates the call type is IMS.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        TYPE_IMS = 1,
        /**
         * Indicates the call type is OTT.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        TYPE_OTT = 2,
        /**
         * Indicates the call type is OTHER.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        TYPE_ERR_CALL = 3,
        /**
         * Indicates the call type is VoIP.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        TYPE_VOIP = 4
    }
    /**
     * Indicates the detailed state of call.
     *
     * @enum { number }
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum DetailedCallState {
        /**
         * Indicates the call is active.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_STATUS_ACTIVE = 0,
        /**
         * Indicates the call is holding.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_STATUS_HOLDING,
        /**
         * Indicates the call is dialing.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_STATUS_DIALING,
        /**
         * Indicates the call is alerting.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_STATUS_ALERTING,
        /**
         * Indicates the call is incoming.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_STATUS_INCOMING,
        /**
         * Indicates the call is waiting.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_STATUS_WAITING,
        /**
         * Indicates the call is disconnected.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_STATUS_DISCONNECTED,
        /**
         * Indicates the call is disconnecting.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_STATUS_DISCONNECTING,
        /**
         * Indicates the call is idle.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_STATUS_IDLE
    }
    /**
     * Indicates the options of call event.
     *
     * @interface CallEventOptions
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface CallEventOptions {
        /**
         * Indicates the event ID of call ability.
         *
         * @type { CallAbilityEventId }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        eventId: CallAbilityEventId;
    }
    /**
     * Indicates the event ID of call ability.
     *
     * @enum { number }
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum CallAbilityEventId {
        /**
         * Indicates there is no available carrier during dialing.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        EVENT_DIAL_NO_CARRIER = 1,
        /**
         * Indicates invalid FDN.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        EVENT_INVALID_FDN_NUMBER,
        /**
         * Indicates hold call fail.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        EVENT_HOLD_CALL_FAILED,
        /**
         * Indicates swap call fail.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        EVENT_SWAP_CALL_FAILED,
        /**
         * Indicates combine call failed.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        EVENT_COMBINE_CALL_FAILED,
        /**
         * Indicates split call failed.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        EVENT_SPLIT_CALL_FAILED,
        /**
         * Indicates show full screen.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        EVENT_SHOW_FULL_SCREEN,
        /**
         * Indicates show float window.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        EVENT_SHOW_FLOAT_WINDOW
    }
    /**
     * Indicates the states of call.
     *
     * @enum { number }
     * @syscap SystemCapability.Telephony.CallManager
     * @since 20
     */
    export enum CallState {
        /**
         * Indicates an invalid state, which is used when the call state fails to be obtained.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @since 20
         */
        CALL_STATE_UNKNOWN = -1,
        /**
         * Indicates that there is no ongoing call.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @since 20
         */
        CALL_STATE_IDLE = 0,
        /**
         * Indicates that an incoming call is ringing or waiting.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @since 20
         */
        CALL_STATE_RINGING = 1,
        /**
         * Indicates that a least one call is in the dialing, active, or hold state, and there is no new
         * incoming call ringing or waiting.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @since 20
         */
        CALL_STATE_OFFHOOK = 2,
        /**
         * Indicates that call is answered
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @since 20
         */
        CALL_STATE_ANSWERED = 3
    }
    /**
     * Indicates the option for number formatting.
     *
     * @interface NumberFormatOptions
     * @syscap SystemCapability.Telephony.CallManager
     * @since 20
     */
    export interface NumberFormatOptions {
        /**
         * Indicates the country code.
         *
         * @type { ?string }
         * @syscap SystemCapability.Telephony.CallManager
         * @since 20
         */
        countryCode?: string;
    }
    /**
     * Indicates the MMI code result.
     *
     * @interface MmiCodeResults
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface MmiCodeResults {
        /**
         * Indicates the result of MMI code.
         *
         * @type { MmiCodeResult }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        result: MmiCodeResult;
        /**
         * Indicates the message of MMI code.
         *
         * @type { string }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        message: string;
    }
    /**
     * Indicates the MMI code result.
     *
     * @enum { number }
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum MmiCodeResult {
        /**
         * Indicates the result of MMI code with successfully.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        MMI_CODE_SUCCESS = 0,
        /**
         * Indicates the result of MMI code with failed.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        MMI_CODE_FAILED = 1
    }
    /**
     * Indicates the causes of call disconnection.
     *
     * @enum { number }
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum DisconnectedReason {
        /**
         * Indicates the call disconnect due to unassigned number.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        UNASSIGNED_NUMBER = 1,
        /**
         * Indicates the call disconnect due to no route to destination.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NO_ROUTE_TO_DESTINATION = 3,
        /**
         * Indicates the call disconnect due to channel unacceptable.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CHANNEL_UNACCEPTABLE = 6,
        /**
         * Indicates the call disconnect due to operator determined barring.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        OPERATOR_DETERMINED_BARRING = 8,
        /**
         * Indicates the call disconnect due to call completed elsewhere.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_COMPLETED_ELSEWHERE = 13,
        /**
         * Indicates the call disconnect due to normal call clearing.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NORMAL_CALL_CLEARING = 16,
        /**
         * Indicates the call disconnect due to user busy.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        USER_BUSY = 17,
        /**
         * Indicates the call disconnect due to no user responding.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NO_USER_RESPONDING = 18,
        /**
         * Indicates the call disconnect due to user alerting, no answer.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        USER_ALERTING_NO_ANSWER = 19,
        /**
         * Indicates the call disconnect due to call rejected.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_REJECTED = 21,
        /**
         * Indicates the call disconnect due to number changed.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NUMBER_CHANGED = 22,
        /**
         * Indicates the call rejected due to feature at the destination.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_REJECTED_DUE_TO_FEATURE_AT_THE_DESTINATION = 24,
        /**
         * Indicates the call disconnect due to pre-emption.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        FAILED_PRE_EMPTION = 25,
        /**
         * Indicates the call disconnect due to non selected user clearing.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NON_SELECTED_USER_CLEARING = 26,
        /**
         * Indicates the call disconnect due to destination out of order.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DESTINATION_OUT_OF_ORDER = 27,
        /**
         * Indicates the call disconnect due to invalid number format.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        INVALID_NUMBER_FORMAT = 28,
        /**
         * Indicates the call disconnect due to facility rejected.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        FACILITY_REJECTED = 29,
        /**
         * Indicates the call disconnect due to response to status enquiry.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESPONSE_TO_STATUS_ENQUIRY = 30,
        /**
         * Indicates the call disconnected normally, no specified cause.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NORMAL_UNSPECIFIED = 31,
        /**
         * Indicates the call disconnect due to no circuit/channel available.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NO_CIRCUIT_CHANNEL_AVAILABLE = 34,
        /**
         * Indicates the call disconnect due to network out of order.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NETWORK_OUT_OF_ORDER = 38,
        /**
         * Indicates the call disconnect due to temporary failure.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        TEMPORARY_FAILURE = 41,
        /**
         * Indicates the call disconnect due to switching equipment congestion.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SWITCHING_EQUIPMENT_CONGESTION = 42,
        /**
         * Indicates the call disconnect due to access information discarded.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        ACCESS_INFORMATION_DISCARDED = 43,
        /**
         * Indicates the call disconnect due to requested circuit/channel not available.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        REQUEST_CIRCUIT_CHANNEL_NOT_AVAILABLE = 44,
        /**
         * Indicates the call disconnect due to resources unavailable unspecified.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESOURCES_UNAVAILABLE_UNSPECIFIED = 47,
        /**
         * Indicates the call disconnect due to quality of service unavailable.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        QUALITY_OF_SERVICE_UNAVAILABLE = 49,
        /**
         * Indicates the call disconnect due to requested facility not subscribed.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        REQUESTED_FACILITY_NOT_SUBSCRIBED = 50,
        /**
         * Indicates the call disconnect due to incoming calls barred within the CUG.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        INCOMING_CALLS_BARRED_WITHIN_THE_CUG = 55,
        /**
         * Indicates the call disconnect due to bearer capability not authorized.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        BEARER_CAPABILITY_NOT_AUTHORIZED = 57,
        /**
         * Indicates the call disconnect due to bearer capability not presently available.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        BEARER_CAPABILITY_NOT_PRESENTLY_AVAILABLE = 58,
        /**
         * Indicates the call disconnect due to service or option not available, unspecified.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SERVICE_OR_OPTION_NOT_AVAILABLE_UNSPECIFIED = 63,
        /**
         * Indicates the call disconnect due to bearer service not implemented.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        BEARER_SERVICE_NOT_IMPLEMENTED = 65,
        /**
         * Indicates the call disconnect due to ACM equal to or greater than the maximum value.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        ACM_EQUALTO_OR_GREATER_THAN_THE_MAXIMUM_VALUE = 68,
        /**
         * Indicates the call disconnect due to requested facility not implemented.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        REQUESTED_FACILITY_NOT_IMPLEMENTED = 69,
        /**
         * Indicates the call disconnect due to only restricted digital info BC available.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        ONLY_RESTRICTED_DIGITAL_INFO_BEARER_CAPABILITY_IS_AVAILABLE = 70,
        /**
         * Indicates the call disconnect due to service or option not implemented, unspecified.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SERVICE_OR_OPTION_NOT_IMPLEMENTED_UNSPECIFIED = 79,
        /**
         * Indicates the call disconnect due to invalid transaction identifier value.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        INVALID_TRANSACTION_IDENTIFIER_VALUE = 81,
        /**
         * Indicates the call disconnect due to user not member of CUG.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        USER_NOT_MEMBER_OF_CUG = 87,
        /**
         * Indicates the call disconnect due to incompatible destination.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        INCOMPATIBLE_DESTINATION = 88,
        /**
         * Indicates the call disconnect due to invalid transit network selection.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        INVALID_TRANSIT_NETWORK_SELECTION = 91,
        /**
         * Indicates the call disconnect due to semantically incorrect message.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SEMANTICALLY_INCORRECT_MESSAGE = 95,
        /**
         * Indicates the call disconnect due to invalid mandatory information.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        INVALID_MANDATORY_INFORMATION = 96,
        /**
         * Indicates the call disconnect due to msg type non-existent or not implemented.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        MESSAGE_TYPE_NON_EXISTENT_OR_NOT_IMPLEMENTED = 97,
        /**
         * Indicates the call disconnect due to msg type not compatible with protocol state.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        MESSAGE_TYPE_NOT_COMPATIBLE_WITH_PROTOCOL_STATE = 98,
        /**
         * Indicates the call disconnect due to IE non-existent or not implemented.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        INFORMATION_ELEMENT_NON_EXISTENT_OR_NOT_IMPLEMENTED = 99,
        /**
         * Indicates the call disconnect due to conditional IE error.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CONDITIONAL_IE_ERROR = 100,
        /**
         * Indicates the call disconnect due to message not compatible with protocol state.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        MESSAGE_NOT_COMPATIBLE_WITH_PROTOCOL_STATE = 101,
        /**
         * Indicates the call disconnect due to recovery on timer expiry timer number.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RECOVERY_ON_TIMER_EXPIRED = 102,
        /**
         * Indicates the call disconnect due to protocol error, unspecified.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        PROTOCOL_ERROR_UNSPECIFIED = 111,
        /**
         * Indicates the call disconnect due to interworking, unspecified.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        INTERWORKING_UNSPECIFIED = 127,
        /**
         * Indicates the call disconnect due to call barred.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_BARRED = 240,
        /**
         * Indicates the call disconnect due to FDN blocked.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        FDN_BLOCKED = 241,
        /**
         * Indicates the call disconnect due to IMSI in VLR is unknown.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        IMSI_UNKNOWN_IN_VLR = 242,
        /**
         * Indicates the call disconnect due to IMEI not accepted.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        IMEI_NOT_ACCEPTED = 243,
        /**
         * Indicates the call disconnect due to dial modified to USSD.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DIAL_MODIFIED_TO_USSD = 244,
        /**
         * Indicates the call disconnect due to dial modified to SS.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DIAL_MODIFIED_TO_SS = 245,
        /**
         * Indicates the call disconnect due to dial modified to dial.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DIAL_MODIFIED_TO_DIAL = 246,
        /**
         * Indicates the call disconnect due to Radio off.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RADIO_OFF = 247,
        /**
         * Indicates the call disconnect due to out of service.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        OUT_OF_SERVICE = 248,
        /**
         * Indicates the call disconnect due to invalid SIM.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NO_VALID_SIM = 249,
        /**
         * Indicates the call disconnect due to radio internal error.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RADIO_INTERNAL_ERROR = 250,
        /**
         * Indicates the call disconnect due to network response timeout.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NETWORK_RESP_TIMEOUT = 251,
        /**
         * Indicates the call disconnect due to network reject.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NETWORK_REJECT = 252,
        /**
         * Indicates the call disconnect due to radio access failure.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RADIO_ACCESS_FAILURE = 253,
        /**
         * Indicates the call disconnect due to radio link failure.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RADIO_LINK_FAILURE = 254,
        /**
         * Indicates the call disconnect due to radio link lost.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RADIO_LINK_LOST = 255,
        /**
         * Indicates the call disconnect due to radio uplink failure.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RADIO_UPLINK_FAILURE = 256,
        /**
         * Indicates the call disconnect due to radio setup failure.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RADIO_SETUP_FAILURE = 257,
        /**
         * Indicates the call disconnect due to radio release normal.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RADIO_RELEASE_NORMAL = 258,
        /**
         * Indicates the call disconnect due to radio release abnormal.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RADIO_RELEASE_ABNORMAL = 259,
        /**
         * Indicates the call disconnect due to access class blocked.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        ACCESS_CLASS_BLOCKED = 260,
        /**
         * Indicates the call disconnect due to network detach.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NETWORK_DETACH = 261,
        /**
         * Indicates the call disconnect due to invalid parameter.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        INVALID_PARAMETER = 1025,
        /**
         * Indicates the call disconnect due to sim not exit.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SIM_NOT_EXIT = 1026,
        /**
         * Indicates the call disconnect due to sim pin need.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SIM_PIN_NEED = 1027,
        /**
         * Indicates the call disconnect due to call not allow.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        CALL_NOT_ALLOW = 1029,
        /**
         * Indicates the call disconnect due to sim invalid.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SIM_INVALID = 1045,
        /**
         * Indicates the call disconnect due to unknown error.
         *
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        UNKNOWN = 1279
    }
    /**
     * Indicates the cause of a call disconnection.
     *
     * @interface DisconnectedDetails
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface DisconnectedDetails {
        /**
         * Indicates the reason for ending the call.
         *
         * @type { DisconnectedReason }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        reason: DisconnectedReason;
        /**
         * Indicates the message for ending the call.
         *
         * @type { string }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        message: string;
    }
    /**
     * Indicates the ims call mode info of a video call.
     *
     * @interface ImsCallModeInfo
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface ImsCallModeInfo {
        /**
         * Indicates the id of call.
         *
         * @type { number }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        callId: number;
    }
    /**
     * Indicates the call session event of a video call.
     *
     * @interface CallSessionEvent
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface CallSessionEvent {
        /**
         * Indicates the id of call.
         *
         * @type { number }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        callId: number;
    }
    /**
     * Indicates the peer dimension.
     *
     * @interface PeerDimensionsDetail
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface PeerDimensionsDetail {
        /**
         * Indicates the id of call.
         *
         * @type { number }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        callId: number;
    }
    /**
     * Indicates the camera capabilities.
     *
     * @interface CameraCapabilities
     * @syscap SystemCapability.Telephony.CallManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface CameraCapabilities {
        /**
         * Indicates the id of call.
         *
         * @type { number }
         * @syscap SystemCapability.Telephony.CallManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        callId: number;
    }
}
export default call;
