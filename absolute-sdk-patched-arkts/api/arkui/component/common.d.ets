'use static'
/*
 * Copyright (c) 2021-2025 Huawei Device Co., Ltd.
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
 import { memo, ComponentBuilder, __memo_context_type, __memo_id_type } from "../stateManagement/runtime";
import OriginalContext from '../../application/Context';
import { Resource } from '../../global/resource';
import pointer from '../../@ohos.multimodalInput.pointer';
import image from '../../@ohos.multimedia.image';
import unifiedDataChannel from '../../@ohos.data.unifiedDataChannel';
import promptAction from '../../@ohos.promptAction';
import uniformTypeDescriptor from '../../@ohos.data.uniformTypeDescriptor';
import Want from '../../@ohos.app.ability.Want';
import { IntentionCode } from '../../@ohos.multimodalInput.intentionCode';
import { SymbolGlyphModifier } from '../../arkui/SymbolGlyphModifier';
import { CircleShape, EllipseShape, PathShape, RectShape } from '../../@ohos.arkui.shape';
import uiObserver from '@ohos.arkui.observer';
import { UIContext as _UIContext } from '../../@ohos.arkui.UIContext';
import { DrawContext as _DrawContext, LengthMetrics } from '../../arkui/Graphics';
import uiEffect from '../../@ohos.graphics.uiEffect';
import { FocusBoxStyle, FocusPriority } from "./focus";
import { ComponentContent } from '../../arkui/ComponentContent';
import { ResizableOptions } from "./image";
import intl from '../../@ohos.intl';
import { ButtonType, ButtonStyleMode, ButtonRole } from "./button";
import { Area, ResourceColor, Dimension, ResourceStr, Font, Length, EdgeColors, LocalizedEdgeColors, BorderRadiuses, EdgeWidths, LocalizedEdgeWidths, SizeOptions, Bias, EdgeStyles, Position, LocalizedBorderRadiuses, Margin, ChainWeightOptions, Padding, LocalizedPadding, LocalizedMargin, BorderOptions, OutlineOptions, EdgeOutlineStyles, EdgeOutlineWidths, OutlineRadiuses, Edges, LocalizedEdges, LocalizedPosition, AccessibilityOptions, ConstraintSizeOptions, EdgeWidth, DirectionalEdgesT, VoidCallback } from "./units";
import { BaseGestureEvent, GestureRecognizer, GestureJudgeResult, GestureType, GestureMask, GestureHandler, GesturePriority, GestureInfo } from "./gesture";
import { ScrollState } from "./list";
import { AccessibilityHoverType, Curve, PlayMode, SharedTransitionEffectType, KeySource, BorderStyle, HorizontalAlign, VerticalAlign, MouseButton, MouseAction, FontWeight, TouchType, FontStyle, Color, ColoringStrategy, Placement, ArrowPointPosition, ClickEffectLevel, NestedScrollMode, HitTestMode, Alignment, ImageRepeat, ImageSize, HoverEffect, Visibility, ItemAlign, Direction, Axis, GradientDirection, FunctionKey, ModifierKey, ObscuredReasons, RenderFit, LineCapStyle, LineJoinStyle, PixelRoundCalcPolicy, TextDecorationType, TextDecorationStyle, KeyType, ResponseType, BarState, EdgeEffect, ScrollSource, InteractionHand, AxisAction, AxisModel, CrownAction, FocusDrawLevel, CrownSensitivity, IlluminatedType } from "./enums";
import { TextRange } from "./textCommon";
import { StyledString } from "./styledString";
import { CustomBuilder, WrappedBuilder, CustomBuilderT } from './builder';
import curves from '../../@ohos.curves';
/**
 * Define the ratio of characters entered by the the percentage of InputCounterOptions.
 *
 * @interface InputCounterOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface InputCounterOptions {
    /**
     * It is the numerator bit of the percentage and used as a threshold. If the number of characters input
     * reaches the maximum number of characters multiplied by this threshold, the counter is displayed.
     *
     * <p><strong>NOTE</strong>:
     * <br>Threshold percentage for displaying the character counter.
     * <br>The character counter is displayed when the number of characters that have been entered is greater than
     * the maximum number of characters multiplied by the threshold percentage value.
     * <br>When displayed, the character counter is in the following format:
     * <br>Number of characters that have been entered/Maximum number of characters allowed.
     * <br>It is visible when the number of characters entered is greater than
     * the character limit multiplied by the threshold percentage value.
     * <br>Value range: [1, 100]
     * <br>If the value is not an integer, it is rounded down to the nearest integer.
     * <br>If the value exceeds the valid value range, the character counter is not displayed.
     * <br>If the value is <em>undefined</em>, the character counter is displayed, but this parameter has no effect.
     * </p>
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    thresholdPercentage?: number;
    /**
     * If the current input character count reaches the maximum character count and users want to exceed the
     * normal input, the border will turn red. If this parameter is true, the red border displayed.
     *
     * <p><strong>NOTE</strong>:
     * <br>Whether to highlight the text box border and character counter subscript in red.
     * <br>If options is not set, the text box border and character counter subscript turn red
     * <br>when the number of characters entered reaches the limit.
     * <br>If the character counter is displayed and thresholdPercentage is set to a valid value,
     * the text box border and character counter subscript turn red when the number of entered characters exceeds the limit.
     * <br>The value true (default) means to highlight the text box border and character counter subscript in red.
     * </p>
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    highlightBorder?: boolean;
}
/**
 * Defines the options of decoration.
 *
 * @interface TextDecorationOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface TextDecorationOptions {
    /**
     * The decoration type.
     *
     * @type { TextDecorationType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    type: TextDecorationType;
    /**
     * Sets the color of decoration.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    color?: ResourceColor;
    /**
     * The style value of decoration.
     *
     * @type { ?TextDecorationStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    style?: TextDecorationStyle;
}
/**
 * Provides an interface for the style of an divider including stroke width, color, start margin
 * and end margin
 *
 * @interface DividerStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface DividerStyle {
    /**
     * Define the stroke width of the divider
     *
     * @type { Length }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    strokeWidth: Length;
    /**
     * Define the color of the divider
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    color?: ResourceColor;
    /**
     * Define the start margin of the divider
     *
     * @type { ?Length }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    startMargin?: Length;
    /**
     * Define the end margin of the divider
     *
     * @type { ?Length }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    endMargin?: Length;
}
/**
 * The **AnimatableArithmetic** API defines the animation operation rules for
 * non-number data types. To animate non-number data (such as arrays, structs,
 * and colors), implement the addition, subtraction, multiplication, and
 * equality judgment functions in the **AnimatableArithmetic\<T\>** API.
 * In this way, the data can be involved in an interpolation operation of the
 * animation and identify whether the data changes, that is, the non-number data
 * is defined as the types that implement the **AnimatableArithmetic\<T\>** API.
 *
 * @interface AnimatableArithmetic
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface AnimatableArithmetic<T> {
    /**
     * Defines the addition rule of the data type.
     *
     * @param { AnimatableArithmetic<T> } rhs - another value
     * @returns { AnimatableArithmetic<T> } new value which implements AnimatableArithmetic<T> interface
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    plus(rhs: AnimatableArithmetic<T>): AnimatableArithmetic<T>;
    /**
     * Defines the subtraction rule of the data type.
     *
     * @param { AnimatableArithmetic<T> } rhs - another value
     * @returns { AnimatableArithmetic<T> } new value which implements AnimatableArithmetic<T> interface
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    subtract(rhs: AnimatableArithmetic<T>): AnimatableArithmetic<T>;
    /**
     * Defines the multiplication rule of the data type.
     *
     * @param { number } scale - scale value
     * @returns { AnimatableArithmetic<T> } new value which implements AnimatableArithmetic<T> interface
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    multiply(scale: number): AnimatableArithmetic<T>;
    /**
     * Defines the equality judgment rule of the data type.
     *
     * @param { AnimatableArithmetic<T> } rhs - another value
     * @returns { boolean } is equals
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    equals(rhs: AnimatableArithmetic<T>): boolean;
}
/**
  * ReuseId callback type. It is used to compute reuseId.
  *
  * @typedef { function } ReuseIdCallback
  * @returns { string }
  * @syscap SystemCapability.ArkUI.ArkUI.Full
  * @crossplatform
  * @atomicservice
  * @since 20
  */
export type ReuseIdCallback = () => string;
/**
 * Defining the reusable configuration parameters.
 *
 * @interface ReuseOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface ReuseOptions {
    /**
     * Defining reuseId function. The default reuseId is the custom component name.
     *
     * @type { ?ReuseIdCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    reuseId?: ReuseIdCallback;
}
/**
 * Export Context.
 *
 * @typedef { OriginalContext } Context
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @stagemodelonly
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type Context = OriginalContext;
/**
 * Post Card Action.
 *
 * @param { Object } component - indicate the card entry component.
 * @param { Object } action - indicate the router, message or call event.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @StageModelOnly
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare function postCardAction(component: Object, action: Object): void;
/**
 * Defines the data type of the interface restriction.
 *
 * @interface Configuration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface Configuration {
    /**
     * Set colorMode.
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    readonly colorMode: string;
    /**
     * Set fontScale.
     *
     * @type { number }
     * @readonly
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    readonly fontScale: number;
}
/**
 * Defines the data type of the interface restriction.
 *
 * @interface Rectangle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface Rectangle {
    /**
     * x:Horizontal coordinate
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    x?: Length;
    /**
     * y:Vertical axis coordinate.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    y?: Length;
    /**
     * Sets the width of the current touchRect.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    width?: Length;
    /**
     * Sets the height of the current touchRect.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    height?: Length;
}
/**
 * Interface for ExpectedFrameRateRange.
 *
 * @interface ExpectedFrameRateRange
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface ExpectedFrameRateRange {
    /**
     * The minimum animation drawing FPS.
     * The minimum value should be less than or equal to the maximum value.
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    min: number;
    /**
     * The maximum animation drawing FPS.
     * The maximum value should be greater than or equal to the minimum value.
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    max: number;
    /**
     * The expected frame rate of dynamical callback rate range.
     * The value should be between the minimum and maximum value.
     * Otherwise, the actual callback rate will be dynamically
     * adjusted to better align with other animation sources.
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    expected: number;
}
/**
 * global $r function
 *
 * @param { string } value
 * @param { (Object | null | undefined)[] } params
 * @returns { Resource }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare function $r(value: string, ...params: (Object | null | undefined)[]): Resource;
/**
 * global $rawfile function
 *
 * @param { string } value
 * name of the file in the resources/rawfile directory of the project.
 * When referencing resources of the Resource type, make sure the data type is the same as that of the attribute method.
 * For example, if an attribute method supports the string | Resource types, the data type of the Resource type must be
 * string.
 * @returns { Resource }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare function $rawfile(value: string): Resource;
/**
 * Defines the same page mode
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare enum AccessibilitySamePageMode {
    /**
    * the first page and root page event is not send.but if application load new page whith navigation,the page event will be sent.
    * this mode is to solve skipping focus
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SEMI_SILENT = 0,
    /**
     * the all page event is not send
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    FULL_SILENT = 1
}
/**
 * Enum for accessibility component type
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare enum AccessibilityRoleType {
    /**
    * ActionSheet component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    ACTION_SHEET = 0,
    /**
    * AlertDialog component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    ALERT_DIALOG = 1,
    /**
    * AlphabetIndexer component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    INDEXER_COMPONENT = 2,
    /**
    * badge component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    BADGE_COMPONENT = 3,
    /**
    * blank component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    BLANK = 4,
    /**
    * button component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    BUTTON = 5,
    /**
    * button component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    BACK_BUTTON = 6,
    /**
    * sheet drag bar component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SHEET_DRAG_BAR = 7,
    /**
    * calendar picker component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    CALENDAR_PICKER = 8,
    /**
    * calendar component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    CALENDAR = 9,
    /**
    * canvas component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    CANVAS = 10,
    /**
    * canvas gradient component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    CANVAS_GRADIENT = 11,
    /**
    * canvas pattern component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    CANVAS_PATTERN = 12,
    /**
    * checkbox component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    CHECKBOX = 13,
    /**
    * checkbox group component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    CHECKBOX_GROUP = 14,
    /**
    * circle component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    CIRCLE = 15,
    /**
    * column split component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    COLUMN_SPLIT = 16,
    /**
    * column component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    COLUMN = 17,
    /**
    * canvas rendering context 2d component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    CANVAS_RENDERING_CONTEXT_2D = 18,
    /**
    * chart component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    CHART = 19,
    /**
    * counter component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
     * @since 20
    */
    COUNTER = 20,
    /**
    * counter modal component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    CONTAINER_MODAL = 21,
    /**
    * data panel component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    DATA_PANEL = 22,
    /**
    * data picker component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    DATE_PICKER = 23,
    /**
    * dialog component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    DIALOG = 24,
    /**
    * divider component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    DIVIDER = 25,
    /**
    * drag bar component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    DRAG_BAR = 26,
    /**
    * effect component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    EFFECT_COMPONENT = 27,
    /**
    * ellipse component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    ELLIPSE = 28,
    /**
    * flex component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    FLEX = 29,
    /**
    * flow item component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    FLOW_ITEM = 30,
    /**
    * form component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    FORM_COMPONENT = 31,
    /**
    * form link component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    FORM_LINK = 32,
    /**
    * gauge component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    GAUGE = 33,
    /**
    * grid component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    GRID = 34,
    /**
    * grid col component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    GRID_COL = 35,
    /**
    * grid container component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    GRID_CONTAINER = 36,
    /**
    * grid item component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    GRID_ITEM = 37,
    /**
    * grid row component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    GRID_ROW = 38,
    /**
    * hyperlink component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    HYPERLINK = 39,
    /**
    * image component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    IMAGE = 40,
    /**
    * image animator component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    IMAGE_ANIMATOR = 41,
    /**
    * image bitmap component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    IMAGE_BITMAP = 42,
    /**
    * image data component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    IMAGE_DATA = 43,
    /**
    * image span component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    IMAGE_SPAN = 44,
    /**
    * label component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    LABEL = 45,
    /**
    * line component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    LINE = 46,
    /**
    * list component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    LIST = 47,
    /**
    * list item component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    LIST_ITEM = 48,
    /**
    * list item group component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    LIST_ITEM_GROUP = 49,
    /**
    * loading progress component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    LOADING_PROGRESS = 50,
    /**
    * marquee component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    MARQUEE = 51,
    /**
    * matrix2d component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    MATRIX2D = 52,
    /**
    * menu component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    MENU = 53,
    /**
    * menu item component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    MENU_ITEM = 54,
    /**
    * menu item group component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    MENU_ITEM_GROUP = 55,
    /**
    * navdestination component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    NAV_DESTINATION = 56,
    /**
    * navrouter component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    NAV_ROUTER = 57,
    /**
    * navigation component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    NAVIGATION = 58,
    /**
    * navigation bar component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    NAVIGATION_BAR = 59,
    /**
    * navigation menu component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    NAVIGATION_MENU = 60,
    /**
    * navigator component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    NAVIGATOR = 61,
    /**
    * offscreen canvas component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    OFFSCREEN_CANVAS = 62,
    /**
    * offscreen canvas rendering context2d component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    OFFSCREEN_CANVAS_RENDERING_CONTEXT2D = 63,
    /**
    * option component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    OPTION = 64,
    /**
    * panel component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    PANEL = 65,
    /**
    * paper page component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    PAPER_PAGE = 66,
    /**
    * path component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    PATH = 67,
    /**
    * path 2d component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    PATH2D = 68,
    /**
    * pattern lock component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    PATTERN_LOCK = 69,
    /**
    * picker component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    PICKER = 70,
    /**
    * picker view component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    PICKER_VIEW = 71,
    /**
    * plugin component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    PLUGIN_COMPONENT = 72,
    /**
    * polygon component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    POLYGON = 73,
    /**
    * polyline component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    POLYLINE = 74,
    /**
    * pop up component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    POPUP = 75,
    /**
    * progress component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    PROGRESS = 76,
    /**
    * qr code component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    QRCODE = 77,
    /**
    * radio component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    RADIO = 78,
    /**
    * rating component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    RATING = 79,
    /**
    * rect component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    RECT = 80,
    /**
    * refresh component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    REFRESH = 81,
    /**
    * relative container component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    RELATIVE_CONTAINER = 82,
    /**
    * remote window component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    REMOTE_WINDOW = 83,
    /**
    * rich editor component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    RICH_EDITOR = 84,
    /**
    * rich text component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    RICH_TEXT = 85,
    /**
    * rolepager component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    ROLE_PAGER = 86,
    /**
    * row component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    ROW = 87,
    /**
    * row split component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    ROW_SPLIT = 88,
    /**
    * scroll component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SCROLL = 89,
    /**
    * scroll bar component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SCROLL_BAR = 90,
    /**
    * search component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SEARCH = 91,
    /**
    * search field component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SEARCH_FIELD = 92,
    /**
    * select component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SELECT = 93,
    /**
    * shape component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SHAPE = 94,
    /**
    * sidebar container component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SIDEBAR_CONTAINER = 95,
    /**
    * slider component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SLIDER = 96,
    /**
    * span component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SPAN = 97,
    /**
    * stack component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    STACK = 98,
    /**
    * stepper component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    STEPPER = 99,
    /**
    * stepper item component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    STEPPER_ITEM = 100,
    /**
    * swiper component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SWIPER = 101,
    /**
    * swiper indicator component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SWIPER_INDICATOR = 102,
    /**
    * switch component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SWITCH = 103,
    /**
    * symbol glyph component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    SYMBOL_GLYPH = 104,
    /**
    * tab content component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TAB_CONTENT = 105,
    /**
    * tab bar component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TAB_BAR = 106,
    /**
    * tabs component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TABS = 107,
    /**
    * text component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TEXT = 108,
    /**
    * text clock component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TEXT_CLOCK = 109,
    /**
    * text entry component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TEXT_ENTRY = 110,
    /**
    * text input component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TEXT_INPUT = 111,
    /**
    * text picker component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TEXT_PICKER = 112,
    /**
    * text timer component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TEXT_TIMER = 113,
    /**
    * text area component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TEXT_AREA = 114,
    /**
    * text field component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TEXT_FIELD = 115,
    /**
    * time picker component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TIME_PICKER = 116,
    /**
    * title bar component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TITLE_BAR = 117,
    /**
    * toggler component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    TOGGLER = 118,
    /**
    * uiextensioncomponent component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    UI_EXTENSION_COMPONENT = 119,
    /**
    * video component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    VIDEO = 120,
    /**
    * water flow component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    WATER_FLOW = 121,
    /**
    * web component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    WEB = 122,
    /**
    * xcomponent component type
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    XCOMPONENT = 123,
    /**
    * none component type: screen reader will not broadcast the component type.
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    ROLE_NONE = 124
}
/**
 * Defines the callback type used in accessibility focus. The value of isFocus indicates whether the current component is focused
 * @typedef {function} AccessibilityFocusCallback
 * @param {boolean} isFocus - if component is focused,isFocus will be true. else isFocus is false.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export type AccessibilityFocusCallback = (isFocus: boolean) => void;
/**
 * Enum for FinishCallbackType.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare enum FinishCallbackType {
    /**
     * The callback is invoked when the entire animation is removed once it has finished.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    REMOVED = 0,
    /**
      * The callback is invoked when the animation logically enters the falling state,
      * though it may still be in its long tail state.
      *
      * @syscap SystemCapability.ArkUI.ArkUI.Full
      * @crossplatform
      * @form
      * @atomicservice
      * @since 20
      */
    LOGICALLY = 1
}
/**
 * Defines the touch test strategy object.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare enum TouchTestStrategy {
    /**
     * Custom dispatch has no effect; the system distributes events based on the hit status of the current node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    DEFAULT = 0,
    /**
     * The specified event is forwarded to a particular child node, and the system determines whether to
     * distribute the event to other sibling nodes.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    FORWARD_COMPETITION = 1,
    /**
     * The specified event is forwarded to a particular child node, and the system no longer distributes
     * the event to other sibling nodes.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    FORWARD = 2
}
/**
 * Defines the animate function params.
 *
 * @interface AnimateParam
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface AnimateParam {
    /**
     * Animation duration, in ms.
     *
     * @type { ?number }
     * @default 1000
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    duration?: number;
    /**
     * Animation playback speed. A larger value indicates faster animation playback, and a smaller value indicates slower
     * animation playback. The value 0 means that there is no animation.
     *
     * @type { ?number }
     * @default 1.0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    tempo?: number;
    /**
     * Animation curve.
     *
     * @type { ?(Curve | string | ICurve) }
     * @default Curve.EaseInOut
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    curve?: Curve | string | ICurve;
    /**
     * Animation delay time, in ms. By default, the animation has no delay.
     *
     * @type { ?number }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    delay?: number;
    /**
     * Number of times that the animation is played. By default, the animation is played once.
     * The value **-1** indicates that the animation is played for an unlimited number of times.
     * The value **0** indicates that there is no animation.
     *
     * @type { ?number }
     * @default 1
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    iterations?: number;
    /**
     * Playback mode. By default, the animation is played from the beginning after the playback is complete.
     *
     * @type { ?PlayMode }
     * @default PlayMode.Normal
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    playMode?: PlayMode;
    /**
     * Callback invoked when the animation playback is complete.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    onFinish?: () => void;
    /**
     * Type of the **onFinish** callback.
     * Default value: FinishCallbackType.REMOVED.
     *
     * @type { ?FinishCallbackType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    finishCallbackType?: FinishCallbackType;
    /**
     * Expected frame rate range of the animation.
     *
     * @type { ?ExpectedFrameRateRange }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    expectedFrameRateRange?: ExpectedFrameRateRange;
}
/**
 * Interface for curve object.
 *
 * @typedef { curves.ICurve } ICurve
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export type ICurve = curves.ICurve;
/**
 * Defines the motion path options.
 *
 * @interface MotionPathOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface MotionPathOptions {
    /**
     * Motion path of the translation animation.
     * The **svg** path string is used.
     * In the value, **start** and **end** can be used in place of the start point and end point,
     * for example, **'Mstart.x start.y L50 50 Lend.x end.y Z'**.
     * If this parameter is set to an empty string, the path animation is not set.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    path: string;
    /**
     * Start point of the motion path.
     * Value range: [0, 1].
     * A value less than 0 or greater than 1 evaluates to the default value **0**.
     *
     * @type { ?number }
     * @default 0.0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    from?: number;
    /**
     * End point of the motion path.
     * Value range: [0, 1].
     * A value less than 0 or greater than 1 evaluates to the default value **1**,
     * provided that the value of **to** is greater than or equal to the value of **from**.
     *
     * @type { ?number }
     * @default 1.0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    to?: number;
    /**
     * Whether to rotate along the path.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    rotatable?: boolean;
}
/**
 * Defines the shard transition function params.
 *
 * @interface sharedTransitionOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface sharedTransitionOptions {
    /**
     * Animation duration.
     * <br>Default value: **1000**.
     * <br>Unit: ms.
     * <br>Value range: [0, +∞).
     *
     * @type { ?number }
     * @default 1000
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    duration?: number;
    /**
     * Animation curve.<br>You are advised to specify the curve using the **Curve** or
     * ** ICurve** type.<br>For the string type, this parameter indicates an animation
     * interpolation curve. For available values, see the **curve** parameter in
     * AnimateParam.
     * <br>Default value: **Curve.Linear**.
     *
     * @type { ?(Curve | string | ICurve) }
     * @default 1000
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    curve?: Curve | string | ICurve;
    /**
     * Animation delay time, in ms.
     *
     * @type { ?number }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    delay?: number;
    /**
     * The motion path info.
     *
     * @type { ?MotionPathOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    motionPath?: MotionPathOptions;
    /**
     * Z index info.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    zIndex?: number;
    /**
     * the animate type.
     *
     * @type { ?SharedTransitionEffectType }
     * @default SharedTransitionEffectType.Exchange
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    type?: SharedTransitionEffectType;
}
/**
 * Defines the options of geometry transition.
 *
 * @interface GeometryTransitionOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface GeometryTransitionOptions {
    /**
     * whether follow target for the component still in the hierarchy, default: false, stay current.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    follow?: boolean;

    /**
     * Defines movement strategy of source and target in the hierarchy during geometry transition.
     * 
     * @type { ?TransitionHierarchyStrategy }
     * @default TransitionHierarchyStrategy.ADAPTIVE
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
  hierarchyStrategy?: TransitionHierarchyStrategy
}
/**
 * Defines the options of linear gradient.
 *
 * @interface LinearGradientOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface LinearGradientOptions {
    /**
     * Defines starting angle of linear gradient.
     *
     * Anonymous Object Rectification.
     * @type { ?(number | string) }
     * @default 180
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    angle?: number | string;
    /**
     * Defines the direction of linear gradient.
     *
     * Anonymous Object Rectification.
     * @type { ?GradientDirection }
     * @default GradientDirection.Bottom
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    direction?: GradientDirection;
    /**
     * Defines color description for gradients.
     *
     * Anonymous Object Rectification.
     * @type { Array<[ResourceColor, number]> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    colors: Array<[
        ResourceColor,
        number
    ]>;
    /**
     * Defines gradient colors with repeated coloring.
     *
     * Anonymous Object Rectification.
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    repeating?: boolean;
}

/**
 * Source and target are two matched elements during the geometry transition.
 * The animation starts at the source and ends at the target.
 * TransitionHierarchyStrategy enumeration defines how levels of source and target elements
 * would be changed in the hierarchy during the geometry transition.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
declare enum TransitionHierarchyStrategy {

  /**
   * None mode.
   * Source and target staty in the original level in the hierarchy during geometry transition.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  NONE = 0,

  /**
   * ADAPTIVE mode.
   * Lower level one of source and target is elevated to higher level of both,
   * indicating that two elements are in same high level.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  ADAPTIVE = 1,
}

/**
 * Defines the options of radial gradient.
 *
 * @interface SweepGradientOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface SweepGradientOptions {
    /**
     * Defines center point for angle gradient.
     *
     * Anonymous Object Rectification.
     * @type { [Length, Length] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    center: [
        Length,
        Length
    ];
    /**
     * Defines the starting point of angle gradient.
     *
     * Anonymous Object Rectification.
     * @type { ?(number | string) }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    start?: number | string;
    /**
     * Defines end point of angle gradient.
     *
     * Anonymous Object Rectification.
     * @type { ?(number | string) }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    end?: number | string;
    /**
     * Defines the rotation angle of the gradient.
     *
     * Anonymous Object Rectification.
     * @type { ?(number | string) }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    rotation?: number | string;
    /**
     * Defines color description for gradients.
     *
     * Anonymous Object Rectification.
     * @type { Array<[ResourceColor, number]> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    colors: Array<[
        ResourceColor,
        number
    ]>;
    /**
     * Defines gradient colors with repeated coloring.
     *
     * Anonymous Object Rectification.
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    repeating?: boolean;
}
/**
 * Defines the options of radial gradient.
 *
 * @interface RadialGradientOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface RadialGradientOptions {
    /**
     * Defines center point for radial gradient.
     *
     * Anonymous Object Rectification.
     * @type { [Length, Length] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    center: [
        Length,
        Length
    ];
    /**
     * Defines radius of the radial gradient.
     *
     * Anonymous Object Rectification.
     * @type { Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    radius: Length;
    /**
     * Defines color description for gradients.
     *
     * Anonymous Object Rectification.
     * @type { Array<[ResourceColor, number]> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    colors: Array<[
        ResourceColor,
        number
    ]>;
    /**
     * Defines gradient colors with repeated coloring.
     *
     * Anonymous Object Rectification.
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    repeating?: boolean;
}
/**
 * Defines the options of translate.
 *
 * @interface TranslateOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface TranslateOptions {
    /**
     * Translation distance along the x-axis.
     * For the number type, the unit is VP, and the value range is (-∞, +∞).
     * For the string type, the value follows the format of length string type.
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    x?: number | string;
    /**
     * Translation distance along the y-axis.
     * For the number type, the unit is VP, and the value range is (-∞, +∞).
     * For the string type, the value follows the format of length string type.
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    y?: number | string;
    /**
     * Distance to translate along the z-axis. The value is a floating
     * point number, the default value is 0.0, and the unit is px.
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    z?: number | string;
}
/**
 * Defines the options of scale.
 *
 * @interface ScaleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface ScaleOptions {
    /**
     * Scale ratio along the x-axis.
     * x > 1: The component is scaled up along the x-axis.
     * 0 < x < 1: The component is scaled down along the x-axis.
     * x < 0: The component is scaled in the reverse direction of the x-axis.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    x?: number;
    /**
     * Scale ratio along the y-axis.
     * y > 1: The component is scaled up along the y-axis.
     * 0 < y < 1: The component is scaled down along the y-axis.
     * y < 0: The component is scaled in the reverse direction of the y-axis.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    y?: number;
    /**
     * Scale ratio along the z-axis. z > 1: The component is scaled up along the z-axis.
     * <br>0 < z < 1: The component is scaled down along the z-axis.
     * <br>z < 0: The component is scaled in the reverse direction of the z-axis.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    z?: number;
    /**
     * X coordinate of the transformation center point (anchor). Unit is vp.
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    centerX?: number | string;
    /**
     * Y coordinate of the transformation center point (anchor). Unit is vp.
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    centerY?: number | string;
}
/**
 * Defines the align rule options of relative container.
 *
 * @interface VerticalAlignParam
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface VerticalAlignParam {
    /**
     * Specifies the anchor component
     *
     * Anonymous Object Rectification
     * @type { ?string } anchor
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    anchor: string;
    /**
     * Sets the vertical alignment relative to the anchor component.
     *
     * Anonymous Object Rectification
     * @type { ?VerticalAlign }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    align: VerticalAlign;
}
/**
 * Defines the horizontal align rule options of relative container.
 *
 * @interface HorizontalAlignParam
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface HorizontalAlignParam {

    /**
     * Specifies the anchor component
     *
     * Anonymous Object Rectification
     * @type { ?string } anchor
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    anchor: string;
    /**
     * Sets the horizontal alignment relative to the anchor component.
     *
     * Anonymous Object Rectification
     * @type { ?HorizontalAlign } align
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    align: HorizontalAlign;
}
/**
 * Defines the align rule options of relative container.
 *
 * @interface AlignRuleOption
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface AlignRuleOption {
    /**
     * The param of left align.
     *
     * @type { ?HorizontalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    left?: HorizontalAlignParam;
    /**
     * The param of right align.
     *
     * @type { ?HorizontalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    right?: HorizontalAlignParam;
    /**
     * The param of middle align.
     *
     * @type { ?HorizontalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    middle?: HorizontalAlignParam;
    /**
     * The param of top align.
     *
     * @type { ?VerticalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    top?: VerticalAlignParam;
    /**
     * The param of bottom align.
     *
     * @type { ?VerticalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @form
     * @atomicservice
     * @since 20
     */
    bottom?: VerticalAlignParam;
    /**
     * The param of center align.
     *
     * @type { ?VerticalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    center?: VerticalAlignParam;
    /**
     * Defines the bias ratio in horizontal and vertical direction.
     *
     * @type { ?Bias }
     * @default {horizontal:0.5,vertical:0.5}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    bias?: Bias;
}
/**
 * Defines the localized horizontal align param of relative container.
 *
 * @interface LocalizedHorizontalAlignParam
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface LocalizedHorizontalAlignParam {
    /**
     * ID of the component that serves as the anchor.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    anchor: string;
    /**
     * Horizontal alignment mode relative to the anchor component.
     *
     * @type { HorizontalAlign }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    align: HorizontalAlign;
}
/**
 * Defines the localized vertical align param of relative container.
 *
 * @interface LocalizedVerticalAlignParam
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface LocalizedVerticalAlignParam {
    /**
     * ID of the component that serves as the anchor.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    anchor: string;
    /**
     * Vertical alignment mode relative to the anchor component.
     *
     * @type { VerticalAlign }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    align: VerticalAlign;
}
/**
 * Defines the Localized align rule options of relative container.
 *
 * @interface LocalizedAlignRuleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface LocalizedAlignRuleOptions {
    /**
     * Left alignment with left-to-right scripts and right alignment with right-to-left scripts in the horizontal direction.
     *
     * @type { ?LocalizedHorizontalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    start?: LocalizedHorizontalAlignParam;
    /**
     * Right alignment with left-to-right scripts and left alignment with right-to-left scripts in the horizontal direction.
     *
     * @type { ?LocalizedHorizontalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    end?: LocalizedHorizontalAlignParam;
    /**
     * Center alignment in the horizontal direction.
     *
     * @type { ?LocalizedHorizontalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    middle?: LocalizedHorizontalAlignParam;
    /**
     * Top alignment in the vertical direction.
     *
     * @type { ?LocalizedVerticalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    top?: LocalizedVerticalAlignParam;
    /**
     * Bottom alignment in the vertical direction.
     *
     * @type { ?LocalizedVerticalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    bottom?: LocalizedVerticalAlignParam;
    /**
     * Center alignment in the vertical direction.
     *
     * @type { ?LocalizedVerticalAlignParam }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    center?: LocalizedVerticalAlignParam;
    /**
     * Offset of the component under the anchor constraints.
     * <br>The value is the ratio of the distance to the left/upper anchor to the total distance between anchors.
     *
     * @type { ?Bias }
     * @default {horizontal:0.5,vertical:0.5}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    bias?: Bias;
}
/**
 * Enumerates the chain styles in relative container.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum ChainStyle {
    /**
     * Child components are evenly distributed among constraint anchors.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    SPREAD,
    /**
     * All child components except the first and last ones are evenly distributed among constraint anchors.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    SPREAD_INSIDE,
    /**
     * There is no gap between child components in the chain.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    PACKED
}
/**
 * The param of rotate.
 *
 * @interface RotateOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface RotateOptions {
    /**
     * X coordinate of the rotation axis vector.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    x?: number;
    /**
     * Y coordinate of the rotation axis vector.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    y?: number;
    /**
     * Z coordinate of the rotation axis vector.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    z?: number;
    /**
     * X coordinate of the transformation center point (anchor). Unit is vp.
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    centerX?: number | string;
    /**
     * Y coordinate of the transformation center point (anchor). Unit is vp.
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    centerY?: number | string;
    /**
     * Z-axis anchor, that is, the z-component of the 3D rotation center point.
     *
     * @type { ?number }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    centerZ?: number;
    /**
     * Distance from the user to the z=0 plane.
     * The axis and center of rotation are set based on the coordinate system,
     * which remains where it is when the component is moved.
     *
     * @type { ?number }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    perspective?: number;
    /**
     * The param of angle.
     *
     * @type { number | string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    angle: number | string;
}
/**
 * Defines the Edge object.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare enum TransitionEdge {
    /**
     * Top edge
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    TOP,
    /**
     * Bottom edge of the window.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    BOTTOM,
    /**
     * Start edge of the window, which is the left edge for left-to-right
     * scripts and the right edge for right-to-left scripts.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    START,
    /**
     * End edge of the window, which is the right edge for left-to-right scripts
     * and the left edge for right-to-left scripts.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    END
}
/**
 * Defines the option of asymmetric transition.
 *
 * @interface AsymmetricTransitionOption
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface AsymmetricTransitionOption {
    /**
     * TransitionEffect used for appearing
     *
     * @type { TransitionEffect }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    appear: TransitionEffect;
    /**
     * TransitionEffect used for disappearing
     *
     * @type { TransitionEffect }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    disappear: TransitionEffect;
}
/**
 * Defined the draw modifier of node. Provides draw callbacks for the associated Node.
 * Each DrawModifier instance can be set for only one component. Repeated setting is not allowed.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare class DrawModifier {
    /**
     * drawBehind Method. Executed before drawing associated Node.
     *
     * @param { DrawContext } drawContext - The drawContext used to draw.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    drawBehind(drawContext: DrawContext): void;
    /**
     * drawContent Method. Executed when associated Node is drawing, the default drawContent method will be replaced
     * if this method is set.
     *
     * @param { DrawContext } drawContext - The drawContext used to draw.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    drawContent(drawContext: DrawContext): void;
    /**
     * Invalidate the component, which will cause a re-render of the component.
     * No overloading is allowed or needed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    invalidate(): void;
}
/**
 * Defines the transition effect
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare class TransitionEffect {
    /**
     * Disables the transition effect
     *
     * @type { TransitionEffect }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    static get IDENTITY(): TransitionEffect;
    /**
     * Specifies a transition effect with transparency of 0, which is equivalent to TransitionEffect.opacity(0).
     *
     * @type { TransitionEffect }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    static get OPACITY(): TransitionEffect;
    /**
     * Defines a slide transition effect
     *
     * @type { TransitionEffect }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    static get SLIDE(): TransitionEffect;
    /**
     * Specify a transition effect where the element enters by shrinking first and then expanding as it slides in from the right,
     * and exits by shrinking first and then expanding as it slides out to the left, with a minimum scale ratio of 0.8.
     * It comes with default animation parameters, which can also be overridden.
     * The default animation duration is set to 600ms, and the specified animation curve is cubicBezierCurve(0.24, 0.0, 0.50, 1.0).
     *
     * @type { TransitionEffect }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    static get SLIDE_SWITCH(): TransitionEffect;
    /**
     * Creates a translate transition effect
     *
     * @param { TranslateOptions } options - translate options
     * @returns { TransitionEffect }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    static translate(options: TranslateOptions): TransitionEffect;
    /**
     * Creates a rotation transition effect
     *
     * @param { RotateOptions } options - rotate options
     * Set the rotation effect for component transitions when inserting and deleting.
     * The value represents the starting rotation point for the inserting animation and the ending rotation point for the deleting animation.
     * -x: Horizontal component of the rotational vector.
     * -y: Vertical component of the rotational vector.
     * -z: Vertical component of the rotational vector.
     * -centerX, centerY specify the rotation center point, with default values of "50%",
     * meaning that the default rotation center point is the center point of the component.
     * -The center point of (0, 0) represents the upper-left corner of the component.
     * -centerZ refers to the Z-axis anchor point. The default value of centerZ is 0.
     * -perspective indicates the visual distance. The perspective property does not support transition animation.
     * @returns { TransitionEffect }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    static rotate(options: RotateOptions): TransitionEffect;
    /**
     * Creates a scale transition effect
     *
     * @param { ScaleOptions } options - scale options
     * @returns { TransitionEffect }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    static scale(options: ScaleOptions): TransitionEffect;
    /**
     * Creates an opacity transition effect with alpha value
     *
     * @param { number } alpha - opacity alpha value, value range [0, 1].
     * Illegal values less than 0 are treated as 0, and illegal values greater than 1 are treated as 1.
     * @returns { TransitionEffect }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    static opacity(alpha: number): TransitionEffect;
    /**
     * Creates a move transition effect
     *
     * @param { TransitionEdge } edge - the edge that component will move to
     * @returns { TransitionEffect }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    static move(edge: TransitionEdge): TransitionEffect;
    /**
     * Creates an asymmetric transition effect
     *
     * @param { TransitionEffect } appear - the transition which will be attached when the component is appear
     * @param { TransitionEffect } disappear - the transition which will be attached when the component is disappear
     * @returns { TransitionEffect }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    static asymmetric(appear: TransitionEffect, disappear: TransitionEffect): TransitionEffect;
    /**
     * identity or slideSwitch TransitionEffect constructor
     *
     * @param { 'identity' | 'slideSwitch' } type - transition type
     * @param { undefined } effect - transition options
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    constructor(type: 'identity' | 'slideSwitch', effect: undefined);
    /**
     * opacity TransitionEffect constructor
     *
     * @param { 'opacity' } type - transition type
     * @param { number } effect - transition options
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    constructor(type: 'opacity', effect: number);
    /**
     * move TransitionEffect constructor
     *
     * @param { 'move' } type - transition type
     * @param { TransitionEdge } effect - transition options
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    constructor(type: 'move', effect: TransitionEdge);
    /**
     * translate TransitionEffect constructor
     *
     * @param { 'translate' } type - transition type
     * @param { TranslateOptions } effect - transition options
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    constructor(type: 'translate', effect: TranslateOptions);
    /**
     * rotate TransitionEffect constructor
     *
     * @param { 'rotate' } type - transition type
     * @param { RotateOptions } effect - transition options
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    constructor(type: 'rotate', effect: RotateOptions);
    /**
     * scale TransitionEffect constructor
     *
     * @param { 'scale' } type - transition type
     * @param { ScaleOptions } effect - transition options
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    constructor(type: 'scale', effect: ScaleOptions);
    /**
     * asymmetric TransitionEffect constructor
     *
     * @param { 'asymmetric' } type - transition type
     * @param { AsymmetricTransitionOption } effect - transition options
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    constructor(type: 'asymmetric', effect: AsymmetricTransitionOption);
    /**
     * Set the animation of current transition effect
     *
     * @param { AnimateParam } value - animation parameters
     * @returns { TransitionEffect }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    animation(value: AnimateParam): TransitionEffect;
    /**
     * Combines another transition effect
     *
     * @param { TransitionEffect } transitionEffect - transition effect which is be combined
     * @returns { TransitionEffect } combined transition effect
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    combine(transitionEffect: TransitionEffect): TransitionEffect;
}
/**
 * ItemDragInfo object description
 *
 * @interface ItemDragInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface ItemDragInfo {
    /**
     * Obtains the X coordinate of the drag window, in vp.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    x: number;
    /**
     * Obtains the Y coordinate of the drag window, in vp.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    y: number;
}
/**
 * Enum of using the effects template mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare enum EffectType {
    /**
     * Define use the effects template defined by the parent effectComponent.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    DEFAULT = 0,
    /**
     * Define use the effects template defined by the window.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    WINDOW_EFFECT = 1
}
/**
 * Defines the drag status before drag action.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare enum PreDragStatus {
    /**
     * Define the status for user prepare to start long press gesture.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    ACTION_DETECTING_STATUS = 0,
    /**
     * Define the status for user can start drag action.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    READY_TO_TRIGGER_DRAG_ACTION = 1,
    /**
     * Define the status for dragItem lift animation started.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    PREVIEW_LIFT_STARTED = 2,
    /**
     * Define the status for dragItem lift animation finished.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    PREVIEW_LIFT_FINISHED = 3,
    /**
     * Define the status for dragItem landing animation started.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    PREVIEW_LANDING_STARTED = 4,
    /**
     * Define the status for dragItem landing animation finished.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    PREVIEW_LANDING_FINISHED = 5,
    /**
     * Define the status for user cancel drag action.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    ACTION_CANCELED_BEFORE_DRAG = 6,
    /**
     * Define the status for user to sense the availability of drag in advance.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    PREPARING_FOR_DRAG_DETECTION = 7
}
/**
 * DragItemInfo object description
 *
 * @interface DragItemInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface DragItemInfo {
    /**
     * Uses the pixelMap object for drawing.
     *
     * @type { ?PixelMap }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    pixelMap?: PixelMap;
    /**
     * Uses the custom builder for drawing, if pixelMap is set, this value is ignored.
     *
     * @type { ?CustomBuilder }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    builder?: CustomBuilder;
    /**
     * Sets the extra info for drag event.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    extraInfo?: string;
}
/**
 * Defining animation function.
 *
 * @param { AnimateParam } value
 * @param { function } event
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 * @deprecated since 18
 * @useinstead ohos.arkui.UIContext.UIContext#animateTo
 */
export declare function animateTo(value: AnimateParam, event: () => void): void;
/**
 * Implements immediate delivery of an explicit animation through a **UIContext** object.
 * When multiple property animations are loaded at once, you can call this API to immediately
 * execute the transition animation for state changes caused by the specified closure function.
 *
 * @param { AnimateParam } value - Set animation effect parameters.
 * @param { function } event - Specify the closure function that displays dynamic effects,
 * and the system will automatically insert transition animations for state changes caused by the closure function.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare function animateToImmediately(value: AnimateParam, event: () => void): void;
/**
 * Converts a value in vp units to a value in px.
 * By default, the virtual pixel ratio of the screen where the current UI instance is located is used for conversion.
 * If no UI instance is available, the virtual pixel ratio of the default screen is used instead.
 *
 * @param { number } value
 * Value range of value: (-∞, +∞).
 * @returns { number }
 * Value range of the return value: (-∞, +∞).
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 * @deprecated since 18
 * @useinstead ohos.arkui.UIContext.UIContext#vp2px
 */
export declare function vp2px(value: number): number;
/**
 * Converts a number in units of px to a number in units of vp.
 * By default, the virtual pixel ratio of the screen where the current UI instance is located is used for conversion.
 * If no UI instance is available, the virtual pixel ratio of the default screen is used instead.
 *
 * @param { number } value
 * Value range of value: (-∞, +∞).
 * @returns { number }
 * Value range of the return value: (-∞, +∞).
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 * @deprecated since 18
 * @useinstead ohos.arkui.UIContext.UIContext#px2vp
 */
export declare function px2vp(value: number): number;
/**
 * Defines the namespace of focus controller.
 *
 * @namespace focusControl
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare namespace focusControl {
    /**
     * Request focus to the specific component by param: 'id/key'.
     *
     * @param { string } value
     * @returns { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    function requestFocus(value: string): boolean;
}
/**
 * Import the PointerStyle type object for setCursor.
 *
 * @typedef { pointer.PointerStyle } PointerStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export type PointerStyle = pointer.PointerStyle;
/**
 * CursorControl
 *
 * @namespace cursorControl
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare namespace cursorControl {
    /**
     * Change the mouse cursor style by param: 'PointerStyle'.
     *
     * @param { PointerStyle } value - Cursor style.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    function setCursor(value: PointerStyle): void;
    /**
     * Restore the default mouse cursor style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    function restoreDefault(): void;
}
/**
 * Defines the event target.
 *
 * @interface EventTarget
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface EventTarget {
    /**
     * Area information of the target element.
     *
     * @type { Area }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    area: Area;
    /**
     * Node id of current target.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    id?: string;
}
/**
 * Defines the event source type.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum SourceType {
    /**
     * Unknown device type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    Unknown,
    /**
     * The mouse type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    Mouse,
    /**
     * The touch screen type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    TouchScreen
}
/**
 * Defines the event tool type.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum SourceTool {
    /**
     * Unknown input source.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    Unknown,
    /**
     * The finger type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    Finger,
    /**
     * The pen type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    Pen,
    /**
     * The mouse type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    MOUSE,
    /**
     * The touchpad type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    TOUCHPAD,
    /**
     * The joystick type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    JOYSTICK
}
/**
 * Defines the Border Image Repeat Mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare enum RepeatMode {
    /**
     * The source image's slices are tiled. Tiles beyond the border box will be clipped.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    Repeat,
    /**
     * The source image's slices are stretched to fill the border box.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    Stretch,
    /**
     * The source image's slices are tiled to fill the border box. Tiles may be compressed when needed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    Round,
    /**
     * The source image's slices are tiled to fill the border box. Extra space will be distributed in between tiles.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    Space
}
/**
 * enum Blur style
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare enum BlurStyle {
    /**
     * Thin material.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    Thin,
    /**
     * Regular material.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    Regular,
    /**
     * Thick material.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    Thick,
    /**
     * Material that creates the minimum depth of field effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    BACKGROUND_THIN,
    /**
     * Material that creates a medium shallow depth of field effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    BACKGROUND_REGULAR,
    /**
     * Material that creates a high shallow depth of field effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    BACKGROUND_THICK,
    /**
     * Material that creates the maximum depth of field effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    BACKGROUND_ULTRA_THICK,
    /**
     * No blur.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    NONE,
    /**
     * Component ultra-thin material.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    COMPONENT_ULTRA_THIN = 8,
    /**
     * Component thin material.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    COMPONENT_THIN = 9,
    /**
     * Component regular material.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    COMPONENT_REGULAR = 10,
    /**
     * Defines the thick component material.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    COMPONENT_THICK = 11,
    /**
     * Defines the ultra thick component material.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    COMPONENT_ULTRA_THICK = 12
}
/**
 * Enumerates the policies for activating the blur style.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum BlurStyleActivePolicy {
    /**
     * The component has the blur effect only when the window is focused.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    FOLLOWS_WINDOW_ACTIVE_STATE = 0,
    /**
     * The component always has the blur effect, regardless of whether the window is focused.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    ALWAYS_ACTIVE = 1,
    /**
     * The component does not have the blur effect, regardless of whether the window is focused.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    ALWAYS_INACTIVE = 2
}
/**
 * enum color mode
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum ThemeColorMode {
    /**
     * Defines the mode which is follow up with system.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    SYSTEM,
    /**
     * Defines the light mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    LIGHT,
    /**
     * Defines the dark mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    DARK
}
/**
 * Defines adaptive color
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum AdaptiveColor {
    /**
     * Adaptive color mode is not used.
     * The default color is used as the mask color. Using a mode other than **DEFAULT** can be more time-consuming.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    DEFAULT,
    /**
     * Adaptive color mode is used. The average color value of the color picking area is used as the mask color.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    AVERAGE
}
/**
 * Defines modal transition type.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum ModalTransition {
    /**
     * Slide-up and slide-down animation for the modal.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    DEFAULT,
    /**
     * No transition animation for the modal.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    NONE,
    /**
     * Opacity gradient animation for the modal.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    ALPHA
}
/**
 * Defines the options of backgroundBlurStyle
 *
 * @extends BlurStyleOption
 * @interface BackgroundBlurStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface BackgroundBlurStyleOptions extends BlurStyleOptions {
    /**
     * Defines the policy for activating the blur style.
     *
     * @type { ?BlurStyleActivePolicy }
     * @default BlurStyleActivePolicy.ALWAYS_ACTIVE
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    policy?: BlurStyleActivePolicy;
    /**
     * Color of the background effect when the window is not focused.
     *
     * @type { ?ResourceColor }
     * @default Color.Transparent
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    inactiveColor?: ResourceColor;
}
/**
 * Defines the options of ForegroundBlurStyle
 *
 * @extends BlurStyleOptions
 * @interface ForegroundBlurStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface ForegroundBlurStyleOptions extends BlurStyleOptions {
}
/**
 * Defines the options of blur
 *
 * @interface BlurOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface BlurOptions {
    /**
     * Fuzzy gray scale parameter.
     * @type { [number, number] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    grayscale: [
        number,
        number
    ];
}
/**
 * Defines the SystemAdaptiveOptions interface
 *
 * @interface SystemAdaptiveOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface SystemAdaptiveOptions {
    /**
     * Whether to disable system adaptive.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    disableSystemAdaptation?: boolean;
}
/**
 * Defines the options of blurStyle
 *
 * @interface BlurStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface BlurStyleOptions {
    /**
     * Color mode used for the foreground blur.
     * <br>Default value: **ThemeColorMode.SYSTEM**.
     *
     * @type { ?ThemeColorMode }
     * @default ThemeColorMode.SYSTEM
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    colorMode?: ThemeColorMode;
    /**
     * Adaptive color mode.
     * <br>Default value: **AdaptiveColor.DEFAULT**.
     *
     * @type { ?AdaptiveColor }
     * @default AdaptiveColor.DEFAULT
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    adaptiveColor?: AdaptiveColor;
    /**
     * Foreground blur scale.
     * <br>Default value: **1.0**.
     * <br>Value range: [0.0, 1.0].
     *
     * @type { ?number }
     * @default 1.0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    scale?: number;
    /**
     * Defines the options of blur
     *
     * @type { ?BlurOptions }
     * @default { grayScale: [0,0] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    blurOptions?: BlurOptions;
}
/**
 * Defines the options of BackgroundEffect
 *
 * @interface BackgroundEffectOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface BackgroundEffectOptions {
    /**
     * Blur radius.
     * Value range: [0, +∞).
     * Default value: **0**.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    radius: number;
    /**
     * Saturation.
     * Value range: [0, +∞).
     * Recommended value range: [0, 50].
     *
     * @type { ?number }
     * @default 1
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    saturation?: number;
    /**
     * Brightness.
     * <br>Value range: [0, +∞).
     * <br>Default value: **1** Recommended value range: [0, 2].
     *
     * @type { ?number }
     * @default 1
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    brightness?: number;
    /**
     * Color.
     *
     * @type { ?ResourceColor }
     * @default Color.Transparent
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    color?: ResourceColor;
    /**
     * Define the adaptiveColor of BackgroundEffect.
     *
     * @type { ?AdaptiveColor }
     * @default AdaptiveColor.DEFAULT
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    adaptiveColor?: AdaptiveColor;
    /**
    * Define the blurOptions of BackgroundEffect.
    *
    * @type { ?BlurOptions }
    * @default { grayScale: [0,0] }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    blurOptions?: BlurOptions;
    /**
     * Defines the policy for activating the blur style.
     *
     * @type { ?BlurStyleActivePolicy }
     * @default BlurStyleActivePolicy.ALWAYS_ACTIVE
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    policy?: BlurStyleActivePolicy;
    /**
     * Color of the background effect when the window is not focused.
     *
     * @type { ?ResourceColor }
     * @default Color.Transparent
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    inactiveColor?: ResourceColor;
}
/**
 * Defines the options of ForegroundEffect
 *
 * @interface ForegroundEffectOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface ForegroundEffectOptions {
    /**
     * Define the radius size of ForegroundEffect.The range of this value is [0, ∞)
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    radius: number;
}
/**
 * Provide an interface for the text style of picker
 *
 * @interface PickerTextStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface PickerTextStyle {
    /**
     * Font color.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    color?: ResourceColor;
    /**
     * Text style.
     *
     * @type { ?Font }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    font?: Font;
}
/**
 * Provide an interface for the button style of picker
 *
 * @interface PickerDialogButtonStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface PickerDialogButtonStyle {
    /**
     * Describes the button style.
     *
     * @type { ?ButtonType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    type?: ButtonType;
    /**
     * Describes the button style.
     *
     * @type { ?ButtonStyleMode }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    style?: ButtonStyleMode;
    /**
     * Describes the button role.
     *
     * @type { ?ButtonRole }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    role?: ButtonRole;
    /**
     * Describes the button text size.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    fontSize?: Length;
    /**
     * Describes the button text color.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    fontColor?: ResourceColor;
    /**
     * Describes the button font weight.
     *
     * @type { ?(FontWeight | number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    fontWeight?: FontWeight | number | string;
    /**
     * Describes the button font style.
     *
     * @type { ?FontStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    fontStyle?: FontStyle;
    /**
     * Describes the button font family.
     *
     * @type { ?(Resource | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    fontFamily?: Resource | string;
    /**
     * Describes the button background color.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    backgroundColor?: ResourceColor;
    /**
     * Describes the button border radius.
     *
     * @type { ?(Length | BorderRadiuses) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    borderRadius?: Length | BorderRadiuses;
    /**
     * Define whether the button default to responding to the Enter key
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    primary?: boolean;
}
/**
 * Define the type of shadow
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum ShadowType {
    /**
     * Define a color type of shadow
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    COLOR,
    /**
     * Blur.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    BLUR
}
/**
 * Define the options of shadow
 *
 * @interface ShadowOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface ShadowOptions {
    /**
     * Blur radius of the shadow.
     *
     * @type { number | Resource }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    radius: number | Resource;
    /**
     * Shadow type.
     * <br>Default value: **COLOR**.
     *
     * @type { ?ShadowType }
     * @default ShadowType.COLOR
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    type?: ShadowType;
    /**
     * Color of the shadow. Default value: **Black**
     *
     * @type { ?(Color | string | Resource| ColoringStrategy) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    color?: Color | string | Resource | ColoringStrategy;
    /**
     * Offset of the shadow along the x-axis. Unit is px. Default value is 0.
     *
     * @type { ?(number | Resource) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    offsetX?: number | Resource;
    /**
     * Offset of the shadow along the y-axis. Unit is px. Default value is 0.
     *
     * @type { ?(number | Resource) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    offsetY?: number | Resource;
    /**
     * Whether to fill the inside of the component with shadow. **true**: Fill
     * the inside of the component with shadow.
     * <br>**false**: Do not fill the inside of the component with shadow.
     * <br>The default value is **false**.
     * <br>**NOTE**<br>This attribute does not take effect in textShadow.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    fill?: boolean;
}
/**
 * enum Shadow style
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum ShadowStyle {
    /**
     * Defines the super small default shadow style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    OUTER_DEFAULT_XS,
    /**
     * Defines the small default shadow style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    OUTER_DEFAULT_SM,
    /**
     * Medium shadow.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    OUTER_DEFAULT_MD,
    /**
     * Large shadow.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    OUTER_DEFAULT_LG,
    /**
     * Floating medium shadow.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    OUTER_FLOATING_SM,
    /**
     * Floating medium shadow.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    OUTER_FLOATING_MD
}
/**
 * Defines the options of Shadow.
 *
 * @interface MultiShadowOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface MultiShadowOptions {
    /**
     * Shadow blur radius.
     * Unit: vp.
     * <p>**NOTE**:
     * <br>A value less than or equal to 0 is handled as the default value.
     * </p>
     *
     * @type { ?(number | Resource) }
     * @default 20
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    radius?: number | Resource;
    /**
     * Offset on the x-axis.
     * Unit: vp.
     *
     * @type { ?(number | Resource) }
     * @default 5
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    offsetX?: number | Resource;
    /**
     * Offset on the y-axis.
     * Unit: vp.
     *
     * @type { ?(number | Resource) }
     * @default 5
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    offsetY?: number | Resource;
}
/**
 * The types of expanded safe areas.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum SafeAreaType {
    /**
     * Default non-safe area of the system, including the status bar and navigation bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    SYSTEM,
    /**
     * Non-safe area of the device like Notch or punch hole.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    CUTOUT,
    /**
     * Soft keyboard area.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    KEYBOARD
}
/**
 * Enumerates the safe area edges.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum SafeAreaEdge {
    /**
     * Top edge.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    TOP,
    /**
     * Bottom edge.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    BOTTOM,
    /**
     * Start edge.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    START,
    /**
     * End edge.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    END
}
/**
 * Describe the types for expanding the safe area in layout.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum LayoutSafeAreaType {
    /**
     * Default non-safe area of the system, including the status bar and navigation bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    SYSTEM = 0
}
/**
 *  Define the edges for expanding the safe area in layout.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum LayoutSafeAreaEdge {
    /**
     * Top edge.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    TOP = 0,
    /**
     * Bottom edge.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    BOTTOM = 1
}
/**
 * Defines sheet size type.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum SheetSize {
    /**
     * The sheet height is half of the screen height.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    MEDIUM,
    /**
     * The sheet height is almost the screen height.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    LARGE,
    /**
     * The sheet height automatically adapts to the content.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    FIT_CONTENT = 2
}
/**
 * The modifier key state query function block.
 *
 * @typedef { function } ModifierKeyStateGetter
 * @param { Array<string> } keys - Indicate the modifier keys to query.
 * @returns { boolean } - the query result
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type ModifierKeyStateGetter = (keys: Array<string>) => boolean;
/**
 * Defines the base event.
 *
 * @interface BaseEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface BaseEvent {
    /**
     * Display area of the element that triggers the gesture event.
     *
     * @type { EventTarget }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    target: EventTarget;
    /**
     * Timestamp of the event.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    timestamp: number;
    /**
     * Event input device.
     *
     * @type { SourceType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    source: SourceType;
    /**
     * the Horizontal axis coordinate.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    axisHorizontal?: number;
    /**
     * the Vertical axis coordinate.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    axisVertical?: number;
    /**
     * Press pressure.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    pressure: number;
    /**
     * Angle between the projection of the stylus on the device plane and the x-axis.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    tiltX: number;
    /**
     * Angle between the projection of the stylus on the device plane and the y-axis.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    tiltY: number;
    /**
     * Indicates the angle at which the stylus rotates around the Z-axis.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    rollAngle?: number;
    /**
     * Event input source.
     *
     * @type { SourceTool }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    sourceTool: SourceTool;
    /**
     * Query the modifier key press state, support 'ctrl'|'alt'|'shift'
     *
     * @type { ?ModifierKeyStateGetter }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getModifierKeyState?: ModifierKeyStateGetter;
    /**
     * Indicates the ID of the input device that triggers the current event.
     *
     * @type { ?number } [deviceId] The ID of the input device that triggers the current event
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    deviceId?: number;
    /**
     * Indicates the screen ID on which the event occurred.
     *
     * @type { ?number } [targetDisplayId] The screen ID on which the event occurred.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    targetDisplayId?: number;
}
/**
 * Border image option
 *
 * @interface BorderImageOption
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface BorderImageOption {
    /**
     * Slice width of the upper left corner, upper right corner, lower left corner,
     * and lower right corner of the border image.
     *
     * @type { ?(Length | EdgeWidths | LocalizedEdgeWidths) }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    slice?: Length | EdgeWidths | LocalizedEdgeWidths;
    /**
     * Repeat mode of the source image's slices on the border.
     *
     * @type { ?RepeatMode }
     * @default RepeatMode.Stretch
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    repeat?: RepeatMode;
    /**
     * Border image source
     *
     * @type { ?(string | Resource | LinearGradientOptions) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    source?: string | Resource | LinearGradientOptions;
    /**
     * Width of the border image.
     *
     * @type { ?(Length | EdgeWidths | LocalizedEdgeWidths) }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    width?: Length | EdgeWidths | LocalizedEdgeWidths;
    /**
     * Amount by which the border image is extended beyond the border box.
     *
     * @type { ?(Length | EdgeWidths | LocalizedEdgeWidths) }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    outset?: Length | EdgeWidths | LocalizedEdgeWidths;
    /**
     * Whether to fill the center of the border image.
     * true: Fill the center of the border image.
     * false: Do not fill the center of the border image.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    fill?: boolean;
}
/**
 * Defines the policy of Layout
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare class LayoutPolicy {
    /**
     * The component fills its parent which means its size is as large as its parent.
     *
     * @type { LayoutPolicy }
     * @readonly
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    static readonly matchParent: LayoutPolicy;
}
/**
 * The tap action triggers this method invocation.
 *
 * @extends BaseEvent
 * @interface ClickEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface ClickEvent extends BaseEvent {
    /**
     * X coordinate of the click relative to the upper left corner of the application screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    displayX: number;
    /**
     * Y coordinate of the click relative to the upper left corner of the application screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    displayY: number;
    /**
     * X coordinate of the click relative to the upper left corner of the application window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    windowX: number;
    /**
     * Y coordinate of the click relative to the upper left corner of the application window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    windowY: number;
    /**
     * X coordinate of the click point relative to the left edge of the clicked element.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    x: number;
    /**
     * Y coordinate of the click point relative to the left edge of the clicked element.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    y: number;
    /**
     * Whether the event is triggered by a left-hand or right-hand tap.
     *
     * @type { InteractionHand }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    hand?: InteractionHand;
    /**
     * Prevent the default function.
     *
     * @type { function }
     * @throws { BusinessError } 100017 - Component does not support prevent function.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    preventDefault: () => void;
}
/**
 * The hover action triggers this method invocation.
 *
 * @extends BaseEvent
 * @interface HoverEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface HoverEvent extends BaseEvent {
    /**
     * X coordinate of the hover point relative to the left edge of the hover element.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    x?: number;
    /**
     * Y coordinate of the hover point relative to the upper edge of the hover element.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    y?: number;
    /**
     * X coordinate of the hover point relative to the left edge of the current window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    windowX?: number;
    /**
     * Y coordinate of the hover point relative to the upper edge of the current window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    windowY?: number;
    /**
     * X coordinate of the hover point relative to the left edge of the device screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    displayX?: number;
    /**
     * Y coordinate of the hover point relative to the upper edge of the device screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    displayY?: number;
    /**
     * The blocking hover event pops up.
     *
     * @type { function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    stopPropagation: () => void;
}
/**
 * The mouse click action triggers this method invocation.
 *
 * @extends BaseEvent
 * @interface MouseEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface MouseEvent extends BaseEvent {
    /**
     * Mouse button of the click event.
     *
     * @type { MouseButton }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    button: MouseButton;
    /**
     * Mouse action of the click event.
     *
     * @type { MouseAction }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    action: MouseAction;
    /**
     * X coordinate of the mouse pointer relative to the upper left corner of the application screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    displayX: number;
    /**
     * Y coordinate of the mouse pointer relative to the upper left corner of the application screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    displayY: number;
    /**
     * X coordinate of the mouse pointer relative to the upper left corner of the application window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    windowX: number;
    /**
     * Y coordinate of the mouse pointer relative to the upper left corner of the application window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    windowY: number;
    /**
     * X coordinate of the mouse pointer relative to the upper left corner of the component being clicked.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    x: number;
    /**
     * Y coordinate of the mouse pointer relative to the upper left corner of the component being clicked.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    y: number;
    /**
     * Stops the event from bubbling upwards or downwards.
     *
     * @type { function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    stopPropagation: () => void;
    /**
     * X axis offset relative to the previous reported mouse pointer position. When the mouse pointer is at
     * the edge of the screen, the value may be less than the difference of the X coordinate reported twice.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    rawDeltaX?: number;
    /**
     * Y axis offset relative to the previous reported mouse pointer position. When the mouse pointer is at
     * the edge of the screen, the value may be less than the difference of the Y coordinate reported twice.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    rawDeltaY?: number;
    /**
     * Array of all mouse buttons that are currently pressed.
     *
     * @type { ?MouseButton[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    pressedButtons?: MouseButton[];
}
/**
 * The accessibility hover action triggers this method invocation.
 *
 * @extends BaseEvent
 * @typedef AccessibilityHoverEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface AccessibilityHoverEvent extends BaseEvent {
    /**
     * Type of the accessibility hover event.
     *
     * @type { AccessibilityHoverType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    type: AccessibilityHoverType;
    /**
     * X coordinate of the accessibility hover point relative to the left edge of the event hit element.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    x: number;
    /**
     * Y coordinate of the accessibility hover point relative to the upper edge of the event hit element.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    y: number;
    /**
     * X coordinate of the accessibility hover point relative to the left edge of the device screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    displayX: number;
    /**
     * Y coordinate of the accessibility hover point relative to the upper edge of the device screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    displayY: number;
    /**
     * X coordinate of the accessibility hover point relative to the left edge of the current window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    windowX: number;
    /**
     * Y coordinate of the accessibility hover point relative to the upper edge of the current window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    windowY: number;
}
/**
 * Type of the touch event.
 *
 * @interface TouchObject
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface TouchObject {
    /**
     * Type of the touch event.
     *
     * @type { TouchType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    type: TouchType;
    /**
     * Unique identifier of a finger.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    id: number;
    /**
     * X coordinate of the touch point relative to the upper left corner of the application screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    displayX: number;
    /**
     * Y coordinate of the touch point relative to the upper left corner of the application screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    displayY: number;
    /**
     * X coordinate of the touch point relative to the upper left corner of the application window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    windowX: number;
    /**
     * Y coordinate of the touch point relative to the upper left corner of the application window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    windowY: number;
    /**
     * X coordinate of the touch point relative to the upper left corner of the event responding component.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    x: number;
    /**
     * Y coordinate of the touch point relative to the upper left corner of the event responding component.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    y: number;
    /**
     * Whether the event is triggered by a left-hand or right-hand tap.
     *
     * @type { InteractionHand }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    hand?: InteractionHand;
    /**
     * Time when the finger is pressed.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    pressedTime?: number;
    /**
   * Pressure value of the finger press.
   *
   * @type { ?number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @atomicservice
   * @since 20
   */
    pressure?: number;
    /**
     * Width of the area pressed by the finger.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    width?: number;
    /**
     * Height of the area pressed by the finger.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    height?: number;
}
/**
 * TouchObject getHistoricalPoints Function Parameters
 *
 * @interface HistoricalPoint
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface HistoricalPoint {
    /**
     * The base touchObject information of historicalPoint
     *
     * @type { TouchObject }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    touchObject: TouchObject;
    /**
     * Contact area between the finger pad and the screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    size: number;
    /**
     * Pressure of the touch event.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    force: number;
    /**
     * Timestamp of the touch event.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    timestamp: number;
}
/**
 * Touch Action Function Parameters
 *
 * @extends BaseEvent
 * @interface TouchEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface TouchEvent extends BaseEvent {
    /**
     * Type of the touch event.
     *
     * @type { TouchType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    type: TouchType;
    /**
     * All finger information.
     *
     * @type { TouchObject[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    touches: TouchObject[];
    /**
     * Finger information changed.
     *
     * @type { TouchObject[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    changedTouches: TouchObject[];
    /**
     * Stops the event from bubbling upwards or downwards.
     *
     * @type { function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    stopPropagation: () => void;
    /**
     * Obtains all historical points of the current frame.
     *
     * @returns { Array<HistoricalPoint> } - return all historical points.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getHistoricalPoints(): Array<HistoricalPoint>;
    /**
     * Blocks the default event.
     *
     * @type { function }
     * @throws { BusinessError } 100017 - Component does not support prevent function.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    preventDefault: () => void;
}
/**
 * The axis event triggers this method invocation.
 *
 * @extends BaseEvent
 * @interface AxisEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface AxisEvent extends BaseEvent {
    /**
     * Axis action of the axis event.
     *
     * @type { AxisAction }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    action: AxisAction;
    /**
     * X coordinate of the mouse cursor relative to the left edge of the device screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    displayX: number;
    /**
     * Y coordinate of the mouse cursor relative to the upper edge of the device screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    displayY: number;
    /**
     * X coordinate of the mouse cursor relative to the left edge of the current window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    windowX: number;
    /**
     * Y coordinate of the mouse cursor relative to the upper edge of the current window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    windowY: number;
    /**
     * X coordinate of the mouse cursor relative to the left edge of the axis event hit element.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    x: number;
    /**
     * Y coordinate of the mouse cursor relative to the upper edge of the axis event hit element.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    y: number;
    /**
     * Scroll step configuration which is only mouse wheel has.
     *  *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    scrollStep?: number;
    /**
     * Active event bubbling.
     *
     * @type { Callback<void> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    propagation: Callback<void>;
    /**
     * Obtains the value of the horizontal scroll axis for this axis event.
     *
     * @returns { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    getHorizontalAxisValue(): number;
    /**
     * Obtains the value of the vertical scroll axis for this axis event.
     *
     * @returns { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    getVerticalAxisValue(): number;
}
/**
 * Defines the callback type used in onSizeChange.
 * <br>oldValue - the width and height of the component before the change.
 * <br>newValue - the width and height of the component after the change.
 *
 * @typedef { function } SizeChangeCallback
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export type SizeChangeCallback = (oldValue: SizeOptions, newValue: SizeOptions) => void;
/**
 * Defines the callback type used in onGestureRecognizerJudgeBegin.
 *
 * @typedef { function } GestureRecognizerJudgeBeginCallback
 * @param { BaseGestureEvent } event - the event information
 * @param { GestureRecognizer } current - the current gesture recognizer of the component
 * @param { Array<GestureRecognizer> } recognizers - the gesture recognizers of the component on the response chain
 * @returns { GestureJudgeResult } the gesture judge result
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type GestureRecognizerJudgeBeginCallback = (event: BaseGestureEvent, current: GestureRecognizer, recognizers: Array<GestureRecognizer>) => GestureJudgeResult;
/**
 * Defines the callback type used in shouldBuiltInRecognizerParallelWith.
 *
 * @typedef { function } ShouldBuiltInRecognizerParallelWithCallback
 * @param { GestureRecognizer } current - the current gesture recognizer of the component
 * @param { Array<GestureRecognizer> } others - the gesture recognizers of the component on the response chain
 * @returns { GestureRecognizer } gesture recognizer of the component
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type ShouldBuiltInRecognizerParallelWithCallback = (current: GestureRecognizer, others: Array<GestureRecognizer>) => GestureRecognizer;
/**
 * Defines the finish callback type used in transition.
 *
 * @typedef { function } TransitionFinishCallback
 * @param { boolean } transitionIn - a boolean value indicates whether it is the callback of transitionIn or transitionOut.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export type TransitionFinishCallback = (transitionIn: boolean) => void;
/**
 * Defines the PixelMap type object for ui component.
 *
 * @typedef { image.PixelMap } PixelMap
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type PixelMap = image.PixelMap;


/**
 * pixelmap object with release function.
 *
 * @interface PixelMapMock
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
declare interface PixelMapMock {
  /**
   * release function.
   *
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  release(): void;
}

/**
 * Enum for Drag Behavior.
 *
 * <strong>NOTE</strong>:<br>
 * DragBehavior serves to inform you about the intended method of data handling,
 * whether it's a copy or a move, but it does not actually dictate the real processing of the data.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum DragBehavior {
    /**
     * If drag use copy event, then set DragBehavior.COPY.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    COPY,
    /**
     * If drag use move event, then set DragBehavior.MOVE.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    MOVE
}
/**
 * Import the UnifiedData type object for ui component.
 *
 * @typedef { unifiedDataChannel.UnifiedData } UnifiedData
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type UnifiedData = unifiedDataChannel.UnifiedData;
/**
 * Import the Summary type object for ui component.
 *
 * @typedef { unifiedDataChannel.Summary } Summary
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export type Summary = unifiedDataChannel.Summary;
/**
 * Import the UniformDataType type object for ui component.
 *
 * @typedef { uniformTypeDescriptor.UniformDataType } UniformDataType
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export type UniformDataType = uniformTypeDescriptor.UniformDataType;
/**
 * Enum for Drag Result.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum DragResult {
    /**
     * If the drag is successful, return DragResult.DRAG_SUCCESSFUL.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    DRAG_SUCCESSFUL = 0,
    /**
     * If drag fail, return DragResult.DRAG_FAILED.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    DRAG_FAILED = 1,
    /**
     * If drag action cancel, return DragResult.DRAG_CANCELED.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    DRAG_CANCELED = 2,
    /**
     * If node allow drop in, return DragResult.DROP_ENABLED.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    DROP_ENABLED = 3,
    /**
     * If node don't allow drop in, return DragResult.DROP_DISABLED.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    DROP_DISABLED = 4
}
/**
 * Enum for BlendMode.
 * Blend modes for compositing current component
 * with overlapping content. Use overlapping content
 * as dst, current component as src.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare enum BlendMode {
    /**
     * The top image is superimposed on the bottom image without any blending.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    NONE = 0,
    /**
     * The target pixels covered by the source pixels are erased by being turned to completely transparent.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    CLEAR = 1,
    /**
     * r = s: Only the source pixels are displayed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    SRC = 2,
    /**
     * r = d
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    DST = 3,
    /**
     * r = s + (1 - sa) * d: The source pixels are blended based on opacity and cover the target pixels.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    SRC_OVER = 4,
    /**
     * r = d + (1 - da) * s: The target pixels are blended based on opacity and cover on the source pixels.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    DST_OVER = 5,
    /**
     * r = s * da: Only the part of the source pixels that overlap with the target pixels is displayed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    SRC_IN = 6,
    /**
     * r = d * sa: Only the part of the target pixels that overlap with the source pixels is displayed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    DST_IN = 7,
    /**
     * r = s * (1 - da)
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    SRC_OUT = 8,
    /**
     * r = d * (1 - sa), retains the parts of the destination pixels that do not overlap with the source.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    DST_OUT = 9,
    /**
     * r = s * da + d * (1 - sa): The part of the source pixels that overlap with the target pixels is displayed
     * and the part of the target pixels that do not overlap with the source pixels are displayed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    SRC_ATOP = 10,
    /**
     * r = d * sa + s * (1 - da): The part of the target pixels that overlap with the source pixels
     * and the part of the source pixels that do not overlap with the target pixels are displayed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    DST_ATOP = 11,
    /**
     * r = s * (1 - da) + d * (1 - sa)
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    XOR = 12,
    /**
     * r = min(s + d, 1):
     * New pixels resulting from adding the source pixels to the target pixels are displayed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    PLUS = 13,
    /**
     * r = s * d
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    MODULATE = 14,
    /**
     * r = s + d - s * d
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    SCREEN = 15,
    /**
     * multiply or screen, depending on destination
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    OVERLAY = 16,
    /**
     * rc = s + d - max(s * da, d * sa), ra = kSrcOver
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    DARKEN = 17,
    /**
     * rc = s + d - min(s * da, d * sa), ra = kSrcOver
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    LIGHTEN = 18,
    /**
     * brighten destination to reflect source
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    COLOR_DODGE = 19,
    /**
     * darken destination to reflect source
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    COLOR_BURN = 20,
    /**
     * multiply or screen, depending on source
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    HARD_LIGHT = 21,
    /**
     * The LIGHTEN or DARKEN mode is used, depending on the source pixels.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    SOFT_LIGHT = 22,
    /**
     * rc = s + d - 2 * (min(s * da, d * sa)), ra = kSrcOver: The final pixel is the result of subtracting
     * the darker of the two pixels (source and target) from the lighter one.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    DIFFERENCE = 23,
    /**
     * rc = s + d - two(s * d), ra = kSrcOver
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    EXCLUSION = 24,
    /**
     * r = s * (1 - da) + d * (1 - sa) + s * d:
     * The final pixel is the result of multiplying the source pixel by the target pixel.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    MULTIPLY = 25,
    /**
     * hue of source with saturation and luminosity of destination
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    HUE = 26,
    /**
     * saturation of source with hue and luminosity of destination
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    SATURATION = 27,
    /**
     * hue and saturation of source with luminosity of destination
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    COLOR = 28,
    /**
     * luminosity of source with hue and saturation of destination
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    LUMINOSITY = 29
}
/**
 * Enum for BlendApplyType.
 * Indicate how to apply specified blend mode to
 * the view's content.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare enum BlendApplyType {
    /**
     * The content of the view is blended in sequence on the target image.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    FAST = 0,
    /**
     * The content of the component and its child components are drawn on the
     * offscreen canvas, and then blended with the existing content on the canvas.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    OFFSCREEN = 1
}
/**
 * DragEvent object description
 *
 * @interface DragEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface DragEvent {
    /**
     * X coordinate of the touch point relative to the left edge of the device screen.
     *
     * @returns { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getDisplayX(): number;
    /**
     * Y coordinate of the touch point relative to the upper edge of the device screen.
     *
     * @returns { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getDisplayY(): number;
    /**
     * X coordinate of the touch point relative to the left edge of the current window.
     *
     * @returns { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getWindowX(): number;
    /**
     * Y coordinate of the touch point relative to the left edge of the current window.
     *
     * @returns { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getWindowY(): number;
    /**
    * If copy is COPY, this DragEvent is a copy event.
    * @type { DragBehavior } Operation, if use copy then set COPY, else set MOVE.
    * @default COPY
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    dragBehavior: DragBehavior;
    /**
     * If useCustomDropAnimation is true, System will not use drop animation.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    useCustomDropAnimation: boolean;
    /**
     * Set dragData into DragEvent.
     *
     * @param { UnifiedData } unifiedData - dragData.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    setData(unifiedData: UnifiedData): void;
    /**
     * Get dragData from DragEvent.
     *
     * @returns { UnifiedData } - get dragData.
     * @throws { BusinessError } 190001 - Data not found.
     * @throws { BusinessError } 190002 - Data error.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getData(): UnifiedData;
    /**
     * Get dragData summary from DragEvent.
     *
     * @returns { Summary } - get Summary Data.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getSummary(): Summary;
    /**
     * Set dragEvent result to DragEvent.
     *
     * @param { DragResult } dragResult - the return of dragEvent.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    setResult(dragResult: DragResult): void;
    /**
     * Get dragEvent result from DragEvent.
     *
     * @returns { DragResult } - dragResult Data.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getResult(): DragResult;
    /**
     * Get the rectangle of drag window.
     *
     * @returns { Rectangle } - getPreview rectangle.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getPreviewRect(): Rectangle;
    /**
     * Get the x axis velocity of drag gesture.
     *
     * @returns { number } - get x axis velocity.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getVelocityX(): number;
    /**
     * Get the y axis velocity of drag gesture.
     *
     * @returns { number } - get y axis velocity.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getVelocityY(): number;
    /**
     * Get the velocity of drag gesture.
     *
     * @returns { number } - get velocity.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getVelocity(): number;
    /**
     * Query the modifier key press state, support 'ctrl'|'alt'|'shift'
     *
     * @type { ?ModifierKeyStateGetter }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getModifierKeyState?: ModifierKeyStateGetter;
    /**
     * Setup one drop animation execution callback, which will be triggered by system when user drops.
     * Use this way to implement the custom drop animation instead of doing it in onDrop, as the system
     * will decide when to trigger the callback during the drop handling.
     * [Note]:
     *   1. Please set useCustomDropAnimation to true as well when using this method.
     *   2. Do not implement the animation no-related logics in the callback.
     *
     * @param { Callback<void> } customDropAnimation - the custom drop animation function.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    executeDropAnimation(customDropAnimation: Callback<void>): void;

    /**
     * Enable the internal drop animation, which is only avaiable for system applications.
     *
     * The animations' configuration need to be provided through the input paramerter, and it is a string in json format.
     *
     * This method can only be called in onDrop, and please do not use custom drop animation after this method,
     * as it will reset the calling result, and use custom drop animation insteadly.
     *
     * @param { string } configuration - the internal drop animation's configuration.
     * @throws { BusinessError } 202 - Permission verification failed, application which is not a system application uses system API.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 190003 - Operation not allowed for current phase.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
  enableInternalDropAnimation(configuration: string): void;
}
/**
 * The event callback function for drag and drop common interfaces.
 * @typedef { function } OnDragEventCallback
 * @param { DragEvent } event - the event object indicating current drag status.
 * @param { string } [extraParams] - extra information set by user or system.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type OnDragEventCallback = (event: DragEvent, extraParams?: string) => void;
/**
 * Defines the options for the drop handling.
 *
 * @interface DropOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface DropOptions {
    /**
     * Indicating to disable the UDMF data prefetch action by system or not.
     * The system will try to fetch data before calling user's onDrop for some situation,
     * it will retry to get data until the max time limit (2.4s for now) reaches,
     * this's useful for the cross device draging operation, as the system helps to eliminate
     * the communication instability, but it's redundant for startDataLoading method, as this
     * method will take care the data fetching with asynchronous mechanism, so must set this
     * field to true if using startDataLoading in onDrop to avoid the data is fetched before
     * onDrop executing unexpectedly.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    disableDataPrefetch?: boolean;
}
/**
 * KeyEvent object description:
 *
 * @interface KeyEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface KeyEvent {
    /**
     * Type of a key.
     *
     * @type { KeyType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    type: KeyType;
    /**
     * Key code of a key
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    keyCode: number;
    /**
     * Key value of a key.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    keyText: string;
    /**
     * Type of the input device that triggers the current key, such as the keyboard or handle.
     *
     * @type { KeySource }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    keySource: KeySource;
    /**
     * Indicates the ID of the input device that triggers the current key.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    deviceId: number;
    /**
     * Indicates the status of the key when the key is pressed.
     * The value 1 indicates the pressed state, and the value 0 indicates the unpressed state.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    metaKey: number;
    /**
     * Timestamp when the key was pressed.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    timestamp: number;
    /**
     * Block event bubbling.
     *
     * @type { function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    stopPropagation: () => void;
    /**
     * Intention code of a key or modifier keys.
     *
     * @type { IntentionCode }
     * @default IntentionCode.INTENTION_UNKNOWN
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    intentionCode: IntentionCode;
    /**
     * Query the modifier key press state, support 'ctrl'|'alt'|'shift'
     *
     * @type { ?ModifierKeyStateGetter }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getModifierKeyState?: ModifierKeyStateGetter;
    /**
     * Unicode of a key
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    unicode?: number;
}
/**
 * Focus axis event object description.
 *
 * @extends BaseEvent
 * @interface FocusAxisEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface FocusAxisEvent extends BaseEvent {
    /**
     * The axis values of axis event.
     *
     * @type { Map<AxisModel, number> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    axisMap: Map<AxisModel, number>;
    /**
     * The blocking event pops up.
     *
     * @type { Callback<void> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    stopPropagation: Callback<void>;
}
/**
 * CrownEvent object description
 *
 * @interface CrownEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface CrownEvent {
    /**
     *The timestamp of the rotating crown event.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    timestamp: number;
    /**
     * The angular velocity of a rotating crown.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    angularVelocity: number;
    /**
     * The rotation angle of the rotating crown.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    degree: number;
    /**
     * The behavior of rotating crown.
     *
     * @type { CrownAction }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    action: CrownAction;
    /**
     * The blocking event pops up.
     *
     * @type { Callback<void> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    stopPropagation: Callback<void>;
}
/**
 * Overlay module options
 *
 * @interface BindOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface BindOptions {
    /**
     * Background color of the sheet.
     * <br>Default value: **Color.White**.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    backgroundColor?: ResourceColor;
    /**
     * Callback for when the sheet is displayed (after the animation ends).
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onAppear?: () => void;
    /**
     * Callback for when the sheet disappears (after the animation ends).
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onDisappear?: () => void;
    /**
     * Callback for when the sheet is about to be displayed (before the animation starts).
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onWillAppear?: () => void;
    /**
     * Callback function before overlay popAnimation starts.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onWillDisappear?: () => void;
}
/**
 * Component content cover dismiss
 *
 * @interface DismissContentCoverAction
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface DismissContentCoverAction {
    /**
     * Defines content cover dismiss function
     *
     * @type { VoidCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    dismiss: VoidCallback;
    /**
     * Defines content cover dismiss reason
     *
     * @type { DismissReason }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    reason: DismissReason;
}
/**
 * Component content cover options
 *
 * @extends BindOptions
 * @interface ContentCoverOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface ContentCoverOptions extends BindOptions {
    /**
     * Defines transition type
     *
     * @type { ?ModalTransition }
     * @default ModalTransition.Default
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    modalTransition?: ModalTransition;
    /**
     * Callback function when the content cover interactive dismiss
     *
     * @type { ?Callback<DismissContentCoverAction> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onWillDismiss?: Callback<DismissContentCoverAction>;
    /**
     * Defines transition effect param
     *
     * @type { ?TransitionEffect }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    transition?: TransitionEffect;
}
/**
 * Component sheet title options
 *
 * @interface SheetTitleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface SheetTitleOptions {
    /**
     * Defines title text
     *
     * @type { ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    title: ResourceStr;
    /**
     * Defines subtitle text
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    subtitle?: ResourceStr;
}
/**
 * Defines the sheet type.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum SheetType {
    /**
     * Bottom sheet.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    BOTTOM = 0,
    /**
     * Center sheet.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    CENTER = 1,
    /**
     * Popup sheet. The popup sheet cannot be dismissed with a pull-down gesture.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    POPUP = 2
}
/**
 * Define the display mode of the sheet.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum SheetMode {
    /**
     * The sheet is displayed at the top of the window corresponding to the current **UIContext** instance,
     * above all pages. It is displayed at the same level as dialog boxes.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    OVERLAY = 0,
    /**
     * The sheet is displayed at the top of the current page.
     * <br>**NOTE**<br>Currently, the sheet can only be mounted on a **Page**
     * or **NavDestination** node, with priority given to the **NavDestination**
     * node if it is present. This means that, the sheet can only be displayed at
     * the top of these two types of pages.<br> In this mode, new pages can overlay
     * the sheet, and when the user returns to the previous page, the sheet remains
     * present without losing its content.<br> In this mode, you must ensure that
     * the target page node, such as the **Page** node, has been attached to the tree
     * before bringing up the sheet; otherwise, the sheet will not be able to be
     * attached to the corresponding page node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    EMBEDDED = 1
}
/**
 * Define the scroll size mode of the sheet.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum ScrollSizeMode {
    /**
     * Sheet change scroll size after the slide ends.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    FOLLOW_DETENT = 0,
    /**
     * Sheet change scroll size during the sliding process.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    CONTINUOUS = 1
}
/**
 * Define the mode of sheet how to avoid keyboard.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum SheetKeyboardAvoidMode {
    /**
     * Sheet will not aovid keyboard.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    NONE = 0,
    /**
     * Firstly sheet will avoid keyboard by changing its height.
     * And then sheet will avoid by resizing after reaching its maximum height.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    TRANSLATE_AND_RESIZE = 1,
    /**
     * Sheet will only avoid keyboard by resizing the content.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    RESIZE_ONLY = 2,
    /**
     * Firstly sheet will avoid keyboard by changing its height.
     * And then sheet will avoid keyboard by scrolling after reaching its maximum height.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    TRANSLATE_AND_SCROLL = 3
}
/**
 * Component sheet dismiss
 *
 * @interface SheetDismiss
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface SheetDismiss {
    /**
     * Defines sheet dismiss function
     *
     * @type { VoidCallback  }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    dismiss: VoidCallback;
}
/**
 * Component sheet dismiss
 *
 * @interface DismissSheetAction
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface DismissSheetAction {
    /**
     * Defines sheet dismiss function
     *
     * @type { VoidCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    dismiss: VoidCallback;
    /**
     * Dismiss reason type.
     *
     * @type { DismissReason }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    reason: DismissReason;
}
/**
 * Defines sheet spring back action
 *
 * @interface SpringBackAction
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface SpringBackAction {
    /**
     * Defines spring back function
     *
     * @type { VoidCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    springBack: VoidCallback;
}
/**
 * Defines the detent array of a single length.
 *
 * @typedef { [SheetSize | Length] } SingleLengthDetent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type SingleLengthDetent = [
    SheetSize | Length
];
/**
 * Defines the detent array of a two-length.
 *
 * @typedef { [(SheetSize | Length), SheetSize | Length | undefined] } DoubleLengthDetents
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type DoubleLengthDetents = [
    (SheetSize | Length),
    SheetSize | Length | undefined
];
/**
 * Defines the detent array of a three-length.
 *
 * @typedef { [(SheetSize | Length), SheetSize | Length | undefined, SheetSize | Length | undefined] } TripleLengthDetents
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type TripleLengthDetents = [
    (SheetSize | Length),
    SheetSize | Length | undefined,
    SheetSize | Length | undefined
];
/**
 * Component sheet options
 *
 * @extends BindOptions
 * @interface SheetOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface SheetOptions extends BindOptions {
    /**
     * Defines sheet height
     *
     * @type { ?(SheetSize | Length) }
     * @default Sheet.LARGE
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    height?: SheetSize | Length;
    /**
     * Whether to display the drag bar.
     * <br>**NOTE**<br>By default, the drag bar is displayed only when the sheet's
     * **detents** attribute is set to multiple heights and the settings take effect.
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    dragBar?: boolean;
    /**
     * Mask color of the sheet.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    maskColor?: ResourceColor;
    /**
     * Defines sheet detents
     *
     * @type { ?(TripleLengthDetents) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    detents?: TripleLengthDetents;
    /**
     * Background blur of the sheet. By default, there is no background blur.
     *
     * @type { ?BlurStyle }
     * @default BlurStyle.NONE
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    blurStyle?: BlurStyle;
    /**
     * Defines whether the close icon is displayed
     *
     * @type { ?(boolean | Resource) }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    showClose?: boolean | Resource;
    /**
    * Type of the sheet.
    * <br>**NOTE**<br>The types supported by the sheet vary by window.
    * <br>1. Width < 600 vp: bottom.
    * <br>2. 600 vp <= Width: bottom, center, and popup (default).
    * <br>3. Width >= 840 vp: bottom, center, and popup (default).
    *
    * @type { ?SheetType }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    preferType?: SheetType;
    /**
     * Title of the sheet.
     *
     * @type { ?(SheetTitleOptions | CustomBuilder) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    title?: SheetTitleOptions | CustomBuilder;
    /**
     * Callback invoked when the user performs an interactive dismiss operation: pulling down or clicking
     * the back button, the mask, or the close icon.<br>**NOTE**<br>If this callback is registered, the
     * sheet is not dismissed immediately when the user performs the above operations. To dismiss the sheet,
     * you must call **shouldDismiss.dismiss()** in the callback.<br>If this callback is not registered, the
     * sheet is dismissed immediately when the user performs the above operations, without any additional
     * behavior.<br>It is recommended that this API be used in scenarios where a secondary confirmation is required.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    shouldDismiss?: (sheetDismiss: SheetDismiss) => void;
    /**
     * Callback invoked when the user performs an interactive dismiss operation:
     * pulling down or clicking the back button, the mask, or the close icon,
     * to obtain the type of dismiss operation and decide whether to dismiss the sheet.
     * <p>**NOTE**:
     * <br>If this callback is registered, the sheet is not dismissed immediately when the user performs the above
     * operations.
     * <br>Instead, you can use the DismissSheetAction parameter in the callback to determine the type of
     * dismiss operation and decide whether to dismiss the sheet.
     * <br>If this callback is not registered, the sheet is dismissed immediately when the user performs the above
     * operations, without any additional behavior.
     * <br>No further interception with onWillDismiss is allowed in an onWillDismiss callback.
     * </p>
     *
     * @type { ?Callback<DismissSheetAction> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onWillDismiss?: Callback<DismissSheetAction>;
    /**
    * Callback invoked when the user performs a pull-down-to-dismiss gesture, to control the bounce effect.
    * <p>**NOTE**:
    * <br>If this callback is registered along with **shouldDismiss** or **onWillDismiss** you can control whether the
    * sheet bounces back during the pull-down-to-dismiss operation by calling **springBack** in the callback.
    * <br>If this callback is not registered but **shouldDismiss** or **onWillDismiss** is registered, the sheet will
    * bounce back before remaining open or being dismissed based on the callback behavior.
    * <br>If neither this callback nor **shouldDismiss** or **onWillDismiss** is registered, the sheet is dismissed by
    * default during the pull-down-to-dismiss operation.
    * </p>
    *
    * @type { ?Callback<SpringBackAction> }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    onWillSpringBackWhenDismiss?: Callback<SpringBackAction>;
    /**
     * Whether to allow users to interact with the page pertaining to the sheet.
     * <br>**NOTE**<br>The value **true** means that interactions are allowed, in which
     * case no mask is not displayed. The value **false** means that interactions are not
     * allowed, in which case a mask is displayed. If this parameter is not set, interactions
     * are allowed for the popup sheet, but not for bottom and center sheets. If this parameter
     * is set to **true**, the setting of **maskColor** does not take effect.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enableOutsideInteractive?: boolean;
    /**
     * Width of the sheet.
     * Percentage parameter method: Set the width of the sheet as a percentage of the width of the parent element.
     *
     * @type { ?Dimension }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    width?: Dimension;
    /**
     * Border width of the sheet.
     * You can set the width for all four sides or set separate widths for individual sides.
     * Default value: **0**.
     * Percentage parameter method:
     * Set the border width of the sheet as a percentage of the width of the parent element.
     * If the left and right border widths of the sheet are greater than the width of the sheet, and the top
     * and bottom border widths are greater than the height of the sheet, the display may not appear as expected.
     * <p>**Note**:
     * <br>For bottom sheets, the bottom border width setting is ineffective.
     * </p>
     *
     * @type { ?(Dimension | EdgeWidths | LocalizedEdgeWidths) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    borderWidth?: Dimension | EdgeWidths | LocalizedEdgeWidths;
    /**
     * Border color of the sheet.
     * **borderColor** must be used with **borderWidth** in pairs.
     * <p>**NOTE**:
     * <br>For bottom sheets, the bottom border color setting is ineffective.
     * </p>
     *
     * @type { ?(ResourceColor | EdgeColors | LocalizedEdgeColors) }
     * @default Color.Black
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    borderColor?: ResourceColor | EdgeColors | LocalizedEdgeColors;
    /**
     * Defines the sheet's border style.
     *
     * @type { ?(BorderStyle | EdgeStyles) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    borderStyle?: BorderStyle | EdgeStyles;
    /**
     * Shadow of the sheet.
     * Default value for 2-in-1 devices: **ShadowStyle.OUTER_FLOATING_SM**.
     *
     * @type { ?(ShadowOptions | ShadowStyle) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    shadow?: ShadowOptions | ShadowStyle;
    /**
     * Callback for changes in the height of the sheet.
     * <p>**Note**:
     * <br>For a bottom sheet, the height of each frame is only returned when there are changes in detents or during drag
     * actions.
     * <br>When the sheet is pulled up or making space for the soft keyboard, only the final height is returned.
     * <br>For other types of sheets, the final height is only returned when the sheet is pulled up.
     * <br>The return value is in px.
     * <p>
     *
     * @type { ?Callback<number> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onHeightDidChange?: Callback<number>;
    /**
     * Determine the level sheet shows, whether sheet should be displayed within the page.
     *
     * @type { ?SheetMode }
     * @default SheetMode.OVERLAY
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    mode?: SheetMode;
    /**
     * Content update mode of the sheet when it is scrolled.
     *
     * @type { ?ScrollSizeMode }
     * @default ScrollSizeMode.FELLOW_DETEND
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    scrollSizeMode?: ScrollSizeMode;
    /**
     * Callback for changes in the detents of the sheet.
     * <p>**NOTE**:
     * <br>For a bottom sheet, the final height is returned when there are changes in detents.
     * <br>The return value is in px.
     * </p>
     * @type { ?Callback<number> }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onDetentsDidChange?: Callback<number>;
    /**
     * Called when width of the sheet changed
     *
     * @type { ?Callback<number> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onWidthDidChange?: Callback<number>;
    /**
     * Called when the sheet type changed
     *
     * @type { ?Callback<SheetType> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onTypeDidChange?: Callback<SheetType>;
    /**
     * The UIContext that the sheet belongs to
     *
     * @type { ?UIContext }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    uiContext?: UIContext;
    /**
     * Determine the mode of sheet how to avoid keyboard.
     *
     * @type { ?SheetKeyboardAvoidMode }
     * @default SheetKeyboardAvoidMode.TRANSLATE_AND_SCROLL
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    keyboardAvoidMode?: SheetKeyboardAvoidMode;
    /**
     * Defines whether to respond to the hover mode.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enableHoverMode?: boolean;
    /**
     * Defines the sheet's display area in hover mode.
     *
     * @type { ?HoverModeAreaType }
     * @default HoverModeAreaType.BOTTOM_SCREEN
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    hoverModeArea?: HoverModeAreaType;

     /**
      * Sets the position offset of the bindSheet.
      *
      * @type { ?Position }
      * @syscap SystemCapability.ArkUI.ArkUI.Full
      * @systemapi
      * @since 20
      */
    offset?: Position
    /**
     * Sets whether the sheet edge has spring effect.
     *
     * @type { ?number }
     * @default 3
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    effectEdge?: number;
    /**
     * Defines sheet radius
     *
     * @type { ?(LengthMetrics | BorderRadiuses | LocalizedBorderRadiuses) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    radius?: LengthMetrics | BorderRadiuses | LocalizedBorderRadiuses;
    /**
     * Select a detent from detents property
     *
     * @type { ?(SheetSize | Length) }
     * @default detents[0]
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    detentSelection?: SheetSize | Length;
    /**
     * Whether to display in the sub window
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    showInSubWindow?: boolean;
    /**
     * The placement of popup sheet type.
     * Supports all positions defined in Placement.
     *
     * @type { ?Placement }
     * @default Placement.Bottom
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    placement?: Placement;
    /**
     * placement On target node
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    placementOnTarget?: boolean;
}
/**
 * The custom styles function block.
 *
 * @typedef { function } CustomStyles
 * @param { CommonMethod } instance - The component instance which can be used to set common attributes.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type CustomStyles = (instance: CommonMethod) => void;
/**
 * Component State Styles.
 *
 * @interface StateStyles
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface StateStyles {
    /**
     * Defines normal state styles.
     *
     * @type { ?CustomStyles }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    normal?: CustomStyles;
    /**
     * Defines pressed state styles.
     *
     * @type { ?CustomStyles }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    pressed?: CustomStyles;
    /**
     * Defines disabled state styles.
     *
     * @type { ?CustomStyles }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    disabled?: CustomStyles;
    /**
     * Defines focused state styles.
     *
     * @type { ?CustomStyles }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    focused?: CustomStyles;
    /**
     * Defines clicked state styles.
     *
     * @type { ?CustomStyles }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    clicked?: CustomStyles;
    /**
     * Defines selected state styles.
     *
     * @type { ?CustomStyles }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    selected?: CustomStyles;
}
/**
 * Defines the options of popup message.
 *
 * @interface PopupMessageOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface PopupMessageOptions {
    /**
     * Sets the color of popup text.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    textColor?: ResourceColor;
    /**
     * Sets the font of popup text.
     *
     * @type { ?Font }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    font?: Font;
}
/**
 * Dismiss reason type.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum DismissReason {
    /**
    * Touching the Back button, swiping left or right on the screen, or pressing the Esc key.
    *
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    PRESS_BACK = 0,
    /**
    * Touching the mask.
    *
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    TOUCH_OUTSIDE = 1,
    /**
    * Touching the Close button.
    *
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    CLOSE_BUTTON = 2,
    /**
    * Slide down
    * <p><strong>NOTE</strong>:
    * <br>This API is effective only in sheet transition.
    * </p>
    *
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    SLIDE_DOWN = 3
}
/**
 * Component popup dismiss
 *
 * @interface DismissPopupAction
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface DismissPopupAction {
    /**
     * Defines popup dismiss function
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    dismiss(): void;
    /**
     * Defines popup dismiss reason
     *
     * @type { DismissReason }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    reason: DismissReason;
}
/**
 * Popup state change param
 *
 * @interface PopupStateChangeParam
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface PopupStateChangeParam {
    /**
     * is Visible.
     * Anonymous Object Rectification.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    isVisible: boolean;
}
/**
 * Popup state change callback
 *
 * @typedef { function } PopupStateChangeCallback
 * @param { PopupStateChangeParam } event - The parameter of state change callback.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type PopupStateChangeCallback = (event: PopupStateChangeParam) => void;
/**
 * Popup mask type
 *
 * @interface PopupMaskType
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface PopupMaskType {
    /**
     * Color.
     * Anonymous Object Rectification.
     *
     * @type { ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    color: ResourceColor;
}
/**
 * Popup common options
 *
 * @interface PopupCommonOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface PopupCommonOptions {
    /**
     * placement of popup.
     *
     * @type { ?Placement }
     * @default Placement.Bottom
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    placement?: Placement;
    /**
     * Set the background color of the popup.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    popupColor?: ResourceColor;
    /**
     * whether show arrow
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enableArrow?: boolean;
    /**
     * Whether hide popup when click mask
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    autoCancel?: boolean;
    /**
     * on State Change
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onStateChange?: PopupStateChangeCallback;
    /**
     * The offset of the sharp corner of popup.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowOffset?: Length;
    /**
     * Whether to display in the sub window.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    showInSubWindow?: boolean;
    /**
     * The mask to block gesture events of popup.
     * When mask is set false, gesture events are not blocked.
     * When mask is set true, gesture events are blocked and mask color is transparent.
     *
     * @type { ?(boolean | PopupMaskType) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    mask?: boolean | PopupMaskType;
    /**
     * Sets the space of between the popup and target.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    targetSpace?: Length;
    /**
     * Sets the position offset of the popup.
     *
     * @type { ?Position }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    offset?: Position;
    /**
     * Set the width of the popup.
     *
     * @type { ?Dimension }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    width?: Dimension;
    /**
     * The position of the sharp corner of popup.
     *
     * @type { ?ArrowPointPosition }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowPointPosition?: ArrowPointPosition;
    /**
     * The width of the arrow.
     *
     * @type { ?Dimension }
     * @default 16.0_vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowWidth?: Dimension;
    /**
     * The height of the arrow.
     *
     * @type { ?Dimension }
     * @default 8.0_vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowHeight?: Dimension;
    /**
     * The round corners of the popup.
     *
     * @type { ?Dimension }
     * @default 20.0_vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    radius?: Dimension;
    /**
     * The style of popup Shadow.
     *
     * @type { ?(ShadowOptions | ShadowStyle) }
     * @default ShadowStyle.OUTER_DEFAULT_MD.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    shadow?: ShadowOptions | ShadowStyle;
    /**
     * Defines popup background blur Style
     *
     * @type { ?BlurStyle }
     * @default BlurStyle.COMPONENT_ULTRA_THICK
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    backgroundBlurStyle?: BlurStyle;
    /**
     * Set popup focusable
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    focusable?: boolean;
    /**
     * Defines the transition effect of popup opening and closing
     *
     * @type { ?TransitionEffect }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    transition?: TransitionEffect;
    /**
     * Callback function when the popup interactive dismiss.
     * Use boolean to respond all interactive dismiss event. Use Callback to customize which event should be responded.
     *
     * @type { ?(boolean | Callback<DismissPopupAction>) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onWillDismiss?: boolean | Callback<DismissPopupAction>;
    /**
     * Determine if it is compatible popup's half folded.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enableHoverMode?: boolean;
    /**
     * Determine if popup can follow the target node when it has rotation or scale.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    followTransformOfTarget?: boolean;
}
/**
 * Defines the Tips options.
 *
 * @interface TipsOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface TipsOptions {
    /**
     * Defines the delay time for appearing.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    appearingTime?: number;
    /**
     * Defines the delay time for disappearing.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    disappearingTime?: number;
    /**
     * Define the delay time for the appearance of continuous operations.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    appearingTimeWithContinuousOperation?: number;
    /**
     * Define the delay time for the disappearance of continuous operations.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    disappearingTimeWithContinuousOperation?: number;
    /**
     * whether show arrow
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enableArrow?: boolean;
    /**
     * The position of the sharp corner of Tips.
     *
     * @type { ?ArrowPointPosition }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowPointPosition?: ArrowPointPosition;
    /**
     * The width of the arrow.
     *
     * @type { ?Dimension }
     * @default 16.0_vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowWidth?: Dimension;
    /**
     * The height of the arrow.
     *
     * @type { ?Dimension }
     * @default 8.0_vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowHeight?: Dimension;
}
/**
 * Defines the popup button.
 *
 * @interface PopupButton
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface PopupButton {
    /**
     * Button text value
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    value: string;
    /**
     * action
     *
     * @type { VoidCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    action: VoidCallback;
}
/**
 * Defines the popup options.
 *
 * @interface PopupOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface PopupOptions {
    /**
     * Content of the popup message.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    message: string;
    /**
     * The placement of popup.
     * Supports all positions defined in Placement.
     *
     * @type { ?Placement }
     * @default Placement.Bottom
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    placement?: Placement;
    /**
     * The first button.
     *
     * @type { ?PopupButton }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    primaryButton?: PopupButton;
    /**
     * The second button.
     *
     * @type { ?PopupButton }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    secondaryButton?: PopupButton;
    /**
     * on State Change
     *
     * @type { ?PopupStateChangeCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onStateChange?: PopupStateChangeCallback;
    /**
     * The offset of the sharp corner of popup.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowOffset?: Length;
    /**
     * Whether to display in the sub window.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    showInSubWindow?: boolean;
    /**
     * The mask to block gesture events of popup.
     * When mask is set false, gesture events are not blocked.
     * When mask is set true, gesture events are blocked and mask color is transparent.
     *
     * @type { ?(boolean | PopupMaskType) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    mask?: boolean | PopupMaskType;
    /**
     * Parameters of the popup message.
     *
     * @type { ?PopupMessageOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    messageOptions?: PopupMessageOptions;
    /**
     * Sets the space of between the popup and target.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    targetSpace?: Length;
    /**
     * whether show arrow
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enableArrow?: boolean;
    /**
     * Sets the position offset of the popup.
     *
     * @type { ?Position }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    offset?: Position;
    /**
     * Set the background color of the popup.
     *
     * @type { ?(Color | string | Resource | number) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    popupColor?: Color | string | Resource | number;
    /**
     * Whether hide popup when click mask
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    autoCancel?: boolean;
    /**
     * Set the width of the popup.
     *
     * @type { ?Dimension }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    width?: Dimension;
    /**
     * The position of the sharp corner of popup.
     *
     * @type { ?ArrowPointPosition }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowPointPosition?: ArrowPointPosition;
    /**
     * The width of the arrow.
     *
     * @type { ?Dimension }
     * @default 16.0_vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowWidth?: Dimension;
    /**
     * The height of the arrow.
     *
     * @type { ?Dimension }
     * @default 8.0_vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowHeight?: Dimension;
    /**
     * The round corners of the popup.
     *
     * @type { ?Dimension }
     * @default 20.0_vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    radius?: Dimension;
    /**
     * The style of popup Shadow.
     *
     * @type { ?(ShadowOptions | ShadowStyle) }
     * @default ShadowStyle.OUTER_DEFAULT_MD.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    shadow?: ShadowOptions | ShadowStyle;
    /**
     * Defines popup background blur Style
     *
     * @type { ?BlurStyle }
     * @default BlurStyle.COMPONENT_ULTRA_THICK
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    backgroundBlurStyle?: BlurStyle;
    /**
     * Defines the transition effect of popup opening and closing
     *
     * @type { ?TransitionEffect }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    transition?: TransitionEffect;
    /**
     * Callback function when the popup interactive dismiss
     *
     * @type { ?(boolean | Callback<DismissPopupAction>) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onWillDismiss?: boolean | Callback<DismissPopupAction>;
    /**
     * Determine if it is compatible popup's half folded.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enableHoverMode?: boolean;
    /**
     * Determine if popup can follow the target node when it has rotation or scale.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    followTransformOfTarget?: boolean;
    /**
     * Define the popup avoid keyboard mode.
     *
     * @type { ?KeyboardAvoidMode }
     * @default KeyboardAvoidMode.NONE
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    keyboardAvoidMode?: KeyboardAvoidMode;
}
/**
 * Defines the custom popup options.
 *
 * @interface CustomPopupOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface CustomPopupOptions {
    /**
     * Popup builder.
     * <p><strong>NOTE</strong>:
     * <br>The popup attribute is a universal attribute. A custom popup does not support display of another popup.
     * <br>The position attribute cannot be used for the first-layer container in the builder.
     * <br>If the position attribute is used, the popup will not be displayed.
     * <br>If a custom component is used in the builder, the aboutToAppear and aboutToDisappear lifecycle callbacks
     * of the custom component are irrelevant to the visibility of the popup. As such, the lifecycle of the
     * custom component cannot be used to determine whether the popup is displayed or not.
     * </p>
     *
     * @type { CustomBuilder }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    builder: CustomBuilder;
    /**
     * Preferred position of the popup. If the set position is insufficient for holding the popup,
     * it will be automatically adjusted.
     *
     * @type { ?Placement }
     * @default Placement.Bottom
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    placement?: Placement;
    /**
     * Color of the popup. To remove the background blur, set backgroundBlurStyle to BlurStyle.NONE.
     *
     * @type { ?(Color | string | Resource | number) }
     * @default TRANSPARENT plus COMPONENT_ULTRA_THICK
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    popupColor?: Color | string | Resource | number;
    /**
     * whether show arrow
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enableArrow?: boolean;
    /**
     * Whether to automatically dismiss the popup when an operation is performed on the page.
     * <p><strong>NOTE</strong>:
     * <br>To enable the popup to disappear upon a click on it, place a layout component in the builder place the
     * <Popup> component in the layout component, and modify the value of the bindPopup variable (show: boolean)
     * in the onClick event of the layout component.
     * </p>
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    autoCancel?: boolean;
    /**
     * on State Change
     *
     * @type { ?PopupStateChangeCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onStateChange?: PopupStateChangeCallback;
    /**
     * The offset of the sharp corner of popup.
     *
     * Offset of the popup arrow relative to the popup. When the arrow is at the top or bottom of the popup:
     * <br>The value 0 indicates that the arrow is located on the leftmost, and any other value indicates the distance
     * from the arrow to the leftmost; the arrow is centered by default. When the arrow is on the left or right
     * side of the popup: The value indicates the distance from the arrow to the top; the arrow is centered by
     * default. When the popup is displayed on either edge of the screen, it will automatically deviate leftward
     * or rightward to stay within the safe area. When the value is 0, the arrow always points to the bound component.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowOffset?: Length;
    /**
     * Whether to display in the sub window.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    showInSubWindow?: boolean;
    /**
     * The mask to block gesture events of popup.
     * When mask is set false, gesture events are not blocked.
     * When mask is set true, gesture events are blocked and mask color is transparent.
     *
     * @type { ?(boolean | PopupMaskType) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    mask?: boolean | PopupMaskType;
    /**
     * Sets the space of between the popup and target.
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    targetSpace?: Length;
    /**
     * Sets the position offset of the popup.
     *
     * @type { ?Position }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    offset?: Position;
    /**
     * Width of the popup.
     *
     * @type { ?Dimension }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    width?: Dimension;
    /**
     * Position of the popup arrow relative to its parent component. Available positions are Start, Center, and End,
     * in both vertical and horizontal directions. All these positions are within the parent component area.
     *
     * @type { ?ArrowPointPosition }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowPointPosition?: ArrowPointPosition;
    /**
     * Arrow thickness. If the arrow thickness exceeds the length of the edge minus twice the size of the popup
     * rounded corner, the arrow is not drawn.
     *
     * @type { ?Dimension }
     * @default 16.0_vp.
     * <p><strong>NOTE</strong>:
     * <br>This parameter cannot be set in percentage.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowWidth?: Dimension;
    /**
     * The height of the arrow.
     *
     * @type { ?Dimension }
     * @default 8.0_vp.
     * <p><strong>NOTE</strong>:
     * <br>This parameter cannot be set in percentage.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowHeight?: Dimension;
    /**
     * Rounded corner radius of the popup.
     *
     * @type { ?Dimension }
     * @default 20.0_vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    radius?: Dimension;
    /**
     * Popup shadow.
     *
     * @type { ?(ShadowOptions | ShadowStyle) }
     * @default ShadowStyle.OUTER_DEFAULT_MD.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    shadow?: ShadowOptions | ShadowStyle;
    /**
     * Background blur style of the popup.
     *
     * @type { ?BlurStyle }
     * @default BlurStyle.COMPONENT_ULTRA_THICK
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    backgroundBlurStyle?: BlurStyle;
    /**
     * Set popup focusable
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    focusable?: boolean;
    /**
     * Defines the transition effect of popup opening and closing
     *
     * @type { ?TransitionEffect }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    transition?: TransitionEffect;
    /**
     * Whether to perform dismissal event interception and interception callback.
     * 1. If this parameter is set to false, the system does not respond to the dismissal event initiated by
     * touching the Back button, swiping left or right on the screen, or pressing the Esc key; and the system
     * dismisses the popup only when show is set to false. If this parameter is set to true, the system responds
     * to the dismissal event as expected.
     * 2. If this parameter is set to a function, the dismissal event is intercepted and the callback function
     * is executed.
     * <p><strong>NOTE</strong>:
     * <br>No more onWillDismiss callback is allowed in an onWillDismiss callback.
     * </p>
     *
     * @type { ?(boolean | Callback<DismissPopupAction>) }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onWillDismiss?: boolean | Callback<DismissPopupAction>;
    /**
      * Determine if it is compatible popup's half folded.
      *
      * @type { ?boolean }
      * @default false
      * @syscap SystemCapability.ArkUI.ArkUI.Full
      * @crossplatform
      * @atomicservice
      * @since 20
      */
    enableHoverMode?: boolean;
    /**
     * Determine if popup can follow the target node when it has rotation or scale.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    followTransformOfTarget?: boolean;
    /**
     * Define the popup avoid keyboard mode.
     *
     * @type { ?KeyboardAvoidMode }
     * @default KeyboardAvoidMode.NONE
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    keyboardAvoidMode?: KeyboardAvoidMode;
}
/**
 * Defines the menu preview mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum MenuPreviewMode {
    /**
     * No preview content.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    NONE = 0,
    /**
     * The preview is a screenshot of the component on which a long-press triggers the context menu.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    IMAGE = 1
}
/**
 * Defines the animator range of start and end property.
 *
 * @typedef { [number, number] } AnimationNumberRange
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type AnimationNumberRange = [
    number,
    number
];
/**
 * Defines the ContextMenu's preview animator options.
 *
 * @interface ContextMenuAnimationOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export interface ContextMenuAnimationOptions {
    /**
     * Sets the start animator scale and end animator scale.
     *
     * @type { ?AnimationNumberRange }
     * @default -
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    scale?: AnimationNumberRange;
    /**
     * Defines the transition effect of menu preview opening and closing.
     *
     * @type { ?TransitionEffect }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    transition?: TransitionEffect;
    /**
     * Sets the scale start and end animator of the image displayed before the custom builder preview is displayed.
     *
     * @type { ?AnimationNumberRange }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    hoverScale?: AnimationNumberRange;
}
/**
   * Defines the type of border radius.
   *
   * @typedef { Length | BorderRadiuses | LocalizedBorderRadiuses }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @crossplatform
   * @atomicservice
   * @since 20
   */
export type BorderRadiusType = Length | BorderRadiuses | LocalizedBorderRadiuses;
/**
 * Defines the menu haptic feedback mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum HapticFeedbackMode {
    /**
     * No haptic feedback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    DISABLED = 0,
    /**
     * Defines menu always haptic feedback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    ENABLED = 1,
    /**
     * Defines menu automatically haptic feedback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    AUTO = 2
}
/**
 * Defines the context menu options.
 *
 * @interface ContextMenuOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface ContextMenuOptions {
    /**
     * Offset for showing the context menu, which should not cause the menu to extend beyond the screen.
     * <p><strong>NOTE</strong>:
     * <br>When the menu is displayed relative to the parent component area, the width or height of the area is
     * automatically counted into the offset based on the placement attribute of the menu. When the menu is
     * displayed above the parent component (that is, placement is set to Placement.TopLeft, Placement.Top, or
     * Placement.TopRight), a positive value of x indicates rightward movement relative to the parent component,
     * and a positive value of y indicates upward movement. When the menu is displayed below the parent component
     * (that is, placement is set to Placement.BottomLeft, Placement.Bottom, or Placement.BottomRight), a positive
     * value of x indicates rightward movement relative to the parent component, and a positive value of y indicates
     * downward movement. When the menu is displayed on the left of the parent component (that is, placement is set
     * to Placement.LeftTop, Placement.Left, or Placement.LeftBottom), a positive value of x indicates leftward
     * movement relative to the parent component, and a positive value of y indicates downward movement. When the
     * menu is displayed on the right of the parent component (that is, placement is set to Placement.RightTop,
     * Placement.Right, or Placement.RightBottom), a positive value of x indicates rightward movement relative to
     * the parent component, and a positive value of y indicates downward movement. If the display position of the
     * menu is adjusted (different from the main direction of the initial placement value), the offset value is invalid.
     * </p>
     *
     * @type { ?Position }
     * @default {x:0,y:0} - Percentage values are not supported.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    offset?: Position;
    /**
     * Preferred position of the context menu. If the set position is insufficient for holding the component, it will be
     * automatically adjusted.
     * <p><strong>NOTE</strong>:
     * <br>If a menu is displayed by pressing and holding or right-clicking, the menu is displayed at the clicked
     * position.
     * </p>
     *
     * @type { ?Placement }
     * @default Placement.BottomLeft
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    placement?: Placement;
    /**
     * whether show arrow belong to the menu.
     * <p><strong>NOTE</strong>:
     * <br>When enableArrow is true, an arrow is displayed in the position specified by placement.
     * <br>If placement is not set or its value is invalid, the arrow is displayed above the target.
     * <br>If the position is insufficient for holding the arrow, it is automatically adjusted.
     * <br>When enableArrow is undefined, no arrow is displayed.
     * <br>This API is supported in bindContextMenu since API version 10 and bindMenu since API version 12.
     * </p>
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enableArrow?: boolean;
    /**
     * Offset of the arrow relative to the context menu. The offset settings take effect only when the value is valid,
     * can be converted to a number greater than 0, and does not cause the arrow to extend beyond the safe area of
     * the context menu.
     * <p><strong>NOTE</strong>:
     * <br>The safe distance of the arrow from the four sides of the menu is the sum of the menu's corner radius and
     * half the width of the arrow. The value of placement determines whether the offset is horizontal or vertical.
     * When the arrow is in the horizontal direction of the menu, the offset is the distance from the arrow to the
     * leftmost arrow's safe distance. When the arrow is in the vertical direction of the menu, the offset is the
     * distance from the arrow to the topmost arrow's safe distance. The default position where the arrow is
     * displayed varies with the value of placement: Without any avoidance by the menu, when placement is set to
     * Placement.Top or Placement.Bottom, the arrow is displayed horizontally and is centered by default; when
     * placement is set to Placement.Left or Placement.Right, the arrow is displayed vertically and is centered by
     * default; when placement is set to Placement.TopLeft or Placement.BottomLeft, the arrow is displayed
     * horizontally by default, and the distance from the arrow to the left edge of the menu is the arrow's safe
     * distance; when placement is set to Placement.TopRight or Placement.BottomRight, the arrow is displayed
     * horizontally by default, and the distance from the arrow to the right edge of the menu is the arrow's safe
     * distance; when placement is set to Placement.LeftTop or Placement.RightTop, the arrow is displayed vertically
     * by default, and the distance from the arrow to the top edge of the menu is the arrow's safe distance; when
     * placement is set to Placement.LeftBottom or Placement.RightBottom, the arrow is displayed vertically by
     * default, and the distance from the arrow to the bottom edge of the menu is the arrow's safe distance.
     * <br>This API is supported in bindContextMenu since API version 10 and bindMenu since API version 12.
     * </p>
     *
     * @type { ?Length }
     * @default 0vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    arrowOffset?: Length;
    /**
     * Preview displayed when the context menu is triggered by a long-press or use the isShown variable of
     * bindContextMenu to display the preview content style of the menu.
     * <p><strong>NOTE</strong>:
     * <br>This parameter has no effect when responseType is set to ResponseType.RightClick.
     * <br>If preview is set to MenuPreviewMode.NONE or is not set, the enableArrow parameter is effective.
     * <br>If preview is set to MenuPreviewMode.IMAGE or CustomBuilder, no arrow will be displayed even when
     * enableArrow is true.
     * </p>
     *
     * @type { ?(MenuPreviewMode | CustomBuilder) }
     * @default MenuPreviewMode.NONE
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    preview?: MenuPreviewMode | CustomBuilder;
    /**
     * Defines the border radius for preview of menu.
     *
     * @type { BorderRadiusType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    previewBorderRadius?: BorderRadiusType;
    /**
     * Border radius of the menu.
     * <p><strong>NOTE</strong>:
     * <br>The value can be in percentage.
     * <br>If the sum of the two maximum corner radii in the horizontal direction exceeds the menu's width, or if the sum
     * of the two maximum corner radii in the vertical direction exceeds the menu's height, the default corner radius of
     * the menu will be used.
     * </p>
     *
     * @type { ?(Length | BorderRadiuses | LocalizedBorderRadiuses) }
     * @default 8vp for 2-in-1 devices and 20vp for other devices
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    borderRadius?: Length | BorderRadiuses | LocalizedBorderRadiuses;
    /**
     * Callback triggered when the menu is displayed.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onAppear?: () => void;
    /**
     * Callback function when the context menu disappear.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onDisappear?: () => void;
    /**
     * Callback triggered when the menu is about to appear.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    aboutToAppear?: () => void;
    /**
     * Callback triggered when the menu is about to disappear.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    aboutToDisappear?: () => void;
    /**
     * The margin of menu's layoutRegion.
     *
     * @type { ?Margin }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    layoutRegionMargin?: Margin;
    /**
     * The preview animator options.
     *
     * @type { ?ContextMenuAnimationOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    previewAnimationOptions?: ContextMenuAnimationOptions;
    /**
     * Background color of the menu.
     *
     * @type { ?ResourceColor }
     * @default Color.Transparent
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    backgroundColor?: ResourceColor;
    /**
     * Background blur style of the menu.
     *
     * @type { ?BlurStyle }
     * @default BlurStyle.COMPONENT_ULTRA_THICK
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    backgroundBlurStyle?: BlurStyle;
    /**
     * Defines the menu's background blur style with options
     *
     * @type { ?BackgroundBlurStyleOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    backgroundBlurStyleOptions?: BackgroundBlurStyleOptions;
    /**
     * Defines the menu's background effect with options
     *
     * @type { ?BackgroundEffectOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    backgroundEffect?: BackgroundEffectOptions;
    /**
     * Defines the transition effect of menu opening and closing.
     *
     * @type { ?TransitionEffect }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    transition?: TransitionEffect;
    /**
      * Determine if it is compatible menu's half folded.
      *
      * @type { ?boolean }
      * @default false
      * @syscap SystemCapability.ArkUI.ArkUI.Full
      * @crossplatform
      * @atomicservice
      * @since 20
      */
    enableHoverMode?: boolean;
    /**
      * The color of menu's outer border.
      *
      * @type { ?(ResourceColor | EdgeColors) }
      * @syscap SystemCapability.ArkUI.ArkUI.Full
      * @crossplatform
      * @atomicservice
      * @since 20
      */
    outlineColor?: ResourceColor | EdgeColors;
    /**
      * The width of menu's outer border.
      *
      * @type { ?(Dimension | EdgeOutlineWidths) }
      * @syscap SystemCapability.ArkUI.ArkUI.Full
      * @crossplatform
      * @atomicservice
      * @since 20
      */
    outlineWidth?: Dimension | EdgeOutlineWidths;
    /**
     * Defines the haptic feedback mode of menu.
     *
     * @type { ?HapticFeedbackMode }
     * @default HapticFeedbackMode.DISABLED
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    hapticFeedbackMode?: HapticFeedbackMode;
}
/**
 * Defines the menu options.
 *
 * @extends ContextMenuOptions
 * @interface MenuOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface MenuOptions extends ContextMenuOptions {
    /**
     * Sets the title of the menu window.
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    title?: ResourceStr;
    /**
     * Whether to display in the sub window.
     *
     * @type { ?boolean }
     * @default true for 2-in-1 devices and false for other devices
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    showInSubWindow?: boolean;
}
/**
 * Implements a ProgressMask object to set the progress, maximum value, and color of the mask.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare class ProgressMask {
    /**
     * constructor.
     *
     * @param { number } value - Current value of the progress mask. Value range: [0.0, +∞).
     * @param { number } total - Maximum value of the progress mask. Value range: [0.0, +∞).
     * @param { ResourceColor } color - Color of the progress mask.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    constructor(value: number, total: number, color: ResourceColor);
    /**
     * Updates the progress value of the progress mask.
     *
     * @param { number } value - Current value of the progress mask.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    updateProgress(value: number): void;
    /**
     * Update the color of the mask.
     *
     * @param { ResourceColor } value - Color of the progress mask.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    updateColor(value: ResourceColor): void;
    /**
     * Enable the breathe animation of mask.
     *
     * @param { boolean } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enableBreathingAnimation(value: boolean): void;
}
/**
 * Defines TouchTestInfo class.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare class TouchTestInfo {
    /**
     * Get the X-coordinate relative to the window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    windowX: number;
    /**
     * Get the Y-coordinate relative to the window.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    windowY: number;
    /**
     * Get the X-coordinate relative to the current component.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    parentX: number;
    /**
     * Get the Y-coordinate relative to the current component.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    parentY: number;
    /**
     * Get the X-coordinate relative to the sub component.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    x: number;
    /**
     * Get the Y-coordinate relative to the sub component.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    y: number;
    /**
     * Get the rectangle of sub component.
     *
     * @type { RectResult }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    rect: RectResult;
    /**
     * Get the name of sub component.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    id: string;
}
/**
 * Defines TouchResult class.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare class TouchResult {
    /**
     * Defines the touch test strategy.
     *
     * @type { TouchTestStrategy }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    strategy: TouchTestStrategy;
    /**
     * Defines the component's name.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    id?: string;
}
/**
 * Set the edge blur effect distance of the corresponding defense line of the component
 * When the component expand out, no re-layout is triggered
 *
 * @interface PixelStretchEffectOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface PixelStretchEffectOptions {
    /**
     * top property. value range (-∞, ∞)
     * If value > 0, expand outward elements. Else first shrink by value and then expand outward pixels.
     *
     * @type { ?Length }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    top?: Length;
    /**
     * bottom property. value range (-∞, ∞)
     * If value > 0, expand outward elements. Else first shrink by value and then expand outward pixels.
     *
     * @type { ?Length }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    bottom?: Length;
    /**
     * left property. value range (-∞, ∞)
     * If value > 0, expand outward elements. Else first shrink by value and then expand outward pixels.
     *
     * @type { ?Length }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    left?: Length;
    /**
     * right property. value range (-∞, ∞)
     * If value > 0, expand outward elements. Else first shrink by value and then expand outward pixels.
     *
     * @type { ?Length }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    right?: Length;
}
/**
 * Defines the click effect.
 *
 * @interface ClickEffect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface ClickEffect {
    /**
     * Set the click effect level.
     *
     * @type { ClickEffectLevel }
     * @default ClickEffectLevel.Light
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    level: ClickEffectLevel;
    /**
     * Set scale number.
     * This default scale is same as the scale of click effect level.
     *
     * <p><strong>NOTE</strong>:
     * <br> This parameter works based on the setting of ClickEffectLevel.
     * <br> If level is set to ClickEffectLevel.LIGHT, the default value is 0.90.
     * <br> If level is set to ClickEffectLevel.MIDDLE or ClickEffectLevel.HEAVY, the default value is 0.95.
     * <br> If level is set to undefined or null (both of which evaluate to ClickEffectLevel.LIGHT), the default value is 0.90.
     * <br> If scale is set to undefined or null, the default zoom ratio for the set level will be used.
     * </p>
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    scale?: number;
}
/**
 * Defines the fadingEdge options.
 *
 * @typedef FadingEdgeOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface FadingEdgeOptions {
    /**
     * The length of FadingEdge.
     *
     * @type { LengthMetrics }
     * @default 32vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    fadingEdgeLength?: LengthMetrics;
}
/**
 * Define nested scroll options
 *
 * @interface NestedScrollOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface NestedScrollOptions {
    /**
     * Set NestedScrollMode when the scrollable component scrolls forward
     *
     * @type { NestedScrollMode }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    scrollForward: NestedScrollMode;
    /**
     * Set NestedScrollMode when the scrollable component scrolls backward
     *
     * @type { NestedScrollMode }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    scrollBackward: NestedScrollMode;
}
/**
 * Defines the menu element.
 *
 * @interface MenuElement
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface MenuElement {
    /**
     * Sets the value of the menu element.
     *
     * @type { ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    value: ResourceStr;
    /**
     * Sets the icon of the menu element.
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    icon?: ResourceStr;
    /**
     * Sets the symbol of the menu element.
     *
     * @type { ?SymbolGlyphModifier }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    symbolIcon?: SymbolGlyphModifier;
    /**
     * If the value is true, the menu element is available and can respond to operations such as clicking.
     * If the value is false, the menu element is not available and click operations are not responded.
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enabled?: boolean;
    /**
     * Method executed by the callback.
     *
     * @type { function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    action: () => void;
}

/**
 * Defines the attribute modifier.
 *
 * @interface AttributeModifier<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface AttributeModifier<T> {
  /**
   * Defines the normal update attribute function.
   *
   * @param { T } instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  default applyNormalAttribute(instance: T) : void;

  /**
   * Defines the pressed update attribute function.
   *
   * @param { T } instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  default applyPressedAttribute(instance: T) : void;

  /**
   * Defines the focused update attribute function.
   *
   * @param { T } instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  default applyFocusedAttribute(instance: T) : void;

  /**
   * Defines the disabled update attribute function.
   *
   * @param { T } instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  default applyDisabledAttribute(instance: T) : void;

  /**
   * Defines the selected update attribute function.
   *
   * @param { T } instance
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  default applySelectedAttribute(instance: T) : void;
}
/**
 * Defines the content modifier.
 *
 * @interface ContentModifier
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface ContentModifier<T> {
    /**
     * Defining applyContent function.
     *
     * @returns { WrappedBuilder<CustomBuilderT<T>> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    applyContent(): WrappedBuilder<CustomBuilderT<T>>;
}
/**
 * Defines the common configuration.
 *
 * @interface CommonConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface CommonConfiguration<T> {
    /**
     * If the value is true, the contentModifier is available and can respond to operations such as triggerChange.
     *  If it is set to false, triggerChange operations are not responded.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enabled: boolean;
    /**
     * Obtains the contentModifier instance object
     *
     * @type { ContentModifier<T> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    contentModifier: ContentModifier<T>;
}
/**
 * Outline Style
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare enum OutlineStyle {
    /**
     * Solid border.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    SOLID = 0,
    /**
     * Dashed border.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    DASHED = 1,
    /**
     * Dotted border. The radius of a dot is half of **outlineWidth**.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    DOTTED = 2
}
/**
 * Defines the drag preview mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum DragPreviewMode {
    /**
     * Default preview mode, let system process preview scale.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    AUTO = 1,
    /**
     * Disable system scale to preview panel
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    DISABLE_SCALE = 2,
    /**
     * Enable the default shadow effect of preview.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    ENABLE_DEFAULT_SHADOW = 3,
    /**
     * Enable the default radius effect of preview.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    ENABLE_DEFAULT_RADIUS = 4,
    /**
     * Enable the default gray effect on the dragging item.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    ENABLE_DRAG_ITEM_GRAY_EFFECT = 5,
    /**
     * Enable the tile effect for multi drag, each dragged graph is display in the original relative position.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    ENABLE_MULTI_TILE_EFFECT = 6,
    /**
     * Enable the touch point calculation position based on final preview rect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    ENABLE_TOUCH_POINT_CALCULATION_BASED_ON_FINAL_PREVIEW = 7
}
/**
 * Define drag start animation effect from drag preview to the handle drag image
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare enum DraggingSizeChangeEffect {
    /**
     * Default effect, no transition.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    DEFAULT = 0,
    /**
     * Only scaled transition, this parameter take effect when PREVIEW_MODE is not DISABLE_SCALE.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    SIZE_TRANSITION = 1,
    /**
     * Scaled and content transition together, this size transition take effect when PREVIEW_MODE is not DISABLE_SCALE.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    SIZE_CONTENT_TRANSITION = 2
}
/**
 * Define the menu pop-up policy
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum MenuPolicy {
    /**
     * Default value. The default logic of whether to pop up a menu depends on the scene.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    DEFAULT = 0,
    /**
     * The menu is always hidden.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    HIDE = 1,
    /**
     * The menu is always displayed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    SHOW = 2
}
/**
 * Defines the preview options.
 *
 * @interface DragPreviewOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface DragPreviewOptions {
    /**
     * Drag preview mode.
     *
     * @type { ?(DragPreviewMode | Array<DragPreviewMode>) }
     * @default DragPreviewMode.AUTO
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    mode?: DragPreviewMode | Array<DragPreviewMode>;
    /**
     * The flag for number showing.
     *
     * @type { ?(boolean | number) }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    numberBadge?: boolean | number;
    /**
    * Drag start animation effect from drag preview to the handle drag image.
    *
    * @type { ?DraggingSizeChangeEffect }
    * @default DraggingSizeChangeEffect.DEFAULT
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @atomicservice
    * @since 20
    */
    sizeChangeEffect?: DraggingSizeChangeEffect;
}
/**
 * Defines the drag options.
 *
 * @interface DragInteractionOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface DragInteractionOptions {
    /**
    * Define whether to gather selected nodes in grid or list.
    *
    * @type { ?boolean }
    * @default false
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @atomicservice
    * @since 20
    */
    isMultiSelectionEnabled?: boolean;
    /**
    * Define whether to execute animation before preview floating.
    *
    * @type { ?boolean }
    * @default false
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @atomicservice
    * @since 20
    */
    defaultAnimationBeforeLifting?: boolean;
    /**
    * Config if auto scrolling should be triggered when the drag hovered on a scrollable controller's edge.
    *
    * @type { ?boolean }
    * @default true
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @atomicservice
    * @since 20
    */
    enableEdgeAutoScroll?: boolean;
    /**
    * Define whether to enable the haptic feedback when dragging, the default value is false.
    *
    * @type { ?boolean }
    * @default false
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @atomicservice
    * @since 20
    */
    enableHapticFeedback?: boolean;
    /**
    * Define whether to lifting trigger drag by finger.
    *
    * @type { ?boolean }
    * @default false
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @atomicservice
    * @since 20
    */
    isLiftingDisabled?: boolean;
}
/**
 * Defines the drag preview configuration.
 *
 * @interface PreviewConfiguration
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface PreviewConfiguration {
    /**
    * Define whether to only use for lifting.
    *
    * @type { ?boolean }
    * @default false
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @atomicservice
    * @since 20
    */
    onlyForLifting?: boolean;
    /**
    * Define whether to delay create builder.
    *
    * @type { ?boolean }
    * @default false
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @atomicservice
    * @since 20
    */
    delayCreating?: boolean;
}
/**
 * Define the options of invert
 *
 * @interface InvertOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface InvertOptions {
    /**
     * Defines the low value of threshold
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    low: number;
    /**
     * Defines the high value of threshold
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    high: number;
    /**
     * Defines the threshold
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    threshold: number;
    /**
     *Defines the threshold range
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    thresholdRange: number;
}
/**
 * Defines the type that can be undefined.
 *
 * @typedef { T | undefined } Optional<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export type Optional<T> = T | undefined;
/**
 * Defines the TipsMessageType property with ResourceStr and StyledString.
 *
 * @typedef { ResourceStr | StyledString } TipsMessageType
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type TipsMessageType = ResourceStr | StyledString;
/**
 * Define the options for background image.
 *
 * @interface BackgroundImageOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export interface BackgroundImageOptions {
    /**
     * Sets the synchronous or asynchronous mode for background image loading.
     * The default parameter type is bool, and the default value is false.
     *
     * @type { ?boolean }
     * @param { boolean } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    syncLoad?: boolean;
    /**
     * Set the repeat style of the background image.
     *
     * @type { ?ImageRepeat }
     * @param { ImageRepeat } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    repeat?: ImageRepeat;
}
/**
 * Defines background options.
 *
 * @interface BackgroundOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface BackgroundOptions {
    /**
     * Set the alignment of the custom background and component.
     *
     * Anonymous Object Rectification.
     * @type { ?Alignment }
     * @default Alignment.Center
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    align?: Alignment;
}
/**
 * Defines the value of the custom property..
 *
 * @typedef { Object | undefined } CustomProperty
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare type CustomProperty = Object | undefined;
export declare interface CommonMethod {
    /**
     * Sets the width of the component or its horizontal layout policy. By default, the
     * component uses the width required for its content. If the width of the component is
     * greater than that of the parent container, the component will be drawn beyond the
     * parent container scope.
     *
     * @param { Length | LayoutPolicy } widthValue
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default width(widthValue: Length | LayoutPolicy | undefined): this;
    /**
     * Sets the height of the component or its vertical layout policy. By default, the
     * component uses the height required for its content. If the height of the component
     * is greater than that of the parent container, the component will be drawn beyond
     * the parent container scope.
     *
     * @param { Length | LayoutPolicy } heightValue
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default height(heightValue: Length | LayoutPolicy | undefined): this;
    /**
     * Sets the drawModifier of the current component.
     *
     * @param { DrawModifier | undefined } modifier - drawModifier used to draw, or undefined if it is not available.
     * Default value: undefined
     * A custom modifier applies only to the FrameNode of the currently bound component, not to its subnodes.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default drawModifier(modifier: DrawModifier | undefined): this;
    /**
     * Sets the custom property of the current component.
     * This API does not work for custom components.
     *
     * @param { string } name - the name of the custom property.
     * @param { CustomProperty } value - the value of the custom property.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default customProperty(name: string, value: CustomProperty): this;
    /**
     * Sets the safe area to be expanded to.
     * <br>default:{types: [SafeAreaType.SYSTEM, SafeAreaType.CUTOUT, SafeAreaType.KEYBOARD],
     * edges: [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM, SafeAreaEdge.START, SafeAreaEdge.END]}
     *
     * @param { Array<SafeAreaType> } types - Indicates the types of the safe area.
     * @param { Array<SafeAreaEdge> } edges - Indicates the edges of the safe area.
     * @returns { T } The component instance.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default expandSafeArea(types?: Array<SafeAreaType> | undefined, edges?: Array<SafeAreaEdge> | undefined): this;
    /**
     * Sets the response region of the current component.
     *
     * @param { Array<Rectangle> | Rectangle } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default responseRegion(value: Array<Rectangle> | Rectangle | undefined): this;
    /**
     * Sets the mouse response region of current component
     *
     * @param { Array<Rectangle> | Rectangle } value
     * @returns { T } return the component attribute
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default mouseResponseRegion(value: Array<Rectangle> | Rectangle | undefined): this;
    /**
     * Sets the size of the component.
     *
     * @param { SizeOptions } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default size(value: SizeOptions | undefined): this;
    /**
     * Sets the constraint size of the component, which is used to limit the size range during component layout.
     * Default value: **{minWidth: 0, maxWidth: Infinity, minHeight: 0, maxHeight: Infinity}**.
     *
     * @param { ConstraintSizeOptions } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default constraintSize(value: ConstraintSizeOptions | undefined): this;
    /**
     * Sets how the component behaves during hit testing.
     *
     * @param { HitTestMode } value - the hit test mode.
     * @default HitTestMode.default - Both the node and its child nodes respond to the hit test of a touch event,
     * but its sibling nodes are blocked from the hit test. The hit test for ancestor nodes is not affected.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default hitTestBehavior(value: HitTestMode | undefined): this;
    /**
     * Called to specify how to perform the touch test on the children of this component.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onChildTouchTest(event: ((value: Array<TouchTestInfo>) => TouchResult) | undefined): this;
    /**
     * Sets the weight of the component during layout. A component with this attribute is allocated space
     * along the main axis of its parent container (Row, Column, or Flex) based on its specified weight.
     * Default value: **0**.
     *
     * @param { number | string } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default layoutWeight(value: number | string | undefined): this;
    /**
     * Sets the weight of the component in a chain, which is used to re-lay out components that form the chain.
     * <br>This API has effect only when the parent container is RelativeContainer.
     *
     * @param { ChainWeightOptions } chainWeight
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default chainWeight(chainWeight: ChainWeightOptions | undefined): this;
    /**
     * Sets the padding of the component.
     * Default value: **0**.
     *
     * @param { Padding | Length | LocalizedPadding } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default padding(value: Padding | Length | LocalizedPadding | undefined): this;
    /**
     * Sets the safe area padding. It enables a container to add a component-level
     * safe area for child components to expand into.
     * Default value: **LengthMetrics.vp(0)**
     *
     * @param { Padding | LengthMetrics | LocalizedPadding } paddingValue - Indicates safeArea padding values
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default safeAreaPadding(paddingValue: Padding | LengthMetrics | LocalizedPadding | undefined): this;
    /**
     * Sets the margin of the component.
     * Default value: **0**.
     *
     * @param { Margin | Length | LocalizedMargin } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default margin(value: Margin | Length | LocalizedMargin | undefined): this;
    /**
     * Background.
     *
     * @param { CustomBuilder } builder
     * @param { BackgroundOptions } options
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default background(builder: CustomBuilder | undefined, options?: BackgroundOptions | undefined): this;
    /**
     * Background color
     *
     * @param { ResourceColor } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default backgroundColor(value: ResourceColor | undefined): this;
    /**
     * Sets the pixel rounding policy for the current component in the specified direction.
     * <br>If a direction is not set, the pixels are rounded to the nearest whole number in that direction.
     *
     * @param { PixelRoundPolicy } value - indicates the rounding policy for the bounds of the component.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default pixelRound(value: PixelRoundPolicy | undefined): this;
    /**
     * Background image
     * src: Image address url
     *
     * @param { ResourceStr | PixelMap } src
     * @param { ImageRepeat } repeat
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default backgroundImage(src: ResourceStr | PixelMap | undefined, repeat?: ImageRepeat | undefined): this;
    /**
     * Background image
     *
     * @param { ResourceStr | PixelMap } src - the background image source
     * @param { BackgroundImageOptions } options - config the options
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default backgroundImage(src: ResourceStr | PixelMap | undefined, options?: BackgroundImageOptions | undefined): this;
    /**
     * Background image size
     *
     * @param { SizeOptions | ImageSize } value - The width and height of the background image.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default backgroundImageSize(value: SizeOptions | ImageSize | undefined): this;
    /**
     * Background image position
     * x:Horizontal coordinate;y:Vertical axis coordinate.
     *
     * @param { Position | Alignment } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default backgroundImagePosition(value: Position | Alignment | undefined): this;
    /**
     * Defines the blur style to apply between the background and content of a component.
     * It encapsulates various blur radius, mask color, mask opacity, saturation.
     * And brightness values through enum values.
     *
     * @param { BlurStyle } value - Settings of the background blur style
     * <br>including the blur radius, mask color, mask opacity, saturation, and brightness.
     * @param { BackgroundBlurStyleOptions } options - Background blur options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default backgroundBlurStyle(value: BlurStyle | undefined, options?: BackgroundBlurStyleOptions | undefined): this;
    /**
     * Background blur style.
     * blurStyle:Blur style type.
     * sysOptions: system adaptive options.
     *
     * @param { Optional<BlurStyle> } style
     * @param { BackgroundBlurStyleOptions } [options]
     * @param { SystemAdaptiveOptions } [sysOptions]
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default backgroundBlurStyle(style: BlurStyle | undefined, options?: BackgroundBlurStyleOptions | undefined, sysOptions?: SystemAdaptiveOptions | undefined): this;
    /**
     * Sets the background effect of the component, including the blur radius, brightness, saturation, and color.
     *
     * @param { BackgroundEffectOptions } options - Background effect, including saturation, brightness, and color.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default backgroundEffect(options: BackgroundEffectOptions | undefined): this;
    /**
     * options:background effect options.
     * sysOptions: system adaptive options.
     *
     * @param { Optional<BackgroundEffectOptions> } options - options indicates the effect options.
     * @param { SystemAdaptiveOptions } [ sysOptions ] - system adaptive options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default backgroundEffect(options: BackgroundEffectOptions | undefined, sysOptions?: SystemAdaptiveOptions | undefined): this;
    /**
     * Background image resizable.
     * value:resizable options
     *
     * @param { ResizableOptions } value - Indicates the resizable options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default backgroundImageResizable(value: ResizableOptions | undefined): this;
    /**
     * Foreground effect.
     *
     * @param { ForegroundEffectOptions } options - options indicates the effect options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default foregroundEffect(options: ForegroundEffectOptions | undefined): this;
    /**
     * Sets a visual effect that is not a filter effect.
     *
     * @param { VisualEffect } effect - Visual effect parameters.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default visualEffect(effect: VisualEffect | undefined): this;
    /**
     * Sets the visual effect of the background filter.
     *
     * @param { Filter } filter - Filter effect parameters.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default backgroundFilter(filter: Filter | undefined): this;
    /**
     * Sets the visual effect of the foreground (content) filter.
     *
     * @param { Filter } filter - Filter effect parameters.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default foregroundFilter(filter: Filter | undefined): this;
    /**
     * Sets the visual effect of the compositing filter.
     *
     * @param { Filter } filter - Filter effect parameters.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default compositingFilter(filter: Filter | undefined): this;
    /**
     * Applies a foreground blur style to the component.
     *
     * @param { BlurStyle } value - Settings of the foreground blur style.
     * @param { ForegroundBlurStyleOptions } options - Foreground blur options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default foregroundBlurStyle(value: BlurStyle | undefined, options?: ForegroundBlurStyleOptions | undefined): this;
    /**
     * Foreground blur style.
     * blurStyle:Blur style type.
     * sysOptions: system adaptive options.
     *
     * @param { Optional<BlurStyle> } style
     * @param { ForegroundBlurStyleOptions } [options]
     * @param { SystemAdaptiveOptions } [sysOptions]
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default foregroundBlurStyle(style: BlurStyle | undefined, options?: ForegroundBlurStyleOptions | undefined, sysOptions?: SystemAdaptiveOptions | undefined): this;
    /**
     * Sets the opacity of the component.
     *
     * @param { number | Resource } value - Opacity of the component. The value ranges from 0 to 1.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default opacity(value: number | Resource | undefined): this;
    /**
     * Sets the border.
     *
     * @param { BorderOptions } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default border(value: BorderOptions | undefined): this;
    /**
     * Sets the border style.
     * Default value: **BorderStyle.Solid**.
     *
     * @param { BorderStyle | EdgeStyles } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default borderStyle(value: BorderStyle | EdgeStyles | undefined): this;
    /**
     * Sets the border width.
     * Percentage values are not supported.
     *
     * @param { Length | EdgeWidths | LocalizedEdgeWidths } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default borderWidth(value: Length | EdgeWidths | LocalizedEdgeWidths | undefined): this;
    /**
     * Sets the border color.
     * Default value: **Color.Black**.
     * @param { ResourceColor | EdgeColors | LocalizedEdgeColors } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default borderColor(value: ResourceColor | EdgeColors | LocalizedEdgeColors | undefined): this;
    /**
     * Sets the radius of the border rounded corners.
     * <br>The radius is restricted by the component size. The maximum value is half of the component width or height.
     *
     * @param { Length | BorderRadiuses | LocalizedBorderRadiuses } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default borderRadius(value: Length | BorderRadiuses | LocalizedBorderRadiuses | undefined): this;
    /**
     * Sets the border image of the component.
     *
     * @param { BorderImageOption } value - Border image or border gradient.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default borderImage(value: BorderImageOption | undefined): this;
    /**
     * Sets the outline attributes in one declaration.
     *
     * @param { OutlineOptions } value - Outline attributes.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default outline(value: OutlineOptions | undefined): this;
    /**
     * Sets the style of the outline.
     *
     * @param { OutlineStyle | EdgeOutlineStyles } value - Outline style.
     * <br>Default value: **OutlineStyle.SOLID**.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default outlineStyle(value: OutlineStyle | EdgeOutlineStyles | undefined): this;
    /**
     * Sets the thickness of the outline.
     *
     * @param { Dimension | EdgeOutlineWidths } value - Outline thickness. Percentage values are not supported.
     * <br>Default value: **0**Outline thickness. Percentage values are not supported.
     * <br>Default value: **0**.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default outlineWidth(value: Dimension | EdgeOutlineWidths | undefined): this;
    /**
     * Sets the color of the outline.
     *
     * @param { ResourceColor | EdgeColors | LocalizedEdgeColors } value - Outline color.
     * <br>Default value: **Color.Black**.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default outlineColor(value: ResourceColor | EdgeColors | LocalizedEdgeColors | undefined): this;
    /**
     * Sets the radius of the outline corners.
     *
     * @param { Dimension | OutlineRadiuses } value - adius of the outline corners. Percentage
     * values are not supported.
     * <br>Default value: **0**.
     * <br>Maximum effective value: Component width/2 + outlineWidth or component height/2 + outlineWidth.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default outlineRadius(value: Dimension | OutlineRadiuses | undefined): this;
    /**
     * Sets the foreground color of the component.
     * If the component does not have a foreground color set, it inherits the color from its parent component by default.
     *
     * @param { ResourceColor | ColoringStrategy } value - Foreground color.
     * <br>The value can be a specific color or a coloring strategy. Property animations are supported.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default foregroundColor(value: ResourceColor | ColoringStrategy | undefined): this;
    /**
     * Called when a click event occurs.
     *
     * <p><strong>NOTE</strong>:
     * <br> Since API version 9, the following constraints apply when this API is used in service widgets:
     * <br> Click events cannot be triggered if the finger is pressed for more than 800 ms.
     * <br> Click events cannot be triggered if the finger moves more than 20 px after pressing down.
     * </p>
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default onClick(event: ((event: ClickEvent) => void) | undefined): this;
    /**
     * Trigger a click event when a click is clicked, move distance should smaller than distanceThreshold.
     *
     * <p><strong>NOTE</strong>:
     * <br> If the distanceThreshold value specified is less than or equal to 0 vp, it will be converted to the default value.
     * <br> Since API version 9, the following constraints apply when this API is used in service widgets:
     * <br> Click events cannot be triggered if the finger is pressed for more than 800 ms.
     * <br> Click events cannot be triggered if the finger moves more than 20 px after pressing down.
     * </p>
     * @param { function } event - this function callback executed when the click action is recognized
     * @param { number } distanceThreshold - the distance threshold of finger's movement when detecting a click action
     * @default (2^31-1)vp
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default onClick(event: Callback<ClickEvent> | undefined, distanceThreshold: number | undefined): this;
    /**
     * Trigger a hover event.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onHover(event: ((isHover: boolean, event: HoverEvent) => void) | undefined): this;
    /**
     * Trigger a hover move event.
     *
     * @param { Callback<HoverEvent> } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onHoverMove(event: Callback<HoverEvent> | undefined): this;
    /**
     * Trigger a accessibility hover event.
     *
     * @param { AccessibilityCallback } callback - A callback instance used when the component is touched after accessibility mode is enabled.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onAccessibilityHover(callback: AccessibilityCallback | undefined): this;
    /**
     * Set hover effect.
     *
     * @param { HoverEffect } value - Hover effect of the component in hover state.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default hoverEffect(value: HoverEffect | undefined): this;
    /**
     * Triggered when the component is clicked by a mouse button or the mouse pointer moves on the component.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default onMouse(event: ((event: MouseEvent) => void) | undefined): this;
    /**
     * Invoked when a touch event is triggered.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onTouch(event: ((event: TouchEvent) => void) | undefined): this;
    /**
     * Keyboard input
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onKeyEvent(event: ((event: KeyEvent) => void) | undefined): this;
    /**
     * Keyboard input
     *
     * @param { Callback<KeyEvent, boolean> } event - Callback for handling the key event.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    // default onKeyEvent(event: Callback<KeyEvent, boolean> | undefined): this;
    /**
     * Digital crown input.
     *
     * @param { Callback<CrownEvent> } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default onDigitalCrown(handler: Callback<CrownEvent> | undefined): this;
    /**
     * Handle keyboard events before input method events.
     *
     * @param { Callback<KeyEvent, boolean> } event - Callback for handling the key event.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onKeyPreIme(event: Callback<KeyEvent, boolean> | undefined): this;
    /**
     * Customize the handling and distribution of key events.
     *
     * @param { Callback<KeyEvent, boolean> } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onKeyEventDispatch(event: Callback<KeyEvent, boolean> | undefined): this;
    /**
     * Trigger a FocusAxisEvent.
     *
     * @param { Callback<FocusAxisEvent> } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default onFocusAxisEvent(event: Callback<FocusAxisEvent> | undefined): this;
    /**
     * Handle axis events.
     *
     * @param { Callback<AxisEvent> } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default onAxisEvent(event: Callback<AxisEvent> | undefined): this;
    /**
     * Set focusable.
     * Components that have default interaction logic, such as Button and TextInput, are focusable by default. Other
     * components, such as Text and Image, are not focusable by default. Only focusable components can trigger a focus
     * event.
     *
     * @param { boolean } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default focusable(value: boolean | undefined): this;
    /**
     * Set nextFocus.
     *
     * @param { FocusMovement } nextStep
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default nextFocus(nextStep: FocusMovement | undefined): this;
    /**
     * Set TabStop on component focus
     *
     * @param { boolean } isTabStop
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default tabStop(isTabStop: boolean | undefined): this;
    /**
     * Trigger a event when got focus.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onFocus(event: (() => void) | undefined): this;
    /**
     * Triggered when the current component loses focus.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onBlur(event: (() => void) | undefined): this;
    /**
     * Set focus index by key tab.
     * The tabIndex and focusScopeId cannot be used together.
     * @param { number } index
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default tabIndex(index: number | undefined): this;
    /**
     * Set default focused component when a page create.
     *
     * @param { boolean } value - True means to set the component as the default focus, and the value false has no effect.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default defaultFocus(value: boolean | undefined): this;
    /**
     * Set default focused component when focus on a focus group.
     *
     * @param { boolean } value - True means the component is the default focus of the parent container, and
     * false means the component is not the default focus of the parent container.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default groupDefaultFocus(value: boolean | undefined): this;
    /**
     * Set a component focused when the component be touched.
     *
     * @param { boolean } value - True means the component is focusable on touch, false means the component is not focusable on touch.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default focusOnTouch(value: boolean | undefined): this;
    /**
     * Set the component's focusBox style.
     *
     * @param { FocusBoxStyle } style - Component's focusBox style.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default focusBox(style: FocusBoxStyle | undefined): this;
    /**
    * Set container as a focus group with a specific identifier.
    *
    * @param { string } id - focus scope identifier.
    * @param { boolean } [isGroup] - whether this scope is a focus group, the default value is false
    * @returns { T }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    default focusScopeId(id: string | undefined, isGroup?: boolean | undefined): this;
    /**
    * Set container as a focus group with a specific identifier.
    *
    * @param { string } id - focus scope identifier.
    * @param { boolean } [isGroup] - whether this scope is a focus group, the default value is false.
    * @param { boolean } [arrowStepOut] - whether the arrow keys can move focus from inside the focus group to outside,
    * only effective when isGroup is true, the default value is true.
    * @returns { T }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    default focusScopeId(id: string | undefined, isGroup?: boolean | undefined, arrowStepOut?: boolean | undefined): this;
    /**
    * Set the focus priority of component in a specific focus scope.
    *
    * @param { string } scopeId
    * @param { FocusPriority } [priority] - the default value is AUTO
    * @returns { T }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    default focusScopePriority(scopeId: string | undefined, priority?: FocusPriority | undefined): this;
    /**
     * animation
     *
     * @param { AnimateParam } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default animation(value: AnimateParam | undefined): this;
    /**
     * Set the transition effect of component when it appears and disappears.
     *
     * @param { TransitionEffect } value - transition effect
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default transition(value: TransitionEffect | undefined): this;
    /**
     * Set the transition effect of component when it appears and disappears.
     *
     * @param { TransitionEffect } effect - transition effect
     * @param { Optional<TransitionFinishCallback> } onFinish - transition finish callback.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default transition(effect: TransitionEffect | undefined, onFinish: TransitionFinishCallback | undefined): this;
    /**
     * Bind gesture recognition.
     * gesture:Bound Gesture Type,mask:GestureMask;
     *
     * @param { GestureType } gesture
     * @param { GestureMask } mask
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default gesture(gesture: GestureType | undefined, mask?: GestureMask | undefined): this;
    /**
     * Binding Preferential Recognition Gestures
     * gesture:Bound Gesture Type,mask:GestureMask;
     *
     * @param { GestureType } gesture
     * @param { GestureMask } mask
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default priorityGesture(gesture: GestureType | undefined, mask?: GestureMask | undefined): this;
    /**
     * Binding gestures that can be triggered simultaneously with internal component gestures
     * gesture:Bound Gesture Type,mask:GestureMask;
     *
     * @param { GestureType } gesture
     * @param { GestureMask } mask
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default parallelGesture(gesture: GestureType | undefined, mask?: GestureMask | undefined): this;
    /**
     * Adds the content blurring effect for the current component. The input parameter is the blurring radius.
     * The larger the blurring radius, the more blurring the content.
     * If the value is 0, the content blurring effect is not blurring.
     *
     * @param { number } value - value indicates radius of backdrop blur.
     * @param { BlurOptions } [options] - options indicates blur options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default blur(value: number | undefined, options?: BlurOptions | undefined): this;
    /**
     * Adds the content blurring effect for the current component. The input parameter is the blurring radius.
     * The larger the blurring radius, the more blurring the content.
     * If the value is 0, the content blurring effect is not blurring.
     *
     * @param { Optional<number> } blurRadius - value indicates radius of backdrop blur.
     * @param { BlurOptions } [options] - options indicates blur options.
     * @param { SystemAdaptiveOptions } [sysOptions] - system adaptive options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default blur(blurRadius: number | undefined, options?: BlurOptions | undefined, sysOptions?: SystemAdaptiveOptions | undefined): this;
    /**
     * Applies a linear gradient foreground blur effect to the component.
     *
     * @param { number } value - the blurring radius.
     * The larger the blurring radius, the more blurring the content, and if the value is 0, the content blurring effect is not blurring.
     * @param { LinearGradientBlurOptions } options - the linear gradient blur options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default linearGradientBlur(value: number | undefined, options: LinearGradientBlurOptions | undefined): this;
    /**
     * Apply a motion blur effect to the component being scaled or moved.
     * 1.Do not use this API in intra-component transitions, shared element transitions,
     * implicit element transitions, or particle animations. Doing so may cause unexpected results.
     * 2.The **radius** parameter of **motionBlur** must be set to **0** for the initial state.
     * Otherwise, there may be unexpected results during a cold start.
     * 3.This API must be used together with the **onFinish** parameter of **AnimateParam**.
     * Its **radius** parameter must be set to **0** when the animation ends; otherwise, there may be unexpected results.
     * 4.When using this API, do not frequently change the blur radius of the same component;
     * otherwise, there may be unexpected results.
     * For example, if you frequently click the image in the example, the blur effect may not work sometimes.
     * 5.To avoid unexpected results, make sure the coordinates of
     * the motion blur anchor point are the same as those of the animation scaling anchor point.
     * 6.To avoid unexpected results, set the blur radius to a value less than 1.
     *
     * @param { MotionBlurOptions } value - Motion blur options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default motionBlur(value: MotionBlurOptions | undefined): this;
    /**
     * Applies a brightness effect to the component.
     *
     * @param { number } value - Brightness of the component. The value **1** indicates no effects.
     * The value **0** indicates the complete darkness. If the value is less than **1**, the brightness
     * decreases. If the value is greater than **1**, the brightness increases. A larger value indicates
     * a higher brightness. A brightness of 2 turns the component completely white.
     * <br>Default value: **1.0**<br>Recommended value range: [0, 2].
     * <br>**NOTE**
     * <br>A value less than 0 evaluates to the value **0**.
     * <br>**Widget capability**: This API can be used in ArkTS widgets since API version 9.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default brightness(value: number | undefined): this;
    /**
     * Applies a contrast effect to the component.
     *
     * @param { number } value - Contrast of the component. The input parameter is a
     * contrast value. If the value is **1**, the source image is displayed. If the
     * value is greater than 1, a larger value indicates a higher contrast and a clearer
     * image. If the value is less than 1, a smaller value indicates a lower contrast is.
     * If the value is **0**, the image becomes all gray. The unit is percentage.
     * <br>Default value: **1.0**.
     * <br>Recommended value range: [0, 10).
     * <br>**NOTE**
     * <br>A value less than 0 evaluates to the value **0**.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default contrast(value: number | undefined): this;
    /**
     * Applies a grayscale effect to the component.
     *
     * @param { number } value - Grayscale conversion ratio of the component.
     * <br>If the value is **1.0**, the component is completely converted to grayscale.
     * <br>If the value is **0.0**, the component remains unchanged. Between **0** and **1**,
     * <br>the value applies a linear multiplier on the grayscale effect. The unit is percentage.
     * <br>Default value: **0.0**.
     * <br>Value range: [0.0, 1.0].
     * <p>**NOTE**:
     * <br>A value less than **0.0** evaluates to the value **0.0**.
     * <br>A value greater than **1.0** evaluates to the value **1.0**.
     * </p>
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default grayscale(value: number | undefined): this;
    /**
     * Applies a color blend effect to the component.
     *
     * @param { Color | string | Resource } value - Color to blend with the component.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default colorBlend(value: Color | string | Resource | undefined): this;
    /**
     * Applies a saturation effect to the component.
     *
     * @param { number } value - Saturation of the component. The saturation is the ratio of the
     * chromatic component to the achromatic component (gray) in a color. If the value is **1**,
     * the original image is displayed. If the value is greater than **1**, a higher percentage of
     * the chromatic component indicates a higher saturation. If the value is less than **1**, a higher
     * percentage of the achromatic component indicates a lower saturation. The unit is percentage.
     * <br>Default value: **1.0**.
     * <br>Recommended value range: [0, 50).
     * <br>**NOTE**
     * <br>A value less than 0 evaluates to the value **0**.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default saturate(value: number | undefined): this;
    /**
     * Sepia conversion ratio of the component.
     *
     * @param { number } value - Sepia conversion ratio of the component. If the value is **1**, the image
     * is completely sepia. If the value is **0**, the component remains unchanged. The unit is percentage.
     * <br> Value range: [0, +∞).
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default sepia(value: number | undefined): this;
    /**
     * Invert the input image. Value defines the scale of the conversion. 100% of the value is a complete reversal.
     * A value of 0% does not change the image. (Percentage)
     *
     * @param { number | InvertOptions } value - value indicates the scale of the conversion or the options of invert.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default invert(value: number | InvertOptions | undefined): this;
    /**
     * Applies a system bar effect to the component, which means to invert colors based on the background and add a blur.
     *
     * @returns { T } return the component attribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default systemBarEffect(): this;
    /**
     * Rotates the hue of the component.
     *
     * @param { number | string } value - Hue rotation angle of the component.
     * <br>A rotation of 360 degrees leaves the color unchanged.
     * <br>A rotation of 180 degrees and then -180 degrees also leaves the color unchanged.
     * <br>When the data type is number, the value **90** is equivalent to **'90deg'**.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default hueRotate(value: number | string | undefined): this;
    /**
     * Sets whether to draw shadows of child nodes in the component at the same layer,
     * so that the shadows of elements at the same layer overlap.
     *
     * @param { boolean } value - Whether to draw shadows of child nodes in the component
     * at the same layer, so that the shadows of elements at the same layer overlap.
     * <br>Default value: **false**.
     * <br>**NOTE**
     * <br>1. When this feature is disabled (default), if the shadow radius of a child node
     * is large, the shadows of the child nodes may overlap. This overlap issue does not occur
     * when the feature is enabled.
     * <br>2. Avoid nesting **useShadowBatching**. When used in nested mode, **useShadowBatching**
     * takes effect for the current child node only and cannot be recursively used.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default useShadowBatching(value: boolean | undefined): this;
    /**
    * Specifies whether to apply the effect defined by <!--Del-->the parent
    * [EffectComponent](ts-container-effectcomponent-sys.md) or <!--DelEnd-->the window.
    *
    * @param { Optional<boolean> } useEffect - Whether to apply the effect defined by <!--Del-->the parent
    * **EffectComponent** or <!--DelEnd-->the window.
    * <br>The value **true** means to apply the effect defined by <!--Del-->the parent **EffectComponent**
    * or <!--DelEnd-->the window.
    * <br>Default value: **false**.
    * @param { EffectType } [effectType] - Type of effect to apply to the component, which is defined by
    * <!--Del-->the parent **EffectComponent** or <!--DelEnd-->the window.
    * <br>Default value: **EffectType.DEFAULT**.
    * @returns { T } return the component attribute.
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @atomicservice
    * @since 20
    */
    default useEffect(useEffect: boolean | undefined, effectType: EffectType | undefined): this;
    /**
     * Specifies whether to combine the drawing of special effects, such as background blur.
     *
     * @param { boolean } value - Whether the component inherits the special effect settings of the
     * **EffectComponent** component.<br>The value **true** means that the component inherits the
     * special effect settings of the **EffectComponent** component, and **false** means the opposite.
     * <br>Default value: **false**.
     * @returns { T } return the component attribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default useEffect(value: boolean | undefined): this;
    /**
     * Applies a background blur effect to the component. You can customize the blur radius and grayscale parameters.
     *
     * @param { number } value - Background blur effect to apply to the component.
     * <br>The input parameter is the blur radius. The larger the radius is, the more blurred the background is.
     * <br>If the value is **0**, the background is not blurred.
     * @param { BlurOptions } [options] - Grayscale parameters.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default backdropBlur(value: number | undefined, options?: BlurOptions | undefined): this;
    /**
     * Adds the background blur effect for the current component. The input parameter is the blur radius.
     * The larger the blur radius, the more blurred the background. If the value is 0, the background blur is not blurred.
     *
     * @param { Optional<number> } radius - radius indicates radius of backdrop blur.
     * @param { BlurOptions } [options] - options indicates the backdrop blur options.
     * @param { SystemAdaptiveOptions } [sysOptions] - system adaptive options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default backdropBlur(radius: number | undefined, options?: BlurOptions | undefined, sysOptions?: SystemAdaptiveOptions | undefined): this;
    /**
     * Sets whether the component and its child components are rendered off
     * the screen as a whole before being blended with its parent.
     *
     * @param { boolean } value - Whether the component and its child components are rendered
     * off the screen as a whole before being blended with its parent. If the opacity of the
     * component is not 1, the drawing effect may vary depending on the value.
     * <br>Default value: **false**.
     * <br> The value **true** means the component and its child components are rendered off
     * the screen as a whole, and **false** means the opposite.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default renderGroup(value: boolean | undefined): this;
    /**
     * Sets whether to freeze the component. When frozen, the component and its children are cached for
     * repeated drawing after offscreen rendering, without updating internal attributes.
     *
     * @param { boolean } value - Whether to freeze the component. When frozen, the component and its children
     * are cached for repeated drawing after offscreen rendering, without updating internal attributes. If the
     * opacity of the component is not 1, the drawing effect may vary depending on the value.
     * <br>Default value: **false**.
     * <br> **true**: Freeze the component.
     * <br>**false**: Do not freeze the component.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default freeze(value: boolean | undefined): this;
    /**
     * Sets the translation effect for page transitions.
     *
     * @param { TranslateOptions } value - Translation effect for page transitions
     * <br>specifying the start value for entrance and the end value for exit. default:{x:0,y:0,z:0}
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default translate(value: TranslateOptions | undefined): this;
    /**
     * Scales the component.
     *
     * @param { ScaleOptions } value - Scale ratio along the x-, y-, and z-axis. The default value is **1**.
     * <br>**centerX** and **centerY** are used to set the scale center point.
     * <br>default:{x:1,y:1,z:1,centerX:'50%',centerY:'50%'}
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default scale(value: ScaleOptions | undefined): this;
    /**
     * Set component rotation.
     *
     * @param { RotateOptions } value default:{x:0,y:0,z:0,centerX:'50%',centerY:'50%',centerZ:0,perspective:0}
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default rotate(value: RotateOptions | undefined): this;
    /**
     * Sets the transformation matrix of the component.
     *
     * @param { object } value - Transformation matrix of the component.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default transform(value: object | undefined): this;
    /**
     * This callback is triggered when a component mounts a display.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default onAppear(event: (() => void) | undefined): this;
    /**
     * This callback is triggered when component uninstallation disappears.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default onDisAppear(event: (() => void) | undefined): this;
    /**
     * This callback is triggered when a component mounts to view tree.
     *
     * @param { VoidCallback } callback
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onAttach(callback: VoidCallback | undefined): this;
    /**
     * This callback is triggered when a component is detached from view tree.
     *
     * @param { VoidCallback } callback
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onDetach(callback: VoidCallback | undefined): this;
    /**
     * This callback is triggered when the size or position of this component change finished.
     *
     * @param { function } event - event callback.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onAreaChange(event: ((oldValue: Area, newValue: Area) => void) | undefined): this;
    /**
     * Controls the display or hide of the current component.
     *
     * @param { Visibility } value - Whether the component is visible.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default visibility(value: Visibility | undefined): this;
    /**
     * Sets the percentage of the parent container's remaining space that is allocated to the component.
     * Default value: **0**.
     *
     * @param { number } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default flexGrow(value: number | undefined): this;
    /**
     * Sets the percentage of the parent container's shrink size that is allocated to the component.
     * Default value: 0 when the parent container is Column or Row, 1 when the parent container is Flex..
     *
     * @param { number } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default flexShrink(value: number | undefined): this;
    /**
     * Sets the base size of the component in the main axis of the parent container.
     * Default value: **'auto'**.
     *
     * @param { number | string } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default flexBasis(value: number | string | undefined): this;
    /**
     * Sets the alignment mode of the child components along the cross axis of the parent container.
     * Default value: **ItemAlign.Auto**.
     *
     * @param { ItemAlign } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default alignSelf(value: ItemAlign | undefined): this;
    /**
     * Sets the display priority for the component in the layout container.
     * <br>This parameter is only effective in Row, Column, and Flex (single-line) container components.
     *
     * @param { number } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default displayPriority(value: number | undefined): this;
    /**
     * The sibling components in the same container are hierarchically displayed. A larger value of z indicates a higher display level.
     *
     * @param { number } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default zIndex(value: number | undefined): this;
    /**
     * If the components of the two pages are configured with the same ID.
     * The shared element transition is performed during transition.
     * If the parameter is set to an empty string, the shared element transition does not occur.
     * For details about the options parameter, see the options parameter description.
     *
     * @param { string } id - Transition of the shared element.
     * <br>If the same **id** value is configured for a component on the two pages,
     * <br>this component is considered as a shared element of the pages.
     * <br>If the **id** value is an empty string, no transition will be applied to the component.
     * @param { sharedTransitionOptions } options - Parameters of the shared element transition animation.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default sharedTransition(id: string | undefined, options?: sharedTransitionOptions | undefined): this;
    /**
     * Sets how elements are laid out along the main axis of the container.
     * Default value: **Direction.Auto**.
     *
     * @param { Direction } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default direction(value: Direction | undefined): this;
    /**
     * Sets the alignment mode of the component content in the drawing area.
     * Default value: **Alignment.Center**.
     *
     * @param { Alignment } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default align(value: Alignment | undefined): this;
    /**
     * Sets the absolute position of the component relative to the position of the parent component.
     * <br>The attribute is not available for a layout container whose width and height are zero.
     *
     * @param { Position | Edges | LocalizedEdges } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default position(value: Position | Edges | LocalizedEdges | undefined): this;
    /**
     * Sets the anchor for locating the component, which is used to move the component
     * further away from the position specified by position or offset.
     *
     * @param { Position | LocalizedPosition} value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default markAnchor(value: Position | LocalizedPosition | undefined): this;
    /**
     * Sets the offset of the component relative to its original position.
     * <br>The offset attribute does not affect the layout of the parent container.
     * It adjusts the component position only during drawing.
     *
     * @param { Position | Edges | LocalizedEdges } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default offset(value: Position | Edges | LocalizedEdges | undefined): this;
    /**
     * If the value is true, the component is available and can respond to operations such as clicking.
     * If it is set to false, click operations are not responded.
     *
     * @param { boolean } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default enabled(value: boolean | undefined): this;
    /**
     * Sets the alignment rules in the relative container.
     * This API is valid only when the container is RelativeContainer.
     *
     * @param { AlignRuleOption } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default alignRulesWithAlignRuleOptionTypedValue(value: AlignRuleOption | undefined): this;
    /**
     * Sets the alignment rules in the relative container.
     * <br>This API is valid only when the container is RelativeContainer.
     * <br>This API takes the right-to-left scripts into account, using start and end instead of
     * left and right for alignment in the horizontal direction. Prioritize this API in aligning
     * child components in the relative container.
     *
     * @param { LocalizedAlignRuleOptions } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default alignRulesWithLocalizedAlignRuleOptionsTypedValue(value: LocalizedAlignRuleOptions | undefined): this;
    overload alignRules { alignRulesWithAlignRuleOptionTypedValue, alignRulesWithLocalizedAlignRuleOptionsTypedValue }
    /**
     * Sets the parameters of the chain in which the component is the head.
     * <br>This parameter has effect only when the parent container is RelativeContainer.
     * <br>The chain head is the first component in the chain that satisfies the chain formation rules.
     * In a horizontal layout, it starts from the left (or from the right in a mirrored language
     * layout). In a vertical layout, it starts from the top.
     *
     * @param { Axis } direction - indicates direction of the chain
     * @param { ChainStyle } style - indicates style of the chain
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default chainMode(direction: Axis | undefined, style: ChainStyle | undefined): this;
    /**
     * Sets the aspect ratio of the component, which can be obtained using the following formula: width/height.
     * <br>If only width and aspectRatio are set, the height is calculated using the following formula: width/aspectRatio.
     * <br>If only height and aspectRatio are set, the width is calculated using the following formula: height x aspectRatio.
     * <br>If width, height, and aspectRatio are all set, the explicitly set height is ignored, and the effective height is
     * calculated using the following formula: width/aspectRatio.
     * <br>This parameter takes effect only when a valid value greater than 0 is specified.
     *
     * @param { number } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default aspectRatio(value: number | undefined): this;
    /**
     * The click effect level and scale number.
     *
     * @param { ClickEffect | null } value
     * @returns { T } return the component attribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default clickEffect(value: ClickEffect | null | undefined): this;
    /**
     * After a listener is bound, the component can be dragged. After the drag occurs, a callback is triggered.
     * (To be triggered, press and hold for 170 milliseconds (ms))
     *
     * <strong>NOTE</strong>:<br>
     * The global builder is not supported.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onDragStart(event: ((event: DragEvent, extraParams?: string) => CustomBuilder | DragItemInfo) | undefined): this;
    /**
     * After binding, a callback is triggered when the component is dragged to the range of the component.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onDragEnter(event: ((event: DragEvent, extraParams?: string) => void) | undefined): this;
    /**
     * After binding, a callback is triggered when the drag moves within the range of a placeable component.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onDragMove(event: ((event: DragEvent, extraParams?: string) => void) | undefined): this;
    /**
     * After binding, a callback is triggered when the component is dragged out of the component range.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onDragLeave(event: ((event: DragEvent, extraParams?: string) => void) | undefined): this;
    /**
     * The component bound to this event can be used as the drag release target.
     * This callback is triggered when the drag behavior is stopped within the scope of the component.
     *
     * @param { function } event
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onDrop(event: ((event: DragEvent, extraParams?: string) => void) | undefined): this;
    /**
     * The component bound to this event can be used as the drag release target.
     * This callback is triggered when the drag behavior is stopped within the scope of the component.
     *
     * @param { OnDragEventCallback } eventCallback - event callback.
     * @param { DropOptions } [dropOptions] - the drop handling options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onDrop(eventCallback: OnDragEventCallback | undefined, dropOptions?: DropOptions | undefined): this;
    /**
     * This function is called when the drag event is end.
     *
     * @param { function } event - indicates the function to be called.
     * @returns { T } property value of type T.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onDragEnd(event: ((event: DragEvent, extraParams?: string) => void) | undefined): this;
    /**
     * Allowed drop uniformData type for this node.
     *
     * @param { Array<UniformDataType> | null } value - the uniformData type for this node.
     * @returns { T } property value of type T.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default allowDrop(value: Array<UniformDataType> | null | undefined): this;
    /**
     * Enable the selectable area can be dragged.
     *
     * @param { boolean } value - true means the area can be dragged, false means the area can't be dragged.
     * The default value is false.
     * @returns { T } property value of type T.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default draggable(value: boolean | undefined): this;
    /**
     * Set preview of the component for dragging process
     *
     * @param { CustomBuilder | DragItemInfo | string } value - preview of the component for dragging process
     * @returns { T } property value of type T.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default dragPreview(value: CustomBuilder | DragItemInfo | string | undefined): this;
    /**
     * Set preview of the component for dragging process
     *
     * @param { CustomBuilder | DragItemInfo | string } preview - preview of the component for dragging process
     * @param { PreviewConfiguration } config - drag preview configuration.
     * @returns { T } property value of type T.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default dragPreview(preview: CustomBuilder | DragItemInfo | string | undefined, config?: PreviewConfiguration | undefined): this;
    /**
     * Set the selectable area drag preview options.
     *
     * @param { DragPreviewOptions } value - preview options value.
     * @param { DragInteractionOptions } options - drag interaction options value.
     * @returns { T } property value of type T.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default dragPreviewOptions(value: DragPreviewOptions | undefined, options?: DragInteractionOptions | undefined): this;
    /**
     * After binding, a callback is triggered when the preDrag status change finished.
     *
     * @param { Callback<PreDragStatus> } callback callback - The callback will be triggered when the preDrag status change.
     * @returns { T } property value of type T.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default onPreDrag(callback: Callback<PreDragStatus> | undefined): this;
    /**
     * Add mask text to the current component. The layout is the same as that of the current component.
     *
     * @param { string | CustomBuilder | ComponentContent } value
     * @param { OverlayOptions } options
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default overlay(value: string | CustomBuilder | ComponentContent | undefined, options?: OverlayOptions | undefined): this;
    /**
     * Linear Gradient
     * angle: Angle of Linear Gradient. The default value is 180;
     * direction: Direction of Linear Gradient. The default value is GradientDirection.Bottom;
     * colors: Color description for gradients.
     * repeating: repeating. The default value is false
     *
     * @param { object } value - Linear gradient.
     * <br>If **options** is **undefined**, the linear gradient is disabled.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default linearGradient(value: LinearGradientOptions | undefined): this;
    /**
     * Creates a sweep gradient.
     *
     * @param { SweepGradientOptions } value - Sweep gradient, which can sweep around the specified
     * center point in the 0–360 degree range. If the rotation angle exceeds the range, a monochrome
     * color instead of a gradient will be drawn.<br>- **center**: center of the sweep gradient, that
     * is, the coordinates relative to the upper left corner of the current component.
     * <br>- **start**: start angle of the sweep gradient.
     * <br> Default value: **0**<br>If the angle is specified with a string, only the deg, grad, rad,
     * and turn types are supported.<br>- **end**: end angle of the sweep gradient.
     * <br> Default value: **0**<br>If the angle is specified with a string, only the deg, grad, rad,
     * and turn types are supported.<br>- **rotation**: rotation angle of the sweep gradient.
     * <br> Default value: **0**<br>If the angle is specified with a string, only the deg, grad, rad,
     * and turn types are supported.<br>- colors: array of color stops,
     * each of which consists of a color and its stop position. Invalid colors are automatically skipped.
     * <br>- **repeating**: whether the colors are repeated.
     * <br>  Default value: **false**.
     * <br>**NOTE**
     * <br>A value less than 0 is treated as **0**. A value greater than 360 is treated as **360**.
     * <br>When **start**, **end**, or **rotation** is specified with a string, the string must be a number
     * or a number followed by one of the following units: deg, rad, grad, and turn. Valid value examples
     * are "90", "90deg", and "1.57rad".
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default sweepGradient(value: SweepGradientOptions | undefined): this;
    /**
     * Creates a radial gradient.
     *
     * Anonymous Object Rectification.
     * @param { RadialGradientOptions } value - Radial gradient.
     * <br>- **center**: center of the radial gradient, that is, the coordinates relative
     * to the upper left corner of the current component.
     * <br>- **radius**: radius of the radial gradient.
     * <br> Value range: [0, +∞).
     * <br>**NOTE**
     * <br>A value less than 0 is treated as **0**.
     * <br>- colors: array of color stops, each of which consists
     * of a color and its stop position. Invalid colors are automatically skipped.
     * <br>- **repeating**: whether the colors are repeated.
     * <br>  Default value: **false**.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default radialGradient(value: RadialGradientOptions | undefined): this;
    /**
     * Set the motion path of the component.
     *
     * @param { MotionPathOptions } value - Motion path of the component.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default motionPath(value: MotionPathOptions | undefined): this;
    /**
     * Applies a shadow effect to the component.
     *
     * @param { ShadowOptions | ShadowStyle } value - Shadow of the component.
     * <br>When the value type is **ShadowOptions**, the blur radius, shadow color,
     * and offset along the x-axis and y-axis can be specified.
     * <br>When the value type is **ShadowStyle**, the shadow style can be specified.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default shadow(value: ShadowOptions | ShadowStyle | undefined): this;
    /**
     * Defines how the component's content (including the content of it child components)
     * is blended with the existing content on the canvas (possibly offscreen canvas) below.
     *
     * @param { BlendMode } value - Blend mode.
     * <br>Default value: **BlendMode.NONE**.
     * <br>**NOTE**
     * <br>When **BlendMode.NONE** is used, the blend effect is **BlendMode.SRC_OVER**
     * by default, and **BlendApplyType** does not take effect.
     * @param { BlendApplyType } [type] - Whether the blend mode is implemented offscreen.
     * <br>Default value: **BlendApplyType.FAST**.
     * <br>**NOTE**
     * <br>1. **BlendApplyType.FAST**: The blend mode is not implemented offscreen.
     * <br>2. **BlendApplyType.OFFSCREEN**: An offscreen canvas of the size of the current component
     * is created. The content of the current component (including child components) is then drawn
     * onto the offscreen canvas, and blended with the existing content on the canvas below using
     * the specified blend mode. This approach may cause issues with screen capture for APIs such
     * as linearGradientBlur<sup>12+</sup>, backgroundEffect, and brightness.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default blendMode(value: BlendMode | undefined, type?: BlendApplyType | undefined): this;


    /**
     * Add a blendMode effect to the current component.Cannot be used together with the blendMode interface.
     * 
     * @param { BlendMode | Blender } effect - When the effect type is BlendMode type, define Different hybrid modes.
     * @param { BlendApplyType } [type] - Different blend apply type
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @form
     * @since 20
     */
    default advancedBlendMode(effect: BlendMode | Blender, type?: BlendApplyType): this;
    /**
     * Sets whether to clip the areas of child components that extend beyond this component's boundaries,
     * That is, whether to perform clipping based on the edge contour of the parent container.
     *
     * @param { boolean } value - Whether to perform clipping based on the edge contour of the parent container.
     * <br>Default value: **false**.
     * <br>**true**: Perform clipping. **false**: Do not perform clipping.
     * <br>If this parameter is set to **true**.
     * <br>child components exceeding the current component's bounds will not respond to bound gesture events.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default clip(value: boolean | undefined): this;
    /**
    * Clips this component based on the given shape.
    *
    * @param { CircleShape | EllipseShape | PathShape | RectShape } value - Shape that the component to be clipped into.
    * <br>The clipped area remains responsive to bound gesture events.
    * @returns { T }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @form
    * @atomicservice
    * @since 20
    */
    default clipShape(value: CircleShape | EllipseShape | PathShape | RectShape | undefined): this;
    /**
     * Adds a mask to the component to indicate the progress.
     *
     * @param { ProgressMask } value - Mask to add to the component, which allows for dynamic
     * adjustment of progress, maximum value, and color settings.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default mask(value: ProgressMask | undefined): this;
    /**
     * Adds a mask of the specified shape to the component.
     *
     * @param { CircleShape | EllipseShape | PathShape | RectShape } value - Mask of the specified
     * shape to add to the component.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default maskShape(value: CircleShape | EllipseShape | PathShape | RectShape | undefined): this;
    /**
     * Key. User can set an key to the component to identify it.
     *
     * @param { string } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     * @test
     */
    default key(value: string | undefined): this;
    /**
     * Id. User can set an id to the component to identify it.
     *
     * @param { string } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default id(value: string | undefined): this;
    /**
     * geometryTransition
     *
     * @param { string } id
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default geometryTransition(id: string | undefined): this;
    /**
     * Shared geometry transition
     *
     * @param { string } id - geometry transition id
     * @param { GeometryTransitionOptions } options - Indicates the options of geometry transition.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default geometryTransition(id: string | undefined, options?: GeometryTransitionOptions | undefined): this;
    /**
    * Tips control
    *
    * @param { TipsMessageType } message
    * @param { TipsOptions } [options]
    * @returns { T }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    default bindTips(message: TipsMessageType | undefined, options?: TipsOptions | undefined): this;
    /**
     * Popup control
     * <p><strong>NOTE</strong>:
     * <br>The popup can be displayed only after the entire page is fully constructed. Therefore, to avoid incorrect
     * display positions and shapes, do not set this parameter to true while the page is still being constructed.
     * </p>
     *
     * @param { boolean } show - Whether to show the popup, default is false.
     * @param { PopupOptions | CustomPopupOptions } popup
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default bindPopup(show: boolean | undefined, popup: PopupOptions | CustomPopupOptions | undefined): this;
    /**
     * Menu control
     *
     * @param { Array<MenuElement> | CustomBuilder } content - Indicates the content of menu.
     * @param { MenuOptions } options - Indicates the options of menu.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default bindMenu(content: Array<MenuElement> | CustomBuilder | undefined, options?: MenuOptions | undefined): this;
    /**
     * Menu control
     *
     * @param { boolean } isShow true means display menu, false means hide menu, default is false.
     * @param { Array<MenuElement> | CustomBuilder } content - Indicates the content of menu.
     * @param { MenuOptions } options - Indicates the options of menu.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default bindMenu(isShow: boolean | undefined, content: Array<MenuElement> | CustomBuilder | undefined, options?: MenuOptions | undefined): this;
    /**
     * Binds a context menu to this component, which is displayed when the user long-presses or right-clicks the
     * component. Only custom menu items are supported.
     *
     * @param { CustomBuilder } content - Indicates the content of context menu.
     * @param { ResponseType } responseType - Indicates response type of context menu, Long pressing with a mouse device
     * is not supported.
     * @param { ContextMenuOptions } options - Indicates the options of context menu.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default bindContextMenu(content: CustomBuilder | undefined, responseType: ResponseType | undefined, options?: ContextMenuOptions | undefined): this;
    /**
     * Binds a context menu to the component, whose visibility is subject to the isShown settings.
     *
     * @param { boolean } isShown - true means display content, false means hide content, default is false.
     * <p><strong>NOTE</strong>:
     * <br>The menu can be displayed properly only when the related page has been constructed. If this parameter is set
     * to true before the construction is complete, display issues, such as misplacement, distortion, or failure to pop
     * up, may occur. To trigger dragging by long presses is not supported.
     * </p>
     *
     * @param { CustomBuilder } content - Indicates the content of context menu.
     * @param { ContextMenuOptions } [options] - Indicates the options of context menu.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default bindContextMenu(isShown: boolean | undefined, content: CustomBuilder | undefined, options?: ContextMenuOptions | undefined): this;
    /**
     * Binds a modal page to the component, whose visibility is subject to the isShow settings.
     *
     * @param { boolean | Bindable<boolean>} isShow - true means display content, false means hide content.
     * @param { CustomBuilder } builder - the content to be displayed.
     * @param { ModalTransition } [type] - transition type.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default bindContentCover(isShow: boolean | Bindable<boolean> | undefined, builder: CustomBuilder | undefined, type?: ModalTransition | undefined): this;
    /**
     * Bind content cover
     *
     * @param { boolean | Bindable<boolean> } isShow - true means display content, false means hide content.
     * @param { CustomBuilder } builder - the content to be displayed.
     * @param { ContentCoverOptions } [options] - options of content cover.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default bindContentCover(isShow: boolean | Bindable<boolean> | undefined, builder: CustomBuilder | undefined, options?: ContentCoverOptions | undefined): this;
    /**
     * Bind sheet
     *
     * @param { boolean | Bindable<boolean>} isShow - true means display sheet, false means hide sheet.
     * @param { CustomBuilder } builder - the sheet to be displayed.
     * @param { SheetOptions } [options] - options of sheet.
     * @returns { T } - template type
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default bindSheet(isShow: boolean | Bindable<boolean> | undefined, builder: CustomBuilder | undefined, options?: SheetOptions | undefined): this;
    /**
     * Sets styles for component state.
     *
     * @param { StateStyles } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default stateStyles(value: StateStyles | undefined): this;
    /**
     * id for distribute identification.
     *
     * @param { number } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default restoreId(value: number | undefined): this;
    /**
     * Trigger a visible area change event.
     *
     * @param { Array<number> } ratios - Threshold array. Each threshold represents a ratio of the component's visible area to the component's total area.
     * The value range of the threshold is [0.0, 1.0].
     * @param { VisibleAreaChangeCallback } event - Callback for visible area changes of the component.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onVisibleAreaChange(ratios: Array<number> | undefined, event: VisibleAreaChangeCallback | undefined): this;
    /**
     * Set or reset the callback which is triggered when the visibleArea of component changed.
     * The interval between two visible area change callbacks will not be less than the expected update interval.
     *
     * @param { VisibleAreaEventOptions } options - The options for the visibility event.
     * @param { VisibleAreaChangeCallback | undefined } event - The callback will be triggered when the visibleArea of component changed and get close to any number in ratios defined by options.
     * If set undefined will reset the target callback.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onVisibleAreaApproximateChange(options: VisibleAreaEventOptions | undefined, event: VisibleAreaChangeCallback | undefined): this;
    /**
     * Applies a spherical effect to the component.
     *
     * @param { number } value - Spherical degree of the component.
     * <br>The value ranges from 0 to 1.
     * <p>**NOTE**:
     * <br>1. If the value is **0**, the component remains unchanged. If the value is 1, the component is completely
     * spherical. Between **0** and **1**, a larger value indicates a higher spherical degree. A value less than 0 is
     * handled as the value **0**. A value greater than 1 is handled as the value **1**.
     * <br>2. The component's shadow and outer stroke do not support spherical effects.
     * <br>3. If the value is greater than 0, the component is frozen and not updated, and its content is drawn to the
     * transparent offscreen buffer. To update the component attributes, set the value to **0**.
     * </p>
     *
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default sphericalEffect(value: number | undefined): this;
    /**
     * Applies a light up effect to the component.
     *
     * @param { number } value - Light up degree of the component.
     * <br>The value ranges from 0 to 1.
     * <br>If the value is **0**, the component is dark. If the value is **1**, the component is fully illuminated.
     * <br>Between **0** and **1**, a larger value indicates higher luminance.
     * <br>A value less than 0 is handled as the value **0**.
     * <br>A value greater than 1 is handled as the value **1**.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default lightUpEffect(value: number | undefined): this;
    /**
     * Applies a pixel stretch effect to the component.
     *
     * @param { PixelStretchEffectOptions } options - Pixel stretch effect options.
     * <br>The value includes the length by which a pixel is stretched toward the four edges.
     * <p>**NOTE**:
     * <br>1. If the length is a positive value, the original image is stretched, and the image size increases. The edge
     * pixels grow by the set length toward the top, bottom, left, and right edges.
     * <br>2. If the length is a negative value, the original image shrinks as follows, but the image size remains
     * unchanged:
     * <br>Shrinking mode:
     * <br>(1) The image shrinks from the four edges by the absolute value of length set through **options**.
     * <br>(2) The image is stretched back to the original size with edge pixels.
     * <br>3. Constraints on **options**:
     * <br>(1) The length values for the four edges must be all positive or all negative. That is, the four edges are
     * stretched or shrink at the same time in the same direction.
     * <br>(2) The length values must all be a percentage or a specific value. Combined use of the percentage and
     * specific value is not allowed.
     * <br>(3) If the input value is invalid, the image is displayed as {0, 0, 0, 0}, that is, the image is the same as
     * the original image.
     * </p>
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default pixelStretchEffect(options: PixelStretchEffectOptions | undefined): this;
    /**
     * Sets hot keys
     *
     * @param { string | FunctionKey } value - Character of the combination key.
     * @param { Array<ModifierKey> } keys - The modifier keys modify the action of key when the key are pressed at the same time.
     * @param { function } [action] - Callback function, triggered when the shortcut keyboard is pressed.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default keyboardShortcut(value: string | FunctionKey | undefined, keys: Array<ModifierKey> | undefined, action?: (() => void) | undefined): this;
    /**
     * Sets whether to enable accessibility grouping.
     *
     * <p><strong>NOTE</strong>
     * <br>Whether to enable accessibility grouping. When accessibility grouping is enabled,
     * <br>the component and all its children are treated as a single selectable unit, and the accessibility
     * <br>service will no longer focus on the individual child components.</p>
     *
     * @param { boolean } value - set group with accessibility, default value is false.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityGroupWithValue(value: boolean | undefined): this;
    /**
     * Sets whether to enable accessibility grouping.
     *
     * <p><strong>NOTE</strong>
     * <br>If accessibility grouping is enabled and the component does not contain a universal text attribute
     * <br>or an accessibility text attribute, the system will concatenate the universal text attributes of
     * <br>its child components to form a merged text for the component. If a child component lacks a universal
     * <br>text attribute, it will be ignored in the concatenation process.
     *
     * <br>When accessibilityPreferred is set to true, the system will prioritize concatenating the accessibility
     * <br>text attributes of the child components to form the merged text. If a child component lacks an
     * <br>accessibility text attribute, the system will continue to concatenate its universal text attribute.
     * <br>If a child component lacks both, it will be ignored.</p>
     *
     * @param { boolean } isGroup - set group with accessibility, default value is false.
     * @param { AccessibilityOptions } config - accessibilityOptions for accessibility, default value is false.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityGroupWithConfig(isGroup: boolean | undefined, config: AccessibilityOptions | undefined): this;
    /**
     * @since 20
     */
    overload accessibilityGroup { accessibilityGroupWithValue, accessibilityGroupWithConfig };
    /**
     * Sets the accessibility text.
     * When a component does not contain a text attribute, you can use this API to set an accessibility
     * text attribute, so that accessibility services can announce the specified content for the component.
     *
     * @param { string } value - set accessibility text, default value is "".
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityTextOfStringType(value: string | undefined): this;
    /**
     * Sets accessibility next focus id
     * @param { string } nextId - set component next accessibility focus id
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityNextFocusId(nextId: string | undefined): this;
    /**
     * Sets the accessibility default foucs flag
     * @param { boolean } focus - if the component is accessibility default focus,focus set true
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityDefaultFocus(focus: boolean | undefined): this;
    /**
     * Sets accessibility same page mode
     * @param { AccessibilitySamePageMode } pageMode - accessibility same page mode
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityUseSamePage(pageMode: AccessibilitySamePageMode | undefined): this;
    /**
     * Sets accessibilityScrollTriggerable
     * @param { boolean } isTriggerable - set property of supporting scroll in accessibility
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityScrollTriggerable(isTriggerable: boolean | undefined): this;
    /**
     * Sets the accessibility text.
     * <p><strong>NOTE</strong>
     * If a component has both text content and accessibility text, only the accessibility text is announced.
     * <br>If a component is grouped for accessibility purposes but lacks both text content and accessibility
     * <br>text, the screen reader will concatenate text from its child components (depth-first traversal).
     * <br>To prioritize accessibility text concatenation, set accessibilityPreferred in accessibilityGroup.
     * </p>
     * @param { Resource } text - set accessibility text
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityTextOfResourceType(text: Resource | undefined): this;
    /**
     * @since 20
     */
    overload accessibilityText { accessibilityTextOfStringType, accessibilityTextOfResourceType };
    /**
     * Sets accessibility role,role indicates the custom type of the component
     * @param { AccessibilityRoleType } role - set accessibility component type
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityRole(role: AccessibilityRoleType | undefined): this;
    /**
     * Register accessibility focus callback,when the component is focused or out of focus,the callback will be executed
     * @param { AccessibilityFocusCallback } callback - accessibility focus callback function
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default onAccessibilityFocus(callback: AccessibilityFocusCallback | undefined): this;
    /**
     * Sets accessibilityTextHint
     *
     * @param { string } value - set accessibility text hint
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityTextHint(value: string | undefined): this;
    /**
     * Sets accessibilityDescription
     *
     * @param { string } value - set description of accessibility, default value is "".
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityDescriptionOfStringType(value: string | undefined): this;
    /**
     * Sets accessibilityDescription
     *
     * with support for resource references using Resource.
     * This property provides additional context or explanation for the component,
     * helping users understand the action or function it performs.
     * <p><strong>NOTE</strong>:
     * <br>Reference resource of the accessibility description. You can specify further explanation
     * <br>of the current component, for example, possible operation consequences, especially those that
     * <br>cannot be learned from component attributes and accessibility text. If a component contains
     * <br>both text information and the accessibility description, the text is read first and then the
     * <br>accessibility description, when the component is selected.</p>
     * @param { Resource } description - set description of accessibility
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityDescriptionOfResourceType(description: Resource | undefined): this;
    /**
     * @since 20
     */
    overload accessibilityDescription { accessibilityDescriptionOfStringType, accessibilityDescriptionOfResourceType };
    /**
     * Sets the accessibility level.
     * This property determines whether the component can be recognized by accessibility services.
     * <p>
     * Accessibility level, which is used to decide whether a component can be identified by the accessibility service.
     * <br>The options are as follows:
     * <br>"auto": The component's recognizability is determined by the accessibility grouping service and ArkUI.
     * <br>"yes": The component can be recognized by accessibility services.
     * <br>"no": The component cannot be recognized by accessibility services.
     * <br>"no-hide-descendants": Neither the component nor its child components can be recognized by accessibility services.
     * <strong>NOTE</strong>
     * <br>When accessibilityLevel is set to "auto", the component's recognizability depends on the following factors:
     * <br>1. The accessibility service internally determines whether the component can be recognized.
     * <br>2. If the parent component's accessibilityGroup property has isGroup set to true, the accessibility service will
     * <br>not focus on its child components, making them unrecognizable.
     * <br>3. If the parent component's accessibilityLevel is set to "no-hide-descendants", the component will not be
     * <br>recognized by accessibility services.</p>
     * @param { string } value - set accessibility level, default value is auto.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityLevel(value: string | undefined): this;
    /**
     * Sets accessibilityVirtualNode
     *
     * @param { CustomBuilder } builder - set virtual node of accessibility
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
   default accessibilityVirtualNode(builder: CustomBuilder | undefined): this;
    /**
     * Sets accessibilityChecked
     *
     * @param { boolean } isCheck - set accessibility checked status
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityChecked(isCheck: boolean | undefined): this;
    /**
     * Sets accessibilitySelected
     *
     * @param { boolean } isSelect - set accessibility selected status
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilitySelected(isSelect: boolean | undefined): this;
    /**
     * Sets obscured
     *
     * @param { Array<ObscuredReasons> } reasons - reasons of obscuration
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default obscured(reasons: Array<ObscuredReasons> | undefined): this;
    /**
     * Reuse id is used for identify the reuse type for each custom node.
     *
     * @param { string } id - The id for reusable custom node.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default reuseId(id: string | undefined): this;
    /**
    * Reuse id is used for identify the reuse type of each @ComponentV2 custom component, which can give user control of sub-component recycle and reuse.
    *
    * @param { ReuseOptions } options - The configuration parameter for reusable custom component.
    * @returns { T }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    default reuse(options: ReuseOptions | undefined): this;
    /**
     * How the final state of the component's content is rendered during its width and height animation process.
     *
     * @param { RenderFit } fitMode - How the final state of the component's content is rendered during.
     * <br>its width and height animation process.
     * <br>If **renderFit** is not set, the default value **RenderFit.TOP_LEFT** is used.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default renderFit(fitMode: RenderFit | undefined): this;
    /**
     * Sets the gesture modifier.
     *
     * @param { GestureModifier } modifier
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default gestureModifier(modifier: GestureModifier | undefined): this;
    /**
     * Sets the background brightness of the component.
     *
     * @param { BackgroundBrightnessOptions } params - Parameters for setting the background brightness.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    default backgroundBrightness(params: BackgroundBrightnessOptions | undefined): this;
    /**
     * When a gesture bound to this component will be accepted, a user-defined callback is triggered to get the result
     *
     * @param { function } callback - A callback instance used when a gesture bound to this component will be accepted.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onGestureJudgeBegin(callback: ((gestureInfo: GestureInfo, event: BaseGestureEvent) => GestureJudgeResult) | undefined): this;
    /**
     * Binds a custom gesture recognizer judgment callback to the component.
     *
     * @param { GestureRecognizerJudgeBeginCallback } callback - A callback instance used when a gesture bound to this component will be accepted.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onGestureRecognizerJudgeBegin(callback: GestureRecognizerJudgeBeginCallback | undefined): this;
    /**
     * Binds a custom gesture recognizer judgment callback to the component.
     *
     * <p><strong>NOTE</strong>:
     * <br> For a composite component, setting exposeInnerGesture to true exposes the internal gesture recognizer of the
     * <br> composite component in the current parameter callback. Currently, only the Tabs component is supported.
     *
     * <br> Do not set exposeInnerGesture for other components. When exposeInnerGesture is set to false, this API provides the same functionality
     * <br> as the onGestureRecognizerJudgeBegin API.
     * </p>
     * @param { GestureRecognizerJudgeBeginCallback } callback - A callback instance used when a gesture bound to this component will be accepted.
     * @param { boolean } exposeInnerGesture - This parameter is a flag. This flag determines whether to expose internal gestures.
     * @default false
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onGestureRecognizerJudgeBegin(callback: GestureRecognizerJudgeBeginCallback | undefined, exposeInnerGesture: boolean | undefined): this;
    /**
     * Provides a callback to set the parallel relationship between built-in gestures and gestures of other components in the response chain.
     *
     * @param { ShouldBuiltInRecognizerParallelWithCallback } callback - A callback instance used when a component is doing touch test.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default shouldBuiltInRecognizerParallelWith(callback: ShouldBuiltInRecognizerParallelWithCallback | undefined): this;
    /**
     * Sets whether the component exclusively handles events.
     * true: The component exclusively handles events. false: The component does not exclusively handle events.
     *
     * @param { boolean } monopolize - indicate the monopoly of events
     * @default false
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default monopolizeEvents(monopolize: boolean | undefined): this;
    /**
     * When the component does a touch test, a user-defined callback is triggered.
     *
     * @param { Callback<TouchEvent, HitTestMode> } callback - A callback instance used when the component does a touch test.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    default onTouchIntercept(callback: Callback<TouchEvent, HitTestMode> | undefined): this;
    /**
     * This callback is triggered when the component size changes due to layout updates.
     * This event is not triggered for render attribute changes caused by re-rendering.
     *
     * @param { SizeChangeCallback } event - event callback.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default onSizeChange(event: SizeChangeCallback | undefined): this;
    /**
     * Accessibility focus draw level, and the default value is FocusDrawLevel.SELF.
     *
     * @param { FocusDrawLevel } drawLevel - indicates accessibility focus draw level.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    default accessibilityFocusDrawLevel(drawLevel: FocusDrawLevel | undefined): this;
}
/**
 * CommonAttribute for ide.
 *
 * @typedef  { CommonMethod } CommonAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export type CommonAttribute = CommonMethod;
/**
 * Defines the OverlayOptions interface.
 *
 * <strong>NOTE</strong>:<br>
 * When both align and offset are set, the effects are combined.
 * The overlay is first aligned relative to the component and then offset from its current upper left corner.
 *
 * @typedef OverlayOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface OverlayOptions {
    /**
     * Defines align type.
     *
     * @type { ?Alignment }
     * @default TopStart
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    align?: Alignment;
    /**
     * Defines offset type.
     *
     * @type { ?OverlayOffset }
     * @default - the overlay is in the upper left corner of the component.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    offset?: OverlayOffset;
}
/**
 * Defines the OverlayOffset.
 *
 * @typedef OverlayOffset
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface OverlayOffset {
    /**
     * Defines x.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    x?: number;
    /**
     * Defines y.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    y?: number;
}
/**
 * Defines the segment of blur.
 * The first element in the tuple means fraction.
 * The range of this value is [0,1]. A value of 1 means opaque and 0 means completely transparent.
 * The second element means the stop position.
 * The range of this value is [0,1]. A value of 1 means region ending position and 0 means region starting position.
 *
 * @typedef { [ number, number ] } FractionStop
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export type FractionStop = [
    number,
    number
];
export declare interface CommonShapeMethod extends CommonMethod {
    /**
     * Sets the stroke color.
     * If this attribute is not set, the component does not have any stroke.
     * If the value is invalid, no stroke will be drawn.
     *
     * @param { ResourceColor | undefined } value - Stroke color.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default stroke(value: ResourceColor | undefined): this;
    /**
     * Sets the color of the fill area.
     * An invalid value is handled as the default value.
     * If this attribute and the universal attribute foregroundColor are both set, whichever is set later takes effect.
     *
     * @param { ResourceColor | undefined } value - Color of the fill area. Default value: Color.Black.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fill(value: ResourceColor | undefined): this;
    /**
     * Sets the offset of the start point for drawing the stroke.
     * An invalid value is handled as the default value.
     *
     * @param { number | string | undefined } value - Offset of the start point for drawing the stroke.
     * Default value: 0
     * Default unit: vp
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default strokeDashOffset(value: number | string | undefined): this;
    /**
     * Sets the cap style of the stroke.
     *
     * @param { LineCapStyle | undefined } value - Cap style of the stroke. Default value: LineCapStyle.Butt
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default strokeLineCap(value: LineCapStyle | undefined): this;
    /**
     * Sets the join style of the stroke.
     * This attribute does not work for the Circle component, which does not have corners.
     *
     * @param { LineJoinStyle | undefined } value - Join style of the stroke. Default value: LineJoinStyle.Miter
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default strokeLineJoin(value: LineJoinStyle | undefined): this;
    /**
     * Limits for drawing acute angles as bevels
     *
     * @param { number | string | undefined } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default strokeMiterLimit(value: number | string | undefined): this;
    /**
     * Sets the stroke opacity.
     * The value range is [0.0, 1.0].
     * A value less than 0.0 evaluates to the value 0.0. A value greater than 1.0 evaluates to the value 1.0.
     * Any other value evaluates to the value 1.0.
     *
     * @param { number | string | Resource | undefined } value - Stroke opacity. Default value: 1
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default strokeOpacity(value: number | string | Resource | undefined): this;
    /**
     * Sets the opacity of the fill area.
     * The value range is [0.0, 1.0].
     * A value less than 0.0 evaluates to the value 0.0. A value greater than 1.0 evaluates to the value 1.0.
     * Any other value evaluates to the value 1.0.
     *
     * @param { number | string | Resource | undefined } value - Opacity of the fill area. Default value: 1
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fillOpacity(value: number | string | Resource | undefined): this;
    /**
     * Sets the stroke width.
     * If this attribute is of the string type, percentage values are not supported and will be treated as 1 px.
     *
     * @param { Length | undefined } value - Stroke width.
     * The value must be greater than or equal to 0.
     * Default value: 1.
     * Default unit: vp.
     * An invalid value is handled as the default value.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default strokeWidth(value: Length | undefined): this;
    /**
     * Specifies whether anti-aliasing is enabled.
     *
     * @param { boolean | undefined } value - Whether anti-aliasing is enabled.
     * true: Anti-aliasing is enabled.
     * false: Anti-aliasing is disabled.
     * Default value: true
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default antiAlias(value: boolean | undefined): this;
    /**
     * Sets the gap for the border.
     *
     * @param { Array<Length> | undefined } value
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default strokeDashArray(value: Array<Length> | undefined): this;
}
/**
 * Defines the direction of pixel rounding at the component level.
 *
 * @interface PixelRoundPolicy
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @form
 * @atomicservice
 * @since 20
 */
export declare interface PixelRoundPolicy {
    /**
     * Rounding for alignment with the start edge.
     *
     * @type { ?PixelRoundCalcPolicy }
     * @default PixelRoundCalcPolicy.NO_FORCE_ROUND
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    start?: PixelRoundCalcPolicy;
    /**
     * Rounding for alignment with the top edge.
     *
     * @type { ?PixelRoundCalcPolicy }
     * @default PixelRoundCalcPolicy.NO_FORCE_ROUND
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    top?: PixelRoundCalcPolicy;
    /**
     * Rounding for alignment with the end edge.
     *
     * @type { ?PixelRoundCalcPolicy }
     * @default PixelRoundCalcPolicy.NO_FORCE_ROUND
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    end?: PixelRoundCalcPolicy;
    /**
     * Rounding for alignment with the bottom edge.
     *
     * @type { ?PixelRoundCalcPolicy }
     * @default PixelRoundCalcPolicy.NO_FORCE_ROUND
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @form
     * @atomicservice
     * @since 20
     */
    bottom?: PixelRoundCalcPolicy;
}
/**
 * Linear Gradient Blur Interface
 *
 * @interface LinearGradientBlurOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface LinearGradientBlurOptions {
    /**
     * Percentage of blurring effect.
     *
     * @type { FractionStop[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    fractionStops: FractionStop[];
    /**
     * Direction of linear gradient blur.
     *
     * @type { GradientDirection }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    direction: GradientDirection;
}
/**
 * Define motion blur anchor coordinates.
 *
 * @interface MotionBlurAnchor
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface MotionBlurAnchor {
    /**
     * Define anchor coordinate x-value.Value range [0.0, 1.0].
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    x: number;
    /**
     * Define anchor coordinate y-value.Value range [0.0, 1.0].
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    y: number;
}
/**
 * Define motion blur options.
 *
 * @interface MotionBlurOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface MotionBlurOptions {
    /**
     * Define the size of motion blur radius.The range of this value is  [0.0, ∞).
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    radius: number;
    /**
     * Define motion blur anchor coordinates.
     *
     * @type { MotionBlurAnchor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    anchor: MotionBlurAnchor;
}
/**
 * Sub component layout info.
 *
 * @extends SizeResult
 * @interface GeometryInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface GeometryInfo extends SizeResult {
    /**
     * Sub component borderWidth info.
     *
     * @type { EdgeWidth }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    borderWidth: EdgeWidth;
    /**
     * Sub component margin info.
     *
     * @type { Margin }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    margin: Margin;
    /**
     * Sub component padding info.
     *
     * @type { Padding }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    padding: Padding;
}
/**
 * Provides the child component layout information.
 *
 * @interface Layoutable
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface Layoutable {
    /**
     * Measurement result of the child component.
     *
     * @type { MeasureResult }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    measureResult: MeasureResult;
    /**
     * Unique ID of the child component.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    uniqueId?: number;
    /**
     * Applies the specified position information to the child component.
     *
     * @param { Position } position
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    layout(position: Position): void;
    /**
     * Obtains the margin of the child component.
     *
     * @returns { DirectionalEdgesT<number> } the margin of sub component, unit is vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getMargin(): DirectionalEdgesT<number>;
    /**
     * Call this method to get the padding of sub component.
     *
     * @returns { DirectionalEdgesT<number> } Padding of the child component, unit is vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getPadding(): DirectionalEdgesT<number>;
    /**
     * Obtains the border width of the child component.
     *
     * @returns { DirectionalEdgesT<number> } the borderWidth of sub component, unit is vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getBorderWidth(): DirectionalEdgesT<number>;
}
/**
 * Sub component info passed from framework when measure happens.
 *
 * @interface Measurable
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface Measurable {
    /**
     * Unique ID that the system assigns to the child component.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    uniqueId?: number;
    /**
     * Applies the size constraint to the child component.
     *
     * @param { ConstraintSizeOptions } constraint
     * @returns { MeasureResult } Provides the measurement result of the component.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    measure(constraint: ConstraintSizeOptions): MeasureResult;
    /**
     * Obtains the margin of the child component.
     *
     * @returns { DirectionalEdgesT<number> } Margin of the child component, unit is vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getMargin(): DirectionalEdgesT<number>;
    /**
     * Obtains the padding of the child component.
     *
     * @returns { DirectionalEdgesT<number> } the padding of sub component, unit is vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getPadding(): DirectionalEdgesT<number>;
    /**
     * Obtains the border width of the child component.
     *
     * @returns { DirectionalEdgesT<number> } Border width of the child component, unit is vp.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getBorderWidth(): DirectionalEdgesT<number>;
}
/**
 * Provides the component size information.
 *
 * @interface SizeResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface SizeResult {
    /**
     * Width obtained from the measurement result. Unit: vp.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    width: number;
    /**
     * Height obtained from the measurement result. Unit: vp.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    height: number;
}
/**
 * Provides the measurement result of the component.
 *
 * @extends SizeResult
 * @interface MeasureResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface MeasureResult extends SizeResult {
}
/**
 * The navigation destination information.
 *
 * @typedef {uiObserver.NavDestinationInfo} NavDestinationInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type NavDestinationInfo = uiObserver.NavDestinationInfo;
/**
 * The navigation information.
 *
 * @typedef {  uiObserver.NavigationInfo } NavigationInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type NavigationInfo = uiObserver.NavigationInfo;
/**
 * The router page information.
 *
 * @typedef {uiObserver.RouterPageInfo} RouterPageInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type RouterPageInfo = uiObserver.RouterPageInfo;
/**
 * UIContext.
 *
 * @typedef { _UIContext } UIContext
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @stagemodelonly
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type UIContext = _UIContext;
/**
 * DrawContext.
 *
 * @typedef { _DrawContext } DrawContext
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @stagemodelonly
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type DrawContext = _DrawContext;
/**
 * VisualEffect
 *
 * @typedef { import('../api/@ohos.graphics.uiEffect').default.VisualEffect } VisualEffect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type VisualEffect = uiEffect.VisualEffect;
/**
 * Filter
 *
 * @typedef { import('../api/@ohos.graphics.uiEffect').default.Filter } Filter
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type Filter = uiEffect.Filter;

/**
 * Blender
 *
 * @typedef { import('../api/@ohos.graphics.uiEffect').default.Blender } Blender
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @form
 * @since 20
 * @arkts 1.2
 */
export type Blender = uiEffect.Blender;
/**
 * Import the DialogController type from promptAction.
 *
 * @typedef { promptAction.DialogController } PromptActionDialogController
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export type PromptActionDialogController = promptAction.DialogController;
/**
 * Describe the position, width, and height of a component.
 *
 * @interface RectResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface RectResult {
    /**
     * Horizontal coordinate.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    x: number;
    /**
     * Vertical coordinate.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    y: number;
    /**
     * Content width.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    width: number;
    /**
     * Content height.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    height: number;
}
/**
 * CaretOffset info.
 *
 * @interface CaretOffset
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface CaretOffset {
    /**
     * Get the index of the CaretOffset
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    index: number;
    /**
     * Get the x of the relative position.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    x: number;
    /**
     * Get the y of the relative position.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    y: number;
}
/**
 * Defines the span options of TextContentController.
 *
 * @interface TextContentControllerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface TextContentControllerOptions {
    /**
     * the offset that add a text at.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    offset?: number;
}
/**
 * TextContentControllerBase
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare abstract class TextContentControllerBase {
    /**
     * Get the index and relative position of the CaretOffset.
     *
     * <p><strong>NOTE</strong>:
     * <br>If this API is called when the caret position is updated in the current frame, it will not take effect.
     * <br>For the Search component, the returned position information is the offset of the first character
     * relative to the search icon in the component.
     * <br>If no text is entered in the Search component,
     * the return value contains the position information relative to the component.
     * <br>The location information in the return value is the location of the caret relative to the editable component.
     * </p>
     *
     * @returns { CaretOffset } index and relative position of the CaretOffset.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getCaretOffset(): CaretOffset;
    /**
     * Get the start and end positions of the text content.
     *
     * <p><strong>NOTE</strong>:
     * <br>If no text is entered, the return value contains the position information, but the size is 0.
     * <br>The position information is the offset of the first character relative to the editable area.
     * <br>For the Search component, the returned position information is the offset of the first character
     * relative to the search icon in the component.
     * <br>If there is input, the width in the return value is the fixed width of the editable area.
     * </p>
     *
     * @returns { RectResult } Text content rect.The unit of the return value is pixel.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getTextContentRect(): RectResult;
    /**
     * Get the lines number of the text content.
     * The getTextContentLineCount type is used to obtain the number of lines of the edited text.
     *
     * @returns { number } Text content line count
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getTextContentLineCount(): number;
    /**
     * Add a text.
     *
     * @param { string } text - text value.
     * @param { TextContentControllerOptions } [textOperationOptions] - operation info.
     * @returns { number } caret index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    addText(text: string, textOperationOptions?: TextContentControllerOptions): number;
    /**
     * Delete text in TextRange.
     *
     * @param { TextRange } [range] - range for deleting.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    deleteText(range?: TextRange): void;
    /**
     * Gets the selected range of text content.
     *
     * @returns { TextRange } range for selecting.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    getSelection(): TextRange;
    /**
     * Clear the content of preview.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    clearPreviewText(): void;
    /**
     * Gets the text content of the selected range.
     *
     * @param { TextRange } [range] - selected range.
     * @returns { string } text content of the selected range.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @atomicservice
     * @since 20
     */
    getText(range?: TextRange): string;

}
/**
 * Enum of scrollable containers' content clip mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum ContentClipMode {
    /**
     * Clip to content rect inside margin & padding.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    CONTENT_ONLY = 0,
    /**
     * Clip to scrollable's outer rect, including padding but inside margin.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    BOUNDARY = 1,
    /**
     * Clip to the safeArea of scrollable container.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    SAFE_AREA = 2
}
export declare interface ScrollableCommonMethod extends CommonMethod {
    /**
     * Sets the scrollbar state.
     *
     * @param { BarState } barState - Scrollbar state.<br>Default value: <em>BarState.Auto</em> for the <em>List</em>, <em>Grid</em>,
     * and <em>Scroll</em> components and <em>BarState.Off</em> for the <em>WaterFlow</em> component
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    scrollBar(barState: BarState | undefined): this;
    /**
     * Sets the scrollbar color.
     *
     * @param { Color | number | string } color - Scrollbar color.<br>Default value: <em>'\#182431'</em> (40% opacity)
     * <br>A number value indicates a HEX color in RGB or ARGB format,
     * for example, <em>0xffffff</em>. A string value indicates a color in RGB or ARGB format, for example, <em>'#ffffff'</em>.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    scrollBarColor(color: Color | number | string | undefined): this;
    /**
     * Sets the scrollbar width.
     *
     * @param { number | string } value  - Scrollbar width.<br>Default value: <em>4</em>
     * <br>Unit: vp
     * <br>If this parameter is set to a value less than or equal to 0, the default value is used.
     * The value <em>0</em> means not to show the scrollbar.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    scrollBarWidth(value: number | string | undefined): this;
    /**
     * Sets the effect used when the scroll boundary is reached.
     *
     * @param { EdgeEffect } edgeEffect - Effect used when the scroll boundary is reached. The spring and shadow effects are supported.
     * <br>Default value: <em>EdgeEffect.None</em> for the <em>Grid</em>, <em>Scroll</em>, and <em>WaterFlow</em> components and <em>EdgeEffect.Spring</em> for the <em>List</em> component
     * @param { EdgeEffectOptions } options - Whether to enable the scroll effect when the component content is smaller than the component itself.
     * The value <em>{ alwaysEnabled: true }</em> means to enable the scroll effect, and <em>{ alwaysEnabled: false }</em> means the opposite.
     * <br>Default value:<br><em>{ alwaysEnabled: false }</em> for the <em>List</em>, <em>Grid</em>, and <em>WaterFlow</em> components,
     * and <em>{ alwaysEnabled: true }</em> for the <em>Scroll</em> component
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    edgeEffect(edgeEffect: EdgeEffect | undefined, options?: EdgeEffectOptions | undefined): this;
    /**
     * Called when setting whether to enable fading Edge effect.
     *
     * @param { Optional<boolean> } enabled - Whether to turn on the edge fade effect
     * @param { FadingEdgeOptions } [options] - The options of fadingEdge.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    fadingEdge(enabled: boolean | undefined, options?: FadingEdgeOptions | undefined): this;
    /**
     * Sets the nested scrolling options.
     *
     * @param { NestedScrollOptions } value - Nested scrolling options.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    nestedScroll(value: NestedScrollOptions | undefined): this;
    /**
     * Sets whether to support scroll gestures.
     *
     * @param { boolean } value - Whether to support scroll gestures.<br>Default value: <em>true</em>
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    enableScrollInteraction(value: boolean | undefined): this;
    /**
     * Sets the friction coefficient.
     *
     * @param { number | Resource } value - Friction coefficient.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    friction(value: number | Resource | undefined): this;
    /**
     * Triggered when the scrollable component reaches the start position.
     *
     * @param { function } event - Callback function, triggered when the scrollable reaches the start position.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onReachStart(event: (() => void) | undefined): this;
    /**
     * Triggered when the scrollable component reaches the end position.
     *
     * @param { function } event - Callback function, triggered when the scrollable reaches the end position.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onReachEnd(event: (() => void) | undefined): this;
    /**
     * Triggered when the scrollable component starts scrolling initiated by the user's finger dragging the component or its scrollbar.
     *
     * @param { function } event - Callback function, triggered when the scrollable starts scrolling.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onScrollStart(event: (() => void) | undefined): this;
    /**
     * Triggered when scrolling stops after the user's finger leaves the screen.
     *
     * @param { function } event - Callback function, triggered when the scrollable stops scrolling.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onScrollStop(event: (() => void) | undefined): this;
    /**
     * Sets the maximum initial velocity at the start of the fling animation that occurs after gesture-driven scrolling ends.
     *
     * @param { number } speedLimit - Maximum initial velocity at the start of the fling animation.
     * <br>Default value: <em>9000</em>
     * <br>Unit: vp/s
     * <br>Value range: (0, +∞). If this parameter is set to a value less than or equal to 0, the default value is used.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    flingSpeedLimit(speedLimit: number | undefined): this;
    /**
     * Sets the content clipping area for this scrollable component.
     *
     * @param { ContentClipMode | RectShape } clip - A value from enum ContentClipMode or a customized clip rect.
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    clipContent(clip: ContentClipMode | RectShape | undefined): this;
    /**
     * Set the sensitivity of rotating crown.
     *
     * @param { Optional<CrownSensitivity> } sensitivity - The sensitivity of rotating crown, default value is { MEDIUM }.
     * @returns { T } The component instance.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    digitalCrownSensitivity(sensitivity: CrownSensitivity | undefined): this;
    /**
     * Sets whether to enable the back-to-top feature for a scrollable component when the status bar is touched.
     *
     * @param { boolean } backToTop - Whether to enable the back-to-top feature for a scrollable component when the status bar is touched.
     * <br>Default value: <em>false</em>
     * @returns { T }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    backToTop(backToTop: boolean | undefined): this;
}
/**
 * The actual offset by which the scrollable scrolls.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare class ScrollResult {
    /**
     * Actual offset by which the scrollable scrolls in vp.
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    offsetRemain: number;
}
/**
 * Called before scroll to allow developer to control real offset the Scrollable can scroll.
 *
 * @typedef { function } OnWillScrollCallback
 * @param { number } scrollOffset - offset this frame will scroll, which may or may not be reached.
 * @param { ScrollState } scrollState - current scroll state.
 * @param { ScrollSource } scrollSource - source of current scroll.
 * @returns { void | ScrollResult } the remain offset for the scrollable,
 *     same as scrollOffset when no ScrollResult is returned.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type OnWillScrollCallback = (scrollOffset: number, scrollState: ScrollState, scrollSource: ScrollSource) => undefined | ScrollResult;
/**
  * On scroll callback using in scrollable onDidScroll.
  *
  * @typedef { function } OnScrollCallback
  * @param { number } scrollOffset - offset this frame did scroll.
  * @param { ScrollState } scrollState - current scroll state.
  * @syscap SystemCapability.ArkUI.ArkUI.Full
  * @crossplatform
  * @form
  * @atomicservice
  * @since 20
  */
export type OnScrollCallback = (scrollOffset: number, scrollState: ScrollState) => void;
/**
  * Defines the callback type used in onItemDragStart.
  *
  * @typedef { function } OnItemDragStartCallback
  * @param { ItemDragInfo } event - Information about the dragged item.
  * @param { number } itemIndex - The index number of the dragged item.
  * @returns {CustomBuilder | undefined}
  * @syscap SystemCapability.ArkUI.ArkUI.Full
  * @atomicservice
  * @since 20
  */
export type OnItemDragStartCallback = (event: ItemDragInfo, itemIndex: number) => CustomBuilder | undefined;
/**
 * Defines the onMove callback.
 *
 * @typedef { function } OnMoveHandler
 * @param { number } from - Index number for moving elements.
 * @param { number } to - Target index number for moving elements.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type OnMoveHandler = (from: number, to: number) => void;
/**
 * Define item drag event handler.
 *
 * @interface ItemDragEventHandler
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface ItemDragEventHandler {
    /**
     * This callback is triggered when the item is long pressed.
     *
     * @type { ?Callback<number> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onLongPress?: Callback<number>;
    /**
     * This callback is triggered when the item is dragged.
     *
     * @type { ?Callback<number> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onDragStart?: Callback<number>;
    /**
     * This callback is triggered when an item is moved through other items.
     *
     * @type { ?Callback<number> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onMoveThrough?: OnMoveHandler;
    /**
     * This callback is triggered when the item is dropped.
     *
     * @type { ?Callback<number> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onDrop?: Callback<number>;
}
/**
* Define DynamicNode.
*
* @syscap SystemCapability.ArkUI.ArkUI.Full
* @crossplatform
* @atomicservice
* @since 20
*/
export declare interface DynamicNode {
    /**
     * Set the move action.
     *
     * @param { Optional<OnMoveHandler> } handler
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onMove(handler: Optional<OnMoveHandler>): this;
    /**
     * Set the move action.
     *
     * @param { Optional<OnMoveHandler> } handler
     * @param { ItemDragEventHandler } eventHandler
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onMove(handler: Optional<OnMoveHandler>, eventHandler: ItemDragEventHandler): this;
}
/**
 * Define EdgeEffect Options.
 *
 * @interface EdgeEffectOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface EdgeEffectOptions {
    /**
     * Enable Sliding effect when component does not full screen.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    alwaysEnabled: boolean;
    /**
     * Set the effective edge of the edge effect.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    effectEdge?: number;
}
/**
 * Enumerates the effective edge of the edge effect.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum EffectEdge {
    /**
     * Effective only for the starting edge.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    START = 1,
    /**
     * Effective only for the end edge.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    END = 2
}
/**
 * Indicates children main size.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare class ChildrenMainSize {
    /**
     * Creates an instance of ChildrenMainSize.
     *
     * @param { number } childDefaultSize - default main size, in vp. If the main axis is vertical, it indicates height.
     * If the main axis is horizontal, it indicates width.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    constructor(childDefaultSize: number);
    /**
     * Set default size.
     *
     * @param { number } value - default main size, in vp. If the main axis is vertical, it indicates height.
     * If the main axis is horizontal, it indicates width.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    set childDefaultSize(value: number);
    /**
     * Get default size
     *
     * @returns { number } - default main size, in vp. If the main axis is vertical, it indicates height.
     * If the main axis is horizontal, it indicates width.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    get childDefaultSize(): number;
    /**
     * Changes children main size by removing or replacing existing elements and/or adding new elements in place.
     *
     * @param { number } start - Zero-based index at which to start changing the children main size.
     * @param { number } [deleteCount] - Indicating the number of children main size to remove from start.
     * @param { Array<number> } [childrenSize] - Add the new children main size, beginning from start.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     * @example splice(1, 0, [100]), Insert a child after first child, the child's main size is 100vp.
     * splice(1, 1), Delete the second child.
     * splice(1, 2, [100, 100]), Change the main size of the second and third children to 100vp.
     */
    splice(start: number, deleteCount?: number, childrenSize?: Array<number>): void;
    /**
     * Updates main size for specified child.
     *
     * @param { number } index - index of child to be updated.
     * @param { number } childSize - new section options.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     * <br> 1. Mandatory parameters are left unspecified.
     * <br> 2. Incorrect parameters types.
     * <br> 3. Parameter verification failed.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    update(index: number, childSize: number): void;
}
/**
 * Define BackgroundBrightness Options.
 *
 * @interface BackgroundBrightnessOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @atomicservice
 * @since 20
 */
export declare interface BackgroundBrightnessOptions {
    /**
     * Brightness change rate. A higher rate means that brightness decreases more quickly.
     * If **rate** is set to **0**, **lightUpDegree** will not take effect, meaning no brightening effect will occur.
     *
     * @type { number } - The default value is 0.0, value range: (0.0, +∞).
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    rate: number;
    /**
     * Light up degree. A greater degree indicates a greater increase in brightness.
     *
     * @type { number } - The default value is 0.0, value range: [-1.0, 1.0].
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @atomicservice
     * @since 20
     */
    lightUpDegree: number;
}

/**
 * PointLightStyle info
 *
 * @interface PointLightStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
export declare interface PointLightStyle {
  /**
   * Defines the PointLight light intensity and position.
   *
   * @type { ?LightSource }
   * @default undefined
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  lightSource?: LightSource;
  /**
   * Defines the PointLight illuminated type.
   *
   * @type { ?IlluminatedType }
   * @default IlluminatedType.NONE
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  illuminated?: IlluminatedType;
  /**
   * Defines the PointLight bloom.
   *
   * @type { ?number }
   * @default 0
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  bloom?: number;
}

/**
 * LightSource info
 *
 * @interface LightSource
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
declare interface LightSource {
  /**
   * Defines the PointLight light positionX.
   *
   * @type { Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  positionX: Dimension;
  /**
   * Defines the PointLight light positionX.
   *
   * @type { Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  positionY: Dimension;
  /**
   * Defines the PointLight light positionX.
   *
   * @type { Dimension }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
  positionZ: Dimension;
  /**
   * Defines the PointLight light intensity.
   *
   * @type { number }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  intensity: number;
  /**
   * Defines the PointLight light color.
   *
   * @type { ?ResourceColor }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  color?: ResourceColor;
}


/**
 * Defines the overall animation parameters of the keyframe animation.
 *
 * @interface KeyframeAnimateParam
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface KeyframeAnimateParam {
    /**
     * Animation delay time, in ms.
     *
     * @type { ?number }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    delay?: number;
    /**
     * Animation iterations. When set to -1, the animation playing it repeatedly. The value range is greater than or equal to -1.
     *
     * @type { ?number }
     * @default 1
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    iterations?: number;
    /**
     * Callback invoked when the whole keyframe animation is complete or the ability is about to enter the background.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    onFinish?: () => void;
    /**
     * Indicates expectedFrameRateRange of keyframe animation.
     *
     * @type { ?ExpectedFrameRateRange }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    expectedFrameRateRange?: ExpectedFrameRateRange;
}
/**
 * Defines a keyframe state.
 *
 * @interface KeyframeState
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface KeyframeState {
    /**
     * Animation duration of this keyframe, in ms.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    duration: number;
    /**
     * Animation curve of this keyframe.
     *
     * @type { ?(Curve | string | ICurve) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    curve?: Curve | string | ICurve;
    /**
     * The closure function to specify the terminating state of this keyframe.
     *
     * @type { function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    event: () => void;
}
/**
 * Defines the callback
 *
 * @typedef { function } Callback<T, V = void>
 * @param { T } data
 * @returns { V }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type Callback<T, V = void> = (data: T) => V;
/**
 * Defines the callback type used in hover events.
 * The value of isHover indicates whether the mouse is hovering over the component.
 * The value of event contains information about HoverEvent.
 *
 * @typedef { function } HoverCallback
 * @param { boolean } isHover
 * @param { HoverEvent} event
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type HoverCallback = (isHover: boolean, event: HoverEvent) => void;
/**
 * Defines the callback type used in accessibility hover events.
 * The value of isHover indicates whether the touch is hovering over the component.
 * The value of event contains information about AccessibilityHoverEvent.
 *
 * @typedef { function } AccessibilityCallback
 * @param { boolean } isHover
 * @param { AccessibilityHoverEvent } event
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type AccessibilityCallback = (isHover: boolean, event: AccessibilityHoverEvent) => void;
/**
 * Defines the options about VisibleAreaEvent.
 *
 * @interface VisibleAreaEventOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface VisibleAreaEventOptions {
    /**
     * Each number in ratios indicates the value of visibility ratio. Each number in the Array value range in [0, 1].
     *
     * @type { Array<number> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    ratios: Array<number>;
    /**
     * The value of expectedUpdateInterval indicates desired update period(ms).
     *
     * @type { ?number }
     * @default 1000
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    expectedUpdateInterval?: number;
}
/**
 * Defines the callback type used in VisibleAreaChange events.
 *
 * @typedef { function } VisibleAreaChangeCallback
 * @param { boolean } isExpanding - Indicates the ratio of the visible area to its own area compared to the last change.
 * It is true as the ratio increases and false as the ratio decreases.
 * @param { number } currentRatio - The value of currentRatio indicates the visibility ratio of the current component.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type VisibleAreaChangeCallback = (isExpanding: boolean, currentRatio: number) => void;
/**
 * Defines a UICommonEvent which is used to set different common event to target component.
 *
 * @interface UICommonEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface UICommonEvent {
    /**
     * Set or reset the callback which will be triggered a click event when clicked.
     *
     * @param { Callback<ClickEvent> | undefined } callback - The callback about the click event. If set undefined will reset the target callback.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    setOnClick(callback: Callback<ClickEvent> | undefined): void;
    /**
     * Set or reset the callback which will be triggered a touch event when touched.
     *
     * @param { Callback<TouchEvent> | undefined } callback - The callback about the touch event. If set undefined will reset the target callback.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    setOnTouch(callback: Callback<TouchEvent> | undefined): void;
    /**
     * Set or reset the callback is triggered when a component mounts a display.
     *
     * @param { Callback<void> | undefined } callback - The callback will be triggered when a component mounts a display. If set undefined will reset the target callback.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    setOnAppear(callback: Callback<void> | undefined): void;
    /**
     * Set or reset the callback is triggered when component uninstallation disappears.
     *
     * @param { Callback<void> | undefined } callback - The callback will be triggered when component uninstallation disappears. If set undefined will reset the target callback.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    setOnDisappear(callback: Callback<void> | undefined): void;
    /**
     * Set or reset the callback is triggered when component has keyboard input.
     *
     * @param { Callback<KeyEvent> | undefined } callback - The callback will be triggered when has keyboard input. If set undefined will reset the target callback.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    setOnKeyEvent(callback: Callback<KeyEvent> | undefined): void;
    /**
     * Set or reset the callback which is triggered when component get focus.
     *
     * @param { Callback<void> | undefined } callback - The callback will be triggered when a component get focus. If set undefined will reset the target callback.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    setOnFocus(callback: Callback<void> | undefined): void;
    /**
     * Set or reset the callback which is triggered when lose focus.
     *
     * @param { Callback<void> | undefined } callback - The callback will be triggered when a component lose focus. If set undefined will reset the target callback.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    setOnBlur(callback: Callback<void> | undefined): void;
    /**
     * Set or reset the callback which is triggered when has a hover event.
     *
     * @param { HoverCallback | undefined } callback - The callback will be triggered when has a hover event. If set undefined will reset the target callback.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    setOnHover(callback: HoverCallback | undefined): void;
    /**
    * Set or reset the callback which is triggered when has a mouse event.
    *
    * @param { Callback<MouseEvent> | undefined } callback - The callback will be triggered when has mouse input. If set undefined will reset the target callback.
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    setOnMouse(callback: Callback<MouseEvent> | undefined): void;
    /**
    * Sets the callback for the onSizeChange event.
    *
    * @param { SizeChangeCallback | undefined } callback - The callback will be triggered when the size of component changed. If set undefined will reset the target callback.
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @crossplatform
    * @atomicservice
    * @since 20
    */
    setOnSizeChange(callback: SizeChangeCallback | undefined): void;
    /**
     * Sets the onVisibleAreaChange callback that limits the callback interval.
     *
     * @param { VisibleAreaEventOptions } options - The options for the visibility event.
     * @param { VisibleAreaChangeCallback | undefined } event - The callback will be triggered when the visibleArea of component changed and get close to any number in ratios defined by options.
     * If set undefined will reset the target callback.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    setOnVisibleAreaApproximateChange(options: VisibleAreaEventOptions, event: VisibleAreaChangeCallback | undefined): void;
}
/**
 * Defines a UIGestureEvent which is used to set different gestures to target component.
 *
 * @interface UIGestureEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface UIGestureEvent {
    /**
     * Add a gesture bound to the component.
     *
     * @param { GestureHandler<T> } gesture - gesture indicates the gesture bound to a component.
     * @param { GesturePriority } priority - priority indicates the gesture's priority.
     * @param { GestureMask } mask - mask indicates the gesture's GestureMask value.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    addGesture(gesture: GestureHandler, priority?: GesturePriority, mask?: GestureMask): void;
    /**
     * Add a parallel gesture bound to the component.
     *
     * @param { GestureHandler<T> } gesture - gesture indicates the gesture bound to a component.
     * @param { GestureMask } mask - mask indicates the gesture's GestureMask value.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    addParallelGesture(gesture: GestureHandler, mask?: GestureMask): void;
    /**
     * Remove a gesture from a component that has been bound with a specific tag through a modifier.
     *
     * @param { string } tag - tag indicates the gesture's tag.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    removeGestureByTag(tag: string): void;
    /**
     * Clear gestures bound to the component.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    clearGestures(): void;
}
/**
 * Defines the gesture modifier.
 *
 * @interface GestureModifier
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface GestureModifier {
    /**
     * Defines the gesture update function.
     *
     * @param { UIGestureEvent } event
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    applyGesture(event: UIGestureEvent): void;
}
/**
 * Defines the selection options.
 *
 * @interface SelectionOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface SelectionOptions {
    /**
     * Menu pop-up policy.
     *
     * @type { ?MenuPolicy }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    menuPolicy?: MenuPolicy;
}
/**
 * Defines the next focus item.
 *
 * @interface FocusMovement
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface FocusMovement {
    /**
     * Next focus item's component identifier of forward.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    forward?: string;
    /**
     * Next focus item's component identifier of backward.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    backward?: string;
    /**
     * Next focus item's component identifier of up.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    up?: string;
    /**
     * Next focus item's component identifier of down.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    down?: string;
    /**
     * Next focus item's component identifier of left.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    left?: string;
    /**
     * Next focus item's component identifier of right.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    right?: string;
}
/**
 * enum keyboard avoid mode
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum KeyboardAvoidMode {
    /**
     * Automatically avoids the soft keyboard and compresses the height when reaching the maximum limit.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    DEFAULT = 0,
    /**
     * Does not avoid the soft keyboard.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    NONE = 1
}
/**
 * Enumerates the type of area in hover mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare enum HoverModeAreaType {
    /**
     * Layout top half screen when the phone in hover mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    TOP_SCREEN = 0,
    /**
     * Layout bottom half screen when the phone in hover mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    BOTTOM_SCREEN = 1
}
/**
 * Defines a range of dates.
 *
 * @interface DateRange
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface DateRange {
    /**
     * Defines the start date of the date range.
     *
     * @type { ?Date }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    start?: Date;
    /**
     * Defines the end date of the date range.
     *
     * @type { ?Date }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    end?: Date;
}
/**
 * Indicates the information when the provider of the embedded UI is terminated.
 *
 * @interface TerminationInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TerminationInfo {
    /**
     * Defines the termination code.
     *
     * @type { int }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    code: int;
    /**
     * Defines the additional termination information.
     *
     * @type { ?Want }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    want?: Want;
}
/**
 * Defines the format for displaying dates and times.
 *
 * @typedef { intl.DateTimeOptions } DateTimeOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export type DateTimeOptions = intl.DateTimeOptions;
/**
 * Defines a bindable property
 * @interface Bindable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @crossplatform
 * @atomicservice
 * @since 20
 */
export declare interface Bindable<T> {
    /**
     * Defines value of the bindable property.
     * @type { T }
     * @readonly
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 20
     */
    readonly value: T;
    /**
     * Defines the callback of the bindable property which will be invork when the property is changed..
     * @type { Callback<T> }
     * @readonly
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    readonly onChange: Callback<T>;
}

/**
 * Defines the Two-way binding type of ResourceStr.
 *
 * @typedef { ResourceStr | Bindable<ResourceStr> | Bindable<Resource> | Bindable<string> }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare type BindableResourceStr = ResourceStr | Bindable<ResourceStr> | Bindable<Resource> | Bindable<string>;

/**
 * Defines the Two-way binding type of ResourceStr[].
 *
 * @typedef { ResourceStr[] | Bindable<ResourceStr[]> | Bindable<Resource[]> | Bindable<string[]> }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare type BindableResourceStrArray = ResourceStr[] | Bindable<ResourceStr[]> | Bindable<Resource[]> | Bindable<string[]>;

/**
 * Convert to a bindable property.
 *
 * @param { T } value - indicate the value of a state property.
 * @returns { Bindable<T> }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare function $$<T>(value: T): Bindable<T>;
/**
 * Apply style function on this CommonMethod.
 *
 * @param { T } this
 * @param { CustomStyles } customStyles
 * @returns { T }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare function applyStyles<T extends CommonMethod>(self: T, customStyles: CustomStyles): T;
