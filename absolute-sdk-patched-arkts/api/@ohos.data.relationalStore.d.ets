/*
 * Copyright (c) 2023-2025 Huawei Device Co., Ltd.
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
import Context from './application/BaseContext';
import dataSharePredicates from './@ohos.data.dataSharePredicates';

/**
 * Provides methods for rdbStore create and delete.
 *
 * @namespace relationalStore
 * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
 * @since 20
 */
declare namespace relationalStore {
    /**
     * Describes the status of asset
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum AssetStatus {
        /**
         * ASSET_NORMAL: means the status of asset is normal.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ASSET_NORMAL,
        /**
         * ASSET_ABNORMAL: means the asset needs to be inserted.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ASSET_INSERT,
        /**
         * ASSET_ABNORMAL: means the asset needs to be updated.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ASSET_UPDATE,
        /**
         * ASSET_ABNORMAL: means the asset needs to be deleted.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ASSET_DELETE,
        /**
         * ASSET_ABNORMAL: means the status of asset is abnormal.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ASSET_ABNORMAL,
        /**
         * ASSET_DOWNLOADING: means the status of asset is downloading.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ASSET_DOWNLOADING
    }
    /**
     * Records information of the asset.
     *
     * @interface Asset
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    interface Asset {
        /**
         * The name of asset.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        name: string;
        /**
         * The uri of asset.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        uri: string;
        /**
         * The path of asset.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        path: string;
        /**
         * The create time of asset.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        createTime: string;
        /**
         * The modify time of asset.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        modifyTime: string;
        /**
         * The size of asset.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        size: string;
        /**
         * The status of asset.
         *
         * @type { ?AssetStatus }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        status?: AssetStatus;
    }
    /**
     * Indicates several assets in one column
     *
     * @typedef { Asset[] } Assets
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    type Assets = Asset[];
    
    
    /**
     * Indicates possible value types
     *
     * @typedef { null | long | double | string | boolean | Uint8Array | Asset | Assets | Float32Array | bigint } ValueType
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    type ValueType = null | long | double | string | boolean | Uint8Array | Asset | Assets | Float32Array | bigint;
    
    
    /**
     * Values in buckets are stored in key-value pairs, change {[key: string]: ValueType;} to Record<string, ValueType>
     *
     * @typedef { Record<string, ValueType> } ValuesBucket
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    type ValuesBucket = Record<string, ValueType>;
    /**
     * The type of the priority key can be number or string
     *
     * @typedef { long | string } PRIKeyType
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    type PRIKeyType = long | string;
    /**
     * The time is in UTC format.
     *
     * @typedef { Date } UTCTime
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    type UTCTime = Date;
    /**
     * Indicates the primary key and UTC time of the modified rows.
     *
     * @typedef { Map<PRIKeyType, UTCTime> } ModifyTime
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    type ModifyTime = Map<PRIKeyType, UTCTime>;
    
    /**
     * Manages relational database configurations.
     *
     * @interface StoreConfig
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    interface StoreConfig {
        
        /**
         * The database name.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        name: string;
        /**
         * Specifies the security level of the database.
         *
         * @type { SecurityLevel }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        securityLevel: SecurityLevel;
        /**
         * Specifies whether the database is encrypted.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        encrypt?: boolean;
        /**
         * The data group id of application.
         *
         * @type { ?string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @StageModelOnly
         * @since 20
         */
        dataGroupId?: string;
        /**
         * Specifies the directory relative to the database directory obtained from context
         *
         * @type { ?string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        customDir?: string;
        /**
         * Specifies whether to clean up dirty data that is synchronized to
         * the local but deleted in the cloud.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.DistributedDataManager.CloudSync.Client
         * @since 20
         */
        autoCleanDirtyData?: boolean;
        /**
         * Specifies whether data can be searched.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @systemapi
         * @since 20
         */
        isSearchable?: boolean;
        /**
         * Specifies whether database allows rebuild.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        allowRebuild?: boolean;
        /**
         * Specifies whether the vector type is supported.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        vector?: boolean;
        
        /**
         * Specifies whether the database opened is read-only.
         * If isReadOnly is true, other configuration items will become invalid.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        isReadOnly?: boolean;
        /**
         * Indicates the names of the shared library containing fts etc.
         *
         * @type { ?Array<string> }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        pluginLibs?: Array<string>;
        /**
         * Enumerates the high availability modes of the RDB store.
         *
         * @type { ?HAMode }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @systemapi
         * @since 20
         */
        haMode?: HAMode;
        
        /**
         * Specifies the cryptographic parameters used when opening an encrypted database.
         *
         * @type { ?CryptoParam }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        cryptoParam?: CryptoParam;
    }
    /**
     * Enumerates the high availability modes of the RDB store.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @systemapi
     * @since 20
     */
    enum HAMode {
        /**
         * SINGLE: Data is written to a single RDB store.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @systemapi
         * @since 20
         */
        SINGLE = 0,
        /**
         * MAIN_REPLICA: Data is written to the main and replica RDB stores.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @systemapi
         * @since 20
         */
        MAIN_REPLICA
    }
    
    /**
     * Specifies the cryptographic parameters used when opening an encrypted database.
     *
     * @typedef CryptoParam
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    interface CryptoParam {
        
        /**
         * Specifies the key used when opening an encrypted database.
         * When finished passing the key to the database, its content should be set to all-zero.
         *
         * @type { Uint8Array }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        encryptionKey: Uint8Array;
        
        /**
         * Specifies the number of KDF iterations used when opening an encrypted database.
         * Default number is 10000.
         * When the number is set to 0, use default iteration number and encryption algorithm.
         *
         * @type { ?int }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        iterationCount?: int;
        
        /**
         * Specifies the encryption algorithm when opening an encrypted database.
         * Default encryption algorithm is AES_256_GCM.
         *
         * @type { ?EncryptionAlgo }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        encryptionAlgo?: EncryptionAlgo;
        
        /**
         * Specifies the HMAC algorithm when opening an encrypted database.
         * Default HMAC algorithm is SHA256.
         *
         * @type { ?HmacAlgo }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        hmacAlgo?: HmacAlgo;
        
        /**
         * Specifies the KDF algorithm when opening an encrypted database.
         * Default KDF SHA algorithm is the same as HMAC algorithm.
         *
         * @type { ?KdfAlgo }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        kdfAlgo?: KdfAlgo;
        
        /**
         * Specifies the page size used when opening an encrypted database.
         * Default crypto page size is 1024.
         *
         * @type { ?int }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        cryptoPageSize?: int;
    }
    
    /**
     * Enumerates the supported encryption algorithm when opening a database.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum EncryptionAlgo {
        
        /**
         * AES_256_GCM: Database is encrypted using AES_256_GCM.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        AES_256_GCM = 0,
        
        /**
         * AES_256_CBC: Database is encrypted using AES_256_CBC.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        AES_256_CBC
    }
    
    /**
     * Enumerates the supported HMAC algorithm when opening a database.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum HmacAlgo {
        
        /**
         * SHA1: HMAC_SHA1 algorithm.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        SHA1 = 0,
        
        /**
         * SHA256: HMAC_SHA256 algorithm.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        SHA256,
        
        /**
         * SHA512: HMAC_SHA512 algorithm.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        SHA512
    }
    
    /**
     * Enumerates the supported KDF algorithm when opening a database.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum KdfAlgo {
        
        /**
         * KDF_SHA1: PBKDF2_HMAC_SHA1 algorithm.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        KDF_SHA1 = 0,
        
        /**
         * KDF_SHA256: PBKDF2_HMAC_SHA256 algorithm.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        KDF_SHA256,
        
        /**
         * KDF_SHA512: PBKDF2_HMAC_SHA512 algorithm.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        KDF_SHA512
    }
    
    /**
     * Defines information about the SQL statements executed.
     *
     * @interface SqlExecutionInfo
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    interface SqlExecutionInfo {
        
        /**
         * Array of SQL statements executed. When the args of batchInsert is too large, there may be more than one SQL.
         *
         * @type { Array<string> }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        sql: Array<string>;
        
        /**
         * Total time used for executing the SQL statements, in μs.
         *
         * @type { long }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        totalTime: long;
        
        /**
         * Maximum time allowed to obtain the SQL file handle, in μs.
         *
         * @type { long }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        waitTime: long;
        
        /**
         * Time used to prepare SQL and args, in μs.
         *
         * @type { long }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        prepareTime: long;
        
        /**
         * Time used to execute the SQL statements, in μs.
         *
         * @type { long }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        executeTime: long;
    }
    /**
     * Defines an exception message.
     *
     * @interface ExceptionMessage
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    interface ExceptionMessage {
        /**
         * Error code returned by SQLite, see {@link https://www.sqlite.org/rescode.html}.
         *
         * @type { int }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        code: int;
        /**
         * Error message.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        message: string;
        /**
         * SQL statement executed when the exception occurs.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        sql: string;
    }
    /**
     * Describes the {@code RdbStore} type.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum SecurityLevel {
        /**
         * S1: means the db is low level security
         * There are some low impact, when the data is leaked.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        S1 = 1,
        /**
         * S2: means the db is middle level security
         * There are some major impact, when the data is leaked.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        S2 = 2,
        /**
         * S3: means the db is high level security
         * There are some severity impact, when the data is leaked.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        S3 = 3,
        /**
         * S4: means the db is critical level security
         * There are some critical impact, when the data is leaked.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        S4 = 4
    }
    /**
     * Indicates the database synchronization mode.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum SyncMode {
        /**
         * Indicates the data is pushed to remote device from local device.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        SYNC_MODE_PUSH = 0,
        /**
         * Indicates the data is pulled from remote device to local device.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        SYNC_MODE_PULL = 1,
        /**
         * Indicates the data is pulled from remote device to local device.
         *
         * @syscap SystemCapability.DistributedDataManager.CloudSync.Client
         * @since 20
         */
        SYNC_MODE_TIME_FIRST,
        /**
         * Indicates force push the native data to the cloud.
         *
         * @syscap SystemCapability.DistributedDataManager.CloudSync.Client
         * @since 20
         */
        SYNC_MODE_NATIVE_FIRST,
        /**
         * Indicates the data is pulled from cloud to local device.
         *
         * @syscap SystemCapability.DistributedDataManager.CloudSync.Client
         * @since 20
         */
        SYNC_MODE_CLOUD_FIRST
    }
    /**
     * Describes the subscription type.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum SubscribeType {
        /**
         * Subscription to remote data changes
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        SUBSCRIBE_TYPE_REMOTE = 0,
        
        /**
         * Subscription to cloud data changes
         *
         * @syscap SystemCapability.DistributedDataManager.CloudSync.Client
         * @since 20
         */
        SUBSCRIBE_TYPE_CLOUD,
        
        /**
         * Subscription to cloud data changes details
         *
         * @syscap SystemCapability.DistributedDataManager.CloudSync.Client
         * @since 20
         */
        SUBSCRIBE_TYPE_CLOUD_DETAILS,
        /**
         * Subscription to local data changes details
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        SUBSCRIBE_TYPE_LOCAL_DETAILS
    }
    /**
     * Describes the change type.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum ChangeType {
        
        /**
         * Means the change type is data change.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        DATA_CHANGE,
        
        /**
         * Means the change type is asset change.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ASSET_CHANGE
    }
    /**
     * Indicates the notify info
     *
     * @interface ChangeInfo
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    interface ChangeInfo {
        /**
         * Indicates the changed table
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        table: string;
        /**
         * Indicates the changed type
         *
         * @type { ChangeType }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        type: ChangeType;
        /**
         * Indicates if there is a string primary key, the inserted will keep data's primary keys
         * otherwise it will keep the data's rowid.
         *
         * @type { Array<string> | Array<long> }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        inserted: Array<string> | Array<long>;
        /**
         * Indicates if there is a string primary key, the updated will keep data's primary keys
         * otherwise it will keep the data's rowid.
         *
         * @type { Array<string> | Array<long> }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        updated: Array<string> | Array<long>;
        /**
         * Indicates if there is a string primary key, the deleted will keep data's primary keys
         * otherwise it will keep the data's rowid.
         *
         * @type { Array<string> | Array<long> }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        deleted: Array<string> | Array<long>;
    }
    /**
     * Describes the conflict resolutions to insert data into the table.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum ConflictResolution {
        /**
         * Implements no action when conflict occurs.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ON_CONFLICT_NONE = 0,
        /**
         * Implements rollback operation when conflict occurs.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ON_CONFLICT_ROLLBACK = 1,
        /**
         * Implements abort operation when conflict occurs.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ON_CONFLICT_ABORT = 2,
        /**
         * Implements fail operation when conflict occurs.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ON_CONFLICT_FAIL = 3,
        /**
         * Implements ignore operation when conflict occurs.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ON_CONFLICT_IGNORE = 4,
        /**
         * Implements replace operation operator when conflict occurs.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ON_CONFLICT_REPLACE = 5
    }
    /**
     * Enumerates the type of rebuild.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum RebuildType {
        /**
         * The database is not rebuilt or repaired.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        NONE,
        /**
         * The database is rebuilt.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        REBUILT,
        /**
         * The database is repaired.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        REPAIRED
    }
    
    /**
     * Enumerates the type of transaction.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum TransactionType {
        
        /**
         * The DEFERRED transaction.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        DEFERRED,
        
        /**
         * The IMMEDIATE transaction.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        IMMEDIATE,
        
        /**
         * The EXCLUSIVE transaction.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        EXCLUSIVE
    }
    
    /**
     * Create transaction options.
     *
     * @interface TransactionOptions
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    interface TransactionOptions {
        
        /**
         * The type of transaction.
         *
         * @type { TransactionType }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        transactionType?: TransactionType;
    }
    /**
     * Enumerates the data types of a column.
     *
     * @enum { int }
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    enum ColumnType {
        /**
         * The value in the column is null.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        NULL,
        /**
         * The value in the column is a 64-bit integer. It can be used to hold an 8-bit (including Boolean values), 16-bit,
         * 32-bit, or 64-bit integer.if the 64-bit integer is greater than 2^53 or less than -2^53, you can use getString
         * to convert the 64-bit integer into a string.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        INTEGER,
        /**
         * The value in the column is a floating point number.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        REAL,
        /**
         * The value in the column is a string.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        TEXT,
        /**
         * The value in the column is a Uint8Array.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        BLOB,
        /**
         * The value in the column is an asset.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ASSET,
        /**
         * The value in the column is an array of assets.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        ASSETS,
        /**
         * The value in the column is a Float32Array.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        FLOAT_VECTOR,
        /**
         * The value in the column is a bigint.
         *
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        UNLIMITED_INT
    }
    
    /**
     * Manages relational database configurations.
     *
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    class RdbPredicates {
        
        /**
         * A parameterized constructor used to create a RdbPredicates instance.
         *
         * @param { string } name - Indicates the table name of the database.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        constructor(name: string);
        
        /**
         * Configure the RdbPredicates to match the field whose data type is ValueType and value is equal
         * to a specified value.
         * This method is similar to = of the SQL statement.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { ValueType } value - Indicates the value to match with the {@link RdbPredicates}.
         * @returns { RdbPredicates } - The {@link RdbPredicates} self.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        equalTo(field: string, value: ValueType): RdbPredicates;
        
        /**
         * Configure the RdbPredicates to match the field whose data type is ValueType and value is not equal to
         * a specified value.
         * This method is similar to != of the SQL statement.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { ValueType } value - Indicates the value to match with the {@link RdbPredicates}.
         * @returns { RdbPredicates } - The {@link RdbPredicates} self.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        notEqualTo(field: string, value: ValueType): RdbPredicates;
        
        /**
         * Adds a left parenthesis to the RdbPredicates.
         * This method is similar to ( of the SQL statement and needs to be used together with endWrap().
         *
         * @returns { RdbPredicates } - The {@link RdbPredicates} with the left parenthesis.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        beginWrap(): RdbPredicates;
        
        /**
         * Adds a right parenthesis to the RdbPredicates.
         * This method is similar to ) of the SQL statement and needs to be used together with beginWrap().
         *
         * @returns { RdbPredicates } - The {@link RdbPredicates} with the right parenthesis.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        endWrap(): RdbPredicates;
        
        /**
         * Adds an or condition to the RdbPredicates.
         * This method is similar to or of the SQL statement.
         *
         * @returns { RdbPredicates } - The {@link RdbPredicates} with the or condition.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        or(): RdbPredicates;
        
        /**
         * Adds an and condition to the RdbPredicates.
         * This method is similar to and of the SQL statement.
         *
         * @returns { RdbPredicates } - The {@link RdbPredicates} with the and condition.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        and(): RdbPredicates;
        
        /**
         * Configure the RdbPredicates to match the field whose data type is string and value
         * contains a specified value.
         * This method is similar to contains of the SQL statement.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { string } value - Indicates the value to match with the {@link RdbPredicates}.
         * @returns { RdbPredicates } - The {@link RdbPredicates} self.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        contains(field: string, value: string): RdbPredicates;
        
        /**
         * Configure the RdbPredicates to match the field whose data type is string and value starts
         * with a specified string.
         * This method is similar to value% of the SQL statement.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { string } value - Indicates the value to match with the {@link RdbPredicates}.
         * @returns { RdbPredicates } - The {@link RdbPredicates} self.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        beginsWith(field: string, value: string): RdbPredicates;
        
        /**
         * Configure the RdbPredicates to match the field whose data type is string and value
         * ends with a specified string.
         * This method is similar to %value of the SQL statement.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { string } value - Indicates the value to match with the {@link RdbPredicates}.
         * @returns { RdbPredicates } - The {@link RdbPredicates} self.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        endsWith(field: string, value: string): RdbPredicates;
        
        /**
         * Configure the RdbPredicates to match the fields whose value is null.
         * This method is similar to is null of the SQL statement.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @returns { RdbPredicates } - The {@link RdbPredicates} self.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        isNull(field: string): RdbPredicates;
        
        /**
         * Configure the RdbPredicates to match the specified fields whose value is not null.
         * This method is similar to is not null of the SQL statement.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @returns { RdbPredicates } - The {@link RdbPredicates} self.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        isNotNull(field: string): RdbPredicates;
        
        /**
         * Configure the RdbPredicates to match the fields whose data type is string and value is
         * similar to a specified string.
         * This method is similar to like of the SQL statement.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { string } value - Indicates the value to match with the {@link RdbPredicates}.
         * @returns { RdbPredicates } - The {@link RdbPredicates} that match the specified field.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        like(field: string, value: string): RdbPredicates;
        
        /**
         * Configure RdbPredicates to match the specified field whose data type is string and the value contains
         * a wildcard.
         * Different from like, the input parameters of this method are case-sensitive.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { string } value - Indicates the value to match with the {@link RdbPredicates}.
         * @returns { RdbPredicates } - The SQL statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        glob(field: string, value: string): RdbPredicates;
        
        /**
         * Configure RdbPredicates to match the specified field whose value is within a given range.
         *
         * @param { string } field - Indicates the column name.
         * @param { ValueType } low - Indicates the minimum value.
         * @param { ValueType } high - Indicates the maximum value.
         * @returns { RdbPredicates } - The SQL statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        between(field: string, low: ValueType, high: ValueType): RdbPredicates;
        
        /**
         * Configure RdbPredicates to match the specified field whose value is out of a given range.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { ValueType } low - Indicates the minimum value.
         * @param { ValueType } high - Indicates the maximum value.
         * @returns { RdbPredicates } - The SQL statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        notBetween(field: string, low: ValueType, high: ValueType): RdbPredicates;
        
        /**
         * Restricts the value of the field to be greater than the specified value.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { ValueType } value - Indicates the value to match with the {@link RdbPredicates}.
         * @returns { RdbPredicates } - The SQL query statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        greaterThan(field: string, value: ValueType): RdbPredicates;
        
        /**
         * Restricts the value of the field to be smaller than the specified value.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { ValueType } value - Indicates the value to match with the {@link RdbPredicates}.
         * @returns { RdbPredicates } - The SQL query statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        lessThan(field: string, value: ValueType): RdbPredicates;
        
        /**
         * Restricts the value of the field to be greater than or equal to the specified value.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { ValueType } value - Indicates the value to match with the {@link RdbPredicates}.
         * @returns { RdbPredicates } - The SQL query statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        greaterThanOrEqualTo(field: string, value: ValueType): RdbPredicates;
        
        /**
         * Restricts the value of the field to be smaller than or equal to the specified value.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { ValueType } value - Indicates the value to match with the {@link RdbPredicates}.
         * @returns { RdbPredicates } - The SQL query statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        lessThanOrEqualTo(field: string, value: ValueType): RdbPredicates;
        
        /**
         * Restricts the ascending order of the return list. When there are several orders,
         * the one close to the head has the highest priority.
         *
         * @param { string } field - Indicates the column name for sorting the return list.
         * @returns { RdbPredicates } - The SQL query statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        orderByAsc(field: string): RdbPredicates;
        
        /**
         * Restricts the descending order of the return list. When there are several orders,
         * the one close to the head has the highest priority.
         *
         * @param { string } field - Indicates the column name for sorting the return list.
         * @returns { RdbPredicates } - The SQL query statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        orderByDesc(field: string): RdbPredicates;
        
        /**
         * Restricts each row of the query result to be unique.
         *
         * @returns { RdbPredicates } - The SQL query statement with the specified {@link RdbPredicates}.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        distinct(): RdbPredicates;
        
        /**
         * Restricts the max number of return records.
         *
         * @param { int } value - Indicates the max length of the return list.
         * @returns { RdbPredicates } - The SQL query statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        limitAs(value: int): RdbPredicates;
        
        /**
         * Configure RdbPredicates to specify the start position of the returned result.
         * Use this method together with limit(number).
         *
         * @param { int } rowOffset - Indicates the start position of the returned result.
         * The value is a positive integer.
         * @returns { RdbPredicates } - The SQL query statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        offsetAs(rowOffset: int): RdbPredicates;
        
        /**
         * Configure RdbPredicates to group query results by specified columns.
         *
         * @param { Array<string> } fields - Indicates the specified columns by which query results are grouped.
         * @returns { RdbPredicates } - The SQL query statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        groupBy(fields: Array<string>): RdbPredicates;
        
        /**
         * Configure RdbPredicates to specify the index column.
         * Before using this method, you need to create an index column.
         *
         * @param { string } field - Indicates the name of the index column.
         * @returns { RdbPredicates } - The SQL statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        indexedBy(field: string): RdbPredicates;
        /**
         * Configure RdbPredicates to match the specified field whose data type is ValueType array and values
         * are within a given range.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { Array<ValueType> } value - Indicates the values to match with {@link RdbPredicates}.
         * @returns { RdbPredicates } - The SQL statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        inValues(field: string, value: Array<ValueType>): RdbPredicates;
        /**
         * Configure RdbPredicates to match the specified field whose data type is ValueType array and values
         * are out of a given range.
         *
         * @param { string } field - Indicates the column name in the database table.
         * @param { Array<ValueType> } value - Indicates the values to match with {@link RdbPredicates}.
         * @returns { RdbPredicates } - The SQL statement with the specified {@link RdbPredicates}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        notInValues(field: string, value: Array<ValueType>): RdbPredicates;
    }
    
    /**
     * Provides methods for accessing a database result set generated by querying the database.
     *
     * @interface ResultSet
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    interface ResultSet {
        
        /**
         * Obtains the names of all columns in a result set.
         * The column names are returned as a string array, in which the strings are in the same order
         * as the columns in the result set.
         *
         * @type { Array<string> }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        columnNames: Array<string>;
        
        /**
         * Obtains the number of columns in the result set.
         * The returned number is equal to the length of the string array returned by the
         * columnNames method.
         *
         * @type { int }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        columnCount: int;
        
        /**
         * Obtains the number of rows in the result set.
         *
         * @type { int }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        rowCount: int;
        
        /**
         * Obtains the current index of the result set.
         * The result set index starts from 0.
         *
         * @type { int }
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        rowIndex: int;
        
        
        /**
         * Obtains the column index based on the specified column name.
         * The column name is passed as an input parameter.
         *
         * @param { string } columnName - Indicates the name of the specified column in the result set.
         * @returns { int } The index of the specified column.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800019 - The SQL must be a query statement.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getColumnIndex(columnName: string): int;
        
        
        /**
         * Obtains the column name based on the specified column index.
         * The column index is passed as an input parameter.
         *
         * @param { int } columnIndex - Indicates the index of the specified column in the result set.
         * @returns { string } The name of the specified column.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800019 - The SQL must be a query statement.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getColumnName(columnIndex: int): string;
        /**
         * Obtains the column data type based on the specified column index.
         * The column index is passed as an input parameter.
         *
         * @param { int | string } columnIdentifier - Index or name of the column.
         * @returns { Promise<ColumnType> } Promise used to return the data type obtained,
         * in an {@link ColumnType} instance.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800019 - The SQL must be a query statement.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getColumnType(columnIdentifier: int | string): Promise<ColumnType>;
        /**
         * Obtains the column data type based on the specified column index. This API returns the result synchronously.
         *
         * @param { int | string } columnIdentifier - Index or name of the column.
         * @returns { ColumnType } Column data type obtained.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800019 - The SQL must be a query statement.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getColumnTypeSync(columnIdentifier: int | string): ColumnType;
        
        
        /**
         * Go to the specified row of the result set forwards or backwards by an offset relative to its current position.
         * A positive offset indicates moving backwards, and a negative offset indicates moving forwards.
         *
         * @param { int } offset - Indicates the offset relative to the current position.
         * @returns { boolean } True if the result set is moved successfully and does not go beyond the range;
         * Returns false otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800019 - The SQL must be a query statement.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        goTo(offset: int): boolean;
        
        
        /**
         * Go to the specified row of the result set.
         *
         * @param { int } position - Indicates the index of the specified row, which starts from 0.
         * @returns { boolean } True if the result set is moved successfully; Returns false otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800019 - The SQL must be a query statement.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        goToRow(position: int): boolean;
        
        
        /**
         * Go to the first row of the result set.
         *
         * @returns { boolean } True if the result set is moved successfully;
         * Returns false otherwise, for example, if the result set is empty.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800019 - The SQL must be a query statement.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        goToFirstRow(): boolean;
        
        
        /**
         * Go to the last row of the result set.
         *
         * @returns { boolean } True if the result set is moved successfully;
         * Returns false otherwise, for example, if the result set is empty.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800019 - The SQL must be a query statement.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        goToLastRow(): boolean;
        
        
        /**
         * Go to the next row of the result set.
         *
         * @returns { boolean } True if the result set is moved successfully;
         * Returns false otherwise, for example, if the result set is already in the last row.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800019 - The SQL must be a query statement.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        goToNextRow(): boolean;
        
        
        /**
         * Go to the previous row of the result set.
         *
         * @returns { boolean } True if the result set is moved successfully;
         * Returns false otherwise, for example, if the result set is already in the first row.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800019 - The SQL must be a query statement.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        goToPreviousRow(): boolean;
        
        
        /**
         * Obtains the value of the specified column in the current row as a byte array.
         * The implementation class determines whether to throw an exception if the value of the specified column
         * in the current row is null or the specified column is not of the Blob type.
         *
         * @param { int } columnIndex - Indicates the specified column index, which starts from 0.
         * @returns { Uint8Array } The value of the specified column as a byte array.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getBlob(columnIndex: int): Uint8Array;
        
        
        /**
         * Obtains the value of the specified column in the current row as string.
         * The implementation class determines whether to throw an exception if the value of the specified column
         * in the current row is null or the specified column is not of the string type.
         *
         * @param { int } columnIndex - Indicates the specified column index, which starts from 0.
         * @returns { string } The value of the specified column as a string.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getString(columnIndex: int): string;
        
        
        /**
         * Obtains the value of the specified column in the current row as long.
         * The implementation class determines whether to throw an exception if the value of the specified column
         * in the current row is null, the specified column is not of the integer type.
         *
         * @param { int } columnIndex - Indicates the specified column index, which starts from 0.
         * @returns { long } The value of the specified column as a long.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getLong(columnIndex: int): long;
        
        
        /**
         * Obtains the value of the specified column in the current row as double.
         * The implementation class determines whether to throw an exception if the value of the specified column
         * in the current row is null, the specified column is not of the double type.
         *
         * @param { int } columnIndex - Indicates the specified column index, which starts from 0.
         * @returns { double } The value of the specified column as a double.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getDouble(columnIndex: int): double;
        
        /**
         * Obtains the value of the specified column in the current row as an asset.
         * The implementation class determines whether to throw an exception if the value of the specified column
         * in the current row is null or the specified column is not of the Asset type.
         *
         * @param { int } columnIndex - Indicates the specified column index, which starts from 0.
         * @returns { Asset } The value of the specified column as an asset.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getAsset(columnIndex: int): Asset;
        
        /**
         * Obtains the value of the specified column in the current row as assets.
         * The implementation class determines whether to throw an exception if the value of the specified column
         * in the current row is null or the specified column is not of the Assets type.
         *
         * @param { int } columnIndex - Indicates the specified column index, which starts from 0.
         * @returns { Assets } The value of the specified column as assets.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getAssets(columnIndex: int): Assets;
        
        
        /**
         * Obtains the value of the specified column in the current row.
         * The implementation class determines whether to throw an exception if the value of the specified column
         * in the current row is null or the specified column is not of the Assets type.
         * Inserting an empty blob, after API14 and API14, the obtained value is an empty blob; Before API 14,
         * the obtained value was null.
         *
         * @param { int } columnIndex - Indicates the specified column index, which starts from 0.
         * @returns { ValueType } The value of the specified column.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getValue(columnIndex: int): ValueType;
        /**
         * Obtains the value of the specified column in the current row as a float array.
         * The implementation class determines whether to throw an exception if the value of the specified column
         * in the current row is null or the specified column is not of the float array type.
         *
         * @param { int } columnIndex - Indicates the specified column index, which starts from 0.
         * @returns { Float32Array } The value of the specified column as a float array.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - The capability is not supported because the database is not a vector DB.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @systemapi
         * @since 20
         */
        getFloat32Array(columnIndex: int): Float32Array;
        
        
        /**
         * Obtains the values of all columns in the specified row.
         * Inserting an empty blob, after API14 and API14, the obtained value is an empty blob; Before API 14,
         * the obtained value was null.
         *
         * @returns { ValuesBucket } Indicates the row of data {@link ValuesBucket} to be inserted into the table.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getRow(): ValuesBucket;
        /**
         * Obtains the values of all columns in the specified rows.
         * @param { int } maxCount - Indicates the maximum number of rows.
         * @param { int } [position] - Indicates the start position to obtain the values.
         * @returns { Promise<Array<ValuesBucket>> } Promise used to return the values obtained,
         * in an {@link Array<ValuesBucket>}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getRows(maxCount: int, position?: int): Promise<Array<ValuesBucket>>;
        
        
        /**
         * Checks whether the value of the specified column in the current row is null.
         *
         * @param { int } columnIndex - Indicates the specified column index, which starts from 0.
         * @returns { boolean } True if the value of the specified column in the current row is null;
         * Returns false otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @throws { BusinessError } 14800013 - Resultset is empty or column index is out of bounds.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        isColumnNull(columnIndex: int): boolean;
        
        
        /**
         * Closes the result set.
         * Calling this method on the result set will release all of its resources and makes it ineffective.
         *
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800012 - ResultSet is empty or pointer index is out of bounds.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        close(): void;
    }
    
    /**
     * Provides methods for managing the relational database (RDB).
     * This class provides methods for creating, querying, updating, and deleting RDBs.
     *
     * @interface RdbStore
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    interface RdbStore {
        
        
        /**
         * Set RdbStore version. The version number must be an integer greater than 0.
         * Obtains the RdbStore version.
         *
         * @type { int }
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        version: int;
        /**
         * Set whether the database is rebuilt.
         *
         * @type {RebuildType}
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        rebuilt: RebuildType;
        
        
        /**
         * Inserts a row of data into the target table.
         *
         * @param { string } table - Indicates the target table.
         * @param { ValuesBucket } values - Indicates the row of data {@link ValuesBucket} to be inserted into the table.
         * @returns { Promise<long> } The row ID if the operation is successful. return -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        insert(table: string, values: ValuesBucket): Promise<long>;
        
        /**
         * Inserts a row of data into the target table.
         *
         * @param { string } table - Indicates the target table.
         * @param { ValuesBucket } values - Indicates the row of data {@link ValuesBucket} to be inserted into the table.
         * @param { ConflictResolution } conflict - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { Promise<long> } The row ID if the operation is successful. return -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        insert(table: string, values: ValuesBucket, conflict: ConflictResolution): Promise<long>;
        /**
         * Inserts a row of data into the target table with sync interface.
         *
         * @param { string } table - Indicates the target table.
         * @param { ValuesBucket } values - Indicates the row of data {@link ValuesBucket} to be inserted into the table.
         * @param { ConflictResolution } conflict - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { long } The row ID if the operation is successful. return -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        insertSync(table: string, values: ValuesBucket, conflict?: ConflictResolution): long;
        
        
        /**
         * Inserts a batch of data into the target table.
         *
         * @param { string } table - Indicates the target table.
         * @param { Array<ValuesBucket> } values -
         * Indicates the rows of data {@link ValuesBucket} to be inserted into the table.
         * @returns { Promise<long> } The number of values that were inserted if the operation is successful.
         * returns -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        batchInsert(table: string, values: Array<ValuesBucket>): Promise<long>;
        /**
         * Inserts a batch of data into the target table.
         *
         * @param { string } table - Indicates the target table.
         * @param { Array<ValuesBucket> } values -
         * Indicates the rows of data {@link ValuesBucket} to be inserted into the table.
         * @returns { long } The number of values that were inserted if the operation is successful. returns -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        batchInsertSync(table: string, values: Array<ValuesBucket>): long;
        /**
         * Inserts a batch of data into the target table.
         *
         * @param { string } table - Indicates the target table.
         * @param { Array<ValuesBucket> } values -
         * Indicates the rows of data {@link ValuesBucket} to be inserted into the table.
         * @param { ConflictResolution } conflict - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { Promise<long> } The number of values that were inserted if the operation is successful.
         * returns -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        batchInsertWithConflictResolution(table: string, values: Array<ValuesBucket>, conflict: ConflictResolution): Promise<long>;
        /**
         * Inserts a batch of data into the target table.
         *
         * @param { string } table - Indicates the target table.
         * @param { Array<ValuesBucket> } values -
         * Indicates the rows of data {@link ValuesBucket} to be inserted into the table.
         * @param { ConflictResolution } conflict - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { long } The number of values that were inserted if the operation is successful. returns -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        batchInsertWithConflictResolutionSync(table: string, values: Array<ValuesBucket>, conflict: ConflictResolution): long;
        
        
        /**
         * Updates data in the database based on a specified instance object of RdbPredicates.
         *
         * @param { ValuesBucket } values - Indicates the row of data to be updated in the database.
         * The key-value pairs are associated with column names of the database table.
         * @param { RdbPredicates } predicates -
         * Indicates the specified update condition by the instance object of  {@link RdbPredicates}.
         * @returns { Promise<long> } The number of affected rows.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        update(values: ValuesBucket, predicates: RdbPredicates): Promise<long>;
        
        /**
         * Updates data in the database based on a specified instance object of RdbPredicates.
         *
         * @param { ValuesBucket } values - Indicates the row of data to be updated in the database.
         * The key-value pairs are associated with column names of the database table.
         * @param { RdbPredicates } predicates -
         * Indicates the specified update condition by the instance object of  {@link RdbPredicates}.
         * @param { ConflictResolution } conflict - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { Promise<long> } The number of affected rows.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        update(values: ValuesBucket, predicates: RdbPredicates, conflict: ConflictResolution): Promise<long>;
        /**
         * Updates data in the database based on a specified instance object of RdbPredicates with sync interface.
         *
         * @param { ValuesBucket } values - Indicates the row of data to be updated in the database.
         * The key-value pairs are associated with column names of the database table.
         * @param { RdbPredicates } predicates -
         * Indicates the specified update condition by the instance object of  {@link RdbPredicates}.
         * @param { ConflictResolution } conflict - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { long } The number of affected rows.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        updateSync(values: ValuesBucket, predicates: RdbPredicates, conflict?: ConflictResolution): long;
        
        
        /**
         * Updates data in the database based on a specified instance object of RdbPredicates.
         *
         * @param { string } table - Indicates the target table.
         * @param { ValuesBucket } values - Indicates the row of data to be updated in the database.
         * The key-value pairs are associated with column names of the database table.
         * @param { dataSharePredicates.DataSharePredicates } predicates - Indicates the specified update condition by
         * the instance object of {@link dataSharePredicates.DataSharePredicates}.
         * @returns { Promise<long> } The number of affected rows.
         * @throws { BusinessError } 202 - Permission verification failed,
         * application which is not a system application uses system API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @systemapi
         * @StageModelOnly
         * @since 20
         */
        update(table: string, values: ValuesBucket, predicates: dataSharePredicates.DataSharePredicates): Promise<long>;
        
        
        /**
         * Deletes data from the database based on a specified instance object of RdbPredicates.
         *
         * @param { RdbPredicates } predicates -
         * The specified delete condition by the instance object of {@link RdbPredicates}.
         * @returns { Promise<long> } return the number of affected rows.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        delete(predicates: RdbPredicates): Promise<long>;
        /**
         * Deletes data from the database based on a specified instance object of RdbPredicates with sync interface.
         *
         * @param { RdbPredicates } predicates -
         * The specified delete condition by the instance object of {@link RdbPredicates}.
         * @returns { long } return the number of rows deleted.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        deleteSync(predicates: RdbPredicates): long;
        
        
        /**
         * Deletes data from the database based on a specified instance object of RdbPredicates.
         *
         * @param { string } table - Indicates the target table.
         * @param { dataSharePredicates.DataSharePredicates } predicates -
         * The specified delete condition by the instance object of {@link dataSharePredicates.DataSharePredicates}.
         * @returns { Promise<long> } The number of affected rows.
         * @throws { BusinessError } 202 - Permission verification failed,
         * application which is not a system application uses system API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @systemapi
         * @StageModelOnly
         * @since 20
         */
        delete(table: string, predicates: dataSharePredicates.DataSharePredicates): Promise<long>;
        
        
        /**
         * Queries data in the database based on specified conditions.
         *
         * @param { RdbPredicates } predicates -
         * The specified query condition by the instance object of {@link RdbPredicates}.
         * @param { Array<string> } columns - The columns to query. If the value is null, the query applies to all columns.
         * @returns { Promise<ResultSet> } The {@link ResultSet} object if the operation is successful.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        query(predicates: RdbPredicates, columns?: Array<string>): Promise<ResultSet>;
        /**
         * Queries data in the database based on specified conditions with sync function.
         *
         * @param { RdbPredicates } predicates -
         * The specified query condition by the instance object of {@link RdbPredicates}.
         * @param { Array<string> } columns -
         * The columns to query. If the value is empty array, the query applies to all columns.
         * @returns { ResultSet } The {@link ResultSet} object if the operation is successful.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        querySync(predicates: RdbPredicates, columns?: Array<string>): ResultSet;
        
        
        /**
         * Queries data in the database based on SQL statement.
         *
         * @param { string } sql - Indicates the SQL statement to execute.
         * @param { Array<ValueType> } bindArgs -
         * Indicates the {@link ValueType} values of the parameters in the SQL statement. The values are strings.
         * @returns { Promise<ResultSet> } The {@link ResultSet} object if the operation is successful.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        querySql(sql: string, bindArgs?: Array<ValueType>): Promise<ResultSet>;
        
        /**
         * Obtains the modify time of rows corresponding to the primary keys.
         *
         * @param { string } table - Indicates the name of the table to check.
         * @param { string } columnName - Indicates the name of the column to check.
         * @param { PRIKeyType[] } primaryKeys - Indicates the primary keys of the rows to check.
         * @returns { Promise<ModifyTime> } -
         * The promise returned by the function. ModifyTime indicates the modify time of current row.
         * If this table does not support cloud, the {@link ModifyTime} will be empty.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1. Need 3 - 4  parameter(s)! 2. The RdbStore must be not nullptr.
         * 3. The tablesNames must be not empty string. 4. The columnName must be not empty string.
         * 5. The PRIKey must be number or string.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        getModifyTime(table: string, columnName: string, primaryKeys: PRIKeyType[]): Promise<ModifyTime>;
        
        /**
         * Cleans dirty data deleted in the cloud.
         *
         * If a cursor is specified, data with a cursor smaller than the specified cursor will be cleaned up.
         * otherwise clean all.
         *
         * @param { string } table - Indicates the name of the table to check.
         * @param { long } [cursor] - Indicates the cursor.
         * @returns { Promise<void> } -The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1. Need 1 - 3  parameter(s)! 2. The RdbStore must be not nullptr.
         * 3. The tablesNames must be not empty string. 4. The cursor must be valid cursor.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.CloudSync.Client
         * @since 20
         */
        cleanDirtyData(table: string, cursor?: long): Promise<void>;
        /**
         * Executes a SQL statement that contains specified parameters and returns a value of ValueType.
         *
         * @param { string } sql - Indicates the SQL statement to execute.
         * @param { Array<ValueType> } args - Indicates the {@link ValueType} values of the parameters in the SQL statement.
         * The values are strings.
         * @returns { Promise<ValueType> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported the sql(attach,begin,commit,rollback etc.).
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        execute(sql: string, args?: Array<ValueType>): Promise<ValueType>;
        
        /**
         * Sync data between devices.
         *
         * @permission ohos.permission.DISTRIBUTED_DATASYNC
         * @param { SyncMode } mode - Indicates the database synchronization mode.
         * @param { RdbPredicates } predicates -
         * The specified sync condition by the instance object of {@link RdbPredicates}.
         * @returns { Promise<Array<[string, int]>> }
         * {Array<[string, int]>}: devices sync status array, {string}: device id, {number}: device sync status.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        sync(mode: SyncMode, predicates: RdbPredicates): Promise<Array<[
            string,
            int
        ]>>;
        
        /**
         * Close the RdbStore and all resultSets.
         *
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error. The store must not be nullptr.
         * @throws { BusinessError } 14800000 - Inner error.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        close(): Promise<void>;
        /**
         * Attaches a database file to the currently linked database.
         *
         * @param { string } fullPath - Indicates the path of the database file to attach.
         * @param { string } attachName - Indicates the alias of the database.
         * @param { long } waitTime - Indicates the maximum time allowed for attaching the database file.
         * @returns { Promise<int> } Promise used to return the number of attached databases.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800010 - Failed to open or delete the database by an invalid database path.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800016 - The database alias already exists.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        attach(fullPath: string, attachName: string, waitTime?: long): Promise<int>;
        /**
         * Attaches a database file to the currently linked database.
         *
         * @param { Context } context - Indicates the context of an application or ability.
         * @param { StoreConfig } config -
         * Indicates the {@link StoreConfig} configuration of the database related to this RDB store.
         * @param { string } attachName - Indicates the alias of the database.
         * @param { long } waitTime - Indicates the maximum time allowed for attaching the database file.
         * @returns { Promise<int> } Promise used to return the number of attached databases.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800010 - Failed to open or delete the database by an invalid database path.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800016 - The database alias already exists.
         * @throws { BusinessError } 14801001 - The operation is supported in the stage model only.
         * @throws { BusinessError } 14801002 - Invalid data group ID.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        attach(context: Context, config: StoreConfig, attachName: string, waitTime?: long): Promise<int>;
        /**
         * Detaches a database from this database.
         *
         * @param { string } attachName - Indicates the alias of the database.
         * @param { long } waitTime - Indicates the maximum time allowed for detaching the database.
         * @returns { Promise<int> } Return the current number of attached databases.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database does not respond.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        detach(attachName: string, waitTime?: long): Promise<int>;
        /**
         * Lock cloud container before non-auto cloud sync.
         *
         * @returns { Promise<int> } The expired time of the lock.
         * @throws { BusinessError } 202 - Permission verification failed,
         * application which is not a system application uses system API.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @systemapi
         * @since 20
         */
        lockCloudContainer(): Promise<int>;
        /**
         * create a transaction instance and begin.
         *
         * @param { TransactionOptions } options - The option for creating transactions.
         * @returns { Promise<Transaction> } The {@link Transaction} object if the operation is successful.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800015 - The database is busy.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        createTransaction(options?: TransactionOptions): Promise<Transaction>;
    }
    /**
     * Provides transactional methods for managing the relational database (RDB).
     *
     * @interface Transaction
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    interface Transaction {
        /**
         * commit the transaction.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        commit(): Promise<void>;
        /**
         * rollback the transaction.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        rollback(): Promise<void>;
        /**
         * Inserts a row of data into the target table.
         *
         * @param { string } table - Indicates the target table.
         * @param { ValuesBucket } values - Indicates the row of data {@link ValuesBucket} to be inserted into the table.
         * @param { ConflictResolution } conflict - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { Promise<long> } The row ID if the operation is successful. return -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        insert(table: string, values: ValuesBucket, conflict?: ConflictResolution): Promise<long>;
        /**
         * Inserts a row of data into the target table with sync interface, just use in TaskPool or Worker.
         *
         * @param { string } table - Indicates the target table.
         * @param { ValuesBucket } values - Indicates the row of data {@link ValuesBucket} to be inserted into the table.
         * @param { ConflictResolution } [conflict] - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { long } The row ID if the operation is successful. return -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        insertSync(table: string, values: ValuesBucket, conflict?: ConflictResolution): long;
        /**
         * Inserts a batch of data into the target table.
         *
         * @param { string } table - Indicates the target table.
         * @param { Array<ValuesBucket> } values -
         * Indicates the rows of data {@link ValuesBucket} to be inserted into the table.
         * @returns { Promise<long> } The number of values that were inserted if the operation is successful.
         * returns -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        batchInsert(table: string, values: Array<ValuesBucket>): Promise<long>;
        /**
         * Inserts a batch of data into the target table.
         *
         * @param { string } table - Indicates the target table.
         * @param { Array<ValuesBucket> } values -
         * Indicates the rows of data {@link ValuesBucket} to be inserted into the table.
         * @returns { long } The number of values that were inserted if the operation is successful. returns -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        batchInsertSync(table: string, values: Array<ValuesBucket>): long;
        /**
         * Inserts a batch of data into the target table.
         *
         * @param { string } table - Indicates the target table.
         * @param { Array<ValuesBucket> } values -
         * Indicates the rows of data {@link ValuesBucket} to be inserted into the table.
         * @param { ConflictResolution } conflict - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { Promise<long> } The number of values that were inserted if the operation is successful.
         * returns -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        batchInsertWithConflictResolution(table: string, values: Array<ValuesBucket>, conflict: ConflictResolution): Promise<long>;
        /**
         * Inserts a batch of data into the target table.
         *
         * @param { string } table - Indicates the target table.
         * @param { Array<ValuesBucket> } values -
         * Indicates the rows of data {@link ValuesBucket} to be inserted into the table.
         * @param { ConflictResolution } conflict - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { long } The number of values that were inserted if the operation is successful. returns -1 otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800032 - SQLite: Abort due to constraint violation.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800034 - SQLite: Library used incorrectly.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        batchInsertWithConflictResolutionSync(table: string, values: Array<ValuesBucket>, conflict: ConflictResolution): long;
        /**
         * Updates data in the database based on a specified instance object of RdbPredicates.
         *
         * @param { ValuesBucket } values - Indicates the row of data to be updated in the database.
         * The key-value pairs are associated with column names of the database table.
         * @param { RdbPredicates } predicates -
         * Indicates the specified update condition by the instance object of  {@link RdbPredicates}.
         * @param { ConflictResolution } conflict - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { Promise<long> } The number of affected rows.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        update(values: ValuesBucket, predicates: RdbPredicates, conflict?: ConflictResolution): Promise<long>;
        /**
         * Updates data in the database based on a specified instance object of RdbPredicates with sync interface.
         *
         * @param { ValuesBucket } values - Indicates the row of data to be updated in the database.
         * The key-value pairs are associated with column names of the database table.
         * @param { RdbPredicates } predicates -
         * Indicates the specified update condition by the instance object of  {@link RdbPredicates}.
         * @param { ConflictResolution } conflict - Indicates the {@link ConflictResolution} to insert data into the table.
         * @returns { long } The number of affected rows.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        updateSync(values: ValuesBucket, predicates: RdbPredicates, conflict?: ConflictResolution): long;
        /**
         * Deletes data from the database based on a specified instance object of RdbPredicates.
         *
         * @param { RdbPredicates } predicates -
         * The specified delete condition by the instance object of {@link RdbPredicates}.
         * @returns { Promise<long> } return the number of affected rows.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        delete(predicates: RdbPredicates): Promise<long>;
        /**
         * Deletes data from the database based on a specified instance object of RdbPredicates with sync interface.
         *
         * @param { RdbPredicates } predicates -
         * The specified delete condition by the instance object of {@link RdbPredicates}.
         * @returns { long } return the number of rows deleted.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800029 - SQLite: The database is full.
         * @throws { BusinessError } 14800031 - SQLite: TEXT or BLOB exceeds size limit.
         * @throws { BusinessError } 14800033 - SQLite: Data type mismatch.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        deleteSync(predicates: RdbPredicates): long;
        /**
         * Queries data in the database based on specified conditions.
         *
         * @param { RdbPredicates } predicates -
         * The specified query condition by the instance object of {@link RdbPredicates}.
         * @param { Array<string> } columns - The columns to query. If the value is null, the query applies to all columns.
         * @returns { Promise<ResultSet> } The {@link ResultSet} object if the operation is successful.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        query(predicates: RdbPredicates, columns?: Array<string>): Promise<ResultSet>;
        /**
         * Queries data in the database based on specified conditions with sync function.
         *
         * @param { RdbPredicates } predicates -
         * The specified query condition by the instance object of {@link RdbPredicates}.
         * @param { Array<string> } columns -
         * The columns to query. If the value is empty array, the query applies to all columns.
         * @returns { ResultSet } The {@link ResultSet} object if the operation is successful.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        querySync(predicates: RdbPredicates, columns?: Array<string>): ResultSet;
        /**
         * Queries data in the database based on SQL statement.
         *
         * @param { string } sql - Indicates the SQL statement to execute.
         * @param { Array<ValueType> } args - Indicates the {@link ValueType} values of the parameters in the SQL statement.
         * The values are strings.
         * @returns { Promise<ResultSet> } The {@link ResultSet} object if the operation is successful.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 14800000 - Inner error.
         * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
         * @throws { BusinessError } 14800014 - The RdbStore or ResultSet is already closed.
         * @throws { BusinessError } 14800021 - SQLite: Generic error.
         * Possible causes: Insert failed or the updated data does not exist.
         * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
         * @throws { BusinessError } 14800024 - SQLite: The database file is locked.
         * @throws { BusinessError } 14800025 - SQLite: A table in the database is locked.
         * @throws { BusinessError } 14800026 - SQLite: The database is out of memory.
         * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
         * @throws { BusinessError } 14800047 - The WAL file size exceeds the default limit.
         * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
         * @since 20
         */
        querySql(sql: string, args?: Array<ValueType>): Promise<ResultSet>;
    }
    
    
    
    /**
     * Obtains a RDB store.
     * You can set parameters of the RDB store as required. In general, this method is recommended
     * to obtain a rdb store.
     *
     * @param { Context } context - Indicates the context of an application or ability.
     * @param { StoreConfig } config -
     * Indicates the {@link StoreConfig} configuration of the database related to this RDB store.
     * @returns { Promise<RdbStore> } Promise used to return the **RdbStore** object obtained.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 14800000 - Inner error.
     * @throws { BusinessError } 14800010 - Failed to open or delete the database by an invalid database path.
     * @throws { BusinessError } 14800011 - Failed to open the database because it is corrupted.
     * @throws { BusinessError } 14801001 - The operation is supported in the stage model only.
     * @throws { BusinessError } 14801002 - Invalid data group ID.
     * @throws { BusinessError } 14800017 - StoreConfig is changed.
     * @throws { BusinessError } 14800020 - The secret key is corrupted or lost.
     * @throws { BusinessError } 14800021 - SQLite: Generic error.
     * Possible causes: Insert failed or the updated data does not exist.
     * @throws { BusinessError } 14800022 - SQLite: Callback routine requested an abort.
     * @throws { BusinessError } 14800023 - SQLite: Access permission denied.
     * @throws { BusinessError } 14800027 - SQLite: Attempt to write a readonly database.
     * @throws { BusinessError } 14800028 - SQLite: Some kind of disk I/O error occurred.
     * @throws { BusinessError } 14800029 - SQLite: The database is full.
     * @throws { BusinessError } 14800030 - SQLite: Unable to open the database file.
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    function getRdbStore(context: Context, config: StoreConfig): Promise<RdbStore>;
    
    /**
     * Deletes the database with a specified store config.
     * When specify custom directory, this function should be called.
     *
     * @param { Context } context - Indicates the context of an application or ability.
     * @param { StoreConfig } config -
     * Indicates the {@link StoreConfig} configuration of the database related to this RDB store.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 14800000 - Inner error.
     * @throws { BusinessError } 14800010 - Failed to open or delete the database by an invalid database path.
     * @throws { BusinessError } 14801001 - The operation is supported in the stage model only.
     * @throws { BusinessError } 14801002 - Invalid data group ID.
     * @syscap SystemCapability.DistributedDataManager.RelationalStore.Core
     * @since 20
     */
    function deleteRdbStore(context: Context, config: StoreConfig): Promise<void>;
}
export default relationalStore;
