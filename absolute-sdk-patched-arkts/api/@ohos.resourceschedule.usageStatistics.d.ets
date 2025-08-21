/*
 * Copyright (c) 2023  Huawei Device Co., Ltd.
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
 * @kit BackgroundTasksKit
 */
import { AsyncCallback, Callback } from './@ohos.base';
/**
 * Provides methods for managing bundle usage statistics,
 * including the methods for querying bundle usage information and state data.
 *
 * <p>You can use the methods defined in this class to query
 * the usage history and states of bundles in a specified period.
 * The system stores the query result in a {@link BundleStatsInfo} instance and
 * then returns it to you.
 *
 * @namespace usageStatistics
 * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
 * @since 20
 */
declare namespace usageStatistics {
    /**
     * @interface BundleStatsInfo
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface BundleStatsInfo {
        /**
         * The identifier of BundleStatsInfo.
         * @type { int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        id: int;
        /**
         * The total duration, in milliseconds.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        abilityInFgTotalTime?: long;
        /**
         * The last time when the application was accessed, in milliseconds.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        abilityPrevAccessTime?: long;
        /**
         * The last time when the application was visible in the foreground, in milliseconds.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        abilityPrevSeenTime?: long;
        /**
         * The total duration, in milliseconds.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        abilitySeenTotalTime?: long;
        /**
         * The bundle name of the application.
         * @type { ?string }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        bundleName?: string;
        /**
         * The total duration, in milliseconds.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        fgAbilityAccessTotalTime?: long;
        /**
         * The last time when the foreground application was accessed, in milliseconds.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        fgAbilityPrevAccessTime?: long;
        /**
         * The time of the first bundle usage record in this {@code BundleActiveInfo} object,
         * in milliseconds.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        infosBeginTime?: long;
        /**
         * The time of the last bundle usage record in this {@code BundleActiveInfo} object,
         * in milliseconds.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        infosEndTime?: long;
        /**
         * The app index of the application.
         * @type { ?int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        appIndex?: int;
    }
    /**
     * @interface HapFormInfo
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface HapFormInfo {
        /**
         * The form name.
         * @type { string }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        formName: string;
        /**
         * The form dimension.
         * @type { int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        formDimension: int;
        /**
         * The form id.
         * @type { long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        formId: long;
        /**
         * The last time when the form was accessed, in milliseconds..
         * @type { long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        formLastUsedTime: long;
        /**
         * The click count of module.
         * @type { int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        count: int;
    }
    /**
     * @interface HapModuleInfo
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface HapModuleInfo {
        /**
         * The device id of module.
         * @type { ?string }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        deviceId?: string;
        /**
         * The bundle name.
         * @type { string }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        bundleName: string;
        /**
         * The module name.
         * @type { string }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        moduleName: string;
        /**
         * The main ability name of module.
         * @type { ?string }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        abilityName?: string;
        /**
         * The label id of application.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        appLabelId?: long;
        /**
         * The label id of module.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        labelId?: long;
        /**
         * The description id of application.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        descriptionId?: long;
        /**
         * The ability id of main ability.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        abilityLableId?: long;
        /**
         * The description id of main ability.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        abilityDescriptionId?: long;
        /**
         * The icon id of main ability.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        abilityIconId?: long;
        /**
         * The launch count of module.
         * @type { int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        launchedCount: int;
        /**
         * The last time when the module was accessed, in milliseconds.
         * @type { long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        lastModuleUsedTime: long;
        /**
         * The form usage record list of current module.
         * @type { Array<HapFormInfo> }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        formRecords: Array<HapFormInfo>;
    }
    /**
     * @interface DeviceEventStats
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface DeviceEventStats {
        /**
         * The bundle name or system event name.
         * @type { string }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        name: string;
        /**
         * The event id.
         * @type { int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        eventId: int;
        /**
         * The the event occurrence number.
         * @type { int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        count: int;
    }
    /**
     * @interface BundleEvents
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface BundleEvents {
        /**
         * The usage group of the application.
         * @type { ?int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        appGroup?: int;
        /**
         * The bundle name.
         * @type { ?string }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        bundleName?: string;
        /**
         * The shortcut ID.
         * @type { ?string }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        indexOfLink?: string;
        /**
         * The class name.
         * @type { ?string }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        nameOfClass?: string;
        /**
         * The time when this state occurred, in milliseconds.
         * @type { ?long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        eventOccurredTime?: long;
        /**
         * The event id.
         * @type { ?int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        eventId?: int;
    }
    /**
     * @interface AppGroupCallbackInfo
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
       * @since 20
       */
    interface AppGroupCallbackInfo {
        /**
         * The usage old group of the application
         * @type { int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        appOldGroup: int;
        /**
         * The usage new group of the application
         * @type { int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        appNewGroup: int;
        /**
         * The use id
         * @type { int }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        userId: int;
        /**
         * The change reason
         * @type { long }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        changeReason: long;
        /**
         * The bundle name
         * @type { string }
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        bundleName: string;
    }
    /**
     * Checks whether the application with a specified bundle name is in the idle state.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { string } bundleName - Indicates the bundle name of the application to query.
     * @param { AsyncCallback<boolean> } callback - the callback of isIdleState.
     * <p> boolean value is true mean the application is idle in a particular period; false mean otherwise.
     * The time range of the particular period is defined by the system, which may be hours or days.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function isIdleState(bundleName: string, callback: AsyncCallback<boolean>): void;
    /**
     * Checks whether the application with a specified bundle name is in the idle state.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { string } bundleName - Indicates the bundle name of the application to query.
     * @returns { Promise<boolean> } the promise returned by isIdleState.
     * <p> boolean value is true mean the application is idle in a particular period; false mean otherwise.
     * The time range of the particular period is defined by the system, which may be hours or days.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function isIdleState(bundleName: string): Promise<boolean>;
    /**
     * Checks whether the application with a specified bundle name is in the idle state.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { string } bundleName - Indicates the bundle name of the application to query.
     * @returns { boolean }
     * <p> boolean value is true mean the application is idle in a particular period; false mean otherwise.
     * The time range of the particular period is defined by the system, which may be hours or days.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function isIdleStateSync(bundleName: string): boolean;
    /**
     * Queries the app group of the calling application.
     * <p>The priority defined in a priority group restricts the resource usage of an application,
     * for example, restricting the running of background tasks. </p>
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { AsyncCallback<int> } callback - the callback of queryAppGroup.
     * <p> Returns the app group of the calling application.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000005 - Application is not installed.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10100002 - Failed to get the application group information.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryAppGroup(callback: AsyncCallback<int>): void;
    /**
     * Queries the app group of the calling application.
     * <p>The priority defined in a priority group restricts the resource usage of an application,
     * for example, restricting the running of background tasks. </p>
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @returns { Promise<int> } the promise returned by queryAppGroup.
     * <p> Returns the app group of the calling application.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000005 - Application is not installed.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10100002 - Failed to get the application group information.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryAppGroup(): Promise<int>;
    /**
     * Queries the app group of the calling application.
     * <p>The priority defined in a priority group restricts the resource usage of an application,
     * for example, restricting the running of background tasks. </p>
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @returns { int } Returns the app group of the calling application.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000005 - Application is not installed.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10100002 - Failed to get the application group information.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryAppGroupSync(): int;
    /**
     * Queries the usage priority group by bundleName.
     * <p>The priority defined in a priority group restricts the resource usage of an application,
     * for example, restricting the running of background tasks. </p>
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { string } bundleName - name of the application.
     * @param { AsyncCallback<int> } callback - the callback of queryAppGroup.
     * <p> the usage priority group of the calling application.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000005 - Application is not installed.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10100002 - Failed to get the application group information.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryAppGroup(bundleName: string, callback: AsyncCallback<int>): void;
    /**
     * Queries the usage priority group by bundleName.
     * <p>The priority defined in a priority group restricts the resource usage of an application,
     * for example, restricting the running of background tasks. </p>
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { string } bundleName - name of the application.
     * @returns { Promise<int> } the promise returned by queryAppGroup.
     * <p> the usage priority group of the calling application.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000005 - Application is not installed.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10100002 - Failed to get the application group information.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryAppGroup(bundleName: string): Promise<int>;
    /**
     * Queries the usage priority group by bundleName.
     * <p>The priority defined in a priority group restricts the resource usage of an application,
     * for example, restricting the running of background tasks. </p>
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { string } bundleName - name of the application.
     * @returns { int } the usage priority group of the calling application.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000005 - Application is not installed.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10100002 - Failed to get the application group information.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryAppGroupSync(bundleName: string): int;
    /**
     * @typedef { Record<string, BundleStatsInfo> }
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    type BundleStatsMap = Record<string, BundleStatsInfo>;
    /**
     * Queries usage information about each bundle within a specified period.
     * <p>This method queries usage information at the {@link #BY_OPTIMIZED} interval by default.</p>
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @param { AsyncCallback<BundleStatsMap> } callback - the callback of queryBundleStatsInfos,
     * <p> the {@link BundleStatsMap} objects containing the usage information about each bundle.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryBundleStatsInfos(begin: long, end: long, callback: AsyncCallback<BundleStatsMap>): void;
    /**
     * Queries usage information about each bundle within a specified period.
     * <p>This method queries usage information at the {@link #BY_OPTIMIZED} interval by default.</p>
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @returns { Promise<BundleStatsMap> } the promise returned by queryBundleStatsInfos.
     * <p> the {@link BundleStatsMap} objects containing the usage information about each bundle.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryBundleStatsInfos(begin: long, end: long): Promise<BundleStatsMap>;
    /**
     * @typedef { Record<string, Array<BundleStatsInfo>> }
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    type AppStatsMap = Record<string, Array<BundleStatsInfo>>;
    /**
     * Queries usage information about each application within a specified period.
     * <p>This method queries usage information at the {@link #BY_OPTIMIZED} interval by default.</p>
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @returns { Promise<AppStatsMap> } the promise returned by queryAppStatsInfos.
     * <p> the {@link AppStatsMap} objects containing the usage information about each application.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryAppStatsInfos(begin: long, end: long): Promise<AppStatsMap>;
    /**
     * Queries the last usage timestamp by bundleName and app index.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { appInfo } bundle name and app index info for each application.
     * @returns { Promise<AppStatsMap> } the promise returned by queryLastUseTime.
     * <p> the {@link AppStatsMap} objects containing the usage information about each application.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryLastUseTime(appInfo: Record<string, Array<long>>): Promise<AppStatsMap>;
    /**
     * Declares interval type.
     *
     * @enum { int }
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum IntervalType {
        /**
         * Indicates the interval type that will determine the optimal interval based on the start and end time.
         *
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        BY_OPTIMIZED = 0,
        /**
         * Indicates the daily interval.
         *
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        BY_DAILY = 1,
        /**
         * Indicates the weekly interval.
         *
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        BY_WEEKLY = 2,
        /**
         * Indicates the monthly interval.
         *
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        BY_MONTHLY = 3,
        /**
         * Indicates the annually interval.
         *
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        BY_ANNUALLY = 4
    }
    /**
     * Queries usage information about each bundle within a specified period at a specified interval.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { IntervalType } byInterval - Indicates the interval at which the usage statistics are queried.
     * <p> The value can be {@link #BY_OPTIMIZED}, {@link #BY_DAILY},
     * {@link #BY_WEEKLY}, {@link #BY_MONTHLY}, or {@link #BY_ANNUALLY}.</p>
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @param { AsyncCallback<Array<BundleStatsInfo>> } callback - the callback of queryBundleStatsInfoByInterval.
     * <p> the list of {@link BundleStatsInfo} objects containing the usage information about each bundle.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryBundleStatsInfoByInterval(byInterval: IntervalType, begin: long, end: long, callback: AsyncCallback<Array<BundleStatsInfo>>): void;
    /**
     * Queries usage information about each bundle within a specified period at a specified interval.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { IntervalType } byInterval - Indicates the interval at which the usage statistics are queried.
     * <p> The value can be {@link #BY_OPTIMIZED}, {@link #BY_DAILY},
     * {@link #BY_WEEKLY}, {@link #BY_MONTHLY}, or {@link #BY_ANNUALLY}.</p>
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @returns { Promise<Array<BundleStatsInfo>> } the promise returned by queryBundleStatsInfoByInterval.
     * <p> the list of {@link BundleStatsInfo} objects containing the usage information about each bundle.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryBundleStatsInfoByInterval(byInterval: IntervalType, begin: long, end: long): Promise<Array<BundleStatsInfo>>;
    /**
     * Queries state data of all bundles within a specified period identified by the start and end time.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @param { AsyncCallback<Array<BundleEvents>> } callback - the promise returned by queryBundleEvents.
     * <p> the list of {@link BundleEvents} objects containing the state data of all bundles.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryBundleEvents(begin: long, end: long, callback: AsyncCallback<Array<BundleEvents>>): void;
    /**
     * Queries state data of all bundles within a specified period identified by the start and end time.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @returns { Promise<Array<BundleEvents>> } the promise returned by queryBundleEvents.
     * <p> the list of {@link BundleEvents} objects containing the state data of all bundles.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryBundleEvents(begin: long, end: long): Promise<Array<BundleEvents>>;
    /**
     * Queries state data of the current bundle within a specified period.
     *
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @param { AsyncCallback<Array<BundleEvents>> } callback - the callback of queryCurrentBundleEvents.
     * <p> the {@link BundleEvents} object Array containing the state data of the current bundle.</p>
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryCurrentBundleEvents(begin: long, end: long, callback: AsyncCallback<Array<BundleEvents>>): void;
    /**
     * Queries state data of the current bundle within a specified period.
     *
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @returns { Promise<Array<BundleEvents>> } the promise returned by queryCurrentBundleEvents.
     * <p> the {@link BundleEvents} object Array containing the state data of the current bundle.</p>
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryCurrentBundleEvents(begin: long, end: long): Promise<Array<BundleEvents>>;
    /**
     * Queries recently module usage records with maxNum.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { int } maxNum - Indicates max record number in result, max value is 1000, default value is 1000.
     * @param { AsyncCallback<Array<HapModuleInfo>> } callback - the callback of queryModuleUsageRecords.
     * <p> the {@link HapModuleInfo} object Array containing the usage data of the modules.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryModuleUsageRecords(maxNum: int, callback: AsyncCallback<Array<HapModuleInfo>>): void;
    /**
     * Queries recently module usage records with maxNum.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { int } maxNum - Indicates max record number in result, max value is 1000, default value is 1000.
     * @returns { Promise<Array<HapModuleInfo>> } the promise returned by queryModuleUsageRecords.
     * <p> the {@link HapModuleInfo} object Array containing the usage data of the modules.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryModuleUsageRecords(maxNum: int): Promise<Array<HapModuleInfo>>;
    /**
     * Queries recently module usage records.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { AsyncCallback<Array<HapModuleInfo>> } callback - the callback of queryModuleUsageRecords.
     * <p> the {@link HapModuleInfo} object Array containing the usage data of the modules.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryModuleUsageRecords(callback: AsyncCallback<Array<HapModuleInfo>>): void;
    /**
     * Queries recently module usage records.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @returns { Promise<Array<HapModuleInfo>> } the promise returned by queryModuleUsageRecords.
     * <p> the {@link HapModuleInfo} object Array containing the usage data of the modules.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryModuleUsageRecords(): Promise<Array<HapModuleInfo>>;
    /**
     * Declares group type.
     *
     * @enum { int }
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum GroupType {
        /**
         * Indicates the alive group.
         *
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        ALIVE_GROUP = 10,
        /**
         * Indicates the daily group.
         *
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DAILY_GROUP = 20,
        /**
         * Indicates the fixed group.
         *
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        FIXED_GROUP = 30,
        /**
         * Indicates the rare group.
         *
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RARE_GROUP = 40,
        /**
         * Indicates the limit group.
         *
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        LIMITED_GROUP = 50,
        /**
         * Indicates the never group.
         *
         * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        NEVER_GROUP = 60
    }
    /**
     * Set app group by bundleName.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { string } bundleName - name of the application.
     * @param { GroupType } newGroup - the group of the application whose name is bundleName.
     * @param { AsyncCallback<void> } callback - the callback of setAppGroup.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10100001 - Repeated operation on the application group.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function setAppGroup(bundleName: string, newGroup: GroupType, callback: AsyncCallback<void>): void;
    /**
     * Set app group by bundleName.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { string } bundleName - name of the application.
     * @param { GroupType } newGroup - the group of the application whose name is bundleName.
     * @returns { Promise<void> } the promise returned by setAppGroup.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10100001 - Repeated operation on the application group.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function setAppGroup(bundleName: string, newGroup: GroupType): Promise<void>;
    /**
     * Register appGroup change callback to service.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { Callback<AppGroupCallbackInfo> } groupCallback -
     * <p> callback of AppGroupCallbackInfo when the group of app changed.</p>
     * @param { AsyncCallback<void> } callback - the callback of registerAppGroupCallBack.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10100001 - Repeated operation on the application group.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function registerAppGroupCallBack(groupCallback: Callback<AppGroupCallbackInfo>, callback: AsyncCallback<void>): void;
    /**
     * Register appGroup change callback to service.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { Callback<AppGroupCallbackInfo> } groupCallback -
     * <p> callback of AppGroupCallbackInfo when the group of app changed.</p>
     * @returns { Promise<void> } the promise returned by registerAppGroupCallBack.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10100001 - Repeated operation on the application group.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function registerAppGroupCallBack(groupCallback: Callback<AppGroupCallbackInfo>): Promise<void>;
    /**
     * Unregister appGroup change callback from service.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { AsyncCallback<void> } callback - the callback of unregisterAppGroupCallBack.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10100001 - Repeated operation on the application group.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function unregisterAppGroupCallBack(callback: AsyncCallback<void>): void;
    /**
     * Unregister appGroup change callback from service.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @returns { Promise<void> } the promise returned by unregisterAppGroupCallBack.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10100001 - Repeated operation on the application group.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.AppGroup
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function unregisterAppGroupCallBack(): Promise<void>;
    /**
     * Queries device event states data within a specified period identified by the start and end time.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @param { AsyncCallback<Array<DeviceEventStats>> } callback - the callback of queryDeviceEventStats.
     * <p> the {@link DeviceEventStats} object Array containing the event states data.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryDeviceEventStats(begin: long, end: long, callback: AsyncCallback<Array<DeviceEventStats>>): void;
    /**
     * Queries device event states data within a specified period identified by the start and end time.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @returns { Promise<Array<DeviceEventStats>> } the promise returned by queryDeviceEventStats.
     * <p> the {@link DeviceEventStats} object Array containing the event states data.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryDeviceEventStats(begin: long, end: long): Promise<Array<DeviceEventStats>>;
    /**
     * Queries app notification number within a specified period identified by the start and end time.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @param { AsyncCallback<Array<DeviceEventStats>> } callback - the callback of queryNotificationEventStats.
     * <p> the {@link DeviceEventStats} object Array containing the event states data.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryNotificationEventStats(begin: long, end: long, callback: AsyncCallback<Array<DeviceEventStats>>): void;
    /**
     * Queries app notification number within a specified period identified by the start and end time.
     *
     * @permission ohos.permission.BUNDLE_ACTIVE_INFO
     * @param { long } begin - Indicates the start time of the query period, in milliseconds.
     * @param { long } end - Indicates the end time of the query period, in milliseconds.
     * @returns { Promise<Array<DeviceEventStats>> } the promise returned by queryNotificationEventStats.
     * <p> the {@link DeviceEventStats} object Array containing the event states data.</p>
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter error. Possible cause: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameters types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 10000001 - Memory operation failed.
     * @throws { BusinessError } 10000002 - Failed to write data into parcel. Possible reasons: 1. Invalid parameters;
     * <br> 2. Failed to apply for memory.
     * @throws { BusinessError } 10000003 - Failed to get system ability manager.
     * @throws { BusinessError } 10000004 - Failed to access the device usage service.
     * @throws { BusinessError } 10000006 - Failed to get the application information.
     * @throws { BusinessError } 10000007 - Failed to get the system time.
     * @syscap SystemCapability.ResourceSchedule.UsageStatistics.App
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function queryNotificationEventStats(begin: long, end: long): Promise<Array<DeviceEventStats>>;
}
export default usageStatistics;
