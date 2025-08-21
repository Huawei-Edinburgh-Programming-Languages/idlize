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
import { Metadata } from './Metadata';
import { Resource } from '../global/resource';
import bundleManager from './../@ohos.bundle.bundleManager';


/**
 * Obtains configuration information about an application
 *
 * @typedef ApplicationInfo
 * @syscap SystemCapability.BundleManager.BundleFramework.Core
 * @since 20
 */
export interface ApplicationInfo {
    
    
    /**
     * Indicates the application name, which is the same as {@code bundleName}
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly name: string;
    
    
    /**
     * Description of application
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly description: string;
    
    
    /**
     * Indicates the description id of the application
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly descriptionId: long;
    
    
    /**
     * Indicates whether or not this application may be instantiated
     *
     * @type { boolean }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly enabled: boolean;
    
    
    /**
     * Indicates the label of the application
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly label: string;
    
    
    /**
     * Indicates the label id of the application
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly labelId: long;
    
    
    /**
     * Indicates the icon of the application
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly icon: string;
    
    
    /**
     * Indicates the icon id of the application
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly iconId: long;
    
    
    /**
     * Process of application, if user do not set it ,the value equal bundleName
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly process: string;
    
    
    /**
     * Indicates the permissions required for accessing the application.
     *
     * @type { Array<string> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly permissions: Array<string>;
    
    
    /**
     * Indicates the application source code path
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly codePath: string;
    
    
    /**
     * Indicates the metadata of the application
     *
     * @type { Array<ModuleMetadata> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly metadataArray: Array<ModuleMetadata>;
    
    
    /**
     * Indicates whether or not this application may be removable
     *
     * @type { boolean }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly removable: boolean;
    
    
    /**
     * Indicates the access token of the application
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly accessTokenId: long;
    
    
    /**
     * Indicates the uid of the application
     *
     * @type { int }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly uid: int;
    
    
    /**
     * Indicates icon resource of the application
     *
     * @type { Resource }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly iconResource: Resource;
    
    
    /**
     * Indicates label resource of the application
     *
     * @type { Resource }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly labelResource: Resource;
    
    
    /**
     * Indicates description resource of the application
     *
     * @type { Resource }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly descriptionResource: Resource;
    
    
    /**
     * Indicates the appDistributionType of the application
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly appDistributionType: string;
    
    
    /**
     * Indicates the appProvisionType of the application
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly appProvisionType: string;
    
    
    /**
     * Indicates whether the application is a system application
     *
     * @type { boolean }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly systemApp: boolean;
    
    /**
     * Indicates the type of application is APP or atomicService.
     *
     * @type { bundleManager.BundleType }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly bundleType: bundleManager.BundleType;
    
    
    /**
     * Indicates whether the application is in debug mode.
     *
     * @type { boolean }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly debug: boolean;
    
    /**
     * Indicates whether the application data is unclearable, that is, whether the application data cannot be cleared.
     *
     * @type { boolean }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly dataUnclearable: boolean;
    
    /**
     * Indicates native library path.
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly nativeLibraryPath: string;
    /**
     * Indicates the MultiAppMode object of the bundle
     *
     * @type { MultiAppMode }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly multiAppMode: MultiAppMode;
    /**
     * Indicates the index of the bundle
     *
     * @type { int }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly appIndex: int;
    /**
     * Indicates sources to install the app
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly installSource: string;
    
    /**
     * Indicates the release type of the app
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly releaseType: string;
    /**
     * Indicates whether the application enables cloud file sync.
     *
     * @type { boolean }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly cloudFileSyncEnabled: boolean;
    /**
     * Indicates the flags of the application.
     *
     * @type { ?int }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly flags?: int;
}


/**
 * Indicates the ModuleMetadata
 *
 * @typedef ModuleMetadata
 * @syscap SystemCapability.BundleManager.BundleFramework.Core
 * @since 20
 */
export interface ModuleMetadata {
    
    
    /**
     * Indicates the name of this hap module
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly moduleName: string;
    
    
    /**
     * Indicates the metadata of this hap module
     *
     * @type { Array<Metadata> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly metadata: Array<Metadata>;
}
/**
 * Indicates MultiAppMode
 *
 * @typedef MultiAppMode
 * @syscap SystemCapability.BundleManager.BundleFramework.Core
 * @since 20
 */
export interface MultiAppMode {
    /**
     * Indicates the multiAppModeType of the bundle
     *
     * @type { bundleManager.MultiAppModeType }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly multiAppModeType: bundleManager.MultiAppModeType;
    /**
     * Indicates the max count of the bundle
     *
     * @type { int }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly maxCount: int;
}
/**
 * Indicates the information of preinstalled application
 *
 * @typedef PreinstalledApplicationInfo
 * @syscap SystemCapability.BundleManager.BundleFramework.Core
 * @systemapi
 * @since 20
 */
export interface PreinstalledApplicationInfo {
    /**
     * Indicates the name of this bundle
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly bundleName: string;
    /**
     * Indicates the name of module
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly moduleName: string;
    /**
     * Indicates the icon id of the application
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly iconId: long;
    /**
     * Indicates the label id of the application
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly labelId: long;
}
