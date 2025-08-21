/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
 */
import { ResourceColor, Length } from './units';
import { CommonMethod, ContentModifier, CommonConfiguration, MultiShadowOptions } from './common';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * DataPanelType enum
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum DataPanelType {
    /**
     * Line Type
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Line,
    /**
     * Line Rainbow
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Circle
}
/**
 * ColorStop type
 * @typedef { object } ColorStop
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ColorStop {
    /**
     * Color property.
     * @type { ResourceColor } color - the color value.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    color: ResourceColor;
    /**
     * Offset property.
     * @type { Length } offset - the color offset.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offset: Length;
}
/**
 * LinearGradient class
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class LinearGradient {
    /**
     * Constructor.
     *
     * @param { ColorStop[] } colorStops - the LinearGradient constructor parameter.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(colorStops: ColorStop[]);
}
/**
 * Defines the options of Shadow.
 *
 * @extends MultiShadowOptions
 * @interface DataPanelShadowOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface DataPanelShadowOptions extends MultiShadowOptions {
    /**
     * Current shadow colors.
     *
     * @type { ?Array<ResourceColor | LinearGradient> }
     * @default Consistent with valueColors
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    colors?: Array<ResourceColor | LinearGradient>;
}
/**
 * Defines the options of DataPanel.
 *
 * @interface DataPanelOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface DataPanelOptions {
    /**
     * Current data value. the max length is 9.
     *
     * @type { number[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    values: number[];
    /**
     * Maximum value of the current data.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    max?: number;
    /**
     * DataPanel Type
     *
     * @type { ?DataPanelType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type?: DataPanelType;
}
/**
 * DataPanelConfiguration used by dataPanel content modifier
 *
 * @extends CommonConfiguration<DataPanelConfiguration>
 * @interface DataPanelConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface DataPanelConfiguration extends CommonConfiguration<DataPanelConfiguration> {
    /**
     * Current data value. the max length is 9.
     *
     * @type { number[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    values: number[];
    /**
     * Maximum value of the current data.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    maxValue: number;
}
export declare interface DataPanelAttribute extends CommonMethod {
    /**
     * Disable the special effect of the data ratio chart.
     *
     * @param { boolean } value
     * @returns { DataPanelAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    closeEffect(value: boolean | undefined): this;
    /**
     * Set the value colors of the data ratio chart.
     *
     * @param { Array<ResourceColor | LinearGradient> } value - the value colors of the data ratio chart.
     * @returns { DataPanelAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    valueColors(value: Array<ResourceColor | LinearGradient> | undefined): this;
    /**
     * Set track background color of the data ratio chart.
     *
     * @param { ResourceColor } value - track background color of the data ratio chart.
     * @returns { DataPanelAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    trackBackgroundColor(value: ResourceColor | undefined): this;
    /**
     * Set the stroke width of the data ratio chart.
     *
     * @param { Length } value - the stroke width of the data ratio chart.
     * @returns { DataPanelAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    strokeWidth(value: Length | undefined): this;
    /**
     * Set the shadow width of the data ratio chart.
     *
     * @param { DataPanelShadowOptions } value - the track shadow width of the data ratio chart.
     * @returns { DataPanelAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    trackShadow(value: DataPanelShadowOptions | undefined): this;
    /**
     * Set the content modifier of data panel.
     *
     * @param { ContentModifier<DataPanelConfiguration> } modifier - The content modifier of data panel.
     * @returns { DataPanelAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    contentModifier(modifier: ContentModifier<DataPanelConfiguration> | undefined): this;
    attributeModifier(modifier: AttributeModifier<DataPanelAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Return a DataPanel.
 *
 * @param { DataPanelOptions } options
 * @returns { DataPanelAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function DataPanel(
    options: DataPanelOptions, 
    @memo
    content_?: () => void,
): DataPanelAttribute