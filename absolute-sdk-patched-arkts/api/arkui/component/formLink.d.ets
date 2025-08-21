/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
/**
 * Defines the FormLink options.
 *
 * @interface FormLinkOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface FormLinkOptions {
    /**
     * Action types: "router" and "message".
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    action: string;
    /**
     * Module name of destination UIAbility.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    moduleName?: string;
    /**
     * Bundle name of destination UIAbility.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    bundleName?: string;
    /**
     * Name of destination UIAbility.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    abilityName?: string;
    /**
     * uri of destination UIAbility.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    uri?: string;
    /**
     * The additional parameters, use JSON format key value pairs for content.
     *
     * @type { ?Object }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    params?: Object;
}
export declare interface FormLinkAttribute extends CommonMethod {
    attributeModifier(modifier: AttributeModifier<FormLinkAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Init FormLink component with options.
 *
 * @param { FormLinkOptions } options
 * @returns { FormLinkAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function FormLink(
    options: FormLinkOptions, 
    @memo
    content_?: () => void,
): FormLinkAttribute