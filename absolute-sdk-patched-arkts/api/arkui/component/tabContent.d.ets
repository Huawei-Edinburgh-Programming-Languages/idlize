'use static'
/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License"),
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

import { CommonMethod } from './common';
import { CustomBuilder } from './builder';
import { TextHeightAdaptivePolicy, TextOverflow, VerticalAlign } from "./enums";
import { Dimension, Font, Length, LocalizedPadding, Padding, Resource, ResourceColor, ResourceStr, VoidCallback } from "./units";
import { ComponentContent } from '../ComponentContent';
import { SymbolGlyphModifier } from '../SymbolGlyphModifier';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";

/**
 * Enum for the mode of the tab bar when selected.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SelectedMode {
  /**
   * Indicator mode.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  INDICATOR = 0,
  /**
   * Board mode.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  BOARD = 1
}
/**
 * Enum for the layout mode of the content in the tab bar.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum LayoutMode {
  /**
   * The the content is laid vertically or horizontally, according to its width.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  AUTO = 0,
  /**
   * The the content is laid vertically
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  VERTICAL = 1,
  /**
   * The the content is laid horizontally
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  HORIZONTAL = 2
}
/**
 * Provide an interface for the style of an SubTabBar indicator including color, height, width, border radius
 * and margin top
 *
 * @interface SubTabBarIndicatorStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SubTabBarIndicatorStyle {
  /**
   * Define the color of the indicator
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  color?: ResourceColor;
  /**
   * Define the height of the indicator
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  height?: Length;
  /**
   * Define the width of the indicator.
   * If it is 0, the width will be equal to the width of the content
   *
   * @type { ?Length }
   * @default 0
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  width?: Length;
  /**
   * Define the border radius of the indicator
   *
   * @type { ?Length }
   * @default 0
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  borderRadius?: Length;
  /**
   * Define the margin top of the indicator
   *
   * @type { ?Length }
   * @default 8
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  marginTop?: Length;
}
/**
 * Provide an interface for the style of an indicator including border radius
 *
 * @interface BoardStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface BoardStyle {
  /**
   * Define the border radius of the board
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  borderRadius?: Length;
}
/**
 * TabBarLabelStyle object.
 *
 * @interface TabBarLabelStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TabBarLabelStyle {
  /**
   * overflow mode.
   *
   * @type { ?TextOverflow }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  overflow?: TextOverflow;
  /**
   * Label max lines.
   *
   * @type { ?number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  maxLines?: number;
  /**
   * Min font size for adapted height.
   *
   * @type { ?(number | ResourceStr) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  minFontSize?: number | ResourceStr;
  /**
   * Max font size for adapted height.
   *
   * @type { ?(number | ResourceStr) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  maxFontSize?: number | ResourceStr;
  /**
   * Adapt text height option.
   *
   * @type { ?TextHeightAdaptivePolicy }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  heightAdaptivePolicy?: TextHeightAdaptivePolicy;
  /**
   * Font style.
   *
   * @type { ?Font }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  font?: Font;
  /**
   * The text color of the selected tab bar.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  selectedColor?: ResourceColor;
  /**
   * The text color of the unselected tab bar.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  unselectedColor?: ResourceColor;
}
/**
 * TabBarIconStyle object.
 *
 * @interface TabBarIconStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TabBarIconStyle {
  /**
   * The icon color of the selected tab bar.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  selectedColor?: ResourceColor;
  /**
   * The icon color of the unselected tab bar.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  unselectedColor?: ResourceColor;
}
/**
 * TabBarSymbol object.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class TabBarSymbol {
  /**
   * Symbol icon in the normal style.
   *
   * @type { SymbolGlyphModifier }
   * @default fontColor: #66182431, renderingStrategy: SymbolRenderingStrategy.MULTIPLE_OPACITY, fontSize: 24vp
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  normal: SymbolGlyphModifier;
  /**
   * Symbol icon in the selected style.
   *
   * @type { ?SymbolGlyphModifier }
   * @default fontColor: #ff007dff, renderingStrategy: SymbolRenderingStrategy.MULTIPLE_OPACITY, fontSize: 24vp
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  selected?: SymbolGlyphModifier;
}
/**
 * Icon and text for TabBar.
 *
 * @typedef TabBarOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TabBarOptions {
  /**
   * TabBar icon.
   * Anonymous Object Rectification
   *
   * <p><strong>NOTE</strong>:
   * <br>If the icon uses an SVG image, the width and height attributes of the SVG image must be deleted.
   * Otherwise, the icon size will be determined by the width and height attributes of the SVG image.
   * </p>
   *
   * @type { ?(string | Resource) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  icon?: string | Resource;
  /**
   * TabBar text.
   * Anonymous Object Rectification
   *
   * @type { ?(string | Resource) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  text?: string | Resource;
}
/**
 * Define SubTabBarStyle, the style is text and underline.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class SubTabBarStyle {
  /**
   * constructor.
   *
   * @param { ResourceStr } content - indicates the content of the sub tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(content: ResourceStr);
  /**
   * constructor.
   *
   * @param { ResourceStr | ComponentContent } content - indicates the content of the sub tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(content: ResourceStr | ComponentContent);
  /**
   * Static constructor used to create a SubTabBarStyle instance.
   *
   * @param { ResourceStr } content - indicates the content of the sub tab bar
   * @returns { SubTabBarStyle } the style of the sub tab bar
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static of(content: ResourceStr): SubTabBarStyle;
  /**
   * Static constructor used to create a SubTabBarStyle instance. You can set custom content with ComponentContent.
   *
   * @param { ResourceStr | ComponentContent } content - indicates the content of the sub tab bar
   * @returns { SubTabBarStyle } the style of the sub tab bar
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static of(content: ResourceStr | ComponentContent): SubTabBarStyle;
  /**
   * Set the style of the indicator when selected
   *
   * @param { SubTabBarIndicatorStyle } style - indicates the indicator style of the sub tab bar
   * @returns { SubTabBarStyle } the style of the sub tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  indicator(style: SubTabBarIndicatorStyle): SubTabBarStyle;
  /**
   * Sets the display mode of the selected subtab.
   *
   * <p><strong>NOTE</strong>:
   * <br>It takes effect only in the horizontal layout.
   * </p>
   *
   * @param { SelectedMode } value - display mode of the selected subtab. Default value is SelectedMode.INDICATOR.
   * @returns { SubTabBarStyle } the style of the sub tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  selectedMode(value: SelectedMode): SubTabBarStyle;
  /**
   * Sets the background style (board style) of the selected subtab.
   *
   * <p><strong>NOTE</strong>:
   * <br>It takes effect only in the horizontal layout.
   * </p>
   *
   * @param { BoardStyle } value - background style object for the selected subtab.
   * @returns { SubTabBarStyle } the style of the sub tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  board(value: BoardStyle): SubTabBarStyle;
  /**
   * Set the label style of the sub tab bar
   *
   * @param { TabBarLabelStyle } style - indicates the label style of the sub tab bar
   * @returns { SubTabBarStyle } the style of the sub tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  labelStyle(style: TabBarLabelStyle): SubTabBarStyle;
  /**
   * Set the padding of the sub tab bar
   *
   * <p><strong>NOTE</strong>:
   * <br>It cannot be set in percentage.
   * <br>When the parameter is of the Dimension type, the value applies to all sides.
   * </p>
   *
   * @param { Padding | Dimension } value - indicates the padding of the sub tab bar
   * @returns { SubTabBarStyle } the style of the sub tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  padding(value: Padding | Dimension): SubTabBarStyle;
  /**
   * Set the padding of the sub tab bar
   *
   * <p><strong>NOTE</strong>:
   * <br>This API supports mirroring but does not support percentage-based settings.
   * </p>
   *
   * @param { LocalizedPadding } padding - indicates the padding of the sub tab bar
   * @returns { SubTabBarStyle } the style of the sub tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  padding(padding: LocalizedPadding): SubTabBarStyle;
  /**
   * Set an id to the sub tab bar to identify it
   *
   * @param { string } value - id of the sub tab bar to identify it
   * @returns { SubTabBarStyle } the style of the sub tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  id(value: string): SubTabBarStyle;
}
/**
 * Define BottomTabBarStyle, the style is icon and text.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class BottomTabBarStyle {
  /**
   * constructor.
   *
   * @param { ResourceStr | TabBarSymbol } icon - indicates the icon of the bottom tab bar
   * @param { ResourceStr } text - indicates the text of the bottom tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(icon: ResourceStr | TabBarSymbol, text: ResourceStr);
  /**
   * Static constructor used to create a BottomTabBarStyle instance.
   *
   * @param { ResourceStr | TabBarSymbol } icon - indicates the icon of the bottom tab bar
   * @param { ResourceStr } text - indicates the text of the bottom tab bar
   * @returns { BottomTabBarStyle } the style of the bottom tab bar
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static of(icon: ResourceStr | TabBarSymbol, text: ResourceStr): BottomTabBarStyle;
  /**
   * Set the label style of the bottom tab bar
   *
   * @param { TabBarLabelStyle } style - indicates the label style of the bottom tab bar
   * @returns { BottomTabBarStyle } the style of the bottom tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  labelStyle(style: TabBarLabelStyle): BottomTabBarStyle;
  /**
   * Set the padding of the bottom tab bar
   *
   * <p><strong>NOTE</strong>:
   * <br>It cannot be set in percentage.
   * <br>When the parameter is of the Dimension type, the value applies to all sides.
   * </p>
   *
   * @param { Padding | Dimension | LocalizedPadding } value - indicates the padding of the bottom tab bar
   * Default value is { left:4.0vp, right:4.0vp, top:0.0vp, bottom:0.0vp }.
   * @returns { BottomTabBarStyle } the style of the bottom tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  padding(value: Padding | Dimension | LocalizedPadding): BottomTabBarStyle;
  /**
   * Sets the layout mode of the images and texts on the bottom tab.
   *
   * @param { LayoutMode } value - layout mode of the images and text on the bottom tab.
   * Default value is LayoutMode.VERTICAL.
   * @returns { BottomTabBarStyle } the style of the bottom tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  layoutMode(value: LayoutMode): BottomTabBarStyle;
  /**
   * Sets the vertical alignment mode of the images and text on the bottom tab.
   *
   * @param { VerticalAlign } value - vertical alignment mode of the images and text on the bottom tab.
   * Default value is VerticalAlign.Center.
   * @returns { BottomTabBarStyle } the style of the bottom tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  verticalAlign(value: VerticalAlign): BottomTabBarStyle;
  /**
   * Sets whether the images and text on the bottom tab can be symmetrically extended by
   * the minimum value of the available space on the left and right bottom tabs.
   *
   * <p><strong>NOTE</strong>:
   * <br>This parameter is valid only between bottom tabs in fixed horizontal mode.
   * </p>
   *
   * @param { boolean } value - indicates whether the bottom tab bar is extensible. Default value is false.
   * @returns { BottomTabBarStyle } the style of the bottom tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  symmetricExtensible(value: boolean): BottomTabBarStyle;
  /**
   * Set an id to the bottom tab bar to identify it
   *
   * @param { string } value - id of the bottom tab bar to identify it
   * @returns { BottomTabBarStyle } the style of the bottom tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  id(value: string): BottomTabBarStyle;
  /**
   * Sets the style of the label icon on the bottom tab.
   *
   * @param { TabBarIconStyle } style - style of the label icon on the bottom tab.
   * @returns { BottomTabBarStyle } the style of the bottom tab bar
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  iconStyle(style: TabBarIconStyle): BottomTabBarStyle;
}

/**
 * Define the TabContentAttribute.
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TabContentAttribute extends CommonMethod {
  /**
   * Sets the content displayed on the tab bar.
   * Anonymous Object Rectification
   *
   * <p><strong>NOTE</strong>:
   * <br>If BottomTabBarStyle or TabBarOptions is used and an icon is set,
   * a gray block will be displayed if the icon is invalid.
   * <br>If the content exceeds the space provided by the tab bar, it will be clipped.
   * </p>
   *
   * @param { ComponentContent | SubTabBarStyle | BottomTabBarStyle | string | Resource | CustomBuilder | TabBarOptions } content
   * Content displayed on the tab bar.
   * @returns { TabContentAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  tabBar(content: ComponentContent | SubTabBarStyle | BottomTabBarStyle | string | Resource | CustomBuilder | TabBarOptions | undefined): this;
  /**
   * Called when the tab content is about to be displayed. The scenarios include the first-time display,
   * tab switching, page switching, and window switching between the foreground and background.
   *
   * @param { VoidCallback  } event
   * @returns { TabContentAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onWillShow(event: VoidCallback | undefined): this;
  /**
   * Called when the tab content is about to be hidden. The scenarios include the tab switching,
   * page switching, and window switching between the foreground and background.
   *
   * @param { VoidCallback  } event
   * @returns { TabContentAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onWillHide(event: VoidCallback | undefined): this;

  /**
   * Set the attribute modifier for TabContent.
   *
   * @param { AttributeModifier<TabContentAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
   * @returns { TabContentAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  attributeModifier(modifier: AttributeModifier<TabContentAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines TabContent Component
 *
 * @param { function } [content_] - TabContent
 * @returns { TabContentAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function TabContent(
    
    @memo
    content_?: () => void,
): TabContentAttribute;
