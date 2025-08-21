/*
* Copyright (c) 2023 Huawei Device Co., Ltd.
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
 * @kit InputKit
 */
import type { AsyncCallback } from './@ohos.base';
/**
 * Enumerates fingerprint key event types.
 *
 * @enum { number }
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @systemapi Hide this for inner system use.
 * @since 20
 */
export declare enum FingerprintAction {
    /**
     * Pressing down.
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    DOWN = 0,
    /**
     * Lifting up.
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    UP = 1,
    /**
     * Sliding.
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    SLIDE = 2,
    /**
     * Retouching.
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    RETOUCH = 3,
    /**
     * Clicking.
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    CLICK = 4
}
/**
 * Defines the key event type and the offset position relative to the key.
 *
 * @interface FingerprintEvent
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @systemapi Hide this for inner system use.
 * @since 20
 */
export declare interface FingerprintEvent {
    /**
     * Fingerprint key event type.
     *
     * @type { FingerprintAction }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    action: FingerprintAction;
    /**
     * This value indicates the sliding percentage of the fingerprint key on the X axis,
     * that is, the ratio of the relative sliding distance to the device length
     * compared with the previous report of the sliding event.
     * A positive value indicates moving in the positive direction of the X axis,
     * and a negative value indicates the opposite.
     * The vertical upward direction of the device stands for the positive direction of the Y axis,
     * and the horizontal rightward direction stands for the positive direction of the X axis.
     * This way, a rectangular coordinate system is constructed.
     *
     * @type { double }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    distanceX: double;
    /**
     * This value indicates the sliding percentage of the fingerprint key on the Y axis,
     * that is, the ratio of the relative sliding distance to the component length
     * compared with the previous report of the sliding event.
     * A positive value indicates moving in the positive direction of the Y axis,
     * and a negative value indicates the opposite.
     * The vertical upward direction of the device stands for the positive direction of the Y axis,
     * and the horizontal rightward direction stands for the positive direction of the X axis.
     * This way, a rectangular coordinate system is constructed.
     *
     * @type { double }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    distanceY: double;
}
