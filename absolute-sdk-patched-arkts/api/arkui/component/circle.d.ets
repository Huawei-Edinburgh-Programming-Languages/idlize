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
import { CommonShapeMethod, CommonMethod, AttributeModifier } from "./common";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";

/**
 * Defines circle options for Circle component.
 *
 * @interface CircleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CircleOptions {
    /**
     * Defines the width property.
     *
     * @type { ?(string | double) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    width?: string | double;
    /**
     * Defines the height property.
     *
     * @type { ?(string | double) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    height?: string | double;
}

/**
 * Circle drawing component attribute functions.
 *
 * @extends CommonShapeMethod
 * @interface
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CircleAttribute extends CommonShapeMethod {
    /**
     * Call attributeModifier.
     *
     * @param { AttributeModifier<CircleAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { CircleAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<CircleAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Circle is returned when the parameter is transferred.
 *
 * @param { CircleOptions } [options] - The options to create a Circle
 * @param { function } [content_]
 * @returns { CircleAttribute } The attribute of the Circle.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Circle(
    options?: CircleOptions, 
    @memo
    content_?: () => void,
): CircleAttribute
