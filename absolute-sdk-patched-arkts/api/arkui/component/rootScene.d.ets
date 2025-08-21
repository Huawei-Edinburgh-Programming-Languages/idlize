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
 * Defines the session of RootScene.
 *
 * @interface RootSceneSession
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
export interface RootSceneSession {
}
export declare interface RootSceneAttribute extends CommonMethod {
    attributeModifier(modifier: AttributeModifier<RootSceneAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Called when the RootScene is used.
 *
 * @param { RootSceneSession } session - indicates the session of RootScene.
 * @returns { RootSceneAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
@memo
@ComponentBuilder
export declare function RootScene(
    session: RootSceneSession, 
    @memo
    content_?: () => void,
): RootSceneAttribute