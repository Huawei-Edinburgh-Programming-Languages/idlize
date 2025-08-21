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
 * Define options used to construct a path.
 *
 * @interface PathOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface PathOptions {
    /**
     * Width option.
     * @type { ?(double | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    width?: double | string;
    /**
     * Height option.
     * @type { ?(double | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    height?: double | string;
    /**
     * Commands option.
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    commands?: string;
}

/**
 * Provides methods for attribute path component.
 *
 * @extends CommonShapeMethod
 * @interface PathAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface PathAttribute extends CommonShapeMethod {
    /**
     * Called when the command string drawn by the path is set.
     *
     * @param { string | undefined } value
     * @returns { PathAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default commands(value: string | undefined): this;
    /**
     * Call attributeModifier.
     *
     * @param { AttributeModifier<PathAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { PathAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<PathAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Path is returned when the parameter is transferred.
 *
 * @param { PathOptions } [options] - The options to create a Path
 * @param { function } [content_]
 * @returns { PathAttribute } The attribute of the Path.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Path(
    options?: PathOptions, 
    @memo
    content_?: () => void,
): PathAttribute
