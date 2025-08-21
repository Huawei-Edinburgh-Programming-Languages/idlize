/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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
import { CommonMethod } from './common';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Round rect.
 *
 * @interface RRect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
export interface RRect {
    /**
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    left: number;
    /**
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    top: number;
    /**
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    width: number;
    /**
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    height: number;
    /**
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    radius: number;
}
/**
 * Window animation target.
 *
 * @interface WindowAnimationTarget
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
export interface WindowAnimationTarget {
    /**
     * @type { string }
     * @readonly
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    readonly bundleName: string;
    /**
     * @type { string }
     * @readonly
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    readonly abilityName: string;
    /**
     * @type { RRect }
     * @readonly
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    readonly windowBounds: RRect;
    /**
     * @type { number }
     * @readonly
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    readonly missionId: number;
}
export declare interface RemoteWindowAttribute extends CommonMethod {
    attributeModifier(modifier: AttributeModifier<RemoteWindowAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Called when the remote window interface is used.
 *
 * @param { WindowAnimationTarget } target
 * @returns { RemoteWindowAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
@memo
@ComponentBuilder
export declare function RemoteWindow(
    target: WindowAnimationTarget, 
    @memo
    content_?: () => void,
): RemoteWindowAttribute