/*
 * Copyright (c) 2022-2024 Huawei Device Co., Ltd.
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
import appManager from '../@ohos.app.ability.appManager';
import bundleManager from '../@ohos.bundle.bundleManager';


/**
 * The class of an process information.
 *
 * @typedef ProcessInformation
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @since 20
 */
export interface ProcessInformation {
    
    
    /**
     * @type { int }
     * @default process id
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    pid: int;
    
    /**
     * @type { int }
     * @default user id
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    uid: int;
    
    
    /**
     * @type { string }
     * @default the name of the process
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    processName: string;
    
    
    /**
     * @type { Array<string> }
     * @default an array of the bundleNames running in the process
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    bundleNames: Array<string>;
    
    /**
     * The process state.
     *
     * @type { appManager.ProcessState }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    state: appManager.ProcessState;
    /**
     * The bundle type of the process.
     *
     * @type { bundleManager.BundleType }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    bundleType: bundleManager.BundleType;
    /**
     * The app clone index of current process if app is multi app mode.
     * @type { ?int }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @since 20
     */
    appCloneIndex?: int;
}
