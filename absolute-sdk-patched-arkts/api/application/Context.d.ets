/*
 * Copyright (c) 2021-2024 Huawei Device Co., Ltd.
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
import EventHub from './EventHub';
import { ApplicationInfo } from '../bundleManager/ApplicationInfo';
import ApplicationContext from './ApplicationContext';
import type { AsyncCallback } from '../@ohos.base';
import BaseContext from './BaseContext';
import resmgr from '../@ohos.resourceManager';
import contextConstant from '../@ohos.app.ability.contextConstant';


/**
 * The Context module, inherited frome {@link BaseContext}, provides context for abilities or applications, including
 * access to application-specific resources.
 *
 * @extends BaseContext
 * @syscap SystemCapability.Ability.AbilityRuntime.Core
 * @stagemodelonly
 * @since 20
 */
declare class Context extends BaseContext {
    
    
    /**
     * Object for resource management.
     *
     * @type { resmgr.ResourceManager }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    resourceManager: resmgr.ResourceManager;
    
    
    /**
     * Application information.
     *
     * @type { ApplicationInfo }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    applicationInfo: ApplicationInfo;
    
    
    /**
     * Cache directory.
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    cacheDir: string;
    
    
    /**
     * Temporary directory.
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    tempDir: string;
    
    
    /**
     * File directory.
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    filesDir: string;
    
    
    /**
     * Database directory.
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    databaseDir: string;
    
    
    /**
     * Preferences directory.
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    preferencesDir: string;
    
    
    /**
     * Bundle code directory.
     *
     * <p>**NOTE**:
     * <br>Do not access resource files using concatenated paths. Use @ohos.resourceManager instead.
     * </p>
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    bundleCodeDir: string;
    
    /**
     * Distributed file directory.
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    distributedFilesDir: string;
    /**
     * Resource directory.
     *
     * <p>**NOTE**:
     * <br>You are required to manually create the resfile directory in <code><module-name>\resource</code>. The resfile
     * directory can be accessed only in read-only mode.
     * </p>
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    resourceDir: string;
    /**
     * Cloud file directory.
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    cloudFileDir: string;
    
    
    /**
     * Event hub that implements event subscription, unsubscription, and triggering.
     *
     * @type { EventHub }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    eventHub: EventHub;
    /**
     * Get encryption level of the directory.
     *
     * @return { contextConstant.AreaMode }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    get area(): contextConstant.AreaMode;
    /**
     * Set encryption level of the directory.
     *
     * @param { contextConstant.AreaMode }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    set area(mode: contextConstant.AreaMode);
    /**
     * Process name of the current application.
     *
     * @type { string }
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    processName: string;
    
    
    /**
     * Obtains the context of this application.
     *
     * @returns { ApplicationContext } Application context obtained.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    getApplicationContext(): ApplicationContext;
    
    /**
     * Obtains the shared directory based on a group ID.
     * This API uses an asynchronous callback to return the result.
     *
     * @param { string } dataGroupID - Group ID, which is assigned by the system when an atomic service project
     * is created.
     * @param { AsyncCallback<string> } callback - Group ID, which is assigned by the system when an atomic service
     * project is created.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    getGroupDir(dataGroupID: string, callback: AsyncCallback<string>): void;
    
    /**
     * Obtains the shared directory based on a group ID.
     * This API uses a promise to return the result.
     *
     * @param { string } dataGroupID - Group ID, which is assigned by the system when an atomic service project
     * is created.
     * @returns { Promise<string> } Promise used to return the result. If no shared directory exists, null is returned.
     * Only the encryption level EL2 is supported.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
     * @throws { BusinessError } 16000011 - The context does not exist.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    getGroupDir(dataGroupID: string): Promise<string>;
    /**
     * Creates a resource management object for a module.
     *
     * @permission ohos.permission.GET_BUNDLE_INFO_PRIVILEGED
     * @param { string } bundleName - Bundle name.
     * @param { string } moduleName - Module name.
     * @returns { resmgr.ResourceManager } Object for resource management.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Permission denied, non-system app called system api.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    createModuleResourceManager(bundleName: string, moduleName: string): resmgr.ResourceManager;
    /**
     * Creates the context for this application based on a data encryption level.
     * This is required when an application needs to store different types of information in different directories.
     * The application can obtain the corresponding directory.
     *
     * @param { contextConstant.AreaMode } areaMode - Data encryption level.
     * @returns { Context } Context created based on the data encryption level.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    createAreaModeContext(areaMode: contextConstant.AreaMode): Context;
    /**
     * Creates the context based on the specified display ID, so as to obtain and use other application contexts with
     * screen information (including ScreenDensity and Direction).
     *
     * @param { long } displayId - Display ID.
     * @returns { Context } 	Context with the specified screen information.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Ability.AbilityRuntime.Core
     * @stagemodelonly
     * @since 20
     */
    createDisplayContext(displayId: long): Context;
}
export default Context;
