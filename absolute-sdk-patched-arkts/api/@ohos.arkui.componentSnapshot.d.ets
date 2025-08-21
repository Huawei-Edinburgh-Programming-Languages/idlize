/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
 * @kit ArkUI
 * @arkts 1.2
 */
import { CustomBuilder } from './arkui/component/builder';
import { AsyncCallback } from './@ohos.base';
import image from './@ohos.multimedia.image';

/**
 * This module allows developers to export snapshot image from a component or a custom builder.
 *
 * @namespace componentSnapshot
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
declare namespace componentSnapshot {
    /**
     * Defines the extra options for snapshot taking.
     *
     * @typedef SnapshotRegion
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export interface SnapshotRegion {
        /**
         * Left side position of rectangle, in PX.
         *
         * @type { number }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        left: number;
        /**
         * Right side position of Rectangle, in PX.
         *
         * @type { number }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        right: number;
        /**
         * Top side position of Rectangle, in PX.
         *
         * @type { number }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        top: number;
        /**
         * Bottom side position of Rectangle, in PX.
         *
         * @type { number }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        bottom: number;
    }
    /**
     * Defines the extra options for snapshot taking, if this is used, the start and end will
     * be assigned to left and right value according to the layout direction of node automaticlly.
     *
     * @typedef LocalizedSnapshotRegion
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export interface LocalizedSnapshotRegion {
        /**
         * Left/Right side position of rectangle, in PX
         *
         * @type { number }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        start: number;
        /**
         * End side position of Rectangle, in PX.
         *
         * @type { number }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        end: number;
        /**
         * Left/Right side position of rectangle, in PX
         *
         * @type { number }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        top: number;
        /**
         * Bottom side position of Rectangle, in PX.
         *
         * @type { number }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        bottom: number;
    }
    /**
     * Defines the snapshot region rect type.
     *
     * @typedef { SnapshotRegion | LocalizedSnapshotRegion } SnapshotRegionType
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export type SnapshotRegionType = SnapshotRegion | LocalizedSnapshotRegion;
    /**
     * Defines the extra options for snapshot taking.
     *
     * @typedef SnapshotOptions
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export interface SnapshotOptions {
        /**
         * Defines the scale property to render the snapshot.
         *
         * @type {?number}
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        scale?: number;
        /**
         * Whether to wait the rendering is finished.
         *
         * @type {?boolean}
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        waitUntilRenderFinished?: boolean;
        /**
         * Defines the rect reigon type of the snapshot.
         *
         * @type {?SnapshotRegionType}
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        region?: SnapshotRegionType;
    }
    /**
     * Take a screenshot of the specified component in synchronous mode,
     * this mode will block the main thread, please use it with caution, the maximum
     * waiting time of the interface is 3s, if it does not return after 3s, an exception will be thrown.
     *
     * @param { string } id - Target component ID, set by developer through .id attribute.
     * @param { SnapshotOptions } [options] - Define the snapshot options.
     * @returns { image.PixelMap } The snapshot result in PixelMap format.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 100001 - Invalid ID.
     * @throws { BusinessError } 160002 - Timeout.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export function getSync(id: string, options?: SnapshotOptions): image.PixelMap;
}
export default componentSnapshot;
