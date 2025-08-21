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
import { CommonShapeMethod, AttributeModifier, CommonMethod } from "./common";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";

/**
 * Ellipse constructor options.
 *
 * @interface EllipseOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface EllipseOptions {
    /**
     * Set width.
     *
     * @type { ?(string | double) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    width?: string | double;
    /**
     * Set height.
     *
     * @type { ?(string | double) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    height?: string | double;
}

/**
 * Provides attribute for Ellipse.
 * @extends CommonShapeMethod
 * @interface EllipseAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface EllipseAttribute extends CommonShapeMethod {
    /**
     * Call attributeModifier.
     *
     * @param { AttributeModifier<EllipseAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { EllipseAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<EllipseAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Ellipse is returned when the parameter is transferred.
 *
 * @param { EllipseOptions } [options] - The options to create an Ellipse
 * @param { function } [content_]
 * @returns { EllipseAttribute } The attribute of the Ellipse.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Ellipse(
    options?: EllipseOptions, 
    @memo
    content_?: () => void,
): EllipseAttribute
