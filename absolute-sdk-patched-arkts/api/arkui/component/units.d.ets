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

import { Resource as _Resource } from '../../global/resource';
import { Color, BorderStyle, FontWeight, FontStyle, DividerMode } from './enums';
import { OutlineStyle, AttributeModifier, CommonMethod } from './common';
import { LengthMetricsUnit as _LengthMetricsUnit, LengthMetrics as _LengthMetrics, ColorMetrics as _ColorMetrics } from '../Graphics';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
/**
 * Defines the data type of the interface restriction.
 *
 * @typedef { _Resource } Resource
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type Resource = _Resource;

/**
 * Defines the length property with string, number and resource unit.
 *
 * @typedef { string | number | Resource } Length
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type Length = string | number | Resource;

/**
 * Defines the length property with number in units of px.
 *
 * @typedef { string } PX
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type PX = string;

/**
 * Defines the length property with number or number in units of vp.
 *
 * @typedef { string | number } VP
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type VP = string | number;

/**
 * Defines the length property with number in units of fp.
 *
 * @typedef { string } FP
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type FP = string;

/**
 * Defines the length property with number in units of lpx.
 *
 * @typedef { string } LPX
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type LPX = string;

/**
 * Defines the length property with number in units of Percentage.
 *
 * @typedef { string } Percentage
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type Percentage = string;

/**
 * Defines the angle property with number in units of deg.
 *
 * @typedef { string } Degree
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type Degree = string;

/**
 * Defines the dimension property with number with units(vp|px|fp|lpx|%), and resource.
 *
 * @typedef { PX | VP | FP | LPX | Percentage | Resource } Dimension
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type Dimension = PX | VP | FP | LPX | Percentage | Resource;

/**
 * Defines the string which can use resource.
 *
 * @typedef { string | Resource } ResourceStr
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type ResourceStr = string | Resource;

/**
 * Defines the padding property.
 *
 * @interface Padding
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface Padding {
  /**
   * top property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: Length;

  /**
   * right property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  right?: Length;

  /**
   * bottom property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom?: Length;

  /**
   * left property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  left?: Length;
}

/**
 * Defines the localized padding property.
 *
 * @interface LocalizedPadding
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LocalizedPadding {
  /**
   * top property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: LengthMetrics;

  /**
   * end property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  end?: LengthMetrics;

  /**
   * bottom property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom?: LengthMetrics;

  /**
   * start property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  start?: LengthMetrics;
}

/**
 * Defines the margin property.
 *
 * @typedef { Padding } Margin
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type Margin = Padding;

/**
 * Defines the border width property.
 *
 * @typedef { EdgeWidths } EdgeWidth
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type EdgeWidth = EdgeWidths;

/**
 * Defines the border width property.
 *
 * @interface EdgeWidths
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface EdgeWidths {
  /**
   * top property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: Length;

  /**
   * right property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  right?: Length;

  /**
   * bottom property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom?: Length;

  /**
   * left property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  left?: Length;
}

/**
 * Defines the localized border width property.
 *
 * @interface LocalizedEdgeWidths
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LocalizedEdgeWidths {
  /**
   * top property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: LengthMetrics;

  /**
   * end property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  end?: LengthMetrics;

  /**
   * bottom property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom?: LengthMetrics;

  /**
   * start property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  start?: LengthMetrics;
}

/**
 * Defines the outline width property.
 *
 * @interface EdgeOutlineWidths
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface EdgeOutlineWidths {
  /**
   * top outline width property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: Dimension;

  /**
   * right outline width property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  right?: Dimension;

  /**
   * bottom outline width property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom?: Dimension;

  /**
   * left outline width property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  left?: Dimension;
}

/**
 * Defines the border radius property.
 *
 * @interface BorderRadiuses
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface BorderRadiuses {
  /**
   * top-left property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  topLeft?: Length;

  /**
   * top-right property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  topRight?: Length;

  /**
   * bottom-left property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottomLeft?: Length;

  /**
   * bottom-right property.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottomRight?: Length;
}

/**
 * Defines the localized border radius property.
 *
 * @interface LocalizedBorderRadiuses
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LocalizedBorderRadiuses {
  /**
   * top-start property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  topStart?: LengthMetrics;

  /**
   * top-end property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  topEnd?: LengthMetrics;

  /**
   * bottom-start property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottomStart?: LengthMetrics;

  /**
   * bottom-end property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottomEnd?: LengthMetrics;
}

/**
 * Defines the outline radius property.
 *
 * @interface OutlineRadiuses
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface OutlineRadiuses {
  /**
   * top-left property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  topLeft?: Dimension;

  /**
   * top-right property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  topRight?: Dimension;

  /**
   * bottom-left property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottomLeft?: Dimension;

  /**
   * bottom-right property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottomRight?: Dimension;
}

/**
 * Defines the border color property.
 *
 * @interface EdgeColors
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface EdgeColors {
  /**
   * top property.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: ResourceColor;

  /**
   * right property.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  right?: ResourceColor;

  /**
   * bottom property.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom?: ResourceColor;

  /**
   * left property.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  left?: ResourceColor;
}

/**
 * Defines the localized border color property.
 *
 * @interface LocalizedEdgeColors
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LocalizedEdgeColors {
  /**
   * top property.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: ResourceColor;

  /**
   * end property.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  end?: ResourceColor;

  /**
   * bottom property.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom?: ResourceColor;

  /**
   * start property.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  start?: ResourceColor;
}

/**
 * Defines the localized margin property.
 *
 * @typedef { LocalizedPadding } LocalizedMargin
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type LocalizedMargin = LocalizedPadding;

/**
 * Defines the border style property.
 *
 * @interface EdgeStyles
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface EdgeStyles {
  /**
   * top property.
   *
   * @type { ?BorderStyle }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: BorderStyle;

  /**
   * right property.
   *
   * @type { ?BorderStyle }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  right?: BorderStyle;

  /**
   * bottom property.
   *
   * @type { ?BorderStyle }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom?: BorderStyle;

  /**
   * left property.
   *
   * @type { ?BorderStyle }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  left?: BorderStyle;
}

/**
 * Defines the outline style property.
 *
 * @interface EdgeOutlineStyles
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface EdgeOutlineStyles {
  /**
   * top property.
   *
   * @type { ?OutlineStyle }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: OutlineStyle;

  /**
   * right property.
   *
   * @type { ?OutlineStyle }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  right?: OutlineStyle;

  /**
   * bottom property.
   *
   * @type { ?OutlineStyle }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom?: OutlineStyle;

  /**
   * left property.
   *
   * @type { ?OutlineStyle }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  left?: OutlineStyle;
}

/**
 * Defines the offset property.
 *
 * @interface Offset
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface Offset {
  /**
   * dx property.
   *
   * @type { Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  dx: Length;

  /**
   * dy property.
   *
   * @type { Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  dy: Length;
}

/**
 * Defines the color which can use resource.
 *
 * @typedef { Color | number | string | Resource } ResourceColor
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type ResourceColor = Color | number | string | Resource;

/**
 * Defines the length constrain property.
 *
 * @typedef { object } LengthConstrain
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LengthConstrain {
  /**
   * minimum length.
   *
   * @type { Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  minLength: Length;

  /**
   * maximum length.
   *
   * @type { Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  maxLength: Length;
}

/**
 * Defines VoidCallback.
 *
 * @typedef { function } VoidCallback
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type VoidCallback = () => void;

/**
 * Defines length metrics unit.
 *
 * @typedef { _LengthMetricsUnit } LengthMetricsUnit
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type LengthMetricsUnit = _LengthMetricsUnit;

/**
 * Defines LengthMetrics.
 *
 * @typedef { _LengthMetrics } LengthMetrics
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type LengthMetrics = _LengthMetrics;

/**
 * Defines ColorMetrics.
 *
 * @typedef { _ColorMetrics } ColorMetrics
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type ColorMetrics = _ColorMetrics;

/**
 * Defines the font used for text.
 *
 * @interface Font
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface Font {
  /**
   * font size.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  size?: Length;

  /**
   * font weight.
   *
   * @type { ?(FontWeight | number | string) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  weight?: FontWeight | number | string;

  /**
   * font family.
   *
   * @type { ?(string | Resource) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  family?: string | Resource;

  /**
   * font style.
   *
   * @type { ?FontStyle }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  style?: FontStyle;
}

/**
 * Defines the area property.
 *
 * @interface Area
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface Area {
  /**
   * Defines the width property.
   *
   * @type { Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  width: Length;

  /**
   * Defines the height property.
   *
   * @type { Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  height: Length;

  /**
   * Defines the local position.
   *
   * @type { Position }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  position: Position;

  /**
   * Defines the global position.
   *
   * @type { Position }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  globalPosition: Position;
}

/**
 * Defines the position.
 *
 * @interface Position
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface Position {
  /**
   * Coordinate x of the Position.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  x?: Length;

  /**
   * Coordinate y of the Position.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  y?: Length;
}

/**
 * Defines the LocalizedPosition.
 *
 * @interface LocalizedPosition
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LocalizedPosition {
  /**
   * Coordinate start of the Position.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  start?: LengthMetrics;

  /**
   * Coordinate top of the Position.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: LengthMetrics;
}

/**
 * Defines the Edges.
 *
 * @interface Edges
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface Edges {
  /**
   * top property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: Dimension;

  /**
   * left property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  left?: Dimension;

  /**
   * bottom property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom?: Dimension;

  /**
   * right property.
   *
   * @type { ?Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  right?: Dimension;
}

/**
 * Defines the LocalizedEdges.
 *
 * @interface LocalizedEdges
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LocalizedEdges {
  /**
   * top property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top?: LengthMetrics;

  /**
   * start property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  start?: LengthMetrics;

  /**
   * bottom property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom?: LengthMetrics;

  /**
   * end property.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  end?: LengthMetrics;
}

/**
 * Defines the Bias.
 *
 * @interface Bias
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface Bias {
  /**
   * Horizontal ratio of the Bias, it must be >= 0.
   *
   * @type { ?number }
   * @default 0.5
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  horizontal?: number;

  /**
   * Vertical ratio of the Bias, it must be >= 0.
   *
   * @type { ?number }
   * @default 0.5
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  vertical?: number;
}

/**
 * Defines the constrain size options.
 *
 * @interface ConstraintSizeOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ConstraintSizeOptions {
  /**
   * Defines the min width.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  minWidth?: Length;

  /**
   * Defines the max width.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  maxWidth?: Length;

  /**
   * Defines the min height.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  minHeight?: Length;

  /**
   * Defines the max height.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  maxHeight?: Length;
}

/**
 * Defines the size options.
 *
 * @interface SizeOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SizeOptions {
  /**
   * Defines the width.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  width?: Length;

  /**
   * Defines the height.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  height?: Length;
}

/**
 * Defines the options of border.
 *
 * @interface BorderOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface BorderOptions {
  /**
   * Defines the border width.
   *
   * @type { ?(EdgeWidths | Length | LocalizedEdgeWidths) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  width?: EdgeWidths | Length | LocalizedEdgeWidths;

  /**
   * Defines the border color.
   *
   * @type { ?(EdgeColors | ResourceColor | LocalizedEdgeColors) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  color?: EdgeColors | ResourceColor | LocalizedEdgeColors;

  /**
   * Defines the border radius.
   *
   * @type { ?(BorderRadiuses | Length | LocalizedBorderRadiuses) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  radius?: BorderRadiuses | Length | LocalizedBorderRadiuses;

  /**
   * Defines the border style.
   *
   * @type { ?(EdgeStyles | BorderStyle) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  style?: EdgeStyles | BorderStyle;

  /**
   * Defines the gap of dash when BorderStyle is dashed.
   *
   * @type { ?(EdgeWidths | LengthMetrics | LocalizedEdgeWidths) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  dashGap?: EdgeWidths | LengthMetrics | LocalizedEdgeWidths;

  /**
   * Defines the length of dash when BorderStyle is dashed.
   *
   * @type { ?(EdgeWidths | LengthMetrics | LocalizedEdgeWidths) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  dashWidth?: EdgeWidths | LengthMetrics | LocalizedEdgeWidths;

  /**
   * Defines the border display hierarchy, such as show in the background or foreground。
   *
   * @type { ?boolean }
   * @default true
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  showInForeground?: boolean;
}

/**
 * Defines the options of border.
 *
 * @interface OutlineOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface OutlineOptions {
  /**
   * Defines the outline width.
   *
   * @type { ?(EdgeOutlineWidths | Dimension) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  width?: EdgeOutlineWidths | Dimension;

  /**
   * Defines the outline color.
   *
   * @type { ?(EdgeColors | ResourceColor | LocalizedEdgeColors) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  color?: EdgeColors | ResourceColor | LocalizedEdgeColors;

  /**
   * Defines the outline radius.
   *
   * @type { ?(OutlineRadiuses | Dimension) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  radius?: OutlineRadiuses | Dimension;

  /**
   * Defines the outline style.
   *
   * @type { ?(EdgeOutlineStyles | OutlineStyle) }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  style?: EdgeOutlineStyles | OutlineStyle;
}

/**
 * Define the style of checkbox mark.
 *
 * @interface MarkStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface MarkStyle {
  /**
   * Define the stroke color of checkbox mark.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  strokeColor?: ResourceColor;

  /**
   * Define the size of checkbox mark.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  size?: Length;

  /**
   * Define the stroke width of checkbox mark.
   *
   * @type { ?Length }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  strokeWidth?: Length;
}

/**
 * Defines the ColorFilter object.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class ColorFilter {
  /**
   * Creates ColorFilter with 4*5 matrix.
   *
   * @param { number[] } value 4*5 color matrix values. The value[m*n] is located in the m row and n column.
   *     The matrix is row-first.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor(value: number[]);
}

/**
 * Defines TouchPoint
 *
 * @interface TouchPoint
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TouchPoint {
  /**
   * Define the touch point x coordinate.
   *
   * @type { Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  x: Dimension;

  /**
   * Define the touch point y coordinate.
   *
   * @type { Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  y: Dimension;
}

/**
 * Defines the DirectionalEdgesT interface.
 *
 * @interface DirectionalEdgesT
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface DirectionalEdgesT<T> {
  /**
   * Start property.
   *
   * @type { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  start: T;

  /**
   * End property.
   *
   * @type { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  end: T;

  /**
   * Top property.
   *
   * @type { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top: T;

  /**
   * Bottom property.
   *
   * @type { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom: T;
}

/**
 * Defines the struct of DividerStyleOptions.
 *
 * @interface DividerStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface DividerStyleOptions {
  /**
   * The strokeWidth of Divider.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  strokeWidth?: LengthMetrics;

  /**
   * The color of Divider.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  color?: ResourceColor;

  /**
   * The startMargin of Divider.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  startMargin?: LengthMetrics;

  /**
   * The endMargin of Divider.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  endMargin?: LengthMetrics;

  /**
   * The mode of Divider.
   *
   * @type { ?DividerMode }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  mode?: DividerMode;
}

/**
 * Define scrollbar margin options.
 *
 * @interface ScrollBarMargin
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
declare interface ScrollBarMargin {
  /**
   * Start margin of the scroll bar.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  start?: LengthMetrics;

  /**
   * End margin of the scroll bar.
   *
   * @type { ?LengthMetrics }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  end?: LengthMetrics;
}

/**
 * Defines the ChainWeightOptions interface.
 *
 * @interface ChainWeightOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ChainWeightOptions {

  /**
   * Horizontal ChainWeight.
   *
   * @type { ?number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  horizontal?: number;

  /**
   * Vertical ChainWeight.
   *
   * @type { ?number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  vertical?: number;
}

/**
 * Defines the struct of AccessibilityOptions.
 *
 * @interface AccessibilityOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface AccessibilityOptions {

  /**
   * accessibilityPreferred - Should accessibilityText be prioritized when contatenating child component strings.
   *
   * @type { ?boolean }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  accessibilityPreferred?: boolean;
}
