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

import { Resource } from '../../global/resource';
import { Length, ResourceColor, Dimension } from './units';
import { CommonMethod, PixelMap, Bindable, DividerStyle } from './common';
import { memo, ComponentBuilder } from './../stateManagement/runtime';

/**
 * Sets the sidebar style of showing
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SideBarContainerType {
  /**
   * The sidebar invisible
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  Embed,

  /**
   * The sidebar visible
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  Overlay,

  /**
   * The sidebar AUTO
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  AUTO
}

/**
 * Sets the sidebar position of showing
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SideBarPosition {
  /**
   * The sidebar is on the Start of the container
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  Start,

  /**
   * The sidebar is on the End of the container
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  End
}

/**
 * ButtonStyle icons.
 *
 * @typedef ButtonIconOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ButtonIconOptions {
  /**
   * Defines whether an icon is shown.
   *
   * Anonymous Object Rectification.
   * @type { string | PixelMap | Resource }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  shown: string | PixelMap | Resource;

  /**
   * Defines whether an icon is hidden.
   *
   * Anonymous Object Rectification.
   * @type { string | PixelMap | Resource }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  hidden: string | PixelMap | Resource;

  /**
   * Defines whether an icon is switching.
   *
   * Anonymous Object Rectification.
   * @type { ?(string | PixelMap | Resource) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  switching?: string | PixelMap | Resource;
}

/**
 * Sets the control button style
 *
 * @interface ButtonStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ButtonStyle {
  /**
   * Set the left of control button
   * default value is 16vp.
   *
   * @type { ?number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  left?: number;

  /**
   * Set the top of control button
   * default value is 48vp.
   *
   * @type { ?number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: number;

  /**
   * Set the width of control button
   * default value is 24vp.
   *
   * @type { ?number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  width?: number;

  /**
   * Set the height of control button
   * default value is 24vp.
   *
   * @type { ?number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  height?: number;

  /**
   * Set the button icon when sidebar status has changed
   *
   * @type { ?ButtonIconOptions }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  icons?: ButtonIconOptions;
}

/**
 * The attribute function of sidebar
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface SideBarContainerAttribute extends CommonMethod {
  /**
   * Callback showControlButton function when setting the status of sidebar
   *
   * @param { boolean | Bindable<boolean> | undefined } value
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  showSideBar(value: boolean | Bindable<boolean> | undefined): this;

  /**
   * Callback controlButton function when setting the style of button
   *
   * @param { ButtonStyle | undefined } value
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  controlButton(value: ButtonStyle | undefined): this;

  /**
   * Callback showControlButton function when setting the status of button
   *
   * @param { boolean | undefined } value
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  showControlButton(value: boolean | undefined): this;

  /**
   * Trigger callback when sidebar style of showing change finished.
   *
   * @param { function | undefined } callback
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onChange(callback: ((value: boolean) => void) | undefined): this;

  /**
   * Sets the length of sidebar.
   * default value is 240vp.
   *
   * @param { Length | Bindable<Length> | undefined } value
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  sideBarWidth(value: Length | Bindable<Length> | undefined): this;

  /**
   * Sets the min length of sidebar.
   * default value is 240vp.
   *
   * @param { number | undefined } value
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  minSideBarWidth(value: number | undefined): this;

  /**
   * Sets the max length of sidebar.
   * default value is 280vp.
   *
   * @param { number | undefined } value
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  maxSideBarWidth(value: number | undefined): this;

  /**
   * Sets the min length of sidebar.
   * default value is 200vp.
   *
   * @param { Length | undefined } value
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  minSideBarWidth(value: Length | undefined): this;

  /**
   * Sets the max length of sidebar.
   * default value is 280vp.
   *
   * @param { Length | undefined } value
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  maxSideBarWidth(value: Length | undefined): this;

  /**
   * Sets whether to automatically hide when drag sidebar width is less than the minimum width.
   * default value is true.
   *
   * @param { boolean | undefined } value
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  autoHide(value: boolean | undefined): this;

  /**
   * Called when determining the location of the sidebar.
   * default value is SideBarPosition.Start.
   *
   * @param { SideBarPosition | undefined } value
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  sideBarPosition(value: SideBarPosition | undefined): this;

  /**
   * Set divider style for sideBarContainer
   *
   * @param { DividerStyle | null | undefined } value - indicates the style of the divider or whether to show the divider.
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  divider(value: DividerStyle | null | undefined): this;

  /**
   * Sets the min length of content.
   * default value is 360vp.
   *
   * @param { Dimension | undefined } value - min length of content.
   * @returns { SideBarContainerAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  minContentWidth(value: Dimension | undefined): this;
}

@memo
@ComponentBuilder
export declare function SideBarContainer(
  type?: SideBarContainerType,
  @memo
  content_?: () => void,
): SideBarContainerAttribute
