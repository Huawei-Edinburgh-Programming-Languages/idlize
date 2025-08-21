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

import { IndicatorComponentController } from './indicatorcomponent';
import { CommonMethod, Callback, ICurve, Optional, Bindable } from './common';
import { EdgeEffect, Curve, PageFlipMode } from './enums';
import { Length, LengthMetrics, VoidCallback, ResourceColor, VP, Font } from './units';
import { memo, ComponentBuilder } from './../stateManagement/runtime';

/**
 * Provides methods for switching components.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class SwiperController {
  /**
   * constructor.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor();

  /**
   * Called when the next child component is displayed.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  showNext(): void;

  /**
   * Called when the previous subcomponent is displayed.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  showPrevious(): void;

  /**
   * Controlling Swiper to change to the specified subcomponent.
   *
   * @param { number } index - the index of item to be redirected.
   * @param { SwiperAnimationMode | boolean } [animationMode] - animation mode for changeIndex,
   * true is equivalent to SwiperAnimationMode.DEFAULT_ANIMATION, false is equivalent to SwiperAnimationMode.NO_ANIMATION
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  changeIndex(index: number, animationMode?: SwiperAnimationMode | boolean): void;

  /**
   * Called when need to stop the swiper animation.
   *
   * @param { ?VoidCallback } callback
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  finishAnimation(callback?: VoidCallback): void;

  /**
   * Called when need to preload specified child.
   *
   * @param { Optional<Array<number>> } indices - Indices of swiper child to be preloaded.
   * @returns { Promise<void> } The promise returned by the function.
   * @throws { BusinessError } 401 - Parameter invalid. Possible causes:
   * <br> 1. The parameter type is not Array<number>.
   * <br> 2. The parameter is an empty array.
   * <br> 3. The parameter contains an invalid index.
   * @throws { BusinessError } 100004 - Controller not bound to component.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  preloadItems(indices: Optional<Array<number>>): Promise<void>;
}

/**
 * Defines the indicator class.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class Indicator<T> {
  /**
   * Set the indicator to the left.
   *
   * @param { Length } value - the indicator to the left.
   * @returns { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  left(value: Length): T;

  /**
   * Set the indicator to the top.
   *
   * @param { Length } value - the indicator to the top.
   * @returns { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  top(value: Length): T;

  /**
   * Set the indicator to the right.
   *
   * @param { Length } value - the indicator to the right.
   * @returns { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  right(value: Length): T;

  /**
   * Set the indicator to the bottom.
   *
   * @param { Length } value - the indicator to the bottom.
   * @returns { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  bottom(value: Length): T;

  /**
   * Set the indicator to the left in LTR
   * Set the indicator to the right in RTL
   *
   * @param { LengthMetrics } value - the indicator to the right in LTR, indicator to the left in RTL
   * @returns { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  start(value: LengthMetrics): T;

  /**
   * Set the indicator to the left in RTL
   * Set the indicator to the right in LTR
   *
   * @param { LengthMetrics } value - the indicator to the left in RTL, Set the indicator to the right in LTR
   * @returns { T }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  end(value: LengthMetrics): T;

  /**
   * DotIndicator class object.
   *
   * @returns { DotIndicator }
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static dot(): DotIndicator;

  /**
   * DigitIndicator class object.
   *
   * @returns { DigitIndicator }
   * @static
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  static digit(): DigitIndicator;
}

/**
 * Define DotIndicator, the indicator type is dot.
 *
 * @extends Indicator<DotIndicator>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class DotIndicator extends Indicator<DotIndicator> {
  /**
   * Constructor.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor();

  /**
   * Set the indicator item width.
   *
   * @param { Length } value - the indicator item width.
   * @returns { DotIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  itemWidth(value: Length): DotIndicator;

  /**
   * Set the indicator item height.
   *
   * @param { Length } value - the indicator item height.
   * @returns { DotIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  itemHeight(value: Length): DotIndicator;

  /**
   * Set the indicator item width when selected.
   *
   * @param { Length } value - the indicator item width when selected.
   * @returns { DotIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  selectedItemWidth(value: Length): DotIndicator;

  /**
   * Set the indicator item height when selected.
   *
   * @param { Length } value - the indicator item height when selected.
   * @returns { DotIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  selectedItemHeight(value: Length): DotIndicator;

  /**
   * Setting indicator style mask.
   *
   * @param { boolean } value - the indicator item mask.
   * @returns { DotIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  mask(value: boolean): DotIndicator;

  /**
   * Set the indicator color.
   *
   * @param { ResourceColor } value - the indicator item color.
   * @returns { DotIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  color(value: ResourceColor): DotIndicator;

  /**
   * Set the navigation point color.
   *
   * @param { ResourceColor } value - the indicator item when selected.
   * @returns { DotIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  selectedColor(value: ResourceColor): DotIndicator;

  /**
   * Set the Indicator maxDisplayCount when selected.
   *
   * @param { number } maxDisplayCount - the indicator item maxDisplayCount when selected.
   * @returns { DotIndicator } return the DotIndicator
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  maxDisplayCount(maxDisplayCount: number): DotIndicator;

  /**
   * Set the space between dots.
   *
   * @param { LengthMetrics } space - the space between dots
   * @returns { DotIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  space(space: LengthMetrics): DotIndicator;
}

/**
 * Set Swiper column count adaptation.
 *
 * @typedef SwiperAutoFill
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SwiperAutoFill {
  /**
   * Set minSize size.
   *
   * @type { VP }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  minSize: VP;
}

/**
 * Define DigitIndicator, the indicator type is digit.
 *
 * @extends Indicator<DigitIndicator>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class DigitIndicator extends Indicator<DigitIndicator> {
  /**
   * Constructor.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  constructor();

  /**
   * Set font color of the digital indicator.
   *
   * @param { ResourceColor } value - the indicator font color.
   * @returns { DigitIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  fontColor(value: ResourceColor): DigitIndicator;

  /**
   * Set font color of the digital indicator when selected.
   *
   * @param { ResourceColor } value - the indicator font color when selected.
   * @returns { DigitIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  selectedFontColor(value: ResourceColor): DigitIndicator;

  /**
   * Set the digital indicator font (just support font size and weight).
   *
   * @param { Font } value - the indicator font size and weight.
   * @returns { DigitIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  digitFont(value: Font): DigitIndicator;

  /**
   * Set the digital indicator font (just support font size and weight).
   *
   * @param { Font } value - the indicator font size and weight when selected.
   * @returns { DigitIndicator }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  selectedDigitFont(value: Font): DigitIndicator;
}

/**
 * Arrow object.
 *
 * @interface ArrowStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ArrowStyle {
  /**
   * Is show the arrow background or not.
   *
   * @type { ?boolean }
   * @default false
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  showBackground?: boolean;

  /**
   * When the indicator show, set the arrow position is side of the indicator or in the middle of content area.
   * The arrow is displayed on side of the indicator, if the value is false.
   *
   * @type { ?boolean }
   * @default false
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  isSidebarMiddle?: boolean;

  /**
   * The arrow background size.
   * The size of the arrow is three-quarters of the background size, when the background is displayed.
   *
   * @type { ?Length }
   * @default When isSidebarMiddle is false, the default value is 24vp, Otherwise,the default value is 32vp
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  backgroundSize?: Length;

  /**
   * The arrow background background color.
   *
   * @type { ?ResourceColor }
   * @default When isSidebarMiddle is false, the default value is #00000000, Otherwise, the default value is #19182431
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  backgroundColor?: ResourceColor;

  /**
   * The arrow size.
   * The arrow size can be set, when the background is not displayed.
   * The size of the arrow is three-quarters of the background size, when the background is displayed.
   *
   * @type { ?Length }
   * @default When isSidebarMiddle is false, the default value is 18vp, Otherwise, the default value is 24vp
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  arrowSize?: Length;

  /**
   * The arrow color.
   *
   * @type { ?ResourceColor }
   * @default #182431
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  arrowColor?: ResourceColor;
}

/**
 * Declare the size of the swiper on the spindle.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SwiperDisplayMode {
  /**
   * Carousel map extension.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  STRETCH
}

/**
 * Provides an interface for swiper animation.
 *
 * @interface SwiperAnimationEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SwiperAnimationEvent {
  /**
   * Offset of the current page to the start position of the swiper main axis. The unit is vp.
   *
   * @type { number }
   * @default 0.0 vp
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  currentOffset: number;

  /**
   * Offset of the target page to the start position of the swiper main axis. The unit is vp.
   *
   * @type { number }
   * @default 0.0 vp
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  targetOffset: number;

  /**
   * Start speed of the page-turning animation. The unit is vp/s.
   *
   * @type { number }
   * @default 0.0 vp/s
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  velocity: number;
}

/**
 * Define autoPlay related options.
 *
 * @interface AutoPlayOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface AutoPlayOptions {
  /**
   * Set whether to stop autoplay immediately on touch down event.
   *
   * @type { boolean }
   * @default true
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  stopWhenTouched: boolean;
}

/**
 * Swiper nested scroll nested mode

 * @enum { number } SwiperNestedScrollMode
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SwiperNestedScrollMode {
  /**
   * Only Self response scrolling.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  SELF_ONLY = 0,

  /**
   * Self priority response scrolling.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  SELF_FIRST = 1
}

/**
 * Declare the animation mode of SwiperController's changeIndex method.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SwiperAnimationMode {
  /**
   * Jump to target index without animation.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  NO_ANIMATION = 0,

  /**
   * Scroll to target index with animation.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  DEFAULT_ANIMATION = 1,

  /**
   * Jump to some index near the target index without animation,
   * then scroll to target index with animation.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  FAST_ANIMATION = 2
}

/**
 * Defines a swiper callback when onAnimationStart.
 *
 * @typedef { function } OnSwiperAnimationStartCallback
 * @param { number } index - The index value of the swiper page that when animation start.
 * @param { number } targetIndex - The target index value of the swiper page that when animation start.
 * @param { SwiperAnimationEvent } extraInfo - The extra callback info.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnSwiperAnimationStartCallback = (index: number, targetIndex: number,
  extraInfo: SwiperAnimationEvent) => void;

/**
 * Defines a swiper callback when onAnimationEnd.
 *
 * @typedef { function } OnSwiperAnimationEndCallback
 * @param { number } index - The index value of the swiper page that when animation end.
 * @param { SwiperAnimationEvent } extraInfo - The extra callback info.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnSwiperAnimationEndCallback = (index: number, extraInfo: SwiperAnimationEvent) => void;

/**
 * Defines a swiper callback when onGestureSwipe.
 *
 * @typedef { function } OnSwiperGestureSwipeCallback
 * @param { number } index - The index value of the swiper page before gesture swipe.
 * @param { SwiperAnimationEvent } extraInfo - The extra callback info.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnSwiperGestureSwipeCallback = (index: number, extraInfo: SwiperAnimationEvent) => void;

/**
 * Defines the swiper attribute functions.
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface SwiperAttribute extends CommonMethod {
  /**
   * Called when the index value of the displayed subcomponent is set in the container.
   *
   * @param { number | Bindable<number> | undefined } value
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  index(value: number | Bindable<number> | undefined): this;

  /**
   * Set whether the subcomponent plays automatically.
   *
   * @param { boolean | undefined } autoPlay - whether the subcomponent plays automatically
   * @param { AutoPlayOptions | undefined } options - autoPlay related options
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  autoPlay(autoPlay: boolean | undefined, options: AutoPlayOptions | undefined): this;

  /**
   * Called when the time interval for automatic playback is set.
   *
   * @param { number | undefined } value
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  interval(value: number | undefined): this;

  /**
   * Use indicator component controller.
   *
   * @param { IndicatorComponentController | DotIndicator | DigitIndicator | boolean | undefined } indicator -
   * the style value or show indicator of the swiper indicator.
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  indicator(indicator: IndicatorComponentController | DotIndicator | DigitIndicator | boolean | undefined): this;

  /**
   * Set arrow is enabled, or set the arrow style.
   *
   * @param { ArrowStyle | boolean | undefined } value - arrow is displayed or set the arrow style.
   * @param { boolean | undefined } [isHoverShow] - arrow is display when mouse hover in indicator hotspot.
   * @returns { SwiperAttribute } return the component attribute.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  displayArrow(value: ArrowStyle | boolean | undefined, isHoverShow?: boolean | undefined): this;

  /**
   * Called when setting whether to turn on cyclic sliding.
   *
   * @param { boolean | undefined } value
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  loop(value: boolean | undefined): this;

  /**
   * Called when the animation duration of the switch is set.
   *
   * @param { number | undefined } value
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  duration(value: number | undefined): this;

  /**
   * Called when setting whether to slide vertically.
   *
   * @param { boolean | undefined } value
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  vertical(value: boolean | undefined): this;

  /**
   * Sets the space between child components.
   *
   * @param { number | string | undefined } value
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  itemSpace(value: number | string | undefined): this;

  /**
   * Called when setting the size of the swiper container on the spindle.
   *
   * @param { SwiperDisplayMode | undefined } value
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  displayMode(value: SwiperDisplayMode | undefined): this;

  /**
   * Sets the number of child components to be preloaded(cached).
   *
   * @param { number | undefined } value
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  cachedCount(value: number | undefined): this;

  /**
   * Sets the number of child components to be preloaded(cached).
   *
   * @param { number | undefined } count - Number of child components to be preloaded (cached).
   * @param { boolean | undefined } isShown - whether to show the nodes in the cache.
   * @returns { SwiperAttribute } the attribute of the swiper.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  cachedCount(count: number | undefined, isShown: boolean | undefined): this;

  /**
   * Sets the number of elements to display per page.
   *
   * If swipeByGroup is set to true:
   * 1、All sub-items are grouped from index 0.
   * 2、The number of sub-items in each group is the value of displayCount.
   * 3、If the number of sub-items in the last group is less than displayCount, placeholder items are added to supplement the number of last group.
   * 4、Placeholder items do not display any content and are only used as placeholders.
   * 5、When turning pages, turn pages by group.
   *
   * @param { number | string | SwiperAutoFill | undefined } value
   * @param { boolean | undefined } [swipeByGroup] - if swipe by group.
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  displayCount(value: number | string | SwiperAutoFill | undefined, swipeByGroup?: boolean | undefined): this;

  /**
   * Invoked when setting the sliding effect
   *
   * @param { EdgeEffect | undefined } value
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  effectMode(value: EdgeEffect | undefined): this;

  /**
   * Sets whether to disable the swipe feature
   *
   * @param { boolean | undefined } value
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  disableSwipe(value: boolean | undefined): this;

  /**
   * Sets the animation curve
   * Curve is an enumeration type for common curves
   * ICurve is a curve object
   *
   * @param { Curve | string | ICurve | undefined } value
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  curve(value: Curve | string | ICurve | undefined): this;

  /**
   * Called when the index value changes.
   *
   * @param { Callback<number> | undefined } event
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onChange(event: Callback<number> | undefined): this;

  /**
   * Called when a new index becomes selected. Animation is not necessarily complete.
   *
   * @param { Callback<number> | undefined } event - callback to notify which index has been selected
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onSelected(event: Callback<number> | undefined): this;

  /**
   * The previous margin which can be used to expose a small portion of the previous item.
   * When the previous item is empty, do not display blank space.
   *
   * @param { Length | undefined } value - The length of previous margin.
   * @param { boolean | undefined } [ignoreBlank] - Whether to hide(ignore) the previous margin on the first page in non-loop scenarios.
   * @returns { SwiperAttribute } The attribute of the swiper.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  prevMargin(value: Length | undefined, ignoreBlank?: boolean | undefined): this;

  /**
   * The next margin which can be used to expose a small portion of the latter item.
   * When the next item is empty, do not display blank space.
   *
   * @param { Length | undefined } value - The length of next margin.
   * @param { boolean | undefined } [ignoreBlank] - Whether to hide(ignore) the next margin on the last page in non-loop scenarios.
   * @returns { SwiperAttribute } The attribute of the swiper.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  nextMargin(value: Length | undefined, ignoreBlank?: boolean | undefined): this;

  /**
   * Called when a new index becomes unselected. Animation is not necessarily complete.
   *
   * @param { Callback<number> | undefined } event - callback to notify which index has been unselected
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onUnselected(event: Callback<number> | undefined): this;

  /**
   * Called when the swiper animation start.
   *
   * @param { OnSwiperAnimationStartCallback | undefined } event
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onAnimationStart(event: OnSwiperAnimationStartCallback | undefined): this;

  /**
   * Called when the swiper animation end.
   *
   * @param { OnSwiperAnimationEndCallback | undefined } event
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onAnimationEnd(event: OnSwiperAnimationEndCallback | undefined): this;

  /**
   * Called when the swiper swipe with the gesture.
   *
   * @param { OnSwiperGestureSwipeCallback | undefined } event
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onGestureSwipe(event: OnSwiperGestureSwipeCallback | undefined): this;

  /**
   * Called to setting the nested scroll mode.
   *
   * @param { SwiperNestedScrollMode | undefined } value - mode for nested scrolling.
   * @returns { SwiperAttribute } the attribute of the swiper.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  nestedScroll(value: SwiperNestedScrollMode | undefined): this;

  /**
   * Custom swiper content transition animation.
   *
   * @param { SwiperContentAnimatedTransition | undefined } transition - custom content transition animation.
   * @returns { SwiperAttribute } the attribute of the swiper.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  customContentTransition(transition: SwiperContentAnimatedTransition | undefined): this;

  /**
   * Called when the swiper content did scroll.
   *
   * @param { ContentDidScrollCallback | undefined } handler - callback of scroll,
   * selectedIndex is the index value of the swiper content selected before animation start.
   * index is the index value of the swiper content.
   * position is the moving ratio of the swiper content from the start position of the swiper main axis.
   * mainAxisLength is the swiper main axis length for calculating position.
   * @returns { SwiperAttribute } the attribute of the swiper.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onContentDidScroll(handler: ContentDidScrollCallback | undefined): this;

  /**
   * Setting whether the indicator is interactive.
   *
   * @param { boolean | undefined } value - Whether the indicator is interactive.
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  indicatorInteractive(value: boolean | undefined): this;

  /**
   * Setting page flip mode on mouse wheel event.
   *
   * @param { PageFlipMode | undefined } mode - page flip mode on mouse wheel event. The default value is PageFlipMode.CONTINUOUS.
   * @returns { SwiperAttribute }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  pageFlipMode(mode: PageFlipMode | undefined): this;

  /**
   * Called when the swiper content will scroll.
   *
   * @param { ContentWillScrollCallback | undefined } handler - callback of will scroll.
   * @returns { SwiperAttribute } the attribute of the swiper.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  onContentWillScroll(handler: ContentWillScrollCallback | undefined): this;
}

/**
 * Defines the swiper content animated transition options.
 *
 * @interface SwiperContentAnimatedTransition
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SwiperContentAnimatedTransition {
  /**
   * Defines the timeout of custom content transition animation after the page is moved out of the swiper. The unit is ms.
   * If SwiperContentTransitionProxy.finishTransition() is not invoked, use the timeout as animation end time.
   *
   * @type { ?number }
   * @default 0 ms
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  timeout?: number;

  /**
   * Called when custom content transition animation start.
   *
   * @type { Callback<SwiperContentTransitionProxy> }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  transition: Callback<SwiperContentTransitionProxy>;
}

/**
 * The proxy of SwiperContentAnimatedTransition.
 *
 * @interface SwiperContentTransitionProxy
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SwiperContentTransitionProxy {
  /**
   * the index value of the swiper content selected before animation start.
   *
   * @type { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  selectedIndex: number;

  /**
   * The index value of the swiper content.
   *
   * @type { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  index: number;

  /**
   * the moving ratio of the swiper content from the start position of the swiper main axis.
   *
   * @type { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  position: number;

  /**
   * the swiper main axis length for calculating position.
   *
   * @type { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  mainAxisLength: number;

  /**
   * Notifies Swiper page the custom content transition animation is complete.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  finishTransition(): void;
}

/**
 * The result of swiper ContentWillScrollCallback.
 *
 * @interface SwiperContentWillScrollResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SwiperContentWillScrollResult {
  /**
   * the index value of the current child page.
   *
   * @type { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  currentIndex: number;

  /**
   * the index value of the child page that will display.
   *
   * @type { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  comingIndex: number;

  /**
   * the sliding offset of each frame. Positive numbers indicating slide backward(e.g. from index=1 to index=0),
   * negative numbers indicating slide forward(e.g. from index=0 to index=1).
   *
   * @type { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  offset: number;
}

/**
 * The callback of onContentDidScroll.
 *
 * @typedef { function } ContentDidScrollCallback
 * @param { number } selectedIndex - the index value of the swiper content selected before animation start.
 * @param { number } index - the index value of the swiper content.
 * @param { number } position - the moving ratio of the swiper content from the start position of the swiper main axis.
 * @param { number } mainAxisLength - the swiper main axis length for calculating position.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type ContentDidScrollCallback = (selectedIndex: number, index: number, position: number,
  mainAxisLength: number) => void;

/**
 * The callback of onContentWillScroll.
 *
 * @typedef { function } ContentWillScrollCallback
 * @param { SwiperContentWillScrollResult } result - the result of swiper ContentWillScrollCallback.
 * @returns { boolean } whether to allow scroll, true indicating can scroll and false indicating can not scroll.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type ContentWillScrollCallback = (result: SwiperContentWillScrollResult) => boolean;

@memo
@ComponentBuilder
export declare function Swiper(
  controller?: SwiperController,
  @memo
  content_?: () => void,
): SwiperAttribute
