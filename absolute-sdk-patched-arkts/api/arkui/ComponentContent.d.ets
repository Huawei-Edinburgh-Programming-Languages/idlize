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

import { BuildOptions } from './BuilderNode';
import { Content } from './Content';
import { UIContext } from '../@ohos.arkui.UIContext';
import { WrappedBuilder, CustomBuilder, CustomBuilderT } from './component/builder';
/**
 * Defines the base class for ComponentContent.
 *
 * @extends Content
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export abstract class ComponentContentBase extends Content {
}

/**
 * Defines ComponentContent.
 *
 * @extends ComponentContentBase
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class ComponentContent<T = undefined> extends ComponentContentBase {
  /**
   * Constructor.
   *
   * @param { UIContext } uiContext - uiContext used to create the ComponentContent
   * @param { WrappedBuilder<CustomBuilder> } builder - Defined the builder will be called to build ComponentContent.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(uiContext: UIContext, builder: WrappedBuilder<CustomBuilder>);

  /**
   * Constructor.
   *
   * @param { UIContext } uiContext - uiContext used to create the ComponentContent
   * @param { WrappedBuilder<CustomBuilderT<T>> } builder - Defined the builder will be called to build
   * ComponentContent.
   * @param { T } args - Parameters used to update the ComponentContent.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(uiContext: UIContext, builder: WrappedBuilder<CustomBuilderT<T>>, args: T);

  /**
   * Constructor.
   *
   * @param { UIContext } uiContext - uiContext used to create the ComponentContent
   * @param { WrappedBuilder<CustomBuilderT<T>> } builder - Defined the builder will be called to build
   * ComponentContent.
   * @param { T } args - Parameters used to update the ComponentContent.
   * @param { BuildOptions } options - Defined the options will be used when build.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(uiContext: UIContext, builder: WrappedBuilder<CustomBuilderT<T>>, args: T, options: BuildOptions);


  /**
   * Update the ComponentContent based on the provided parameters.
   *
   * @param { T } args - Parameters used to update the ComponentContent, which must match the types required by the
   * builder bound to the ComponentContent.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  update(args: T): void;

  /**
   * Reuse the ComponentContent based on the provided parameters.
   *
   * @param { Object } [param] - Parameters for reusing ComponentContent.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  reuse(param?: Object): void;

  /**
   * Recycle the ComponentContent.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  recycle(): void;

  /**
   * Dispose the ComponentContent immediately.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  dispose(): void;

  /**
   * Notify ComponentContent to update the configuration to trigger a reload of the ComponentContent.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  updateConfiguration(): void;
}
