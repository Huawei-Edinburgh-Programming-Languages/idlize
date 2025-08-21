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
import { ResourceColor, Length, PX, VP, LPX, Font, ResourceStr } from './units';
import { Resource } from '../../global/resource';
import { CommonMethod, Optional, ContentModifier, CommonConfiguration } from './common';
import { LinearGradient } from "./dataPanel";
import { LengthMetrics } from '../Graphics';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Defines the option of Progress.
 *
 * @interface ProgressOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ProgressOptions {
    /**
     * Sets the value of Progress.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: number;
    /**
     * Sets the total of Progress.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    total?: number;
    /**
     * Sets the type of Progress.
     *
     * @type { ?ProgressType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type?: ProgressType;
}
/**
 * Type of progress bar
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ProgressType {
    /**
     * Linear progress bar style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Linear = 0,
    /**
     * Ring progress bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Ring = 1,
    /**
     * Eclipse progress bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Eclipse = 2,
    /**
     * ScaleRing progress bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ScaleRing = 3,
    /**
     * Capsule progress bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Capsule = 4
}
/**
 * Current status of progress bar.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ProgressStatus {
    /**
     * Loading status.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LOADING,
    /**
     * Processing status.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PROGRESSING
}
/**
 * Defines style options for progress component.
 *
 * @extends CommonProgressStyleOptions
 * @interface ProgressStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ProgressStyleOptions extends CommonProgressStyleOptions {
    /**
     * Defines the strokeWidth property.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    strokeWidth?: Length;
    /**
     * Defines the scaleCount property.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scaleCount?: number;
    /**
     * Defines the scaleWidth property.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scaleWidth?: Length;
}
/**
 * Progress common style options.
 *
 * @interface CommonProgressStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CommonProgressStyleOptions {
    /**
     * Enable smooth effect.
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableSmoothEffect?: boolean;
}
/**
 * Defines the enable scan effect.
 *
 * @interface ScanEffectOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ScanEffectOptions {
    /**
     * Enable scan effect.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableScanEffect?: boolean;
}
/**
 * Defines the Eclipse style Options.
 *
 * @extends CommonProgressStyleOptions
 * @interface EclipseStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface EclipseStyleOptions extends CommonProgressStyleOptions {
}
/**
 * Defines the ScaleRing style Options.
 *
 * @extends CommonProgressStyleOptions
 * @interface ScaleRingStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ScaleRingStyleOptions extends CommonProgressStyleOptions {
    /**
     * Defines the strokeWidth property.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    strokeWidth?: Length;
    /**
     * Defines the scaleWidth property.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scaleWidth?: Length;
    /**
     * Defines the scaleCount property.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scaleCount?: number;
}
/**
 * Defines the ring style Options.
 *
 * @extends ScanEffectOptions, CommonProgressStyleOptions
 * @interface RingStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RingStyleOptions extends ScanEffectOptions, CommonProgressStyleOptions {
    /**
     * Defines the strokeWidth property.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    strokeWidth?: Length;
    /**
     * Enables progress shadow.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    shadow?: boolean;
    /**
     * The status of progress, default is PROGRESSING. Set to LOADING status will trigger the loading animation.
     *
     * @type { ?ProgressStatus }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    status?: ProgressStatus;
}
/**
 * Defines the linear style Options.
 *
 * @extends ScanEffectOptions, CommonProgressStyleOptions
 * @interface LinearStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LinearStyleOptions extends ScanEffectOptions, CommonProgressStyleOptions {
    /**
     * Defines the strokeWidth property.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    strokeWidth?: Length;
    /**
     * Defines the stroke radius property.
     *
     * @type { ?(PX | VP | LPX | Resource) }
     * @default strokeWidth / 2
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    strokeRadius?: PX | VP | LPX | Resource;
}
/**
 * Defines the capsule style Options.
 *
 * @extends ScanEffectOptions, CommonProgressStyleOptions
 * @interface CapsuleStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CapsuleStyleOptions extends ScanEffectOptions, CommonProgressStyleOptions {
    /**
     * Set the inner border color.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderColor?: ResourceColor;
    /**
     * Set the border width.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderWidth?: Length;
    /**
     * Set the text style.
     *
     * @type { ?Font }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    font?: Font;
    /**
     * Set the text fontColor.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontColor?: ResourceColor;
    /**
     * show default percentage.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    showDefaultPercentage?: boolean;
    /**
     * Set border rounded corner radius.
     *
     * @type { ?LengthMetrics }
     * @default height / 2
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderRadius?: LengthMetrics;
}
/**
 * Type of progress bar
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ProgressStyle {
    /**
     * Linear progress bar style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Linear,
    /**
     * Ring progress bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Ring,
    /**
     * Eclipse progress bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Eclipse,
    /**
     * ScaleRing progress bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ScaleRing,
    /**
     * Capsule progress bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Capsule
}
/**
 * Defines the map for progress type and style.
 *
 * @interface ProgressStyleMap
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ProgressStyleMap {
}
export declare interface ProgressAttribute extends CommonMethod {
    /**
     * Called when the current progress value is set.
     *
     * @param { number } value
     * @returns { ProgressAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value(value: number | undefined): this;
    /**
     * Called when the progress bar foreground is set.
     *
     * @param { ResourceColor | LinearGradient } value - indicates the color of the progress.
     * @returns { ProgressAttribute } the attribute of the progress.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    color(value: ResourceColor | LinearGradient | undefined): this;
    /**
     * Called when the style of progress bar is set.
     *
     * @param { LinearStyleOptions | RingStyleOptions | CapsuleStyleOptions | ProgressStyleOptions } value - indicates the style of the progress.
     * @returns { ProgressAttribute } the attribute of the progress.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style(value: LinearStyleOptions | RingStyleOptions | CapsuleStyleOptions | ProgressStyleOptions | undefined): this;
    /**
     * Sets if mark to privacy sensitive.
     *
     * @param { Optional<boolean> } isPrivacySensitiveMode - indicates if mark to privacy sensitive.
     * @returns { ProgressAttribute } the attribute of the progress.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    privacySensitive(isPrivacySensitiveMode: boolean | undefined): this;
    /**
     * Set the contentModifier of progress.
     *
     * @param { ContentModifier<ProgressConfiguration> } modifier - The contentModifier of progress.
     * @returns { ProgressAttribute } the attribute of the progress.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    contentModifier(modifier: ContentModifier<ProgressConfiguration> | undefined): this;
    attributeModifier(modifier: AttributeModifier<ProgressAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * ProgressConfiguration used by progress contentModifier
 *
 * @extends CommonConfiguration<ProgressConfiguration>
 * @interface ProgressConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ProgressConfiguration extends CommonConfiguration<ProgressConfiguration> {
    /**
     * The value of Progress.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: number;
    /**
     * The total of Progress.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    total: number;
}
/**
 * Called when the progress bar is set.
 *
 * @param { ProgressOptions } options
 * @returns { ProgressAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Progress(
    options: ProgressOptions, 
    @memo
    content_?: () => void,
): ProgressAttribute