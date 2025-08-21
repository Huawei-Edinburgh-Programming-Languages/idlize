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
 * @file The CommonEventSubscribeInfo module provides APIs for providing subscriber information.
 * @kit BasicServicesKit
 */

/**
 * The CommonEventSubscribeInfo module provides APIs for providing subscriber information.
 *
 * @typedef CommonEventSubscribeInfo
 * @syscap SystemCapability.Notification.CommonEvent
 * @since 20
 */
export interface CommonEventSubscribeInfo {
    
    /**
     * Common events to subscribe to.
     *
     * @type { Array<string> }
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    events: Array<string>;
    
    /**
     * Permission of the publisher. The subscriber can receive only the events from the publisher with this permission.
     *
     * @type { ?string }
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    publisherPermission?: string;
    
    /**
     * Device ID. Use @ohos.deviceInfo to obtain the UDID as the device ID of the subscriber. Not supported currently.
     *
     * @type { ?string }
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    publisherDeviceId?: string;
    
    /**
     * User ID. If this parameter is not specified, the default value, which is the ID of the current user, will be used.
     * The value must be an existing user ID in the system. Use getOsAccountLocalId to obtain the system account ID and use it as the user ID of the subscriber.
     *
     * @type { ?int }
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    userId?: int;
    
    /**
     * Subscriber priority. The value ranges from –100 to +1000. If the value exceeds the upper or lower limit, the upper or lower limit is used.
     *
     * @type { ?int }
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    priority?: int;
    /**
     * Bundle name of the publisher to subscribe to.
     *
     * @type { ?string }
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    publisherBundleName?: string;
}
