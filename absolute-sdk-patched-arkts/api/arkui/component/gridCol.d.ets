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
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Defines the option in number unit of grid-container child component.
 *
 * @interface GridColColumnOption
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GridColColumnOption {
    /**
     * Grid Col Column Option xs
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xs?: number;
    /**
     * Grid Col Column Option sm
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    sm?: number;
    /**
     * Grid Col Column Option md
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    md?: number;
    /**
     * Grid Col Column Option lg
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    lg?: number;
    /**
     * Grid Col Column Option xl
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xl?: number;
    /**
     * Grid Col Column Option xxl
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xxl?: number;
}
/**
 * Defines the options of grid-container child component.
 *
 * @interface GridColOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GridColOptions {
    /**
     * Sets the span of current gird-container item.
     *
     * @type { ?(number | GridColColumnOption) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    span?: number | GridColColumnOption;
    /**
     * Sets the offset of current gird-container item.
     *
     * @type { ?(number | GridColColumnOption) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offset?: number | GridColColumnOption;
    /**
     * Sets the order of current gird-container item.
     *
     * @type { ?(number | GridColColumnOption) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    order?: number | GridColColumnOption;
}
export declare interface GridColAttribute extends CommonMethod {
    /**
     * Sets the span of current gird-container item.
     *
     * @param { number | GridColColumnOption } value
     * @returns { GridColAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default span(value: number | GridColColumnOption | undefined): this;
    /**
     * Sets the offset of current gird-container item.
     *
     * @param { number | GridColColumnOption } value
     * @returns { GridColAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default gridColOffset(value: number | GridColColumnOption | undefined): this;
    /**
     * Sets the order of current gird-container item.
     *
     * @param { number | GridColColumnOption } value
     * @returns { GridColAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default order(value: number | GridColColumnOption | undefined): this;
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<GridColAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { GridColAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<GridColAttribute> | AttributeModifier<CommonMethod>
        | undefined): this;
}

@memo
@ComponentBuilder
export declare function GridCol(
    option?: GridColOptions, 
    @memo
    content_?: () => void,
): GridColAttribute
