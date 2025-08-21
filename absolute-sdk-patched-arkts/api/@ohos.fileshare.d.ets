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
import type wantConstant from './@ohos.app.ability.wantConstant';
/**
 * Provides fileshare APIS
 *
 * @namespace fileShare
 * @syscap SystemCapability.FileManagement.AppFileService
 * @since 20
 */
declare namespace fileShare {
    /**
     * Enumerates the uri operate mode types.
     *
     * @enum { int } OperationMode
     * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
     * @since 20
     */
    export enum OperationMode {
        /**
         * Indicates read permissions.
         *
         * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
         * @since 20
         */
        READ_MODE = 0b1,
        /**
         * Indicates write permissions.
         *
         * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
         * @since 20
         */
        WRITE_MODE = 0b10
    }
    /**
     * Policy information to manager permissions on a URI.
     *
     * @interface PolicyInfo
     * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
     * @since 20
     */
    export interface PolicyInfo {
        /**
         * Indicates the uri of the policy information.
         *
         * @type { string }
         * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
         * @since 20
         */
        uri: string;
        /**
         * Indicates the mode of operation for the URI, example { OperationMode.READ_MODE } or { OperationMode.READ_MODE | OperationMode.WRITE_MODE }
         *
         * @type { int }
         * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
         * @since 20
         */
        operationMode: int;
    }
    /**
     * Policy information to manager permissions on a path.
     *
     * @interface PathPolicyInfo
     * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
     * @since 20
     */
    export interface PathPolicyInfo {
        /**
         * Indicates the path of the policy information.
         *
         * @type { string }
         * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
         * @since 20
         */
        path: string;
        /**
         * Indicates the mode of operation for the path.
         *
         * @type { OperationMode }
         * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
         * @since 20
         */
        operationMode: OperationMode;
    }
    /**
     * Indicates the policy type of the path.
     *
     * @enum { number } policyType
     * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
     * @since 20
     */
    export enum PolicyType {
        /**
         * Indicates that the policy is temporary.
         *
         * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
         * @since 20
         */
        TEMPORARY_TYPE = 0,
        /**
         * Indicates that the policy is persistent.
         *
         * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
         * @since 20
         */
        PERSISTENT_TYPE = 1
    }
    /**
     * Provides grant uri permission for app
     *
     * @permission ohos.permission.WRITE_MEDIA
     * @param { string } uri uri
     * @param { string } bundleName bundleName
     * @param { wantConstant.Flags } flag wantConstant.Flags.FLAG_AUTH_READ_URI_PERMISSION or wantConstant.Flags.FLAG_AUTH_WRITE_URI_PERMISSION
     * @param { AsyncCallback<void> } callback
     * @throws { BusinessError } 201 - Permission verification failed
     * @throws { BusinessError } 202 - The caller is not a system application
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 14300001 - IPC error
     * @syscap SystemCapability.FileManagement.AppFileService
     * @systemapi
     * @since 20
     */
    function grantUriPermission(uri: string, bundleName: string, flag: wantConstant.Flags, callback: AsyncCallback<void>): void;
    /**
     * Provides grant uri permission for app
     *
     * @permission ohos.permission.WRITE_MEDIA
     * @param { string } uri uri
     * @param { string } bundleName bundleName
     * @param { wantConstant.Flags } flag wantConstant.Flags.FLAG_AUTH_READ_URI_PERMISSION or wantConstant.Flags.FLAG_AUTH_WRITE_URI_PERMISSION
     * @returns { Promise<void> } no callback return Promise otherwise return void
     * @throws { BusinessError } 201 - Permission verification failed
     * @throws { BusinessError } 202 - The caller is not a system application
     * @throws { BusinessError } 401 - The input parameter is invalid.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 14300001 - IPC error
     * @syscap SystemCapability.FileManagement.AppFileService
     * @systemapi
     * @since 20
     */
    function grantUriPermission(uri: string, bundleName: string, flag: wantConstant.Flags): Promise<void>;
    /**
     * Enable the URI that have been permanently authorized
     *
     * @permission ohos.permission.FILE_ACCESS_PERSIST
     * @param { Array<PolicyInfo> } policies - Policy information to grant permission on URIs.
     * @returns { Promise<void> } the promise returned by the function.
     * @throws { BusinessError } 201 - Permission verification failed, usually the result returned by VerifyAccessToken.
     * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 13900001 - Operation not permitted.
     * @throws { BusinessError } 13900042 - Out of memory
     * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
     * @since 20
     */
    function activatePermission(policies: Array<PolicyInfo>): Promise<void>;
    /**
     * Stop the authorized URI that has been enabled
     *
     * @permission ohos.permission.FILE_ACCESS_PERSIST
     * @param { Array<PolicyInfo> } policies - Policy information to grant permission on URIs.
     * @returns { Promise<void> } the promise returned by the function.
     * @throws { BusinessError } 201 - Permission verification failed, usually the result returned by VerifyAccessToken.
     * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 13900001 - Operation not permitted.
     * @throws { BusinessError } 13900042 - Out of memory
     * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
     * @since 20
     */
    function deactivatePermission(policies: Array<PolicyInfo>): Promise<void>;
    /**
     * Check permissions for the path.
     *
     * @permission ohos.permission.CHECK_SANDBOX_POLICY
     * @param { int } tokenID - Token ID of the application.
     * @param { Array<PathPolicyInfo> } policies - Policy information to check on paths.
     * @param { PolicyType } policyType - Persistent or temporary type.
     * @returns { Promise<Array<boolean>> } Returns the permission state of paths.
     * @throws { BusinessError } 201 - Permission verification failed, usually the result returned by VerifyAccessToken.
     * @throws { BusinessError } 202 - The caller is not a system application
     * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameter types.
     * @throws { BusinessError } 801 - Capability not supported.
     * @syscap SystemCapability.FileManagement.AppFileService.FolderAuthorization
     * @systemapi
     * @since 20
     */
    function checkPathPermission(tokenID: int, policies: Array<PathPolicyInfo>, policyType: PolicyType): Promise<Array<boolean>>;
}
export default fileShare;
