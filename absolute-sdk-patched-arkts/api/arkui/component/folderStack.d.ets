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
import window from '../../@ohos.window';
import { FoldStatus, Alignment, AppRotation } from './enums';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Import the WindowStatusType type object for onHoverStatusChange.
 *
 * @typedef { window.WindowStatusType } WindowStatusType
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type WindowStatusType = window.WindowStatusType;
/**
 * FolderStack constructor options.
 *
 * @interface FolderStackOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface FolderStackOptions {
    /**
     * Define the IDs of the sub component that will be moved to the upper half screen when hovering.
     *
     * Anonymous Object Rectification
     * @type { ?Array<string> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    upperItems?: Array<string>;
}
/**
 * Information when onFolderStateChange.
 *
 * @interface OnFoldStatusChangeInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface OnFoldStatusChangeInfo {
    /**
     * Folder state.
     *
     * Anonymous Object Rectification
     * @type { FoldStatus }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    foldStatus: FoldStatus;
}
/**
 * Callback when onStateChangeCallback.
 *
 * Anonymous Object Rectification
 * @typedef { function } OnFoldStatusChangeCallback
 * @param { OnFoldStatusChangeInfo } event - the folding information of the current device
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnFoldStatusChangeCallback = (event: OnFoldStatusChangeInfo) => void;
/**
 * Callback when onHoverStatusChange.
 *
 * Anonymous Object Rectification
 * @typedef { function } OnHoverStatusChangeCallback
 * @param { HoverEventParam } param - hover event param
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnHoverStatusChangeCallback = (param: HoverEventParam) => void;
export declare interface FolderStackAttribute extends CommonMethod {
    /**
     * Set the alignment of folderStack.
     *
     * @param { Alignment } value - align of children
     * @returns { FolderStackAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default alignContent(value: Alignment | undefined): this;
    /**
    * Callback folderState when the folderState changes
    *
    * Anonymous Object Rectification
    * @param { OnFoldStatusChangeCallback } callback - executed when folderStatus changed
    * @returns { FolderStackAttribute }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    default onFolderStateChange(callback: OnFoldStatusChangeCallback | undefined): this;
    /**
     * Callback hoverStatus|folderStatus|rotation|windowMode when the hoverStatus changes
     *
     * Anonymous Object Rectification
     * @param { OnHoverStatusChangeCallback } handler - executed when hoverStatus changed
     * @returns { FolderStackAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onHoverStatusChange(handler: OnHoverStatusChangeCallback | undefined): this;
    /**
     * Enable the animation of folderStack.
     *
     * @param { boolean } value - enable the animation of folderStatus changed
     * @returns { FolderStackAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableAnimation(value: boolean | undefined): this;
    /**
     * Enable auto halfFolder when orientation.
     *
     * @param { boolean } value - enable auto halfFold
     * @returns { FolderStackAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default autoHalfFold(value: boolean | undefined): this;
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<FolderStackAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { FolderStackAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<FolderStackAttribute>
        | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Defines the Embed Data info.
 *
 * @interface HoverEventParam
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface HoverEventParam {
    /**
     * Folder state.
     *
     * @type { FoldStatus }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    foldStatus: FoldStatus;
    /**
     * Is hover mode
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isHoverMode: boolean;
    /**
     * App rotation
     *
     * @type { AppRotation }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    appRotation: AppRotation;
    /**
     * Window status type
     *
     * @type { WindowStatusType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    windowStatusType: WindowStatusType;
}

@memo
@ComponentBuilder
export declare function FolderStack(
    options?: FolderStackOptions, 
    @memo
    content_?: () => void,
): FolderStackAttribute
