'use static'
/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
 * @kit ArkUI
 * @arkts 1.2
 */

import { Builder } from './builder';
import { ExtendableComponent } from './extendableComponent';
import { IDecoratedV1Variable } from '../stateManagement/decorator';

/**
 * Defines the info of compatible custom component.
 *
 * @typedef CompatibleComponentInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface CompatibleComponentInfo {
    /**
     * the name of compatible custom component
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    name: string;

    /**
     * the compatible custom component
     *
     * @type { ESValue }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    component: ESValue;
}

/**
 * Defines the callback for initializing compatible custom component.
 *
 * @typedef { function } CompatibleInitCallback
 * @returns { CompatibleComponentInfo } the info of compatible custom component
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type CompatibleInitCallback = () => CompatibleComponentInfo;

/**
 * Defines the callback for updating compatible custom component.
 *
 * @typedef { function } CompatibleUpdateCallback
 * @param { ESValue } component - the compatible custom component
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type CompatibleUpdateCallback = (component: ESValue) => void;

/**
 * Obtains the compatible custom component.
 *
 * @param { CompatibleInitCallback } init - the callback for initializing compatible custom component
 * @param { CompatibleUpdateCallback } update - the callback for updating compatible custom component
 * @param { ExtendableComponent } [component] - the custom component
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Builder
export declare function compatibleComponent(
    init: CompatibleInitCallback,
    update: CompatibleUpdateCallback,
    component?: ExtendableComponent
): void;

/**
 * Obtains the compatible state.
 *
 * @param { IDecoratedV1Variable<T> } state - the source state
 * @returns { ESValue } the compatible state
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare function getCompatibleState<T>(state: IDecoratedV1Variable<T>): ESValue;

/**
 * Obtains the compatible WrappedBuilder.
 *
 * @param { Any } builder - the WrappedBuilder
 * @param { FixedArray<ESValue> } args - the parameters of WrappedBuilder
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Builder
export declare function compatibleWrappedBuilder(builder: Any, ...args: FixedArray<ESValue>): void;

/**
 * Transfer compatible Builder
 * 
 * @param { T } builder - the source builder
 * @returns { ESValue } the comaptible builder
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare function transferCompatibleBuilder<T extends Function>(@Builder builder: T): ESValue;
