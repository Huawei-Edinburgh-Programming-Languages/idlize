/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
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
 * @kit ArkData
 */
import { AsyncCallback } from './@ohos.base';
import ExtensionContext from './application/ExtensionContext';
import Want from './@ohos.app.ability.Want';
import dataSharePredicates from './@ohos.data.dataSharePredicates';
import { ValuesBucket } from './@ohos.data.ValuesBucket';
import dataShare from './@ohos.data.dataShare';
/**
 * This module provides data sharing and expansion capabilities.
 *
 * @syscap SystemCapability.DistributedDataManager.DataShare.Provider
 * @systemapi
 * @StageModelOnly
 * @since 20
 */
export default class DataShareExtensionAbility {
    /**
     * Indicates datashare extension ability context.
     *
     * @type { ExtensionContext }
     * @syscap SystemCapability.DistributedDataManager.DataShare.Provider
     * @systemapi
     * @StageModelOnly
     * @since 20
     */
    context: ExtensionContext;
    /**
     * Called back when a datashare extension ability is started for initialization.
     *
     * @param { Want } want - Indicates connection information about the datashare extension ability.
     * @param { AsyncCallback<void> } callback - callback function, no return value.
     * @syscap SystemCapability.DistributedDataManager.DataShare.Provider
     * @systemapi
     * @StageModelOnly
     * @since 20
     */
    onCreate?(want: Want, callback: AsyncCallback<void>): void;
    /**
     * Updates one or more data records in the database. This method should be implemented by a data share.
     *
     * @param { string } uri - Indicates the database table storing the data to update.
     * @param { dataSharePredicates.DataSharePredicates } predicates - Indicates filter criteria. If this parameter is
     *                                                               null, all data records will be updated by default.
     * @param { ValuesBucket } valueBucket - Indicates the data to update. This parameter can be null.
     * @param { AsyncCallback<number> } callback - Returns the number of data records updated.
     * @syscap SystemCapability.DistributedDataManager.DataShare.Provider
     * @systemapi
     * @StageModelOnly
     * @since 20
     */
    update?(uri: string, predicates: dataSharePredicates.DataSharePredicates, valueBucket: ValuesBucket, callback: AsyncCallback<number>): void;
    /**
     * Deletes one or more data records. This method should be implemented by a data share.
     *
     * @param { string } uri - Indicates the database table storing the data to delete.
     * @param { dataSharePredicates.DataSharePredicates } predicates - Indicates filter criteria. If this parameter is
     *                                                                 null, all data records will be deleted by default.
     * @param { AsyncCallback<number> } callback - Returns the number of data records deleted.
     * @syscap SystemCapability.DistributedDataManager.DataShare.Provider
     * @systemapi
     * @StageModelOnly
     * @since 20
     */
    delete?(uri: string, predicates: dataSharePredicates.DataSharePredicates, callback: AsyncCallback<number>): void;
    /**
     * Queries one or more data records in the database. This method should be implemented by a data share.
     * Only RDB and distributed KVDB resultsets are supported. The current version does not support custom resultsets.
     *
     * @param { string } uri - Indicates the database table storing the data to query.
     * @param { dataSharePredicates.DataSharePredicates } predicates - Indicates filter criteria. If this parameter is
     *                                                                 null, all data records will be queried by default.
     * @param { Array<string> } columns - Indicates the columns to be queried, in array, for example, {"name","age"}.
     *                                    You should define the processing logic when this parameter is null.
     * @param { AsyncCallback<Object> } callback - Returns the queried data, only support result set of rdb or kvstore.
     * @syscap SystemCapability.DistributedDataManager.DataShare.Provider
     * @systemapi
     * @StageModelOnly
     * @since 20
     */
    query?(uri: string, predicates: dataSharePredicates.DataSharePredicates, columns: Array<string>, callback: AsyncCallback<Object>): void;
    /**
     * Inserts multiple data records into the database. This method should be implemented by a data share.
     *
     * @param { string } uri - Indicates the position where the data is to insert.
     * @param { Array<ValuesBucket> } valueBuckets - Indicates the data to insert.
     * @param { AsyncCallback<number> } callback - Returns the number of data records inserted.
     * @syscap SystemCapability.DistributedDataManager.DataShare.Provider
     * @systemapi
     * @StageModelOnly
     * @since 20
     */
    batchInsert?(uri: string, valueBuckets: Array<ValuesBucket>, callback: AsyncCallback<number>): void;
}
