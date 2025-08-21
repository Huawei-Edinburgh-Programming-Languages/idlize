/*
 * Copyright (C) 2022-2025 Huawei Device Co., Ltd.
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
 * @kit CoreFileKit
 */
import { AsyncCallback, Callback } from './@ohos.base';
/**
 * Provides filesystem statistics APIs.
 *
 * @namespace storageStatistics
 * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
 * @since 20
 */
declare namespace storageStatistics {
    /**
     * Get the bundle statistics.
     *
     * @interface BundleStats
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @since 20
     */
    export interface BundleStats {
        /**
         * The size of application installation data.
         *
         * @type { long }
         * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
         * @since 20
         */
        appSize: long;
        /**
         * The size of application cache data.
         *
         * @type { long }
         * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
         * @since 20
         */
        cacheSize: long;
        /**
         * The size of application local data, distributed data and database data.
         *
         * @type { long }
         * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
         * @since 20
         */
        dataSize: long;
    }
    /**
     * Get the current bundle statistics.
     *
     * @param { AsyncCallback<BundleStats> } callback - callback
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:Mandatory
  parameters are left unspecified;
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @since 20
     */
    function getCurrentBundleStats(callback: AsyncCallback<BundleStats>): void;
    /**
     * Get the current bundle statistics.
     *
     * @returns { Promise<BundleStats> } return Promise
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:Mandatory
  parameters are left unspecified;
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @since 20
     */
    function getCurrentBundleStats(): Promise<BundleStats>;
    /**
     * Get the user storage statistics.
     *
     * @interface StorageStats
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @systemapi
     * @since 20
     */
    export interface StorageStats {
        /**
         * The total size of device.
         *
         * @type { long }
         * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
         * @systemapi
         * @since 20
         */
        total: long;
    }
    /**
     * Get the user storage statistics.
     *
     * @permission ohos.permission.STORAGE_MANAGER
     * @returns { Promise<StorageStats> } return Promise
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory
  parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @systemapi
     * @since 20
     */
    function getUserStorageStats(): Promise<StorageStats>;
    /**
     * Get the user storage statistics.
     *
     * @permission ohos.permission.STORAGE_MANAGER
     * @param { AsyncCallback<StorageStats> } callback - callback
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory
  parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @systemapi
     * @since 20
     */
    function getUserStorageStats(callback: AsyncCallback<StorageStats>): void;
    /**
     * Get the user storage statistics.
     *
     * @permission ohos.permission.STORAGE_MANAGER
     * @param { long } userId - The id of the user
     * @returns { Promise<StorageStats> } return Promise
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory
  parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13600009 - User if out of range.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @systemapi
     * @since 20
     */
    function getUserStorageStats(userId: long): Promise<StorageStats>;
    /**
     * Get the user storage statistics.
     *
     * @permission ohos.permission.STORAGE_MANAGER
     * @param { long } userId - The id of the user
     * @param { AsyncCallback<StorageStats> } callback - callback
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory
  parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13600009 - User if out of range.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @systemapi
     * @since 20
     */
    function getUserStorageStats(userId: long, callback: AsyncCallback<StorageStats>): void;
    
    /**
     * Get the total size.
     *
     * @param { AsyncCallback<long> } callback - callback
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:Mandatory
  parameters are left unspecified;
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @since 20
     */
    function getTotalSize(callback: AsyncCallback<long>): void;
    
    /**
     * Get the total size.
     *
     * @returns { Promise<long> } return Promise
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @since 20
     */
    function getTotalSize(): Promise<long>;
    
    /**
     * Get the free size.
     *
     * @param { AsyncCallback<long> } callback - callback
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:Mandatory
  parameters are left unspecified;
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @since 20
     */
    function getFreeSize(callback: AsyncCallback<long>): void;
    
    /**
     * Get the free size.
     *
     * @returns { Promise<long> } return Promise
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.SpatialStatistics
     * @since 20
     */
    function getFreeSize(): Promise<long>;
}
export default storageStatistics;
