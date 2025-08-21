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
import { ItemAlign } from './enums';
import { Length } from './units';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Defines the option in length unit of grid-row component.
 *
 * @interface GridRowSizeOption
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GridRowSizeOption {
    /**
     * Grid Row Size Option xs, select xs gutter size based on gridRow current breakpoint
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xs?: Length;
    /**
     * Grid Row Size Option sm, select sm gutter size based on gridRow current breakpoint
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    sm?: Length;
    /**
     * Grid Row Size Option md, select md gutter size based on gridRow current breakpoint
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    md?: Length;
    /**
     * Grid Row Size Option lg, select lg gutter size based on gridRow current breakpoint
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    lg?: Length;
    /**
     * Grid Row Size Option xl, select xl gutter size based on gridRow current breakpoint
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xl?: Length;
    /**
     * Grid Row Size Option xxl, select xxl gutter size based on gridRow current breakpoint
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xxl?: Length;
}
/**
 * Defines the option in number unit of grid-container component.
 *
 * @interface GridRowColumnOption
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GridRowColumnOption {
    /**
     * Grid Row Column Option xs, select xs column num based on gridRow current breakpoint
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xs?: number;
    /**
     * Grid Row Column Option sm, select sm column num based on gridRow current breakpoint
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    sm?: number;
    /**
     * Grid Row Column Option md
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    md?: number;
    /**
     * Grid Row Column Option lg, select lg column num based on gridRow current breakpoint
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    lg?: number;
    /**
     * Grid Row Column Option xl, select xl column num based on gridRow current breakpoint
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xl?: number;
    /**
     * Grid Row Column Option xxl, select xxl column num based on gridRow current breakpoint
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    xxl?: number;
}
/**
 * Defines the gutter of grid-row component.
 *
 * @interface GutterOption
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GutterOption {
    /**
     * Define x in GutterOption
     *
     * @type { ?(Length | GridRowSizeOption) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    x?: Length | GridRowSizeOption;
    /**
     * Define y in GutterOption
     *
     * @type { ?(Length | GridRowSizeOption) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    y?: Length | GridRowSizeOption;
}
/**
 * Defines the breakpoint reference of grid-container component.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum BreakpointsReference {
    /**
     * Respond to breakpoint changes according to window width
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    WindowSize,
    /**
     * Respond to breakpoint changes according to component width
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ComponentSize
}
/**
 * Defines the direction of grid-container component.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum GridRowDirection {
    /**
     * The elements in the grid component are arranged in rows
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Row,
    /**
     * The elements in the grid component are arranged in reverse order of rows
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RowReverse
}
/**
 * Defines the breakpoints of grid-row component.
 *
 * @interface BreakPoints
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface BreakPoints {
    /**
     * Breakpoint array
     *
     * @type { ?Array<string> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value?: Array<string>;
    /**
     * Set breakpoint reference
     *
     * @type { ?BreakpointsReference }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    reference?: BreakpointsReference;
}
/**
 * Defines the options of grid-row component.
 *
 * @interface GridRowOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GridRowOptions {
    /**
     * layout spacing between sub-components
     *
     * @type { ?(Length | GutterOption) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    gutter?: Length | GutterOption;
    /**
     * Sets the total number of columns in the current layout.
     *
     * @type { ?(number | GridRowColumnOption) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    columns?: number | GridRowColumnOption;
    /**
     * grid-row layout breakpoints.
     *
     * @type { ?BreakPoints }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    breakpoints?: BreakPoints;
    /**
     * grid-row layout direction.
     *
     * @type { ?GridRowDirection }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    direction?: GridRowDirection;
}
export declare interface GridRowAttribute extends CommonMethod {
    /**
     * Callback triggered when the breakpoint changes, breakpoints value can be xs, sm, md, lg, xl, xxl
     *
     * @param { function } callback
     * @returns { GridRowAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onBreakpointChange(callback: ((breakpoints: string) => void) | undefined): this;
    /**
     * Cross axis alignment of each line in GridRow.
     *
     * @param { ItemAlign } value - element alignment
     * @returns { GridRowAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default alignItems(value: ItemAlign | undefined): this;
    /**
     * Set the attribute modifier
     *
     * @param { AttributeModifier<GridRowAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { GridRowAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<GridRowAttribute> | AttributeModifier<CommonMethod>
        | undefined): this;
}

@memo
@ComponentBuilder
export declare function GridRow(
    option?: GridRowOptions, 
    @memo
    content_?: () => void,
): GridRowAttribute
