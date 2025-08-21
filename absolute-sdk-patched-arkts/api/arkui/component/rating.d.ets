'use static'
/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { CommonConfiguration, Callback, CommonMethod, Optional, ContentModifier, Bindable } from './common';
import { ResourceStr } from './units';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Define options used to construct a rating.
 *
 * @interface RatingOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RatingOptions {
    /**
     * Rating option.
     *
     * @type { number | undefined | Bindable<number> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    rating: number | undefined | Bindable<number>;
    /**
     * Indicator option.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    indicator?: boolean;
}
/**
 * Define star style options.
 *
 * @interface StarStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface StarStyleOptions {
    /**
     * Background URI option.
     * Anonymous Object Rectification.
     *
     * @type { ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundUri: ResourceStr;
    /**
     * Foreground URI option.
     * Anonymous Object Rectification.
     *
     * @type { ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    foregroundUri: ResourceStr;
    /**
     * Secondary URI option.
     * Anonymous Object Rectification.
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    secondaryUri?: ResourceStr;
}
/**
 * RatingConfiguration used by rating content modifier.
 *
 * @extends CommonConfiguration<RatingConfiguration>
 * @interface RatingConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RatingConfiguration extends CommonConfiguration<RatingConfiguration> {
    /**
     * Current number of Rating.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    rating: number;
    /**
     * Indicates whether Rating is used as an indicator.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    indicator: boolean;
    /**
     * Total stars of Rating.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stars: number;
    /**
     * The step size of the Rating.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stepSize: number;
    /**
     * Trigger Rating select change.
     *
     * @type { Callback<number> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    triggerChange: Callback<number>;
}
/**
 * Callback of the star rating of the operation scoring bar changes event.
 *
 * @typedef {function} OnRatingChangeCallback
 * @param {number} rating - The rating of the rating bar.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnRatingChangeCallback = (rating: number) => void;
/**
 * Defines the Rating component attributes.
 *
 * @extends CommonMethod
 * @interface RatingAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RatingAttribute extends CommonMethod {
    /**
     * Called when the total number of stars is set.
     *
     * @param { number | undefined } value
     * @returns { RatingAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stars(value: number | undefined): this;
    /**
     * Called when the step size of the operation rating.
     *
     * @param { number | undefined } value
     * @returns { RatingAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stepSize(value: number | undefined): this;
    /**
     * Called when a picture is set.
     * Anonymous Object Rectification.
     *
     * @param { StarStyleOptions | undefined } options - star style options
     * @returns { RatingAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    starStyle(options: StarStyleOptions | undefined): this;
    /**
     * Called when the star rating of the operation scoring bar changes.
     *
     * @param { OnRatingChangeCallback | undefined } callback
     * @returns { RatingAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onChange(callback: OnRatingChangeCallback | undefined): this;
    /**
     * Set the content modifier of rating.
     *
     * @param { ContentModifier<RatingConfiguration> | undefined } modifier - The content modifier of rating.
     * @returns { RatingAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    contentModifier(modifier: ContentModifier<RatingConfiguration> | undefined): this;
    /**
     * Set the attribute modifier of rating.
     *
     * @param { AttributeModifier<RatingAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     *     The attribute modifier of rating.
     * @returns { RatingAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    attributeModifier(modifier: AttributeModifier<RatingAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines Rating Component.
 *
 * @param { RatingOptions } [options] - the options of Rating.
 * @param { function } [content_] - container
 * @returns { RatingAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Rating(
    options?: RatingOptions,
    @memo
    content_?: () => void,
): RatingAttribute
