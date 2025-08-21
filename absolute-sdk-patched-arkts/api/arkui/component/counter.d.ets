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
import { VoidCallback } from './units';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
export declare interface CounterAttribute extends CommonMethod {
    /**
     * Listen to the event that the value increases.
     * Anonymous Object Rectification.
     *
     * @param { VoidCallback } event
     * @returns { CounterAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onInc(event: VoidCallback | undefined): this;
    /**
     * Listens to the number decrease event.
     * Anonymous Object Rectification.
     *
     * @param { VoidCallback } event
     * @returns { CounterAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDec(event: VoidCallback | undefined): this;
    /**
     * Indicates whether the decrease button of counter component is available or not.
     *
     * @param { boolean } value - If true, the decrease button is available and can respond to operations such as clicking. If false, click operations are not responded.
     * @returns { CounterAttribute } The attribute of the counter.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableDec(value: boolean | undefined): this;
    /**
     * Indicates whether the increase button of counter component is available or not.
     *
     * @param { boolean } value - If true, the increase button is available and can respond to operations such as clicking. If false, click operations are not responded.
     * @returns { CounterAttribute } The attribute of the counter.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableInc(value: boolean | undefined): this;
    attributeModifier(modifier: AttributeModifier<CounterAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Return Counter.
 *
 * @returns { CounterAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Counter(
    
    @memo
    content_?: () => void,
): CounterAttribute