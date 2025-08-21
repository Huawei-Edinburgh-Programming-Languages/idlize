/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
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
import type { AsyncCallback } from './@ohos.base';
import Context from './application/Context';
import DataShareResultSet from './@ohos.data.DataShareResultSet';
import dataSharePredicates from './@ohos.data.dataSharePredicates';
import { ValuesBucket, ValueType } from './@ohos.data.ValuesBucket';

/**
 * This module provides the dataShare capability for consumer.
 *
 * @namespace dataShare
 * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
 * @stagemodelonly
 * @since 20
 */
declare namespace dataShare {
    /**
     * Manages create datashare helper options.
     *
     * @interface DataShareHelperOptions
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    interface DataShareHelperOptions {
        /**
         * Specifies whether the {@link DataShareHelper} in proxy mode.
         * If value is true, the {@link DataShareHelper} to be created is in proxy mode, and all operations will not open provider APP as possible
         *
         * @type { ?boolean }
         * @default false
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        isProxy?: boolean;
        /**
         * Specifies the time to wait for connecting extension, in seconds.
         *
         * @type { ?number }
         * @default 2
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        waitTime?: number;
    }
    
    /**
     * Obtains the dataShareHelper.
     *
     * @param { Context } context - Indicates the application context.
     * @param { string } uri - Indicates the path of the file to open.
     * @param { AsyncCallback<DataShareHelper> } callback - {DataShareHelper}: The dataShareHelper for consumer.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
     *         2. Incorrect parameters types.
     * @throws { BusinessError } 15700010 - The DataShareHelper fails to be initialized.
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function createDataShareHelper(context: Context, uri: string, callback: AsyncCallback<DataShareHelper>): void;
    
    /**
     * Obtains the dataShareHelper.
     *
     * @param { Context } context - Indicates the application context.
     * @param { string } uri - Indicates the path of the file to open.
     * @param { DataShareHelperOptions } options - Indicates the optional config.
     * @param { AsyncCallback<DataShareHelper> } callback - {DataShareHelper}: The dataShareHelper for consumer.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
     *         2. Incorrect parameters types.
     * @throws { BusinessError } 15700010 - The DataShareHelper fails to be initialized.
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function createDataShareHelper(context: Context, uri: string, options: DataShareHelperOptions, callback: AsyncCallback<DataShareHelper>): void;
    
    
    /**
     * Obtains the dataShareHelper.
     *
     * @param { Context } context - Indicates the application context.
     * @param { string } uri - Indicates the path of the file to open.
     * @param { DataShareHelperOptions } options - Indicates the optional config.
     * @returns { Promise<DataShareHelper> } {DataShareHelper}: The dataShareHelper for consumer.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
     *         2. Incorrect parameters types.
     * @throws { BusinessError } 15700010 - The DataShareHelper fails to be initialized.
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function createDataShareHelper(context: Context, uri: string, options?: DataShareHelperOptions): Promise<DataShareHelper>;
    
    /**
     * Enables silent access dynamically.
     *
     * @param { Context } context - Indicates the application context.
     * @param { string } uri - Indicates the uri of the data share silent proxy resource.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
     *         2. Incorrect parameters types.
     * @throws { BusinessError } 15700011 - The URI does not exist.
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function enableSilentProxy(context: Context, uri?: string): Promise<void>;
    
    /**
     * Disables silent access dynamically.
     *
     * @param { Context } context - Indicates the application context.
     * @param { string } uri - Indicates the uri of the data share silent proxy resource.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
     *         2. Incorrect parameters types.
     * @throws { BusinessError } 15700011 - The URI does not exist.
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    function disableSilentProxy(context: Context, uri?: string): Promise<void>;
    /**
     * Specifies the {@link Template} id structure.
     * A template is marked by the template id. Note that the template id is auto generated in {@link DataShareHelper#addTemplate}.
     * After {@link DataShareHelper#addTemplate}, can use the template id to direct a template.
     *
     * @interface TemplateId
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    interface TemplateId {
        /**
         * Specifies the id of subscriber, who process the callback
         * Same as subscriberId in {@link DataShareHelper#addTemplate}
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        subscriberId: string;
        /**
         * Specifies the bundleName of template owner, who create the template
         * Same as the caller's bundleName of {@link DataShareHelper#addTemplate}
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        bundleNameOfOwner: string;
    }
    /**
     * Specifies the published item structure.
     *
     * @interface PublishedItem
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    interface PublishedItem {
        /**
         * Specifies the key of the published data
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        key: string;
        /**
         * Specifies the published data
         * If the data is large, use ArrayBuffer.
         *
         * @type { string | ArrayBuffer }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        data: string | ArrayBuffer;
        /**
         * Specifies the subscriber id
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        subscriberId: string;
    }
    /**
     * Specifies the change node structure of rdb store data in callback.
     *
     * @interface RdbDataChangeNode
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    interface RdbDataChangeNode {
        /**
         * Specifies the uri of the callback.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        uri: string;
        /**
         * Specifies the templateId of the callback.
         *
         * @type { TemplateId }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        templateId: TemplateId;
        /**
         * Specifies the datas of the callback.
         * every node is a json, json's key is [key of {@link Template#predicates}
         * and value is the query result from rdb store query by value of{@link Template#predicates}].
         *
         * @type { Array<string> }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        data: Array<string>;
    }
    /**
     * Specifies the change node structure of published data in callback.
     *
     * @interface PublishedDataChangeNode
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    interface PublishedDataChangeNode {
        /**
         * Specifies the bundleName of the callback.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        bundleName: string;
        /**
         * Specifies the datas of the callback.
         *
         * @type { Array<PublishedItem> }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        data: Array<PublishedItem>;
    }
    /**
     * Specifies the template structure in subscribe.
     *
     * @interface Template
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    interface Template {
        
        /**
         * Specifies the predicates of the template.
         * When the callback in {@link DataShareHelper#on(string, Array<string>, TemplateId, AsyncCallback<ChangeNode>)}
         * is called, the predicates is used to generate data in {@link ChangeNode}. Only for rdb store data.
         *
         * @type { Record<string, string> }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        predicates: Record<string, string>;
        /**
         * Specifies the scheduler sql of the template.
         * When modify the subscribed uri's data, scheduler is auto called.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        scheduler: string;
        /**
         * Specifies the update sql of the template.
         * The update is called after the predicates execution is complete.
         *
         * @type { ?string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        update?: string;
    }
    /**
     * Specifies the operation result structure.
     *
     * @interface OperationResult
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    interface OperationResult {
        /**
         * Specifies the key of the operation result.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        key: string;
        /**
         * Specifies the operation result.
         *
         * @type { number }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        result: number;
    }
    
    /**
     * Enumerates the data change types.
     *
     * @enum { number }
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @stagemodelonly
     * @since 20
     */
    enum ChangeType {
        
        /**
         * Data inserted.
         *
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        INSERT = 0,
        
        /**
         * Data deleted.
         *
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        DELETE,
        
        /**
         * Data updated.
         *
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        UPDATE
    }
    /**
     * Enumerates the subscription types.
     *
     * @enum { number }
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    enum SubscriptionType {
        /**
         * Subscribe to the change of the data with the specified URI.
         *
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        SUBSCRIPTION_TYPE_EXACT_URI = 0
    }
    /**
     * Struct for the data change.
     *
     * @interface ChangeInfo
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    interface ChangeInfo {
        /**
         * Type of the data change.
         *
         * @type { ChangeType }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        type: ChangeType;
        /**
         * URI of the data changed.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        uri: string;
        /**
          * Data changed.
          *
          * @type { Array<ValuesBucket> }
          * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
          * @systemapi
          * @stagemodelonly
          * @since 20
          */
        values: Array<ValuesBucket>;
    }
    /**
     * Provides a DataShareHelper interface to access data.
     *
     * @interface DataShareHelper
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @systemapi
     * @stagemodelonly
     * @since 20
     */
    interface DataShareHelper {
        
        /**
         * Registers an observer to observe data specified by the given uri.
         *
         * @param { 'dataChange' } type - Type must be 'dataChange'.
         * @param { string } uri - Indicates the path of the data to operate.
         * @param { AsyncCallback<void> } callback - The callback of on.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        on(type: 'dataChange', uri: string, callback: AsyncCallback<void>): void;
        
        /**
         * Deregisters an observer used for monitoring data specified by the given uri.
         *
         * @param { 'dataChange' } type - Type must be 'dataChange'.
         * @param { string } uri - Indicates the path of the data to operate.
         * @param { AsyncCallback<void> } callback - The callback of off.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        off(type: 'dataChange', uri: string, callback?: AsyncCallback<void>): void;
        /**
         * Subscribes to the change of the data specified by the given URI.
         *
         * @param { 'dataChange' } event - Indicates the event type, which must be 'dataChange'.
         * @param { SubscriptionType } type - Indicates the subscription type, which is defined in {@link SubscriptionType}.
         * @param { string } uri - Indicates the path of the data to subscribe.
         * @param { AsyncCallback<ChangeInfo> } callback - Indicates the callback used to return the data change.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        on(event: 'dataChange', type: SubscriptionType, uri: string, callback: AsyncCallback<ChangeInfo>): void;
        /**
         * Unsubscribes from the change of the data specified by the given URI.
         *
         * @param { 'dataChange' } event - Indicates the event type, which must be 'dataChange'.
         * @param { SubscriptionType } type - Indicates the subscription type, which is defined in {@link SubscriptionType}.
         * @param { string } uri - Indicates the path of the data to unsubscribe.
         * @param { AsyncCallback<ChangeInfo> } callback - Indicates the callback to unsubscribe.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        off(event: 'dataChange', type: SubscriptionType, uri: string, callback?: AsyncCallback<ChangeInfo>): void;
        
        /**
         * Adds a template of {@link #on(string, Array<string>, TemplateId, AsyncCallback<ChangeNode>)}.
         *
         * @param { string } uri - Indicates the uri to add.
         * @param { string } subscriberId - The subscribe id to add..
         * @param { Template } template - The template to add.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700011 - The URI does not exist.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        addTemplate(uri: string, subscriberId: string, template: Template): void;
        
        /**
         * Deletes a template of {@link #on(string, Array<string>, TemplateId, AsyncCallback<ChangeNode>)}.
         *
         * @param { string } uri - Indicates the uri to delete.
         * @param { string } subscriberId - The subscribe id.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700011 - The URI does not exist.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        delTemplate(uri: string, subscriberId: string): void;
        
        /**
         * Registers observers to observe rdb data specified by the given uri and template.
         *
         * @param { 'rdbDataChange' } type - Type must be 'rdbDataChange'.
         * @param { Array<string> } uris - Indicates the paths of the data to operate.
         * @param { TemplateId } templateId - The template of on.
         * @param { AsyncCallback<RdbDataChangeNode> } callback - The callback of on.
         * @returns { Array<OperationResult> } : The operation result.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        on(type: 'rdbDataChange', uris: Array<string>, templateId: TemplateId, callback: AsyncCallback<RdbDataChangeNode>): Array<OperationResult>;
        
        /**
         * Deregisters observers used for monitoring data specified by the given uri and template.
         *
         * @param { 'rdbDataChange' } type - Type must be 'rdbDataChange'.
         * @param { Array<string> } uris - Indicates the paths of the data to operate.
         * @param { TemplateId } templateId - The template of off.
         * @param { AsyncCallback<RdbDataChangeNode> } callback - The callback of off.
         * @returns { Array<OperationResult> } : The operation result.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        off(type: 'rdbDataChange', uris: Array<string>, templateId: TemplateId, callback?: AsyncCallback<RdbDataChangeNode>): Array<OperationResult>;
        
        /**
         * Registers observers to observe published data specified by the given key and subscriberId.
         *
         * @param { 'publishedDataChange' } type - Type must be 'publishedDataChange'.
         * @param { Array<string> } uris - Indicates the uris of the data to operate.
         * @param { string } subscriberId - The subscriberId of on.
         * @param { AsyncCallback<PublishedDataChangeNode> } callback - The callback of on.
         * @returns { Array<OperationResult> } : The operation result.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        on(type: 'publishedDataChange', uris: Array<string>, subscriberId: string, callback: AsyncCallback<PublishedDataChangeNode>): Array<OperationResult>;
        
        /**
         * Deregisters observers used for monitoring data specified by the given key and subscriberId.
         *
         * @param { 'publishedDataChange' } type - Type must be 'publishedDataChange'.
         * @param { Array<string> } uris - Indicates the uris of the data to operate.
         * @param { string } subscriberId - The subscriberId of off.
         * @param { AsyncCallback<PublishedDataChangeNode> } callback - The callback of off.
         * @returns { Array<OperationResult> } : The operation result.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        off(type: 'publishedDataChange', uris: Array<string>, subscriberId: string, callback?: AsyncCallback<PublishedDataChangeNode>): Array<OperationResult>;
        
        /**
         * Update a single data into host data area.
         *
         * @param { Array<PublishedItem> } data - Indicates the data to publish.
         * @param { string } bundleName - Indicates the bundleName of data to publish.
         * @param { number } version - Indicates the version of data to publish, larger is newer.
         * @param { AsyncCallback<Array<OperationResult>> } callback
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700012 - The data area does not exist.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        publish(data: Array<PublishedItem>, bundleName: string, version: number, callback: AsyncCallback<Array<OperationResult>>): void;
        
        /**
         * Update a single data into host data area.
         *
         * @param { Array<PublishedItem> } data - Indicates the data to publish.
         * @param { string } bundleName - Indicates the bundleName of data to publish.
         * @param { AsyncCallback<Array<OperationResult>> } callback
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700012 - The data area does not exist.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        publish(data: Array<PublishedItem>, bundleName: string, callback: AsyncCallback<Array<OperationResult>>): void;
        
        /**
         * Update a single data into host data area.
         *
         * @param { Array<PublishedItem> } data - Indicates the data to publish.
         * @param { string } bundleName - Indicates the bundleName of data to publish.
         * @param { number } version - Indicates the version of data to publish, larger is newer.
         * @returns { Promise<Array<OperationResult>> }
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700012 - The data area does not exist.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        publish(data: Array<PublishedItem>, bundleName: string, version?: number): Promise<Array<OperationResult>>;
        
        /**
         * Inserts a single data record into the database.
         *
         * @param { string } uri - Indicates the path of the data to operate.
         * @param { ValuesBucket } value - Indicates the data record to insert. If this parameter is null,
         * a blank row will be inserted.
         * @param { AsyncCallback<number> } callback - {number}: the index of the inserted data record.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        insert(uri: string, value: ValuesBucket, callback: AsyncCallback<number>): void;
        
        /**
         * Inserts a single data record into the database.
         *
         * @param { string } uri - Indicates the path of the data to operate.
         * @param { ValuesBucket } value - Indicates the data record to insert. If this parameter is null,
         * a blank row will be inserted.
         * @returns { Promise<number> } {number}: the index of the inserted data record.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        insert(uri: string, value: ValuesBucket): Promise<number>;
        
        /**
         * Deletes one or more data records from the database.
         *
         * @param { string } uri - Indicates the path of the data to operate.
         * @param { dataSharePredicates.DataSharePredicates } predicates - Indicates filter criteria.
         * You should define the processing logic when this parameter is null.
         * @param { AsyncCallback<number> } callback - {number}: the number of data records deleted.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        delete(uri: string, predicates: dataSharePredicates.DataSharePredicates, callback: AsyncCallback<number>): void;
        
        /**
         * Deletes one or more data records from the database.
         *
         * @param { string } uri - Indicates the path of the data to operate.
         * @param { dataSharePredicates.DataSharePredicates } predicates - Indicates filter criteria.
         * You should define the processing logic when this parameter is null.
         * @returns { Promise<number> } {number}: the number of data records deleted.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        delete(uri: string, predicates: dataSharePredicates.DataSharePredicates): Promise<number>;
        
        /**
         * Queries data in the database.
         *
         * @param { string } uri - Indicates the path of data to query.
         * @param { dataSharePredicates.DataSharePredicates } predicates - Indicates filter criteria.
         * You should define the processing logic when this parameter is null.
         * @param { Array<string> } columns - Indicates the columns to query.
         * If this parameter is null, all columns are queried.
         * @param { AsyncCallback<DataShareResultSet> } callback - {DataShareResultSet}: the query result.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        query(uri: string, predicates: dataSharePredicates.DataSharePredicates, columns: Array<string>, callback: AsyncCallback<DataShareResultSet>): void;
        
        /**
         * Queries data in the database.
         *
         * @param { string } uri - Indicates the path of data to query.
         * @param { dataSharePredicates.DataSharePredicates } predicates - Indicates filter criteria.
         * You should define the processing logic when this parameter is null.
         * @param { Array<string> } columns - Indicates the columns to query.
         * If this parameter is null, all columns are queried.
         * @returns { Promise<DataShareResultSet> } {DataShareResultSet}: the query result.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        query(uri: string, predicates: dataSharePredicates.DataSharePredicates, columns: Array<string>): Promise<DataShareResultSet>;
        
        /**
         * Updates data records in the database.
         *
         * @param { string } uri - Indicates the path of data to update.
         * @param { dataSharePredicates.DataSharePredicates } predicates - Indicates filter criteria.
         * You should define the processing logic when this parameter is null.
         * @param { ValuesBucket } value - Indicates the data to update. This parameter can be null.
         * @param { AsyncCallback<number> } callback - {number}: the number of data records updated.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        update(uri: string, predicates: dataSharePredicates.DataSharePredicates, value: ValuesBucket, callback: AsyncCallback<number>): void;
        
        /**
         * Updates data records in the database.
         *
         * @param { string } uri - Indicates the path of data to update.
         * @param { dataSharePredicates.DataSharePredicates } predicates - Indicates filter criteria.
         * You should define the processing logic when this parameter is null.
         * @param { ValuesBucket } value - Indicates the data to update. This parameter can be null.
         * @returns { Promise<number> } {number}: the number of data records updated.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        update(uri: string, predicates: dataSharePredicates.DataSharePredicates, value: ValuesBucket): Promise<number>;
        
        /**
         * Inserts multiple data records into the database.
         *
         * @param { string } uri - Indicates the path of the data to operate.
         * @param { Array<ValuesBucket> } values - Indicates the data records to insert.
         * @param { AsyncCallback<number> } callback - {number}: the number of data records inserted.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        batchInsert(uri: string, values: Array<ValuesBucket>, callback: AsyncCallback<number>): void;
        
        /**
         * Inserts multiple data records into the database.
         *
         * @param { string } uri - Indicates the path of the data to operate.
         * @param { Array<ValuesBucket> } values - Indicates the data records to insert.
         * @returns { Promise<number> } {number}: the number of data records inserted.
         * @throws { BusinessError } 401 - Parameter error.Possible causes: 1. Mandatory parameters are left unspecified;
         *         2. Incorrect parameters types.
         * @throws { BusinessError } 15700013 - The DataShareHelper instance is already closed.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        batchInsert(uri: string, values: Array<ValuesBucket>): Promise<number>;
        
        /**
         * Close the connection between datashare and extension.
         *
         * @returns { Promise<void> } The promise returned by the function.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 15700000 - Inner error. Possible causes: 1.The internal status is abnormal;
         *         2.The interface is incorrectly used; 3.Permission configuration error; 4.A system error.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @systemapi
         * @stagemodelonly
         * @since 20
         */
        close(): Promise<void>;
    }
    /**
     * Obtains the data proxy handle, which can be used to subscribe, publish, and access globally shared data.
     *
     * @returns { Promise<DataProxyHandle> } Handle used for the data proxy operations.
     * @throws { BusinessError } 15700000 - Inner error. Possible causes: The service is not ready or is being
     *     restarted abnormally.
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @stagemodelonly
     * @since 20
     */
    function createDataProxyHandle(): Promise<DataProxyHandle>;
    /**
     * Specifies the proxy data structure.
     *
     * @interface ProxyData
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @stagemodelonly
     * @since 20
     */
    interface ProxyData {
        /**
         * URI for proxy data that uniquely identifies a proxy data item. Maximum length 256 bytes.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        uri: string;
        /**
         * Value of the proxy data. Maximum length 4096 bytes.
         * When the proxy data is first published, if it is not filled in, it is set to an empty string by default.
         * When updating the proxy data, if it is not filled in, the value of the proxy data is not updated.
         *
         * @type { ?ValueType }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        value?: ValueType;
        /**
         * List of applications that are allowed to subscribe and read proxy data. The maximum length of the list is 256.
         * Uses appId to represent the allowed application.
         * When the proxy data is first published, if it is not filled in, it defaults to an empty array.
         * When updating the proxy data, if it is not filled in, the allowList of the proxy data is not updated.
         * An empty allowList array indicates that only the publisher can access the data.
         *
         * @type { ?string[] }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        allowList?: string[];
    }
    /**
     * Structure that describes the info of the proxy data changed.
     *
     * @interface DataProxyChangeInfo
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @stagemodelonly
     * @since 20
     */
    interface DataProxyChangeInfo {
        /**
         * Type of the data changed.
         *
         * @type { ChangeType }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        type: ChangeType;
        /**
         * URI of the data changed.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        uri: string;
        /**
         * Value of the data changed.
         *
         * @type { ValueType }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        value: ValueType;
    }
    /**
     * Enumeration of data proxy operation error codes.
     *
     * @enum { number } DataProxyErrorCode
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @stagemodelonly
     * @since 20
     */
    enum DataProxyErrorCode {
        /**
         * Operation successful.
         *
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        SUCCESS = 0,
        /**
         * URI format is incorrect or does not exist.
         *
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        URI_NOT_EXIST = 1,
        /**
         * Do not have permission to perform this operation on this URI.
         *
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        NO_PERMISSION = 2,
        /**
         * Exceeds the upper limit of the number of data records.
         *
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        OVER_LIMIT = 3
    }
    /**
     * Structure that indicates the result of a single data proxy operation.
     *
     * @interface DataProxyResult
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @stagemodelonly
     * @since 20
     */
    interface DataProxyResult {
        /**
         * URI of the data being operated on.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        uri: string;
        /**
         * Error code of the operation result.
         * @type { DataProxyErrorCode }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        result: DataProxyErrorCode;
    }
    /**
     * Structure that indicates the result of a single getting operation.
     *
     * @interface DataProxyGetResult
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @stagemodelonly
     * @since 20
     */
    interface DataProxyGetResult {
        /**
         * URI of the data being operated on.
         *
         * @type { string }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        uri: string;
        /**
         * Error code of the operation result.
         *
         * @type { DataProxyErrorCode }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        result: DataProxyErrorCode;
        /**
         * If the getting operation is successful, it is the value of the proxy data,
         * if the getting operation is failed, it is undefined.
         *
         * @type { ValueType | undefined }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        value: ValueType | undefined;
        /**
         * If the getting operation is successful, it is the allowList of the proxy data,
         * if the getting operation is failed, it is undefined.
         * Only the publisher can obtain the allowList. Other applications can only obtain the value.
         *
         * @type { string[] | undefined}
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        allowList: string[] | undefined;
    }
    /**
     * Enumeration of data proxy types.
     *
     * @enum { number } DataProxyType
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @stagemodelonly
     * @since 20
     */
    enum DataProxyType {
        /**
         * Indicates shared configuration between applications.
         *
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        SHARED_CONFIG = 0
    }
    /**
     * Structure that indicates the configuration for data proxy operation.
     *
     * @interface DataProxyConfig
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @stagemodelonly
     * @since 20
     */
    interface DataProxyConfig {
        /**
         * Type of the data proxy operation.
         *
         * @type { DataProxyType }
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        type: DataProxyType;
    }
    /**
     * Handle for data proxy operations.
     *
     * @interface DataProxyHandle
     * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
     * @stagemodelonly
     * @since 20
     */
    interface DataProxyHandle {
        /**
         * Registers observers to observe proxy data change specified by the given URIs.
         *
         * @param { 'dataChange' } event - Event type must be 'sharedDataChange'.
         * @param { string[] } uris - Indicates the uris of the data to operate.
         * @param { DataProxyConfig } config - Indicates the configuration of the data proxy operation.
         * @param { AsyncCallback<DataProxyChangeInfo[]> } callback - The callback function when data changes.
         * @returns { DataProxyResult[] } : The operation result.
         * @throws { BusinessError } 15700000 - Inner error. Possible causes: The service is not ready or is being
         *     restarted abnormally.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        on(event: 'dataChange', uris: string[], config: DataProxyConfig, callback: AsyncCallback<DataProxyChangeInfo[]>): DataProxyResult[];
        /**
         * Deregisters observers to observe proxy data change specified by the given URIs.
         *
         * @param { 'dataChange' } event - Event type must be 'sharedDataChange'.
         * @param { string[] } uris - Indicates the uris of the data to operate.
         * @param { DataProxyConfig } config - Indicates the configuration of the data proxy operation.
         * @param { AsyncCallback<DataProxyChangeInfo[]> } callback - The callback function when data changes.
         * @returns { DataProxyResult[] } : The operation result.
         * @throws { BusinessError } 15700000 - Inner error. Possible causes: The service is not ready or is being
         *     restarted abnormally.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        off(event: 'dataChange', uris: string[], config: DataProxyConfig, callback?: AsyncCallback<DataProxyChangeInfo[]>): DataProxyResult[];
        /**
         * Publishes proxy data. The data that is published can be accessed by the publisher and the applications
         * specified in the allowList.
         * If the URI being published already exists, update the corresponding data.
         * Only the publisher is allowed to update the data.
         *
         * @param { ProxyData[] } data - Indicates the data to create or update.
         * @param { DataProxyConfig } config - Indicates the configuration of the data proxy operation.
         * @returns { Promise<DataProxyResult[]> } : The operation result.
         * @throws { BusinessError } 15700000 - Inner error. Possible causes: The service is not ready or is being
         *     restarted abnormally.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        publish(data: ProxyData[], config: DataProxyConfig): Promise<DataProxyResult[]>;
        /**
         * Deletes the proxy data specified by the URIs.
         * Only the data publisher can delete the data.
         *
         * @param { string[] } uris - Indicates the uris of data to delete.
         * @param { DataProxyConfig } config - Indicates the configuration of the data proxy operation.
         * @returns { Promise<DataProxyResult[]> } : The operation result.
         * @throws { BusinessError } 15700000 - Inner error. Possible causes: The service is not ready or is being
         *     restarted abnormally.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        delete(uris: string[], config: DataProxyConfig): Promise<DataProxyResult[]>;
        /**
         * Gets published data specified by the URIs.
         * Only the publisher itself and applications in the allowList can get the data.
         *
         * @param { string[] } uris - Indicates the uris of data to get.
         * @param { DataProxyConfig } config - Indicates the configuration of the data proxy operation.
         * @returns { Promise<DataProxyGetResult[]> } : The operation result.
         * @throws { BusinessError } 15700000 - Inner error. Possible causes: The service is not ready or is being
         *     restarted abnormally.
         * @syscap SystemCapability.DistributedDataManager.DataShare.Consumer
         * @stagemodelonly
         * @since 20
         */
        get(uris: string[], config: DataProxyConfig): Promise<DataProxyGetResult[]>;
    }
}
export default dataShare;
