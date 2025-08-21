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
export declare interface RowSplitAttribute extends CommonMethod {
    /**
     * Called when judging whether the split line can be dragged.
     *
     * @param { boolean } value
     * @returns { RowSplitAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default resizeable(value: boolean | undefined): this;
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<RowSplitAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { RowSplitAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<RowSplitAttribute> | AttributeModifier<CommonMethod>
        | undefined): this;
}

@memo
@ComponentBuilder
export declare function RowSplit(
    
    @memo
    content_?: () => void,
): RowSplitAttribute
