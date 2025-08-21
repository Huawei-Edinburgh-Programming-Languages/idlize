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
import { Callback, Optional, CommonMethod, Bindable } from './common';
import { CustomBuilder } from './builder';
import { ResourceStr } from './units';
import { ComponentContent } from '../ComponentContent';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * The refresh status of the drop-down refresh.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum RefreshStatus {
    /**
     * The refresh status of the drop-down refresh.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    Inactive,
    /**
     * Drop down, but the drop-down distance is less than the refresh distance.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    Drag,
    /**
     * The pull-down exceeds the refresh distance.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    OverDrag,
    /**
     * After the pull-down, it rebounds to the refresh distance and enters the refresh state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    Refresh,
    /**
     * After refresh, return to the initial state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    Done
}
/**
 * Defines the options of refresh component.
 *
 * @interface RefreshOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export interface RefreshOptions {
    /**
     * Whether the current component is being refreshed.
     * This parameter supports $$ for two-way binding of variables.
     *
     * @type { boolean | Bindable<boolean> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    refreshing: boolean | Bindable<boolean>;
    /**
     * The text displayed during refreshing
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    promptText?: ResourceStr;
    /**
     * Custom component to display during dragging.
     *
     * @type { ?CustomBuilder }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    builder?: CustomBuilder;
    /**
     * Custom component to display during dragging.
     *
     * @type { ?ComponentContent }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    refreshingContent?: ComponentContent;
}
/**
 * The RefreshAttribute.
 * 
 * @extends CommonMethod
 * @interface RefreshAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface RefreshAttribute extends CommonMethod {
    /**
     * Called when the refresh state changes.
     *
     * @param { function | undefined } callback
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onStateChange(callback: ((state: RefreshStatus) => void) | undefined): this;
    /**
     * Called when the refresh state is entered.
     *
     * @param { function | undefined } callback
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onRefreshing(callback: (() => void) | undefined): this;
    /**
     * The pull-down offset to trigger refresh.
     *
     * @param { number | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default refreshOffset(value: number | undefined): this;
    /**
     * Sets whether to trigger refresh when the pull-down distance exceeds the refreshOffset.
     *
     * @param { boolean | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default pullToRefresh(value: boolean | undefined): this;
    /**
     * Called when the refresh offset changed.
     * The unit is vp.
     *
     * @param { Callback<number> | undefined } callback
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onOffsetChange(callback: Callback<number> | undefined): this;
    /**
     * Pull-down follow ratio for Refresh.
     *
     * @param { number | undefined } ratio - Pull-down follow ratio for Refresh.
     * @returns { this } The attribute of the Refresh.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default pullDownRatio(ratio: number | undefined): this;
    /**
     * Called attributeModifier.
     *
     * @param { AttributeModifier<RefreshAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<RefreshAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines Refresh Component.
 *
 * @param { RefreshOptions } value - value
 * @param { function } [content_] - container
 * @returns { RefreshAttribute } The attribute of the grid
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Refresh(
    value: RefreshOptions, 
    @memo
    content_?: () => void,
): RefreshAttribute