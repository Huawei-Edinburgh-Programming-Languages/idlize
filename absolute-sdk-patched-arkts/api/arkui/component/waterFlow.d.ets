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
import { ScrollableCommonMethod, NestedScrollOptions, CommonMethod, Optional, OnWillScrollCallback, OnScrollCallback } from './common';
import { CustomBuilder } from './builder';
import { Length, Dimension, Margin, ConstraintSizeOptions, Resource } from './units';
import { Scroller, OnScrollFrameBeginCallback } from "./scroll";
import { ScrollState } from "./list";
import { FlexDirection } from './enums';
import { ComponentContent } from '../../arkui/ComponentContent';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * function that returns item main size by index.
 *
 * @typedef { function } GetItemMainSizeByIndex
 * @param { number } index - Index of the target water flow item.<br>Value range: [0, total number of child nodes - 1].
 * @returns { number } main size of the FlowItem at index
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type GetItemMainSizeByIndex = (index: number) => number;
/**
 * Describes the configuration of the water flow item section.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class SectionOptions {
    /**
     * The number of FlowItems in this section.
     *
     * @type { number } itemsCount - Number of water flow items in the section. The value must be a positive integer.
     * If the <em>splice</em>, <em>push</em>, or <em>update</em> APIs receive a section where the <em>itemsCount</em> value is less than 0, these APIs will not be executed.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    itemsCount: number;
    /**
     * The columns of this section in vertical layout, or rows in horizontal layout.
     *
     * @type { ?number } crossCount - Number of columns (in vertical layout) or rows (in horizontal layout).
     * <br> If the value is less than 1, the default value is used.
     * @default 1 one column in vertical layout, or one row in horizontal layout
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    crossCount?: number;
    /**
     * Callback used to obtain the main axis size,in vp, of the water flow item at a specified index during
     * the layout process of the WaterFlow component.
     *
     * <p><strong>NOTE</strong>
     * <br>1. When both <em>onGetItemMainSizeByIndex</em> and the width or height attribute of the water flow item are used,
     * the main axis size is determined by the return value of <em>onGetItemMainSizeByIndex</em>,
     * which will override the main axis length of water flow item.
     * <br>2. Using <em>onGetItemMainSizeByIndex</em> can improve the efficiency of jumping to a specific position or index in the <em>WaterFlow</em> component.
     * Avoid mixing the use of <em>onGetItemMainSizeByIndex</em> with sections that do not have it set, as this can cause layout exceptions.
     * <br>3. If <em>onGetItemMainSizeByIndex</em> returns a negative number, the height of the water flow item is 0.
     * </p>
     *
     * @type { ?GetItemMainSizeByIndex } onGetItemMainSizeByIndex - function that returns item main size by index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onGetItemMainSizeByIndex?: GetItemMainSizeByIndex;
    /**
     * Gap between columns. If this parameter is not set, the value of columnsGap for the water flow is used.
     * If this parameter is set to an invalid value, 0 vp is used.
     *
     * @type { ?Dimension } columnsGap - column gap of this section
     * same with columnsGap of WaterFlow if not set
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    columnsGap?: Dimension;
    /**
     * Gap between rows. If this parameter is not set, the value of <em>rowsGap</em> for the water flow is used.
     * If this parameter is set to an invalid value, 0 vp is used.
     *
     * @type { ?Dimension } rowsGap - row gap of this section
     * same with rowsGap of WaterFlow if not set
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    rowsGap?: Dimension;
    /**
     * Padding of the section. A value of the Length type specifies the margin for all the four sides.
     *
     * @type { ?(Margin | Dimension) } margin - outer margin of this section
     * @default {top: 0, right: 0, bottom: 0, left: 0}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    margin?: Margin | Dimension;
}
/**
 * Describes the water flow item sections.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare class WaterFlowSections {
    /**
     * A constructor used to create a <em>WaterFlowSections</em> object.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor();
    /**
     * Changes sections by removing or replacing an existing section and/or adding a section.
     *
     * @param { number } start - Zero-based index at which the changing starts. The value is converted to an integer.
     * <br><em>NOTE</em>
     * <br>1. A negative index counts back from the end of the section list. If -<em>WaterFlowSections.length()</em> <= <em>start</em> < <em>0</em>, <em>start</em> + <em>array.length</em> is used.
     * <br>2. If <em>start</em> < -<em>WaterFlowSections.length()</em>, <em>0</em> is used.
     * <br>3. If <em>start</em> >= <em>WaterFlowSections.length()</em>, a new section is added at the end.
     * @param { number } [deleteCount] - Number of sections to be deleted from the position specified by <em>start</em>.
     * <br><em>NOTE</em>
     * <br>1. If <em>deleteCount</em> is omitted, or if its value is greater than or equal to the number of sections from
     * the position specified by <em>start</em> to the end of the <em>WaterFlowSections</em>,
     * then all sections from the position specified by <em>start</em> to the end of the <em>WaterFlowSections</em> will be deleted.
     * <br>2. If <em>deleteCount</em> is <em>0</em> or a negative number, no sections are deleted.
     * @param { Array<SectionOptions> } [sections] - Sections to add to the section list, beginning from the position specified by <em>start</em>.
     * If no section is specified, <em>splice()</em> will only delete sections from the <em>WaterFlow</em> component.
     * @returns { boolean } Whether the splice was successful.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    splice(start: number, deleteCount?: number, sections?: Array<SectionOptions>): boolean;
    /**
     * Adds the specified sections to the end of the <em>WaterFlow</em> component.
     *
     * @param { SectionOptions } section - Sections to add to the end of the <em>WaterFlow</em> component.
     * @returns { boolean } Whether the push was successful.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    push(section: SectionOptions): boolean;
    /**
     * Updates the configuration of a specified water flow item section.
     *
     * @param { number } sectionIndex - Zero-based index of the water flow item section to update. The value is converted to an integer.
     * <br><em>NOTE</em>
     * <br>1. A negative index counts back from the end of the section list. If -<em>WaterFlowSections.length()</em> <= <em>sectionIndex</em> < <em>0</em>, <em>sectionIndex</em> + <em>array.length</em> is used.
     * <br>2. If <em>sectionIndex</em> < -<em>WaterFlowSections.length()</em>, <em>0</em> is used.<br>3. If <em>sectionIndex</em> >= <em>WaterFlowSections.length()</em>, a new section is added at the end.
     * @param { SectionOptions } section - New section configuration.
     * @returns { boolean } Whether the update was successful.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    update(sectionIndex: number, section: SectionOptions): boolean;
    /**
     * Obtains the configuration of all sections in the <em>WaterFlow</em> component.
     *
     * @returns { Array<SectionOptions> } Returns all the section options in the WaterFlow.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    values(): Array<SectionOptions>;
    /**
     * Obtains the number of sections in the <em>WaterFlow</em> component.
     *
     * @returns { number } Returns section counts in the WaterFlow.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    length(): number;
}
/**
 * Declare layout modes of WaterFlow.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum WaterFlowLayoutMode {
    /**
     * Default layout mode where water flow items are arranged from top to bottom. Items in the viewport depend on the layout of all items above them.
     * As such, in cases of redirection or switching the number of columns, the layout of all items above the viewport must be recalculated.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ALWAYS_TOP_DOWN = 0,
    /**
     * Sliding window mode. This mode only takes into account the layout in the viewport,
     * without depending on water flow items above the viewport.
     *
     * <p><strong>NOTE</strong>
     * <br> 1. During a non-animated redirection to a distant location, water flow items are laid out forward or backward based on the target position.
     * If the user then swipes back to the position prior to the redirection, the layout of the content may not be consistent with its previous state.
     * This can lead to misalignment of the top nodes when the user swipes back to the top after the redirection.
     * To counteract this issue, in this layout mode, the layout will be automatically adjusted after reaching the top of the viewport to ensure that the top is aligned.
     * If there are multiple sections, adjustments will be made to the sections within the viewport when scrolling ends.
     * <br> 2. The total offset returned by the currentOffset API of scroller is inaccurate after a redirection or data update. This offset will be recalibrated when the user swipes back to the top.
     * <br> 3. If a jump action (for example, by calling scrollToIndex without animation or scrollEdge) and
     * an input offset (such as from a swipe gesture or a scrolling animation) are both initiated within the same frame, both will be executed.
     * <br> 4. If the scrollToIndex API is called without animation to jump to a distant position (beyond the range of visible water flow items in the window),
     * the total offset is calculated in the sliding window mode.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SLIDING_WINDOW = 1
}
/**
 * Provides parameters of the <em>WaterFlow</em> component.
 *
 * @interface WaterFlowOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface WaterFlowOptions {
    /**
     * Footer of the WaterFlow component.
     *
     * @type { ?CustomBuilder }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    footer?: CustomBuilder;
    /**
     * Footer of the WaterFlow component.
     *
     * @type { ?ComponentContent }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    footerContent?: ComponentContent;
    /**
     * Controller of the scrollable component, bound to the scrollable component.
     *
     * <p><strong>NOTE</strong>
     * <br>The scroller cannot be bound to other scrollable components, such as ArcList, List, Grid, or Scroll.
     * </p>
     *
     * @type { ?Scroller }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scroller?: Scroller;
    /**
     * Water flow item sections. Different sections can have different numbers of columns.
     *
     * <p><strong>NOTE</strong>
     * <br>1. When <em>sections</em> is used, the <em>columnsTemplate</em> and <em>rowsTemplate</em> attributes are ignored.
     * <br>2. When <em>sections</em> is used, the footer cannot be set separately. The last section can function as the footer.
     * </p>
     *
     * @type { ?WaterFlowSections } sections - sections with different cross count
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    sections?: WaterFlowSections;
    /**
     * Layout mode of the <em>WaterFlow</em> component.
     *
     * @type { ?WaterFlowLayoutMode }
     * @default ALWAYS_TOP_DOWN
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    layoutMode?: WaterFlowLayoutMode;
}

/**
 * The WaterFlowAttribute.
 * 
 * @extends ScrollableCommonMethod
 * @interface WaterFlowAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface WaterFlowAttribute extends ScrollableCommonMethod {
    /**
     * Sets the number of columns in the layout. If this attribute is not set, one column is used by default.
     *
     * @param { string | undefined } value - Number of columns in the layout.<br>Default value: <em>'1fr'</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default columnsTemplate(value: string | undefined): this;
    /**
     * Sets the size constraints of the child components during layout.
     *
     * @param { ConstraintSizeOptions | undefined } value - Size constraints of the child components during layout.
     * If the value specified is less than 0, this parameter does not take effect.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default itemConstraintSize(value: ConstraintSizeOptions | undefined): this;
    /**
     * Sets the number of rows in the layout. If this attribute is not set, one row is used by default.
     *
     * @param { string | undefined } value - Number of rows in the layout.<br>Default value: <em>'1fr'</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default rowsTemplate(value: string | undefined): this;
    /**
     * Sets the gap between columns.
     *
     * @param { Length | undefined } value - Gap between columns.<br>Default value: <em>0</em>
     * <br>Value range: [0, +∞).
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default columnsGap(value: Length | undefined): this;
    /**
     * Sets the gap between rows.
     *
     * @param { Length | undefined } value - Gap between rows.<br>Default value: <em>0</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default rowsGap(value: Length | undefined): this;
    /**
     * Sets the main axis direction of the layout.
     *
     * @param { FlexDirection | undefined } value -  Main axis direction of the layout.<br>Default value: <em>FlexDirection.Column</em>
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default layoutDirection(value: FlexDirection | undefined): this;
    /**
     * Sets the number of items to be cached.
     *
     * @param { number | undefined } value - Number of water flow items to be preloaded (cached).
     * <br>Default value: number of nodes visible on the screen, with the maximum value of 16
     * <br>Value range: [0, +∞).
     * <br>Values less than 0 are treated as <em>1</em>.
     * @returns { this } the attribute of the water flow.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default cachedCount(value: number | undefined): this;
    /**
     * Sets the number of water flow items to be cached (preloaded) and specifies whether to display the cached nodes.
     *
     * @param { number | undefined } count - Number of water flow items to be preloaded (cached).
     * <br>Default value: number of nodes visible on the screen, with the maximum value of 16
     * <br>Value range: [0, +∞).
     * <br>Values less than 0 are treated as <em>1</em>.
     * @param { boolean | undefined } show - Whether to display the cached water flow items.
     * @returns { this } the attribute of the water flow.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default cachedCount(count: number | undefined, show: boolean | undefined): this;
    /**
     * Called when scrolling begin each frame.
     * Anonymous Object Rectification.
     *
     * @param { OnScrollFrameBeginCallback | undefined } event - callback function, triggered when the scrolling begin each frame.
     * @returns { this } the attribute of the water flow.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onScrollFrameBegin(event: OnScrollFrameBeginCallback | undefined): this;
    /**
     * Triggered when the first or last item displayed in the component changes.
     * It is triggered once when the component is initialized.
     *
     * @param { function | undefined } event - Callback function, triggered when the first or last item
     * displayed in the waterflow changes.
     * "first": the index of the first item displayed in the waterflow,
     * "last": the index of the last item displayed in the waterflow.
     * @returns { this } the attribute of the water flow.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onScrollIndex(event: ((first: number, last: number) => void) | undefined): this;
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
     * @param { AttributeModifier<WaterFlowAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<WaterFlowAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines WaterFlow Component.
 *
 * @param { WaterFlowOptions } [options] - options
 * @param { function } [content_] - container
 * @returns { WaterFlowAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function WaterFlow(
    options?: WaterFlowOptions, 
    @memo
    content_?: () => void,
): WaterFlowAttribute