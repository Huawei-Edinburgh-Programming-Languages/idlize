/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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
 * @kit ArkData
 */
import { AsyncCallback, Callback } from './@ohos.base';
import { ValuesBucket } from './@ohos.data.ValuesBucket';
import dataSharePredicates from './@ohos.data.dataSharePredicates';
import BaseContext from './application/BaseContext';
/**
 * Provider interfaces to create a {@link KVManager} instance.
 *
 * @namespace distributedKVStore
 * @syscap SystemCapability.DistributedDataManager.KVStore.DistributedKVStore
 * @since 20
 */
declare namespace distributedKVStore {
    /**
     * Provides configuration information to create a {@link KVManager} instance,
     * which includes the caller's package name and ability or hap context.
     *
     * @interface KVManagerConfig
     * @syscap SystemCapability.DistributedDataManager.KVStore.Core
     * @since 20
     */
    interface KVManagerConfig {
        /**
         * Indicates the bundleName
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        bundleName: string;
        
        /**
         * Indicates the ability or hap context
         *
         * @type { BaseContext }
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * if swap the area, you should close all the KV store and use the new BaseContext to create the KVManager
         * @since 20
         */
        context: BaseContext;
    }
    /**
     * Describes the KVStore type.
     *
     * @enum { number }
     * @syscap SystemCapability.DistributedDataManager.KVStore.Core
     * @since 20
     */
    enum KVStoreType {
        /**
         * Device-collaboration database, as specified by {@code DeviceKVStore}
         *
         * @syscap SystemCapability.DistributedDataManager.KVStore.DistributedKVStore
         * @since 20
         */
        DEVICE_COLLABORATION,
        /**
         * Single-version database, as specified by {@code SingleKVStore}
         *
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        SINGLE_VERSION
    }
    /**
     * Describes the KVStore security level.
     *
     * @enum { number }
     * @syscap SystemCapability.DistributedDataManager.KVStore.Core
     * @since 20
     */
    enum SecurityLevel {
        /**
         * S1: means the db is in the low security level
         * There are some low impact when the data is leaked.
         *
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        S1,
        /**
         * S2: means the db is in the middle security level
         * There are some major impact when the data is leaked.
         *
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        S2,
        /**
         * S3: means the db is in the high security level
         * There are some severity impact when the data is leaked.
         *
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        S3,
        /**
         * S4: means the db is in the critical security level
         * There are some critical impact when the data is leaked.
         *
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        S4
    }
    /**
     * Provides configuration options to create a {@code SingleKVStore} or {@code DeviceKVStore}.
     *
     * @interface Options
     * @syscap SystemCapability.DistributedDataManager.KVStore.Core
     * @since 20
     */
    interface Options {
        /**
         * Indicates whether to create a database when the database file does not exist
         *
         * @type { ?boolean }
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        createIfMissing?: boolean;
        /**
         * Indicates whether database files to be encrypted
         *
         * @type { ?boolean }
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        encrypt?: boolean;
        /**
         * Indicates whether to back up database files
         *
         * @type { ?boolean }
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        backup?: boolean;
        /**
         * Indicates whether database files are automatically synchronized
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @type { ?boolean }
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        autoSync?: boolean;
        /**
         * Indicates the database type
         *
         * @type { ?KVStoreType }
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        kvStoreType?: KVStoreType;
        /**
         * Indicates the database security level
         *
         * @type { SecurityLevel }
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        securityLevel: SecurityLevel;
        /**
         * Indicates the database schema
         *
         * @type { ?Schema }
         * @syscap SystemCapability.DistributedDataManager.KVStore.DistributedKVStore
         * @since 20
         */
        schema?: Schema;
    }
    /**
     * Represents the database schema.
     * You can set the schema object in options when create or open the database.
     *
     * @syscap SystemCapability.DistributedDataManager.KVStore.DistributedKVStore
     * @since 20
     */
    class Schema {
        /**
         * A constructor used to create a Schema instance.
         *
         * @syscap SystemCapability.DistributedDataManager.KVStore.DistributedKVStore
         * @since 20
         */
        constructor();
    }
    /**
     * Provides methods related to single-version distributed databases.
     * <p>To create a {@code SingleKVStore} database,
     * you can use the {@link data.distributed.common.KVManager#getKVStore​(Options, String)} method
     * with {@code KVStoreType} set to {@code SINGLE_VERSION} for the input parameter {@code Options}.
     * This database synchronizes data to other databases in time sequence.
     * The {@code SingleKVStore} database does not support
     * synchronous transactions, or data search using snapshots.
     *
     * @interface SingleKVStore
     * @syscap SystemCapability.DistributedDataManager.KVStore.Core
     * @since 20
     */
    interface SingleKVStore {
        
        /**
         * Writes a key-value pair of the string type into the {@code SingleKVStore} database.
         * <p>If you do not want to synchronize this key-value pair to other devices, set the write option in the local
         * database.
         *
         * @param { string } key - Indicates the key. Length must be less than {@code MAX_KEY_LENGTH}.
         * Spaces before and after the key will be cleared.
         * @param { Uint8Array | string | number | boolean } value - Indicates the value to be inserted.
         * @param { AsyncCallback<void> } callback - the callback of put.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types;
         * <br>3.Parameter verification failed.
         * @throws { BusinessError } 15100003 - Database corrupted.
         * @throws { BusinessError } 15100005 - Database or result set already closed.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        put(key: string, value: Uint8Array | string | number | boolean, callback: AsyncCallback<void>): void;
        
        /**
         * Writes a key-value pair of the string type into the {@code SingleKVStore} database.
         * <p>If you do not want to synchronize this key-value pair to other devices, set the write option in the local
         * database.
         *
         * @param { string } key - Indicates the key. Length must be less than {@code MAX_KEY_LENGTH}.
         * Spaces before and after the key will be cleared.
         * @param { Uint8Array | string | number | boolean } value - Indicates the value to be inserted.
         * @returns { Promise<void> } the promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types;
         * <br>3.Parameter verification failed.
         * @throws { BusinessError } 15100003 - Database corrupted.
         * @throws { BusinessError } 15100005 - Database or result set already closed.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        put(key: string, value: Uint8Array | string | number | boolean): Promise<void>;
        /**
         * Obtains the value of a specified key.
         *
         * @param { string } key - Indicates the key. The length must be less than {@code MAX_KEY_LENGTH}.
         * @param { AsyncCallback<boolean | string | number | Uint8Array> } callback -
         * {Uint8Array|string|boolean|number}: the returned value specified by the key.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types;
         * <br>3.Parameter verification failed.
         * @throws { BusinessError } 15100003 - Database corrupted.
         * @throws { BusinessError } 15100004 - Not found.
         * @throws { BusinessError } 15100005 - Database or result set already closed.
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        get(key: string, callback: AsyncCallback<boolean | string | number | Uint8Array>): void;
        /**
         * Obtains the value of a specified key.
         *
         * @param { string } key - Indicates the key. The length must be less than {@code MAX_KEY_LENGTH}.
         * @returns { Promise<boolean | string | number | Uint8Array> }
         * {Uint8Array|string|boolean|number}: the returned value specified by the key.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types;
         * <br>3.Parameter verification failed.
         * @throws { BusinessError } 15100003 - Database corrupted.
         * @throws { BusinessError } 15100004 - Not found.
         * @throws { BusinessError } 15100005 - Database or result set already closed.
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        get(key: string): Promise<boolean | string | number | Uint8Array>;
        /**
         * Backs up a database in the specified filename.
         *
         * @param { string } file - Indicates the database backup filename, It can not be empty and
         * The length must be less than {@code MAX_KEY_LENGTH}.
         * @param { AsyncCallback<void> } callback - the callback of backup.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Parameter verification failed.
         * @throws { BusinessError } 15100005 - Database or result set already closed.
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        backup(file: string, callback: AsyncCallback<void>): void;
        /**
         * Backs up a database in the specified filename.
         *
         * @param { string } file - Indicates the database backup filename, It can not be empty and
         * The length must be less than {@code MAX_KEY_LENGTH}.
         * @returns { Promise<void> } the promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Parameter verification failed.
         * @throws { BusinessError } 15100005 - Database or result set already closed.
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        backup(file: string): Promise<void>;
    }
    /**
     * Provides methods related to device-collaboration distributed databases.
     * <p>To create a {@code DeviceKVStore} database, you can use the
     * {@link data.distributed.common.KVManager.getKVStore(Options, String)}
     * method with {@code KVStoreType} set to {@code DEVICE_COLLABORATION} for the input parameter Options.
     * This database manages distributed
     * data by device, and cannot modify data synchronized from remote devices. When an application writes a
     * key-value pair entry
     * into the database, the system automatically adds the ID of the device running the application to the key.
     *
     * @extends SingleKVStore
     * @typedef DeviceKVStore
     * @syscap SystemCapability.DistributedDataManager.KVStore.DistributedKVStore
     * @since 20
     */
    interface DeviceKVStore extends SingleKVStore {
        /**
         * Obtains the value matching the local device ID and specified key.
         *
         * @param { string } key - Indicates the key. The length must be less than {@code MAX_KEY_LENGTH}.
         * @param { AsyncCallback<boolean | string | number | Uint8Array> } callback -
         * {Uint8Array|string|boolean|number}: the returned value specified by the local device ID and specified key.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types;
         * <br>3.Parameter verification failed.
         * @throws { BusinessError } 15100003 - Database corrupted.
         * @throws { BusinessError } 15100004 - Not found.
         * @throws { BusinessError } 15100005 - Database or result set already closed.
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        get(key: string, callback: AsyncCallback<boolean | string | number | Uint8Array>): void;
        /**
         * Obtains the value matching the local device ID and specified key.
         *
         * @param { string } key - Indicates the key. The length must be less than {@code MAX_KEY_LENGTH}.
         * @returns { Promise<boolean | string | number | Uint8Array> }
         * {Uint8Array|string|boolean|number}: the returned value specified by the local device ID and specified key.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types;
         * <br>3.Parameter verification failed.
         * @throws { BusinessError } 15100003 - Database corrupted.
         * @throws { BusinessError } 15100004 - Not found.
         * @throws { BusinessError } 15100005 - Database or result set already closed.
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        get(key: string): Promise<boolean | string | number | Uint8Array>;
        /**
         * Obtains the value matching a specified device ID and key.
         *
         * @param { string } deviceId - Indicates the device to be queried.
         * @param { string } key - Indicates the key of the value to be queried. The length must be less than
         * {@code MAX_KEY_LENGTH}.
         * @param { AsyncCallback<boolean | string | number | Uint8Array> } callback -
         * {boolean | string | number | Uint8Array}: the returned value specified by the deviceId and key.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types;
         * <br>3.Parameter verification failed.
         * @throws { BusinessError } 15100003 - Database corrupted.
         * @throws { BusinessError } 15100004 - Not found.
         * @throws { BusinessError } 15100005 - Database or result set already closed.
         * @syscap SystemCapability.DistributedDataManager.KVStore.DistributedKVStore
         * @since 20
         */
        get(deviceId: string, key: string, callback: AsyncCallback<boolean | string | number | Uint8Array>): void;
        /**
         * Obtains the value matching a specified device ID and key.
         *
         * @param { string } deviceId - Indicates the device to be queried.
         * @param { string } key - Indicates the key of the value to be queried. The length must be less than
         * {@code MAX_KEY_LENGTH}.
         * @returns { Promise<boolean | string | number | Uint8Array> }
         * {Uint8Array|string|boolean|number}: the returned value specified by the deviceId and key.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types;
         * <br>3.Parameter verification failed.
         * @throws { BusinessError } 15100003 - Database corrupted.
         * @throws { BusinessError } 15100004 - Not found.
         * @throws { BusinessError } 15100005 - Database or result set already closed.
         * @syscap SystemCapability.DistributedDataManager.KVStore.DistributedKVStore
         * @since 20
         */
        get(deviceId: string, key: string): Promise<boolean | string | number | Uint8Array>;
    }
    /**
     * Creates a {@link KVManager} instance based on the configuration information.
     * <p>You must pass {@link KVManagerConfig} to provide configuration information
     * to create a {@link KVManager} instance.
     *
     * @param { KVManagerConfig } config - Indicates the KVStore configuration information,
     * including the package name and context, and package name can not be empty.
     * @returns { KVManager } : the {@code KVManager} instance.
     * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
     * <br>2.Incorrect parameters types;
     * <br>3.Parameter verification failed.
     * @syscap SystemCapability.DistributedDataManager.KVStore.Core
     * @since 20
     */
    function createKVManager(config: KVManagerConfig): KVManager;
    /**
     * Provides interfaces to manage a {@code SingleKVStore} database, including obtaining, closing, and deleting the
     * {@code SingleKVStore}.
     *
     * @interface KVManager
     * @syscap SystemCapability.DistributedDataManager.KVStore.Core
     * @since 20
     */
    interface KVManager {
        /**
         * Creates and obtains a KVStore database by specifying {@code Options} and {@code storeId}.
         *
         * @param { string } storeId - Identifies the KVStore database. The value of this parameter must be unique
         * for the same application, and different applications can share the same value. The storeId can consist
         * of only letters, digits, and underscores (_), and cannot exceed 128 characters.
         * @param { Options } options - Indicates the {@code Options} object used for creating and
         * obtaining the KVStore database.
         * @param { AsyncCallback<T> } callback - {T}: the {@code SingleKVStore} or {@code DeviceKVStore} instance.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types;
         * <br>3.Parameter verification failed.
         * @throws { BusinessError } 15100002 - Open existed database with changed options.
         * @throws { BusinessError } 15100003 - Database corrupted.
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        getKVStore<T>(storeId: string, options: Options, callback: AsyncCallback<T>): void;
        /**
         * Creates and obtains a KVStore database by specifying {@code Options} and {@code storeId}.
         *
         * @param { string } storeId - Identifies the KVStore database. The value of this parameter must be unique
         * for the same application, and different applications can share the same value. The storeId can consist
         * of only letters, digits, and underscores (_), and cannot exceed 128 characters.
         * @param { Options } options - Indicates the {@code Options} object used for creating and
         * obtaining the KVStore database.
         * @returns { Promise<T> } {T}: the {@code SingleKVStore} or {@code DeviceKVStore} instance.
         * @throws { BusinessError } 401 - Parameter error.Possible causes:1.Mandatory parameters are left unspecified;
         * <br>2.Incorrect parameters types;
         * <br>3.Parameter verification failed.
         * @throws { BusinessError } 15100002 - Open existed database with changed options.
         * @throws { BusinessError } 15100003 - Database corrupted.
         * @syscap SystemCapability.DistributedDataManager.KVStore.Core
         * @since 20
         */
        getKVStore<T>(storeId: string, options: Options): Promise<T>;
    }
}
export default distributedKVStore;
