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
 * @kit AbilityKit
 */
import { AsyncCallback } from './@ohos.base';
import { ProcessInformation as _ProcessInformation } from './application/ProcessInformation';
import bundleManager from './@ohos.bundle.bundleManager';
import { RunningMultiAppInfo as _RunningMultiAppInfo } from './application/RunningMultiAppInfo';
import _ApplicationStateObserver from './application/ApplicationStateObserver';
import _AbilityStateData from './application/AbilityStateData';
import _AppStateData from './application/AppStateData';
import _ProcessData from './application/ProcessData';
import _AppForegroundStateObserver from './application/AppForegroundStateObserver';
import { AbilityFirstFrameStateObserver as _AbilityFirstFrameStateObserver } from './application/AbilityFirstFrameStateObserver';
import { AbilityFirstFrameStateData as _AbilityFirstFrameStateData } from './application/AbilityFirstFrameStateData';

/**
 * This module provides the function of app manager service.
 *
 * @namespace appManager
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
declare namespace appManager {
    /**
     * Enum for the application state
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    export enum ApplicationState {
        /**
         * The state in which the application is being created.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @since 20
         */
        STATE_CREATE,
        /**
         * The state that the application is in when it switches to the foreground.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @since 20
         */
        STATE_FOREGROUND,
        /**
         * The state in which the application is in focus.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @since 20
         */
        STATE_ACTIVE,
        /**
         * The state in which the application is invisible in the background.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @since 20
         */
        STATE_BACKGROUND,
        /**
         * The state that the application is in when it is destroyed.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @since 20
         */
        STATE_DESTROY
    }
    
    /**
     * Enum for the process state
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    export enum ProcessState {
        
        /**
         * The state that the process is in when it is being created.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @since 20
         */
        STATE_CREATE,
        
        /**
         * The state in which the process is in when it switches to the foreground.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @since 20
         */
        STATE_FOREGROUND,
        
        /**
         * The state in which the process is in focus.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @since 20
         */
        STATE_ACTIVE,
        
        /**
         * The state in which a process is invisible in the background.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @since 20
         */
        STATE_BACKGROUND,
        
        /**
         * The state that the process is in when it is destroyed.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @since 20
         */
        STATE_DESTROY
    }
    /**
     * Enum for the preload mode
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    export enum PreloadMode {
        /**
         * Preload application when press the app icon down.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        PRESS_DOWN
    }
    /**
     * Indicates the type of keep-alive apps.
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @systemapi
     * @since 20
     */
    export enum KeepAliveAppType {
        /**
         * All apps.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
         * @systemapi
         * @since 20
         */
        ALL = 0,
        /**
         * 3rd party app.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
         * @systemapi
         * @since 20
         */
        THIRD_PARTY = 1,
        /**
         * System app.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
         * @systemapi
         * @since 20
         */
        SYSTEM = 2
    }
    /**
     * Setter who sets the keep-alive flag for a bundle.
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @systemapi
     * @since 20
     */
    export enum KeepAliveSetter {
        /**
         * Indicates the bundle is set keep-alive by system.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
         * @systemapi
         * @since 20
         */
        SYSTEM = 0,
        /**
         * Indicates the bundle is set keep-alive by user.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
         * @systemapi
         * @since 20
         */
        USER = 1
    }
    /**
     * The class of keep-alive bundle information.
     *
     * @typedef KeepAliveBundleInfo
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    export interface KeepAliveBundleInfo {
        /**
         * The name of the bundle.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @since 20
         */
        bundleName: string;
        /**
         * App type.
         *
         * @type { KeepAliveAppType }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @since 20
         */
        type: KeepAliveAppType;
        /**
         * The setter who sets the keep-alive flag.
         *
         * @type { KeepAliveSetter }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @since 20
         */
        setter: KeepAliveSetter;
    }
    /**
     * Register application state observer.
     *
     * @permission ohos.permission.RUNNING_STATE_OBSERVER
     * @param { 'applicationState' } type - applicationState.
     * @param { ApplicationStateObserver } observer - The application state observer.
     * @returns { int } Returns the number code of the observer.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function on(type: 'applicationState', observer: ApplicationStateObserver): int;
    /**
     * Register application state observer.
     *
     * @permission ohos.permission.RUNNING_STATE_OBSERVER
     * @param { 'applicationState' } type - applicationState.
     * @param { ApplicationStateObserver } observer - The application state observer.
     * @param { Array<string> } bundleNameList - The list of bundleName. The max length is 128.
     * @returns { int } Returns the number code of the observer.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function on(type: 'applicationState', observer: ApplicationStateObserver, bundleNameList: Array<string>): int;
    /**
     * Register app foreground or background state observer.
     *
     * @permission ohos.permission.RUNNING_STATE_OBSERVER
     * @param { 'appForegroundState' } type - app foreground or background state.
     * @param { AppForegroundStateObserver } observer - The app foreground state observer.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function on(type: 'appForegroundState', observer: AppForegroundStateObserver): void;
    /**
     * Register ability first frame state observe.
     *
     * @permission ohos.permission.RUNNING_STATE_OBSERVER
     * @param { 'abilityFirstFrameState' } type - The ability first frame drawing state.
     * @param { AbilityFirstFrameStateObserver } observer - The ability first frame state observer.
     * @param { string } [bundleName] - The target bundle name.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function on(type: 'abilityFirstFrameState', observer: AbilityFirstFrameStateObserver, bundleName?: string): void;
    /**
     * Unregister application state observer.
     *
     * @permission ohos.permission.RUNNING_STATE_OBSERVER
     * @param { 'applicationState' } type - applicationState.
     * @param { int } observerId - Indicates the number code of the observer.
     * @param { AsyncCallback<void> } callback - The callback of off.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function off(type: 'applicationState', observerId: int, callback: AsyncCallback<void>): void;
    /**
     * Unregister application state observer.
     *
     * @permission ohos.permission.RUNNING_STATE_OBSERVER
     * @param { 'applicationState' } type - applicationState.
     * @param { int } observerId - Indicates the number code of the observer.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function off(type: 'applicationState', observerId: int): Promise<void>;
    /**
     * Unregister app foreground or background state observer.
     *
     * @permission ohos.permission.RUNNING_STATE_OBSERVER
     * @param { 'appForegroundState' } type - app foreground or background state.
     * @param { AppForegroundStateObserver } [observer] - The app foreground state observer.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function off(type: 'appForegroundState', observer?: AppForegroundStateObserver): void;
    /**
     * Unregister ability first frame state observer.
     *
     * @permission ohos.permission.RUNNING_STATE_OBSERVER
     * @param { 'abilityFirstFrameState' } type - The ability first frame drawing state.
     * @param { AbilityFirstFrameStateObserver } [observer] - The ability first frame state observer.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function off(type: 'abilityFirstFrameState', observer?: AbilityFirstFrameStateObserver): void;
    /**
     * getForegroundApplications.
     *
     * @permission ohos.permission.GET_RUNNING_INFO
     * @param { AsyncCallback<Array<AppStateData>> } callback - The callback is used to return the list of AppStateData.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getForegroundApplications(callback: AsyncCallback<Array<AppStateData>>): void;
    /**
     * getForegroundApplications.
     *
     * @permission ohos.permission.GET_RUNNING_INFO
     * @returns { Promise<Array<AppStateData>> } Returns the list of AppStateData.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getForegroundApplications(): Promise<Array<AppStateData>>;
    
    /**
     * Kill process with account.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS and ohos.permission.KILL_APP_PROCESSES
     *     or ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS and ohos.permission.CLEAN_BACKGROUND_PROCESSES
     * @param { string } bundleName - The process bundle name.
     * @param { int } accountId - The account id.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     *     2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function killProcessWithAccount(bundleName: string, accountId: int): Promise<void>;
    /**
     * Kill process with account.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS and ohos.permission.KILL_APP_PROCESSES
     *     or ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS and ohos.permission.CLEAN_BACKGROUND_PROCESSES
     * @param { string } bundleName - The process bundle name.
     * @param { int } accountId - The account id.
     * @param { boolean } clearPageStack - The flag that indicates whether the page stack need to be cleared.
     * @param { int } [appIndex] - The application index.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - If the input parameter is not valid parameter.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function killProcessWithAccount(bundleName: string, accountId: int, clearPageStack: boolean, appIndex?: int): Promise<void>;
    
    /**
     * Kill process with account.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS and ohos.permission.KILL_APP_PROCESSES
     *     or ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS and ohos.permission.CLEAN_BACKGROUND_PROCESSES
     * @param { string } bundleName - The process bundle name.
     * @param { int } accountId - The account id.
     * @param { AsyncCallback<void> } callback - The callback of killProcessWithAccount.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     *     2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function killProcessWithAccount(bundleName: string, accountId: int, callback: AsyncCallback<void>): void;
    
    /**
     * Is user running in stability test.
     *
     * @param { AsyncCallback<boolean> } callback - The callback is used to return true if user is running stability test.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function isRunningInStabilityTest(callback: AsyncCallback<boolean>): void;
    
    /**
     * Is user running in stability test.
     *
     * @returns { Promise<boolean> } Returns true if user is running stability test.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function isRunningInStabilityTest(): Promise<boolean>;
    
    /**
     * Kill processes by bundle name
     *
     * @permission ohos.permission.KILL_APP_PROCESSES or ohos.permission.CLEAN_BACKGROUND_PROCESSES
     * @param { string } bundleName - bundle name.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     *     2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function killProcessesByBundleName(bundleName: string): Promise<void>;
    /**
     * Kill processes by bundle name
     *
     * @permission ohos.permission.KILL_APP_PROCESSES or ohos.permission.CLEAN_BACKGROUND_PROCESSES
     * @param { string } bundleName - bundle name.
     * @param { boolean } clearPageStack - The flag that indicates whether the page stack need to be cleared.
     * @param { int } [appIndex] - The index of clone app.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - If the input parameter is not valid parameter.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function killProcessesByBundleName(bundleName: string, clearPageStack: boolean, appIndex?: int): Promise<void>;
    
    /**
     * Is it a ram-constrained device
     *
     * @returns { Promise<boolean> } Returns true if the device is ram-constrained.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function isRamConstrainedDevice(): Promise<boolean>;
    
    /**
     * Is it a ram-constrained device
     *
     * @param { AsyncCallback<boolean> } callback - The callback is used to return true if the device is ram-constrained.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function isRamConstrainedDevice(callback: AsyncCallback<boolean>): void;
    
    /**
     * Get the memory size of the application
     *
     * @returns { Promise<int> } Returns the application memory size.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function getAppMemorySize(): Promise<int>;
    
    /**
     * Get the memory size of the application
     *
     * @param { AsyncCallback<int> } callback - The callback is used to return the application memory size.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function getAppMemorySize(callback: AsyncCallback<int>): void;
    
    /**
     * Get information about the current process.
     *
     * @returns { Promise<Array<ProcessInformation>> } Returns the array of {@link ProcessInformation}.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function getRunningProcessInformation(): Promise<Array<ProcessInformation>>;
    /**
     * Get running process information by bundle type.
     *
     * @permission ohos.permission.GET_RUNNING_INFO
     * @param { bundleManager.BundleType } bundleType - the bundle type of the process
     * @returns { Promise<Array<ProcessInformation>> } Returns the array of {@link ProcessInformation}.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getRunningProcessInformationByBundleType(bundleType: bundleManager.BundleType): Promise<Array<ProcessInformation>>;
    
    /**
     * Get information about the current process.
     *
     * @param { AsyncCallback<Array<ProcessInformation>> } callback - The callback is used to return the array of {@link ProcessInformation}.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    function getRunningProcessInformation(callback: AsyncCallback<Array<ProcessInformation>>): void;
    /**
     * Check whether the shared bundle is running.
     *
     * @permission ohos.permission.GET_RUNNING_INFO
     * @param { string } bundleName - Indicates the bundle name of the shared bundle.
     * @param { long } versionCode - Indicates the version code of the shared bundle.
     * @returns { Promise<boolean> } Returns the shared bundle running result. The result is true if running, false otherwise.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function isSharedBundleRunning(bundleName: string, versionCode: long): Promise<boolean>;
    /**
     * Check whether the shared bundle is running.
     *
     * @permission ohos.permission.GET_RUNNING_INFO
     * @param { string } bundleName - Indicates the bundle name of the shared bundle.
     * @param { long } versionCode - Indicates the version code of the shared bundle.
     * @param { AsyncCallback<boolean> } callback - The callback of checking the shared bundle running result.
     *                                              The result is true if running, false otherwise.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function isSharedBundleRunning(bundleName: string, versionCode: long, callback: AsyncCallback<boolean>): void;
    /**
     * Obtains memory usage of one process by its pid.
     *
     * @param { int } pid - Indicates the pid of the process.
     * @returns { Promise<int> } Returns the memory usage of the process in KB.
     * @throws { BusinessError } 202 - Permission denied, non-system app called system api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getProcessMemoryByPid(pid: int): Promise<int>;
    /**
     * Obtains memory usage of one process by its pid.
     *
     * @param { int } pid - Indicates the pid of the process.
     * @param { AsyncCallback<int> } callback - Indicates the callback of getting process memory by pid result.
     * @throws { BusinessError } 202 - Permission denied, non-system app called system api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getProcessMemoryByPid(pid: int, callback: AsyncCallback<int>): void;
    /**
     * Obtains the process information list of running processes that belong to a specific bundle of current user.
     *
     * @param { string } bundleName - Indicates the bundle name of the application to which the processes belong to.
     * @param { AsyncCallback<Array<ProcessInformation>> } callback - Indicates the callback of getting process information by bundleName result.
     * @throws { BusinessError } 202 - Permission denied, non-system app called system api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getRunningProcessInfoByBundleName(bundleName: string, callback: AsyncCallback<Array<ProcessInformation>>): void;
    /**
     * Obtains the process information list of running processes that belong to a specific bundle and specific user ID.
     *
     * @param { string } bundleName - Indicates the bundle name of the application to which the processes belong to.
     * @param { int } userId - Indicates the user ID of the application to which the processes belong to.
     * @param { AsyncCallback<Array<ProcessInformation>> } callback - Indicates the callback of getting process information by bundleName result.
     * @throws { BusinessError } 202 - Permission denied, non-system app called system api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getRunningProcessInfoByBundleName(bundleName: string, userId: int, callback: AsyncCallback<Array<ProcessInformation>>): void;
    /**
     * Obtains the process information list of running processes that belong to a specific bundle of current user.
     *
     * @param { string } bundleName - Indicates the bundle name of the application to which the processes belong to.
     * @returns { Promise<Array<ProcessInformation>> } Returns a list of process information.
     * @throws { BusinessError } 202 - Permission denied, non-system app called system api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getRunningProcessInfoByBundleName(bundleName: string): Promise<Array<ProcessInformation>>;
    /**
     * Obtains the process information list of running processes that belong to a specific bundle and specific user ID.
     *
     * @param { string } bundleName - Indicates the bundle name of the application to which the processes belong to.
     * @param { int } userId - Indicates the user ID of the application to which the processes belong to.
     * @returns { Promise<Array<ProcessInformation>> } Returns a list of process information.
     * @throws { BusinessError } 202 - Permission denied, non-system app called system api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getRunningProcessInfoByBundleName(bundleName: string, userId: int): Promise<Array<ProcessInformation>>;
    /**
     * Preload the target application, create process and initialize resources.
     *
     * @permission ohos.permission.PRELOAD_APPLICATION
     * @param { string } bundleName - The bundle name of the application to preload.
     * @param { int } userId - Indicates the user identification.
     * @param { PreloadMode } mode - Preload application mode.
     * @param { int } [appIndex] - The index of application clone.
     * @returns { Promise<void> } Returns the result of preloadApplication.
     * @throws { BusinessError } 201 - The application does not have permission to call the interface.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16300005 - The target bundle does not exist.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function preloadApplication(bundleName: string, userId: int, mode: PreloadMode, appIndex?: int): Promise<void>;
    /**
     * Get all running multi app info by bundleName
     *
     * @permission ohos.permission.GET_RUNNING_INFO
     * @param { string } bundleName - The bundle name of the application to query.
     * @returns { Promise<RunningMultiAppInfo> } Returns the {@link RunningMultiAppInfo} for given bundle.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16000072 - App clone or multi-instance is not supported.
     * @throws { BusinessError } 18500001 - The bundle does not exist or no patch has been applied.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function getRunningMultiAppInfo(bundleName: string): Promise<RunningMultiAppInfo>;
    /**
    * Check whether the bundle is running.
    *
    * @permission ohos.permission.GET_RUNNING_INFO
    * @param { string } bundleName - Indicates the bundle name of the bundle.
    * @param { int } [appCloneIndex] - app clone index
    * @returns { Promise<boolean> } Returns the bundle running result. The result is true if running, false otherwise.
    * @throws { BusinessError } 201 - Permission denied.
    * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
    * 2. Incorrect parameter types; 3. Parameter verification failed.
    * @throws { BusinessError } 16000050 - Internal error.
    * @throws { BusinessError } 16000073 - The app clone index is invalid.
    * @syscap SystemCapability.Ability.AbilityRuntime.Core
    * @since 20
    */
    function isAppRunning(bundleName: string, appCloneIndex?: int): Promise<boolean>;
    /**
     * Get pids of processes which belong to specific bundle name and support process cache feature.
     *
     * @permission ohos.permission.GET_RUNNING_INFO
     * @param { string } bundleName - bundle name.
     * @returns { Promise<Array<int>> } Returns the list of pid.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function getSupportedProcessCachePids(bundleName: string): Promise<Array<int>>;
    /**
     * Set keep alive for the specified bundle.
     *
     * @permission ohos.permission.MANAGE_APP_KEEP_ALIVE
     * @param { string } bundleName - bundle name.
     * @param { int } userId - user id.
     * @param { boolean } enable - flag indicates whether the bundle should be kept alive.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16300005 - The target bundle does not exist.
     * @throws { BusinessError } 16300008 - The target bundle has no MainAbility.
     * @throws { BusinessError } 16300009 - The target bundle has no status-bar ability.
     * @throws { BusinessError } 16300010 - The target application is not attached to the status bar.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function setKeepAliveForBundle(bundleName: string, userId: int, enable: boolean): Promise<void>;
    /**
     * Get keep-alive bundle information.
     *
     * @permission ohos.permission.MANAGE_APP_KEEP_ALIVE
     * @param { KeepAliveAppType } type - type of keep-alive apps to be quried.
     * @param { int } [userId] - user id.
     * @returns { Promise<Array<KeepAliveBundleInfo>> } Returns the list of KeepAliveBundleInfo.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function getKeepAliveBundles(type: KeepAliveAppType, userId?: int): Promise<Array<KeepAliveBundleInfo>>;
    /**
     * Kill processes in batch.
     *
     * @permission ohos.permission.KILL_APP_PROCESSES
     * @param { Array<int> } pids - The pids of the processes.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     *     2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    function killProcessesInBatch(pids: Array<int>): Promise<void>;
    /**
     * The ability or extension state data.
     *
     * @typedef { _AbilityStateData }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    export type AbilityStateData = _AbilityStateData;
    /**
     * The application state data.
     *
     * @typedef { _AppStateData }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    export type AppStateData = _AppStateData;
    /**
     * The application state observer.
     *
     * @typedef { _ApplicationStateObserver }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    export type ApplicationStateObserver = _ApplicationStateObserver;
    /**
     * The application foreground state observer.
     *
     * @typedef { _AppForegroundStateObserver }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    export type AppForegroundStateObserver = _AppForegroundStateObserver;
    
    /**
     * The class of a process information.
     *
     * @typedef { _ProcessInformation }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    export type ProcessInformation = _ProcessInformation;
    /**
     * The application state data.
     *
     * @typedef { _ProcessData }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    export type ProcessData = _ProcessData;
    /**
     * The ability first frame state observer.
     *
     * @typedef { _AbilityFirstFrameStateObserver }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    export type AbilityFirstFrameStateObserver = _AbilityFirstFrameStateObserver;
    /**
     * The class of an ability first frame state data.
     *
     * @typedef { _AbilityFirstFrameStateData }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    export type AbilityFirstFrameStateData = _AbilityFirstFrameStateData;
    /**
     * The class of running multi app information.
     *
     * @typedef { _RunningMultiAppInfo }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @since 20
     */
    export type RunningMultiAppInfo = _RunningMultiAppInfo;
}
export default appManager;
