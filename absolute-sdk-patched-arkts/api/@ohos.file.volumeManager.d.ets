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
 * Provides volumemanager statistics APIs
 *
 * @namespace volumeManager
 * @syscap SystemCapability.FileManagement.StorageService.Volume
 * @systemapi
 * @since 20
 */
declare namespace volumeManager {
    /**
     * Get All Volumes
     *
     * @interface Volume
     * @syscap SystemCapability.FileManagement.StorageService.Volume
     * @systemapi
     * @since 20
     */
    export interface Volume {
        /**
         * Universally unique identifier of volume.
         *
         * @type { string }
         * @syscap SystemCapability.FileManagement.StorageService.Volume
         * @systemapi
         * @since 20
         */
        uuid: string;
        /**
         * The label of the volume.
         *
         * @type { string }
         * @syscap SystemCapability.FileManagement.StorageService.Volume
         * @systemapi
         * @since 20
         */
        description: string;
    }
    /**
     * Get All Volumes
     *
     * @permission ohos.permission.STORAGE_MANAGER
     * @param { AsyncCallback<Array<Volume>> } callback - callback
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:Mandatory
  parameters are left unspecified;
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.Volume
     * @systemapi
     * @since 20
     */
    function getAllVolumes(callback: AsyncCallback<Array<Volume>>): void;
    /**
     * Get All Volumes
     *
     * @permission ohos.permission.STORAGE_MANAGER
     * @returns { Promise<Array<Volume>> } return Promise
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:Mandatory
  parameters are left unspecified;
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.Volume
     * @systemapi
     * @since 20
     */
    function getAllVolumes(): Promise<Array<Volume>>;
    /**
     * Get the volume by uuid.
     *
     * @permission ohos.permission.STORAGE_MANAGER
     * @param { string } uuid - The uuid of volume
     * @param { AsyncCallback<Volume> } callback - callback
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory
  parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13600008 - No such object.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.Volume
     * @systemapi
     * @since 20
     */
    function getVolumeByUuid(uuid: string, callback: AsyncCallback<Volume>): void;
    /**
     * Get the volume by uuid.
     *
     * @permission ohos.permission.STORAGE_MANAGER
     * @param { string } uuid - The uuid of volume
     * @returns { Promise<Volume> } return Promise
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory
  parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 13600001 - IPC error.
     * @throws { BusinessError } 13600008 - No such object.
     * @throws { BusinessError } 13900042 - Unknown error.
     * @syscap SystemCapability.FileManagement.StorageService.Volume
     * @systemapi
     * @since 20
     */
    function getVolumeByUuid(uuid: string): Promise<Volume>;
}
export default volumeManager;
