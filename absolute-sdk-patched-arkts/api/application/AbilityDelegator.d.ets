/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
import { AsyncCallback } from '../@ohos.base';
import { AbilityMonitor } from './AbilityMonitor';
import Context from './Context';
import Want from '../@ohos.app.ability.Want';
import { ShellCmdResult } from './shellCmdResult';
import UIAbility from '../@ohos.app.ability.UIAbility';
import AbilityStage from '../@ohos.app.ability.AbilityStage';
import { AbilityStageMonitor } from './AbilityStageMonitor';


/**
 * A global test utility interface used for adding AbilityMonitor objects and control lifecycle states of abilities.
 *
 * @interface AbilityDelegator
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
export interface AbilityDelegator {
    
    
    /**
     * Add an AbilityMonitor object for monitoring the lifecycle state changes of the specified ability in this process.
     *
     * @param { AbilityMonitor } monitor - AbilityMonitor object
     * @param { AsyncCallback<void> } callback - The callback of addAbilityMonitor.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling AddAbilityMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    addAbilityMonitor(monitor: AbilityMonitor, callback: AsyncCallback<void>): void;
    
    
    /**
     * Add an AbilityMonitor object for monitoring the lifecycle state changes of the specified ability in this process.
     *
     * @param { AbilityMonitor } monitor - AbilityMonitor object
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling AddAbilityMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    addAbilityMonitor(monitor: AbilityMonitor): Promise<void>;
    
    /**
     * Add an AbilityMonitor object for monitoring the lifecycle state changes of the specified ability in this process.
     *
     * @param { AbilityMonitor } monitor - AbilityMonitor object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling AddAbilityMonitorSync failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    addAbilityMonitorSync(monitor: AbilityMonitor): void;
    
    
    /**
     * Add an AbilityStageMonitor object for monitoring the lifecycle state changes of the specified abilityStage in this process.
     *
     * @param { AbilityStageMonitor } monitor - AbilityStageMonitor object.
     * @param { AsyncCallback<void> } callback - The callback of addAbilityStageMonitor.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling AddAbilityStageMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    addAbilityStageMonitor(monitor: AbilityStageMonitor, callback: AsyncCallback<void>): void;
    
    
    /**
     * Add an AbilityStageMonitor object for monitoring the lifecycle state changes of the specified abilityStage in this process.
     *
     * @param { AbilityStageMonitor } monitor - AbilityStageMonitor object.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling AddAbilityStageMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    addAbilityStageMonitor(monitor: AbilityStageMonitor): Promise<void>;
    
    /**
     * Add an AbilityStageMonitor object for monitoring the lifecycle state changes of the specified abilityStage in this process.
     *
     * @param { AbilityStageMonitor } monitor - AbilityStageMonitor object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling AddAbilityStageMonitorSync failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    addAbilityStageMonitorSync(monitor: AbilityStageMonitor): void;
    
    
    /**
     * Remove a specified AbilityMonitor object from the application memory.
     *
     * @param { AbilityMonitor } monitor - AbilityMonitor object.
     * @param { AsyncCallback<void> } callback - The callback of removeAbilityMonitor.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling RemoveAbilityMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    removeAbilityMonitor(monitor: AbilityMonitor, callback: AsyncCallback<void>): void;
    
    
    /**
     * Remove a specified AbilityMonitor object from the application memory.
     *
     * @param { AbilityMonitor } monitor - AbilityMonitor object.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling RemoveAbilityMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    removeAbilityMonitor(monitor: AbilityMonitor): Promise<void>;
    
    /**
     * Remove a specified AbilityMonitor object from the application memory.
     *
     * @param { AbilityMonitor } monitor - AbilityMonitor object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling RemoveAbilityMonitorSync failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    removeAbilityMonitorSync(monitor: AbilityMonitor): void;
    
    
    /**
     * Remove a specified AbilityStageMonitor object from the application memory.
     *
     * @param { AbilityStageMonitor } monitor - AbilityStageMonitor object.
     * @param { AsyncCallback<void> } callback - The callback of removeAbilityStageMonitor.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling RemoveAbilityStageMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    removeAbilityStageMonitor(monitor: AbilityStageMonitor, callback: AsyncCallback<void>): void;
    
    
    /**
     * Remove a specified AbilityStageMonitor object from the application memory.
     *
     * @param { AbilityStageMonitor } monitor - AbilityStageMonitor object.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling RemoveAbilityStageMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    removeAbilityStageMonitor(monitor: AbilityStageMonitor): Promise<void>;
    
    /**
     * Remove a specified AbilityStageMonitor object from the application memory.
     *
     * @param { AbilityStageMonitor } monitor - AbilityStageMonitor object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling RemoveAbilityStageMonitorSync failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    removeAbilityStageMonitorSync(monitor: AbilityStageMonitor): void;
    
    
    /**
     * Wait for and returns the Ability object that matches the conditions set in the given AbilityMonitor.
     *
     * @param { AbilityMonitor } monitor - AbilityMonitor object.
     * @param { AsyncCallback<UIAbility> } callback - The callback is used to return the Ability object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling WaitAbilityMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    waitAbilityMonitor(monitor: AbilityMonitor, callback: AsyncCallback<UIAbility>): void;
    
    
    /**
     * Wait for and returns the Ability object that matches the conditions set in the given AbilityMonitor.
     *
     * @param { AbilityMonitor } monitor - AbilityMonitor object.
     * @param { long } timeout - Maximum wait time, in milliseconds.
     * @param { AsyncCallback<UIAbility> } callback - The callback is used to return the Ability object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling WaitAbilityMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    waitAbilityMonitor(monitor: AbilityMonitor, timeout: long, callback: AsyncCallback<UIAbility>): void;
    
    
    /**
     * Wait for and returns the Ability object that matches the conditions set in the given AbilityMonitor.
     *
     * @param { AbilityMonitor } monitor - AbilityMonitor object.
     * @param { long } [timeout] - Maximum wait time, in milliseconds.
     * @returns { Promise<UIAbility> } Returns the Ability object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling WaitAbilityMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    waitAbilityMonitor(monitor: AbilityMonitor, timeout?: long): Promise<UIAbility>;
    
    
    /**
     * Wait for and returns the AbilityStage object that matches the conditions set in the given AbilityStageMonitor.
     *
     * @param { AbilityStageMonitor } monitor - AbilityStageMonitor object.
     * @param { AsyncCallback<AbilityStage> } callback - The callback is used to return the AbilityStage object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling WaitAbilityStageMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    waitAbilityStageMonitor(monitor: AbilityStageMonitor, callback: AsyncCallback<AbilityStage>): void;
    
    
    /**
     * Wait for and returns the AbilityStage object that matches the conditions set in the given AbilityStageMonitor.
     *
     * @param { AbilityStageMonitor } monitor - AbilityStageMonitor object.
     * @param { long } timeout - Maximum wait time, in milliseconds.
     * @param { AsyncCallback<AbilityStage> } callback - The callback is used to return the AbilityStage object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling WaitAbilityStageMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    waitAbilityStageMonitor(monitor: AbilityStageMonitor, timeout: long, callback: AsyncCallback<AbilityStage>): void;
    
    
    /**
     * Wait for and returns the AbilityStage object that matches the conditions set in the given AbilityStageMonitor.
     *
     * @param { AbilityStageMonitor } monitor - AbilityStageMonitor object.
     * @param { long } [timeout] - Maximum wait time, in milliseconds.
     * @returns { Promise<AbilityStage> } Returns the AbilityStage object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling WaitAbilityStageMonitor failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    waitAbilityStageMonitor(monitor: AbilityStageMonitor, timeout?: long): Promise<AbilityStage>;
    
    
    /**
     * Obtain the application context.
     *
     * @returns { Context } Returns the app Context.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    getAppContext(): Context;
    
    
    /**
     * Obtain the lifecycle state of a specified ability.
     *
     * @param { UIAbility } ability - The Ability object.
     * @returns { int } Returns the state of the Ability object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    getAbilityState(ability: UIAbility): int;
    
    
    /**
     * Obtain the ability that is currently being displayed in this process.
     *
     * @param { AsyncCallback<UIAbility> } callback - The callback is used to return the Ability object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling GetCurrentTopAbility failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    getCurrentTopAbility(callback: AsyncCallback<UIAbility>): void;
    
    
    /**
     * Obtain the ability that is currently being displayed in this process.
     *
     * @returns { Promise<UIAbility> } Returns the Ability object.
     * @throws { BusinessError } 16000100 - Calling GetCurrentTopAbility failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    getCurrentTopAbility(): Promise<UIAbility>;
    
    
    /**
     * Start a new ability.
     *
     * @param { Want } want - Indicates the ability to start
     * @param { AsyncCallback<void> } callback - The callback of startAbility.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000010 - The call with the continuation and prepare continuation flag is forbidden.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @throws { BusinessError } 16000055 - Installation-free timed out.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    startAbility(want: Want, callback: AsyncCallback<void>): void;
    
    
    /**
     * Start a new ability.
     *
     * @param { Want } want - Indicates the ability to start
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000001 - The specified ability does not exist.
     * @throws { BusinessError } 16000002 - Incorrect ability type.
     * @throws { BusinessError } 16000004 - Cannot start an invisible component.
     * @throws { BusinessError } 16000005 - The specified process does not have the permission.
     * @throws { BusinessError } 16000006 - Cross-user operations are not allowed.
     * @throws { BusinessError } 16000008 - The crowdtesting application expires.
     * @throws { BusinessError } 16000009 - An ability cannot be started or stopped in Wukong mode.
     * @throws { BusinessError } 16000010 - The call with the continuation and prepare continuation flag is forbidden.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @throws { BusinessError } 16000012 - The application is controlled.
     * @throws { BusinessError } 16000013 - The application is controlled by EDM.
     * @throws { BusinessError } 16000050 - Internal error.
     * @throws { BusinessError } 16000053 - The ability is not on the top of the UI.
     * @throws { BusinessError } 16000055 - Installation-free timed out.
     * @throws { BusinessError } 16200001 - The caller has been released.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    startAbility(want: Want): Promise<void>;
    
    
    /**
     * Invoke the Ability.onForeground() callback of a specified ability without changing its lifecycle state.
     *
     * @param { UIAbility } ability - The ability object.
     * @param { AsyncCallback<void> } callback - The callback of doAbilityForeground.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling DoAbilityForeground failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    doAbilityForeground(ability: UIAbility, callback: AsyncCallback<void>): void;
    
    
    /**
     * Invoke the Ability.onForeground() callback of a specified ability without changing its lifecycle state.
     *
     * @param { UIAbility } ability - The ability object.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling DoAbilityForeground failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    doAbilityForeground(ability: UIAbility): Promise<void>;
    
    
    /**
     * Invoke the Ability.onBackground() callback of a specified ability without changing its lifecycle state.
     *
     * @param { UIAbility } ability - The ability object.
     * @param { AsyncCallback<void> } callback - The callback of doAbilityBackground.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling DoAbilityBackground failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    doAbilityBackground(ability: UIAbility, callback: AsyncCallback<void>): void;
    
    
    /**
     * Invoke the Ability.onBackground() callback of a specified ability without changing its lifecycle state.
     *
     * @param { UIAbility } ability - The ability object.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling DoAbilityBackground failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    doAbilityBackground(ability: UIAbility): Promise<void>;
    
    
    /**
     * Prints log information to the unit testing console.
     * The total length of the log information to be printed cannot exceed 1000 characters.
     *
     * @param { string } msg - Log information
     * @param { AsyncCallback<void> } callback - The callback of print.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    print(msg: string, callback: AsyncCallback<void>): void;
    
    
    /**
     * Prints log information to the unit testing console.
     * The total length of the log information to be printed cannot exceed 1000 characters.
     *
     * @param { string } msg - Log information
     * @returns { Promise<void> } the promise returned by the function.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    print(msg: string): Promise<void>;
    
    
    /**
     * Prints log information to the unit testing console.
     * The total length of the log information to be printed cannot exceed 1000 characters.
     *
     * @param { string } msg - Log information.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    printSync(msg: string): void;
    
    /**
     * Execute the given command in the aa tools side.
     *
     * @param { string } cmd - Shell command
     * @param { AsyncCallback<ShellCmdResult> } callback - The callback of executeShellCommand.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    executeShellCommand(cmd: string, callback: AsyncCallback<ShellCmdResult>): void;
    
    /**
     * Execute the given command in the aa tools side.
     *
     * @param { string } cmd - Shell command
     * @param { long } timeoutSecs - Timeout, in seconds
     * @param { AsyncCallback<ShellCmdResult> } callback - The callback of executeShellCommand.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    executeShellCommand(cmd: string, timeoutSecs: long, callback: AsyncCallback<ShellCmdResult>): void;
    
    /**
     * Execute the given command in the aa tools side.
     *
     * @param { string } cmd - Shell command
     * @param { long } [timeoutSecs] - Timeout, in seconds
     * @returns { Promise<ShellCmdResult> } the promise returned by the function.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    executeShellCommand(cmd: string, timeoutSecs?: long): Promise<ShellCmdResult>;
    
    
    /**
     * Finish the test and print log information to the unit testing console.
     * The total length of the log information to be printed cannot exceed 1000 characters.
     *
     * @param { string } msg - Log information.
     * @param { long } code - Result code.
     * @param { AsyncCallback<void> } callback - The callback of finishTest.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling FinishTest failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    finishTest(msg: string, code: long, callback: AsyncCallback<void>): void;
    
    
    /**
     * Finish the test and print log information to the unit testing console.
     * The total length of the log information to be printed cannot exceed 1000 characters.
     *
     * @param { string } msg - Log information.
     * @param { long } code - Result code.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000100 - Calling FinishTest failed.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    finishTest(msg: string, code: long): Promise<void>;
}
