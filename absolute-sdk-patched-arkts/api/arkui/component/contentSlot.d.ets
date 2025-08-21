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
import { Content } from '../../@ohos.arkui.node';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';

/**
 * Define ContentSlot attribute, to prevent improper recursive usage of ContentSlot
 *
 * @interface ContentSlotAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ContentSlotAttribute {
}

/**
 * ContentSlot is returned when the parameter is transferred.
 *
 * @param { Content } content - Indicates the class object of NodeContent.
 * @param { function } [content_]
 * @returns { ContentSlotAttribute } The attribute of the ContentSlot.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function ContentSlot(
    content: Content, 
    @memo
    content_?: () => void,
): ContentSlotAttribute
