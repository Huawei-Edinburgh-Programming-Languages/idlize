'use static';
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

import { NodeController } from '../../@ohos.arkui.node';
import { CommonMethod, AttributeModifier } from './common';
import { memo, ComponentBuilder } from './../stateManagement/runtime';

/**
 * The NodeContainerAttribute.
 *
 * @extends CommonMethod
 * @interface TabsAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface NodeContainerAttribute extends CommonMethod {
    /**
     * Sets the attribute modifier.
     *
     * @param { AttributeModifier<NodeContainerAttribute> | AttributeModifier<CommonMethod> | undefined } modifier -
     *     instance of NodeController
     * @return { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    attributeModifier(
        modifier: AttributeModifier<NodeContainerAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines NodeContainer Component.
 *
 * @param { NodeController } controller - instance of NodeController
 * @param { function } [content_ ] - container
 * @return { NodeContainerAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function NodeContainer(
    controller: NodeController, 
    @memo
    content_?: () => void,
): NodeContainerAttribute