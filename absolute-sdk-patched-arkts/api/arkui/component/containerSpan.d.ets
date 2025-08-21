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
import { TextBackgroundStyle } from "./span";
import { AttributeModifier, CommonMethod } from "./common";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";

/**
 * Define the ContainerSpan attribute functions.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface ContainerSpanAttribute {
    /**
     * Span background style.
     *
     * @param { TextBackgroundStyle | undefined } style - The background style of span.
     * @returns { ContainerSpanAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textBackgroundStyle(style: TextBackgroundStyle | undefined): this;
    /**
     * Sets the attribute modifier.
     *
     * @param { AttributeModifier<ContainerSpanAttribute> | undefined } modifier.
     * @returns { ContainerSpanAttribute } the attribute of the ContainerSpanAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<ContainerSpanAttribute> | undefined): this;
}

/**
 * Defines ContainerSpan Component.
 *
 * @param { function } [content_]
 * @returns { ContainerSpanAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
@memo
@ComponentBuilder
export declare function ContainerSpan(
    @memo
    content_?: () => void,
): ContainerSpanAttribute