/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
 * @kit CoreFileKit
 */
import type { AsyncCallback, Callback } from './@ohos.base';
/**
 * Provides the capabilities to manage the state and data of cloud file synchronization.
 *
 * @namespace cloudSyncManager
 * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
 * @since 20
 */
declare namespace cloudSyncManager {
    /**
     * Modify switch state of the application's cloud synchronization capability.
     *
     * @param { string } accountId - Current account id
     * @param { string } bundleName - Name of bundle whose switchStatus is changing
     * @param { boolean } status - New switch status
     * @returns { Promise<void> } - Return Promise
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function changeAppCloudSwitch(accountId: string, bundleName: string, status: boolean): Promise<void>;
    /**
     * Modify switch state of the application's cloud synchronization capability.
     *
     * @param { string } accountId - Current account id
     * @param { string } bundleName - Name of bundle whose switchStatus is changing
     * @param { boolean } status - New switch status
     * @param { AsyncCallback<void> } [callback] - Callback function
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function changeAppCloudSwitch(accountId: string, bundleName: string, status: boolean, callback: AsyncCallback<void>): void;
    /**
     * Notify the change of data in cloud.
     *
     * @param { string } accountId - Current account id
     * @param { string } bundleName - Name of bundle whose switchStatus is changing
     * @returns { Promise<void> } Return Promise
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function notifyDataChange(accountId: string, bundleName: string): Promise<void>;
    /**
     * Notify the change of data in cloud.
     *
     * @param { string } accountId - Current account id
     * @param { string } bundleName - Name of bundle whose switchStatus is changing
     * @param { AsyncCallback<void> } [callback] - Callback function
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function notifyDataChange(accountId: string, bundleName: string, callback: AsyncCallback<void>): void;
    /**
     * Enable the cloud file synchronization function.
     *
     * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
     * @param { string } accountId - Current account id.
     * @param { Record<string, boolean> } switches - Indicates switches information of all applications.
     * @returns { Promise<void> } Return Promise
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function enableCloud(accountId: string, switches: Record<string, boolean>): Promise<void>;
    /**
     * Enable the cloud file synchronization function.
     *
     * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
     * @param { string } accountId - Current account id
     * @param { Record<string, boolean> } switches - Indicates switches information of all applications.
     * @param { AsyncCallback<void> } [callback] - Callback function
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function enableCloud(accountId: string, switches: Record<string, boolean>, callback: AsyncCallback<void>): void;
    /**
     * Disable the cloud file synchronization function.
     *
     * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
     * @param { string } accountId - Current account id.
     * @returns { Promise<void> } Return Promise.
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function disableCloud(accountId: string): Promise<void>;
    /**
     * Disable the cloud file synchronization function.
     *
     * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
     * @param { string } accountId - Current account id.
     * @param { AsyncCallback<void> } callback - Callback function
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function disableCloud(accountId: string, callback: AsyncCallback<void>): void;
    /**
     * Describes the clear action type.
     *
     * @enum { int }
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    enum Action {
        /**
         * Indicates clearing cloud identification only, retaining local cached data.
         *
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @systemapi
         * @since 20
         */
        RETAIN_DATA,
        /**
         * Indicates clearing all cloud-related file data, which synchronized with the cloud.
         *
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @systemapi
         * @since 20
         */
        CLEAR_DATA
    }
    /**
     * Clean up cloud-related file data based on specific action.
     *
     * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
     * @param { string } accountId - Current account id.
     * @param { Record<string, Action> } appActions - Indicates information about cloud file need to clear in which way.
     * @returns { Promise<void> } Return Promise.
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function clean(accountId: string, appActions: Record<string, Action>): Promise<void>;
    /**
     * Clean up cloud-related file data based on specific action.
     *
     * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
     * @param { string } accountId - Current account id.
     * @param { Record<string, Action> } appActions - Indicates information about cloud file need to clear in which way.
     * @param { AsyncCallback<void> } callback - Callback function
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function clean(accountId: string, appActions: Record<string, Action>, callback: AsyncCallback<void>): void;
    /**
     * Notify the change of data in cloud.
     *
     * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
     * @param { int } userId - The Id of the user whose cloud data changed
     * @param { ExtraData } extraData - The change info from push notification
     * @returns { Promise<void> } Return Promise
     * @throws { BusinessError } 201 - Permission verification failed, usually the result returned by VerifyAccessToken.
     * @throws { BusinessError } 202 - Permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 13600001 - IPC error.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function notifyDataChange(userId: int, extraData: ExtraData): Promise<void>;
    /**
     * Notify the change of data in cloud.
     *
     * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
     * @param { int } userId - The Id of the user whose cloud data changed
     * @param { ExtraData } extraData - The change info from push notification
     * @param { AsyncCallback<void> } callback - Callback function
     * @throws { BusinessError } 201 - Permission verification failed, usually the result returned by VerifyAccessToken.
     * @throws { BusinessError } 202 - Permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 13600001 - IPC error.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    function notifyDataChange(userId: int, extraData: ExtraData, callback: AsyncCallback<void>): void;
    /**
     * The change info from push notification.
     *
     * @interface ExtraData
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    interface ExtraData {
        /**
         * The eventId of the push info.
         *
         * @type { string }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @systemapi
         * @since 20
         */
        eventId: string;
        /**
         * The change info.
         *
         * @type { string }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @systemapi
         * @since 20
         */
        extraData: string;
    }
    /**
     * Describes the reason why the download task stop.
     * @enum { number } DownloadStopReason
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @since 20
     */
    enum DownloadStopReason {
        /**
         * download task is not stopped.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        NO_STOP = 0,
        /**
         * Network is unavailable.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        NETWORK_UNAVAILABLE = 1,
        /**
         * The local storage space is full.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        LOCAL_STORAGE_FULL = 2,
        /**
         * Temperature control Limits.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        TEMPERATURE_LIMIT = 3,
        /**
         * User stopped the download task.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        USER_STOPPED = 4,
        /**
         * The local application has been unloaded.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        APP_UNLOAD = 5,
        /**
         * Other reasons of some internal error.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        OTHER_REASON = 6
    }
    /**
     * Describes the state type of downgrade download.
     * @enum { number } DownloadState
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @since 20
     */
    enum DownloadState {
        /**
         * Indicates that the download task in process now.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        RUNNING = 0,
        /**
         * Indicates that the download task finished.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        COMPLETED = 1,
        /**
         * Indicates that the download task stopped.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        STOPPED = 2
    }
    /**
     * Defines the CloudFileInfo data structure.
     * @typedef CloudFileInfo
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @since 20
     */
    interface CloudFileInfo {
        /**
         * Total number of files located in the cloud.
         * @type { number }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        cloudFileCount: number;
        /**
         * Total size of files located in the cloud, in units of bytes.
         * @type { number }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        cloudFileTotalSize: number;
        /**
         * Total number of files located locally.
         * @type { number }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        localFileCount: number;
        /**
         * Total size of files located locally, in units of bytes.
         * @type { number }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        localFileTotalSize: number;
        /**
         * Total number of files located both locally and in the cloud.
         * @type { number }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        bothFileCount: number;
        /**
         * Total size of files located both locally and in the cloud, in units of bytes.
         * @type { number }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        bothFileTotalSize: number;
    }
    /**
     * Defines DownloadProgress object.
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @since 20
     */
    class DownloadProgress {
        /**
         * The current download task state.
         * @type { DownloadState }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        state: DownloadState;
        /**
         * The number of files that downloaded successfully
         * @type { number }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        successfulCount: number;
        /**
         * The number of files that fail to be downloaded.
         * @type { number }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        failedCount: number;
        /**
         * Total number of all files to be downloaded.
         * @type { number }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        totalCount: number;
        /**
         * Total size of downloaded files.
         * @type { number }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        downloadedSize: number;
        /**
         * Total size of all files to be downloaded.
         * @type { number }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        totalSize: number;
        /**
         * The reason for stopping the download task.
         * @type { DownloadStopReason }
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @since 20
         */
        stopReason: DownloadStopReason;
    }
    /**
     * DowngradeDownload object.
     *
     * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
     * @systemapi
     * @since 20
     */
    class DowngradeDownload {
        /**
         * A constructor used to create a DowngradeDownload object.
         *
         * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
         * @param { string } bundleName - Name of the bundle that need to synchronize and subscribe the sync progress event.
         * @throws { BusinessError } 201 - Permission verification failed, usually the result returned by VerifyAccessToken.
         * @throws { BusinessError } 202 - Permission verification failed, application which is not a system application uses system API.
         * @throws { BusinessError } 13900020 - Parameter error. Possible causes:
         *     <br>1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
         * @throws { BusinessError } 22400005 - Inner error. Possible causes:
         *     <br>1.Failed to access the database or execute the SQL statement.
         *     <br>2.System error, such as a null pointer, insufficient memory or a JS engine exception.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @systemapi
         * @since 20
         */
        constructor(bundleName: string);
        /**
         * Get the total size and number of files in different locations.
         *
         * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
         * @returns { Promise<CloudFileInfo> } - Return the file size and number info.
         * @throws { BusinessError } 201 - Permission verification failed, usually the result returned by VerifyAccessToken.
         * @throws { BusinessError } 202 - Permission verification failed, application which is not a system application uses system API.
         * @throws { BusinessError } 13600001 - IPC error. Possible causes:
         *     <br>1.IPC failed or timed out. 2.Failed to load the service.
         * @throws { BusinessError } 13900010 - Try again.
         * @throws { BusinessError } 22400005 - Inner error. Possible causes:
         *     <br>1.Failed to access the database or execute the SQL statement.
         *     <br>2.System error, such as a null pointer, insufficient memory or a JS engine exception.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @systemapi
         * @since 20
         */
        getCloudFileInfo(): Promise<CloudFileInfo>;
        /**
         * Start to download all cloud files of the specified application to local.
         *
         * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
         * @param { Callback<DownloadProgress> } callback - callback function with a `DownloadProgress` argument.
         * @returns { Promise<void> } - Return Promise.
         * @throws { BusinessError } 201 - Permission verification failed, usually the result returned by VerifyAccessToken.
         * @throws { BusinessError } 202 - Permission verification failed, application which is not a system application uses system API.
         * @throws { BusinessError } 13600001 - IPC error. Possible causes:
         *     <br>1.IPC failed or timed out. 2.Failed to load the service.
         * @throws { BusinessError } 13900010 - Try again.
         * @throws { BusinessError } 13900020 - Parameter error. Possible causes:
         *     <br>1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
         * @throws { BusinessError } 22400005 - Inner error. Possible causes:
         *     <br>1.Failed to access the database or execute the SQL statement.
         *     <br>2.System error, such as a null pointer, insufficient memory or a JS engine exception.
         * @throws { BusinessError } 22400006 - The same task is already in progress.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @systemapi
         * @since 20
         */
        startDownload(callback: Callback<DownloadProgress>): Promise<void>;
        /**
         * Stop the specified application's download task.
         *
         * @permission ohos.permission.CLOUDFILE_SYNC_MANAGER
         * @returns { Promise<void> } - Return Promise.
         * @throws { BusinessError } 201 - Permission verification failed, usually the result returned by VerifyAccessToken.
         * @throws { BusinessError } 202 - Permission verification failed, application which is not a system application uses system API.
         * @throws { BusinessError } 13600001 - IPC error. Possible causes:
         *     <br>1.IPC failed or timed out. 2.Failed to load the service.
         * @throws { BusinessError } 22400005 - Inner error. Possible causes:
         *     <br>1.Failed to access the database or execute the SQL statement.
         *     <br>2.System error, such as a null pointer, insufficient memory or a JS engine exception.
         * @syscap SystemCapability.FileManagement.DistributedFileService.CloudSyncManager
         * @systemapi
         * @since 20
         */
        stopDownload(): Promise<void>;
    }
}
export default cloudSyncManager;
