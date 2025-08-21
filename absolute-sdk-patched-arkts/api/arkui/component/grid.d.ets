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
import { EdgeEffectOptions, NestedScrollOptions, ItemDragInfo, ScrollableCommonMethod, CommonMethod, OnWillScrollCallback, OnScrollCallback, OnItemDragStartCallback } from './common';
import { Length, Resource } from './units';
import { Scroller, OnScrollFrameBeginCallback } from './scroll';
import { BarState, Color, EdgeEffect } from './enums';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * The options to help grid layout
 *
 * @interface GridLayoutOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GridLayoutOptions {
    /**
     * The size of most grid items, in [rows, columns], generally [1, 1]
     *
     * @type { [number, number] } regularSize
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    regularSize: [
        number,
        number
    ];
    /**
     * The indexes of grid items with irregular size.
     *
     * @type { ?number[] } irregularIndexes
     * @default number[] no irregular grid item
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    irregularIndexes?: number[];
    /**
     * Called to return the size of the irregular grid items with the specified index in [rows, columns].
     *
     * @type { ?function } onGetIrregularSizeByIndex,
     * all irregular grid items will occupy an entire line if not set
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onGetIrregularSizeByIndex?: (index: number) => [
        number,
        number
    ];
    /**
     * Called to return the size of the grid items with the specified index in
     * [rowStart, columnStart, rowSpan, columnSpan].
     *
     * @type { ?function } onGetRectByIndex
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onGetRectByIndex?: (index: number) => [
        number,
        number,
        number,
        number
    ];
}
/**
 * The enum of property layoutDirection
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum GridDirection {
    /**
     * The row direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Row,
    /**
     * The column direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Column,
    /**
     * The row reverse direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RowReverse,
    /**
     * The column reverse direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ColumnReverse
}
/**
 * Declare grid item alignment status
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum GridItemAlignment {
    /**
     * Use the default alignment of the Grid.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DEFAULT = 0,
    /**
     * The height of the tallest grid item in the current line
     * will be used as the height for the other items in the same line
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    STRETCH = 1
}
/**
 * The attribute of scrollbar to compute scrollbar position and height.
 *
 * @interface ComputedBarAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ComputedBarAttribute {
    /**
     * The offset of the grid.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    totalOffset: number;
    /**
     * The range of the grid.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    totalLength: number;
}

/**
 * The gridAttribute.
 * 
 * @extends ScrollableCommonMethod
 * @interface GridAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GridAttribute extends ScrollableCommonMethod {
    /**
     * This parameter specifies the number of columns in the current grid layout.
     *
     * @param { string | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default columnsTemplate(value: string | undefined): this;
    /**
     * Lets you set the number of rows in the current grid layout,
     *
     * @param { string | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default rowsTemplate(value: string | undefined): this;
    /**
     * Allows you to set the spacing between columns.
     *
     * @param { Length | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default columnsGap(value: Length | undefined): this;
    /**
     * Lets you set the spacing between rows.
     *
     * @param { Length | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default rowsGap(value: Length | undefined): this;
    /**
     * This parameter specifies the width of the scroll bar.
     *
     * @param { number | string | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default scrollBarWidth(value: number | string | undefined): this;
    /**
     * Sets the color of the scroll bar.
     *
     * @param { Color | number | string | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default scrollBarColor(value: Color | number | string | undefined): this;
    /**
     * Lets you set the spacing between rows.
     *
     * @param { BarState | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default scrollBar(value: BarState | undefined): this;
    /**
     * Set scrollbar position.
     *
     * @param { function | undefined } event - callback of grid scroll,
     *     index is the current first displayed item, offset is the grid offset,
     *     return ComputedBarAttribute to update scrollbar position and height.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default onScrollBarUpdate(event: ((index: number, offset: number) => ComputedBarAttribute) | undefined): this;
    /**
     * Called when the first or last item displayed in the grid changes.
     *
     * @param { function | undefined } event - of grid scroll,
     *     first is the index of the first item displayed in the grid,
     *     last is the index of the last item displayed in the grid.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default onScrollIndex(event: ((first: number, last: number) => void) | undefined): this;
    /**
     * cached Count
     *
     * @param { number | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default cachedCount(value: number | undefined): this;
    /**
     * Called to set number of GridItems to be preloaded (cached) in LazyForEach / Repeat.
     * @param { number | undefined } count - number of GridItems to be preloaded (cached).
     * @param { boolean | undefined } show - if true, cached items are displayed when clip is disabled.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default cachedCount(count: number | undefined, show: boolean | undefined): this;
    /**
     * editMode
     *
     * @param { boolean | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default editMode(value: boolean | undefined): this;
    /**
     * Called when judging whether it is multiSelectable.
     *
     * @param { boolean | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default multiSelectable(value: boolean | undefined): this;
    /**
     * maxCount
     *
     * @param { number | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default maxCount(value: number | undefined): this;
    /**
     * minCount
     *
     * @param { number | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default minCount(value: number | undefined): this;
    /**
     * cellLength
     *
     * @param { number | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default cellLength(value: number | undefined): this;
    /**
     * Control GridDirection of the grid.
     *
     * @param { GridDirection | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default layoutDirection(value: GridDirection | undefined): this;
    /**
     * Control if the grid supports animation.
     *
     * @param { boolean | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default supportAnimation(value: boolean | undefined): this;
    /**
    * After a listener is bound, the component can be dragged. After the drag occurs, a callback is triggered.
    * (To be triggered, press and hold for 170 milliseconds (ms))
    *
    * @param { OnItemDragStartCallback | undefined } event
    * @returns { this }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @atomicservice
    * @since 20
    */
    default onItemDragStart(event: OnItemDragStartCallback | undefined): this;
    /**
     * After binding, a callback is triggered when the component is dragged to the range of the component.
     *
     * @param { function | undefined } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default onItemDragEnter(event: ((event: ItemDragInfo) => void) | undefined): this;
    /**
     * After binding, a callback is triggered when the drag moves within the range of a placeable component.
     *
     * @param { function | undefined } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default onItemDragMove(event: ((event: ItemDragInfo, itemIndex: number, insertIndex: number) => void) | undefined): this;
    /**
     * After binding, a callback is triggered when the component is dragged out of the component range.
     *
     * @param { function | undefined } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default onItemDragLeave(event: ((event: ItemDragInfo, itemIndex: number) => void) | undefined): this;
    /**
     * The component bound to this event can be used as the drag release target.
     * This callback is triggered when the drag behavior is stopped within the scope of the component.
     *
     * @param { function | undefined } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default onItemDrop(event: ((event: ItemDragInfo, itemIndex: number, insertIndex: number, isSuccess: boolean) => void) | undefined): this;
    /**
     * Called when the sliding effect is set.
     *
     * @param { EdgeEffect | undefined } value
     * @param { EdgeEffectOptions } [options]
     * @returns { this } The attribute of the grid
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default edgeEffect(value: EdgeEffect | undefined, options?: EdgeEffectOptions): this;
    /**
     * Called to setting the nested scroll options.
     *
     * @param { NestedScrollOptions | undefined } value - options for nested scrolling.
     * @returns { this } the attribute of the grid.
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default nestedScroll(value: NestedScrollOptions | undefined): this;
    /**
     * Called when setting whether to enable scroll by gesture or mouse.
     *
     * @param { boolean | undefined } value
     * @returns { this } The attribute of the grid
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default enableScrollInteraction(value: boolean | undefined): this;
    /**
     * Called to setting the friction.
     *
     * @param { number | Resource | undefined } value - options for scrolling friction.
     * @returns { this } the attribute of the grid.
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default friction(value: number | Resource | undefined): this;
    /**
     * Set the alignment of grid items.
     *
     * @param { GridItemAlignment | undefined } alignment - Items alignment
     * @returns { this } The attribute of the grid.
     * @syscap SystemCapability.ArkUI.ArkUI.Full

     * @since 20
     */
    default alignItems(alignment: GridItemAlignment | undefined): this;
    /**
     * Called when scrolling begin each frame.
     * Anonymous Object Rectification.
     *
     * @param { OnScrollFrameBeginCallback | undefined } event - callback function,
     *     triggered when the scrolling begin each frame.
     * @returns { this } Returns the instance of the GridAttribute.
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
     * @atomicservice
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
     * @atomicservice
     * @since 20
     */
    default onDidScroll(handler: OnScrollCallback | undefined): this;
    /**
     * Call attributeModifier.
     *
     * @param { AttributeModifier<GridAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<GridAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Grid is returned when the parameter is transferred.
 *
 * @param { Scroller } [scroller] - Controller bound to the grid
 * @param { GridLayoutOptions } [layoutOptions] - The options to help grid layout
 * @param { function } [content_] - container
 * @returns { GridAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Grid(
    scroller?: Scroller, layoutOptions?: GridLayoutOptions, 
    @memo
    content_?: () => void,
): GridAttribute