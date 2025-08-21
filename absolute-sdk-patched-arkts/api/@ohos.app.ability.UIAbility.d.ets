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
import Ability from './@ohos.app.ability.Ability';
import AbilityConstant from './@ohos.app.ability.AbilityConstant';
import Want from './@ohos.app.ability.Want';
import window from './@ohos.window';
import UIAbilityContext from './application/UIAbilityContext';
import rpc from './@ohos.rpc';
/**
 * The prototype of the listener function interface registered by the Caller.
 * Defines the callback of OnRelease.
 *
 * @typedef OnReleaseCallback
 * @param { string } msg - The notification event string listened to by the OnRelease.
 * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
 * @stagemodelonly
 * @since 20
 */
export type OnReleaseCallback = (msg: string) => void;
/**
 * The prototype of the listener function interface registered by the Caller.
 * Defines the callback of OnRemoteStateChange.
 *
 * @typedef OnRemoteStateChangeCallback
 * @param { string } msg - The notification event string listened to by the OnRemoteStateChange.
 * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
 * @stagemodelonly
 * @since 20
 */
export type OnRemoteStateChangeCallback = (msg: string) => void;
/**
 * The prototype of the message listener function interface registered by the Callee.
 * Defines the callback of the registration message notification of the UIAbility.
 *
 * @typedef CalleeCallback
 * @param { rpc.MessageSequence } indata - Data to be transferred.
 * @returns { rpc.Parcelable } Returned data object.
 * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
 * @stagemodelonly
 * @since 20
 */
export type CalleeCallback = (indata: rpc.MessageSequence) => rpc.Parcelable;
/**
 * Implements sending of parcelable data to the target UIAbility when the CallerAbility invokes the target UIAbility (CalleeAbility).
 *
 * @interface Caller
 * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
 * @stagemodelonly
 * @since 20
 */
export interface Caller {
    /**
     * Sends parcelable data to the target UIAbility. This API uses a promise to return the result.
     *
     * @param { string } method - Notification message string negotiated between the two UIAbilities. The message is used
     * to instruct the callee to register a function to receive the parcelable data.
     * @param { rpc.Parcelable } data - Parcelable data. You need to customize the data.
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @throws { BusinessError } 16200002 - The callee does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    call(method: string, data: rpc.Parcelable): Promise<void>;
    /**
     * Sends parcelable data to the target UIAbility and obtains the parcelable data returned by the target UIAbility.
     * This API uses a promise to return the result.
     *
     * @param { string } method - Notification message string negotiated between the two UIAbilities. The message is used
     * to instruct the callee to register a function to receive the parcelable data.
     * @param { rpc.Parcelable } data - Parcelable data. You need to customize the data.
     * @returns { Promise<rpc.MessageSequence> } Promise used to return the parcelable data from the target UIAbility.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @throws { BusinessError } 16200002 - The callee does not exist.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    callWithResult(method: string, data: rpc.Parcelable): Promise<rpc.MessageSequence>;
    /**
     * Releases the caller interface of the target UIAbility.
     *
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @throws { BusinessError } 16200002 - The callee does not exist.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    release(): void;
    /**
     * Called when the stub on the target UIAbility is disconnected.
     * This API uses an asynchronous callback to return the result.
     *
     * @param { OnReleaseCallback } callback - Callback used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onRelease(callback: OnReleaseCallback): void;
    /**
     * Called when the remote UIAbility state changes in the collaboration scenario.
     * This API uses an asynchronous callback to return the result.
     *
     * @param { OnRemoteStateChangeCallback } callback - Callback used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onRemoteStateChange(callback: OnRemoteStateChangeCallback): void;
    /**
     * Called when the stub on the target UIAbility is disconnected.
     * This API uses an asynchronous callback to return the result.
     *
     * @param { 'release' } type - Event type. The value is fixed at '**release**'.
     * @param { OnReleaseCallback } callback - Callback used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    on(type: 'release', callback: OnReleaseCallback): void;
    /**
     * Unregisters a callback that is invoked when the stub on the target UIAbility is disconnected.
     * This capability is reserved. This API uses an asynchronous callback to return the result.
     *
     * @param { 'release' } type - Event type. The value is fixed at '**release**'.
     * @param { OnReleaseCallback } callback - Callback used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    off(type: 'release', callback: OnReleaseCallback): void;
    /**
     * Unregisters a callback that is invoked when the stub on the target UIAbility is disconnected.
     * This capability is reserved.
     *
     * @param { 'release' } type - Event type. The value is fixed at '**release**'.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    off(type: 'release'): void;
}
/**
 * Implements callbacks for caller notification registration and deregistration.
 *
 * @interface Callee
 * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
 * @stagemodelonly
 * @since 20
 */
export interface Callee {
    /**
     * Registers a caller notification callback, which is invoked when the target UIAbility registers a function.
     *
     * @param { string } method - Notification message string negotiated between the two UIAbilities.
     * @param { CalleeCallback } callback - JS notification synchronization callback of the rpc.MessageSequence type. The
     * callback must return at least one empty rpc.Parcelable object. Otherwise, the function execution fails.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16200004 - The method has been registered.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    on(method: string, callback: CalleeCallback): void;
    /**
     * Unregisters a caller notification callback, which is invoked when the target UIAbility registers a function.
     *
     * @param { string } method - Registered notification message string.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 16200005 - The method has not been registered.
     * @throws { BusinessError } 16000050 - Internal error.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    off(method: string): void;
}


/**
 * UIAbility is an application component that has the UI.
 * The UIAbility module, inherited from Ability, provides lifecycle callbacks such as component creation, destruction,
 * and foreground/background switching. It also provides the following capabilities related to component collaboration:
 * <br>Caller: an object returned by startAbilityByCall. The CallerAbility (caller) uses this object to communicate
 * with the CalleeAbility (callee).
 * <br>Callee: an internal object of UIAbility. The CalleeAbility (callee) uses this object to communicate with the
 * CallerAbility (caller).
 *
 * @extends Ability
 * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
 * @stagemodelonly
 * @since 20
 */
declare class UIAbility extends Ability {
    
    
    /**
     * Context of the UIAbility.
     *
     * @type { UIAbilityContext }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    context: UIAbilityContext;
    
    /**
     * Parameters for starting the UIAbility.
     *
     * @type { Want }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    launchWant: Want;
    
    /**
     * Latest Want received through onCreate or onNewWant when the UIAbility is started for multiple times.
     *
     * @type { Want }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    lastRequestWant: Want;
    /**
     * Object that invokes the stub service.
     *
     * @type { Callee }
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    callee: Callee;
    
    
    /**
     * Called to initialize the service logic when a UIAbility instance in the completely closed state is created.
     * In other words, a UIAbility instance enters this lifecycle callback from a cold start. This API returns the
     * result synchronously and does not support asynchronous callback.
     *
     * @param { Want } want - Want information, including the ability name and bundle name.
     * @param { AbilityConstant.LaunchParam } launchParam - Parameters for starting the UIAbility, and the reason for
     * the last abnormal exit.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void;
    
    
    /**
     * Called when a WindowStage is created for this UIAbility.
     *
     * @param { window.WindowStage } windowStage - WindowStage information.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onWindowStageCreate(windowStage: window.WindowStage): void;
    /**
     * Called when the WindowStage is about to be destroyed.
     *
     * @param { window.WindowStage } windowStage - WindowStage information.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onWindowStageWillDestroy(windowStage: window.WindowStage): void;
    
    
    /**
     * Called when the WindowStage is destroyed for this UIAbility.
     *
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onWindowStageDestroy(): void;
    
    /**
     * Called when the WindowStage is restored during the migration of this UIAbility, which is a multi-instance ability.
     *
     * @param { window.WindowStage } windowStage - WindowStage information.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onWindowStageRestore(windowStage: window.WindowStage): void;
    /**
     * Called to clear resources when this UIAbility is destroyed.
     * This API returns the result synchronously or uses a promise to return the result.
     *
     * <p>**NOTE**:
     * <br>After the onDestroy() lifecycle callback is executed, the application may exit. Consequently,
     * the asynchronous function (for example, asynchronously writing data to the database) in onDestroy() may fail to be
     * executed. You can use the asynchronous lifecycle to ensure that the subsequent lifecycle continues only after the
     * asynchronous function in onDestroy() finishes the execution.
     * </p>
     *
     * @returns { void } the promise returned by the function.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onDestroy(): void;
    /**
     * Called to clear resources when this UIAbility is destroyed.
     * This API returns the result synchronously or uses a promise to return the result.
     *
     * <p>**NOTE**:
     * <br>After the onDestroyAsync() lifecycle callback is executed, the application may exit. Consequently,
     * the asynchronous function (for example, asynchronously writing data to the database) in onDestroyAsync() may fail to be
     * executed. You can use the asynchronous lifecycle to ensure that the subsequent lifecycle continues only after the
     * asynchronous function in onDestroyAsync() finishes the execution.
     * </p>
     *
     * @returns { Promise<void> } the promise returned by the function.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onDestroyAsync(): Promise<void>;
    
    
    /**
     * Triggered when the application transitions from the background to the foreground.
     * It is called between onWillForeground and onDidForeground.
     * It can be used to request system resources required, for example, requesting location services when the
     * application transitions to the foreground.
     *
     * <p>**NOTE**:
     * <br>This API returns the result synchronously and does not support asynchronous callback.
     * </p>
     *
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onForeground(): void;
    /**
     * Triggered just before the application transitions to the foreground.
     * It is called before onForeground.
     * It can be used to capture the moment when the application starts to transition to the foreground.
     * When paired with onDidForeground, it can also measure the duration from the application's initial
     * foreground entry to its full transition into the foreground state.
     *
     * <p>**NOTE**:
     * <br>This API returns the result synchronously and does not support asynchronous callback.
     * </p>
     *
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onWillForeground(): void;
    /**
     * Triggered after the application has transitioned to the foreground.
     * It is called after onForeground.
     * It can be used to capture the moment when the application fully transitions to the foreground.
     * When paired with onWillForeground, it can also measure the duration from the application's initial foreground
     * entry to its full transition into the foreground state.
     *
     * <p>**NOTE**:
     * <br>This API returns the result synchronously and does not support asynchronous callback.
     * </p>
     *
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onDidForeground(): void;
    
    
    /**
     * Triggered when the application transitions from the foreground to the background.
     * It is called between onWillBackground and onDidBackground.
     * It can be used to release resources when the UI is no longer visible, for example, stopping location services.
     *
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onBackground(): void;
    /**
     * Triggered just when the application transitions to the background.
     * It is called before onBackground.
     * It can be used to log various types of data, such as faults, statistics, security information, and user behavior
     * that occur during application running.
     *
     * <p>**NOTE**:
     * <br>This API returns the result synchronously and does not support asynchronous callback.
     * </p>
     *
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onWillBackground(): void;
    /**
     * Triggered after the application has transitioned to the background.
     * It is called after onBackground.
     * It can be used to release resources after the application has entered the background, for example, stopping
     * audio playback.
     *
     * <p>**NOTE**:
     * <br>This API returns the result synchronously and does not support asynchronous callback.
     * <p/>
     *
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onDidBackground(): void;
    
    
    /**
     * Called when a UIAbility instance that has undergone the following states is started again:
     * started in the foreground, running in the foreground, and switched to the background.
     * In other words, a UIAbility instance enters this lifecycle callback from a hot start.
     *
     * @param { Want } want - Want information, such as the ability name and bundle name.
     * @param { AbilityConstant.LaunchParam } launchParam - Reason for the UIAbility startup and the last abnormal exit.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void;
    
    /**
     * Called when dump client information is required.
     * This API can be used to dump non-sensitive information.
     *
     * @param { Array<string> } params - Parameters in the form of a command.
     * @returns { Array<string> } Dumped information array.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onDump(params: Array<string>): Array<string>;
    
    /**
     * Called when the framework automatically saves the UIAbility state in the case of an application fault.
     * When an application is faulty, the framework calls onSaveState to save the status of the UIAbility if
     * auto-save is enabled.
     *
     * <p>**NOTE**:
     * <br>This API is used together with appRecovery.
     * </p>
     *
     * @param { AbilityConstant.StateType } reason - Reason for triggering the callback to save the UIAbility state.
     * @param { Record<string, Object> } wantParam - want parameter.
     * @returns { AbilityConstant.OnSaveResult } Whether the UIAbility state is saved.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onSaveState(reason: AbilityConstant.StateType, wantParam: Record<string, Object>): AbilityConstant.OnSaveResult;
    /**
    * Called back asynchronously when an ability prepares to save.
    *
    * @param { AbilityConstant.StateType } stateType - state type when save.
    * @param { Record<string, Object> } wantParam - Indicates the want parameter.
    * @returns { Promise<AbilityConstant.OnSaveResult> } agree with the current UIAbility status or not.return 0 if ability
    *                                           agrees to save data successfully, otherwise errcode.
    * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
    * @stagemodelonly
    * @since 20
    */
    onSaveStateAsync(stateType: AbilityConstant.StateType, wantParam: Record<string, Object>): Promise<AbilityConstant.OnSaveResult>;
    
    /**
     * Called by this UIAbility to set data to share in the cross-device sharing scenario.
     *
     * @param { Record<string, Object> } wantParam - Data to share.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onShare(wantParam: Record<string, Object>): void;
    
    /**
     * Called when this UIAbility is about to terminate. It allows for additional actions to be performed before the
     * UIAbility is officially terminated.
     * For example, you can prompt the user to confirm whether they want to terminate the UIAbility. If the user
     * confirms, you can call terminateSelf to terminate it.
     *
     * <p>**NOTE**:
     * <br>Currently, this API takes effect only on 2-in-1 devices.
     * <br>Since API version 15, this callback is not executed when UIAbility.onPrepareToTerminateAsync is implemented.
     * <br>When AbilityStage.onPrepareTerminationAsync or AbilityStage.onPrepareTermination is implemented, this callback
     * is not executed if the user right-clicks the dock bar or system tray to close the UIAbility.
     * </p>
     *
     * @permission ohos.permission.PREPARE_APP_TERMINATE
     * @returns { boolean } Whether to terminate the UIAbility.
     * <br>The value <code>true</code> means that the termination process is canceled.
     * <br>The value <code>false</code> means to continue terminating the UIAbility.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onPrepareToTerminate(): boolean;
    /**
     * Called when this UIAbility is about to terminate. It allows for additional actions to be performed before the
     * UIAbility is officially terminated.
     * This API uses a promise to return the result.
     * For example, you can prompt the user to confirm whether they want to terminate the UIAbility. If the user
     * confirms, you can call terminateSelf to terminate it.
     *
     * <p>**NOTE**:
     * <br>Currently, this API takes effect only on 2-in-1 devices.
     * <br>When AbilityStage.onPrepareTerminationAsync or AbilityStage.onPrepareTermination is implemented, this callback
     * is not executed if the user right-clicks the dock bar or system tray to close the UIAbility.
     * <br>If an asynchronous callback crashes, it will be handled as a timeout. If the UIAbility does not respond within
     * 10 seconds, it will be terminated forcibly.
     * </P>
     *
     * @permission ohos.permission.PREPARE_APP_TERMINATE
     * @returns { Promise<boolean> } Promise used to return the result.
     * <br>The value <code>true</code> means that the termination process is canceled.
     * <br>The value <code>false</code> means to continue terminating the UIAbility.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onPrepareToTerminateAsync(): Promise<boolean>;
    
    /**
     * Called when an operation of going back to the previous page is triggered on this UIAbility. The return value
     * determines whether to destroy the UIAbility instance.
     *
     * <p>**NOTE**:
     * <br>When the target SDK version is earlier than 12, the default return value is false, indicating that the
     * UIAbility will be destroyed.
     * <br>When the target SDK version is 12 or later, the default return value is true, indicating that the UIAbility
     * will be moved to the background and will not be destroyed.
     * </p>
     *
     * @returns { boolean } The value <code>true</code> means that the UIAbility instance will be moved to the background
     * and will not be destroyed, and <code>false</code> means that the UIAbility instance will be destroyed.
     * @syscap SystemCapability.Ability.AbilityRuntime.AbilityCore
     * @stagemodelonly
     * @since 20
     */
    onBackPressed(): boolean;
}
export default UIAbility;
