/*
 * Copyright (c) 2022-2025 Huawei Device Co., Ltd.
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
 * @kit AbilityKit
 */


/**
 * The <code>AbilityConstant</code> module defines the UIAbility-related enums, including the initial launch reasons,
 * reasons for the last exit, ability continuation results, and window modes.
 *
 * @namespace AbilityConstant
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @stagemodelonly
 * @since 20
 */
declare namespace AbilityConstant {
    
    
    /**
     * Defines the parameters for starting an ability.
     * The parameter values are automatically passed in by the system when the ability is started. You do not need to
     * change the values.
     *
     * @typedef LaunchParam
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export interface LaunchParam {
        
        
        /**
         * Ability launch reason, which is an enumerated type.
         *
         * @type { LaunchReason }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        launchReason: LaunchReason;
        /**
         * Detailed message that describes the ability launch reason.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        launchReasonMessage?: string;
        
        
        /**
         * Reason for the last exit, which is an enumerated type.
         *
         * @type { LastExitReason }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        lastExitReason: LastExitReason;
        /**
         * Reason for the last exit.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        lastExitMessage: string;
        /**
         * Detailed information about the last exit.
         *
         * @type { LastExitDetailInfo }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        lastExitDetailInfo?: LastExitDetailInfo;
    }
    /**
     * Describes the detailed information about the last exit.
     *
     * @typedef LastExitDetailInfo
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export interface LastExitDetailInfo {
        /**
         * ID of the process where the ability is running when it exits last time.
         *
         * @type { int }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        pid: int;
        /**
         * Name of the process.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        processName: string;
        /**
         * UID of the application.
         *
         * @type { int }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        uid: int;
        /**
         * Specific reason for the last exit of the ability.
         *
         * @type { int }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        exitSubReason: int;
        /**
         * Reason why the process was killed.
         *
         * @type { string }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        exitMsg: string;
        /**
         * RSS value of the process.
         *
         * @type { int }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        rss: int;
        /**
         * PSS value of the process.
         *
         * @type { int }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        pss: int;
        /**
         * Exact time when the ability last exits.
         *
         * @type { long }
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        timestamp: long;
    }
    
    
    /**
     * Enumerates the initial ability launch reasons.
     * You can use it together with the value of <code>launchParam.launchReason</code> in
     * <code>onCreate(want, launchParam)</code> of the UIAbility to complete different operations.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export enum LaunchReason {
        
        
        /**
         * Unknown reason.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        UNKNOWN = 0,
        
        /**
         * The ability is started by calling <code>startAbility</code>.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        START_ABILITY = 1,
        
        /**
         * The ability is started by calling <code>startAbilityByCall</code>.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        CALL = 2,
        
        /**
         * The ability is started by means of cross-device migration.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        CONTINUATION = 3,
        
        /**
         * The ability is automatically started when the application is restored from a fault.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        APP_RECOVERY = 4,
        
        /**
         * The ability is started by means of atomic service sharing.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        SHARE = 5,
        /**
         * The ability is automatically started upon system boot.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        AUTO_STARTUP = 8,
        /**
         * The ability is started by the InsightIntent framework.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        INSIGHT_INTENT = 9,
        /**
         * The ability is started in advance during cross-device migration.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        PREPARE_CONTINUATION = 10,
        /**
         * Start by preload.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        PRELOAD = 11
    }
    
    
    /**
     * Enumerates the reasons for the last exit.
     * You can use it together with the value of <code>launchParam.lastExitReason</code> in
     * <code>onCreate(want, launchParam)</code> of the UIAbility to complete different operations.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export enum LastExitReason {
        
        
        /**
         * Unknown reason.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        UNKNOWN = 0,
        
        /**
         * The ability exits normally because the user closes the application.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        NORMAL = 2,
        
        /**
         * The ability exits due to abnormal signals on the local host.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        CPP_CRASH = 3,
        
        /**
         * The ability exits due to a JS_ERROR fault triggered when an application has a JS syntax error that is not
         * captured by developers.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        JS_ERROR = 4,
        
        /**
         * The ability exits because watchdog detects that the application is frozen.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        APP_FREEZE = 5,
        
        /**
         * The ability exits due to system performance problems, for example, insufficient device memory.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        PERFORMANCE_CONTROL = 6,
        
        /**
         * The ability exits due to improper use of system resources. The specific error cause can be obtained through
         * LaunchParam.lastExitMessage. The possible causes are as follows:
         * - CPU Highload: The CPU load is high.
         * - CPU_EXT Highload: A fast CPU load detection is carried out.
         * - IO Manage Control: An I/O management and control operation is carried out.
         * - App Memory Deterioration: The application memory usage exceeds the threshold.
         * - Temperature Control: The temperature is too high or too low.
         * - Memory Pressure: The system is low on memory, triggering ability exiting in ascending order of priority.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        RESOURCE_CONTROL = 7,
        
        /**
         * The ability exits due to an update.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        UPGRADE = 8,
        /**
         * The ability exits because of an action in the multitasking center, for example, when users swipe up or hit the
         * one-click clean button in the multitasking view.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        USER_REQUEST = 9,
        /**
         * The ability exits because it receives a kill signal from the system.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        SIGNAL = 10
    }
    
    /**
     * Enumerates the ability continuation results.
     * You can use it together with <code>onContinue(wantParam)</code> of the UIAbility to complete different
     * operations.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export enum OnContinueResult {
        
        /**
         * The ability continuation is accepted.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        AGREE = 0,
        
        /**
         * The ability continuation is rejected.
         * If the application is abnormal in onContinue, which results in abnormal display during data restoration, this
         * error code is returned.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        REJECT = 1,
        
        /**
         * The version does not match.
         * The application on the initiator can obtain the version of the target application from onContinue. If the
         * ability continuation cannot be performed due to version mismatch, this error code is returned.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        MISMATCH = 2
    }
    
    /**
     * Enumerates the memory levels. You can use it in <code>onMemoryLevel(level)</code> of the UIAbility to complete
     * different operations.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export enum MemoryLevel {
        
        /**
         * Moderate memory usage.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        MEMORY_LEVEL_MODERATE = 0,
        
        /**
         * Low memory usage.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        MEMORY_LEVEL_LOW = 1,
        
        /**
         * High memory usage.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        MEMORY_LEVEL_CRITICAL = 2
    }
    /**
     * Enumerates the window mode when the ability is started.
     * It can be used together with <code>startAbility</code> to specify the window mode for starting the ability.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export enum WindowMode {
        /**
         * Undefined window mode.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        WINDOW_MODE_UNDEFINED = 0,
        /**
         * Full screen mode. It takes effect only on 2-in-1 devices and tablets.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        WINDOW_MODE_FULLSCREEN = 1,
        /**
         * Primary screen (left screen in the case of horizontal orientation) in split-screen mode. It is valid only in
         * intra-app redirection scenarios.
         * It takes effect only on foldable devices and tablets.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        WINDOW_MODE_SPLIT_PRIMARY = 100,
        /**
         * Secondary screen (right screen in the case of horizontal orientation) in split-screen mode. It is valid only in
         * intra-app redirection scenarios.
         * It takes effect only on foldable devices and tablets.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        WINDOW_MODE_SPLIT_SECONDARY = 101,
        /**
         * The ability is displayed in a floating window.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        WINDOW_MODE_FLOATING = 102
    }
    
    /**
     * Enumerates the result types for the operation of saving application data. You can use it in
     * <code>onSaveState(reason, wantParam)</code> of the UIAbility to complete different operations.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export enum OnSaveResult {
        
        /**
         * Always agreed to save the status.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        ALL_AGREE = 0,
        
        /**
         * Rejected to save the status in continuation.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        CONTINUATION_REJECT = 1,
        
        /**
         * Continuation mismatch.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        CONTINUATION_MISMATCH = 2,
        
        /**
         * Agreed to restore the saved status.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        RECOVERY_AGREE = 3,
        
        /**
         * Rejected to restore the saved status.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        RECOVERY_REJECT = 4,
        
        /**
         * Always rejected to save the status.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        ALL_REJECT
    }
    
    /**
     * Enumerates the scenarios for saving application data. You can use it in
     * <code>onSaveState(reason, wantParam)</code> of the UIAbility to complete different operations.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export enum StateType {
        
        /**
         * Saving the status in continuation.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        CONTINUATION = 0,
        
        /**
         * Saving the status in application recovery.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        APP_RECOVERY = 1
    }
    
    /**
     * Enumerates the mission continuation states of the application. It is used in the
     * <code>setMissionContinueState</code> API of UIAbilityContext.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export enum ContinueState {
        
        /**
         * Mission continuation is activated for the current application.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        ACTIVE = 0,
        
        /**
         * Mission continuation is not activated for the current application.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        INACTIVE = 1
    }
    /**
     * Enumerates the collaboration request results.
     * This enum is used in multi-device collaboration scenarios to specify whether the target application accepts the
     * collaboration request from the caller application.
     * It is used in <code>onCollaborate(wantParam)</code> of the UIAbility.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export enum CollaborateResult {
        /**
         * 	Accepts the collaboration request.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        ACCEPT = 0,
        /**
         * Rejects the collaboration request.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        REJECT = 1
    }
    /**
     * Enumerates the actions triggered when an application is closed by the user. It must be used together with
     * <code>onPrepareTermination</code> or <code>onPrepareTerminationAsync</code> of AbilityStage.
     *
     * @enum { number }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    export enum PrepareTermination {
        /**
         * Executes the termination action immediately. This is the default behavior.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        TERMINATE_IMMEDIATELY = 0,
        /**
         * Cancels the termination action.
         *
         * @syscap SystemCapability.Ability.AbilityRuntime.Core
         * @stagemodelonly
         * @since 20
         */
        CANCEL = 1
    }
}
export default AbilityConstant;
