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
 * @file
 * @kit ArkUI
 */
import { Resource } from "../../global/resource";
import image from '../../@ohos.multimedia.image';
import { CommonMethod, PixelMap } from './common';
import { AnimationStatus, FillMode } from "./enums";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Defines the ImageFrameInfo Interface.
 *
 * @interface ImageFrameInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface ImageFrameInfo {
    /**
     * Image path
     *
     * @type { string | Resource | PixelMap }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    src: string | Resource | PixelMap;
    /**
     * Image width
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    width?: number | string;
    /**
     * Image height
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    height?: number | string;
    /**
     * Vertical coordinate of the image relative to the upper left corner of the component
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    top?: number | string;
    /**
     * Horizontal coordinate of the image relative to the upper left corner of the component
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    left?: number | string;
    /**
     * Playback duration of this image frame, in milliseconds.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    duration?: number;
}
export declare interface ImageAnimatorAttribute extends CommonMethod {
    /**
     * Sets the image frame information.
     *
     * <p><strong>NOTE</strong>:
     * <br>Dynamic update is not supported.
     * </p>
     *
     * @param { Array<ImageFrameInfo> } value - Image frame informatio, Default value is [].
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    images(value: Array<ImageFrameInfo> | undefined): this;
    /**
     * Sets the playback state of the animation.
     *
     * @param { AnimationStatus } value - Playback state of the animation, Default value is AnimationStatus.Initial.
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    state(value: AnimationStatus | undefined): this;
    /**
     * Sets the playback duration.
     * The unit is millisecond.
     *
     * <p><strong>NOTE</strong>:
     * <br>This attribute does not take effect when a separate duration is set for any of the image frames.
     * </p>
     *
     * @param { number } value - Playback duration, Default value is 1000.
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    duration(value: number | undefined): this;
    /**
     * Sets the playback direction.
     *
     * @param { boolean } value - Playback direction, Default value is false.
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    reverse(value: boolean | undefined): this;
    /**
     * Sets whether the image size is fixed at the component size.
     *
     * @param { boolean } value - Whether the image size is fixed at the component size, Default value is true.
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fixedSize(value: boolean | undefined): this;
    /**
     * Sets the status before and after execution of the animation in the current playback direction.
     *
     * @param { FillMode } value - Status before and after execution of the animation in the current playback direction,
     * Default value is FillMode.Forwards.
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fillMode(value: FillMode | undefined): this;
    /**
     * Sets the number of times that the animation is played.
     * Played once by default
     *
     * @param { number } value - Number of times that the animation is played, Default value is 1.
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    iterations(value: number | undefined): this;
    /**
     * Sets whether the component should automatically pause or resume based on its visibility, using the system's
     * onVisibleAreaChange event.
     *
     * @param { boolean } monitorInvisibleArea - 	Whether the component should automatically pause or resume based on
     * its visibility, using the system's onVisibleAreaChange event, Default value is false.
     * @returns { ImageAnimatorAttribute }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    monitorInvisibleArea(monitorInvisibleArea: boolean | undefined): this;
    /**
     * Status callback, which is triggered when the animation starts to play.
     *
     * @param { function } event
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onStart(event: (() => void) | undefined): this;
    /**
     * Status callback, which is triggered when the animation pauses.
     *
     * @param { function } event
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onPause(event: (() => void) | undefined): this;
    /**
     * Status callback, triggered when the animation is replayed
     *
     * @param { function } event
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onRepeat(event: (() => void) | undefined): this;
    /**
     * Status callback, which is triggered when the animation playback returns to the initial state.
     *
     * @param { function } event
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onCancel(event: (() => void) | undefined): this;
    /**
     * Status callback, which is triggered when the animation playback is complete or stopped.
     *
     * @param { function } event
     * @returns { ImageAnimatorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onFinish(event: (() => void) | undefined): this;
    attributeModifier(modifier: AttributeModifier<ImageAnimatorAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * ImageAnimator is returned.
 *
 * @returns { ImageAnimatorAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function ImageAnimator(
    
    @memo
    content_?: () => void,
): ImageAnimatorAttribute