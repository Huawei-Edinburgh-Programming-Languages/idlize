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
import { CommonMethod, ContentModifier, CommonConfiguration } from './common';
import { ResourceColor } from './units';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Load style of progress bar.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum LoadingProgressStyle {
    /**
     * Default style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Default,
    /**
     * Announcement style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Circular,
    /**
     * The style of the track.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Orbital
}
export declare interface LoadingProgressAttribute extends CommonMethod {
    /**
     * Load the color of the progress bar.
     *
     * @param { ResourceColor } value
     * @returns { LoadingProgressAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    color(value: ResourceColor | undefined): this;
    /**
     * Whether to display the LoadingProgress content.
     *
     * @param { boolean } value - indicates the state of LoadingProgress content
     * @returns { LoadingProgressAttribute } the attribute of the LoadingProgress.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableLoading(value: boolean | undefined): this;
    /**
     * Set the content modifier of loadingProgress.
     *
     * @param { ContentModifier<LoadingProgressConfiguration> } modifier - The contentModifier of LoadingProgress.
     * @returns { LoadingProgressAttribute} the attribute of the loading progress
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    contentModifier(modifier: ContentModifier<LoadingProgressConfiguration> | undefined): this;
    attributeModifier(modifier: AttributeModifier<LoadingProgressAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * LoadingProgressConfiguration used by LoadingProgress contentModifier
 *
 * @extends CommonConfiguration<LoadingProgressConfiguration>
 * @interface LoadingProgressConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LoadingProgressConfiguration extends CommonConfiguration<LoadingProgressConfiguration> {
    /**
     * Whether to enable the LoadingProgress content.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableLoading: boolean;
}
/**
 * Called when the progress bar progress is viewed.
 *
 * @returns { LoadingProgressAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function LoadingProgress(
    
    @memo
    content_?: () => void,
): LoadingProgressAttribute