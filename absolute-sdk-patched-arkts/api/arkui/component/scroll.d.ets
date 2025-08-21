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
import { BarState, Edge, Color, EdgeEffect, ScrollSource, Curve } from './enums';
import { ICurve, RectResult, ScrollableCommonMethod, EdgeEffectOptions, NestedScrollOptions, CommonMethod } from './common';
import { Dimension, Length, VoidCallback, Resource, LengthMetrics } from './units';
import { ScrollSnapAlign, ScrollState } from "./list";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Enumerates the scrolling directions.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ScrollDirection {
    /**
     * Only vertical scrolling is supported.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Vertical,
    /**
     * Only horizontal scrolling is supported.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Horizontal,
    /**
     * Scrolling is disabled.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None
}
/**
 * Enumerates alignment modes.
 *
 * @enum { number } ScrollAlign
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ScrollAlign {
    /**
     * The start edge of the list item is flush with the start edge of the list.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    START,
    /**
     * The list item is centered along the main axis of the list.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CENTER,
    /**
     * The end edge of the list item is flush with the end edge of the list.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    END,
    /**
     * The list item is automatically aligned.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    AUTO
}
/**
 * Represents the offset values resulting from a scroll operation.
 *
 * @interface OffsetResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface OffsetResult {
    /**
     * Horizontal scrolling offset.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xOffset: number;
    /**
     * Vertical scrolling offset.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    yOffset: number;
}
/**
 * Provides parameters for scrolling to the edge of a scrollable container.
 *
 * @interface ScrollEdgeOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ScrollEdgeOptions {
    /**
     * Fixed velocity for scrolling to the edge of the container.
     * If the value specified is less than or equal to 0, the parameter will not take effect.
     *
     * @type { ?number }
     * @default 0vp/s
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    velocity?: number;
}
/**
 * Provides parameters for scrolling to a specific index.
 *
 * @interface ScrollToIndexOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ScrollToIndexOptions {
    /**
     * Extra offset for scrolling to a specified index.
     *
     * @type { ?LengthMetrics }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    extraOffset?: LengthMetrics;
}
/**
 * Provides parameters for customizing scroll animations.
 *
 * @interface ScrollAnimationOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ScrollAnimationOptions {
    /**
     * Scrolling duration.
     *
     * <p><strong>NOTE</strong>
     * <br>A value less than 0 evaluates to the default value.
     * </p>
     *
     * @type { ?number }
     * @default 1000
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    duration?: number;
    /**
     * Scrolling curve.
     *
     * @type { ?(Curve | ICurve) }
     * @default Curve.Ease
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    curve?: Curve | ICurve;
    /**
     * Whether to enable overscroll.
     *
     * <p><strong>NOTE</strong>
     * <br> Scrolling can exceed the boundary and initiate a bounce animation when this parameter is set to <em>true</em>,
     * and the component's <em>edgeEffect</em> attribute is set to EdgeEffect.Spring.
     * </p>
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    canOverScroll?: boolean;
}
/**
 * Provides parameters for setting the initial scrolling offset.
 *
 * @interface OffsetOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface OffsetOptions {
    /**
     * Horizontal scrolling offset.
     *
     * @type { ?Dimension }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xOffset?: Dimension;
    /**
     * Vertical scrolling offset.
     *
     * @type { ?Dimension }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    yOffset?: Dimension;
}
/**
 * Defines a controller for scrollable container components.
 *
 * <p><strong>NOTE</strong>
 * <br>1. The binding of a <em>Scroller</em> instance to a scrollable container component occurs during the component creation phase.
 * <br>2. <em>Scroller</em> APIs can only be effectively called after the <em>Scroller</em> instance is bound to a scrollable container component.
 * Otherwise, depending on the API called, it may have no effect or throw an exception.
 * <br>3. For example, with aboutToAppear, this callback is executed after a new instance of a custom component is
 * created and before its <em>build()</em> method is called.
 * Therefore, if a scrollable component is defined within the <em>build</em> method of a custom component,
 * the internal scrollable component has not yet been created during the <em>aboutToAppear</em> callback
 * of that custom component, and therefore the <em>Scroller</em> APIs cannot be called effectively.
 * </p>
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class Scroller {
    /**
     * A constructor used to create a <em>Scroller</em> object.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor();
    /**
     * Called when the setting slides to the specified position.
     *
     * @param { ScrollOptions } options - scroll options
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scrollTo(options: ScrollOptions): void;
    /**
     * Called when scrolling to the edge of the container.
     *
     * @param { Edge } value - Edge type of the container.
     * @param { ScrollEdgeOptions } [options] - Options of scrolling to edge.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scrollEdge(value: Edge, options?: ScrollEdgeOptions): void;
    /**
     * Performs inertial scrolling based on the initial velocity passed in.
     *
     * @param { number } velocity - Initial velocity of inertial scrolling. Unit: vp/s
     * <br><em>NOTE</em>
     * <br>If the value specified is 0, it is considered as invalid, and the scrolling for this instance will not take effect.
     * A positive value indicates scrolling towards the top, while a negative value indicates scrolling towards the bottom.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 100004 - Controller not bound to component.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fling(velocity: number): void;
    /**
     * Called when page turning mode is set.
     *
     * @param { ScrollPageOptions } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scrollPage(value: ScrollPageOptions): void;
    /**
     * Obtains the current scrolling offset.
     *
     * @returns { OffsetResult } Returns the current scrolling offset. If the scroller not bound to a component, the return value is void.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    currentOffset(): OffsetResult;
    /**
     * Scroll to the specified index.
     *
     * @param { number } value - Index to jump to.
     * @param { boolean } [smooth] - If true, scroll to index item with animation. If false, scroll to index item without animation.
     * @param { ScrollAlign } [align] - Sets the alignment mode of a specified index.
     * @param { ScrollToIndexOptions } [options] - Sets the options of a specified index, such as extra offset.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scrollToIndex(value: number, smooth?: boolean, align?: ScrollAlign, options?: ScrollToIndexOptions): void;
    /**
     * Called when the setting slides by offset.
     *
     * @param { Length } dx
     * @param { Length } dy
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scrollBy(dx: Length, dy: Length): void;
    /**
     * Checks whether the component has scrolled to the bottom.
     *
     * <p><strong>NOTE</strong>
     * <br>This API is available for the <em>ArcList</em>, <em>Scroll</em>, <em>List</em>, <em>Grid</em>, and <em>WaterFlow</em> components.
     * </p>
     *
     * @returns { boolean } Returns whether the component scrolls to the end position.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isAtEnd(): boolean;
    /**
     * Obtains the size and position of a child component relative to its container.
     *
     * <p><strong>NOTE</strong>
     * <br>- The value of <em>index</em> must be the index of a child component visible in the display area.
     * Otherwise, the value is considered invalid.
     * <br>- The value of <em>index</em> must be the index of a child component visible in the display area. Otherwise,
     * the value is considered invalid.
     * </p>
     *
     * @param { number } index - Index of the target child component.
     * @returns { RectResult } Returns the size and position.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 100004 - Controller not bound to component.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getItemRect(index: number): RectResult;
    /**
     * Obtains the index of a child component based on coordinates.
     *
     * <p><strong>NOTE</strong>
     * <br>The returned index is <em>-1</em> for invalid coordinates.
     * </p>
     *
     * @param { number } x - X-coordinate, in vp.
     * @param { number } y - Y-coordinate, in vp.
     * @returns { number } Index of the item.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 100004 - The controller not bound to component.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getItemIndex(x: number, y: number): number;
}
/**
 * Provides parameters for scrolling to a specific position in a scrollable container.
 *
 * @interface ScrollOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ScrollOptions {
    /**
     * Horizontal scrolling offset.
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>
     * <br>This parameter cannot be set in percentage.
     * <br>If the value is less than 0, the offset will be 0 for non-animated scrolling.
     * Animated scrolling stops at the starting position by default.
     * By setting the <em>animation</em> parameter, you can enable a bounce effect when the scrolling goes beyond the boundary.
     * <br>This parameter takes effect only when the scroll axis is the x-axis.
     * </p>
     *
     * @type { number | string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xOffset: number | string;
    /**
     * Vertical scrolling offset.
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>
     * <br>This parameter cannot be set in percentage.
     * <br>If the value is less than 0, the offset will be 0 for non-animated scrolling.
     * Animated scrolling stops at the starting position by default.
     * By setting the <em>animation</em> parameter, you can enable a bounce effect when the scrolling goes beyond the boundary.
     * <br>This parameter takes effect only when the scroll axis is the y-axis.
     * </p>
     *
     * @type { number | string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    yOffset: number | string;
    /**
     * Animation configuration
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>
     * <br>Currently, the <em>List</em>, <em>Scroll</em>, <em>Grid</em>, and <em>WaterFlow</em> support the <em>Boolean</em> type and <em>ICurve</em>.
     * </p>
     *
     * @type { ?( ScrollAnimationOptions | boolean) } The ScrollAnimationOptions type provides custom animation parameters
     * and the boolean type enables default spring animation.
     * @default ScrollAnimationOptions: { duration: 1000, curve: Curve.Ease, canOverScroll: false }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    animation?: ScrollAnimationOptions | boolean;
}
/**
 * Provides parameters for page scrolling behavior.
 *
 * @interface ScrollPageOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ScrollPageOptions {
    /**
     * Whether to turn to the next page.The value true means to scroll to the next page,
     * and false means to scroll to the previous page.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    next: boolean;
    /**
     * Whether to enable the page-turning animation.The value true means to enable the page-turning animation,
     * and false means the opposite.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    animation?: boolean;
}
/**
 * Defines a scroll snapping mode object.
 *
 * @interface ScrollSnapOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ScrollSnapOptions {
    /**
     * Alignment mode for the scroll snap position.
     *
     * @type { ScrollSnapAlign }
     * @default ScrollSnapAlign.NONE
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    snapAlign: ScrollSnapAlign;
    /**
     * Pagination points for scroll snapping.
     *
     * <p><strong>NOTE</strong>
     * <br>1. If the value is of the Dimension type, it indicates the size of each page, and the system will paginate based on this size.
     * <br>2. If the value is of the Array\<Dimension\> type, each <em>Dimension</em> represents a pagination point,
     * and the system will paginate accordingly. Each <em>Dimension</em> value must be within the [0, scrollable distance] range.
     * <br>3. If this parameter is not set or <em>Dimension</em> is set to a value less than or equal to 0, the value is regarded as an invalid value.
     * In this case, there is no scroll snapping. When the value is of the Array\<Dimension\> type, the items in the array must be monotonically increasing.
     * <br>4. When the value is a percentage, the actual size is the product of the viewport of the <em>Scroll</em> component and the percentage value.
     * </p>
     *
     * @type { ?(Dimension | Array<Dimension>) }
     * @default 100%
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    snapPagination?: Dimension | Array<Dimension>;
    /**
     * Whether to enable the snap to start feature. When scroll snapping is defined for the <em>Scroll</em> component,
     * setting this parameter to <em>false</em> enables the component to scroll between the start and the first page.
     *
     * <p><strong>NOTE</strong>
     * <br>2. This attribute takes effect only when <em>snapPagination</em> is set to a value of the <em>Array\<Dimension\></em> type;
     * it does not work with values of the <em>Dimension</em> type.
     * </p>
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableSnapToStart?: boolean;
    /**
     * Whether to enable the snap to end feature. When scroll snapping is defined for the <em>Scroll</em> component,
     * setting this parameter to <em>false</em> enables the component to scroll between the end and the last page.
     *
     * <p><strong>NOTE</strong>
     * <br>2. This attribute takes effect only when <em>snapPagination</em> is set to a value of the <em>Array\<Dimension\></em> type;
     * it does not work with values of the <em>Dimension</em> type.
     * </p>
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableSnapToEnd?: boolean;
}
/**
 * Represents the callback triggered when scrolling reaches an edge.
 *
 * @typedef { function } OnScrollEdgeCallback
 * @param { Edge } side - Edge position to scroll to.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnScrollEdgeCallback = (side: Edge) => void;
/**
 * The data returned by the event handler when onScrollFrameBegin.
 *
 * @interface OnScrollFrameBeginHandlerResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface OnScrollFrameBeginHandlerResult {
    /**
     * Actual scroll offset.
     * Anonymous Object Rectification.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offsetRemain: number;
}
/**
 * Represents the callback triggered before each frame scrolling starts.
 *
 * @typedef { function } OnScrollFrameBeginCallback
 * @param { number } offset - Amount to scroll by, in vp.
 * @param { ScrollState } state - Current scroll state.
 * @returns { OnScrollFrameBeginHandlerResult } data - the scroll data return by handler
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnScrollFrameBeginCallback = (offset: number, state: ScrollState) => OnScrollFrameBeginHandlerResult;

/**
 * The ScrollAttribute
 * 
 * @extends ScrollableCommonMethod
 * @interface ScrollAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ScrollAttribute extends ScrollableCommonMethod {
    /**
     * Sets the scrolling direction.
     *
     * @param { ScrollDirection | undefined } value - Scrolling direction.<br>Default value: <em>ScrollDirection.Vertical</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default scrollable(value: ScrollDirection | undefined): this;
    /**
     * Triggered before scrolling.
     *
     * <p><strong>NOTE</strong>
     * <br>1. This event is triggered when scrolling is started by the <em>Scroll</em> component or other input settings,
     * such as keyboard and mouse operations.
     * <br>2. This event is triggered when the controller API is called.
     * <br>3. This event supports the out-of-bounds bounce effect.
     * </p>
     *
     * @param { ScrollOnWillScrollCallback | undefined } handler - Callback triggered before scrolling.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onWillScroll(handler: ScrollOnWillScrollCallback | undefined): this;
    /**
     * Triggered when the Scroll component scrolls.
     *
     * <p><strong>NOTE</strong>
     * <br>1. This event is triggered when scrolling is started by the <em>Scroll</em> component or other input settings,
     * such as keyboard and mouse operations.
     * <br>2. This event is triggered when the controller API is called.
     * <br>3. This event supports the out-of-bounds bounce effect.
     * </p>
     *
     * @param { ScrollOnScrollCallback | undefined } handler - Callback triggered when the <em>Scroll</em> component scrolls.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onDidScroll(handler: ScrollOnScrollCallback | undefined): this;
    /**
     * Triggered when scrolling reaches the edge.
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>
     * <br>1. This event is triggered when scrolling reaches the edge after being started by the <em>Scroll</em> component or other input settings,
     * such as keyboard and mouse operations.
     * <br>2. This event is triggered when the controller API is called.
     * <br>3. This event supports the out-of-bounds bounce effect.
     * </p>
     *
     * @param { OnScrollEdgeCallback | undefined } event - Edge position to scroll to.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onScrollEdge(event: OnScrollEdgeCallback | undefined): this;
    /**
     * Called when scrolling start.
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>
     * <br>1. This event is triggered when scrolling is started by the <em>Scroll</em> component or other input settings, such as keyboard and mouse operations.
     * <br>2. This event is triggered when the controller API is called, accompanied by a transition animation.
     * </p>
     *
     * @param { VoidCallback | undefined } event - Callback triggered when scrolling starts.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onScrollStart(event: VoidCallback | undefined): this;
    /**
     * Called when scrolling has stopped.
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>
     * <br>1. This event is triggered when scrolling is stopped by the <em>Scroll</em> component or other input settings, such as keyboard and mouse operations.
     * <br>2. This event is triggered when the controller API is called, accompanied by a transition animation.
     * </p>
     *
     * @param { VoidCallback | undefined } event - Callback triggered when scrolling stops.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onScrollStop(event: VoidCallback | undefined): this;
    /**
     * Sets the scrollbar state.
     *
     * @param { BarState | undefined } barState - Scrollbar state.<br>Default value: <em>BarState.Auto</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default scrollBar(barState: BarState | undefined): this;
    /**
     * Sets the scrollbar color.
     *
     * @param { Color | number | string | undefined } color - Scrollbar color.<br>Default value: <em>'\#182431'</em> (40% opacity)
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default scrollBarColor(color: Color | number | string | undefined): this;
    /**
     * Sets the scrollbar width.
     *
     * @param { number | string | undefined } value - Scrollbar width.<br>Default value: <em>4</em> <br>Unit: vp
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default scrollBarWidth(value: number | string | undefined): this;
    /**
     * Sets the effect used when the scroll boundary is reached.
     *
     * @param { EdgeEffect | undefined } edgeEffect - Effect used when the scroll boundary is reached. The spring and shadow effects are supported.
     * <br>Default value: <em>EdgeEffect.None</em>
     * @param { EdgeEffectOptions | undefined } [options] - Whether to enable the scroll effect when the component content is smaller than the component itself.
     * The value <em>{ alwaysEnabled: true }</em> means to enable the scroll effect, and <em>{ alwaysEnabled: false }</em> means the opposite.
     * <br>Default value: <em>{ alwaysEnabled: true }</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default edgeEffect(edgeEffect: EdgeEffect | undefined, options?: EdgeEffectOptions | undefined): this;
    /**
     * Triggered when each frame scrolling starts.
     * Anonymous Object Rectification.
     *
     * @param { OnScrollFrameBeginCallback | undefined } event - Callback triggered when each frame scrolling starts.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onScrollFrameBegin(event: OnScrollFrameBeginCallback | undefined): this;
    /**
     * Sets the nested scrolling options. You can set the nested scrolling mode in the forward and backward directions
     * to implement scrolling linkage with the parent component.
     *
     * @param { NestedScrollOptions | undefined } value - Nested scrolling options.
     * <br>Default value: <em>{ scrollForward: NestedScrollMode.SELF_ONLY, scrollBackward: NestedScrollMode.SELF_ONLY }</em>
     * @returns { this } the attribute of the scroll.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default nestedScroll(value: NestedScrollOptions | undefined): this;
    /**
     * Sets whether to support scroll gestures. When this attribute is set to <em>false</em>,
     * scrolling by finger or mouse is not supported, but the scroll controller API is not affected.
     *
     * @param { boolean | undefined } value - Whether to support scroll gestures.<br>Default value: <em>true</em>
     * @returns { this } The attribute of the scroll
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableScrollInteraction(value: boolean | undefined): this;
    /**
     * Sets the friction coefficient. It applies only to gestures in the scrolling area, and
     * it affects only indirectly the scroll chaining during the inertial scrolling process.
     * If this attribute is set to a value less than or equal to 0, the default value is used.
     *
     * @param { number | Resource | undefined } value - Friction coefficient.
     * <br>Default value: <em>0.9</em> for wearable devices and <em>0.6</em> for non-wearable devices
     * <br>Since API version 11, the default value for non-wearable devices is <em>0.7</em>.
     * <br>Since API version 12, the default value for non-wearable devices is <em>0.75</em>.
     * @returns { this } the attribute of the scroll.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default friction(value: number | Resource | undefined): this;
    /**
     * Sets the scroll snapping mode.
     *
     * @param { ScrollSnapOptions | undefined } value - Scroll snapping mode.
     * @returns { this } the attribute of the scroll.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default scrollSnap(value: ScrollSnapOptions | undefined): this;
    /**
     * Sets whether to enable the swipe-to-turn-pages feature.
     *
     * @param { boolean | undefined } value - Whether to enable the swipe-to-turn-pages feature.
     * The value <em>true</em> means to enable the swipe-to-turn-pages feature, and <em>false</em> means the opposite.
     * @returns { this } the attribute of the scroll.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enablePaging(value: boolean | undefined): this;
    /**
     * Sets the initial scrolling offset.
     *
     * @param { OffsetOptions | undefined } value - Initial scrolling offset. When the value specified is a percentage,
     * the initial scrolling offset is calculated as the product of the <em>Scroll</em> component's size
     * in the main axis direction and the percentage value.
     * @returns { this } the attribute of the scroll.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default initialOffset(value: OffsetOptions | undefined): this;
    /**
     * Called attributeModifier.
     *
     * @param { AttributeModifier<ScrollAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<ScrollAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Represents the callback triggered when the <em>Scroll</em> component scrolls.
 *
 * <p><strong>NOTE</strong>
 * <br>If the <em>onScrollFrameBegin</em> event and <em>scrollBy</em> method are used to implement nested scrolling,
 * set the <em>edgeEffect</em> attribute of the scrollable child component to <em>None</em>. For example,
 * if a <em>List</em> is nested in the <em>Scroll</em> component, <em>edgeEffect</em> of the <em>List</em> must be set to <em>EdgeEffect.None</em>.
 * </p>
 *
 * @typedef { function } ScrollOnScrollCallback
 * @param { number } xOffset - Horizontal offset per frame during scrolling. A positive offset indicates scrolling to the left,
 * and a negative offset indicates scrolling to the right.
 * <br>Unit: vp
 * @param { number } yOffset - Vertical offset per frame during scrolling.
 * A positive offset indicates scrolling upward, and a negative offset indicates scrolling downward.
 * <br>Unit: vp
 * @param { ScrollState } scrollState - Current scrolling state.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type ScrollOnScrollCallback = (xOffset: number, yOffset: number, scrollState: ScrollState) => void;
/**
 * Called before scroll to allow developer to control real offset the Scroll can scroll.
 *
 * @typedef { function } ScrollOnWillScrollCallback
 * @param { number } xOffset - horizontal offset this frame will scroll, which may or may not be reached.
 * @param { number } yOffset - vertical offset this frame will scroll, which may or may not be reached.
 * @param { ScrollState } scrollState - current scroll state.
 * @param { ScrollSource } scrollSource - source of current scroll.
 * @returns { undefined | OffsetResult } the remain offset for the Scroll,
 *     same as (xOffset, yOffset) when no OffsetResult is returned.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type ScrollOnWillScrollCallback = (xOffset: number, yOffset: number, scrollState: ScrollState, scrollSource: ScrollSource) => undefined | OffsetResult;

/**
 * Defines Scroll Component.
 *
 * @param { Scroller } [scroller] - scroller
 * @param { function } [content_] - container
 * @returns { ScrollAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Scroll(
    scroller?: Scroller, 
    @memo
    content_?: () => void,
): ScrollAttribute