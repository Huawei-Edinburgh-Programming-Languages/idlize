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
 * @kit AbilityKit
 */
import { ApplicationInfo } from './ApplicationInfo';
import { Metadata } from './Metadata';
import bundleManager from './../@ohos.bundle.bundleManager';
import { Skill } from './Skill';


/**
 * Obtains configuration information about an ability
 *
 * @typedef AbilityInfo
 * @syscap SystemCapability.BundleManager.BundleFramework.Core
 * @since 20
 */
export interface AbilityInfo {
    
    
    /**
     * Indicates the name of the bundle containing the ability
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly bundleName: string;
    
    
    /**
     * Indicates the module name of the package to which the capability belongs
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly moduleName: string;
    
    
    /**
     * Ability simplified class name
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly name: string;
    
    
    /**
     * Indicates the label of the ability
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly label: string;
    
    
    /**
     * Indicates the label id of the ability
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly labelId: long;
    
    
    /**
     * Indicates the ability
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly description: string;
    
    
    /**
     * Indicates the description id of the ability
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly descriptionId: long;
    
    
    /**
     * Indicates the icon of the ability
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly icon: string;
    
    
    /**
     * Indicates the icon id of the ability
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly iconId: long;
    
    
    /**
     * Process of ability, if user do not set it, the value equal application process
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly process: string;
    
    
    /**
     * Indicates whether this ability can be called by other abilities
     *
     * @type { boolean }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly exported: boolean;
    
    
    /**
     * Enumerates ability display orientations
     *
     * @type { bundleManager.DisplayOrientation }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly orientation: bundleManager.DisplayOrientation;
    
    
    /**
     * Enumerates ability launch type
     *
     * @type { bundleManager.LaunchType }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly launchType: bundleManager.LaunchType;
    
    
    /**
     * The permissions that others need to launch this ability
     *
     * @type { Array<string> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly permissions: Array<string>;
    
    
    /**
     * The device types that this ability can run on
     *
     * @type { Array<string> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly deviceTypes: Array<string>;
    /**
     * Obtains configuration information about an application
     *
     * @type { ApplicationInfo | null }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly applicationInfo: ApplicationInfo | null;
    
    
    /**
     * Indicates the metadata of ability
     *
     * @type { Array<Metadata> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly metadata: Array<Metadata>;
    
    
    /**
     * Indicates whether the ability is enabled
     *
     * @type { boolean }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly enabled: boolean;
    
    
    /**
     * Indicates which window mode is supported
     *
     * @type { Array<bundleManager.SupportWindowMode> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly supportWindowModes: Array<bundleManager.SupportWindowMode>;
    
    
    /**
     * Indicates window size
     *
     * @type { WindowSize }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly windowSize: WindowSize;
    /**
     * Indicates whether to hide the application icon from the dock area
     *
     * @type { boolean }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly excludeFromDock: boolean;
    /**
     * Indicates skills of the ability
     *
     * @type { Array<Skill> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly skills: Array<Skill>;
    /**
     * Indicates the appIndex of application, only work in clone app mode
     *
     * @type { int }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly appIndex: int;
    /**
     * Indicates the orientation id of the ability
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly orientationId: long;
}


/**
 * Indicates the window size.
 *
 * @typedef WindowSize
 * @syscap SystemCapability.BundleManager.BundleFramework.Core
 * @since 20
 */
export interface WindowSize {
    
    
    /**
     * Indicates maximum ratio of width over height of window under free window status.
     *
     * @type { double }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly maxWindowRatio: double;
    
    
    /**
     * Indicates minimum ratio of width over height of window under free window status.
     *
     * @type { double }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly minWindowRatio: double;
    
    
    /**
     * Indicates maximum width of window under free window status.
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly maxWindowWidth: long;
    
    
    /**
     * Indicates minimum width of window under free window status.
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly minWindowWidth: long;
    
    
    /**
     * Indicates maximum height of window under free window status.
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly maxWindowHeight: long;
    
    
    /**
     * Indicates minimum height of window under free window status.
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly minWindowHeight: long;
}
