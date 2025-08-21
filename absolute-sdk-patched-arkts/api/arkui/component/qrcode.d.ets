/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
import { ResourceColor, ResourceStr } from './units';
import { Resource } from '../../global/resource';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
export declare interface QRCodeAttribute extends CommonMethod {
    /**
     * Called when the QR code color is set.
     *
     * @param { ResourceColor } value
     * @returns { QRCodeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    color(value: ResourceColor | undefined): this;
    /**
     * Called when setting the QR code background color.
     *
     * @param { ResourceColor } value
     * @returns { QRCodeAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundColor(value: ResourceColor | undefined): this;
    /**
     * Set the opacity of the QR code content color.
     * @param { number | Resource } value - indicates the opacity of the QR code content color. The value is between 0 and 1, with a default value of 1.
     * @returns { QRCodeAttribute } the attribute of the QR code
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    contentOpacity(value: number | Resource | undefined): this;
    attributeModifier(modifier: AttributeModifier<QRCodeAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Called when a QR code is set.
 *
 * @param { ResourceStr } value
 * @returns { QRCodeAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function QRCode(
    value: ResourceStr, 
    @memo
    content_?: () => void,
): QRCodeAttribute