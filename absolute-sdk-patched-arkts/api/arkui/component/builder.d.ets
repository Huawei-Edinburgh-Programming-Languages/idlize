'use static'
/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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

import { memo, ComponentBuilder, __memo_context_type, __memo_id_type } from "../stateManagement/runtime";

/**
 * Defines Builder Annotation.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface Builder {}

/**
 * Defines BuilderParam Annotation.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
@Retention({policy: "SOURCE"})
export declare @interface BuilderParam {}

/**
 * Defines the CustomBuilder Type.
 *
 * @typedef { @Builder (() => void) } CustomBuilder
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export type CustomBuilder = @Builder (() => void);

/**
 * Defines the CustomBuilder Type.
 *
 * @typedef { @Builder ((t:T) => void) } CustomBuilderT
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export type CustomBuilderT<T> = @Builder ((t: T) => void);

/**
 * Defines the PageMapBuilder Type.
 *
 * @typedef { @Builder ((name: string, param: Object | null | undefined) => void) } PageMapBuilder
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export type PageMapBuilder = @Builder ((name: string, param: Object | null | undefined) => void)

/**
 * Defining wrapBuilder function.
 * @param { function } builder
 * @returns { WrappedBuilder<T> }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare function wrapBuilder<T>(builder: T): WrappedBuilder<T>;

/**
 * Defines the WrappedBuilder class.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class WrappedBuilder<T> {

  /**
   * @type { function }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  @Builder public builder: T;

  /**
   * @param { function } builder
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  public constructor(builder: T);
}
