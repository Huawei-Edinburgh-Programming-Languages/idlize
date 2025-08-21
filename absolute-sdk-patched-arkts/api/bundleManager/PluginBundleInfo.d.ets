/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
/**
 * Provides information about a plugin.
 *
 * @typedef PluginBundleInfo
 * @syscap SystemCapability.BundleManager.BundleFramework.Core
 * @systemapi
 * @since 20
 */
export interface PluginBundleInfo {
    /**
     * Indicates the label of the plugin
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly label: string;
    /**
     * Indicates the label id of the plugin
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly labelId: long;
    /**
     * Indicates the icon of the plugin
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly icon: string;
    /**
     * Indicates the icon id of the plugin
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly iconId: long;
    /**
    * Indicates the name of the plugin
    *
    * @type { string }
    * @readonly
    * @syscap SystemCapability.BundleManager.BundleFramework.Core
    * @systemapi
    * @since 20
    */
    readonly pluginBundleName: string;
    /**
     * Indicates the version code of the plugin
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly versionCode: long;
    /**
     * Indicates the version name of the plugin
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly versionName: string;
    /**
     * Indicates the information about the plugin module
     *
     * @type { Array<PluginModuleInfo> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly pluginModuleInfos: Array<PluginModuleInfo>;
}
/**
 * Indicates the plugin module info.
 *
 * @typedef PluginModuleInfo
 * @syscap SystemCapability.BundleManager.BundleFramework.Core
 * @systemapi
 * @since 20
 */
export interface PluginModuleInfo {
    /**
     * Indicates the moduleName of the plugin
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly moduleName: string;
    /**
     * Indicates the description of the plugin
     *
     * @type { long }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly descriptionId: long;
    /**
     * Describes the plugin
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @systemapi
     * @since 20
     */
    readonly description: string;
}
