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
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * The FlowItemAttribute.
 * 
 * @extends CommonMethod
 * @interface FlowItemAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface FlowItemAttribute extends CommonMethod {
    /**
     * Call attributeModifier.
     *
     * @param { AttributeModifier<FlowItemAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<FlowItemAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines FlowItem Component
 *
 * @param { function } [content_] - container
 * @returns { FlowItemAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function FlowItem(
    @memo
    content_?: () => void,
): FlowItemAttribute