/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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
import { Callback } from './@ohos.base';
/**
 * systemScreenLock
 *
 * @namespace screenLock
 * @syscap SystemCapability.MiscServices.ScreenLock
 * @since 20
 */
declare namespace screenLock {
    /**
     * Checks whether the screen is currently locked.
     *
     * @returns { boolean } returns true if the screen is currently locked, returns false otherwise.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function isLocked(): boolean;
    
    /**
     * Unlock the screen.
     *
     * @param { AsyncCallback<boolean> } callback - the callback of unlock.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @throws { BusinessError } 13200003 - Invalid use.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function unlock(callback: AsyncCallback<boolean>): void;
    
    /**
     * Unlock the screen.
     *
     * @returns { Promise<boolean> } the promise returned by the function.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @throws { BusinessError } 13200003 - Invalid use.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function unlock(): Promise<boolean>;
    /**
     * Lock the screen.
     *
     * @permission ohos.permission.ACCESS_SCREEN_LOCK_INNER
     * @param { AsyncCallback<boolean> } callback - the callback of lock.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function lock(callback: AsyncCallback<boolean>): void;
    /**
     * Lock the screen.
     *
     * @permission ohos.permission.ACCESS_SCREEN_LOCK_INNER
     * @returns { Promise<boolean> } the promise returned by the function.
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function lock(): Promise<boolean>;
    
    /**
     * Indicates the system event type related to the screenlock management service. Adding strongAuthChanged and screenLockDisabledChanged.
     *
     * @typedef {('beginWakeUp' | 'endWakeUp' | 'beginScreenOn' | 'endScreenOn' | 'beginScreenOff' | 'endScreenOff' | 'unlockScreen'
     * | 'lockScreen' | 'beginExitAnimation' | 'beginSleep' | 'endSleep' | 'changeUser' | 'screenlockEnabled' | 'serviceRestart'
     * | 'strongAuthChanged' | 'screenLockDisabledChanged')}
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    type EventType = 'beginWakeUp' | 'endWakeUp' | 'beginScreenOn' | 'endScreenOn' | 'beginScreenOff' | 'endScreenOff' | 'unlockScreen' | 'lockScreen' | 'beginExitAnimation' | 'beginSleep' | 'endSleep' | 'changeUser' | 'screenlockEnabled' | 'serviceRestart' | 'strongAuthChanged' | 'screenLockDisabledChanged';
    /**
     * Indicates the system event type and parameter related to the screenlock management service.
     *
     * @typedef SystemEvent
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface SystemEvent {
        /**
         * Indicates the system event type related to the screenlock management service.
         *
         * @type { EventType }
         * @syscap SystemCapability.MiscServices.ScreenLock
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        eventType: EventType;
        /**
         * Identifies the customized extended parameter of an event.
         *
         * @type { string }
         * @syscap SystemCapability.MiscServices.ScreenLock
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        params: string;
    }
    /**
     * Register system event related to screen lock service.
     *
     * @permission ohos.permission.ACCESS_SCREEN_LOCK_INNER
     * @param { Callback<SystemEvent> } callback - the callback of onSystemEvent.
     * @returns { boolean } returns true if register system event is success, returns false otherwise.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function onSystemEvent(callback: Callback<SystemEvent>): boolean;
    /**
     * The screen lock app sends the event to the screen lock service.
     *
     * @permission ohos.permission.ACCESS_SCREEN_LOCK_INNER
     * @param { String } event - event type.
     * @param { number } parameter - operation result of the event.
     * @param { AsyncCallback<boolean> } callback - the callback of sendScreenLockEvent.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function sendScreenLockEvent(event: String, parameter: number, callback: AsyncCallback<boolean>): void;
    /**
     * The screen lock app sends the event to the screen lock service.
     *
     * @permission ohos.permission.ACCESS_SCREEN_LOCK_INNER
     * @param { String } event - event type.
     * @param { number } parameter - operation result of the event.
     * @returns { Promise<boolean> } the promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function sendScreenLockEvent(event: String, parameter: number): Promise<boolean>;
    /**
     * Obtain strong authentication reason flags for os account local userId.
     *
     * @permission ohos.permission.ACCESS_SCREEN_LOCK
     * @param { number } userId - Os account local userId.
     * @returns { number } the strong authentication reason flags.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getStrongAuth(userId: number): number;
    /**
     * Disable screen lock showing for os account local userId. This only becomes effective when there is no password.
     *
     * @permission ohos.permission.ACCESS_SCREEN_LOCK
     * @param { boolean } disable - disable or enable screen lock showing.
     * @param { number } userId - Os account local userId.
     * @returns { Promise<boolean> } the promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function setScreenLockDisabled(disable: boolean, userId: number): Promise<boolean>;
    /**
     * Check whether screen lock is disabled for os account local userId.
     *
     * @permission ohos.permission.ACCESS_SCREEN_LOCK
     * @param { number } userId - Os account local userId.
     * @returns { boolean } whether screen lock is disabled.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function isScreenLockDisabled(userId: number): boolean;
    /**
     * Set the screen lock authentication state for os account local userId.
     *
     * @permission ohos.permission.ACCESS_SCREEN_LOCK_INNER
     * @param { AuthState } state - the screen lock authentication state.
     * @param { number } userId - Os account local userId.
     * @param { Uint8Array } authToken - the authentication token for this state
     * @returns { Promise<boolean> } the promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function setScreenLockAuthState(state: AuthState, userId: number, authToken: Uint8Array): Promise<boolean>;
    /**
     * Obtain the screen lock authentication state for os account local userId.
     *
     * @permission ohos.permission.ACCESS_SCREEN_LOCK
     * @param { number } userId - Os account local userId.
     * @returns { AuthState } the screen lock authentication state.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 13200002 - the screenlock management service is abnormal.
     * @syscap SystemCapability.MiscServices.ScreenLock
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getScreenLockAuthState(userId: number): AuthState;
}
export default screenLock;
