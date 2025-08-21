'use static';
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
 * @arkts 1.2
 */

import { UIContext } from '../@ohos.arkui.UIContext';
import { FrameNode } from './FrameNode';
import { Size } from './Graphics';
import { TouchEvent, MouseEvent, AxisEvent } from './component/common';
import { WrappedBuilder, CustomBuilder, CustomBuilderT } from './component/builder';

/**
 * Render type of the node using for indicating that
 * if the node will be shown on the display or rendered to a texture
 *
 * @enum { number } Render type
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum NodeRenderType {
  /**
   * Display type.The node will be shown on the display.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  RENDER_TYPE_DISPLAY = 0,

  /**
   * Exporting texture type.The node will be render to a  texture.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  RENDER_TYPE_TEXTURE = 1
}

/**
 * RenderOptions info.
 *
 * @interface RenderOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface RenderOptions {
  /**
   * The ideal size of the node.
   * @type { ?Size } selfIdealSize - The ideal size of the node
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  selfIdealSize?: Size;

  /**
   * Render type of the node.
   * @type { ?NodeRenderType } type - Render type of the node
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  type?: NodeRenderType;

  /**
   * The surfaceId of a texture consumer
   * @type { ?string } surfaceId - surfaceId of a consumer who can receive the texture of the Node
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  surfaceId?: string;
}


/**
 * BuildOptions info.
 *
 * @interface BuildOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface BuildOptions {
  /**
   * Whether support the BuilderNode parallel creation.
   * @type { ?boolean } useParallel - Indicates whether use parallel.
   * @default false
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  useParallel?: boolean;
}

/**
 * Defines BuilderNode.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class BuilderNode<T = undefined> {
  /**
   * Constructor.
   *
   * @param { UIContext } uiContext - uiContext used to create the BuilderNode
   * @param { RenderOptions } [options] - Render options of the Builder Node
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(uiContext: UIContext, options?: RenderOptions);
  /**
   * Build the BuilderNode with the builder.
   *
   * @param {  WrappedBuilder<CustomBuilder> } builder - Defined the builder will be called to build the node.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  build(builder: WrappedBuilder<CustomBuilder>): void;
  /**
   * Build the BuilderNode with the builder.
   *
   * @param { WrappedBuilder<CustomBuilderT<T>> } builder - Defined the builder will be called to build the node.
   * @param { T } arg - Defined the args will be used in the builder.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  build(builder: WrappedBuilder<CustomBuilderT<T>>, arg: T): void;

  /**
   * Build the BuilderNode with the builder.Support the type that WrappedBuilder contains builder used different params.
   *
   * @param { WrappedBuilder<CustomBuilderT<T>> } builder - Defined the builder will be called to build the node.
   * @param { T } arg - Defined the args will be used in the builder.
   * @param { BuildOptions } options - Defined the options will be used when build.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  build(builder: WrappedBuilder<CustomBuilderT<T>>, arg: T, options: BuildOptions): void;

  /**
   * Update the BuilderNode based on the provided parameters.
   *
   * @param { T } arg - Parameters used to update the BuilderNode, which must match the types required by the builder
   *     bound to the BuilderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  update(arg: T): void;

  /**
   * Get the FrameNode in BuilderNode.
   *
   * @returns { FrameNode | null } - Returns a FrameNode inside the BuilderNode, or null if not contained.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  getFrameNode(): FrameNode | null;

  /**
   * Dispatch touchEvent to targetNode.
   *
   * @param { TouchEvent } event - The touchEvent which will be sent to the targetNode.
   * @returns { boolean } - Returns true if the TouchEvent has been successfully posted to the targetNode, false
   * otherwise.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  postTouchEvent(event: TouchEvent): boolean;

  /**
   * Dispose the BuilderNode immediately.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  dispose(): void;

  /**
   * Reuse the BuilderNode based on the provided parameters.
   *
   * @param { Object } [param] - Parameters for reusing BuilderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  reuse(param?: Object): void;

  /**
   * Recycle the BuilderNode.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  recycle(): void;

  /**
   * Notify BuilderNode to update the configuration to trigger a reload of the BuilderNode.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  updateConfiguration(): void;

  /**
   * Get if the BuilderNode is disposed.
   *
   * @returns { boolean } - Returns true if the BuilderNode is disposed, false otherwise.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  isDisposed(): boolean;

  /**
   * Dispatch the event to targetNode.
   *
   * @param { InputEventType  } event - The event which will be sent to the targetNode.
   * @returns { boolean } - Returns true if the event has been successfully posted to the targetNode,
   *     false otherwise.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  postInputEvent(event: InputEventType): boolean;

  /**
   * Set if the BuilderNode inherits the freezing policy of the parent CustomComponent, ComponentContent,
   * or BuilderNode.
   *
   * @param { boolean } enabled - If the BuilderNode inherits the freezing policy of the parent CustomComponent,
   *     ComponentContent, or BuilderNode.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  inheritFreezeOptions(enabled: boolean): void;
}

/**
 * Defines the event type used for posting.
 *
 * @typedef { TouchEvent | MouseEvent | AxisEvent } InputEventType
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
declare type InputEventType = TouchEvent | MouseEvent | AxisEvent;
