/*
 * Copyright (c) 2022-2024 Huawei Device Co., Ltd.
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
import { BundleOption as _BundleOption } from './notification/NotificationCommonDef';
import { NotificationActionButton as _NotificationActionButton } from './notification/notificationActionButton';
import { NotificationBasicContent as _NotificationBasicContent } from './notification/notificationContent';
import { NotificationContent as _NotificationContent } from './notification/notificationContent';
import { NotificationLongTextContent as _NotificationLongTextContent } from './notification/notificationContent';
import { NotificationMultiLineContent as _NotificationMultiLineContent } from './notification/notificationContent';
import { NotificationPictureContent as _NotificationPictureContent } from './notification/notificationContent';
import { NotificationSystemLiveViewContent as _NotificationSystemLiveViewContent } from './notification/notificationContent';
import { NotificationCapsule as _NotificationCapsule } from './notification/notificationContent';
import { NotificationButton as _NotificationButton } from './notification/notificationContent';
import { NotificationTime as _NotificationTime } from './notification/notificationContent';
import { NotificationProgress as _NotificationProgress } from './notification/notificationContent';
import { NotificationFlags as _NotificationFlags } from './notification/notificationFlags';
import { NotificationFlagStatus as _NotificationFlagStatus } from './notification/notificationFlags';
import { NotificationRequest as _NotificationRequest } from './notification/notificationRequest';
import { UnifiedGroupInfo as _UnifiedGroupInfo } from './notification/notificationRequest';
import { DistributedOptions as _DistributedOptions } from './notification/notificationRequest';
import { NotificationSlot as _NotificationSlot } from './notification/notificationSlot';
import { NotificationSorting as _NotificationSorting } from './notification/notificationSorting';
import { NotificationTemplate as _NotificationTemplate } from './notification/notificationTemplate';
import { NotificationUserInput as _NotificationUserInput } from './notification/notificationUserInput';
import { AsyncCallback } from '@ohos.base';
import { NotificationLiveViewContent as _NotificationLiveViewContent } from './notification/notificationContent';
import { LiveViewStatus as _LiveViewStatus } from './notification/notificationContent';
import { LiveViewTypes as _LiveViewTypes } from './notification/notificationContent';
import { NotificationFilter as _NotificationFilter } from './notification/notificationRequest';
import { NotificationCheckRequest as _NotificationCheckRequest } from './notification/notificationRequest';
import type UIAbilityContext from './application/UIAbilityContext';

/**
 * The NotificationManager module provides notification management capabilities, covering notifications,
 * notification slots, notification enabled status, and notification badge status.
 *
 * @namespace notificationManager
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
declare namespace notificationManager {
    
    
    /**
     * Publish a notification. This API uses an asynchronous callback to return the result.
     * If the ID and label of the new notification are the same as that of the previous notification, the new one replaces the previous one.
     *
     * @param { NotificationRequest } request - Content and related configuration of the notification to publish.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful, err is undefined;
     *                                           otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600004 - Notification disabled.
     * @throws { BusinessError } 1600005 - Notification slot disabled.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 1600009 - The notification sending frequency reaches the upper limit.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 1600014 - No permission.
     * @throws { BusinessError } 1600015 - The current notification status does not support duplicate configurations.
     * @throws { BusinessError } 1600016 - The notification version for this update is too low.
     * @throws { BusinessError } 1600020 - The application is not allowed to send notifications due to permission settings.
     * @throws { BusinessError } 2300007 - Network unreachable.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function publish(request: NotificationRequest, callback: AsyncCallback<void>): void;
    
    
    /**
     * Publish a notification. This API uses a promise to return the URI of the file in the destination directory.
     * If the ID and label of the new notification are the same as that of the previous notification, the new one replaces the previous one.
     *
     * @param { NotificationRequest } request - Content and related configuration of the notification to publish.
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600004 - Notification disabled.
     * @throws { BusinessError } 1600005 - Notification slot disabled.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 1600009 - The notification sending frequency reaches the upper limit.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 1600014 - No permission.
     * @throws { BusinessError } 1600015 - The current notification status does not support duplicate configurations.
     * @throws { BusinessError } 1600016 - The notification version for this update is too low.
     * @throws { BusinessError } 1600020 - The application is not allowed to send notifications due to permission settings.
     * @throws { BusinessError } 2300007 - Network unreachable.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function publish(request: NotificationRequest): Promise<void>;
    
    
    /**
     * Publishes a notification to the specified user.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER or ohos.permission.SEND_NOTIFICATION_CROSS_USER
     * @param { NotificationRequest } request - a notification.
     * @param { int } userId - of subscriber receiving the notification.
     * @param { AsyncCallback<void> } callback - The callback of publish.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600004 - Notification disabled.
     * @throws { BusinessError } 1600005 - Notification slot disabled.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 1600009 - The notification sending frequency reaches the upper limit.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 1600014 - No permission.
     * @throws { BusinessError } 1600015 - The current notification status does not support duplicate configurations.
     * @throws { BusinessError } 1600016 - The notification version for this update is too low.
     * @throws { BusinessError } 1600020 - The application is not allowed to send notifications due to permission settings.
     * @throws { BusinessError } 2300007 - Network unreachable.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function publish(request: NotificationRequest, userId: int, callback: AsyncCallback<void>): void;
    
    
    /**
     * Publishes a notification to the specified user.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER or ohos.permission.SEND_NOTIFICATION_CROSS_USER
     * @param { NotificationRequest } request - a notification.
     * @param { int } userId - of subscriber receiving the notification.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600004 - Notification disabled.
     * @throws { BusinessError } 1600005 - Notification slot disabled.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 1600009 - The notification sending frequency reaches the upper limit.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 1600014 - No permission.
     * @throws { BusinessError } 1600015 - The current notification status does not support duplicate configurations.
     * @throws { BusinessError } 1600016 - The notification version for this update is too low.
     * @throws { BusinessError } 1600020 - The application is not allowed to send notifications due to permission settings.
     * @throws { BusinessError } 2300007 - Network unreachable.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function publish(request: NotificationRequest, userId: int): Promise<void>;
    /**
     * Publishes a representative notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
     * @param { NotificationRequest } request - a notification.
     * @param { string } representativeBundle - bundle name of the representative
     * @param { int } userId - userid of the representative
     * @param { AsyncCallback<void> } callback - The callback of publishAsBundle.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600004 - Notification disabled.
     * @throws { BusinessError } 1600005 - Notification slot disabled.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 1600009 - The notification sending frequency reaches the upper limit.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 1600015 - The current notification status does not support duplicate configurations.
     * @throws { BusinessError } 1600016 - The notification version for this update is too low.
     * @throws { BusinessError } 1600020 - The application is not allowed to send notifications due to permission settings.
     * @throws { BusinessError } 2300007 - Network unreachable.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function publishAsBundle(request: NotificationRequest, representativeBundle: string, userId: int, callback: AsyncCallback<void>): void;
    /**
     * Publishes a representative notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
     * @param { NotificationRequest } request - a notification.
     * @param { string } representativeBundle - bundle name of the representative
     * @param { int } userId - userid of the representative
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600004 - Notification disabled.
     * @throws { BusinessError } 1600005 - Notification slot disabled.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 1600009 - The notification sending frequency reaches the upper limit.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 1600015 - The current notification status does not support duplicate configurations.
     * @throws { BusinessError } 1600016 - The notification version for this update is too low.
     * @throws { BusinessError } 1600020 - The application is not allowed to send notifications due to permission settings.
     * @throws { BusinessError } 2300007 - Network unreachable.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function publishAsBundle(request: NotificationRequest, representativeBundle: string, userId: int): Promise<void>;
    /**
     * Publishes a representative notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
     * @param { BundleOption } representativeBundle - bundle option of the representative.
     * @param { NotificationRequest } request - a notification.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600004 - Notification disabled.
     * @throws { BusinessError } 1600005 - Notification slot disabled.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 1600009 - The notification sending frequency reaches the upper limit.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 1600015 - The current notification status does not support duplicate configurations.
     * @throws { BusinessError } 1600016 - The notification version for this update is too low.
     * @throws { BusinessError } 1600020 - The application is not allowed to send notifications due to permission settings.
     * @throws { BusinessError } 2300007 - Network unreachable.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function publishAsBundle(representativeBundle: BundleOption, request: NotificationRequest): Promise<void>;
    
    /**
     * Cancels a notification with the specified ID. This API uses an asynchronous callback to return the result.
     *
     * @param { int } id - Notification ID.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful, err is undefined;
     *                                           otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function cancel(id: int, callback: AsyncCallback<void>): void;
    /**
     * Cancels a notification with the specified ID and label. This API uses an asynchronous callback to return the result.
     *
     * @param { int } id - Notification ID.
     * @param { string } label - Notification label.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful, err is undefined;
     *                                           otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function cancel(id: int, label: string, callback: AsyncCallback<void>): void;
    /**
     * Cancels a notification with the specified ID and optional label. This API uses a promise to return the result.
     *
     * @param { int } id - Notification ID.
     * @param { string } [label] - Notification label. This parameter is left empty by default.
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function cancel(id: int, label?: string): Promise<void>;
    /**
     * Cancel a notification with the representative and ID.
     *
     * @param { BundleOption } representativeBundle - bundle option of the representative.
     * @param { int } id - ID of the notification to cancel, which must be unique in the application.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 1600017 - There is no corresponding agent relationship configuration.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function cancel(representativeBundle: BundleOption, id: int): Promise<void>;
    /**
     * Cancel a representative notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
     * @param { int } id - ID of the notification to cancel, which must be unique in the application.
     * @param { string } representativeBundle - bundle name of the representative.
     * @param { int } userId - userid of the representative.
     * @param { AsyncCallback<void> } callback - The callback of cancelAsBundle.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function cancelAsBundle(id: int, representativeBundle: string, userId: int, callback: AsyncCallback<void>): void;
    /**
     * Cancel a representative notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
     * @param { int } id - ID of the notification to cancel, which must be unique in the application.
     * @param { string } representativeBundle - bundle name of the representative.
     * @param { int } userId - userid of the representative.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function cancelAsBundle(id: int, representativeBundle: string, userId: int): Promise<void>;
    /**
     * Cancel a representative notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
     * @param { BundleOption } representativeBundle - bundle option of the representative.
     * @param { int } id - ID of the notification to cancel, which must be unique in the application.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function cancelAsBundle(representativeBundle: BundleOption, id: int): Promise<void>;
    
    /**
     * Cancels all notifications of this application. This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful, err is undefined;
     *                                           otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function cancelAll(callback: AsyncCallback<void>): void;
    
    /**
     * Cancels all notifications of this application. This API uses a promise to return the result.
     *
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function cancelAll(): Promise<void>;
    /**
     * Creates a notification slot.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { NotificationSlot } slot - Indicates the notification slot to be created, which is set by {@link NotificationSlot}.
     * @param { AsyncCallback<void> } callback - The callback of addSlot.
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
    function addSlot(slot: NotificationSlot, callback: AsyncCallback<void>): void;
    /**
     * Creates a notification slot.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { NotificationSlot } slot - Indicates the notification slot to be created, which is set by {@link NotificationSlot}.
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
    function addSlot(slot: NotificationSlot): Promise<void>;
    /**
     * Adds a notification slot of a specified type. This API uses an asynchronous callback to return the result.
     *
     * @param { SlotType } type - Type of the notification slot to add.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful, err is undefined;
     *                                           otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function addSlot(type: SlotType, callback: AsyncCallback<void>): void;
    /**
     * Adds a notification slot of a specified type. This API uses a promise to return the result.
     *
     * @param { SlotType } type - Type of the notification slot to add.
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function addSlot(type: SlotType): Promise<void>;
    /**
     * Creates notification slots.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { Array<NotificationSlot> } slots - Indicates the notification slots to be created, which is set by {@link NotificationSlot}.
     * @param { AsyncCallback<void> } callback - The callback of addSlots.
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
    function addSlots(slots: Array<NotificationSlot>, callback: AsyncCallback<void>): void;
    /**
     * Creates notification slots.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { Array<NotificationSlot> } slots - Indicates the notification slots to be created, which is set by {@link NotificationSlot}.
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
    function addSlots(slots: Array<NotificationSlot>): Promise<void>;
    /**
     * Obtains a notification slot of a specified type. This API uses an asynchronous callback to return the result.
     *
     * @param { SlotType } slotType - Type of a notification slot, including social communication, service notification, and content consultation.
     * @param { AsyncCallback<NotificationSlot> } callback - Callback used to return the result. If the operation is successful, err is undefined
     *                                                       and data is the obtained NotificationSlot; otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function getSlot(slotType: SlotType, callback: AsyncCallback<NotificationSlot>): void;
    /**
     * Obtains a notification slot of a specified type. This API uses a promise to return the result.
     *
     * @param { SlotType } slotType - Type of a notification slot, such as social communication, service notification, content consultation, and so on.
     * @returns { Promise<NotificationSlot> } Promise used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function getSlot(slotType: SlotType): Promise<NotificationSlot>;
    /**
     * Obtains all notification slots of this application. This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<Array<NotificationSlot>> } callback - Callback used to return the result. If the operation is successful, err is undefined
     *                                                              and data is the obtained NotificationSlot array; otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function getSlots(callback: AsyncCallback<Array<NotificationSlot>>): void;
    /**
     * Obtains all notification slots of this application. This API uses a promise to return the result.
     *
     * @returns { Promise<Array<NotificationSlot>> } Promise used to return all notification slots of the current application.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function getSlots(): Promise<Array<NotificationSlot>>;
    /**
     * Obtains allow notification application list.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @returns { Promise<Array<BundleOption>> } Returns all enable notification applications.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getAllNotificationEnabledBundles(): Promise<Array<BundleOption>>;
    /**
     * Removes a notification slot of a specified type for this application. This API uses an asynchronous callback to return the result.
     *
     * @param { SlotType } slotType - Type of a notification slot, including social communication, service notification, and content consultation.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful, err is undefined;
     *                                           otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function removeSlot(slotType: SlotType, callback: AsyncCallback<void>): void;
    /**
     * Removes a notification slot of a specified type for this application. This API uses a promise to return the result.
     *
     * @param { SlotType } slotType - Type of a notification slot, including social communication, service notification, and content consultation.
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function removeSlot(slotType: SlotType): Promise<void>;
    /**
     * Removes all notification slots for this application. This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful, err is undefined;
     *                                           otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function removeAllSlots(callback: AsyncCallback<void>): void;
    /**
     * Removes all notification slots for this application. This API uses a promise to return the result.
     *
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function removeAllSlots(): Promise<void>;
    /**
     * Set whether the application can send notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { boolean } enable - Set enable or not.
     * @param { AsyncCallback<void> } callback - The callback of setNotificationEnable.
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
    function setNotificationEnable(bundle: BundleOption, enable: boolean, callback: AsyncCallback<void>): void;
    /**
     * Set whether the application can send notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { boolean } enable - Set enable or not.
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
    function setNotificationEnable(bundle: BundleOption, enable: boolean): Promise<void>;
    /**
     * Checks whether this application allows to publish notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { AsyncCallback<boolean> } callback - The callback of isNotificationEnabled.
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
    function isNotificationEnabled(bundle: BundleOption, callback: AsyncCallback<boolean>): void;
    /**
     * Checks whether this application allows to publish notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @returns { Promise<boolean> } The promise returned by the function.
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
    function isNotificationEnabled(bundle: BundleOption): Promise<boolean>;
    
    
    /**
     * Checks whether notification is enabled for the specified application. This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<boolean> } callback - Callback used to return the result. The value true means that the
     *                                              notification is enabled, and false means the opposite.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function isNotificationEnabled(callback: AsyncCallback<boolean>): void;
    
    
    /**
     * Checks whether notification is enabled for the specified application. This API uses a promise to return the result.
     *
     * @returns { Promise<boolean> } Promise used to return the result. The value true means that the notification is enabled, and false means the opposite.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function isNotificationEnabled(): Promise<boolean>;
    /**
     * Checks whether notification is enabled for the specified application. This API returns the result synchronously.
     *
     * @returns { boolean } Result of the notification enabling status. The value true means that the notification is enabled,
     *                      and false means the opposite.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function isNotificationEnabledSync(): boolean;
    /**
     * Checks whether this application allows to publish notifications under the user.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { int } userId - The userid of the representative.
     * @param { AsyncCallback<boolean> } callback - The callback of isNotificationEnabled.
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
    function isNotificationEnabled(userId: int, callback: AsyncCallback<boolean>): void;
    /**
     * Checks whether this application allows to publish notifications under the user.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { int } userId - The userid of the representative.
     * @returns { Promise<boolean> } The promise returned by the function.
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
    function isNotificationEnabled(userId: int): Promise<boolean>;
    
    /**
     * Sets whether to allow the specified application to show badge.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { boolean } enable - Set enable or not.
     * @param { AsyncCallback<void> } callback - The callback of displayBadge.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function displayBadge(bundle: BundleOption, enable: boolean, callback: AsyncCallback<void>): void;
    
    /**
     * Sets whether to allow the specified application to show badge.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { boolean } enable - Set enable or not.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function displayBadge(bundle: BundleOption, enable: boolean): Promise<void>;
    
    /**
     * Obtains the flag that whether to allow the application to show badge.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { AsyncCallback<boolean> } callback - The callback of isBadgeDisplayed.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function isBadgeDisplayed(bundle: BundleOption, callback: AsyncCallback<boolean>): void;
    
    /**
     * Obtains the flag that whether to allow the application to show badge.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @returns { Promise<boolean> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function isBadgeDisplayed(bundle: BundleOption): Promise<boolean>;
    
    /**
     * Update all notification slots for the specified bundle.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { NotificationSlot } slot - Indicates the notification slot.
     * @param { AsyncCallback<void> } callback - The callback of setSlotByBundle.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setSlotByBundle(bundle: BundleOption, slot: NotificationSlot, callback: AsyncCallback<void>): void;
    
    /**
     * Update all notification slots for the specified bundle.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { NotificationSlot } slot - Indicates the notification slot.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setSlotByBundle(bundle: BundleOption, slot: NotificationSlot): Promise<void>;
    
    /**
     * Obtains all notification slots belonging to the specified bundle.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { AsyncCallback<Array<NotificationSlot>> } callback - The callback of getSlotsByBundle.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getSlotsByBundle(bundle: BundleOption, callback: AsyncCallback<Array<NotificationSlot>>): void;
    
    /**
     * Obtains all notification slots belonging to the specified bundle.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @returns { Promise<Array<NotificationSlot>> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getSlotsByBundle(bundle: BundleOption): Promise<Array<NotificationSlot>>;
    
    /**
     * Obtains number of slot.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { AsyncCallback<long> } callback - The callback of getSlotNumByBundle.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getSlotNumByBundle(bundle: BundleOption, callback: AsyncCallback<long>): void;
    
    /**
     * Obtains number of slot.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @returns { Promise<long> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getSlotNumByBundle(bundle: BundleOption): Promise<long>;
    /**
     * Obtains all active notifications in the current system. The caller must have system permissions to
     * call this method.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { AsyncCallback<Array<NotificationRequest>> } callback - The callback of getAllActiveNotifications.
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
    function getAllActiveNotifications(callback: AsyncCallback<Array<NotificationRequest>>): void;
    /**
     * Obtains all active notifications in the current system. The caller must have system permissions to
     * call this method.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @returns { Promise<Array<NotificationRequest>> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getAllActiveNotifications(): Promise<Array<NotificationRequest>>;
    /**
     * Obtains the number of active notifications of this application. This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<long> } callback - Callback used to return the result. If the operation is successful, err is undefined and data is the
     *                                             obtained number of active notifications; otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function getActiveNotificationCount(callback: AsyncCallback<long>): void;
    /**
     * Obtains the number of active notifications of this application. This API uses a promise to return the result.
     *
     * @returns { Promise<long> } Promise used to return the result.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function getActiveNotificationCount(): Promise<long>;
    /**
     * Obtains the active notifications of this application. This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<Array<NotificationRequest>> } callback - Callback used to return the result. If the operation is successful,
     *                                                                 err is undefined and data is the obtained NotificationRequest array;
     *                                                                 otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function getActiveNotifications(callback: AsyncCallback<Array<NotificationRequest>>): void;
    /**
     * Obtains the active notifications of this application. This API uses a promise to return the result.
     *
     * @returns { Promise<Array<NotificationRequest>> } Promise used to return the result.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function getActiveNotifications(): Promise<Array<NotificationRequest>>;
    /**
     * Get the live view notification by bundle option and notification key. If the extraInfoKeys is provided,
     * filter the additional information of the live view notification and return the filtered result.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { NotificationFilter } filter - The bundle, notification key and additional information filter of the live view notification.
     * @param { AsyncCallback<NotificationRequest> } callback - The callback of getActiveNotificationByFilter.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getActiveNotificationByFilter(filter: NotificationFilter, callback: AsyncCallback<NotificationRequest>): void;
    /**
     * Get the live view notification by bundle option and notification key. If the extraInfoKeys is provided,
     * filter the additional information of the live view notification and return the filtered result.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { NotificationFilter } filter - The bundle, notification key and additional information filter of the live view notification.
     * @returns { Promise<NotificationRequest> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getActiveNotificationByFilter(filter: NotificationFilter): Promise<NotificationRequest>;
    /**
     * Cancels notifications under a notification group of this application. This API uses an asynchronous callback to return the result.
     *
     * @param { string } groupName - Name of the notification group, which is specified through NotificationRequest when the notification is published.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful, err is undefined; otherwise,
     *                                           err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function cancelGroup(groupName: string, callback: AsyncCallback<void>): void;
    /**
     * Cancels notifications under a notification group of this application. This API uses a promise to return the result.
     *
     * @param { string } groupName - Name of the notification group, which is specified through NotificationRequest when the notification is published.
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function cancelGroup(groupName: string): Promise<void>;
    /**
     * Delete the notification of a specified group for this application.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { string } groupName - The name of the group.
     * @param { AsyncCallback<void> } callback - The callback of removeGroupByBundle.
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
    function removeGroupByBundle(bundle: BundleOption, groupName: string, callback: AsyncCallback<void>): void;
    /**
     * Delete the notification of a specified group for this application.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { string } groupName - The name of the group.
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
    function removeGroupByBundle(bundle: BundleOption, groupName: string): Promise<void>;
    
    /**
     * Set the Do Not Disturb date.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { DoNotDisturbDate } date - The Do Not Disturb date.
     * @param { AsyncCallback<void> } callback - The callback of setDoNotDisturbDate.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setDoNotDisturbDate(date: DoNotDisturbDate, callback: AsyncCallback<void>): void;
    
    /**
     * Set the Do Not Disturb date.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { DoNotDisturbDate } date - The Do Not Disturb date.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setDoNotDisturbDate(date: DoNotDisturbDate): Promise<void>;
    
    /**
     * Set the Do Not Disturb date under the specified user.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { DoNotDisturbDate } date - The Do Not Disturb date.
     * @param { int } userId - The userId.
     * @param { AsyncCallback<void> } callback - The callback of setDoNotDisturbDate.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setDoNotDisturbDate(date: DoNotDisturbDate, userId: int, callback: AsyncCallback<void>): void;
    
    /**
     * Set the Do Not Disturb date under the specified user.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { DoNotDisturbDate } date - The Do Not Disturb date.
     * @param { int } userId - The userId.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setDoNotDisturbDate(date: DoNotDisturbDate, userId: int): Promise<void>;
    
    /**
     * Obtains the Do Not Disturb date.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { AsyncCallback<DoNotDisturbDate> } callback - The callback is used to return the Do Not Disturb date.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getDoNotDisturbDate(callback: AsyncCallback<DoNotDisturbDate>): void;
    
    /**
     * Obtains the Do Not Disturb date.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @returns { Promise<DoNotDisturbDate> } Returns the Do Not Disturb date.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getDoNotDisturbDate(): Promise<DoNotDisturbDate>;
    
    /**
     * Obtains the Do Not Disturb date.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { int } userId - The userId.
     * @param { AsyncCallback<DoNotDisturbDate> } callback - The callback is used to return the Do Not Disturb date.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getDoNotDisturbDate(userId: int, callback: AsyncCallback<DoNotDisturbDate>): void;
    
    /**
     * Obtains the Do Not Disturb date.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { int } userId - The userId.
     * @returns { Promise<DoNotDisturbDate> } Returns the Do Not Disturb date.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getDoNotDisturbDate(userId: int): Promise<DoNotDisturbDate>;
    /**
     * Obtains whether to support the Do Not Disturb mode.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { AsyncCallback<boolean> } callback - The callback is used to return whether Do Not Disturb
     *                                              mode is supported.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function isSupportDoNotDisturbMode(callback: AsyncCallback<boolean>): void;
    /**
     * Obtains whether to support the Do Not Disturb mode.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @returns { Promise<boolean> } Returns whether Do Not Disturb mode is supported.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function isSupportDoNotDisturbMode(): Promise<boolean>;
    /**
     * Checks whether a specified template is supported before using NotificationTemplate to publish a notification.
     * This API uses an asynchronous callback to return the result.
     *
     * @param { string } templateName - Template name. Currently, only downloadTemplate is supported.
     * @param { AsyncCallback<boolean> } callback - Callback used to return the result. The value true means that the specified template is supported,
     *                                              and false means the opposite.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function isSupportTemplate(templateName: string, callback: AsyncCallback<boolean>): void;
    /**
     * Checks whether a specified template is supported before using NotificationTemplate to publish a notification. This API uses a promise to return the result.
     *
     * @param { string } templateName - Template name. Currently, only downloadTemplate is supported.
     * @returns { Promise<boolean> } Promise used to return the result. The value true means that the specified template
     *                               is supported, and false means the opposite.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function isSupportTemplate(templateName: string): Promise<boolean>;
    
    
    /**
     * Requests notification to be enabled for this application. You can call this API to display a dialog box prompting the user to enable
     * notification for your application before publishing a notification. This API uses an asynchronous callback to return the result.
     *
     * @param { UIAbilityContext } context - Ability context bound to the notification dialog box.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful, err is undefined;
     *                                           otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600004 - Notification disabled.
     * @throws { BusinessError } 1600013 - A notification dialog box is already displayed.
     * @syscap SystemCapability.Notification.Notification
     * @StageModelOnly
     * @since 20
     */
    function requestEnableNotification(context: UIAbilityContext, callback: AsyncCallback<void>): void;
    
    
    /**
     * Requests notification to be enabled for this application. You can call this API to display a dialog box prompting the user to enable
     * notification for your application before publishing a notification. This API uses a promise to return the result.
     *
     * @param { UIAbilityContext } context - Ability context bound to the notification dialog box.
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600004 - Notification disabled.
     * @throws { BusinessError } 1600013 - A notification dialog box is already displayed.
     * @syscap SystemCapability.Notification.Notification
     * @StageModelOnly
     * @since 20
     */
    function requestEnableNotification(context: UIAbilityContext): Promise<void>;
    
    /**
     * Sets whether the device supports distributed notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { boolean } enable - Set enable or not.
     * @param { AsyncCallback<void> } callback - The callback of setDistributedEnable.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setDistributedEnable(enable: boolean, callback: AsyncCallback<void>): void;
    
    /**
     * Sets whether the device supports distributed notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { boolean } enable - Set enable or not.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setDistributedEnable(enable: boolean): Promise<void>;
    /**
     * Checks whether distributed notification is enabled on this device. This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<boolean> } callback - Callback used to return the result. The value true means that
     *                                              distributed notification is enabled, and false means the opposite.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function isDistributedEnabled(callback: AsyncCallback<boolean>): void;
    /**
     * Checks whether distributed notification is enabled on this device. This API uses a promise to return the result.
     *
     * @returns { Promise<boolean> } Promise used to return the result. The value true means that distributed notification
     *                               is enabled, and false means the opposite.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function isDistributedEnabled(): Promise<boolean>;
    
    /**
     * Sets whether an application supports distributed notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { boolean } enable - Set enable or not.
     * @param { AsyncCallback<void> } callback - The callback of setDistributedEnableByBundle.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setDistributedEnableByBundle(bundle: BundleOption, enable: boolean, callback: AsyncCallback<void>): void;
    
    /**
     * Sets whether an application supports distributed notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { boolean } enable - Set enable or not.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setDistributedEnableByBundle(bundle: BundleOption, enable: boolean): Promise<void>;
    
    /**
     * Sets whether an application supports distributed notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { string } deviceType - The device type.
     * @param { boolean } enable - Set enable or not.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setDistributedEnabledByBundle(bundle: BundleOption, deviceType: string, enable: boolean): Promise<void>;
    
    /**
     * Obtains whether an application supports distributed notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { AsyncCallback<boolean> } callback - The callback is used to return whether the distributed
     *                                              notification is supported.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function isDistributedEnabledByBundle(bundle: BundleOption, callback: AsyncCallback<boolean>): void;
    
    /**
     * Obtains whether an application supports distributed notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @returns { Promise<boolean> } Returns whether the distributed notification is supported.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function isDistributedEnabledByBundle(bundle: BundleOption): Promise<boolean>;
    
    /**
     * Obtains whether an application supports distributed notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { string } deviceType - The device type.
     * @returns { Promise<boolean> } Returns whether the distributed notification is supported.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function isDistributedEnabledByBundle(bundle: BundleOption, deviceType: string): Promise<boolean>;
    
    /**
     * Sets whether an application supports smart reminders across devices.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { string } deviceType - The device type.
     * @param { boolean } enable - Set enable or not.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setSmartReminderEnabled(deviceType: string, enable: boolean): Promise<void>;
    
    /**
     * Obtains whether an application supports smart reminders across devices.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { string } deviceType - The device type.
     * @returns { Promise<boolean> } Returns whether the smart reminders across devices notification is supported.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600010 - Distributed operation failed.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function isSmartReminderEnabled(deviceType: string): Promise<boolean>;
    
    /**
     * Obtains the remind modes of the notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { AsyncCallback<DeviceRemindType> } callback - The callback is used to return the RemindType.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getDeviceRemindType(callback: AsyncCallback<DeviceRemindType>): void;
    
    /**
     * Obtains the remind modes of the notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @returns { Promise<DeviceRemindType> } Returns the RemindType.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getDeviceRemindType(): Promise<DeviceRemindType>;
    
    
    /**
     * Set whether the application slot is enabled.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { SlotType } type - Type of the notification slot.
     * @param { boolean } enable - Set enable or not.
     * @param { AsyncCallback<void> } callback - The callback of setNotificationEnableSlot.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setNotificationEnableSlot(bundle: BundleOption, type: SlotType, enable: boolean, callback: AsyncCallback<void>): void;
    
    /**
     * Set whether the application slot is enabled.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { SlotType } type - Type of the notification slot.
     * @param { boolean } enable - Set enable or not.
     * @param { boolean } isForceControl - Is the notification slot enable affected by the application
     *         notification enable, false means affected.
     * @param { AsyncCallback<void> } callback - The callback of setNotificationEnableSlot.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setNotificationEnableSlot(bundle: BundleOption, type: SlotType, enable: boolean, isForceControl: boolean, callback: AsyncCallback<void>): void;
    
    
    /**
     * Set whether the application slot is enabled.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { SlotType } type - Type of the notification slot.
     * @param { boolean } enable - Set enable or not.
     * @param { boolean } isForceControl - Is the notification slot enable affected by the application
     *         notification enable, false means affected.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setNotificationEnableSlot(bundle: BundleOption, type: SlotType, enable: boolean, isForceControl?: boolean): Promise<void>;
    
    /**
     * Obtains whether the application slot is enabled.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { SlotType } type - Type of the notification slot.
     * @param { AsyncCallback<boolean> } callback - The callback is used to return whether the application slot is enabled.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function isNotificationSlotEnabled(bundle: BundleOption, type: SlotType, callback: AsyncCallback<boolean>): void;
    
    /**
     * Obtains whether the application slot is enabled.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { SlotType } type - Type of the notification slot.
     * @returns { Promise<boolean> } Returns whether the application slot is enabled.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function isNotificationSlotEnabled(bundle: BundleOption, type: SlotType): Promise<boolean>;
    
    /**
     * Set whether to sync notifications to devices that do not have the app installed.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { int } userId - The userId.
     * @param { boolean } enable - Set enable or not.
     * @param { AsyncCallback<void> } callback - The callback of setSyncNotificationEnabledWithoutApp.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setSyncNotificationEnabledWithoutApp(userId: int, enable: boolean, callback: AsyncCallback<void>): void;
    
    /**
     * Set whether to sync notifications to devices that do not have the app installed.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { int } userId - The userId.
     * @param { boolean } enable - Set enable or not.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600008 - The user does not exist.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setSyncNotificationEnabledWithoutApp(userId: int, enable: boolean): Promise<void>;
    /**
     * Obtains whether to sync notifications to devices that do not have the app installed.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { int } userId - The userId.
     * @param { AsyncCallback<boolean> } callback - The callback is used to return whether to sync notifications to devices.
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
    function getSyncNotificationEnabledWithoutApp(userId: int, callback: AsyncCallback<boolean>): void;
    /**
     * Obtains whether to sync notifications to devices that do not have the app installed.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { int } userId - The userId.
     * @returns { Promise<boolean> } Returns whether to sync notifications to devices.
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
    function getSyncNotificationEnabledWithoutApp(userId: int): Promise<boolean>;
    
    
    /**
     * Sets the notification badge number. This API uses an asynchronous callback to return the result.
     *
     * @param { int } badgeNumber - Notification badge number to set. If badgeNumber is set to 0, badges are cleared;
     *                                 if the value is greater than 99, 99+ is displayed on the badge.
     * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
     *                                           err is undefined; otherwise, err is an error object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function setBadgeNumber(badgeNumber: int, callback: AsyncCallback<void>): void;
    
    
    /**
     * Sets the notification badge number. This API uses a promise to return the result.
     *
     * @param { int } badgeNumber - Notification badge number to set. If badgeNumber is set to 0, badges are cleared;
     *                                 if the value is greater than 99, 99+ is displayed on the badge.
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    function setBadgeNumber(badgeNumber: int): Promise<void>;
    
    /**
     * Set badge number by bundle.
     *
     * @param { BundleOption } bundle - Use the bundleOption to carry bundleName and uid of the application.
     * @param { int } badgeNumber - Badge number.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @throws { BusinessError } 1600017 - There is no corresponding agent relationship configuration.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setBadgeNumberByBundle(bundle: BundleOption, badgeNumber: int): Promise<void>;
    
    /**
     * Subscribe the callback for check notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
     * @param { 'checkNotification' } type - Type of the callback to listen for.
     * @param { function } callback - callback - The callback of check notifications.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function on(type: 'checkNotification', callback: (checkInfo: NotificationCheckInfo) => NotificationCheckResult): void;
    
    /**
     * Subscribe the callback for check notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
     * @param { 'checkNotification' } type - Type of the callback to listen for.
     * @param { NotificationCheckRequest } checkRequest - Check Request for filter notification request.
     * @param { function } callback - callback - The callback of check notifications.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function on(type: 'checkNotification', checkRequest: NotificationCheckRequest, callback: (checkInfo: NotificationCheckInfo) => Promise<NotificationCheckResult>): void;
    
    /**
     * Unsubscribe the callback for check notifications.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
     * @param { 'checkNotification' } type - Type of the callback to listen for.
     * @param { function } [callback] - callback - The callback of check notifications.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function off(type: 'checkNotification', callback?: (checkInfo: NotificationCheckInfo) => NotificationCheckResult): void;
    
    /**
     * Trigger system live view notification.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { int } notificationId - The notification id.
     * @param { ButtonOptions } buttonOptions - The button option.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600007 - The notification does not exist.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function triggerSystemLiveView(bundle: BundleOption, notificationId: int, buttonOptions: ButtonOptions): Promise<void>;
    
    /**
     * Subscribe to system live view notifications
     *
     * @param { SystemLiveViewSubscriber } subscriber - The system live vie notification subscriber.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function subscribeSystemLiveView(subscriber: SystemLiveViewSubscriber): Promise<void>;
    
    /**
     * Set basic configurations of application-level notification channels.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @param { long } slotFlags - Indicates the slotFlags.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setSlotFlagsByBundle(bundle: BundleOption, slotFlags: long): Promise<void>;
    
    /**
     * Obtains basic configurations of application-level notification channels.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { BundleOption } bundle - The bundle option.
     * @returns { Promise<long> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 17700001 - The specified bundle name was not found.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getSlotFlagsByBundle(bundle: BundleOption): Promise<long>;
    
    /**
     * Add do not disturb notification templates.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { Array<DoNotDisturbProfile> } templates - The array of Notification templates.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function addDoNotDisturbProfile(templates: Array<DoNotDisturbProfile>): Promise<void>;
    
    /**
     * Remove do not disturb notification templates.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { Array<DoNotDisturbProfile> } templates - The array of Notification templates.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600012 - No memory space.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function removeDoNotDisturbProfile(templates: Array<DoNotDisturbProfile>): Promise<void>;
    
    /**
     * Set system additional config information of notification
     *
     * @permission ohos.permission.NOTIFICATION_AGENT_CONTROLLER
     * @param { string } key - addition config key.
     * @param { string } value - addition config value.
     * @returns { Promise<int> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setAdditionalConfig(key: string, value: string): Promise<int>;
    
    /**
     * Opens the notification settings page of the application, which is displayed in semi-modal mode and can be used to set
     * the notification enabling and notification mode. This API uses a promise to return the URI of the file in the destination directory.
     *
     * @param { UIAbilityContext } context - Ability context bound to the notification settings page.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600018 - the notification settings window is already displayed.
     * @syscap SystemCapability.Notification.NotificationSettings
     * @stagemodelonly
     * @since 20
     */
    function openNotificationSettings(context: UIAbilityContext): Promise<void>;
    
    /**
     * Get do not disturb profile by id.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { long } id - The id of profile.
     * @returns { Promise<DoNotDisturbProfile> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @throws { BusinessError } 1600003 - Failed to connect to the service.
     * @throws { BusinessError } 1600019 - The do-not-disturb profile does not exist.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function getDoNotDisturbProfile(id: long): Promise<DoNotDisturbProfile>;
    /**
     * Set target device status.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { string } deviceType - The device.
     * @param { long } status - The device status.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setTargetDeviceStatus(deviceType: string, status: long): Promise<void>;
    /**
     * Disabling notifications based on the application list.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { boolean } disabled - The switch of disableNotification.
     * @param { Array<string> } bundleList - The bundles of disableNotification.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1600001 - Internal error.
     * @throws { BusinessError } 1600002 - Marshalling or unmarshalling error.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function disableNotificationFeature(disabled: boolean, bundleList: Array<string>): Promise<void>;
    /**
     * Set notification slot synchronization switch.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { SlotType } slot - The slot type.
     * @param { string } deviceType - The device type.
     * @param { boolean } enabled - The switch state.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function setDistributedEnabledBySlot(slot: SlotType, deviceType: string, enabled: boolean): Promise<void>;
    /**
     * Get notification slot synchronization switch.
     *
     * @permission ohos.permission.NOTIFICATION_CONTROLLER
     * @param { SlotType } slot - The slot type.
     * @param { string } deviceType - The device type.
     * @returns { Promise<boolean> } The promise returned by the function.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application to call the interface.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    function isDistributedEnabledBySlot(slot: SlotType, deviceType: string): Promise<boolean>;
    /**
     * Describes a button option for a triggering.
     *
     * @typedef ButtonOptions
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export interface ButtonOptions {
        /**
         * The button name for a triggering.
         *
         * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
         * @type { string }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        buttonName: string;
    }
    /**
     * Describes a subscriber for system live view.
     *
     * @typedef SystemLiveViewSubscriber
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export interface SystemLiveViewSubscriber {
        /**
         * The callback function that receives a new button option of a notification.
         *
         * @type { ?function }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        onResponse?: (notificationId: int, buttonOptions: ButtonOptions) => void;
    }
    /**
     * Describes the parameters of check notifications.
     *
     * @typedef NotificationCheckInfo
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export interface NotificationCheckInfo {
        /**
         * The application bundle name for publishing notification.
         *
         * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
         * @type { string }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        bundleName: string;
        /**
         * The notification id.
         *
         * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
         * @type { int }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        notificationId: int;
        /**
         * Label of the notification.
         *
         * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
         * @type { ?string }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        label?: string;
        /**
         * The notification content type.
         *
         * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
         * @type { ContentType }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        contentType: ContentType;
        /**
         * UserId of the notification creator.
         *
         * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
         * @type { int }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        creatorUserId: int;
        /**
         * Type of the notification slot.
         *
         * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
         * @type { SlotType }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        slotType: SlotType;
        /**
         * Additional information of the live view notification.
         *
         * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
         * @type { ?Record<string, Object> }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        extraInfos?: Record<string, Object>;
    }
    /**
     * Describes the result of check notifications.
     *
     * @typedef NotificationCheckResult
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export interface NotificationCheckResult {
        /**
         * The result code. 0-display, 1-no display
         *
         * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
         * @type { int }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        code: int;
        /**
         * The result message.
         *
         * @permission ohos.permission.NOTIFICATION_CONTROLLER and ohos.permission.NOTIFICATION_AGENT_CONTROLLER
         * @type { string }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        message: string;
    }
    
    /**
     * Enumerates the notification slot types.
     *
     * @enum { int }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export enum SlotType {
        
        /**
         * Unknown type. This type corresponds to SlotLevel being LEVEL_MIN.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        UNKNOWN_TYPE = 0,
        
        /**
         * Notification slot for social communication. This type corresponds to SlotLevel being LEVEL_HIGH.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        SOCIAL_COMMUNICATION = 1,
        
        /**
         * Notification slot for service information. This type corresponds to SlotLevel being LEVEL_HIGH.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        SERVICE_INFORMATION = 2,
        
        /**
         * Notification slot for content consultation. This type corresponds to SlotLevel being LEVEL_MIN.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        CONTENT_INFORMATION = 3,
        
        /**
         * Live view. A third-party application cannot directly create a notification of this slot type. After the system proxy creates a system live view,
         * the third-party application releases a notification with the same ID to update the specified content.
         * This type corresponds to SlotLevel being LEVEL_DEFAULT.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        LIVE_VIEW = 4,
        
        /**
         * Customer service message. This type is used for messages between users and customer service providers. The messages must be initiated by users.
         * This type corresponds to SlotLevel being LEVEL_DEFAULT.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        CUSTOMER_SERVICE = 5,
        /**
         * NotificationSlot for emergency information.
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        EMERGENCY_INFORMATION = 10,
        
        /**
         * Notification slot for other purposes. This type corresponds to SlotLevel being LEVEL_MIN.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        OTHER_TYPES = 0xFFFF
    }
    
    /**
     * Enumerates the notification content types.
     *
     * @enum { int }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export enum ContentType {
        
        /**
         * Normal text notification.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        NOTIFICATION_CONTENT_BASIC_TEXT,
        
        /**
         * Long text notification.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        NOTIFICATION_CONTENT_LONG_TEXT,
        
        /**
         * Picture-attached notification.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        NOTIFICATION_CONTENT_PICTURE,
        
        /**
         * Conversation notification.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        NOTIFICATION_CONTENT_CONVERSATION,
        
        /**
         * Multi-line text notification.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        NOTIFICATION_CONTENT_MULTILINE,
        
        /**
         * Live view notification. A third-party application cannot directly create a notification of this type.
         * After the system proxy creates a system live view, the third-party application releases a notification with the same ID to update the specified content.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        NOTIFICATION_CONTENT_SYSTEM_LIVE_VIEW,
        
        /**
         * Common live view notification. Only system applications are supported.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        NOTIFICATION_CONTENT_LIVE_VIEW
    }
    /**
     * Enumerates the notification level.
     *
     * @enum { int }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export enum SlotLevel {
        /**
         * Notification is disabled.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        LEVEL_NONE = 0,
        /**
         * Notification is enabled, but the notification icon is not displayed in the status bar, with no banner and alert tone.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        LEVEL_MIN = 1,
        /**
         * Notification is enabled, and the notification icon is displayed in the status bar, with no banner and alert tone.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        LEVEL_LOW = 2,
        /**
         * Notification is enabled, and the notification icon is displayed in the status bar, with an alert tone but no banner.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        LEVEL_DEFAULT = 3,
        /**
         * Notification is enabled, and the notification icon is displayed in the status bar, with an alert tone and banner.
         *
         * @syscap SystemCapability.Notification.Notification
         * @since 20
         */
        LEVEL_HIGH = 4
    }
    /**
     * The type of the Do Not Disturb.
     *
     * @enum { int }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export enum DoNotDisturbType {
        /**
         * Non do not disturb type notification
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        TYPE_NONE = 0,
        /**
         * Execute do not disturb once in the set time period (only watch hours and minutes)
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        TYPE_ONCE = 1,
        /**
         * Execute do not disturb every day with a set time period (only watch hours and minutes)
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        TYPE_DAILY = 2,
        /**
         * Execute in the set time period (specify the time, month, day and hour)
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        TYPE_CLEARLY = 3
    }
    /**
     * Describes a DoNotDisturbDate instance.
     *
     * @typedef DoNotDisturbDate
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export interface DoNotDisturbDate {
        /**
         * the type of the Do Not Disturb.
         *
         * @type { DoNotDisturbType }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        type: DoNotDisturbType;
        /**
         * The start time of the Do Not Disturb.
         *
         * @type { Date }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        begin: Date;
        /**
         * The end time of the Do Not Disturb.
         *
         * @type { Date }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        end: Date;
    }
    /**
     * Describes a DoNotDisturbProfile instance.
     *
     * @typedef DoNotDisturbProfile
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export interface DoNotDisturbProfile {
        /**
         * The profile id of the Do Not disturb.
         *
         * @type { long }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        id: long;
        /**
         * The profile name of the Do Not disturb.
         *
         * @type { string }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        name: string;
        /**
         * The trustlist of application.
         *
         * @type { ?Array<BundleOption> }
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        trustlist?: Array<BundleOption>;
    }
    /**
     * The remind type of the notification.
     *
     * @enum { int }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export enum DeviceRemindType {
        /**
         * The device is not in use, no reminder
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        IDLE_DONOT_REMIND = 0,
        /**
         * The device is not in use, remind
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        IDLE_REMIND = 1,
        /**
         * The device is in use, no reminder
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        ACTIVE_DONOT_REMIND = 2,
        /**
         * The device is in use, reminder
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        ACTIVE_REMIND = 3
    }
    /**
     * Notification source type
     *
     * @enum { int }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export enum SourceType {
        /**
         * General notification
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        TYPE_NORMAL = 0,
        /**
         * Continuous notification
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        TYPE_CONTINUOUS = 1,
        /**
         * Scheduled notification
         *
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        TYPE_TIMER = 2
    }
    /**
     * Enum for notification control flag status.
     *
     * @enum { int }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export enum NotificationControlFlagStatus {
        /**
         * Manipulating of the enumeration by bitwise-or operation represents the closing of ringtone.
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        NOTIFICATION_STATUS_CLOSE_SOUND = 1 << 0,
        /**
         * Manipulating of the enumeration by bitwise-or operation represents the closing of lock screen.
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        NOTIFICATION_STATUS_CLOSE_LOCKSCREEN = 1 << 1,
        /**
         * Manipulating of the enumeration by bitwise-or operation represents the closing of banner.
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        NOTIFICATION_STATUS_CLOSE_BANNER = 1 << 2,
        /**
         * Manipulating of the enumeration by bitwise-or operation represents the closing of light screen.
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        NOTIFICATION_STATUS_CLOSE_LIGHT_SCREEN = 1 << 3,
        /**
         * Manipulating of the enumeration by bitwise-or operation represents the closing of vibration.
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        NOTIFICATION_STATUS_CLOSE_VIBRATION = 1 << 4,
        /**
         * Manipulating of the enumeration by bitwise-or operation represents the closing of status bar icon.
         * @syscap SystemCapability.Notification.Notification
         * @systemapi
         * @since 20
         */
        NOTIFICATION_STATUS_CLOSE_STATUSBAR_ICON = 1 << 5
    }
    /**
     * Describes a bundleOption in a notification.
     *
     * @typedef { _BundleOption } BundleOption
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type BundleOption = _BundleOption;
    /**
     * Describes an action button displayed in a notification.
     *
     * @typedef { _NotificationActionButton } NotificationActionButton
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationActionButton = _NotificationActionButton;
    
    /**
     * Describes a normal text notification.
     *
     * @typedef { _NotificationBasicContent } NotificationBasicContent
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationBasicContent = _NotificationBasicContent;
    
    /**
     * Describes notification types.
     *
     * @typedef { _NotificationContent } NotificationContent
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationContent = _NotificationContent;
    
    /**
     * Describes a long text notification.
     *
     * @typedef { _NotificationLongTextContent } NotificationLongTextContent
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationLongTextContent = _NotificationLongTextContent;
    /**
     * Describes a live view notification.
     *
     * @typedef { _NotificationLiveViewContent } NotificationLiveViewContent
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type NotificationLiveViewContent = _NotificationLiveViewContent;
    
    /**
     * Describes a multi-line text notification.
     *
     * @typedef { _NotificationMultiLineContent } NotificationMultiLineContent
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationMultiLineContent = _NotificationMultiLineContent;
    /**
     * Describes a picture-attached notification.
     *
     * @typedef { _NotificationPictureContent } NotificationPictureContent
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationPictureContent = _NotificationPictureContent;
    /**
     * Describes a system live view notification.
     *
     * @typedef { _NotificationSystemLiveViewContent } NotificationSystemLiveViewContent
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationSystemLiveViewContent = _NotificationSystemLiveViewContent;
    /**
     * Describes a NotificationFlags instance.
     *
     * @typedef { _NotificationFlags } NotificationFlags
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type NotificationFlags = _NotificationFlags;
    /**
     * The status of the notification flag.
     *
     * @typedef { _NotificationFlagStatus } NotificationFlagStatus
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type NotificationFlagStatus = _NotificationFlagStatus;
    
    /**
     * Defines a NotificationRequest instance.
     *
     * @typedef { _NotificationRequest } NotificationRequest
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationRequest = _NotificationRequest;
    /**
     * Defines a UnifiedGroupInfo instance.
     *
     * @typedef { _UnifiedGroupInfo } UnifiedGroupInfo
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type UnifiedGroupInfo = _UnifiedGroupInfo;
    /**
     * Defines a NotificationFilter instance.
     *
     * @typedef { _NotificationFilter } NotificationFilter
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type NotificationFilter = _NotificationFilter;
    /**
     * Defines a NotificationCheckRequest instance.
     *
     * @typedef { _NotificationCheckRequest } NotificationCheckRequest
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type NotificationCheckRequest = _NotificationCheckRequest;
    /**
     * Describes distributed options.
     *
     * @typedef { _DistributedOptions } DistributedOptions
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type DistributedOptions = _DistributedOptions;
    /**
     * Describes a NotificationSlot instance.
     *
     * @typedef { _NotificationSlot } NotificationSlot
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationSlot = _NotificationSlot;
    /**
     * Describes live view notification option type.
     *
     * @typedef { _LiveViewStatus } LiveViewStatus
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type LiveViewStatus = _LiveViewStatus;
    /**
     * Describes live view notification task type.
     *
     * @typedef { _LiveViewTypes } LiveViewTypes
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type LiveViewTypes = _LiveViewTypes;
    /**
     * Provides sorting information about an active notification.
     *
     * @typedef { _NotificationSorting } NotificationSorting
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    export type NotificationSorting = _NotificationSorting;
    /**
     * Describes a NotificationTemplate instance.
     *
     * @typedef { _NotificationTemplate } NotificationTemplate
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationTemplate = _NotificationTemplate;
    /**
     * Describes a NotificationUserInput instance.
     *
     * @typedef { _NotificationUserInput } NotificationUserInput
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationUserInput = _NotificationUserInput;
    /**
     * Describes a system live view capsule type.
     *
     * @typedef { _NotificationCapsule } NotificationCapsule
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationCapsule = _NotificationCapsule;
    /**
     * Describes a system live view button type.
     *
     * @typedef { _NotificationButton } NotificationButton
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationButton = _NotificationButton;
    /**
     * Describes a system live view time type.
     *
     * @typedef { _NotificationTime } NotificationTime
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationTime = _NotificationTime;
    /**
     * Describes a system live view progress type.
     *
     * @typedef { _NotificationProgress } NotificationProgress
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    export type NotificationProgress = _NotificationProgress;
}
export default notificationManager;
