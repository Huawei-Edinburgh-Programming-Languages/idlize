/*
 * Copyright (c) 2021-2024 Huawei Device Co., Ltd.
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
 * @file Provides methods that will be called back when the subscriber receives a new notification or a notification is canceled
 * @kit NotificationKit
 */
import { NotificationRequest } from './notificationRequest';
import { NotificationSortingMap } from './notificationSortingMap';
import type notificationManager from '../@ohos.notificationManager';
/**
 * Provides methods that will be called back when the subscriber receives a new notification or
 * a notification is canceled.
 *
 * @interface NotificationSubscriber
 * @syscap SystemCapability.Notification.Notification
 * @systemapi
 * @since 20
 */
export interface NotificationSubscriber {
    /**
     * The callback function that receives a new notification.
     *
     * @type { ?function }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    onConsume?: (data: SubscribeCallbackData) => void;
    /**
     * The callback function that cancels the notification.
     *
     * @type { ?function }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    onCancel?: (data: SubscribeCallbackData) => void;
    /**
     * The callback function that updates the sort of notifications.
     *
     * @type { ?function }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    onUpdate?: (data: NotificationSortingMap) => void;
    /**
     * The callback function of the completed subscription.
     *
     * @type { ?function }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    onConnect?: () => void;
    /**
     * The callback function to unsubscribe.
     *
     * @type { ?function }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    onDisconnect?: () => void;
    /**
     * The callback function that service disconnected.
     *
     * @type { ?function }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    onDestroy?: () => void;
    /**
     * Callback when the Do Not Disturb setting changed.
     *
     * @type { ?function }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    onDoNotDisturbChanged?: (mode: notificationManager.DoNotDisturbDate) => void;
    /**
     * Callback when the notification permission is changed.
     *
     * @type { ?function }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    onEnabledNotificationChanged?: (callbackData: EnabledNotificationCallbackData) => void;
    /**
     * Callback when badge number changed.
     *
     * @type { ?function }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    onBadgeChanged?: (data: BadgeNumberCallbackData) => void;
    /**
     * Callback when badge enabled state changed.
     *
     * @type { ?BadgeEnabledChangedCallback }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    onBadgeEnabledChanged?: BadgeEnabledChangedCallback;
    /**
     * Callback when badge cancel notifications.
     *
     * @type { ?function }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    onBatchCancel?: (data: Array<SubscribeCallbackData>) => void;
}
/**
 * Provides methods that will be called back when the subscriber receives a new notification or
 * a notification is canceled.
 *
 * @typedef SubscribeCallbackData
 * @syscap SystemCapability.Notification.Notification
 * @systemapi
 * @since 20
 */
export interface SubscribeCallbackData {
    /**
     * Content of the notice.
     *
     * @type { NotificationRequest }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly request: NotificationRequest;
    /**
     * Notify sorting information.
     *
     * @type { ?NotificationSortingMap }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly sortingMap?: NotificationSortingMap;
    /**
     * The reason for the deletion.(1:CLICK_REASON_REMOVE,2:CANCEL_REASON_REMOVE)
     *
     * @type { ?int }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly reason?: int;
    /**
     * Notification sound.
     *
     * @type { ?string }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly sound?: string;
    /**
     * Notice the vibration.
     *
     * @type { ?Array<long> }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly vibrationValues?: Array<long>;
}
/**
 * Describes the properties of the application that the permission to send notifications
 * or the badge enabled state has changed.
 *
 * @typedef EnabledNotificationCallbackData
 * @syscap SystemCapability.Notification.Notification
 * @systemapi
 * @since 20
 */
export interface EnabledNotificationCallbackData {
    /**
     * The bundle name of the application.
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly bundle: string;
    /**
     * The uid of the application.
     *
     * @type { int }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly uid: int;
    /**
     * Apply notification enable status.
     *
     * @type { boolean }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly enable: boolean;
}
/**
 * Describes the badge number of the application has changed.
 *
 * @typedef BadgeNumberCallbackData
 * @syscap SystemCapability.Notification.Notification
 * @systemapi
 * @since 20
 */
export interface BadgeNumberCallbackData {
    /**
     * bundle name
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly bundle: string;
    /**
     * The uid of the application.
     *
     * @type { int }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly uid: int;
    /**
     * badge number
     *
     * @type { int }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly badgeNumber: int;
    /**
     * Application instance key.
     *
     * @type { ?string }
     * @readonly
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    readonly appInstanceKey?: string;
}
/**
 * Defines the BadgeEnabledChanged callback.
 * @param { EnabledNotificationCallbackData } data
 * @syscap SystemCapability.Notification.Notification
 * @systemapi
 * @since 20
 */
export type BadgeEnabledChangedCallback = (data: EnabledNotificationCallbackData) => void;
