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
import { ChildrenMainSize, ItemDragInfo, RectResult, ScrollableCommonMethod, Optional, OnWillScrollCallback, OnScrollCallback, OnItemDragStartCallback } from './common';
import { Axis } from './enums';
import { OnScrollFrameBeginCallback, ScrollAlign, Scroller } from "./scroll";
import { Dimension, Length, LengthConstrain, ResourceColor } from './units';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Declare scroll status
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ScrollState {
    /**
     * Idle state. Triggered when the scroll state returns to idle, and when the controller's
     * non-animated methods are used to control the scroll.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Idle,
    /**
     * Scrolling state. Triggered when the list is dragged with the finger,
     * when the scrollbar is dragged, or when the mouse scroll wheel is used.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Scroll,
    /**
     * Inertial scrolling state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Fling
}
/**
 * Declare list item alignment status
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ListItemAlign {
    /**
     * The list items are packed toward the start edge of the <em>List</em> component along the cross axis.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Start,
    /**
     * The list items are centered in the <em>List</em> component along the cross axis.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Center,
    /**
     * The list items are packed toward the end edge of the <em>List</em> component along the cross axis.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    End
}
/**
 * Declare list item group area
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ListItemGroupArea {
    /**
     * The edge of the viewport is in the position of <em>none</em>.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NONE = 0,
    /**
     * The edge of the viewport is in the position of a list item.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    IN_LIST_ITEM_AREA = 1,
    /**
     * The edge of the viewport is in the position of a header.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    IN_HEADER_AREA = 2,
    /**
     * The edge of the viewport is in the position of a footer.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    IN_FOOTER_AREA = 3
}
/**
 * Declare item group sticky style.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum StickyStyle {
    /**
     * In the ListItemGroup component, the header is not pinned to the top,
     * and the footer is not pinned to the bottom.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None = 0,
    /**
     * In the ListItemGroup component, the header is pinned to the top,
     * and the footer is not pinned to the bottom.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Header = 1,
    /**
     * In the <em>ListItemGroup</em> component, the footer is pinned to the bottom,
     * and the header is not pinned to the top.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Footer = 2
}
/**
 * Declare edge effect of chain animation.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
export declare enum ChainEdgeEffect {
    /**
     * Default edge effect. Compress the space in the drag direction
     * and stretch the space in the opposite drag direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    DEFAULT,
    /**
     * Stretch all space.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    STRETCH
}
/**
 * Declare limited position when scroll end.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ScrollSnapAlign {
    /**
     * No alignment. This is the default value.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NONE = 0,
    /**
     * The first item in the view is aligned at the start of the list.
     *
     * <p><strong>NOTE</strong>
     * <br>When the list hits the end, the items at the end must be completely displayed.
     * In this case, the items at the start may not be aligned.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    START = 1,
    /**
     * The middle items in the view are aligned in the center of the list.
     *
     * <p><strong>NOTE</strong>
     * <br>The top and end items can be aligned in the center of the list.
     * In this case, a blank area may result, and the first or last item is aligned to the center of the list.
     * </pr>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CENTER = 2,
    /**
     * The last item in the view is aligned at the end of the list.
     *
     * <p><strong>NOTE</strong>
     * <br>When the list hits the start, the items at the start must be completely displayed.
     * In this case, the items at the end may not be aligned.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    END = 3
}
/**
 * Defines the chain animation options.
 *
 * @interface ChainAnimationOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
export declare interface ChainAnimationOptions {
    /**
     * Minimum space for chain animation.
     *
     * @type { Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    minSpace: Length;
    /**
     * Maximum space for chain animation.
     *
     * @type { Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    maxSpace: Length;
    /**
     * Conductivity of chain animation.
     *
     * @type { ?number }
     * @default 0.7
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    conductivity?: number;
    /**
     * Intensity of chain animation.
     *
     * @type { ?number }
     * @default 0.3
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    intensity?: number;
    /**
     * Edge effect of chain animation.
     *
     * @type { ?ChainEdgeEffect }
     * @default ChainEdgeEffect.DEFAULT
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    edgeEffect?: ChainEdgeEffect;
    /**
     * Stiffness of chain spring.
     *
     * @type { ?number }
     * @default 228
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    stiffness?: number;
    /**
     * Damping of chain spring.
     *
     * @type { ?number }
     * @default 30
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    damping?: number;
}
/**
 * Defines the close swipe action options.
 *
 * @interface CloseSwipeActionOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CloseSwipeActionOptions {
    /**
     * Triggered after the collapse animation is complete.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onFinish?: () => void;
}
/**
 * Defines the visible list content info.
 *
 * @interface VisibleListContentInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface VisibleListContentInfo {
    /**
     * Index of the list item or list item group in the list display area.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    index: number;
    /**
     * Position of the top or bottom edge of the viewport in the
     * list item group to which the edge is located, if applicable.
     *
     * @type { ?ListItemGroupArea }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    itemGroupArea?: ListItemGroupArea;
    /**
     * Index of the starting or ending list item in the list
     * item group to which the top or bottom edge of the viewport is located.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    itemIndexInGroup?: number;
}
/**
 * Called when a child component enters or leaves the list display area.
 *
 * @typedef {function} OnScrollVisibleContentChangeCallback
 * @param {VisibleListContentInfo} start - Information about the currently displayed first list item or list item group.
 * @param {VisibleListContentInfo} end - Information about the currently displayed last list item or list item group.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnScrollVisibleContentChangeCallback = (start: VisibleListContentInfo, end: VisibleListContentInfo) => void;
/**
 * @extends Scroller
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class ListScroller extends Scroller {
    /**
     * Obtains the size of a list item in a list item group and its position relative to the list.
     *
     * <p><strong>NOTE</strong>:
     * <br>- The value of <em>index</em> must be the index of a child component visible in the display area.
     * Otherwise, the value is considered invalid.
     * <br>- The child component for which <em>index</em> is set must be a list item group. Otherwise,
     * the <em>index </em>value is considered invalid.
     * <br>- The value of <em>indexInGroup</em> must be the index of a list item in the list item group
     * visible in the display area. Otherwise, the value is considered invalid.
     * <br>- When <em>index</em> or <em>indexInGroup</em> is set to an invalid value, the returned size and position are both <em>0</em>.
     * </p>
     *
     * @param { number } index - Index of the list item group in the list.
     * @param { number } indexInGroup - Index of the list item in the list item group.
     * @returns { RectResult } - Size of the list item in the list item group and its position relative to the list.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 100004 - Controller not bound to component.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getItemRectInGroup(index: number, indexInGroup: number): RectResult;
    /**
     * Scrolls to the specified list item in the specified list item group.
     *
     * @param { number } index - Index of the target list item group in the current container.
     * <br><em>NOTE</em>
     * <br>If the value set is a negative value or greater than the maximum index of the items in the container,
     * the value is deemed abnormal, and no scrolling will be performed.
     * @param { number } indexInGroup - Index of the target list item in the list item group specified by <em>index</em>.
     * <br><em>NOTE</em>
     * <br>If the value set is a negative value or greater than the maximum index of the items in the list item group,
     * the value is deemed abnormal, and no scrolling will be performed.
     * @param { boolean } [smooth] - Whether to enable the smooth animation for scrolling to the item with the specified index.
     * The value <em>true</em> means to enable that the smooth animation, and <em>false</em> means the opposite.<br>Default value: <em>false</em>
     * @param { ScrollAlign } [align] - How the list item to scroll to is aligned with the container.<br>Default value: <em>ScrollAlign.START</em>
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 100004 - Controller not bound to component.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scrollToItemInGroup(index: number, indexInGroup: number, smooth?: boolean, align?: ScrollAlign): void;
    /**
     * Collapses the list items in the EXPANDED state and sets callback events.
     *
     * <p><strong>NOTE</strong>:
     * <br>- A <em>ListScroller</em> must be bound to the <em>List</em> component.
     * </p>
     *
     * @param { CloseSwipeActionOptions } options - Callback events for collapsing list items in the EXPANDED state.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 100004 - Controller not bound to component.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    closeAllSwipeActions(options?: CloseSwipeActionOptions): void;
    /**
     * Obtains the index information of the child component at the specified coordinates.
     *
     * <p><strong>NOTE</strong>:
     * <br>- If the provided value of <em>x</em> or <em>y</em> is invalid,
     * the returned VisibleListContentInfo object has the <em>index</em> property set to <em>-1</em>,
     * and both <em>itemGroupArea</em> and <em>itemIndexInGroup</em> are <em>undefined</em>.
     * </p>
     *
     * @param { number } x - X-coordinate, in vp.
     * @param { number } y - Y-coordinate, in vp.
     * @returns { VisibleListContentInfo } Index information of the child component at the specified coordinates.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @throws { BusinessError } 100004 - The controller not bound to component.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getVisibleListContentInfo(x: number, y: number): VisibleListContentInfo;
}
/**
 * Defines the options of the <em>List</em> component.
 *
 * <p><strong>NOTE</strong>:
 * <br>- The default value of the universal attribute clip is <em>true</em> for the <em>List</em> component.
 * </p>
 *
 * @interface ListOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface ListOptions {
    /**
     * Index of the item to be displayed at the start when the list is initially loaded.
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>
     * <br>If the set value is a negative number or is greater than the index of the last item in the list,
     * the value is invalid. In this case, the default value will be used.
     * </p>
     *
     * @type { ?number }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    initialIndex?: number;
    /**
     * Spacing between list items along the main axis.
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>
     * <br>If this parameter is set to a negative number or a value greater than or equal to the length of the list content area, the default value is used.
     * <br>If this parameter is set to a value less than the width of the list divider, the width of the list divider is used as the spacing.
     * <br> Child components of <em>List</em> whose <em>visibility</em> attribute is set to <em>None</em> are not displayed, but the spacing above and below them still takes effect.
     * </p>
     *
     * @type { ?(number | string) }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    space?: number | string;
    /**
     * Scroller, which can be bound to scrollable components.
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>
     * <br>The scroller cannot be bound to other scrollable components.
     * </p>
     *
     * @type { ?Scroller }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scroller?: Scroller;
}
/**
 * Defines the divider style of the list or list item group.
 *
 * @interface ListDividerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ListDividerOptions {
    /**
     * Width of the divider.
     * Anonymous Object Rectification.
     *
     * @type { Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    strokeWidth: Length;
    /**
     * Color of the divider.
     * Anonymous Object Rectification.
     *
     * @type { ?ResourceColor }
     * @default 0x08000000
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    color?: ResourceColor;
    /**
     * Distance between the divider and the start edge of the list.
     * Anonymous Object Rectification.
     *
     * @type { ?Length }
     * @default 0vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    startMargin?: Length;
    /**
     * Distance between the divider and the end edge of the list.
     * Anonymous Object Rectification.
     *
     * @type { ?Length }
     * @default 0vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    endMargin?: Length;
}
/**
 * The ListAttribute.
 * 
 * @extends ScrollableCommonMethod
 * @interface ListAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ListAttribute extends ScrollableCommonMethod {
    /**
     * Sets the number of columns or rows in the list. If the value is set to the gutter type, it indicates the gap between columns.
     * It takes effect when the number of columns is greater than 1.
     *
     * @param { number | LengthConstrain | undefined } value - Number of columns or rows in the list.<br>Default value: <em>1</em>
     * @param { Dimension | undefined } [gutter] - Gap between columns.<br>Default value: <em>0</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default lanes(value: number | LengthConstrain | undefined, gutter?: Dimension | undefined): this;
    /**
     * Alignment mode of list items along the cross axis when the cross-axis width of the list is greater
     * than the cross-axis width of list items multiplied by the value of lanes.
     *
     * @param { ListItemAlign | undefined } value - Alignment mode of list items along the cross axis.<br>Default value: <em>ListItemAlign.Start</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default alignListItem(value: ListItemAlign | undefined): this;
    /**
     * Sets the direction in which the list items are arranged.
     *
     * @param { Axis | undefined } value - Direction in which the list items are arranged.<br>Default value: <em>Axis.Vertical</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default listDirection(value: Axis | undefined): this;
    /**
     * Sets the offset from the start of the list content to the boundary of the list display area.
     * @param { number | undefined } value - Offset from the start of the list content to the boundary of the list display
     * <br>Default value: <em>0</em>
     * @returns { this } the attribute of the list.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default contentStartOffset(value: number | undefined): this;
    /**
     * Sets the offset from the end of the list content to the boundary of the list display area.
     *
     * @param { number | undefined } value - Offset from the end of the list content to the boundary of the list display area.
     * <br>Default value: <em>0</em>
     * @returns { this } the attribute of the list.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default contentEndOffset(value: number | undefined): this;
    /**
     * Sets the style of the divider for the list items. By default, there is no divider.
     * Anonymous Object Rectification.
     *
     * @param { ListDividerOptions | null | undefined } value - Style of the divider for the list items.<br>Default value: <em>null</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default divider(value: ListDividerOptions | null | undefined): this;
    /**
     * Sets whether to enable multiselect.
     *
     * @param { boolean | undefined } value - Whether to enable multiselect.
     * <br><em>false</em> (default): Multiselect is disabled.
     * <br><em>true</em>: Multiselect is enabled.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default multiSelectable(value: boolean | undefined): this;
    /**
     * Called when the minimum number of list item caches is set for long list deferred loading.
     *
     * @param { number | undefined } value - Number of list items to be preloaded.
     * <br>Default value: number of nodes visible on the screen, with the maximum value of 16
     * <br>Value range: [0, +∞)
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default cachedCount(value: number | undefined): this;
    /**
     * Sets the number of list items or list item groups to be cached (preloaded) and specifies whether to display the preloaded nodes.
     *
     * @param { number | undefined } count - Number of list items to be preloaded.
     * <br>Default value: number of nodes visible on the screen, with the maximum value of 16
     * <br>Value range: [0, +∞)
     * @param { boolean | undefined } show - Whether to display the preloaded list items.<br> Default value: <em>false</em>
     * @returns { this } the attribute of the list.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default cachedCount(count: number | undefined, show: boolean | undefined): this;
    /**
     * Sets whether to enable chained animations, which provide a visually connected,
     * or "chained," effect when the list is scrolled or its top or bottom edge is dragged.
     *
     * @param { boolean | undefined } value - Whether to enable chained animations.
     * <br><em>false</em> (default): Chained animations are disabled.
     * <br><em>true</em>: Chained animations are enabled.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default chainAnimation(value: boolean | undefined): this;
    /**
     * Called to setting chain linkage dynamic effect options.
     *
     * @param { ChainAnimationOptions | undefined } value - options of the chain animation.
     * @returns { this } the attribute of the list.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    default chainAnimationOptions(value: ChainAnimationOptions | undefined): this;
    /**
     * Sets whether to pin the header to the top or the footer to the bottom in the list item group,
     *
     * <p><strong>NOTE</strong>:
     * <br>- Occasionally, after <em>sticky</em> is set, floating-point calculation precision may result in small gaps appearing during scrolling.
     * To address this issue, you can apply the pixelRound attribute to the current component, which rounds down the pixel values and help eliminate the gaps.
     * </p>
     *
     * @param { StickyStyle | undefined } value - Whether to pin the header to the top or the footer to the bottom in the list item group.
     * <br> Default value: <em>StickyStyle.None</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default sticky(value: StickyStyle | undefined): this;
    /**
     * Sets the scroll snap alignment effect for list items.
     * This effect aligns list items to the nearest snap point when scrolling ends.
     *
     * @param { ScrollSnapAlign | undefined } value - Alignment mode of the scroll snap position.<br>Default value: <em>ScrollSnapAlign.NONE</em>
     * @returns { this } the attribute of the list.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default scrollSnapAlign(value: ScrollSnapAlign | undefined): this;
    /**
     * Sets the size information of the child components of a <em>List</em> component along the main axis.
     *
     * @param { ChildrenMainSize | undefined } value - children main size for List
     * @returns { this } the attribute of the list.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default childrenMainSize(value: ChildrenMainSize | undefined): this;
    /**
     * Sets whether the visible content position should remain unchanged when data is inserted or deleted above the visible area.
     *
     * <p><strong>NOTE</strong>:
     * <br>- The visible content position will only remain unchanged when <em>LazyForEach</em> is used to insert or delete data outside the visible area.
     * If <em>ForEach</em> is used to insert or delete data, or if <em>LazyForEach</em> is used for data reloading,
     * the visible content position will change even if <em>maintainVisibleContentPosition</em> is set to <em>true</em>.
     * <br>- When <em>maintainVisibleContentPosition</em> is set to <em>true</em>,
     * inserting or deleting data above the visible area will trigger <em>onDidScroll</em> and <em>onScrollIndex</em> events.
     * <br>- In a multi-column scenario, setting <em>maintainVisibleContentPosition</em> to <em>true</em> allows
     * you to insert or delete entire rows of data while keeping the visible content position unchanged.
     * If the insertion or deletion does not involve entire rows, however, the visible content position will still change.
     * </p>
     *
     * @param { boolean | undefined } enabled - Whether the visible content position should remain unchanged
     * when data is inserted or deleted above the visible area.<br>Default value: <em>false</em>
     * @returns { this } the attribute of the list.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maintainVisibleContentPosition(enabled: boolean | undefined): this;
    /**
     * Sets whether the list's layout starts from the bottom (end) rather than the top (beginning).
     *
     * <p><strong>NOTE</strong>:
     * <br>- When <em>stackFromEnd</em> is set to <em>true</em>, the following rules apply:
     * <br>If the content of the <em>List</em> component is shorter than the component height,
     * the content will be aligned to the bottom of the component.
     * <br>- If the height of a list item in the visible area changes, or if a new list item is inserted,
     * the list items above the changed or inserted item will move upwards to accommodate the new layout.
     * <br>- The default value of <em>initialIndex</em> becomes the total number of list items minus one.
     * </p>
     *
     * @param { boolean | undefined } enabled - Whether the list's layout starts from the bottom (end) rather than the top (beginning).
     * <br>Default value: <em>false</em>
     * @returns { this } the attribute of the list.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default stackFromEnd(enabled: boolean | undefined): this;
    /**
     * Triggered when a child component enters or leaves the list display area.
     *
     * @param { function | undefined } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onScrollIndex(event: ((start: number, end: number, center: number) => void) | undefined): this;
    /**
     * Triggered when a child component enters or leaves the list display area.
     *
     * @param { OnScrollVisibleContentChangeCallback | undefined } handler - Callback invoked when the displayed content changes.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onScrollVisibleContentChange(handler: OnScrollVisibleContentChangeCallback | undefined): this;
    /**
     * Triggered when a list item moves.
     *
     * @param { function } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onItemMove(event: ((from: number, to: number) => boolean) | undefined): this;
    /**
     * After a listener is bound, the component can be dragged. After the drag occurs, a callback is triggered.
     * (To be triggered, press and hold for 170 milliseconds (ms))
     *
     * @param { OnItemDragStartCallback | undefined } event - callback function, triggered when the item drag start.
     * @returns { this } Returns the instance of the ListAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onItemDragStart(event: OnItemDragStartCallback | undefined): this;
    /**
     * Triggered when the dragged item enters the drop target of the list.
     *
     * @param { function | undefined } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onItemDragEnter(event: ((event: ItemDragInfo) => void) | undefined): this;
    /**
     * Triggered when the dragged item moves over the drop target of the list.
     *
     * @param { function } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onItemDragMove(event: ((event: ItemDragInfo, itemIndex: number, insertIndex: number) => void) | undefined): this;
    /**
     * Triggered when the dragged item leaves the drop target of the list.
     *
     * @param { function | undefined } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onItemDragLeave(event: ((event: ItemDragInfo, itemIndex: number) => void) | undefined): this;
    /**
     * Triggered when the dragged item is dropped on the drop target of the list.
     *
     * @param { function | undefined } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onItemDrop(event: ((event: ItemDragInfo, itemIndex: number, insertIndex: number, isSuccess: boolean) => void) | undefined): this;
    /**
     * Called when scrolling begin each frame.
     * Anonymous Object Rectification.
     *
     * @param { OnScrollFrameBeginCallback | undefined } event - callback function, triggered when the scrolling begin each frame.
     * @returns { this } Returns the instance of the ListAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onScrollFrameBegin(event: OnScrollFrameBeginCallback | undefined): this;
    /**
    * Called when the scrollable will scroll.
    *
    * @param { OnWillScrollCallback | undefined } handler - callback of scrollable.
    * @returns { this }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    default onWillScroll(handler: OnWillScrollCallback | undefined): this;
    /**
     * Called when the scrollable did scroll.
     *
     * @param { OnScrollCallback | undefined } handler - callback of scrollable,
     * scrollOffset is offset this frame did scroll, scrollState is current scroll state.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onDidScroll(handler: OnScrollCallback | undefined): this;
    /**
     * Called attributeModifier.
     *
     * @param { AttributeModifier<ListAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<ListAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines List Component.
 *
 * @param { ListOptions } [options]
 * @param { function } [content_]
 * @returns { ListAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function List(
    options?: ListOptions, 
    @memo
    content_?: () => void,
): ListAttribute