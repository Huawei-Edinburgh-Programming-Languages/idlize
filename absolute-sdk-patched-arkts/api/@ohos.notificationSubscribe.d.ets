/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License"),
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
 * @kit NotificationKit
 */
import { AsyncCallback } from './@ohos.base';
import { BundleOption as _BundleOption } from './notification/NotificationCommonDef';
import { NotificationSubscribeInfo as _NotificationSubscribeInfo } from './notification/notificationSubscribeInfo';
import { NotificationSubscriber as _NotificationSubscriber } from './notification/notificationSubscriber';
import { SubscribeCallbackData as _SubscribeCallbackData } from './notification/notificationSubscriber';
import { EnabledNotificationCallbackData as _EnabledNotificationCallbackData } from './notification/notificationSubscriber';
import { BadgeNumberCallbackData as _BadgeNumberCallbackData } from './notification/notificationSubscriber';
/**
 * @namespace notificationSubscribe
 * @syscap SystemCapability.Notification.Notification
 * @systemapi
 * @since 20
 */
declare namespace notificationSubscribe {
    /**
     * Describes a NotificationKey, which can be used to identify a notification.
     *
     * @typedef NotificationKey
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export interface NotificationKey {
        /**
         * Notify ID.
         *
         * @type { int }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        id: int;
        /**
         * Notification label.
         *
         * @type { ?string }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        label?: string;
    }
    /**
     * Reason for remove a notification
     *
     * @enum { int }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export enum RemoveReason {
        /**
         * Notification clicked notification on the status bar
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        CLICK_REASON_REMOVE = 1,
        /**
         * User dismissal notification  on the status bar
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        CANCEL_REASON_REMOVE = 2
    }
    /**
     * Subscribe to notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { NotificationSubscriber } subscriber - The notification subscriber.
     * @param { AsyncCallback<void> } callback - The callback of subscribe.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function subscribe(subscriber: NotificationSubscriber, callback: AsyncCallback<void>): void;
    /**
     * Subscribe self notifications.
     *
     * @param { NotificationSubscriber } subscriber - The notification subscriber.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function subscribeSelf(subscriber: NotificationSubscriber): Promise<void>;
    /**
     * Subscribe to notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { NotificationSubscriber } subscriber - The notification subscriber.
     * @param { NotificationSubscribeInfo } info - The notification subscribe info.
     * @param { AsyncCallback<void> } callback - The callback of subscribe.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function subscribe(subscriber: NotificationSubscriber, info: NotificationSubscribeInfo, callback: AsyncCallback<void>): void;
    /**
     * Subscribe to notifications
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { NotificationSubscriber } subscriber - The notification subscriber.
     * @param { NotificationSubscribeInfo } [info] - The notification subscribe info.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function subscribe(subscriber: NotificationSubscriber, info?: NotificationSubscribeInfo): Promise<void>;
    /**
     * Unsubscribe notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { NotificationSubscriber } subscriber - The notification subscriber.
     * @param { AsyncCallback<void> } callback - The callback of unsubscribe.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function unsubscribe(subscriber: NotificationSubscriber, callback: AsyncCallback<void>): void;
    /**
     * Unsubscribe notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { NotificationSubscriber } subscriber - The notification subscriber.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function unsubscribe(subscriber: NotificationSubscriber): Promise<void>;
    /**
     * Remove notification based on BundleOption and NotificationKey.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { NotificationKey } notificationKey - The notification key.
     * @param { RemoveReason } reason - The remove reason.
     * @param { AsyncCallback<void> } callback - The callback of remove.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function remove(bundle: BundleOption, notificationKey: NotificationKey, reason: RemoveReason, callback: AsyncCallback<void>): void;
    /**
     * Remove notification based on BundleOption and NotificationKey.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { NotificationKey } notificationKey - The notification key.
     * @param { RemoveReason } reason - The remove reason.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function remove(bundle: BundleOption, notificationKey: NotificationKey, reason: RemoveReason): Promise<void>;
    /**
     * Remove notification based on hashCode.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { string } hashCode - The hashCode.
     * @param { RemoveReason } reason - The remove reason.
     * @param { AsyncCallback<void> } callback - The callback of remove.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function remove(hashCode: string, reason: RemoveReason, callback: AsyncCallback<void>): void;
    /**
     * Remove notifications based on hashCodes.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { Array<String> } hashCodes - The hashCode array.
     * @param { RemoveReason } reason - The remove reason.
     * @param { AsyncCallback<void> } callback - The callback of remove.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function remove(hashCodes: Array<String>, reason: RemoveReason, callback: AsyncCallback<void>): void;
    /**
     * Remove notification based on hashCode.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { string } hashCode - The hashCode.
     * @param { RemoveReason } reason - The remove reason.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function remove(hashCode: string, reason: RemoveReason): Promise<void>;
    /**
     * Remove notifications based on hashCodes.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { Array<String> } hashCodes - The hashCode array.
     * @param { RemoveReason } reason - The remove reason.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function remove(hashCodes: Array<String>, reason: RemoveReason): Promise<void>;
    /**
     * RemoveAll all notifications based on BundleOption.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { AsyncCallback<void> } callback - The callback of removeAll.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function removeAll(bundle: BundleOption, callback: AsyncCallback<void>): void;
    /**
     * RemoveAll all notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { AsyncCallback<void> } callback - The callback of removeAll.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function removeAll(callback: AsyncCallback<void>): void;
    /**
     * Remove all notifications under the specified user.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { int } userId - The userId.
     * @param { AsyncCallback<void> } callback - The callback of removeAll.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function removeAll(userId: int, callback: AsyncCallback<void>): void;
    /**
     * Remove all notifications under the specified user.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { int } userId - The userId.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function removeAll(userId: int): Promise<void>;
    /**
     * RemoveAll all notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } [bundle] - The bundle option.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function removeAll(bundle?: BundleOption): Promise<void>;
    /**
    * Trigger notification cross-device operation.
    *
    * @permission ohos.permission.NOTIFICATION_CONTROLLER
    * @param { string } [hashcode] - The notification identifier.
    * @param { OperationInfo } [operationInfo] - The interactive information.
    * @returns { Promise<void> } The promise returned by the function.
    * @throws { BusinessError } 201 - Permission denied.
    * @throws { BusinessError } 202 - Not system application to call the interface.
    * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
    * <br>2. Incorrect parameter types. 3. Parameter verification failed.
    * @throws { BusinessError } 1600010 - Distributed operation failed.
    * @throws { BusinessError } 1600021 - Distributed operation timed out.
    * @syscap SystemCapability.Notification.Notification
    * @systemapi
    * @since 20
    */
    function distributeOperation(hashcode: string, operationInfo?: OperationInfo): Promise<void>;
    /**
     * Information on cross-device notification interactions
     *
     * @typedef OperationInfo
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export interface OperationInfo {
        /**
         * action button name
         *
         * @type { ?string }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        actionName?: string;
        /**
         * user input.
         *
         * @type { ?string }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        userInput?: string;
        /**
         * action operation type
         *
         * @type { ?number }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        operationType?: number;
        /**
         * action button index
         *
         * @type { ?number }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        buttonIndex?: number;
    }
    /**
     * Describes a bundleOption in a notification.
     *
     * @typedef { _BundleOption } BundleOption
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type BundleOption = _BundleOption;
    /**
     * Sets filter criteria of publishers for subscribing to desired notifications.
     *
     * @typedef { _NotificationSubscribeInfo } NotificationSubscribeInfo
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type NotificationSubscribeInfo = _NotificationSubscribeInfo;
    /**
     * Provides methods that will be called back when the subscriber receives a new notification or
     * a notification is canceled.
     *
     * @typedef { _NotificationSubscriber } NotificationSubscriber
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type NotificationSubscriber = _NotificationSubscriber;
    /**
     * Provides methods that will be called back when the subscriber receives a new notification or
     * a notification is canceled.
     *
     * @typedef { _SubscribeCallbackData } SubscribeCallbackData
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type SubscribeCallbackData = _SubscribeCallbackData;
    /**
     * Describes the properties of the application that the permission to send notifications has changed.
     *
     * @typedef { _EnabledNotificationCallbackData } EnabledNotificationCallbackData
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type EnabledNotificationCallbackData = _EnabledNotificationCallbackData;
    /**
     * Describes the badge number of the application has changed.
     *
     * @typedef { _BadgeNumberCallbackData } BadgeNumberCallbackData
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type BadgeNumberCallbackData = _BadgeNumberCallbackData;
}
export default notificationSubscribe;
