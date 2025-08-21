/*
 * Copyright (c) 2021-2024 Huawei Device Co., Ltd.
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
 * @file The NotificationContent module provides APIs for defining the notification content.
 * @kit NotificationKit
 */
import image from '../@ohos.multimedia.image';
import { Resource } from '../global/resource';
import type notificationManager from '../@ohos.notificationManager';
/**
 * Describes icon type.
 *
 * @typedef { Resource | image.PixelMap } IconType
 * @syscap SystemCapability.Notification.Notification
 * @systemapi
 * @since 20
 */
type IconType = Resource | image.PixelMap;

/**
 * Describes a normal text notification.
 *
 * @typedef NotificationBasicContent
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
export interface NotificationBasicContent {
    
    /**
     * Notification title. It cannot be empty or exceed 1024 bytes. Excess content will be truncated.
     *
     * @type { string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    title: string;
    
    /**
     * Notification content. It cannot be empty or exceed 3072 bytes. Excess content will be truncated.
     *
     * @type { string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    text: string;
    /**
     * Additional information of the notification. It cannot exceed 3072 bytes. Excess content will be truncated.
     *
     * @type { ?string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    additionalText?: string;
    /**
     * Picture of a notification displayed on the lock screen. Currently, only the live view notification is supported.
     * The total number of the icon pixel bytes cannot exceed 192 KB (which is obtained through getPixelBytesNumber.
     * The recommended icon size is 128 × 128 pixels.
     * The display effect depends on the device capability and notification center UI style.
     *
     * @type { ?image.PixelMap }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    lockscreenPicture?: image.PixelMap;
}

/**
 * Describes the long text notification. This API is inherited from NotificationBasicContent.
 *
 * @extends NotificationBasicContent
 * @typedef NotificationLongTextContent
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
export interface NotificationLongTextContent extends NotificationBasicContent {
    
    /**
     * Long text of the notification. It cannot be an empty string and exceed 3072 bytes. Excess content will be truncated.
     *
     * @type { string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    longText: string;
    
    /**
     * Brief text of the notification. It cannot be empty or exceed 1024 bytes. Excess content will be truncated.
     *
     * @type { string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    briefText: string;
    
    /**
     * Title of the notification in the expanded state. It cannot be empty or exceed 1024 bytes. Excess content will be truncated.
     *
     * @type { string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    expandedTitle: string;
}
/**
   * Enum for live view notification option type.
   *
   * @enum { int }
   * @syscap SystemCapability.Security.AccessToken
   * @systemapi
   * @since 20
   */
export enum LiveViewStatus {
    /**
     * Create the live view notification.
     *
     * @syscap SystemCapability.Security.AccessToken
     * @systemapi
     * @since 20
     */
    LIVE_VIEW_CREATE = 0,
    /**
     * Batch update the live view notification.
     *
     * @syscap SystemCapability.Security.AccessToken
     * @systemapi
     * @since 20
     */
    LIVE_VIEW_INCREMENTAL_UPDATE = 1,
    /**
     * Complete the live view notification.
     *
     * @syscap SystemCapability.Security.AccessToken
     * @systemapi
     * @since 20
     */
    LIVE_VIEW_END = 2,
    /**
     * Full update the live view notification.
     *
     * @syscap SystemCapability.Security.AccessToken
     * @systemapi
     * @since 20
     */
    LIVE_VIEW_FULL_UPDATE = 3
}
/**
 * Enum for live view notification task type.
 *
 * @enum { int }
 * @syscap SystemCapability.Notification.Notification
 * @systemapi
 * @since 20
 */
export enum LiveViewTypes {
    /**
     * Real-time activity live view Notification.
     *
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    LIVE_VIEW_ACTIVITY = 0,
    /**
     * Instant Task live view Notification.
     *
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    LIVE_VIEW_INSTANT = 1,
    /**
     * Long-term status task live view Notification.
     *
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    LIVE_VIEW_LONG_TERM = 2
}
/**
 * Describes a live view notification.
 *
 * @extends NotificationBasicContent
 * @typedef NotificationLiveViewContent
 * @syscap SystemCapability.Notification.Notification
 * @systemapi
 * @since 20
 */
export interface NotificationLiveViewContent extends NotificationBasicContent {
    /**
     * Status of the live view (0: create, 1: batch update, 2: end, 3: full update).
     *
     * @type { LiveViewStatus }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    status: LiveViewStatus;
    /**
     * Version of the live view with the same id. (If the version number stored in the database is 0xffffffff,
     * the version number is not verified at the current operation of update or end. Otherwise, the
     * version number must be greater than the version number stored in the database.)
     *
     * @type { ?int }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    version?: int;
    /**
     * Additional information of the live view notification.
     *
     * @type { ?Record<string, Object>}
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    extraInfo?: Record<string, Object>;
    /**
     * The picture information list of the live view notification.
     *
     * @type { ?Record<string, Array<image.PixelMap>> }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    pictureInfo?: Record<string, Array<image.PixelMap>>;
    /**
     * Whether to update locally.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    isLocalUpdateOnly?: boolean;
}

/**
 * Describes the multi-line text notification. This API is inherited from NotificationBasicContent.
 *
 * @extends NotificationBasicContent
 * @typedef NotificationMultiLineContent
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
export interface NotificationMultiLineContent extends NotificationBasicContent {
    
    /**
     * Brief text of the notification. It cannot be empty or exceed 1024 bytes. Excess content will be truncated.
     *
     * @type { string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    briefText: string;
    
    /**
     * Title of the notification in the expanded state. It cannot be empty or exceed 1024 bytes. Excess content will be truncated.
     *
     * @type { string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    longTitle: string;
    
    /**
     * Multi-line text of the notification. It cannot exceed 1024 bytes. Excess content will be truncated.
     *
     * @type { Array<string> }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    lines: Array<string>;
}
/**
 * Describes the picture-attached notification. This API is inherited from NotificationBasicContent.
 *
 * @extends NotificationBasicContent
 * @typedef NotificationPictureContent
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
export interface NotificationPictureContent extends NotificationBasicContent {
    /**
     * Brief text of the notification. It cannot be empty or exceed 1024 bytes. Excess content will be truncated.
     *
     * @type { string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    briefText: string;
    /**
     * Title of the notification in the expanded state. It cannot be empty or exceed 1024 bytes. Excess content will be truncated.
     *
     * @type { string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    expandedTitle: string;
    /**
     * Picture content of the notification. (The total number of bytes of image pixels cannot exceed 2 MB.)
     *
     * @type { image.PixelMap }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    picture: image.PixelMap;
}
/**
 * Describes the system live view notification. A third-party application cannot directly create a notification of this type.
 * After the system proxy creates a system live view, the third-party application releases a notification with the same ID to update the specified content.
 * This API is inherited from NotificationBasicContent.
 *
 * @extends NotificationBasicContent
 * @typedef NotificationSystemLiveViewContent
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
export interface NotificationSystemLiveViewContent extends NotificationBasicContent {
    /**
     * Type code, which identifies the type of the service that invokes the API.
     *
     * @type { int }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    typeCode: int;
    /**
     * Capsule of the notification.
     *
     * @type { ?NotificationCapsule }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    capsule?: NotificationCapsule;
    /**
     * Button in the notification.
     *
     * @type { ?NotificationButton }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    button?: NotificationButton;
    /**
     * card button of a system live view notification.
     *
     * @type { ?Array<NotificationIconButton> }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    cardButtons?: Array<NotificationIconButton>;
    /**
     * Time of the notification.
     *
     * @type { ?NotificationTime }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    time?: NotificationTime;
    /**
     * Progress of the notification.
     *
     * @type { ?NotificationProgress }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    progress?: NotificationProgress;
    /**
     * task type of a system live view notification.
     *
     * @type { int }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    liveViewType?: LiveViewTypes;
}
/**
 * Describe the notification capsule.
 *
 * @typedef NotificationCapsule
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
export interface NotificationCapsule {
    /**
     * Title of the capsule.
     *
     * @type { ?string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    title?: string;
    /**
     * Icon of the capsule.
     *
     * @type { ?image.PixelMap }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    icon?: image.PixelMap;
    /**
     * Background color of the capsule.
     *
     * @type { ?string }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    backgroundColor?: string;
    /**
     * Extended text of this capsule.
     *
     * @type { ?string }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    content?: string;
    /**
     * Display time of this capsule.
     *
     * @type { ?int }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    time?: int;
    /**
     * Extended button of this capsule.
     *
     * @type { ?Array<NotificationIconButton> }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    capsuleButtons?: Array<NotificationIconButton>;
}
/**
 * Describes a system live view button with icon.
 *
 * @typedef NotificationIconButton
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
export interface NotificationIconButton {
    /**
     * button unique name.
     *
     * @type { string }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    name: string;
    /**
     * button icon resource.
     *
     * @type { IconType }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    iconResource: IconType;
    /**
     * addition text of the icon buttion
     *
     * @type { ?string }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    text?: string;
    /**
     * hide the panel when click the icon button.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    hidePanel?: boolean;
}
/**
 * Describes the notification button.
 *
 * @typedef NotificationButton
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
export interface NotificationButton {
    /**
     * Button names. A maximum of three names are supported.
     *
     * @type { ?Array<string> }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    names?: Array<string>;
    /**
     * Button icons. A maximum of three icons are supported.
     *
     * @type { ?Array<image.PixelMap> }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    icons?: Array<image.PixelMap>;
    /**
     * Button icon resources. A maximum of three icon resources are supported.
     *
     * @type { ?Array<Resource> }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    iconsResource?: Array<Resource>;
}
/**
 * Describes the notification timing information.
 *
 * @typedef NotificationTime
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
export interface NotificationTime {
    /**
     * Start time, in milliseconds.
     *
     * @type { ?int }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    initialTime?: int;
    /**
     * Whether to count down.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    isCountDown?: boolean;
    /**
     * Whether to pause the progress.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    isPaused?: boolean;
    /**
     * Whether the time is displayed in the title.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    isInTitle?: boolean;
}
/**
 * Describes the notification progress.
 *
 * @typedef NotificationProgress
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
export interface NotificationProgress {
    /**
     * Maximum progress value.
     *
     * @type { ?int }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    maxValue?: int;
    /**
     * Current progress value.
     *
     * @type { ?int }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    currentValue?: int;
    /**
     * Whether to show the progress in percentage.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    isPercentage?: boolean;
}

/**
 * Describes the notification contents.
 *
 * @typedef NotificationContent
 * @syscap SystemCapability.Notification.Notification
 * @since 20
 */
export interface NotificationContent {
    
    /**
     * Notification content type.
     *
     * @type { ?notificationManager.ContentType }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    notificationContentType?: notificationManager.ContentType;
    
    /**
     * Normal text.
     *
     * @type { ?NotificationBasicContent }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    normal?: NotificationBasicContent;
    
    /**
     * Long text.
     *
     * @type { ?NotificationLongTextContent }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    longText?: NotificationLongTextContent;
    
    /**
     * Multi-line text.
     *
     * @type { ?NotificationMultiLineContent }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    multiLine?: NotificationMultiLineContent;
    /**
     * Picture-attached.
     *
     * @type { ?NotificationPictureContent }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    picture?: NotificationPictureContent;
    /**
     * System live view. A third-party application cannot directly create a notification of this type. After the system proxy creates a system live view,
     * the third-party application releases a notification with the same ID to update the specified content.
     *
     * @type { ?NotificationSystemLiveViewContent }
     * @syscap SystemCapability.Notification.Notification
     * @since 20
     */
    systemLiveView?: NotificationSystemLiveViewContent;
    /**
     * live-view notification.
     *
     * @type { ?NotificationLiveViewContent }
     * @syscap SystemCapability.Notification.Notification
     * @systemapi
     * @since 20
     */
    liveView?: NotificationLiveViewContent;
}
