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
import { CommonMethod } from './common';
import { LengthMetrics } from '../Graphics';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";

/**
 * The LazyGridLayoutAttribute.
 * 
 * @extends CommonMethod
 * @interface LazyGridLayoutAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LazyGridLayoutAttribute extends CommonMethod {
    /**
     * The spacing between rows.
     *
     * @param { LengthMetrics | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default rowsGap(value: LengthMetrics | undefined): this;
    /**
     * The spacing between columns.
     *
     * @param { LengthMetrics | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default columnsGap(value: LengthMetrics | undefined): this;
}

/**
 * The LazyVGridLayoutAttribute
 * 
 * @extends LazyGridLayoutAttribute
 * @interface LazyVGridLayoutAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LazyVGridLayoutAttribute extends LazyGridLayoutAttribute {
    /**
     * This parameter specifies the number of columns in the current grid layout.
     *
     * @param { string | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default columnsTemplate(value: string | undefined): this;
    /**
     * Called attributeModifier.
     *
     * @param { AttributeModifier<LazyVGridLayoutAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<LazyVGridLayoutAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines LazyVGridLayout Component.
 *
 * @param { function } [content_] - container
 * @returns { LazyVGridLayoutAttribute } The attribute of the grid
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function LazyVGridLayout(
    @memo
    content_?: () => void,
): LazyVGridLayoutAttribute