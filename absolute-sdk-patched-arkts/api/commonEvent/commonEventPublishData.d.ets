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
 * @file The CommonEventPublishData module provides APIs for defining common event content and attributes.
 * @kit BasicServicesKit
 */


/**
 * The CommonEventPublishData module provides APIs for defining common event content and attributes.
 *
 * @typedef CommonEventPublishData
 * @syscap SystemCapability.Notification.CommonEvent
 * @since 20
 */
export interface CommonEventPublishData {
    
    /**
     * Bundle name of the subscriber that can receive the common event.
     *
     * @type { ?string }
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    bundleName?: string;
    
    /**
     * Common event data transferred by the publisher. The default value is 0.
     *
     * @type { ?int }
     * @default 0
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    code?: int;
    
    
    /**
     * Common event data transferred by the publisher. The data size cannot exceed 64 KB.
     *
     * @type { ?string }
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    data?: string;
    
    /**
     * Permissions required for subscribers to receive the common event.
     *
     * @type { ?Array<string> }
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    subscriberPermissions?: Array<string>;
    /**
     * Whether the common event is an ordered one.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    isOrdered?: boolean;
    /**
     * Whether the common event is a sticky one. Only system applications and system services are allowed to send sticky events.
     *
     * @permission ohos.permission.COMMONEVENT_STICKY
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    isSticky?: boolean;
    /**
     * The description of the parameters in a common event.
     *
     * @type { ?Record<string, Object> }
     * @syscap SystemCapability.Notification.CommonEvent
     * @since 20
     */
    parameters?: Record<string, Object>;
}
