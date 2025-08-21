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

import { BackgroundBlurStyleOptions, BackgroundEffectOptions, BlurStyle, Callback, CommonMethod, Optional, TranslateOptions, DividerStyle, Bindable } from './common';
import { EdgeEffect, PageFlipMode } from "./enums";
import { Dimension, Length, ResourceColor } from "./units";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Declare the graphic format of the bar chart.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum BarMode {
    /**
     * The width of each tab is determined by the actual layout. The tabs are scrollable in the following case:
     * In horizontal layout, the total width exceeds the tab bar width; in vertical layout,
     * the total height exceeds the tab bar height.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Scrollable = 0,
    /**
     * The width of each tab is determined by equally dividing the number of tabs by the bar width
     * (or bar height in the vertical layout).
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Fixed = 1
}
/**
 * Declare the animation mode of tab content.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum AnimationMode {
    /**
     * Load the content of the target page before starting the switching animation.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CONTENT_FIRST = 0,
    /**
     * Start the switching animation before loading the content of the target page.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ACTION_FIRST = 1,
    /**
     * Disable the default switching animation.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NO_ANIMATION = 2,
    /**
     * Load the content of the target page first, then jump to the vicinity of the target page without animation,
     * and finally jump to the target page with animation.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CONTENT_FIRST_WITH_JUMP = 3,
    /**
     * Jump to the vicinity of the target page without animation first,
     * then jump to the target page with animation, and finally load the content of the target page.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ACTION_FIRST_WITH_JUMP = 4
}
/**
 * Declare the location of the bar chart.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum BarPosition {
    /**
     * When the vertical attribute method is set to true, the tab is on the left of the container. When the vertical property method is set to false, the tab is at the top of the container.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Start,
    /**
     * When the vertical attribute method is set to true, the tab is located on the right of the container. When the vertical property method is set to false, the tab is at the bottom of the container.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    End
}
/**
 * Declare the layout style of the tab bar items.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum LayoutStyle {
    /**
     * If the tab content exceeds the tab bar width, the tabs are scrollable.
     * If not, the tabs are compactly centered on the tab bar and not scrollable.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ALWAYS_CENTER = 0,
    /**
     * If the tab content exceeds the tab bar width, the tabs are scrollable.
     * If not, the tabs are not scrollable, and the width of the tab bar is evenly distributed among all tabs.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ALWAYS_AVERAGE_SPLIT = 1,
    /**
     * If the tab content exceeds the tab bar width, the tabs are scrollable. If the tab content exceeds
     * half the width of the tab bar but is still within the tab bar width, the tabs are compactly centered and
     * not scrollable.If the tab content does not exceed half the width of the tab bar, the tabs are centered within
     * half the width of the tab bar with even spacing between them and are not scrollable.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SPACE_BETWEEN_OR_CENTER = 2
}
/**
 * Declare the cache mode of the child components.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TabsCacheMode {
    /**
     * Caches the child components on both sides of the current child components.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CACHE_BOTH_SIDE = 0,
    /**
     * Caches the latest switched child components.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CACHE_LATEST_SWITCHED = 1
}
/**
 * Provides methods for switching tabs.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class TabsController {
    /**
     * constructor.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor();
    /**
     * Switches to the specified tab.
     *
     * @param { number } value - Index of the tab. If this parameter is set to a value less than 0
     * or greater than the maximum number, the default value 0 is used.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    changeIndex(value: number): void;
    /**
     * Called when need to preload specified tab content.
     *
     * @param { Optional<Array<number>> } indices - Indices of tab content to be preloaded.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter invalid. Possible causes:
     * <br> 1. The parameter type is not Array<number>.
     * <br> 2. The parameter is an empty array.
     * <br> 3. The parameter contains an invalid index.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    preloadItems(indices: Optional<Array<number>>): Promise<void>;
    /**
     * Set tab bar translate.
     *
     * @param { TranslateOptions } translate - translate options
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setTabBarTranslate(translate: TranslateOptions): void;
    /**
     * Set tab bar opacity.
     *
     * @param { number } opacity - opacity
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setTabBarOpacity(opacity: number): void;
}
/**
 * Options used to create Tabs.
 *
 * @typedef TabsOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TabsOptions {
    /**
     * Set the tab location for Tabs.
     *
     * @type { ?BarPosition }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barPosition?: BarPosition;
    /**
     * Set the index of the currently displayed tab.
     *
     * @type { ?(number | Bindable<number>) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    index?: number | Bindable<number>;
    /**
     * Set the Tabs controller.
     *
     * @type { ?TabsController }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    controller?: TabsController;
}
/**
 * Provides an interface for tabs animation.
 *
 * @interface TabsAnimationEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TabsAnimationEvent {
    /**
     * Offset of the current page to the start position of the tabs main axis. The unit is vp.
     *
     * @type { number }
     * @default 0.0 vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    currentOffset: number;
    /**
     * Offset of the target page to the start position of the tabs main axis. The unit is vp.
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
 * Provides an interface for the grid column options of an tab bar including sm, md, lg, margin and gutter.
 *
 * @interface BarGridColumnOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface BarGridColumnOptions {
    /**
     * Number of columns occupied by a tab on a screen whose width is
     * greater than or equal to 320 vp but less than 600 vp. The value must be a non-negative even number.
     *
     * @type { ?number }
     * @default -1
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    sm?: number;
    /**
     * Number of columns occupied by a tab on a screen whose width is
     * greater than or equal to 600 vp but less than 800 vp. The value must be a non-negative even number.
     *
     * @type { ?number }
     * @default -1
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    md?: number;
    /**
     * Number of columns occupied by a tab on a screen whose width is
     * greater than or equal to 840 vp but less than 1024 vp. The value must be a non-negative even number.
     *
     * @type { ?number }
     * @default -1
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    lg?: number;
    /**
     * Column margin in grid mode. It cannot be set in percentage.
     *
     * @type { ?Dimension }
     * @default 24vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    margin?: Dimension;
    /**
     * Column gutter (that is, gap between columns) in grid mode. It cannot be set in percentage.
     *
     * @type { ?Dimension }
     * @default 24vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    gutter?: Dimension;
}
/**
 * Provides an interface for the options for the scrollable bar mode including margin and nonScrollableLayoutStyle.
 *
 * @interface ScrollableBarModeOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface ScrollableBarModeOptions {
    /**
     * Left and right margin of the tab bar in scrollable mode. It cannot be set in percentage.
     *
     * @type { ?Dimension }
     * @default 0vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    margin?: Dimension;
    /**
     * Tab layout mode of the tab bar when not scrolling in scrollable mode.
     *
     * @type { ?LayoutStyle }
     * @default LayoutStyle.ALWAYS_CENTER
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    nonScrollableLayoutStyle?: LayoutStyle;
}
/**
 * Defines a tabs callback when onAnimationStart.
 *
 * @typedef { function } OnTabsAnimationStartCallback
 * @param { number } index - The index value of the tab that when animation start.
 * @param { number } targetIndex - The target index value of the tab that when animation start.
 * @param { TabsAnimationEvent } extraInfo - The extra callback info.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnTabsAnimationStartCallback = (index: number, targetIndex: number, extraInfo: TabsAnimationEvent) => void;
/**
 * Defines a tabs callback when onAnimationEnd.
 *
 * @typedef { function } OnTabsAnimationEndCallback
 * @param { number } index - The index value of the tab that when animation end.
 * @param { TabsAnimationEvent } extraInfo - The extra callback info.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnTabsAnimationEndCallback = (index: number, extraInfo: TabsAnimationEvent) => void;
/**
 * Defines a tabs callback when onGestureSwipe.
 *
 * @typedef { function } OnTabsGestureSwipeCallback
 * @param { number } index - The index value of the tab before gesture swipe.
 * @param { TabsAnimationEvent } extraInfo - The extra callback info.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnTabsGestureSwipeCallback = (index: number, extraInfo: TabsAnimationEvent) => void;
/**
 * Defines a tabs callback when customContentTransition.
 *
 * @typedef { function } TabsCustomContentTransitionCallback
 * @param { number } from - The index value of the current tab when the animation begins.
 * @param { number } to - The index value of the target tab when the animation begins.
 * @returns { TabContentAnimatedTransition | undefined } Returns animated transition options of tab or undefined.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type TabsCustomContentTransitionCallback = (from: number, to: number) => TabContentAnimatedTransition | undefined;
/**
 * Defines a tabs callback when onContentWillChange.
 *
 * @typedef { function } OnTabsContentWillChangeCallback
 * @param { number } currentIndex - The index value of the current tab.
 * @param { number } comingIndex - The index value of the tab that will change.
 * @returns { boolean }
 * Tabs can change from currentIndex to comingIndex if function return true.
 * Tabs can not change from currentIndex to comingIndex if function return false.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnTabsContentWillChangeCallback = (currentIndex: number, comingIndex: number) => boolean;

/**
 * The TabsAttribute.
 * 
 * @extends CommonMethod
 * @interface TabsAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TabsAttribute extends CommonMethod {
    /**
     * Sets whether to use vertical tabs.
     *
     * @param { boolean } value - Whether to use vertical tabs. Default value is false.
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    vertical(value: boolean | undefined): this;
    /**
     * Sets the position of the Tabs component.
     *
     * @param { BarPosition } value - Position of the Tabs component. Default value is BarPosition.Start.
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barPosition(value: BarPosition | undefined): this;
    /**
     * Sets whether the tabs are scrollable.
     *
     * @param { boolean } value - Whether the tabs are scrollable. Default value is true.
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scrollable(value: boolean | undefined): this;
    /**
     * Sets the tab bar layout mode.
     *
     * @param { BarMode } value - Layout mode. Default value is BarMode.Fixed.
     * @param { ScrollableBarModeOptions } [options] - Layout style of the tab bar in scrollable mode.
     * This parameter is effective only when the tab bar is in horizontal scrollable mode.
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barMode(value: BarMode | undefined, options?: ScrollableBarModeOptions | undefined): this;
    /**
     * Sets the width of the tab bar.
     * Notice: barWidth only supports Number type on 7, supports Length type since 8.
     *
     * @param { Length } value - Width of the tab bar. If the set value is less than 0
     * or greater than the width of the Tabs component, the default value is used.
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barWidth(value: Length | undefined): this;
    /**
     * Sets the height of the tab bar.
     * Notice: barHeight only supports Number type on 7, supports Length type since 8.
     *
     * @param { Length } value - Height of the tab bar. If the set value is less than 0 or
     * greater than the height of the Tabs component, the default value is used.
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barHeight(value: Length | undefined): this;
    /**
     * Sets the length of time required to complete the tab switching animation,
     * which is initiated by clicking a specific tab or by calling the changeIndex API of TabsController.
     *
     * @param { number } value
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    animationDuration(value: number | undefined): this;
    /**
     * Sets the animation mode for tab switching initiated by clicking a specific tab or
     * by calling the changeIndex API of TabsController.
     *
     * @param { Optional<AnimationMode> } mode - animation mode for tabs switch animation.
     * Default value is AnimationMode.CONTENT_FIRST.
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    animationMode(mode: AnimationMode | undefined): this;
    /**
     * Sets the edge effect used when the boundary of the scrolling area is reached.
     *
     * @param { Optional<EdgeEffect> } edgeEffect - Effect used when the boundary of the scrolling area is reached.
     * Default value is EdgeEffect.Spring.
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    edgeEffect(edgeEffect: EdgeEffect | undefined): this;
    /**
     * Triggered when a tab is switched.
     * Anonymous Object Rectification
     *
     * <p><strong>NOTE</strong>:
     * <br>This event is triggered when any of the following conditions is met:
     * 1. The swiping animation is completed, followed by tab switching.
     * 2. The Controller API is called.
     * 3. The attribute value is updated using a state variable.
     * 4. A tab is clicked.
     * </p>
     *
     * @param { Callback<number> } event
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onChange(event: Callback<number> | undefined): this;
    /**
     * Called when a new tab becomes selected. Animation is not necessarily complete.
     *
     * @param { Callback<number> } event - callback to notify which index has been selected
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onSelected(event: Callback<number> | undefined): this;
    /**
     * Triggered when a tab is clicked.
     * Anonymous Object Rectification
     *
     * @param { Callback<number> } event
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onTabBarClick(event: Callback<number> | undefined): this;
    /**
     * Called when a new tab becomes unselected. Animation is not necessarily complete.
     *
     * @param { Callback<number> } event - callback to notify which index has been unselected
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onUnselected(event: Callback<number> | undefined): this;
    /**
     * Triggered when the tab switching animation starts.
     * Anonymous Object Rectification
     *
     * @param { OnTabsAnimationStartCallback } handler
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAnimationStart(handler: OnTabsAnimationStartCallback | undefined): this;
    /**
     * Triggered when the tab switching animation ends.
     * Anonymous Object Rectification
     *
     * @param { OnTabsAnimationEndCallback } handler
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAnimationEnd(handler: OnTabsAnimationEndCallback | undefined): this;
    /**
     * Triggered on a frame-by-frame basis when the tab is switched by a swipe.
     * Anonymous Object Rectification
     *
     * @param { OnTabsGestureSwipeCallback } handler
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onGestureSwipe(handler: OnTabsGestureSwipeCallback | undefined): this;
    /**
     * Sets whether the tab fades out when it exceeds the container width.
     *
     * <p><strong>NOTE</strong>:
     * <br>It is recommended that this attribute be used together with the barBackgroundColor attribute.
     * If the barBackgroundColor attribute is not defined, the tab fades out in white
     * when it exceeds the container width by default.
     * </p>
     *
     * @param { boolean } value - Whether the tab fades out when it exceeds the container width. Default value is true.
     * @returns { TabsAttribute } the attribute of the tabs
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fadingEdge(value: boolean | undefined): this;
    /**
     * Set the divider between tab bar and tab content.
     *
     * @param { DividerStyle | null } value - indicates the style of the indicator. Default value is null.
     * @returns { TabsAttribute } the attribute of the tabs
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    divider(value: DividerStyle | null | undefined): this;
    /**
     * Sets whether the tab bar is superimposed on the TabContent component after having its background blurred.
     *
     * @param { boolean } value - indicates whether the tab bar overlaps with the tab content. Default value is false.
     * @returns { TabsAttribute } the attribute of the tabs
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barOverlap(value: boolean | undefined): this;
    /**
     * Set the background color of the tab bar.
     *
     * @param { ResourceColor } value - indicates the background color of the tab bar.
     * Default value is Color.Transparent.
     * @returns { TabsAttribute } the attribute of the tabs
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barBackgroundColor(value: ResourceColor | undefined): this;
    /**
     * Sets the visible area of the tab bar in grid mode.
     *
     * <p><strong>NOTE</strong>:
     * <br>This attribute is effective only in horizontal mode. It is not applicable to XS, XL, and XXL devices.
     * </p>
     *
     * @param { BarGridColumnOptions } value - indicates the bar grid alignment options.
     * @returns { TabsAttribute } the attribute of the tabs
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barGridAlign(value: BarGridColumnOptions | undefined): this;
    /**
     * Custom tab content transition animation.
     * When undefined is set, this interface does not take effect.
     * Anonymous Object Rectification
     *
     * <p><strong>NOTE</strong>:
     * <br>Instructions:
     * <br>1. When the custom tab switching animation is used, the default switching animation of
     * the Tabs component is disabled, and tabs cannot be switched through swiping.
     * <br>2. The value undefined means not to use the custom tab switching animation,
     * in which case the default switching animation is used.
     * <br>3. The custom tab switching animation cannot be interrupted.
     * <br>4. Currently, the custom tab switching animation can be triggered only by clicking a tab
     * or by calling the TabsController.changeIndex() API.
     * <br>5. When the custom tab switching animation is used,
     * the Tabs component supports all events except onGestureSwipe.
     * <br>6. Notes about the onChange and onAnimationEnd events: If the second custom animation is triggered
     * during the execution of the first custom animation, the onChange and onAnimationEnd events of
     * the first custom animation will be triggered when the second custom animation starts.
     * <br>7. When the custom animation is used, the stack layout is used for pages involved in the animation.
     * If the zIndex attribute is not set for related pages, the zIndex values of all pages are the same.
     * In this case, the pages are rendered in the order in which they are added to
     * the component tree(that is, the sequence of page indexes). In light of this,
     * to control the rendering levels of pages, set the zIndex attribute of the pages.
     * </p>
     *
     * @param { TabsCustomContentTransitionCallback } delegate - Custom content transition animation.
     * @returns { TabsAttribute } The attribute of the tabs.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    customContentTransition(delegate: TabsCustomContentTransitionCallback | undefined): this;
    /**
     * Sets the background blur style of the tab bar.
     *
     * @param { BlurStyle } value - Background blur style of the tab bar. Default value is BlurStyle.NONE.
     * @returns { TabsAttribute } the attribute of the tabs
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barBackgroundBlurStyle(value: BlurStyle | undefined): this;
    /**
     * Setting page flip mode on mouse wheel event.
     *
     * @param { Optional<PageFlipMode> } mode - page flip mode on mouse wheel event. The default value is PageFlipMode.CONTINUOUS.
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pageFlipMode(mode: PageFlipMode | undefined): this;
    /**
     * Set the BlurStyle of the tab bar.
     *
     * @param { BlurStyle } style - style indicate the blur style for the tab bar
     * @param { BackgroundBlurStyleOptions } options - options indicate the options for the tab bar
     * @returns { TabsAttribute } the attribute of the tabs
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barBackgroundBlurStyle(style: BlurStyle | undefined, options: BackgroundBlurStyleOptions | undefined): this;
    /**
     * Set the BackgroundEffect of the tab bar.
     *
     * @param { BackgroundEffectOptions } options - options indicate the options for the tab bar
     * @returns { TabsAttribute } the attribute of the tabs
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barBackgroundEffect(options: BackgroundEffectOptions | undefined): this;
    /**
     * Triggered when a new page is about to be displayed.
     * Anonymous Object Rectification
     *
     * <p><strong>NOTE</strong>:
     * <br>This event is triggered when any of the following conditions is met:
     * 1. When the user swipes on the TabContent component (provided that it supports swiping) to switch to a new page.
     * 2. When TabsController.changeIndex is called to switch to a new page.
     * 3. When the **index** attribute is changed to switch to a new page.
     * 4. When the user clicks a tab on the tab bar to switch to a new page.
     * 5. When the user presses the left or right arrow key on the keyboard to switch to a new page
     * while the tab bar is focused.
     * </p>
     *
     * @param { OnTabsContentWillChangeCallback } handler
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onContentWillChange(handler: OnTabsContentWillChangeCallback | undefined): this;
    /**
     * Sets the maximum number of child components to be cached.
     *
     * @param { number } count - the maximum number of child components to be cached.
     * @param { TabsCacheMode } mode - the mode of caching child components.
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    cachedMaxCount(count: number | undefined, mode: TabsCacheMode | undefined): this;

    /**
     * Sets the attribute modifier to Tabs.
     *
     * @param { numberAttributeModifier<TabsAttribute> | AttributeModifier<CommonMethod> | undefined } modifier -
     *  the input modifier.
     * @returns { TabsAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    attributeModifier(modifier: AttributeModifier<TabsAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Defines the Tab Content animated transition options.
 *
 * @interface TabContentAnimatedTransition
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TabContentAnimatedTransition {
    /**
     * Defines the timeout of custom content transition animation. The unit is ms.
     * If TabContentTransitionProxy.finishTransition() is not invoked, use the timeout as animation end time.
     *
     * @type { ?number }
     * @default 1000 ms
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    timeout?: number;
    /**
     * Called when custom content transition animation start.
     * Anonymous Object Rectification
     *
     * @type { Callback<TabContentTransitionProxy> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    transition: Callback<TabContentTransitionProxy>;
}
/**
 *  The proxy of TabContentAnimatedTransition.
 *
 * @interface TabContentTransitionProxy
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TabContentTransitionProxy {
    /**
     * The index of current tab content.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    from: number;
    /**
     * The index of target tab content.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    to: number;
    /**
     * Notifies Tabs component the custom content transition animation is complete.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    finishTransition(): void;
}

/**
 * Defines Tabs Component
 *
 * @param { TabsOptions } [options] - tabs constructor options
 * @param { function } [content_] - container
 * @returns { FlowItemAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Tabs(
    options?: TabsOptions, 
    @memo
    content_?: () => void,
): TabsAttribute
