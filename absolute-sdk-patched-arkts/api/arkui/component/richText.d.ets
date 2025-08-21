/*
 * Copyright (c) 2021 Huawei Device Co., Ltd.
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
export declare interface RichTextAttribute extends CommonMethod {
    /**
     * Triggered when the RichText loading starts.
     *
     * @param { function } callback
     * @returns { RichTextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onStart(callback: (() => void) | undefined): this;
    /**
     * Triggered when the RichText loading ends.
     *
     * @param { function } callback
     * @returns { RichTextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onComplete(callback: (() => void) | undefined): this;
    attributeModifier(modifier: AttributeModifier<RichTextAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Set value.
 *
 * @param { string } content
 * @returns { RichTextAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function RichText(
    content: string, 
    @memo
    content_?: () => void,
): RichTextAttribute