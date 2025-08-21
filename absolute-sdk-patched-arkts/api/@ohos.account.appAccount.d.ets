/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
 * @kit BasicServicesKit
 */
import type { AsyncCallback, Callback } from './@ohos.base';
import type Want from './@ohos.app.ability.Want';
import type rpc from './@ohos.rpc';
/**
 * This module provides the capability to manage application accounts.
 *
 * @namespace appAccount
 * @syscap SystemCapability.Account.AppAccount
 * @since 20
 */
declare namespace appAccount {
    /**
     * Obtains the AppAccountManager instance.
     *
     * @returns { AppAccountManager } Returns the instance of the AppAccountManager.
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    function createAppAccountManager(): AppAccountManager;
    /**
     * Provides methods for managing application accounts.
     *
     * @interface AppAccountManager
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    interface AppAccountManager {
        /**
         * Creates the account name and extra information of this application to the account management service.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the name of the application account to add.
         * @param { AsyncCallback<void> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name.
         * @throws { BusinessError } 12300004 - Account already exists.
         * @throws { BusinessError } 12300007 - The number of accounts reaches the upper limit.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        createAccount(name: string, callback: AsyncCallback<void>): void;
        /**
         * Creates the account name and extra information of this application to the account management service.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the name of the application account to add.
         * @param { CreateAccountOptions } options - Indicates the extra information of the application account to add.
         *        The extra information cannot be sensitive information of the application account.
         * @param { AsyncCallback<void> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or options.
         * @throws { BusinessError } 12300004 - Account already exists.
         * @throws { BusinessError } 12300007 - The number of accounts reaches the upper limit.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        createAccount(name: string, options: CreateAccountOptions, callback: AsyncCallback<void>): void;
        /**
         * Creates the account name and extra information of this application to the account management service.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the name of the application account to add.
         * @param { CreateAccountOptions } [options] - Indicates the extra information of the application account to add.
         *        The extra information cannot be sensitive information of the application account.
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or options.
         * @throws { BusinessError } 12300004 - Account already exists.
         * @throws { BusinessError } 12300007 - The number of accounts reaches the upper limit.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        createAccount(name: string, options?: CreateAccountOptions): Promise<void>;
        /**
         * Creates an application account of a specified owner implicitly.
         *
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid owner.
         * @throws { BusinessError } 12300007 - The number of accounts reaches the upper limit.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        createAccountImplicitly(owner: string, callback: AuthCallback): void;
        /**
         * Creates an application account of a specified owner implicitly.
         *
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @param { CreateAccountImplicitlyOptions } options - Indicates the authenticator-specific options for the request.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid owner or options.
         * @throws { BusinessError } 12300007 - The number of accounts reaches the upper limit.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        createAccountImplicitly(owner: string, options: CreateAccountImplicitlyOptions, callback: AuthCallback): void;
        /**
         * Removes an application account from the account management service.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the name of the application account to delete.
         * @param { AsyncCallback<void> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        removeAccount(name: string, callback: AsyncCallback<void>): void;
        /**
         * Removes an application account from the account management service.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the name of the application account to delete.
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        removeAccount(name: string): Promise<void>;
        
        /**
         * Sets a third-party application with the specified bundle name to access the given application
         * account for data query and listening.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } bundleName - Indicates the bundle name of the third-party application.
         * @param { boolean } isAccessible - Indicates the accessibility flag, true for accessible, false for inaccessible.
         * @param { AsyncCallback<void> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or bundleName.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12400005 - The size of authorization list reaches the upper limit.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setAppAccess(name: string, bundleName: string, isAccessible: boolean, callback: AsyncCallback<void>): void;
        
        /**
         * Sets a third-party application with the specified bundle name to access the given application
         * account for data query and listening.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } bundleName - Indicates the bundle name of the third-party application.
         * @param { boolean } isAccessible - Indicates the accessibility flag, true for accessible, false for inaccessible.
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or bundleName.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12400005 - The size of authorization list reaches the upper limit.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setAppAccess(name: string, bundleName: string, isAccessible: boolean): Promise<void>;
        /**
         * Checks whether a third-party application with the specified bundle name is allowed to access
         * the given application account for data query and listening.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } bundleName - Indicates the bundle name of the third-party application.
         * @param { AsyncCallback<boolean> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or bundleName.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        checkAppAccess(name: string, bundleName: string, callback: AsyncCallback<boolean>): void;
        /**
         * Checks whether a third-party application with the specified bundle name is allowed to access
         * the given application account for data query and listening.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } bundleName - Indicates the bundle name of the third-party application.
         * @returns { Promise<boolean> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or bundleName.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        checkAppAccess(name: string, bundleName: string): Promise<boolean>;
        /**
         * Checks whether application data synchronization is enabled for the specified account.
         * <p>
         * If the same OHOS account has logged in to multiple devices, these devices constitute a super device
         * through the distributed networking. On the connected devices, you can call this method to check
         * whether application data can be synchronized.
         * <p>
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { string } name - Indicates the name of the application account.
         * @param { AsyncCallback<boolean> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        checkDataSyncEnabled(name: string, callback: AsyncCallback<boolean>): void;
        /**
         * Checks whether application data synchronization is enabled for the specified account.
         * <p>
         * If the same OHOS account has logged in to multiple devices, these devices constitute a super device
         * through the distributed networking. On the connected devices, you can call this method to check
         * whether application data can be synchronized.
         * <p>
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { string } name - Indicates the name of the application account.
         * @returns { Promise<boolean> } Returns {@code true} if application data synchronization is allowed; returns {@code false} otherwise.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        checkDataSyncEnabled(name: string): Promise<boolean>;
        /**
         * Sets the credential for this application account.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } credentialType - Indicates the type of the credential to set.
         * @param { string } credential - Indicates the credential to set.
         * @param { AsyncCallback<void> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, credentialType or credential.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setCredential(name: string, credentialType: string, credential: string, callback: AsyncCallback<void>): void;
        /**
         * Sets the credential for this application account.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } credentialType - Indicates the type of the credential to set.
         * @param { string } credential - Indicates the credential to set.
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, credentialType or credential.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setCredential(name: string, credentialType: string, credential: string): Promise<void>;
        /**
         * Sets whether a specified application account enables application data synchronization.
         * <p>
         * If the same OHOS account has logged in to multiple devices, these devices constitute a super device
         * through the distributed networking. On the connected devices, you can call this method to set whether to
         * enable cross-device data synchronization. If synchronization is enabled, application data can be synchronized
         * among these devices in the event of any changes related to the application account.
         * If synchronization is not enabled, the application data is stored only on the local device.
         * <p>
         * <b>Application account-related changes</b>: adding or deleting an application account, setting extra
         * information (such as updating a token), and setting data associated with this application account
         * <p>
         * <b>Application data that can be synchronized</b>: application account name, token,
         * and data associated with this application account
         * <p>
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { string } name - Indicates the name of the application account.
         * @param { boolean } isEnabled - Specifies whether to enable application data synchronization.
         * @param { AsyncCallback<void> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setDataSyncEnabled(name: string, isEnabled: boolean, callback: AsyncCallback<void>): void;
        /**
         * Sets whether a specified application account enables application data synchronization.
         * <p>
         * If the same OHOS account has logged in to multiple devices, these devices constitute a super device
         * through the distributed networking. On the connected devices, you can call this method to set whether to
         * enable cross-device data synchronization. If synchronization is enabled, application data can be synchronized
         * among these devices in the event of any changes related to the application account.
         * If synchronization is not enabled, the application data is stored only on the local device.
         * <p>
         * <b>Application account-related changes</b>: adding or deleting an application account, setting extra
         * information (such as updating a token), and setting data associated with this application account
         * <p>
         * <b>Application data that can be synchronized</b>: application account name, token,
         * and data associated with this application account
         * <p>
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { string } name - Indicates the name of the application account.
         * @param { boolean } isEnabled - Specifies whether to enable application data synchronization.
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setDataSyncEnabled(name: string, isEnabled: boolean): Promise<void>;
        /**
         * Sets data associated with this application account.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } key - Indicates the key of the data to set. The key can be customized.
         * @param { string } value - Indicates the value of the data to set.
         * @param { AsyncCallback<void> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, key or value.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12400003 - The number of custom data reaches the upper limit.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setCustomData(name: string, key: string, value: string, callback: AsyncCallback<void>): void;
        /**
         * Sets data associated with this application account.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } key - Indicates the key of the data to set. The key can be customized.
         * @param { string } value - Indicates the value of the data to set.
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, key or value.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12400003 - The number of custom data reaches the upper limit.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setCustomData(name: string, key: string, value: string): Promise<void>;
        /**
         * Obtains information about all accessible accounts.
         * This method applies to the following accounts:
         * <br> Accounts of this application.
         * <br> Accounts of third-party applications. To obtain such information,
         * <br> your application must have gained authorization from the third-party applications or
         * <br> have gained the ohos.permission.GET_ALL_APP_ACCOUNTS permission.
         *
         * @param { AsyncCallback<Array<AppAccountInfo>> } callback - Asynchronous callback interface. Returns a list of application accounts.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAllAccounts(callback: AsyncCallback<Array<AppAccountInfo>>): void;
        /**
         * Obtains information about all accessible accounts.
         * This method applies to the following accounts:
         * <br> Accounts of this application.
         * <br> Accounts of third-party applications. To obtain such information,
         * <br> your application must have gained authorization from the third-party applications or
         * <br> have gained the ohos.permission.GET_ALL_APP_ACCOUNTS permission.
         *
         * @returns { Promise<Array<AppAccountInfo>> } Returns a list of application accounts.
         * @throws { BusinessError } 12300001 - System service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAllAccounts(): Promise<Array<AppAccountInfo>>;
        
        /**
         * Gets information about all accounts of a specified account owner.
         * This method applies to the following accounts:
         * <br> Accounts of this application.
         * <br> Accounts of third-party applications. To obtain such information,
         * <br> your application must have gained authorization from the third-party applications or
         * <br> have gained the ohos.permission.GET_ALL_APP_ACCOUNTS permission.
         *
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @param { AsyncCallback<Array<AppAccountInfo>> } callback - Asynchronous callback interface. Returns a list of application accounts.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid owner.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAccountsByOwner(owner: string, callback: AsyncCallback<Array<AppAccountInfo>>): void;
        
        /**
         * Gets information about all accounts of a specified account owner.
         * This method applies to the following accounts:
         * <br> Accounts of this application.
         * <br> Accounts of third-party applications. To obtain such information,
         * <br> your application must have gained authorization from the third-party applications or
         * <br> have gained the ohos.permission.GET_ALL_APP_ACCOUNTS permission.
         *
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @returns { Promise<Array<AppAccountInfo>> } Returns a list of application accounts.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid owner.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAccountsByOwner(owner: string): Promise<Array<AppAccountInfo>>;
        /**
         * Obtains the credential of this application account.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } credentialType - Indicates the type of the credential to obtain.
         * @param { AsyncCallback<string> } callback - Asynchronous callback interface. Returns the credential of the application account.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or credentialType.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300102 - Credential not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getCredential(name: string, credentialType: string, callback: AsyncCallback<string>): void;
        /**
         * Obtains the credential of this application account.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } credentialType - Indicates the type of the credential to obtain.
         * @returns { Promise<string> } Returns the credential of the application account.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or credentialType.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300102 - Credential not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getCredential(name: string, credentialType: string): Promise<string>;
        /**
         * Obtains data associated with this application account.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } key - Indicates the key of the data to obtain.
         * @param { AsyncCallback<string> } callback - Asynchronous callback interface. Returns the associated data of the application account.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or key.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12400002 - Custom data not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getCustomData(name: string, key: string, callback: AsyncCallback<string>): void;
        /**
         * Obtains data associated with this application account.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } key - Indicates the key of the data to obtain.
         * @returns { Promise<string> } Returns the associated data of the application account.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or key.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12400002 - Custom data not found
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getCustomData(name: string, key: string): Promise<string>;
        /**
         * Obtains data associated with the specified account synchronously.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { string } key - Indicates the key of the data to obtain.
         * @returns { string } Returns the associated data of the application account.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or key.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12400002 - Custom data not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getCustomDataSync(name: string, key: string): string;
        
        /**
         * Subscribes to the change events of accounts of the specified owners.
         * <p>
         * When the account owner updates the account, the subscriber will receive a notification
         * about the account change event.
         *
         * @param { 'accountChange' } type - Event type.
         * @param { Array<string> } owners - Indicates the account owners, which are specified
         *        by {@link AppAccount#AppAccount(String name, String owner)}.
         * @param { Callback<Array<AppAccountInfo>> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid type or owners.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        on(type: 'accountChange', owners: Array<string>, callback: Callback<Array<AppAccountInfo>>): void;
        /**
         * Unsubscribes from account events.
         *
         * @param { 'accountChange' } type - Event type.
         * @param { Callback<Array<AppAccountInfo>> } [callback] - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid type.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        off(type: 'accountChange', callback?: Callback<Array<AppAccountInfo>>): void;
        /**
         * Authenticates an application account to get an auth token.
         *
         * @param { string } name - Indicates the account name of your application or third-party applications.
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @param { string } authType - Indicates the authentication type.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, owner or authType.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        auth(name: string, owner: string, authType: string, callback: AuthCallback): void;
        /**
         * Authenticates an application account to get an auth token.
         *
         * @param { string } name - Indicates the account name of your application or third-party applications.
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @param { string } authType - Indicates the authentication type.
         * @param { Record<string, Object> } options - Indicates the authenticator-specific options for the request.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, owner, authType or options.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        auth(name: string, owner: string, authType: string, options: Record<string, Object>, callback: AuthCallback): void;
        /**
         * Gets an auth token with the specified authentication type from a particular application account.
         *
         * @param { string } name - Indicates the account name of your application or third-party applications.
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @param { string } authType - Indicates the authentication type.
         * @param { AsyncCallback<string> } callback - Asynchronous callback interface. Returns an auth token.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, owner or authType.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300107 - AuthType not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAuthToken(name: string, owner: string, authType: string, callback: AsyncCallback<string>): void;
        /**
         * Gets an auth token with the specified authentication type from a particular application account.
         *
         * @param { string } name - Indicates the account name of your application or third-party applications.
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @param { string } authType - Indicates the authentication type.
         * @returns { Promise<string> } Returns an auth token.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, owner or authType.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300107 - AuthType not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAuthToken(name: string, owner: string, authType: string): Promise<string>;
        /**
         * Sets an auth token with the specified authentication type for a particular account.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the account name of your application.
         * @param { string } authType - Indicates the authentication type.
         * @param { string } token - Indicates the auth token.
         * @param { AsyncCallback<void> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, authType or token.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12400004 - The number of tokens reaches the upper limit.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setAuthToken(name: string, authType: string, token: string, callback: AsyncCallback<void>): void;
        /**
         * Sets an auth token with the specified authentication type for a particular account.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the account name of your application.
         * @param { string } authType - Indicates the authentication type.
         * @param { string } token - Indicates the auth token.
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, authType or token.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12400004 - The number of tokens reaches the upper limit.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setAuthToken(name: string, authType: string, token: string): Promise<void>;
        /**
         * Deletes an auth token for the specified application account.
         * <p>
         * Only tokens visible to the caller application can be deleted.
         *
         * @param { string } name - Indicates the account name of your application or third-party applications.
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @param { string } authType - Indicates the authentication type.
         * @param { string } token - Indicates the auth token.
         * @param { AsyncCallback<void> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, owner, authType or token.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300107 - AuthType not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        deleteAuthToken(name: string, owner: string, authType: string, token: string, callback: AsyncCallback<void>): void;
        /**
         * Deletes an auth token for the specified application account.
         * <p>
         * Only tokens visible to the caller application can be deleted.
         *
         * @param { string } name - Indicates the account name of your application or third-party applications.
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @param { string } authType - Indicates the authentication type.
         * @param { string } token - Indicates the auth token.
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, owner, authType or token.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300107 - AuthType not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        deleteAuthToken(name: string, owner: string, authType: string, token: string): Promise<void>;
        
        /**
         * Sets the auth token visibility of the specified authentication type to a third-party application.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the account name of your application.
         * @param { string } authType - Indicates the authentication type.
         * @param { string } bundleName - Indicates the bundle name of the third-party application.
         * @param { boolean } isVisible - Indicates the bool value of visibility.
         * @param { AsyncCallback<void> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, authType or bundleName.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300107 - AuthType not found.
         * @throws { BusinessError } 12400005 - The size of authorization list reaches the upper limit.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setAuthTokenVisibility(name: string, authType: string, bundleName: string, isVisible: boolean, callback: AsyncCallback<void>): void;
        
        /**
         * Sets the auth token visibility of the specified authentication type to a third-party application.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the account name of your application.
         * @param { string } authType - Indicates the authentication type.
         * @param { string } bundleName - Indicates the bundle name of the third-party application.
         * @param { boolean } isVisible - Indicates the bool value of visibility.
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, authType or bundleName.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300107 - AuthType not found.
         * @throws { BusinessError } 12400005 - The size of authorization list reaches the upper limit.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setAuthTokenVisibility(name: string, authType: string, bundleName: string, isVisible: boolean): Promise<void>;
        /**
         * Checks the auth token visibility of the specified authentication type for a third-party application.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the account name of your application or third-party applications.
         * @param { string } authType - Indicates the authentication type.
         * @param { string } bundleName - Indicates the bundle name of the third-party application.
         * @param { AsyncCallback<boolean> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, authType or bundleName.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300107 - AuthType not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        checkAuthTokenVisibility(name: string, authType: string, bundleName: string, callback: AsyncCallback<boolean>): void;
        /**
         * Checks the auth token visibility of the specified authentication type for a third-party application.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the account name of your application or third-party applications.
         * @param { string } authType - Indicates the authentication type.
         * @param { string } bundleName - Indicates the bundle name of the third-party application.
         * @returns { Promise<boolean> } Returns the bool value of visibility.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, authType or bundleName.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300107 - AuthType not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        checkAuthTokenVisibility(name: string, authType: string, bundleName: string): Promise<boolean>;
        /**
         * Gets all auth tokens visible to the caller application.
         *
         * @param { string } name - Indicates the account name of your application or third-party applications.
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @param { AsyncCallback<Array<AuthTokenInfo>> } callback - Asynchronous callback interface.
         *   Returns a list of auth tokens visible to the caller application.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or owner.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAllAuthTokens(name: string, owner: string, callback: AsyncCallback<Array<AuthTokenInfo>>): void;
        /**
         * Gets all auth tokens visible to the caller application.
         *
         * @param { string } name - Indicates the account name of your application or third-party applications.
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @returns { Promise<Array<AuthTokenInfo>> } Returns a list of auth tokens visible to the caller application.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or owner.
         * @throws { BusinessError } 12300003 - Account not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAllAuthTokens(name: string, owner: string): Promise<Array<AuthTokenInfo>>;
        /**
         * Gets the open authorization list with a specified authentication type for a particular application account.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the account name of your application.
         * @param { string } authType - Indicates the authentication type.
         * @param { AsyncCallback<Array<string>> } callback - Asynchronous callback interface.
         *   Returns the open authorization list of the specified authentication type.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or authType.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300107 - AuthType not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAuthList(name: string, authType: string, callback: AsyncCallback<Array<string>>): void;
        /**
         * Gets the open authorization list with a specified authentication type for a particular application account.
         * <p>
         * Only the owner of the application account has the permission to call this method.
         *
         * @param { string } name - Indicates the account name of your application.
         * @param { string } authType - Indicates the authentication type.
         * @returns { Promise<Array<string>> } Returns the open authorization list of the specified authentication type.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or authType.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300107 - AuthType not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAuthList(name: string, authType: string): Promise<Array<string>>;
        /**
         * Obtains the authenticator callback with the specified session id.
         * <p>
         * Only the owner of the authenticator has the permission to call this method.
         *
         * @param { string } sessionId - Indicates the id of a authentication session.
         * @param { AsyncCallback<AuthCallback> } callback - Asynchronous callback interface.
         *   Returns the authenticator callback related to the session id.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid sessionId.
         * @throws { BusinessError } 12300108 - Session not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAuthCallback(sessionId: string, callback: AsyncCallback<AuthCallback>): void;
        /**
         * Obtains the authenticator callback with the specified session id.
         * <p>
         * Only the owner of the authenticator has the permission to call this method.
         *
         * @param { string } sessionId - Indicates the id of a authentication session.
         * @returns { Promise<AuthCallback> } Returns the authenticator callback related to the session id.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid sessionId.
         * @throws { BusinessError } 12300108 - Session not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getAuthCallback(sessionId: string): Promise<AuthCallback>;
        /**
         * Queries the authenticator information of an application account.
         *
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @param { AsyncCallback<AuthenticatorInfo> } callback - Asynchronous callback interface.
         *   Returns the authenticator information of the application account.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid owner.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        queryAuthenticatorInfo(owner: string, callback: AsyncCallback<AuthenticatorInfo>): void;
        /**
         * Queries the authenticator information of an application account.
         *
         * @param { string } owner - Indicates the account owner of your application or third-party applications.
         * @returns { Promise<AuthenticatorInfo> } Returns the authenticator information of the application account.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid owner.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        queryAuthenticatorInfo(owner: string): Promise<AuthenticatorInfo>;
        /**
         * Checks whether a particular account has all specified labels.
         *
         * @param { string } name - Indicates the account name.
         * @param { string } owner - Indicates the account owner.
         * @param { Array<string> } labels - Indicates an array of labels to check.
         * @param { AsyncCallback<boolean> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, owner or labels.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        checkAccountLabels(name: string, owner: string, labels: Array<string>, callback: AsyncCallback<boolean>): void;
        /**
         * Checks whether a particular account has all specified labels.
         *
         * @param { string } name - Indicates the account name.
         * @param { string } owner - Indicates the account owner.
         * @param { Array<string> } labels - Indicates an array of labels to check.
         * @returns { Promise<boolean> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, owner or labels.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        checkAccountLabels(name: string, owner: string, labels: Array<string>): Promise<boolean>;
        /**
         * Deletes the credential of the specified application account.
         *
         * @param { string } name - Indicates the account name.
         * @param { string } credentialType - Indicates the type of the credential to delete.
         * @param { AsyncCallback<void> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or credentialType.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300102 - Credential not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        deleteCredential(name: string, credentialType: string, callback: AsyncCallback<void>): void;
        /**
         * Deletes the credential of the specified application account.
         *
         * @param { string } name - Indicates the account name.
         * @param { string } credentialType - Indicates the type of the credential to delete.
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or credentialType.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300102 - Credential not found.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        deleteCredential(name: string, credentialType: string): Promise<void>;
        /**
         * Selects a list of accounts that satisfied with the specified options.
         *
         * @param { SelectAccountsOptions } options - Indicates the options for selecting account.
         * @param { AsyncCallback<Array<AppAccountInfo>> } callback - Asynchronous callback interface.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid options.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        selectAccountsByOptions(options: SelectAccountsOptions, callback: AsyncCallback<Array<AppAccountInfo>>): void;
        /**
         * Selects a list of accounts that satisfied with the specified options.
         *
         * @param { SelectAccountsOptions } options - Indicates the options for selecting account.
         * @returns { Promise<Array<AppAccountInfo>> } Returns a list of accounts.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid options.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        selectAccountsByOptions(options: SelectAccountsOptions): Promise<Array<AppAccountInfo>>;
        /**
         * Verifies the credential to ensure the user is the owner of the specified account.
         *
         * @param { string } name - Indicates the account name.
         * @param { string } owner - Indicates the account owner.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name or owner.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        verifyCredential(name: string, owner: string, callback: AuthCallback): void;
        /**
         * Verifies the credential to ensure the user is the owner of the specified account.
         *
         * @param { string } name - Indicates the account name.
         * @param { string } owner - Indicates the account owner.
         * @param { VerifyCredentialOptions } options - Indicates the options for verifying credential.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid name, owner or options.
         * @throws { BusinessError } 12300003 - Account not found.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        verifyCredential(name: string, owner: string, options: VerifyCredentialOptions, callback: AuthCallback): void;
        /**
         * Sets properties for the specified account authenticator.
         * <p>
         * If the authenticator supports setting its properties,
         * the caller will normally be redirected to an Ability specified by Want for property setting.
         *
         * @param { string } owner - Indicates the owner of authenticator.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid owner.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setAuthenticatorProperties(owner: string, callback: AuthCallback): void;
        /**
         * Sets properties for the specified account authenticator.
         * <p>
         * If the authenticator supports setting its properties,
         * the caller will normally be redirected to an Ability specified by Want for property setting.
         *
         * @param { string } owner - Indicates the owner of authenticator.
         * @param { SetPropertiesOptions } options - Indicates the options for setting properties.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameter types.
         * @throws { BusinessError } 12300001 - System service exception.
         * @throws { BusinessError } 12300002 - Invalid owner or options.
         * @throws { BusinessError } 12300010 - Account service busy.
         * @throws { BusinessError } 12300113 - Authenticator service not found.
         * @throws { BusinessError } 12300114 - Authenticator service exception.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setAuthenticatorProperties(owner: string, options: SetPropertiesOptions, callback: AuthCallback): void;
    }
    /**
     * Provides basic information of an application account, including the account owner and name.
     *
     * @interface AppAccountInfo
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    interface AppAccountInfo {
        /**
         * The owner an application account.
         *
         * @type { string }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        owner: string;
        /**
         * The name an application account.
         *
         * @type { string }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        name: string;
    }
    /**
     * Provides basic information of an auth token, including the authentication type and token value.
     *
     * @interface AuthTokenInfo
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    interface AuthTokenInfo {
        /**
         * The authentication type.
         *
         * @type { string }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        authType: string;
        /**
         * The token value.
         *
         * @type { string }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        token: string;
        /**
         * The account to which the token belongs.
         *
         * @type { ?AppAccountInfo }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        account?: AppAccountInfo;
    }
    /**
     * Provides basic information of an authenticator, including the authenticator owner, icon id and label id.
     *
     * @interface AuthenticatorInfo
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    interface AuthenticatorInfo {
        /**
         * The owner of an authenticator.
         *
         * @type { string }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        owner: string;
        /**
         * The icon id of an authenticator.
         *
         * @type { long }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        iconId: long;
        /**
         * The label id of an authenticator.
         *
         * @type { long }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        labelId: long;
    }
    /**
     * Provides the definition of the authentication result.
     *
     * @interface AuthResult
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    interface AuthResult {
        /**
         * The account information.
         *
         * @type { ?AppAccountInfo }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        account?: AppAccountInfo;
        /**
         * The token information.
         *
         * @type { ?AuthTokenInfo }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        tokenInfo?: AuthTokenInfo;
    }
    /**
     * Provides the available options for creating an account.
     *
     * @interface CreateAccountOptions
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    interface CreateAccountOptions {
        /**
         * The custom data for creating an account,
         * which can be further modified by function setCustomData.
         *
         * @type { ?Record<string, string> }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        customData?: Record<string, string>;
    }
    /**
     * Provides the available options for creating an account implicitly.
     *
     * @interface CreateAccountImplicitlyOptions
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    interface CreateAccountImplicitlyOptions {
        /**
         * The required labels for creating an account.
         *
         * @type { ?Array<string> }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        requiredLabels?: Array<string>;
        /**
         * The authentication type.
         *
         * @type { ?string }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        authType?: string;
        /**
         * The authenticator-specific parameters.
         * The list of reserved parameter name:
         * 1. Constants.KEY_CALLER_BUNDLE_NAME;
         * The above parameters are set by the appAccount management service and can be used for identify the caller.
         *
         * @type { ?Record<string, Object> }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        parameters?: Record<string, Object>;
    }
    /**
     * Provides the available options for selecting accounts.
     *
     * @interface SelectAccountsOptions
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    interface SelectAccountsOptions {
        /**
         * The list of accounts allowed to be selected.
         *
         * @type { ?Array<AppAccountInfo> }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        allowedAccounts?: Array<AppAccountInfo>;
        /**
         * The list of account owners, whose accounts allowed to be selected.
         *
         * @type { ?Array<string> }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        allowedOwners?: Array<string>;
        /**
         * The labels required for the selected accounts.
         *
         * @type { ?Array<string> }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        requiredLabels?: Array<string>;
    }
    /**
     * Provides the available options for verifying credential.
     *
     * @interface VerifyCredentialOptions
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    interface VerifyCredentialOptions {
        /**
         * The credential type to be verified.
         *
         * @type { ?string }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        credentialType?: string;
        /**
         * The credential to be verified.
         *
         * @type { ?string }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        credential?: string;
        /**
         * The authenticator-specific parameters.
         * The list of reserved parameter name:
         * 1. Constants.KEY_CALLER_BUNDLE_NAME;
         * The above parameters are set by the appAccount management service and can be used for identify the caller.
         *
         * @type { ?Record<string, Object> }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        parameters?: Record<string, Object>;
    }
    /**
     * Provides the available options for setting properties.
     *
     * @interface SetPropertiesOptions
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    interface SetPropertiesOptions {
        /**
         * The properties to be set.
         *
         * @type { ?Record<string, Object> }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        properties?: Record<string, Object>;
        /**
         * The authenticator-specific parameters.
         * The list of reserved parameter name:
         * 1. Constants.KEY_CALLER_BUNDLE_NAME;
         * The above parameters are set by the appAccount management service and can be used for identify the caller.
         *
         * @type { ?Record<string, Object> }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        parameters?: Record<string, Object>;
    }
    /**
     * Provides constants definition.
     *
     * @enum { string } Constants
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    enum Constants {
        /**
         * Indicates the action for creating account implicitly.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        ACTION_CREATE_ACCOUNT_IMPLICITLY = 'createAccountImplicitly',
        /**
         * Indicates the action for authenticating.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        ACTION_AUTH = 'auth',
        /**
         * Indicates the action for verifying credential.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        ACTION_VERIFY_CREDENTIAL = 'verifyCredential',
        /**
         * Indicates the action for set authenticator properties.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        ACTION_SET_AUTHENTICATOR_PROPERTIES = 'setAuthenticatorProperties',
        /**
         * Indicates the key of name.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        KEY_NAME = 'name',
        /**
         * Indicates the key of owner.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        KEY_OWNER = 'owner',
        /**
         * Indicates the key of token.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        KEY_TOKEN = 'token',
        /**
         * Indicates the key of action.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        KEY_ACTION = 'action',
        /**
         * Indicates the key of authentication type.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        KEY_AUTH_TYPE = 'authType',
        /**
         * Indicates the key of session id.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        KEY_SESSION_ID = 'sessionId',
        /**
         * Indicates the key of caller pid.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        KEY_CALLER_PID = 'callerPid',
        /**
         * Indicates the key of caller uid.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        KEY_CALLER_UID = 'callerUid',
        /**
         * Indicates the key of caller bundle name.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        KEY_CALLER_BUNDLE_NAME = 'callerBundleName',
        /**
         * Indicates the key of required labels.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        KEY_REQUIRED_LABELS = 'requiredLabels',
        /**
         * Indicates the key of boolean result.
         *
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        KEY_BOOLEAN_RESULT = 'booleanResult'
    }
    /**
     * Provides methods for authentication callback.
     *
     * @interface AuthCallback
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     */
    interface AuthCallback {
        /**
         * Notifies the client of the authentication result.
         *
         * @type { function }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        onResult: (code: int, result?: AuthResult) => void;
        /**
         * Notifies the client that the authentication request need to be redirected.
         *
         * @type { function }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        onRequestRedirected: (request: Want) => void;
        /**
         * Notifies the client that the request is continued.
         *
         * @type { ?function }
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        onRequestContinued?: () => void;
    }
    /**
     * Provides methods for authenticator.
     *
     * @syscap SystemCapability.Account.AppAccount
     * @since 20
     * @name Authenticator
     */
    class Authenticator {
        /**
         * Creates an application account of a specified owner implicitly.
         *
         * @param { CreateAccountImplicitlyOptions } options - Indicates the authenticator-specific options for the request.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        createAccountImplicitly(options: CreateAccountImplicitlyOptions, callback: AuthCallback): void;
        /**
         * Authenticates an application account to get an oauth token.
         *
         * @param { string } name - Indicates the account name.
         * @param { string } authType - Indicates the authentication type.
         * @param { Record<string, Object> } options - Indicates the authenticator-specific options for the request.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        auth(name: string, authType: string, options: Record<string, Object>, callback: AuthCallback): void;
        /**
         * Verifies the credential to ensure the user is the owner of the specified application account.
         * <p>
         * The credential can be provided in the options, otherwise an Ability will normally be returned,
         * which can be started by the caller to further verify credential.
         *
         * @param { string } name - Indicates the name of the application account.
         * @param { VerifyCredentialOptions } options - Indicates the options for verifying credential.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        verifyCredential(name: string, options: VerifyCredentialOptions, callback: AuthCallback): void;
        /**
         * Sets properties for the authenticator.
         *
         * @param { SetPropertiesOptions } options - Indicates the options for setting properties.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        setProperties(options: SetPropertiesOptions, callback: AuthCallback): void;
        /**
         * Checks whether a particular account has all specified labels.
         *
         * @param { string } name - Indicates the account name.
         * @param { Array<string> } labels - Indicates an array of labels to check.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        checkAccountLabels(name: string, labels: Array<string>, callback: AuthCallback): void;
        /**
         * Checks whether the specified account can be removed.
         *
         * @param { string } name - Indicates the account name.
         * @param { AuthCallback } callback - Indicates the authenticator callback.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        checkAccountRemovable(name: string, callback: AuthCallback): void;
        /**
         * Gets the remote object of the authenticator for remote procedure call.
         *
         * @returns { rpc.RemoteObject } Returns a remote object.
         * @syscap SystemCapability.Account.AppAccount
         * @since 20
         */
        getRemoteObject(): rpc.RemoteObject;
    }
}
export default appAccount;
