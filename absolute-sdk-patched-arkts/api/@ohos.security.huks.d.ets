/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
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
 * @kit UniversalKeystoreKit
 */
import { BusinessError, AsyncCallback } from '@ohos.base';

/**
 * OpenHarmony Universal KeyStore
 *
 * @namespace huks
 * @syscap SystemCapability.Security.Huks.Core
 * @since 20
 */
declare namespace huks {
    
    /**
     * Generates a key. This API uses an asynchronous callback to return the result.
     *
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } options - Tags required for generating the key. The algorithm, key purpose,
     * and key length are mandatory.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
     * this API does not return the key content because the key is always protected in a TEE. If an exception occurs in
     * the generation process, an error is captured.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000013 - queried credential does not exist
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @throws { BusinessError } 12000015 - Failed to obtain the security information via UserIAM
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    function generateKeyItem(keyAlias: string, options: HuksOptions, callback: AsyncCallback<void>): void;
    
    /**
     * Generates a key. This API uses a promise to return the result. Because the key is always
     * protected in a trusted environment (such as a TEE), the promise does not return the key content.
     * It returns only the information indicating whether the API is successfully called.
     *
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } options - Tags required for generating the key. The algorithm, key purpose,
     * and key length are mandatory.
     * @returns { Promise<void> } the promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000013 - queried credential does not exist
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @throws { BusinessError } 12000015 - Failed to obtain the security information via UserIAM
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function generateKeyItem(keyAlias: string, options: HuksOptions): Promise<void>;
    /**
     * Generate Key As User.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { int } userId - userId indicates the userId of the owner of the key.
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } huksOptions - huksOptions indicates the properties of the key.
     * @returns { Promise<void> } the promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied. An attempt was made to use key as user forbidden by permission:
     * <br>ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS.
     * @throws { BusinessError } 202 - not system app
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000013 - queried credential does not exist
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @throws { BusinessError } 12000015 - Failed to obtain the security information via UserIAM
     * @syscap SystemCapability.Security.Huks.Extension
     * @systemapi this method can be used only by system applications.
     * @since 20
     */
    function generateKeyItemAsUser(userId: int, keyAlias: string, huksOptions: HuksOptions): Promise<void>;
    
    /**
     * Deletes a key. This API uses an asynchronous callback to return the result.
     *
     * @param { string } keyAlias - Alias of the key to delete. It must be the key alias passed in when the key
     * was generated.
     * @param { HuksOptions } options - Properties of the key to delete. For example, you can pass in HuksAuthStorageLevel
     * to specify the security level of the key to delete. HuksAuthStorageLevel can be left empty, which means the default
     * value HUKS_AUTH_STORAGE_LEVEL_DE is used.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
     * no err value is returned; otherwise, an error code is returned.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    function deleteKeyItem(keyAlias: string, options: HuksOptions, callback: AsyncCallback<void>): void;
    
    /**
     * Deletes a key. This API uses a promise to return the result.
     *
     * @param { string } keyAlias - Alias of the key to delete. It must be the key alias passed in when the key
     * was generated.
     * @param { HuksOptions } options - Options for deleting the key. For example, you can pass in HuksAuthStorageLevel to
     * specify the security level of the key to delete. HuksAuthStorageLevel can be left empty, which means the default
     * value HUKS_AUTH_STORAGE_LEVEL_DE is used.
     * @returns { Promise<void> } the promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function deleteKeyItem(keyAlias: string, options: HuksOptions): Promise<void>;
    /**
     * Delete Key As User.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { int } userId - userId indicates the userId of the owner of the key.
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } huksOptions - huksOptions indicates the properties of the key.
     * @returns { Promise<void> } the promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied. An attempt was made to use key as user forbidden by permission:
     * <br>ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS.
     * @throws { BusinessError } 202 - not system app
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @systemapi this method can be used only by system applications.
     * @since 20
     */
    function deleteKeyItemAsUser(userId: int, keyAlias: string, huksOptions: HuksOptions): Promise<void>;
    
    
    /**
     * Imports a key in plaintext. This API uses an asynchronous callback to return the result.
     *
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } options - Tags required for the import and key to import. The algorithm, key purpose, and
     * key length are mandatory.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful, no
     * error value is returned; otherwise, an error code is returned.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000013 - queried credential does not exist
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @throws { BusinessError } 12000015 - Failed to obtain the security information via UserIAM
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    function importKeyItem(keyAlias: string, options: HuksOptions, callback: AsyncCallback<void>): void;
    
    /**
     * Imports a key in plaintext. This API uses a promise to return the result.
     *
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } options - Tags required for the import and key to import. The algorithm, key purpose, and
     * key length are mandatory.
     * @returns { Promise<void> } the promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000013 - queried credential does not exist
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @throws { BusinessError } 12000015 - Failed to obtain the security information via UserIAM
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function importKeyItem(keyAlias: string, options: HuksOptions): Promise<void>;
    /**
     * Import Key As User.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { int } userId - userId indicates the userId of the owner of the key.
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } huksOptions - huksOptions indicates the properties of the key.
     * @returns { Promise<void> } the promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied. An attempt was made to use key as user forbidden by permission:
     * <br>ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS.
     * @throws { BusinessError } 202 - not system app
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000013 - queried credential does not exist
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @throws { BusinessError } 12000015 - Failed to obtain the security information via UserIAM
     * @syscap SystemCapability.Security.Huks.Extension
     * @systemapi this method can be used only by system applications.
     * @since 20
     */
    function importKeyItemAsUser(userId: int, keyAlias: string, huksOptions: HuksOptions): Promise<void>;
    
    /**
     * Imports a wrapped key. This API uses an asynchronous callback to return the result.
     *
     * @param { string } keyAlias - Alias of the wrapped key to import.
     * @param { string } wrappingKeyAlias - Alias of the data used to unwrap the key imported.
     * @param { HuksOptions } options - Tags required for the import and the wrapped key to import.
     * The algorithm, key purpose, and key length are mandatory.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
     * no err value is returned; otherwise, an error code is returned.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000013 - queried credential does not exist
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @throws { BusinessError } 12000015 - Failed to obtain the security information via UserIAM
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    function importWrappedKeyItem(keyAlias: string, wrappingKeyAlias: string, options: HuksOptions, callback: AsyncCallback<void>): void;
    /**
     * Import Wrapped Key As User.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { int } userId - userId indicates the userId of the owner of the key.
     * @param { string } keyAlias - keyAlias indicates the name of key to be imported.
     * @param { string } wrappingKeyAlias - wrappingKeyAlias indicates the name of key for wrapping the key to be imported.
     * @param { HuksOptions } huksOptions - huksOptions indicates the properties of the key.
     * @returns { Promise<void> } the promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied. An attempt was made to use key as user forbidden by permission:
     * <br>ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS.
     * @throws { BusinessError } 202 - not system app
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000013 - queried credential does not exist
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @throws { BusinessError } 12000015 - Failed to obtain the security information via UserIAM
     * @syscap SystemCapability.Security.Huks.Extension
     * @systemapi this method can be used only by system applications.
     * @since 20
     */
    function importWrappedKeyItemAsUser(userId: int, keyAlias: string, wrappingKeyAlias: string, huksOptions: HuksOptions): Promise<void>;
    
    /**
     * Imports a wrapped key. This API uses a promise to return the result.
     *
     * @param { string } keyAlias - Alias of the wrapped key to import.
     * @param { string } wrappingKeyAlias - Alias of the data used to unwrap the key imported.
     * @param { HuksOptions } options - Tags required for the import and the wrapped key to import. The algorithm, key
     * purpose, and key length are mandatory.
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000013 - queried credential does not exist
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @throws { BusinessError } 12000015 - Failed to obtain the security information via UserIAM
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function importWrappedKeyItem(keyAlias: string, wrappingKeyAlias: string, options: HuksOptions): Promise<void>;
    
    /**
     * Exports a key. This API uses an asynchronous callback to return the result.
     *
     * @param { string } keyAlias - Key alias, which must be the same as the alias used when the key was generated.
     * @param { HuksOptions } options - Empty object (leave this parameter empty).
     * @param { AsyncCallback<HuksReturnResult> } callback - Callback used to return the result. If the operation is
     * successful, no err value is returned and outData contains the public key exported. Otherwise,
     * an error code is returned.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    function exportKeyItem(keyAlias: string, options: HuksOptions, callback: AsyncCallback<HuksReturnResult>): void;
    /**
     * Export Key As User.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { int } userId - userId indicates the userId of the owner of the key.
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } huksOptions - huksOptions indicates the properties of the key.
     * @returns { Promise<HuksReturnResult> } the promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied. An attempt was made to use key as user forbidden by permission:
     * <br>ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS.
     * @throws { BusinessError } 202 - not system app
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @systemapi this method can be used only by system applications.
     * @since 20
     */
    function exportKeyItemAsUser(userId: int, keyAlias: string, huksOptions: HuksOptions): Promise<HuksReturnResult>;
    
    /**
     * Exports a key. This API uses a promise to return the result.
     *
     * @param { string } keyAlias - Key alias, which must be the same as the alias used when the key was generated.
     * @param { HuksOptions } options - Empty object (leave this parameter empty).
     * @returns { Promise<HuksReturnResult> } Promise used to return the result. If the operation is successful, outData
     * in HuksReturnResult is the public key exported.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function exportKeyItem(keyAlias: string, options: HuksOptions): Promise<HuksReturnResult>;
    /**
     * Checks whether a key exists. This API uses an asynchronous callback to return the result.
     *
     * @param { string } keyAlias - Alias of the key to check.
     * @param { HuksOptions } options - Options for checking the key. For example, you can pass in HuksAuthStorageLevel to
     * specify the security level of the key to check. HuksAuthStorageLevel can be left empty, which means the default
     * value HUKS_AUTH_STORAGE_LEVEL_DE is used.
     * @param { AsyncCallback<boolean> } callback - Callback used to return the result. If the key exists, data is true.
     * If the key does not exist, error is the error code.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    function isKeyItemExist(keyAlias: string, options: HuksOptions, callback: AsyncCallback<boolean>): void;
    /**
     * Checks whether a key exists. This API uses a promise to return the result.
     *
     * @param { string } keyAlias - Alias of the key to check.
     * @param { HuksOptions } options - Options for checking the key. For example, you can pass in HuksAuthStorageLevel to
     * specify the security level of the key to check. HuksAuthStorageLevel can be left empty, which means the default
     * value HUKS_AUTH_STORAGE_LEVEL_DE is used.
     * @returns { Promise<boolean> } Promise used to return the result. If the key exists, then() performs subsequent
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function isKeyItemExist(keyAlias: string, options: HuksOptions): Promise<boolean>;
    /**
     * Checks whether a key exists. This API uses an asynchronous callback to return the result.
     *
     * @param { string } keyAlias - Alias of the key to check.
     * @param { HuksOptions } options - Options for checking the key. For example, you can pass in HuksAuthStorageLevel to
     * specify the security level of the key to check. HuksAuthStorageLevel can be left empty, which means the default
     * value HUKS_AUTH_STORAGE_LEVEL_DE is used.
     * @param { AsyncCallback<boolean> } callback - Callback used to return the result. If the key exists, data is true.
     * Otherwise, data is false.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    function hasKeyItem(keyAlias: string, options: HuksOptions, callback: AsyncCallback<boolean>): void;
    /**
     * Check whether the key exists as user.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { int } userId - userId indicates the userId of the owner of the key.
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } huksOptions - huksOptions indicates the properties of the key.
     * @returns { Promise<boolean> } the promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied. An attempt was made to use key as user forbidden by permission:
     * <br>ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS.
     * @throws { BusinessError } 202 - not system app
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @systemapi this method can be used only by system applications.
     * @since 20
     */
    function hasKeyItemAsUser(userId: int, keyAlias: string, huksOptions: HuksOptions): Promise<boolean>;
    /**
     * Checks whether a key exists. This API uses a promise to return the result.
     *
     * @param { string } keyAlias - Alias of the key to check.
     * @param { HuksOptions } options - Options for checking the key. For example, you can pass in HuksAuthStorageLevel to
     * specify the security level of the key to check. HuksAuthStorageLevel can be left empty, which means the default
     * value HUKS_AUTH_STORAGE_LEVEL_DE is used.
     * @returns { Promise<boolean> } Promise used to return the result. If the key exists, true is returned. If the key
     * does not exist, false is returned.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function hasKeyItem(keyAlias: string, options: HuksOptions): Promise<boolean>;
    
    /**
     * Initializes a session for a key operation. This API uses an asynchronous callback to return the
     * result. huks.initSession, huks.updateSession, and huks.finishSession must be used together.
     *
     * @param { string } keyAlias - Alias of the key involved in the initSession operation.
     * @param { HuksOptions } options - Parameter set used for the initSession operation.
     * @param { AsyncCallback<HuksSessionHandle> } callback - Callback used to return a session handle for subsequent
     * operations.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000010 - the number of sessions has reached limit
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    function initSession(keyAlias: string, options: HuksOptions, callback: AsyncCallback<HuksSessionHandle>): void;
    
    /**
     * Initializes a session for a key operation. This API uses a promise to return the result.
     * huks.initSession, huks.updateSession, and huks.finishSession must be used together.
     *
     * @param { string } keyAlias - Alias of the key involved in the initSession operation.
     * @param { HuksOptions } options - Parameter set used for the initSession operation.
     * @returns { Promise<HuksSessionHandle> } Promise used to return a session handle for subsequent operations.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000010 - the number of sessions has reached limit
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function initSession(keyAlias: string, options: HuksOptions): Promise<HuksSessionHandle>;
    /**
     * Init Operation As User.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { int } userId - userId indicates the userId of the owner of the key.
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } huksOptions - huksOptions indicates the properties of the key.
     * @returns { Promise<HuksSessionHandle> } the promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied. An attempt was made to use key as user forbidden by permission:
     * <br>ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS.
     * @throws { BusinessError } 202 - not system app
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000010 - the number of sessions has reached limit
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @systemapi this method can be used only by system applications.
     * @since 20
     */
    function initSessionAsUser(userId: int, keyAlias: string, huksOptions: HuksOptions): Promise<HuksSessionHandle>;
    
    /**
     * Updates the key operation by segment. This API uses an asynchronous callback to return the result.
     * huks.initSession, huks.updateSession, and huks.finishSession must be used together.
     *
     * @param { long } handle - Handle for the updateSession operation.
     * @param { HuksOptions } options - Parameter set used for the updateSession operation.
     * @param { AsyncCallback<HuksReturnResult> } callback - Callback used to return the updateSession operation result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000007 - this credential is already invalidated permanently
     * @throws { BusinessError } 12000008 - verify auth token failed
     * @throws { BusinessError } 12000009 - auth token is already timeout
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    function updateSession(handle: long, options: HuksOptions, callback: AsyncCallback<HuksReturnResult>): void;
    
    /**
     * Updates the key operation by segment. This API uses an asynchronous callback to return the result.
     * huks.initSession, huks.updateSession, and huks.finishSession must be used together.
     *
     * @param { long } handle - Handle for the updateSession operation.
     * @param { HuksOptions } options - Parameter set used for the updateSession operation.
     * @param { Uint8Array } token - Authentication token for refined key access control.
     * @param { AsyncCallback<HuksReturnResult> } callback - Callback used to return the updateSession operation result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000007 - this credential is already invalidated permanently
     * @throws { BusinessError } 12000008 - verify auth token failed
     * @throws { BusinessError } 12000009 - auth token is already timeout
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function updateSession(handle: long, options: HuksOptions, token: Uint8Array, callback: AsyncCallback<HuksReturnResult>): void;
    
    /**
     * Updates the key operation by segment. This API uses a promise to return the result. huks.initSession,
     * huks.updateSession, and huks.finishSession must be used together.
     *
     * @param { long } handle - Handle for the updateSession operation.
     * @param { HuksOptions } options - Parameter set used for the updateSession operation.
     * @param { Uint8Array } token - Authentication token for refined key access control. If this parameter is left blank,
     * refined key access control is not performed.
     * @returns { Promise<HuksReturnResult> } Promise used to return the updateSession operation result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000007 - this credential is already invalidated permanently
     * @throws { BusinessError } 12000008 - verify auth token failed
     * @throws { BusinessError } 12000009 - auth token is already timeout
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function updateSession(handle: long, options: HuksOptions, token?: Uint8Array): Promise<HuksReturnResult>;
    
    /**
     * Finishes the key operation. This API uses an asynchronous callback to return the result.
     * huks.initSession, huks.updateSession, and huks.finishSession must be used together.
     *
     * @param { long } handle - Handle for the finishSession operation.
     * @param { HuksOptions } options - Parameter set used for the finishSession operation.
     * @param { AsyncCallback<HuksReturnResult> } callback - Callback used to return the finishSession operation result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000007 - this credential is already invalidated permanently
     * @throws { BusinessError } 12000008 - verify auth token failed
     * @throws { BusinessError } 12000009 - auth token is already timeout
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    function finishSession(handle: long, options: HuksOptions, callback: AsyncCallback<HuksReturnResult>): void;
    
    /**
     * Finishes the key operation. This API uses an asynchronous callback to return the result.
     * huks.initSession, huks.updateSession, and huks.finishSession must be used together.
     *
     * @param { long } handle - Handle for the finishSession operation.
     * @param { HuksOptions } options - Parameter set used for the finishSession operation.
     * @param { Uint8Array } token - Authentication token for refined key access control.
     * @param { AsyncCallback<HuksReturnResult> } callback - Callback used to return the finishSession operation result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000007 - this credential is already invalidated permanently
     * @throws { BusinessError } 12000008 - verify auth token failed
     * @throws { BusinessError } 12000009 - auth token is already timeout
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function finishSession(handle: long, options: HuksOptions, token: Uint8Array, callback: AsyncCallback<HuksReturnResult>): void;
    
    /**
     * Finishes the key operation. This API uses a promise to return the result. huks.initSession,
     * huks.updateSession, and huks.finishSession must be used together.
     *
     * @param { long } handle - Handle for the finishSession operation.
     * @param { HuksOptions } options - Parameter set used for the finishSession operation.
     * @param { Uint8Array } token - Authentication token for refined key access control. If this parameter is left blank,
     * refined key access control is not performed.
     * @returns { Promise<HuksReturnResult> } Promise used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000007 - this credential is already invalidated permanently
     * @throws { BusinessError } 12000008 - verify auth token failed
     * @throws { BusinessError } 12000009 - auth token is already timeout
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function finishSession(handle: long, options: HuksOptions, token?: Uint8Array): Promise<HuksReturnResult>;
    
    /**
     * Aborts a key operation. This API uses an asynchronous callback to return the result.
     *
     * @param { long } handle - Handle for the abortSession operation.
     * @param { HuksOptions } options - Parameter set used for the abortSession operation.
     * @param { AsyncCallback<void> } callback - Callback used to return the abortSession operation result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    function abortSession(handle: long, options: HuksOptions, callback: AsyncCallback<void>): void;
    
    /**
     * Aborts a key operation. This API uses a promise to return the result.
     *
     * @param { long } handle - Handle for the abortSession operation.
     * @param { HuksOptions } options - Parameter set used for the abortSession operation.
     * @returns { Promise<void> } Promise used to return the abortSession operation result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function abortSession(handle: long, options: HuksOptions): Promise<void>;
    /**
     * Obtains the certificate used to attest a key. This API uses an asynchronous callback to return the result.
     *
     * @permission ohos.permission.ATTEST_KEY
     * @param { string } keyAlias - Alias of the key. The certificate to be obtained stores the key.
     * @param { HuksOptions } options - Parameters and data required for obtaining the certificate.
     * @param { AsyncCallback<HuksReturnResult> } callback - Callback used to return the result. If the operation is
     * successful, no err value is returned; otherwise, an error code is returned.
     * @throws { BusinessError } 201 - check permission failed
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function attestKeyItem(keyAlias: string, options: HuksOptions, callback: AsyncCallback<HuksReturnResult>): void;
    /**
     * Key Attestation As User.
     *
     * @permission ohos.permission.ATTEST_KEY and ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { int } userId - userId indicates the userId of the owner of the key.
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } huksOptions - huksOptions indicates the properties of the key attestation operation.
     * @returns { Promise<HuksReturnResult> } the promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied. An attempt was made to use key as user forbidden by permission:
     * <br>ohos.permission.ATTEST_KEY or ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS.
     * @throws { BusinessError } 202 - not system app
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @systemapi this method can be used only by system applications.
     * @since 20
     */
    function attestKeyItemAsUser(userId: int, keyAlias: string, huksOptions: HuksOptions): Promise<HuksReturnResult>;
    /**
     * Obtains the certificate used to attest a key. This API uses a promise to return the result.
     *
     * @permission ohos.permission.ATTEST_KEY
     * @param { string } keyAlias - Alias of the key. The certificate to be obtained stores the key.
     * @param { HuksOptions } options - Parameters and data required for obtaining the certificate.
     * @returns { Promise<HuksReturnResult> } Promise used to return the result. If the operation is successful,
     * certChains in HuksReturnResult is the certificate chain obtained.
     * @throws { BusinessError } 201 - check permission failed
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function attestKeyItem(keyAlias: string, options: HuksOptions): Promise<HuksReturnResult>;
    
    /**
     * Obtains the certificate for anonymous attestation. This API uses an asynchronous callback to return
     * the result. This operation requires Internet access and takes time. If error code 12000012 is returned, the network
     * is abnormal. If the device is not connected to the network, display a message, indicating that the network is not
     * connected. If the network is connected, the failure may be caused by network jitter. Try again later.
     *
     * @param { string } keyAlias - Alias of the key. The certificate to be obtained stores the key.
     * @param { HuksOptions } options - Parameters and data required for obtaining the certificate.
     * @param { AsyncCallback<HuksReturnResult> } callback - Callback used to return the result. If the operation is
     * successful, no err value is returned; otherwise, an error code is returned.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function anonAttestKeyItem(keyAlias: string, options: HuksOptions, callback: AsyncCallback<HuksReturnResult>): void;
    /**
     * Key Attestation with anonymous certificate as user.
     *
     * @permission ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS
     * @param { int } userId - userId indicates the userId of the owner of the key.
     * @param { string } keyAlias - keyAlias indicates the key's name.
     * @param { HuksOptions } huksOptions - huksOptions indicates the properties of the key attestation operation.
     * @returns { Promise<HuksReturnResult> } the promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied. An attempt was made to use key as user forbidden by permission:
     * <br>ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS.
     * @throws { BusinessError } 202 - not system app
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @systemapi this method can be used only by system applications.
     * @since 20
     */
    function anonAttestKeyItemAsUser(userId: int, keyAlias: string, huksOptions: HuksOptions): Promise<HuksReturnResult>;
    
    /**
     * Obtains the certificate for anonymous attestation. This API uses a promise to return the result. This
     * operation requires Internet access and takes time. If error code 12000012 is returned, the network is abnormal. If
     * the device is not connected to the network, display a message, indicating that the network is not connected. If the
     * network is connected, the failure may be caused by network jitter. Try again later.
     *
     * @param { string } keyAlias - Alias of the key. The certificate to be obtained stores the key.
     * @param { HuksOptions } options - Parameters and data required for obtaining the certificate.
     * @returns { Promise<HuksReturnResult> } Promise used to return the result. If the operation is successful,
     * certChains in HuksReturnResult is the certificate chain obtained.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 801 - api is not supported
     * @throws { BusinessError } 12000001 - algorithm mode is not supported
     * @throws { BusinessError } 12000002 - algorithm param is missing
     * @throws { BusinessError } 12000003 - algorithm param is invalid
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000006 - error occurred in crypto engine
     * @throws { BusinessError } 12000011 - queried entity does not exist
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function anonAttestKeyItem(keyAlias: string, options: HuksOptions): Promise<HuksReturnResult>;
    /**
     * Lists key aliases. This API uses a promise to return the result.
     *
     * @param { HuksOptions } options - Parameters for listing key aliases.
     * @returns { Promise<HuksListAliasesReturnResult> } Promise used to return the key aliases obtained.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *                                 1. Mandatory parameters are left unspecified.
     *                                 2. Incorrect parameter types.
     *                                 3. Parameter verification failed.
     * @throws { BusinessError } 12000004 - operating file failed
     * @throws { BusinessError } 12000005 - IPC communication failed
     * @throws { BusinessError } 12000012 - Device environment or input parameter abnormal
     * @throws { BusinessError } 12000014 - memory is insufficient
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    function listAliases(options: HuksOptions): Promise<HuksListAliasesReturnResult>;
    
    /**
     * Defines the param field in the properties array of options used in the APIs.
     *
     * @typedef HuksParam
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export interface HuksParam {
        
        /**
         * @type { HuksTag }
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        tag: HuksTag;
        
        /**
         * @type { boolean | int | bigint | Uint8Array }
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        value: boolean | int | bigint | Uint8Array;
    }
    
    /**
     * Defines the struct for a HUKS handle.
     *
     * @typedef HuksSessionHandle
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export interface HuksSessionHandle {
        
        /**
         * @type { long }
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        handle: long;
        
        /**
         * @type { ?Uint8Array }
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        challenge?: Uint8Array;
    }
    
    /**
     * Defines options used in the APIs.
     *
     * @typedef HuksOptions
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export interface HuksOptions {
        
        /**
         * @type { ?Array<HuksParam> }
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        properties?: Array<HuksParam>;
        
        /**
         * @type { ?Uint8Array }
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        inData?: Uint8Array;
    }
    
    /**
     * Represents the result returned.
     *
     * @typedef HuksReturnResult
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export interface HuksReturnResult {
        
        /**
         * @type { ?Uint8Array }
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        outData?: Uint8Array;
        
        /**
         * @type { ?Array<HuksParam> }
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        properties?: Array<HuksParam>;
        
        /**
         * @type { ?Array<string> }
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        certChains?: Array<string>;
    }
    /**
   * Represents an array of key aliases.
   *
   * @typedef HuksListAliasesReturnResult
   * @syscap SystemCapability.Security.Huks.Extension
   * @since 20
   */
    export interface HuksListAliasesReturnResult {
        /**
         * the returned list of key aliases
         *
         * @type { Array<string> }
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        keyAliases: Array<string>;
    }
    
    /**
     * Enumerates the error codes.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksExceptionErrCode {
        
        /**
         * Permission verification failed.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_PERMISSION_FAIL = 201,
        /**
         * The caller is not a system application and cannot call the system API.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_NOT_SYSTEM_APP = 202,
        
        /**
         * Invalid parameters are detected. Possible causes:
         * 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * 3. Parameter verification failed.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_ILLEGAL_ARGUMENT = 401,
        
        /**
         * The API is not supported.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_NOT_SUPPORTED_API = 801,
        
        /**
         * The feature is not supported.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_FEATURE_NOT_SUPPORTED = 12000001,
        
        /**
         * Key algorithm parameters are missing.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_MISSING_CRYPTO_ALG_ARGUMENT = 12000002,
        
        /**
         * Invalid key algorithm parameters are detected.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_INVALID_CRYPTO_ALG_ARGUMENT = 12000003,
        
        /**
         * The file operation failed.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_FILE_OPERATION_FAIL = 12000004,
        
        /**
         * The communication failed.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_COMMUNICATION_FAIL = 12000005,
        
        /**
         * Failed to operate the algorithm library.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_CRYPTO_FAIL = 12000006,
        
        /**
         * Failed to access the key because the key has expired.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_KEY_AUTH_PERMANENTLY_INVALIDATED = 12000007,
        
        /**
         * Failed to access the key because the authentication has failed.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_KEY_AUTH_VERIFY_FAILED = 12000008,
        
        /**
         * Key access timed out.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_KEY_AUTH_TIME_OUT = 12000009,
        
        /**
         * The number of key operation sessions has reached the limit.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_SESSION_LIMIT = 12000010,
        
        /**
         * The target object does not exist.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_ITEM_NOT_EXIST = 12000011,
        
        /**
         * An external error occurs.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_EXTERNAL_ERROR = 12000012,
        
        /**
         * The credential does not exist.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_CREDENTIAL_NOT_EXIST = 12000013,
        
        /**
         * The memory is insufficient.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_INSUFFICIENT_MEMORY = 12000014,
        
        /**
         * Failed to call other system services.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ERR_CODE_CALL_SERVICE_FAILED = 12000015,
        
        /**
         * The required lock screen password is not set.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_ERR_CODE_DEVICE_PASSWORD_UNSET = 12000016
    }
    
    /**
     * Enumerates the key purposes.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksKeyPurpose {
        
        /**
         * Used to encrypt the plaintext.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_PURPOSE_ENCRYPT = 1,
        
        /**
         * Used to decrypt the cipher text.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_PURPOSE_DECRYPT = 2,
        
        /**
         * Used for signing.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_PURPOSE_SIGN = 4,
        
        /**
         * Used to verify the signature.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_PURPOSE_VERIFY = 8,
        
        /**
         * Used to derive a key.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_PURPOSE_DERIVE = 16,
        
        /**
         * Used for an encrypted export.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_PURPOSE_WRAP = 32,
        
        /**
         * Used for an encrypted import.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_PURPOSE_UNWRAP = 64,
        
        /**
         * Used to generate a message authentication code (MAC).
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_PURPOSE_MAC = 128,
        
        /**
         * Used for key agreement.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_PURPOSE_AGREE = 256
    }
    
    /**
     * Enumerates the digest algorithms.
     *
     * @enum { int }
     *
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksKeyDigest {
        
        /**
         * No digest algorithm.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DIGEST_NONE = 0,
        
        /**
         * MD5.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DIGEST_MD5 = 1,
        
        /**
         * SM3.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DIGEST_SM3 = 2,
        
        /**
         * SHA-1.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DIGEST_SHA1 = 10,
        
        /**
         * SHA-224.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DIGEST_SHA224 = 11,
        
        /**
         * SHA-256.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DIGEST_SHA256 = 12,
        
        /**
         * SHA-384.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DIGEST_SHA384 = 13,
        
        /**
         * SHA-512.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DIGEST_SHA512 = 14
    }
    
    /**
     * Enumerates the padding algorithms.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksKeyPadding {
        
        /**
         * No padding algorithm is used.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_PADDING_NONE = 0,
        
        /**
         * Optimal Asymmetric Encryption Padding (OAEP).
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_PADDING_OAEP = 1,
        
        /**
         * Probabilistic Signature Scheme (PSS).
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_PADDING_PSS = 2,
        
        /**
         * Public Key Cryptography Standards (PKCS) #1 v1.5.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_PADDING_PKCS1_V1_5 = 3,
        
        /**
         * PKCS #5.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_PADDING_PKCS5 = 4,
        
        /**
         * PKCS #7.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_PADDING_PKCS7 = 5,
        /**
         * ISO_IEC_9796_2.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_PADDING_ISO_IEC_9796_2 = 6,
        /**
         * ISO_IEC_9797_1.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_PADDING_ISO_IEC_9797_1 = 7
    }
    
    /**
     * Enumerates the cipher modes.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksCipherMode {
        
        /**
         * Electronic Code Block (ECB) mode.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_MODE_ECB = 1,
        
        /**
         * Cipher Block Chaining (CBC) mode.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_MODE_CBC = 2,
        
        /**
         * Counter (CTR) mode.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_MODE_CTR = 3,
        
        /**
         * Output Feedback (OFB) mode.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_MODE_OFB = 4,
        /**
         * Ciphertext Feedback (CFB) mode.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_MODE_CFB = 5,
        
        /**
         * Counter with CBC-MAC (CCM) mode.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_MODE_CCM = 31,
        
        /**
         * Galois/Counter (GCM) mode.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_MODE_GCM = 32
    }
    
    /**
     * Enumerates the key sizes.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksKeySize {
        
        /**
         * Rivest-Shamir-Adleman (RSA) key of 512 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_RSA_KEY_SIZE_512 = 512,
        
        /**
         * RSA key of 768 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_RSA_KEY_SIZE_768 = 768,
        
        /**
         * RSA key of 1024 bits.
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_RSA_KEY_SIZE_1024 = 1024,
        
        /**
         * RSA key of 2048 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_RSA_KEY_SIZE_2048 = 2048,
        
        /**
         * RSA key of 3072 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_RSA_KEY_SIZE_3072 = 3072,
        
        /**
         * RSA key of 4096 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_RSA_KEY_SIZE_4096 = 4096,
        
        /**
         * Elliptic Curve Cryptography (ECC) key of 224 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ECC_KEY_SIZE_224 = 224,
        
        /**
         * ECC key of 256 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ECC_KEY_SIZE_256 = 256,
        
        /**
         * ECC key of 384 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ECC_KEY_SIZE_384 = 384,
        
        /**
         * ECC key of 521 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ECC_KEY_SIZE_521 = 521,
        
        /**
         * Advanced Encryption Standard (AES) key of 128 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_AES_KEY_SIZE_128 = 128,
        
        /**
         * AES key of 192 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_AES_KEY_SIZE_192 = 192,
        
        /**
         * AES key of 256 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_AES_KEY_SIZE_256 = 256,
        
        /**
         * Curve25519 key of 256 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_CURVE25519_KEY_SIZE_256 = 256,
        
        /**
         * Diffie-Hellman (DH) key of 2048 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DH_KEY_SIZE_2048 = 2048,
        
        /**
         * DH key of 3072 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DH_KEY_SIZE_3072 = 3072,
        
        /**
         * DH key of 4096 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DH_KEY_SIZE_4096 = 4096,
        
        /**
         * ShangMi2 (SM2) key of 256 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_SM2_KEY_SIZE_256 = 256,
        
        /**
         * ShangMi4 (SM4) key of 128 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_SM4_KEY_SIZE_128 = 128,
        /**
         * DES key of 64 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_DES_KEY_SIZE_64 = 64,
        /**
         * 3DES key of 128 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_3DES_KEY_SIZE_128 = 128,
        /**
         * 3DES key of 192 bits.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_3DES_KEY_SIZE_192 = 192
    }
    
    /**
   * Enumerates the key algorithms.
   *
   * @enum { int }
   * @syscap SystemCapability.Security.Huks.Core
   * @since 20
   */
    export enum HuksKeyAlg {
        
        /**
         * RSA.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_RSA = 1,
        
        /**
         * ECC.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_ECC = 2,
        
        /**
         * DSA.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_DSA = 3,
        
        /**
         * AES.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_AES = 20,
        
        /**
         * HMAC.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_HMAC = 50,
        
        /**
         * HKDF.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_HKDF = 51,
        
        /**
         * PBKDF2.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_PBKDF2 = 52,
        
        /**
         * ECDH.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_ECDH = 100,
        
        /**
         * X25519.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_X25519 = 101,
        
        /**
         * Ed25519.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_ED25519 = 102,
        
        /**
         * DH.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_DH = 103,
        
        /**
         * SM2.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_SM2 = 150,
        
        /**
         * SM3.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_SM3 = 151,
        
        /**
         * SM4.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_SM4 = 152,
        /**
         * DES.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_DES = 160,
        /**
         * 3DES.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_3DES = 161,
        /**
         * CMAC.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_ALG_CMAC = 162
    }
    
    /**
     * Enumerates the algorithm suites that can be used for importing a key in ciphertext.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksUnwrapSuite {
        
        /**
         * Use X25519 for key agreement and then use AES-256 GCM to encrypt the key.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_UNWRAP_SUITE_X25519_AES_256_GCM_NOPADDING = 1,
        
        /**
         * Use ECDH for key agreement and then use AES-256 GCM to encrypt the key.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_UNWRAP_SUITE_ECDH_AES_256_GCM_NOPADDING = 2
    }
    
    /**
     * Enumerates the key generation types.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksKeyGenerateType {
        
        /**
         * Key generated by default.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_GENERATE_TYPE_DEFAULT = 0,
        
        /**
         * Derived key.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_GENERATE_TYPE_DERIVE = 1,
        
        /**
         * Key generated by agreement.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_GENERATE_TYPE_AGREE = 2
    }
    
    /**
     * Enumerates the key generation modes.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksKeyFlag {
        
        /**
         * Import a key using an API.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_FLAG_IMPORT_KEY = 1,
        
        /**
         * Generate a key by using an API.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_FLAG_GENERATE_KEY = 2,
        
        /**
         * Generate a key by using a key agreement API.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_FLAG_AGREE_KEY = 3,
        
        /**
         * Derive a key by using an API.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_FLAG_DERIVE_KEY = 4
    }
    
    /**
     * Enumerates the key storage modes.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksKeyStorageType {
        
        /**
         * The key derived from the master key is stored in the HUKS and managed by the HUKS.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_STORAGE_ONLY_USED_IN_HUKS = 2,
        
        /**
         * The key derived from the master key is exported to the service, and not managed by the HUKS.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_STORAGE_KEY_EXPORT_ALLOWED = 3
    }
    
    /**
     * Enumerates the types of keys to import. By default, a public key is imported. This field is not
     * required when a symmetric key is imported.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksImportKeyType {
        
        /**
         * Public key.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_TYPE_PUBLIC_KEY = 0,
        
        /**
         * Private key.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_TYPE_PRIVATE_KEY = 1,
        
        /**
         * Public and private key pair.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_KEY_TYPE_KEY_PAIR = 2
    }
    
    /**
     * Enumerates the salt_len types to set when PSS padding is used in RSA signing or signature
     * verification.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksRsaPssSaltLenType {
        
        /**
         * salt_len is set to the digest length.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_RSA_PSS_SALT_LEN_DIGEST = 0,
        
        /**
         * salt_len is set to the maximum length.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_RSA_PSS_SALT_LEN_MAX = 1
    }
    
    /**
     * Enumerates the user authentication types.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    export enum HuksUserAuthType {
        
        /**
         * Fingerprint authentication.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_USER_AUTH_TYPE_FINGERPRINT = 1 << 0,
        
        /**
         * Facial authentication.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_USER_AUTH_TYPE_FACE = 1 << 1,
        
        /**
         * PIN authentication.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_USER_AUTH_TYPE_PIN = 1 << 2
    }
    
    /**
     * Enumerates the access control types.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    export enum HuksAuthAccessType {
        
        /**
         * The key becomes invalid after the password is cleared.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_AUTH_ACCESS_INVALID_CLEAR_PASSWORD = 1 << 0,
        
        /**
         * The key becomes invalid after a new biometric feature is added.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_AUTH_ACCESS_INVALID_NEW_BIO_ENROLL = 1 << 1,
        
        /**
         * The key is always valid.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_AUTH_ACCESS_ALWAYS_VALID = 1 << 2
    }
    /**
     * Enumerates the user authentication modes.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    export enum HuksUserAuthMode {
        /**
         * Local authentication.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_USER_AUTH_MODE_LOCAL = 0,
        /**
         * Cross-device collaborative authentication.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_USER_AUTH_MODE_COAUTH = 1
    }
    
    /**
     * Enumerates the storage security levels of a key.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksAuthStorageLevel {
        
        /**
         * The key can be accessed only after the device is started.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_AUTH_STORAGE_LEVEL_DE = 0,
        
        /**
         * The key can be accessed only after the first unlock of the device.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_AUTH_STORAGE_LEVEL_CE = 1,
        
        /**
         * The key can be accessed only when the device is unlocked.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_AUTH_STORAGE_LEVEL_ECE = 2
    }
    
    /**
     * Enumerates the types of the challenges generated when a key is used.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    export enum HuksChallengeType {
        
        /**
         * Normal challenge, which is of 32 bytes by default.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_CHALLENGE_TYPE_NORMAL = 0,
        
        /**
         * Custom challenge, which supports only one authentication for multiple keys.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_CHALLENGE_TYPE_CUSTOM = 1,
        
        /**
         * Challenge is not required.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_CHALLENGE_TYPE_NONE = 2
    }
    
    /**
     * Enumerates the positions of the 8-byte valid value in a custom challenge generated.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    export enum HuksChallengePosition {
        
        /**
         * Bytes 0 to 7.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_CHALLENGE_POS_0 = 0,
        
        /**
         * Bytes 8 to 15.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_CHALLENGE_POS_1,
        
        /**
         * Bytes 16 to 23.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_CHALLENGE_POS_2,
        
        /**
         * Bytes 24 to 31.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_CHALLENGE_POS_3
    }
    
    /**
     * Enumerates the signature types of the key generated or imported.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Extension
     * @since 20
     */
    export enum HuksSecureSignType {
        
        /**
         * The signature carries authentication information. This field is specified when a key is generated or
         * imported. When the key is used for signing, the data will be added with the authentication information and then
         * be signed.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_SECURE_SIGN_WITH_AUTHINFO = 1
    }
    
    /**
     * Enumerates the tag transfer modes.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksSendType {
        
        /**
         * The tag is sent asynchronously.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_SEND_TYPE_ASYNC = 0,
        
        /**
         * The tag is sent synchronously.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_SEND_TYPE_SYNC = 1
    }
    
    /**
     * Enumerates the tag data types.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksTagType {
        
        /**
         * Invalid tag type.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_TYPE_INVALID = 0 << 28,
        
        /**
         * Number of the int type.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_TYPE_INT = 1 << 28,
        
        /**
         * Number of the uint type.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_TYPE_UINT = 2 << 28,
        
        /**
         * BigInt.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_TYPE_ULONG = 3 << 28,
        
        /**
         * Boolean.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_TYPE_BOOL = 4 << 28,
        
        /**
         * Uint8Array.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_TYPE_BYTES = 5 << 28
    }
    
    /**
     * Enumerates the tags used to invoke parameters.
     *
     * @enum { int }
     * @syscap SystemCapability.Security.Huks.Core
     * @since 20
     */
    export enum HuksTag {
        /** Base algorithm TAG: 1 - 200 */
        
        /**
         * Algorithm.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_ALGORITHM = HuksTagType.HUKS_TAG_TYPE_UINT | 1,
        
        /**
         * Purpose of the key.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_PURPOSE = HuksTagType.HUKS_TAG_TYPE_UINT | 2,
        
        /**
         * Key size.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_KEY_SIZE = HuksTagType.HUKS_TAG_TYPE_UINT | 3,
        
        /**
         * Digest algorithm.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_DIGEST = HuksTagType.HUKS_TAG_TYPE_UINT | 4,
        
        /**
         * Padding mode.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_PADDING = HuksTagType.HUKS_TAG_TYPE_UINT | 5,
        
        /**
         * Cipher mode.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_BLOCK_MODE = HuksTagType.HUKS_TAG_TYPE_UINT | 6,
        
        /**
         * Key type.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_KEY_TYPE = HuksTagType.HUKS_TAG_TYPE_UINT | 7,
        
        /**
         * Associated authentication data.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_ASSOCIATED_DATA = HuksTagType.HUKS_TAG_TYPE_BYTES | 8,
        
        /**
         * Nonce for key encryption and decryption.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_NONCE = HuksTagType.HUKS_TAG_TYPE_BYTES | 9,
        
        /**
         * IV.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_IV = HuksTagType.HUKS_TAG_TYPE_BYTES | 10,
        
        /**
         * Information generated during key derivation.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_INFO = HuksTagType.HUKS_TAG_TYPE_BYTES | 11,
        
        /**
         * Salt value used for key derivation.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_SALT = HuksTagType.HUKS_TAG_TYPE_BYTES | 12,
        
        /**
         * Number of iterations for key derivation.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_ITERATION = HuksTagType.HUKS_TAG_TYPE_UINT | 14,
        
        /**
         * Key generation type.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_KEY_GENERATE_TYPE = HuksTagType.HUKS_TAG_TYPE_UINT | 15,
        
        /**
         * Type of the algorithm used for key agreement.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_AGREE_ALG = HuksTagType.HUKS_TAG_TYPE_UINT | 19,
        
        /**
         * Public key alias used in key agreement.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_AGREE_PUBLIC_KEY_IS_KEY_ALIAS = HuksTagType.HUKS_TAG_TYPE_BOOL | 20,
        
        /**
         * Private key alias used in key agreement.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_AGREE_PRIVATE_KEY_ALIAS = HuksTagType.HUKS_TAG_TYPE_BYTES | 21,
        
        /**
         * Public key used in key agreement.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_AGREE_PUBLIC_KEY = HuksTagType.HUKS_TAG_TYPE_BYTES | 22,
        
        /**
         * Key alias.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_KEY_ALIAS = HuksTagType.HUKS_TAG_TYPE_BYTES | 23,
        
        /**
         * Size of the derived key.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_DERIVE_KEY_SIZE = HuksTagType.HUKS_TAG_TYPE_UINT | 24,
        
        /**
         * Type of the imported key.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_IMPORT_KEY_TYPE = HuksTagType.HUKS_TAG_TYPE_UINT | 25,
        
        /**
         * Algorithm suite required for encrypted imports.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_UNWRAP_ALGORITHM_SUITE = HuksTagType.HUKS_TAG_TYPE_UINT | 26,
        
        /**
         * Storage type of the derived key or agreed key.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_DERIVED_AGREED_KEY_STORAGE_FLAG = HuksTagType.HUKS_TAG_TYPE_UINT | 29,
        
        /**
         * Type of the rsa_pss_salt_length.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_RSA_PSS_SALT_LEN_TYPE = HuksTagType.HUKS_TAG_TYPE_UINT | 30,
        /** Other authentication related TAG: 301 - 500 */
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_ALL_USERS = HuksTagType.HUKS_TAG_TYPE_BOOL | 301,
        
        /**
         * ID of the user to which the key belongs.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_USER_ID = HuksTagType.HUKS_TAG_TYPE_UINT | 302,
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_NO_AUTH_REQUIRED = HuksTagType.HUKS_TAG_TYPE_BOOL | 303,
        
        /**
         * User authentication type. For details, see HuksUserAuthType. This parameter must be set together with
         * HuksAuthAccessType. You can set a maximum of two user authentication types at a time. For example, if
         * HuksAuthAccessType is HUKS_SECURE_ACCESS_INVALID_NEW_BIO_ENROLL, you can set the user authentication type to
         * HUKS_USER_AUTH_TYPE_FACE, HUKS_USER_AUTH_TYPE_FINGERPRINT or
         * HUKS_USER_AUTH_TYPE_FACE | HUKS_USER_AUTH_TYPE_FINGERPRINT.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_USER_AUTH_TYPE = HuksTagType.HUKS_TAG_TYPE_UINT | 304,
        
        /**
         * One-time validity period of the authentication token.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_AUTH_TIMEOUT = HuksTagType.HUKS_TAG_TYPE_UINT | 305,
        
        /**
         * Authentication token.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_AUTH_TOKEN = HuksTagType.HUKS_TAG_TYPE_BYTES | 306,
        /** Key secure access control and user auth TAG */
        
        /**
         * Access control type. For details, see HuksAuthAccessType. This parameter must be set together with
         * HuksUserAuthType.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_KEY_AUTH_ACCESS_TYPE = HuksTagType.HUKS_TAG_TYPE_UINT | 307,
        
        /**
         * Signature type of the key generated or imported.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_KEY_SECURE_SIGN_TYPE = HuksTagType.HUKS_TAG_TYPE_UINT | 308,
        
        /**
         * Type of the challenge generated for a key. For details, see HuksChallengeType.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_CHALLENGE_TYPE = HuksTagType.HUKS_TAG_TYPE_UINT | 309,
        
        /**
         * Position of the 8-byte valid value in a custom challenge. For details, see HuksChallengePosition.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_CHALLENGE_POS = HuksTagType.HUKS_TAG_TYPE_UINT | 310,
        
        /**
         * Key authentication purpose.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_KEY_AUTH_PURPOSE = HuksTagType.HUKS_TAG_TYPE_UINT | 311,
        
        /**
         * Key storage security level, which is a value of HuksAuthStorageLevel.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_AUTH_STORAGE_LEVEL = HuksTagType.HUKS_TAG_TYPE_UINT | 316,
        /**
         * User authentication mode, which is a value of HuksUserAuthMode.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_USER_AUTH_MODE = HuksTagType.HUKS_TAG_TYPE_UINT | 319,
        /** Attestation related TAG: 501 - 600 */
        
        /**
         * Challenge value used in the attestation.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_ATTESTATION_CHALLENGE = HuksTagType.HUKS_TAG_TYPE_BYTES | 501,
        
        /**
         * Application ID used in the attestation.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_ATTESTATION_APPLICATION_ID = HuksTagType.HUKS_TAG_TYPE_BYTES | 502,
        
        /**
         * Key alias used in the attestation.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_ATTESTATION_ID_ALIAS = HuksTagType.HUKS_TAG_TYPE_BYTES | 511,
        
        /**
         * Security level used in the attestation.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_ATTESTATION_ID_SEC_LEVEL_INFO = HuksTagType.HUKS_TAG_TYPE_BYTES | 514,
        
        
        
        /**
         * Whether to use the alias passed in during key generation.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_IS_KEY_ALIAS = HuksTagType.HUKS_TAG_TYPE_BOOL | 1001,
        
        /**
         * Key storage mode.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_KEY_STORAGE_FLAG = HuksTagType.HUKS_TAG_TYPE_UINT | 1002,
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_IS_ALLOWED_WRAP = HuksTagType.HUKS_TAG_TYPE_BOOL | 1003,
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_KEY_WRAP_TYPE = HuksTagType.HUKS_TAG_TYPE_UINT | 1004,
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_KEY_AUTH_ID = HuksTagType.HUKS_TAG_TYPE_BYTES | 1005,
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_KEY_ROLE = HuksTagType.HUKS_TAG_TYPE_UINT | 1006,
        
        /**
         * Flag of the key.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_KEY_FLAG = HuksTagType.HUKS_TAG_TYPE_UINT | 1007,
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_IS_ASYNCHRONIZED = HuksTagType.HUKS_TAG_TYPE_UINT | 1008,
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_KEY_DOMAIN = HuksTagType.HUKS_TAG_TYPE_UINT | 1011,
        
        /**
         * Whether the key is accessible only when the user sets a lock screen password.
         *
         * @syscap SystemCapability.Security.Huks.Extension
         * @since 20
         */
        HUKS_TAG_IS_DEVICE_PASSWORD_SET = HuksTagType.HUKS_TAG_TYPE_BOOL | 1012,
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_KEY = HuksTagType.HUKS_TAG_TYPE_BYTES | 10006,
        
        
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_SYMMETRIC_KEY_DATA = HuksTagType.HUKS_TAG_TYPE_BYTES | 20001,
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_ASYMMETRIC_PUBLIC_KEY_DATA = HuksTagType.HUKS_TAG_TYPE_BYTES | 20002,
        
        /**
         * Reserved.
         *
         * @syscap SystemCapability.Security.Huks.Core
         * @since 20
         */
        HUKS_TAG_ASYMMETRIC_PRIVATE_KEY_DATA = HuksTagType.HUKS_TAG_TYPE_BYTES | 20003
    }
}
export default huks;
