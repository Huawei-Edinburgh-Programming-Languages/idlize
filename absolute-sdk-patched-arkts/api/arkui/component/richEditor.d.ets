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
import { ShadowOptions, ClickEvent, SelectionOptions, CommonMethod, Callback, HapticFeedbackMode, RectResult, HoverEvent, PixelMap } from './common';
import { CustomBuilder } from './builder';
import { ResourceColor, Length, ResourceStr, Dimension, Margin, BorderRadiuses, Font, VoidCallback } from './units';
import { FontStyle, FontWeight, TextAlign, WordBreak, LineBreakStrategy, ImageSpanAlignment, ImageFit, ResponseType, CopyOptions, BarState } from './enums';
import { DecorationStyleInterface, StyledString, MutableStyledString } from './styledString';
import { Resource } from './../../../api/global/resource';
import { SymbolEffectStrategy, SymbolRenderingStrategy } from './symbolglyph';
import { DecorationStyleResult, TextRange, MenuType, TextEditControllerEx, LayoutManager, PreviewText, StyledStringController, StyledStringChangedListener, TextDataDetectorConfig, OnDidChangeCallback, EditMenuOptions, KeyboardAppearance } from './textCommon';
import { GestureEvent } from './gesture';
import { EnterKeyType, SubmitEvent } from './textInput';
import { LengthMetrics, ColorMetrics } from '../Graphics';
import { TextBackgroundStyle } from './span';
import { memo, ComponentBuilder } from './../stateManagement/runtime';
import { AttributeModifier, CommonMethod } from './common';
/**
 * Defines delete text direction.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum RichEditorDeleteDirection {
    /**
     * Delete backward.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BACKWARD,
    /**
     * Delete forward.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FORWARD
}
/**
 * Defines span type.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum RichEditorSpanType {
    /**
     * Text,corresponding textSpan type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TEXT = 0,
    /**
     * Image,corresponding imageSpan type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    IMAGE = 1,
    /**
     * Mixed,corresponding mixed span type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MIXED = 2,
    /**
     * Builder,corresponding builderSpan type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BUILDER = 3,
    /**
     * When no other types are explicitly specified, this type will be matched.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DEFAULT = 4
}
/**
 * ResponseType for contextMenu
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum RichEditorResponseType {
    /**
     * Right click.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RIGHT_CLICK = 0,
    /**
     * Long press.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LONG_PRESS = 1,
    /**
     * Selected by mouse.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SELECT = 2,
    /**
     * When no other types are explicitly specified, this type will be matched.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DEFAULT = 3
}
/**
 * Defines the span position.
 *
 * @interface RichEditorSpanPosition
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorSpanPosition {
    /**
     * Define the index of span.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    spanIndex: number;
    /**
     * The range of span.
     *
     * @type { [number, number] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    spanRange: [
        number,
        number
    ];
}
/**
 * Defines the span text style.
 *
 * @interface RichEditorTextStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorTextStyle {
    /**
     * font color.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontColor?: ResourceColor;
    /**
     * font size.
     *
     * @type { ?(Length | number) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontSize?: Length | number;
    /**
     * font style.
     *
     * @type { ?FontStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontStyle?: FontStyle;
    /**
     * font weight.
     *
     * @type { ?(number | FontWeight | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontWeight?: number | FontWeight | string;
    /**
     * font family.
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontFamily?: ResourceStr;
    /**
     * Font decoration.
     *
     * @type { ?DecorationStyleInterface }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    decoration?: DecorationStyleInterface;
    /**
     * Text shadow
     *
     * @type { ?(ShadowOptions | Array<ShadowOptions>) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textShadow?: ShadowOptions | Array<ShadowOptions>;
    /**
     * letter spacing.
     *
     * @type { ?(number | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    letterSpacing?: number | string;
    /**
     * line height.
     *
     * @type { ? (number | string | Resource) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    lineHeight?: number | string | Resource;
    /**
     * Set the text with half leading.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    halfLeading?: boolean;
    /**
     * Set font feature, advanced text styles and effects as designed by the font author.
     * The format is the like the CSS font-feature-settings attribute.
     *
     * @type { ?string }
     * normal | <feature-tag-value>,
     * where <feature-tag-value> = <string> [ <integer> | on | off ], like: "ss01" 0
     * the values of <feature-tag-value> reference to doc of RichEditor component
     * number of <feature-tag-value> can be single or multiple, and separated by comma ','.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontFeature?: string;
    /**
     * Text background style.
     *
     * @type { ?TextBackgroundStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textBackgroundStyle?: TextBackgroundStyle;
}
/**
 * Defines the leading margin placeholder of a paragraph.
 *
 * @interface LeadingMarginPlaceholder
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface LeadingMarginPlaceholder {
    /**
     * Placeholder pixelMap.
     *
     * @type { PixelMap }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pixelMap: PixelMap;
    /**
     * Placeholder size.
     *
     * @type { [Dimension, Dimension] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    size: [
        Dimension,
        Dimension
    ];
}
/**
 * Defines the paragraph style.
 *
 * @interface RichEditorParagraphStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorParagraphStyle {
    /**
     * Text alignment.
     *
     * @type { ?TextAlign }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textAlign?: TextAlign;
    /**
     * Leading margin.
     *
     * @type { ?(Dimension | LeadingMarginPlaceholder) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    leadingMargin?: Dimension | LeadingMarginPlaceholder;
    /**
     * Set word break type.
     *
     * @type { ?WordBreak }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    wordBreak?: WordBreak;
    /**
     * Set line break strategy type.
     *
     * @type { ?LineBreakStrategy }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    lineBreakStrategy?: LineBreakStrategy;
    /**
     * Set paragraph spacing.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    paragraphSpacing?: number;
}
/**
 * Defines the paste event.
 *
 * @interface PasteEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface PasteEvent {
    /**
     * Override system paste event.
     *
     * @type { ?VoidCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    preventDefault?: VoidCallback;
}
/**
 * Defines the text span.
 *
 * @interface RichEditorTextSpan
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorTextSpan {
    /**
     * The position of the text span.
     *
     * @type { RichEditorSpanPosition }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    spanPosition: RichEditorSpanPosition;
    /**
     * The content of the text span.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: string;
    /**
     * text style.
     *
     * @type { ?RichEditorTextStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textStyle?: RichEditorTextStyle;
}
/**
 * Defines the richEditor Image Layout Style.
 *
 * @interface RichEditorLayoutStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface RichEditorLayoutStyle {
    /**
     * Outer Margin.
     *
     * @type { ?(Dimension | Margin) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    margin?: Dimension | Margin;
    /**
     * Border radius.
     *
     * @type { ?(Dimension | BorderRadiuses) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    borderRadius?: Dimension | BorderRadiuses;
}
/**
 * Defines the span image style.
 *
 * @interface RichEditorImageSpanStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorImageSpanStyle {
    /**
     * image size.
     *
     * @type { ?[Dimension, Dimension] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    size?: [
        Dimension,
        Dimension
    ];
    /**
     * image vertical align.
     *
     * @type { ?ImageSpanAlignment }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    verticalAlign?: ImageSpanAlignment;
    /**
     * image fit.
     *
     * @type { ?ImageFit }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    objectFit?: ImageFit;
    /**
     * RichEditor ImageSpan Layout Style.
     *
     * @type { ?RichEditorLayoutStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    layoutStyle?: RichEditorLayoutStyle;
}
/**
 * Defines the symbol span style.
 *
 * @interface RichEditorSymbolSpanStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorSymbolSpanStyle {
    /**
     * The font size.
     *
     * @type { ?(number | string | Resource) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontSize?: number | string | Resource;
    /**
     * The font color.
     *
     * @type { ?Array<ResourceColor> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontColor?: Array<ResourceColor>;
    /**
     * The font weight.
     *
     * @type { ?(number | FontWeight | string) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontWeight?: number | FontWeight | string;
    /**
     * The symbol span effect strategy.
     *
     * @type { ?SymbolEffectStrategy }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    effectStrategy?: SymbolEffectStrategy;
    /**
     * The symbol span rendering strategy.
     *
     * @type { ?SymbolRenderingStrategy }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    renderingStrategy?: SymbolRenderingStrategy;
}
/**
 * Defines the text style result.
 *
 * @interface RichEditorTextStyleResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorTextStyleResult {
    /**
     * font color.
     *
     * @type { ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontColor: ResourceColor;
    /**
     * font size.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontSize: number;
    /**
     * font style.
     *
     * @type { FontStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontStyle: FontStyle;
    /**
     * font weight.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontWeight: number;
    /**
     * font family.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontFamily: string;
    /**
     * Font decoration.
     *
     * @type { DecorationStyleResult }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    decoration: DecorationStyleResult;
    /**
     * Text shadow
     *
     * @type { ?Array<ShadowOptions> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textShadow?: Array<ShadowOptions>;
    /**
     * letter spacing.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    letterSpacing?: number;
    /**
     * line height.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    lineHeight?: number;
    /**
     * Set the text with half leading.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    halfLeading?: boolean;
    /**
     * Set font feature, advanced text styles and effects as designed by the font author.
     * The format is the like the CSS font-feature-settings attribute.
     *
     * @type { ?string }
     * normal | <feature-tag-value>,
     * where <feature-tag-value> = <string> [ <integer> | on | off ], like: "ss01" 0
     * the values of <feature-tag-value> reference to doc of RichEditor component
     * number of <feature-tag-value> can be single or multiple, and separated by comma ','.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontFeature?: string;
    /**
     * Text background style.
     *
     * @type { ?TextBackgroundStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textBackgroundStyle?: TextBackgroundStyle;
}
/**
 * Defines the paragraph result.
 *
 * @interface RichEditorParagraphResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorParagraphResult {
    /**
     * The paragraph style.
     *
     * @type { RichEditorParagraphStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style: RichEditorParagraphStyle;
    /**
     * The range of paragraph based on character indices.
     *
     * @type { [number, number] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    range: [
        number,
        number
    ];
}
/**
 * Defines the symbol span style result.
 *
 * @interface RichEditorSymbolSpanStyleResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorSymbolSpanStyleResult {
    /**
     * The font size.
     *
     * @type { number | string | Resource }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontSize: number | string | Resource;
    /**
     * The font color.
     *
     * @type { Array<ResourceColor> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontColor: Array<ResourceColor>;
    /**
     * The font weight.
     *
     * @type { number | FontWeight | string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontWeight: number | FontWeight | string;
    /**
     * The symbol span effect strategy.
     *
     * @type { SymbolEffectStrategy }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    effectStrategy: SymbolEffectStrategy;
    /**
     * The symbol span rendering strategy.
     *
     * @type { SymbolRenderingStrategy }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    renderingStrategy: SymbolRenderingStrategy;
}
/**
 * Defines the text span result.
 *
 * @interface RichEditorTextSpanResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorTextSpanResult {
    /**
     * The position of the text span.
     *
     * @type { RichEditorSpanPosition }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    spanPosition: RichEditorSpanPosition;
    /**
     * The content of the text span.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: string;
    /**
     * text style.
     *
     * @type { RichEditorTextStyleResult }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textStyle: RichEditorTextStyleResult;
    /**
     * get offset in span.
     *
     * @type { [number, number] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offsetInSpan: [
        number,
        number
    ];
    /**
     * Symbol span style.
     *
     * @type { ?RichEditorSymbolSpanStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    symbolSpanStyle?: RichEditorSymbolSpanStyle;
    /**
     * The resource string of the symbol span.
     *
     * @type { ?Resource }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    valueResource?: Resource;
    /**
     * The Style of paragraph.
     *
     * @type { ?RichEditorParagraphStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    paragraphStyle?: RichEditorParagraphStyle;
    /**
     * The preview text.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    previewText?: string;
    /**
     * RichEditor url style.
     *
     * @type { ?RichEditorUrlStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    urlStyle?: RichEditorUrlStyle;
}
/**
 * Defines the span image style result.
 *
 * @interface RichEditorImageSpanStyleResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorImageSpanStyleResult {
    /**
     * image size.
     *
     * @type { [number, number] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    size: [
        number,
        number
    ];
    /**
     * image vertical align.
     *
     * @type { ImageSpanAlignment }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    verticalAlign: ImageSpanAlignment;
    /**
     * image fit.
     *
     * @type { ImageFit }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    objectFit: ImageFit;
    /**
     * RichEditor ImageSpan Layout Style.
     *
     * @type { ?RichEditorLayoutStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    layoutStyle?: RichEditorLayoutStyle;
}
/**
 * Defines the image span.
 *
 * @interface RichEditorImageSpanResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorImageSpanResult {
    /**
     * The position of the image span.
     *
     * @type { RichEditorSpanPosition }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    spanPosition: RichEditorSpanPosition;
    /**
     * The pixel map of the image span.
     *
     * @type { ?PixelMap }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    valuePixelMap?: PixelMap;
    /**
     * The resource string of the image span.
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    valueResourceStr?: ResourceStr;
    /**
     * image attribute.
     *
     * @type { RichEditorImageSpanStyleResult }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    imageStyle: RichEditorImageSpanStyleResult;
    /**
     * get offset in span.
     *
     * @type { [number, number] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offsetInSpan: [
        number,
        number
    ];
}
/**
 * Defines the image span.
 *
 * @interface RichEditorImageSpan
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorImageSpan {
    /**
     * The position of the image span.
     *
     * @type { RichEditorSpanPosition }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    spanPosition: RichEditorSpanPosition;
    /**
     * The content of the image span.
     *
     * @type { PixelMap | ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: PixelMap | ResourceStr;
    /**
     * image style.
     *
     * @type { ?RichEditorImageSpanStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    imageStyle?: RichEditorImageSpanStyle;
}
/**
 * Defines range of RichEditor.
 *
 * @interface RichEditorRange
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorRange {
    /**
     * start offset.
     *
     * @type { ?number }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    start?: number;
    /**
     * end offset.
     *
     * @type { ?number }
     * @default text length
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    end?: number;
}
/**
 * Defines the richEditor Gestures.
 *
 * @interface RichEditorGesture
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorGesture {
    /**
     * Trigger a click event when a click is clicked.
     *
     * @type { ?Callback<ClickEvent> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onClick?: Callback<ClickEvent>;
    /**
     * Trigger a gesture event when long press event is complete.
     *
     * @type { ?Callback<GestureEvent> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onLongPress?: Callback<GestureEvent>;
    /**
     * Trigger a gesture event when a double click event is complete.
     *
     * @type { ?Callback<GestureEvent> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    onDoubleClick?: Callback<GestureEvent>;
}
/**
 * Defines the span options of RichEditor.
 *
 * @interface RichEditorTextSpanOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorTextSpanOptions {
    /**
     * the offset that add a text span at.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offset?: number;
    /**
     * text style.
     *
     * @type { ?RichEditorTextStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style?: RichEditorTextStyle;
    /**
     * Paragraph style.
     *
     * @type { ?RichEditorParagraphStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    paragraphStyle?: RichEditorParagraphStyle;
    /**
     * RichEditor gesture.
     *
     * @type { ?RichEditorGesture }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    gesture?: RichEditorGesture;
    /**
     * RichEditor url style.
     *
     * @type { ?RichEditorUrlStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    urlStyle?: RichEditorUrlStyle;
}
/**
 * Defines the custom keyboard options of RichEditor.
 *
 * @interface KeyboardOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface KeyboardOptions {
    /**
     * Indicates whether to support custom keyboard avoidance.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    supportAvoidance?: boolean;
}
/**
 * Defines the image span options of RichEditor.
 *
 * @interface RichEditorImageSpanOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorImageSpanOptions {
    /**
     * the offset that add image span at.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offset?: number;
    /**
     * image style.
     *
     * @type { ?RichEditorImageSpanStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    imageStyle?: RichEditorImageSpanStyle;
    /**
     * RichEditor gesture.
     *
     * @type { ?RichEditorGesture }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    gesture?: RichEditorGesture;
    /**
     * RichEditor onHover.
     *
     * @type { ?OnHoverCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onHover?: OnHoverCallback;
}
/**
 * Defines the builder span options of RichEditor.
 *
 * @interface RichEditorBuilderSpanOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorBuilderSpanOptions {
    /**
     * The offset that add custom builder span at.
     *
     * @type { ?number } Indicates the index where the builder will be inserted
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offset?: number;
    /**
     * builder span drag background color
     *
     * @type { ?ColorMetrics }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    dragBackgroundColor?: ColorMetrics;
    /**
     * builder span drag shadow configuration
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    isDragShadowNeeded?: boolean;
}
/**
 * Defines the placeholder style.
 *
 * @interface PlaceholderStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface PlaceholderStyle {
    /**
     * font.
     *
     * @type { ?Font }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    font?: Font;
    /**
     * fontColor.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontColor?: ResourceColor;
}
/**
 * Defines span style option of RichEditor.
 *
 * @extends RichEditorRange
 * @interface RichEditorSpanStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorSpanStyleOptions extends RichEditorRange {
}
/**
 * Defines paragraph style option of RichEditor.
 *
 * @extends RichEditorRange
 * @interface RichEditorParagraphStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorParagraphStyleOptions extends RichEditorRange {
    /**
     * Paragraph style.
     *
     * @type { RichEditorParagraphStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style: RichEditorParagraphStyle;
}
/**
 * Defines text span style option of RichEditor.
 *
 * @extends RichEditorSpanStyleOptions
 * @interface RichEditorUpdateTextSpanStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorUpdateTextSpanStyleOptions extends RichEditorSpanStyleOptions {
    /**
     * text style.
     *
     * @type { RichEditorTextStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textStyle: RichEditorTextStyle;
    /**
     * RichEditor url style.
     *
     * @type { ?RichEditorUrlStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    urlStyle?: RichEditorUrlStyle;
}
/**
 * Defines image span style option of RichEditor.
 *
 * @extends RichEditorSpanStyleOptions
 * @interface RichEditorUpdateImageSpanStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorUpdateImageSpanStyleOptions extends RichEditorSpanStyleOptions {
    /**
     * image style.
     *
     * @type { RichEditorImageSpanStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    imageStyle: RichEditorImageSpanStyle;
}
/**
 * Defines symbol span style option of RichEditor.
 *
 * @extends RichEditorSpanStyleOptions
 * @interface RichEditorUpdateSymbolSpanStyleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorUpdateSymbolSpanStyleOptions extends RichEditorSpanStyleOptions {
    /**
     * Update the symbol span style.
     *
     * @type { RichEditorSymbolSpanStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    symbolStyle: RichEditorSymbolSpanStyle;
}
/**
 * Defines the symbol span options of RichEditor.
 *
 * @interface RichEditorSymbolSpanOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorSymbolSpanOptions {
    /**
     * The offset that add custom symbol span at.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offset?: number;
    /**
     * The style that add custom symbol span at.
     *
     * @type { ?RichEditorSymbolSpanStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style?: RichEditorSymbolSpanStyle;
}
/**
 * Defines the text information for editing.
 *
 * @interface RichEditorSelection
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorSelection {
    /**
     * The location info.
     *
     * @type { [number, number] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selection: [
        number,
        number
    ];
    /**
     * The selected text content.
     *
     * @type { Array<RichEditorTextSpanResult | RichEditorImageSpanResult> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    spans: Array<RichEditorTextSpanResult | RichEditorImageSpanResult>;
}
/**
 * Defines the inserted text value info.
 *
 * @interface RichEditorInsertValue
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorInsertValue {
    /**
     * The location info where the value will be inserted.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    insertOffset: number;
    /**
     * The inserted value.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    insertValue: string;
    /**
     * The preview text.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    previewText?: string;
}
/**
 * Provides an interface for deleting value from text.
 *
 * @interface RichEditorDeleteValue
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorDeleteValue {
    /**
     * The offset of deleting.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offset: number;
    /**
     * The deleted direction.
     *
     * @type { RichEditorDeleteDirection }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    direction: RichEditorDeleteDirection;
    /**
     * The deleted text length.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    length: number;
    /**
     * The deleted span object.
     *
     * @type { Array<RichEditorTextSpanResult | RichEditorImageSpanResult> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    richEditorDeleteSpans: Array<RichEditorTextSpanResult | RichEditorImageSpanResult>;
}
/**
 * Provides an interface for changes in the text.
 *
 * @interface RichEditorChangeValue
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorChangeValue {
    /**
     * Range of content that will be replaced.
     *
     * @type { TextRange }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    rangeBefore: TextRange;
    /**
     * Text spans to replace.
     *
     * @type { Array<RichEditorTextSpanResult> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    replacedSpans: Array<RichEditorTextSpanResult>;
    /**
     * Image spans to replace.
     *
     * @type { Array<RichEditorImageSpanResult> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    replacedImageSpans: Array<RichEditorImageSpanResult>;
    /**
     * Symbol spans to replace.
     *
     * @type { Array<RichEditorTextSpanResult> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    replacedSymbolSpans: Array<RichEditorTextSpanResult>;
}
/**
 * Defines the options of RichEditor.
 *
 * @interface RichEditorOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorOptions {
    /**
     * RichEditor controller.
     *
     * @type { RichEditorController }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    controller: RichEditorController;
}
/**
 * Defines the options of RichEditor with StyledString.
 *
 * @interface RichEditorStyledStringOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorStyledStringOptions {
    /**
     * RichEditor controller.
     *
     * @type { RichEditorStyledStringController }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    controller: RichEditorStyledStringController;
}
/**
 * Defines the selection menu options.
 *
 * @interface SelectionMenuOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SelectionMenuOptions {
    /**
     * Callback function when the selection menu appears.
     *
     * @type { ?MenuOnAppearCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAppear?: MenuOnAppearCallback;
    /**
     * Callback function when the selection menu disappears.
     *
     * @type { ?VoidCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDisappear?: VoidCallback;
    /**
     * Menu type, default value is MenuType.SELECTION_MENU.
     *
     * @type { ?MenuType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    menuType?: MenuType;
    /**
     * Callback function when the selection menu is displayed.
     *
     * @type { ?MenuCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onMenuShow?: MenuCallback;
    /**
     * Callback function when the selection menu is hidden.
     *
     * @type { ?MenuCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onMenuHide?: MenuCallback;
    /**
     * Defines the preview menu options.
     *
     * @type { ?PreviewMenuOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    previewMenuOptions?: PreviewMenuOptions;
}
/**
 * Defines the preview menu options.
 *
 * @interface PreviewMenuOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface PreviewMenuOptions {
    /**
     * Defines the haptic feedback mode of preview menu.
     *
     * @type { ?HapticFeedbackMode }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hapticFeedbackMode?: HapticFeedbackMode;
}
/**
 * Provides Base Controller for RichEditor.
 *
 * @implements TextEditControllerEx
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class RichEditorBaseController implements TextEditControllerEx {
    /**
     * Get caret offset from controller.
     *
     * @returns { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getCaretOffset(): number;
    /**
     * Set caret offset.
     *
     * @param { number } offset - caret offset.
     * @returns { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setCaretOffset(offset: number): boolean;
    /**
     * close the select menu when menu is on.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    closeSelectionMenu(): void;
    /**
     * Get the typing text style.
     *
     * @returns { RichEditorTextStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getTypingStyle(): RichEditorTextStyle;
    /**
     * Set the typing text style.
     *
     * @param { RichEditorTextStyle } value - set the typing text style.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setTypingStyle(value: RichEditorTextStyle): void;
    /**
     * Specify the start and end positions to select a range of content.
     *
     * @param { number } selectionStart - The start position of the selected text.
     * @param { number } selectionEnd - The end position of the selected text.
     * @param { SelectionOptions } [options] - Indicates the options of selection.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setSelection(selectionStart: number, selectionEnd: number, options?: SelectionOptions): void;
    /**
     * Judge whether is in editing state
     *
     * @returns { boolean } - true is editing state, false is non editing status
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isEditing(): boolean;
    /**
     * Stop editing state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stopEditing(): void;
    /**
     * Get LayoutManager.
     *
     * @returns { LayoutManager } - Return the LayoutManager.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getLayoutManager(): LayoutManager;
    /**
     * Get PreviewText.
     *
     * @returns { PreviewText } - Return the PreviewText.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getPreviewText(): PreviewText;
    /**
     * Get CaretRect.
     *
     * @returns { RectResult | undefined } - Return the caret rect or undefined value.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getCaretRect(): RectResult | undefined;
}
/**
 * Provides Controller for RichEditor.
 *
 * @extends RichEditorBaseController
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class RichEditorController extends RichEditorBaseController {
    /**
     * Add a text span.
     *
     * @param { ResourceStr } content - text value.
     * @param { RichEditorTextSpanOptions } [options] - span info.
     * @returns { number } span index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    addTextSpan(content: ResourceStr, options?: RichEditorTextSpanOptions): number;
    /**
     * Add a image span.
     *
     * @param { PixelMap | ResourceStr } value - image value.
     * @param { RichEditorImageSpanOptions } [options] - image span info.
     * @returns { number } span index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    addImageSpan(value: PixelMap | ResourceStr, options?: RichEditorImageSpanOptions): number;
    /**
     * Add a builder span.
     *
     * @param { CustomBuilder } value - Indicates the custom builder node
     * @param { RichEditorBuilderSpanOptions } [options] - span option.
     * @returns { number } span index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    addBuilderSpan(value: CustomBuilder, options?: RichEditorBuilderSpanOptions): number;
    /**
     * Add a symbol span.
     *
     * @param { Resource } value - symbol span value
     * @param { RichEditorSymbolSpanOptions } [options] - symbol span option.
     * @returns { number } symbol span index
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    addSymbolSpan(value: Resource, options?: RichEditorSymbolSpanOptions): number;
    /**
     * Modify span style.
     *
     * @param { RichEditorUpdateTextSpanStyleOptions | RichEditorUpdateImageSpanStyleOptions |
     *    RichEditorUpdateSymbolSpanStyleOptions } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    updateSpanStyle(value: RichEditorUpdateTextSpanStyleOptions | RichEditorUpdateImageSpanStyleOptions |
        RichEditorUpdateSymbolSpanStyleOptions): void;
    /**
     * Modify span style.
     *
     * @param { RichEditorParagraphStyleOptions } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    updateParagraphStyle(value: RichEditorParagraphStyleOptions): void;
    /**
     * Delete span.
     *
     * @param { RichEditorRange } [value] - range for deleting.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    deleteSpans(value?: RichEditorRange): void;
    /**
     * Get span content.
     *
     * @param { RichEditorRange } [value] - range for getting span info.
     * @returns { Array<RichEditorImageSpanResult | RichEditorTextSpanResult> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getSpans(value?: RichEditorRange): Array<RichEditorImageSpanResult | RichEditorTextSpanResult>;
    /**
     * Get span content.
     *
     * @param { RichEditorRange } [value] - range for getting span info.
     * @returns { Array<RichEditorParagraphResult> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getParagraphs(value?: RichEditorRange): Array<RichEditorParagraphResult>;
    /**
     * Called when the content is selected.
     *
     * @returns { RichEditorSelection }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getSelection(): RichEditorSelection;
    /**
     * Convert StyledString to spans in rich editor.
     * return a empty Array<RichEditorSpan> if convert failed
     *
     * @param { StyledString } value - StyledString.
     * @returns { Array<RichEditorSpan> }
     * @throws { BusinessError } 401 - The parameter check failed.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fromStyledString(value: StyledString): Array<RichEditorSpan>;
    /**
     * Convert spans to StyledString in rich editor.
     * return a empty StyledString if convert failed
     *
     * @param { RichEditorRange } value - range of spans in rich editor
     * @returns { StyledString }
     * @throws { BusinessError } 401 - The parameter check failed.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    toStyledString(value: RichEditorRange): StyledString;
}
/**
 * Defines the types of spans in rich editor.
 *
 * @typedef { RichEditorImageSpanResult | RichEditorTextSpanResult } RichEditorSpan
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type RichEditorSpan = RichEditorImageSpanResult | RichEditorTextSpanResult;
/**
 * Provides Controller for RichEditor with StyledString.
 *
 * @extends RichEditorBaseController
 * @implements StyledStringController
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class RichEditorStyledStringController extends RichEditorBaseController
    implements StyledStringController {
    /**
     * Set the StyledString of the RichEditor.
     *
     * @param { StyledString } styledString - StyledString.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setStyledString(styledString: StyledString): void;
    /**
     * Get the StyledString of the RichEditor.
     *
     * @returns { MutableStyledString }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getStyledString(): MutableStyledString;
    /**
     * Get the selection in the StyledString of the RichEditor.
     *
     * @returns { RichEditorRange }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getSelection(): RichEditorRange;
    /**
     * Register content changed listener
     *
     * @param { StyledStringChangedListener } listener - content changed listener.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onContentChanged(listener: StyledStringChangedListener): void;
}
/**
 * Provides attribute for RichEditor.
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface RichEditorAttribute extends CommonMethod {
    /**
     * Called when on ready.
     *
     * @param { VoidCallback | undefined } callback - The triggered function when rich editor is ready.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onReady(callback: VoidCallback | undefined): this;
    /**
     * Called when the content is selected.
     *
     * @param { Callback<RichEditorSelection> | undefined } callback - The triggered function when select text.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onSelect(callback: Callback<RichEditorSelection> | undefined): this;
    /**
     * Called when selection range or caret position is changed.
     *
     * @param { Callback<RichEditorRange> | undefined } callback - The triggered function when change selection range or
     *     caret position.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onSelectionChange(callback: Callback<RichEditorRange> | undefined): this;
    /**
     * Get text value information when about to input.
     *
     * @param { Callback<RichEditorInsertValue, boolean> | undefined } callback - The triggered function when text
     *     content is about to insert.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    aboutToIMEInput(callback: Callback<RichEditorInsertValue, boolean> | undefined): this;
    /**
     * Get text value information when completed input.
     *
     * @param { Callback<RichEditorTextSpanResult> | undefined } callback - The triggered function when text content
     *     has been inserted.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onIMEInputComplete(callback: Callback<RichEditorTextSpanResult> | undefined): this;
    /**
     * Called when ime input complete.
     *
     * @param { Callback<TextRange> | undefined } callback - The triggered function when text content has been inserted.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDidIMEInput(callback: Callback<TextRange> | undefined): this;
    /**
     * Get text value information when about to delete.
     *
     * @param { Callback<RichEditorDeleteValue, boolean> | undefined } callback - The triggered function when text
     *     content is about to delete.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    aboutToDelete(callback: Callback<RichEditorDeleteValue, boolean> | undefined): this;
    /**
     * Notify that the deletion has been completed
     *
     * @param { VoidCallback | undefined } callback - The triggered function when text content has been deleted.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDeleteComplete(callback: VoidCallback | undefined): this;
    /**
     * Allow replication.
     *
     * @param { CopyOptions | undefined } value - Indicates the type of copy option.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    copyOptions(value: CopyOptions | undefined): this;
    /**
     * Bind to the selection menu.
     *
     * @param { RichEditorSpanType | undefined } spanType - Indicates the type of selection menu.
     * @param { CustomBuilder | undefined } content - Indicates the content of selection menu.
     * @param { ResponseType | RichEditorResponseType | undefined } responseType - Indicates response type of
     *     selection menu.
     * @param { SelectionMenuOptions | undefined } [options] - Indicates the options of selection menu.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    bindSelectionMenu(spanType: RichEditorSpanType | undefined, content: CustomBuilder | undefined,
        responseType: ResponseType | RichEditorResponseType | undefined,
        options?: SelectionMenuOptions | undefined): this;
    /**
     * Define custom keyboard.
     *
     * @param { CustomBuilder | undefined } value - Set up a custom keyboard of RichEditor
     * @param { KeyboardOptions | undefined } [options] - Indicates the custom keyboard options of RichEditor
     * @returns { RichEditorAttribute } returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    customKeyboard(value: CustomBuilder | undefined, options?: KeyboardOptions | undefined): this;
    /**
     * Defines onPaste callback.
     *
     * @param { PasteEventCallback | undefined } callback Executed when a paste operation is performed.
     * @returns { RichEditorAttribute } returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onPaste(callback: PasteEventCallback | undefined): this;
    /**
     * Enable data detector.
     *
     * @param { boolean | undefined } enable - Enable data detector.
     * @returns { RichEditorAttribute } The attribute of the rich editor.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableDataDetector(enable: boolean | undefined): this;
    /**
     * Enable preview text.
     *
     * @param { boolean | undefined } enable - Enable preview text.
     * @returns { RichEditorAttribute } The attribute of the rich editor.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enablePreviewText(enable: boolean | undefined): this;
    /**
     * Data detector with config.
     *
     * @param { TextDataDetectorConfig | undefined } config - The config of text data detector.
     * @returns { RichEditorAttribute } The attribute of the rich editor.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    dataDetectorConfig(config: TextDataDetectorConfig | undefined): this;
    /**
     * Set richEditor placeholder.
     *
     * @param { ResourceStr | undefined } value - The value of placeholder.
     * @param { PlaceholderStyle | undefined } [style] - The style of placeholder.
     * @returns { RichEditorAttribute } The attribute of the rich editor.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    placeholder(value: ResourceStr | undefined, style?: PlaceholderStyle | undefined): this;
    /**
     * Set caret color of rich editor.
     *
     * @param { ResourceColor | undefined } value - Custom color types.
     * @returns { RichEditorAttribute } The attribute of the rich editor.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    caretColor(value: ResourceColor | undefined): this;
    /**
     * Set background color of selected text in rich editor.
     *
     * @param { ResourceColor | undefined } value - Custom color types.
     * @returns { RichEditorAttribute } The attribute of the rich editor.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedBackgroundColor(value: ResourceColor | undefined): this;
    /**
     * Called when edit status is changed
     *
     * @param { Callback<boolean> | undefined } callback - when edit status is changed
     * @returns { RichEditorAttribute } returns The attribute of the rich editor.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onEditingChange(callback: Callback<boolean> | undefined): this;
    /**
     * Set enter key type of soft keyboard.
     *
     * @param { EnterKeyType | undefined } value - the enter key type of soft keyboard
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enterKeyType(value: EnterKeyType | undefined): this;
    /**
     * Called when submitted.
     *
     * @param { SubmitCallback | undefined } callback - callback of the listened event.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onSubmit(callback: SubmitCallback | undefined): this;
    /**
     * Called before text changed.
     *
     * @param { Callback<RichEditorChangeValue, boolean> | undefined } callback - The triggered function before text
     *     content is about to change.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onWillChange(callback: Callback<RichEditorChangeValue, boolean> | undefined): this;
    /**
     * Called after text changed.
     *
     * @param { OnDidChangeCallback | undefined } callback - The triggered function after content changed.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDidChange(callback: OnDidChangeCallback | undefined): this;
    /**
     * Called before the cut event.
     *
     * @param { Callback<CutEvent> | undefined } callback - Called before the cut event.
     * @returns { RichEditorAttribute } returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onCut(callback: Callback<CutEvent> | undefined): this;
    /**
     * Called before the copy event.
     *
     * @param { Callback<CopyEvent> | undefined } callback - Called before the copy event.
     * @returns { RichEditorAttribute } returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onCopy(callback: Callback<CopyEvent> | undefined): this;
    /**
     * Set the custom text menu.
     *
     * @param { EditMenuOptions | undefined } editMenu - Customize text menu options.
     * @returns { RichEditorAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    editMenuOptions(editMenu: EditMenuOptions | undefined): this;
    /**
     * Sets whether request keyboard or not when on focus.
     *
     * @param { boolean | undefined } isEnabled - Whether enable request keyboard when on focus.
     * @returns { RichEditorAttribute } Returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableKeyboardOnFocus(isEnabled: boolean | undefined): this;
    /**
     * Enable or disable haptic feedback.
     *
     * @param { boolean | undefined } isEnabled - Default value is true, set false to disable haptic feedback.
     * @returns { RichEditorAttribute } returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableHapticFeedback(isEnabled: boolean | undefined): this;
    /**
     * Define bar state of the RichEditor.
     *
     * @param { BarState | undefined } state - bar state.
     * @returns { RichEditorAttribute } returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barState(state: BarState | undefined): this;
    /**
     * Define the max length content of the richEditor.
     *
     * @param { Optional<number> } maxLength - The maximun length content of the richEditor.
     * @returns { RichEditorAttribute }  returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    maxLength(maxLength: number | undefined): this;
    /**
     * Define max lines of the richEditor.
     *
     * @param { Optional<number> } maxLines - The maximun Lines of the richEditor.
     * @returns { RichEditorAttribute } returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    maxLines(maxLines: number | undefined): this;
    /**
     * Set the keyboard appearance.
     *
     * @param { Optional<KeyboardAppearance> } appearance - Default value is KeyboardAppearance.NONE_IMMERSIVE
     * @returns { RichEditorAttribute } returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    keyboardAppearance(appearance: KeyboardAppearance | undefined): this;
    /**
     * Set whether stop backPressed callback event or not.
     *
     * @param { Optional<boolean> } isStopped - Default value is true, set false to trigger the latest callback event.
     * @returns { RichEditorAttribute } returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stopBackPress(isStopped: boolean | undefined): this;
    /**
     * Sets the attribute modifier.
     *
     * @param { AttributeModifier<RichEditorAttribute> | AttributeModifier<CommonMethod> | undefined } modifier.
     * @returns { RichEditorAttribute } returns the instance of the RichEditorAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */    
    attributeModifier(modifier: AttributeModifier<RichEditorAttribute> | AttributeModifier<CommonMethod> |
        undefined): this;
}
/**
 * the callback of cut event.
 * @interface CutEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CutEvent {
    /**
     * Prevent system cut event.
     *
     * @type { ?VoidCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    preventDefault?: VoidCallback;
}
/**
 * the callback of copy event.
 * @interface CopyEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CopyEvent {
    /**
     * Prevent system cut event.
     *
     * @type { ?VoidCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    preventDefault?: VoidCallback;
}
/**
 * RichEditor url style.
 * @interface RichEditorUrlStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface RichEditorUrlStyle {
    /**
     * uniform resoure locator.
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    url?: ResourceStr;
}
/**
 * callback of the listened enter key event.
 *
 * @typedef { function } SubmitCallback
 * @param { EnterKeyType } enterKey - the enter key type of soft keyboard.
 * @param { SubmitEvent } event - Provides the method of keeping RichEditor editable state when submitted.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type SubmitCallback = (enterKey: EnterKeyType, event: SubmitEvent) => void;
/**
 * Callback function when the selection menu appears.
 *
 * @typedef { function } MenuOnAppearCallback
 * @param { number } start - Start offset of the selected content in rich editor.
 * @param { number } end - End offset of the selected content in rich editor.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type MenuOnAppearCallback = (start: number, end: number) => void;
/**
 * Callback function when the selection menu show or hide.
 *
 * @typedef { function } MenuCallback
 * @param { number } start - Start offset of the selected content in rich editor.
 * @param { number } end - End offset of the selected content in rich editor.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type MenuCallback = (start: number, end: number) => void;
/**
 * Callback function when a paste operation is performed.
 *
 * @typedef { function } PasteEventCallback
 * @param { PasteEvent } [event] - The paste event.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type PasteEventCallback = (event?: PasteEvent) => void;
/**
 * callback of the on hover event.
 *
 * @typedef { function } OnHoverCallback
 * @param { boolean } status - The hover status
 * @param { HoverEvent } event - The event info for hover.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnHoverCallback = (status: boolean, event: HoverEvent) => void;

/**
 * Defines RichEditor Component.
 *
 * @param { RichEditorOptions | RichEditorStyledStringOptions } [options]
 * @param { function } [content_]
 * @returns { RichEditorAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
@memo
@ComponentBuilder
export declare function RichEditor(
    options: RichEditorOptions | RichEditorStyledStringOptions, 
    @memo
    content_?: () => void,
): RichEditorAttribute