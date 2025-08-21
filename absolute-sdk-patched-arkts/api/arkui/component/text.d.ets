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
import { CommonMethod, ShadowOptions, Optional, Callback, AttributeModifier } from "./common";
import { CustomBuilder } from './builder';
import { EllipsisMode, TextCase, LineBreakStrategy, TextAlign, FontStyle, FontWeight, WordBreak, TextOverflow, CopyOptions, TextHeightAdaptivePolicy, TextSelectableMode } from "./enums";
import { Resource, ResourceColor, Font, Length, LengthMetrics } from "./units";
import { TextDataDetectorConfig, LayoutManager, FontSettingOptions, EditMenuOptions } from "./textCommon";
import { DecorationStyleInterface, StyledString } from "./styledString";
import { SelectionMenuOptions } from "./richEditor";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
/**
 * Text overflow options.
 *
 * Anonymous Object Rectification.
 * @interface TextOverflowOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextOverflowOptions {
    /**
     * Text overflow option.
     *
     * Anonymous Object Rectification.
     * @type { TextOverflow }
     * @default TextOverflow.Clip
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    overflow: TextOverflow;
}
/**
 * TextAttribute.
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface TextAttribute extends CommonMethod {
    /**
     * Called when the font is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>It is only effective for the Text component, not for its child components.
     * </p>
     *
     * @param { Font } fontValue - the text font size and weight and family and style.
     * @param { FontSettingOptions } options - font setting options.
     * @returns { TextAttribute } The attribute of the text.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default font(fontValue: Font | undefined, options?: FontSettingOptions | undefined): this;
    /**
     * Called when the font color is set.
     *
     * @param { ResourceColor } value - Default value is '#e6182431'.The default value on wearable devices is '#c5ffffff'.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontColor(value: ResourceColor | undefined): this;
    /**
     * Called when the font size is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>If fontSize is of the number type, the unit fp is used.
     * </p>
     *
     * @param { number | string | Resource } value - Default value is 16fp.The default value on wearable devices is 15fp.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontSize(value: number | string | Resource | undefined): this;
    /**
     * Called when the minimum font size of the font is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>For the string type, numeric string values with optional units, for example, "10" or "10fp", are supported.
     * <br>For the setting to take effect, this attribute must be used together with maxFontSize and maxLines,
     * or layout constraint settings.
     * <br>When the adaptive font size is used, the fontSize settings do not take effect.
     * <br>If the value of minFontSize is less than or equal to 0, font size adaptation does not take effect.
     * <br>In this case, the actual font size is determined by the value of fontSize.
     * <br>If fontSize is not specified, the default value is used.
     * <br>Since API version 18, this attribute takes effect on child components and styled strings,
     * and the adaptive font size is applied to parts where the font size is not set.
     * </p>
     *
     * @param { number | string | Resource } value - The unit is fp.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default minFontSize(value: number | string | Resource | undefined): this;
    /**
     * Called when the maximum font size of the font is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>For the string type, numeric string values with optional units, for example, "10" or "10fp", are supported.
     * <br>For the setting to take effect, this attribute must be used together with minFontSize and maxLines,
     * or layout constraint settings.
     * <br>When the adaptive font size is used, the fontSize settings do not take effect.
     * <br>If the value of maxFontSize is less than or equal to 0, font size adaptation does not take effect.
     * <br>In this case, the actual font size is determined by the value of fontSize.
     * <br>If fontSize is not specified, the default value is used.
     * <br>Since API version 18, this attribute takes effect on child components and styled strings,
     * and the adaptive font size is applied to parts where the font size is not set.
     * </p>
     *
     * @param { number | string | Resource } value - The unit is fp.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maxFontSize(value: number | string | Resource | undefined): this;
    /**
     * Called when the minimum font scale of the font is set.
     * Value range: [0, 1]
     *
     * <p><strong>NOTE</strong>:
     * <br>A value less than 0 is handled as 0.
     * <br>A value greater than 1 is handled as 1.
     * <br>Abnormal values are ineffective by default.
     * </p>
     *
     * @param { number | Resource } scale
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default minFontScale(scale: number | Resource | undefined): this;
    /**
     * Called when the maximum font scale of the font is set.
     * Value range: [1, +∞)
     *
     * <p><strong>NOTE</strong>:
     * <br>A value less than 1 is handled as 1.
     * <br>Abnormal values are ineffective by default.
     * </p>
     *
     * @param { number | Resource  } scale
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maxFontScale(scale: number | Resource | undefined): this;
    /**
     * Called when the font style of a font is set.
     *
     * @param { FontStyle } value - Default value is FontStyle.Normal.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontStyle(value: FontStyle | undefined): this;
    /**
     * Called when the font weight is set.
     *
     * @param { number | FontWeight | string } weight
     * @param { FontSettingOptions } options - font setting options.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontWeight(weight: number | FontWeight | string | undefined, options?: FontSettingOptions | undefined): this;
    /**
     * Set font line spacing.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value specified is less than or equal to 0, the default value 0 is used.
     * </p>
     *
     * @param { LengthMetrics } value - Default value is 0.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default lineSpacing(value: LengthMetrics | undefined): this;
    /**
     * Called when the horizontal center mode of the font is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>The text takes up the full width of the Text component.
     * <br>To set vertical alignment for the text, use the align attribute.
     * <br>The align attribute alone does not control the horizontal position of the text.
     * <br>In other words, Alignment.TopStart, Alignment.Top, and Alignment.TopEnd produce the same effect,
     * top-aligning the text; Alignment.Start, Alignment.Center, and Alignment.End produce the same effect,
     * centered-aligning the text vertically; Alignment.BottomStart, Alignment.Bottom,
     * and Alignment.BottomEnd produce the same effect, bottom-aligning the text.
     * <br>When textAlign is set to TextAlign.JUSTIFY, you must set the wordBreak attribute,
     * and the text in the last line is horizontally aligned with the start edge.
     * </p>
     *
     * @param { TextAlign } value - Default value is TextAlign.Start.The default value on wearable devices is TextAlign.Center.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textAlign(value: TextAlign | undefined): this;
    /**
     * Called when the vertical center mode of the font is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value is less than or equal to 0, the line height is not limited and the font size is adaptive.
     * <br>If the value is of the number type, the unit fp is used.
     * <br>For the string type, numeric string values with optional units, for example, "10" or "10fp", are supported.
     * </p>
     *
     * @param { number | string | Resource } value
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default lineHeight(value: number | string | Resource | undefined): this;
    /**
     * Called when the overflow mode of the font is set.
     *
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>:
     * <br>Text is clipped at the transition between words.
     * <br>To clip text in the middle of a word, add \u200B between characters.
     * <br>Since API version 11, preferably set the wordBreak attribute to WordBreak.BREAK_ALL to achieve the same purpose.
     * <br>If overflow is set to TextOverflow.None, TextOverflow.Clip, or TextOverflow.Ellipsis,
     * this attribute must be used with maxLines for the settings to take effect.
     * <br>TextOverflow.None produces the same effect as TextOverflow.Clip.
     * <br>If overflow is set to TextOverflow.MARQUEE, the text scrolls in a line, and neither maxLines nor copyOption takes effect.
     * <br>The textAlign attribute takes effect only when the text is not scrollable.
     * <br>With overflow set to TextOverflow.MARQUEE, the clip attribute is set to true by default.
     * <br>TextOverflow.MARQUEE is not available for CustomSpan of the styled string.
     * <br>Since API version 12, TextOverflow.MARQUEE is available for the ImageSpan component,
     * where the text and images are displayed in scrolling mode in a line.
     * </p>
     *
     * @param { TextOverflowOptions } options - Text overflow options.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textOverflow(options: TextOverflowOptions | undefined): this;
    /**
     * Called when the font list of text is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>Default font: 'HarmonyOS Sans'
     * <br>The 'HarmonyOS Sans' font and registered custom fonts are supported for applications.
     * <br>Only the 'HarmonyOS Sans' font is supported for widgets.
     * </p>
     *
     * @param { string | Resource } value
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontFamily(value: string | Resource | undefined): this;
    /**
     * Called when the maximum number of lines of text is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>By default, text is automatically folded.
     * <br>If this attribute is specified, the text will not exceed the specified number of lines.
     * <br>If there is extra text, you can use textOverflow to specify how it is displayed.
     * </p>
     *
     * @param { number } value
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maxLines(value: number | undefined): this;
    /**
     * Called when the text decoration of the text is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>The style parameter cannot be used in widgets.
     * </p>
     *
     * @param { DecorationStyleInterface } value - Default value is { type: TextDecorationType.None, color: Color.Black, style: TextDecorationStyle.SOLID }.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default decoration(value: DecorationStyleInterface | undefined): this;
    /**
     * Called when the distance between text fonts is set.
     *
     * @param { number | string } value
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default letterSpacing(value: number | string | undefined): this;
    /**
     * Called when the type of letter in the text font is set.
     *
     * @param { TextCase } value - Default value is TextCase.Normal.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textCase(value: TextCase | undefined): this;
    /**
     * Called when the baseline offset is set.
     *
     * @param { number | string } value
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default baselineOffset(value: number | string | undefined): this;
    /**
     * Allow replication.
     *
     * <p><strong>NOTE</strong>:
     * <br>If this attribute is set to CopyOptions.InApp or CopyOptions.LocalDevice,
     * a long press on the text will display a context menu that offers the copy and select-all options.
     * <br>Because widgets do not have the long press event, the context menu will not be displayed when users long press text.
     * </p>
     *
     * @param { CopyOptions } value - Default value is CopyOptions.None.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default copyOption(value: CopyOptions | undefined): this;
    /**
     * Enable the selectable area can be dragged.
     *
     * <p><strong>NOTE</strong>:
     * <br>This attribute cannot be used together with the onDragStart event.
     * <br>It must be used together with CopyOptions.
     * <br>When it is set to true and copyOptions is set to CopyOptions.InApp or CopyOptions.LocalDevice,
     * the selected text can be dragged and copied to the text box.
     * </p>
     *
     * @param { boolean } value - Default value is false.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default draggable(value: boolean | undefined): this;
    /**
     * Called when the text shadow is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>This API does not work with the fill attribute or coloring strategy.
     * </p>
     *
     * @param { ShadowOptions | Array<ShadowOptions> } value - The shadow options.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textShadow(value: ShadowOptions | Array<ShadowOptions> | undefined): this;
    /**
     * Called when the height adaptive policy is set.
     *
     * <p><strong>NOTE</strong>:
     * <ul>
     * <li>When this attribute is set to TextHeightAdaptivePolicy.MAX_LINES_FIRST,
     * the maxLines attribute takes precedence for adjusting the text height.
     * <br>If the maxLines setting results in a layout beyond the layout constraints,
     * the text will shrink to a font size between minFontSize and maxFontSize to allow for more content to be shown.</li>
     * <li>If this attribute is set to TextHeightAdaptivePolicy.MIN_FONT_SIZE_FIRST,
     * the minFontSize attribute takes precedence for adjusting the text height.
     * <br>If the text fits on one line at minFontSize,the system attempts to increase the font size within the range of minFontSize
     * and maxFontSize to display the text as large as possible on one line.
     * <br>If the text cannot fit into a single line even at minFontSize, it sticks with minFontSize.</li>
     * <li>If this attribute is set to TextHeightAdaptivePolicy.LAYOUT_CONSTRAINT_FIRST,
     * the layout constraints take precedence for adjusting the text height.
     * <br>If the resultant layout is beyond the layout constraints,
     * the text will shrink to a font size between minFontSize and maxFontSize to respect the layout constraints.
     * <br>If the text still extends beyond the layout constraints after shrinking to minFontSize,
     * the lines that exceed the constraints are deleted.</li>
     * </ul>
     * </p>
     *
     * @param { TextHeightAdaptivePolicy } value - The height adaptive policy.Default value is TextHeightAdaptivePolicy.MAX_LINES_FIRST.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default heightAdaptivePolicy(value: TextHeightAdaptivePolicy | undefined): this;
    /**
     * Specify the indentation of the first line in a text-block.
     *
     * @param { Length } value - The length of text indent.Default value is 0.
     * @returns { TextAttribute } The attribute of the text.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textIndent(value: Length | undefined): this;
    /**
     * Set the word break type.
     *
     * <p><strong>NOTE</strong>:
     * <br>When used with {overflow: TextOverflow.Ellipsis} and maxLines, WordBreak.BREAK_ALL can insert line breaks
     * between letters when overflow occurs and display excess content with an ellipsis (...).
     * </p>
     *
     * @param { WordBreak } value - The word break type.Default value is WordBreak.BREAK_WORD.
     * @returns { TextAttribute } The attribute of the text.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default wordBreak(value: WordBreak | undefined): this;
    /**
     * Set the text line break strategy type.
     *
     * <p><strong>NOTE</strong>:
     * <br>This attribute takes effect when wordBreak is not set to breakAll.
     * <br>Hyphens are not supported.
     * </p>
     *
     * @param { LineBreakStrategy } strategy - The text line break strategy type.Default value is LineBreakStrategy.GREEDY.
     * @returns { TextAttribute } The attribute of the text.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default lineBreakStrategy(strategy: LineBreakStrategy | undefined): this;
    /**
     * Called when using the Clipboard menu
     * Currently, only text can be copied.
     *
     * @param { function } callback - callback of the listened event.
     * @returns { TextAttribute } The attribute of the text.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onCopy(callback: ((value: string) => void) | undefined): this;
    /**
     * Text selection is achieved by specifying the start and end positions of the text.
     *
     * <p><strong>NOTE</strong>:
     * <br>The selected text is highlighted, and a selection handle is displayed together with a menu of available actions.
     * <br>When copyOption is set to CopyOptions.None, the selection attribute is not effective.
     * <br>When overflow is set to TextOverflow.MARQUEE, the selection attribute is not effective.
     * <br>If the value of selectionStart is greater than or equal to that of selectionEnd, no text will be selected.
     * <br>The value range is [0, textSize], where textSize indicates the maximum number of characters in the text content.
     * <br>If the value is less than 0, the value 0 will be used.
     * <br>If the value is greater than textSize, textSize will be used.
     * <br>If the value of selectionStart or selectionEnd falls within the invisible area, no text will be selected.
     * <br>If clipping is disabled, the text selection outside of the parent component takes effect.
     * </p>
     *
     * @param { number } selectionStart - The start position of the selected text.Default value is -1.
     * @param { number } selectionEnd - The end position of the selected text.Default value is -1.
     * @returns { TextAttribute } The attribute of the text.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default selection(selectionStart: number | undefined, selectionEnd: number | undefined): this;
    /**
     * Set the caret color for the selected text.
     *
     * @param { ResourceColor } color - The color of the selected text caret.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default caretColor(color: ResourceColor | undefined): this;
    /**
     * Set the selected background color of the text.
     *
     * @param { ResourceColor } color - The color of the selected text background.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default selectedBackgroundColor(color: ResourceColor | undefined): this;
    /**
     * Set the ellipsis mode.
     *
     * <p><strong>NOTE</strong>:
     * <br>For the settings to work, overflow must be set to TextOverflow.Ellipsis and maxLines must be specified.
     * <br>Setting ellipsisMode alone does not take effect.
     * <br>EllipsisMode.START and EllipsisMode.CENTER take effect only when text overflows in a single line.
     * </p>
     *
     * @param { EllipsisMode } value - The ellipsis mode.Default value is EllipsisMode.END.
     * @returns { TextAttribute } The attribute of the text.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default ellipsisMode(value: EllipsisMode | undefined): this;
    /**
     * Enable data detector.
     *
     * <p><strong>NOTE</strong>:
     * <br>This API only works on devices that provide text recognition.
     * <br>When enableDataDetector is set to true, and the dataDetectorConfig attribute is not set,
     * all types of entities are recognized by default,
     * and the color and decoration of the recognized entities will be changed to the following styles:
     * <code>
     *   color: '#ff007dff',
     *   decoration:{
     *      type: TextDecorationType.Underline,
     *      color: '#ff007dff',
     *      style: TextDecorationStyle.SOLID
     *   }
     * </code>
     * <br>Touching and right-clicking an entity with the mouse will pop up the corresponding entity operation menu based on the type of entity,
     * while left-clicking an entity with the mouse will directly respond to the first option of the menu.
     * <br>This API does not work when overflow is set to TextOverflow.MARQUEE.
     * <br>When copyOption is set to CopyOptions.None, the menu displayed after an entity is clicked does not provide the text selection,
     * copy, translation, or sharing functionality.
     * <br>When copyOption is not set to CopyOptions.None, and textSelectable is set to TextSelectableMode.UNSELECTABLE,
     * the entity still has the copy functionality but does not have the text selection feature.
     * </p>
     *
     * @param { boolean } enable - Enable data detector.Default value is false.
     * @returns { TextAttribute } The attribute of the text.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableDataDetector(enable: boolean | undefined): this;
    /**
     * Data detector with config.
     *
     * <p><strong>NOTE</strong>:
     * <br>This API must be used together with enableDataDetector.
     * <br>It takes effect only when enableDataDetector is set to true.
     * <br>When entities A and B overlap, the following rules are followed:
     * <ol>
     * <li>If A is a subset of B (A ⊂ B), then B is retained; otherwise, A is retained.</li>
     * <li>If A is not a subset of B (A ⊄ B) and B is not a subset of A (B ⊄ A),
     * and if the starting point of A is earlier than that of B (A.start < B.start),
     * then A is retained; otherwise, B is retained.</li>
     * </ol>
     * </p>
     *
     * @param { TextDataDetectorConfig } config - The config of text data detector.
     * @returns { TextAttribute } The attribute of the text.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default dataDetectorConfig(config: TextDataDetectorConfig | undefined): this;
    /**
     * Bind to the selection menu.
     *
     * <p><strong>NOTE</strong>:
     * <br>The duration required for a long-press gesture is 600 ms for bindSelectionMenu and 800 ms for bindContextMenu.
     * <br>When both bindSelectionMenu and bindContextMenu are set and both are configured to be triggered by a long-press gesture,
     * bindSelectionMenu is triggered first.
     * <br>If the custom menu is too long, embed a Scroll component to prevent the keyboard from being blocked.
     * </p>
     *
     * @param { TextSpanType } spanType - Indicates the type of selection menu.Default value is TextSpanType.TEXT.
     * @param { CustomBuilder } content - Indicates the content of selection menu.
     * @param { TextResponseType } responseType - Indicates response type of selection menu.Default value is TextResponseType.LONG_PRESS.
     * @param { SelectionMenuOptions } [options] - Indicates the options of selection menu.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default bindSelectionMenu(spanType: TextSpanType | undefined, content: CustomBuilder | undefined, responseType: TextResponseType | undefined, options?: SelectionMenuOptions | undefined): this;
    /**
     * Called when the text selection changes.
     *
     * @param { function } callback - callback of the listened event.
     * @returns { TextAttribute } returns the instance of the TextAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onTextSelectionChange(callback: ((selectionStart: number, selectionEnd: number) => void) | undefined): this;
    /**
     * Set font feature.
     *
     * @param { string } value - The fontFeature.
     * normal | <feature-tag-value>,
     * where <feature-tag-value> = <string> [ <integer> | on | off ], like: "ss01" 0
     * the values of <feature-tag-value> reference to doc of text component
     * number of <feature-tag-value> can be single or multiple, and separated by comma ','.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontFeature(value: string | undefined): this;
    /**
     * Set the marquee options.
     *
     * @param { Optional<TextMarqueeOptions> } options
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default marqueeOptions(options: TextMarqueeOptions | undefined): this;
    /**
     * Called when the text marquee state changes.
     *
     * @param { Callback<MarqueeState> } callback - callback of the marquee state change event.
     * @returns { TextAttribute } returns the instance of the TextAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onMarqueeStateChange(callback: Callback<MarqueeState> | undefined): this;
    /**
     * Whether to support sensitive privacy information
     *
     * <p><strong>NOTE</strong>:
     * <br>The value true means to enable privacy mode, in which case text is obscured as hyphens (-).
     * <br>If this parameter is set to null, privacy mode is disabled.
     * <br>Enabling privacy mode requires widget framework support.
     * </p>
     *
     * @param { boolean } supported - Whether to support sensitive privacy information.Default value is false.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default privacySensitive(supported: boolean | undefined): this;
    /**
     * set text selectable and focusable
     *
     * @param { TextSelectableMode } mode - Default value is TextSelectableMode.SELECTABLE_UNFOCUSABLE.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textSelectable(mode: TextSelectableMode | undefined): this;
    /**
     * Set the custom text menu.
     * Sets the extended options of the custom context menu on selection,
     * including the text content, icon, and callback.
     *
     * @param { EditMenuOptions } editMenu - Customize text menu options.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default editMenuOptions(editMenu: EditMenuOptions | undefined): this;
    /**
     * Set the text with half leading.
     *
     * <p><strong>NOTE</strong>:
     * <br>The halfLeading settings configured within the component take precedence over those in module.json5.
     * <br>The value true means that half leading is enabled, and false means the opposite.
     * </p>
     *
     * @param { boolean } halfLeading - Default value is false.
     * @returns { TextAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default halfLeading(halfLeading: boolean | undefined): this;
    /**
     * Enable or disable haptic feedback.
     *
     * @param { boolean } isEnabled - Default value is true, set false to disable haptic feedback.
     * @returns { TextAttribute } returns the instance of the TextAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableHapticFeedback(isEnabled: boolean | undefined): this;
    /**
     * Sets the attribute modifier.
     *
     * @param { AttributeModifier<TextAttribute> | AttributeModifier<CommonMethod> | undefined } modifier.
     * @returns { TextAttribute } the attribute of the TextAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<TextAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Defines span type.
 *
 * <p><strong>NOTE</strong>:
 * <br>The order for menu type matching is as follows.
 * <br>When the user interacts with text, the system follows this order to decides which type of menu to display.
 * <ol>
 * <li>Check whether a menu is registered for TextSpanType.TEXT and TextResponseType.LONG_PRESS.</li>
 * <li>Check whether a menu is registered for TextSpanType.TEXT and TextResponseType.DEFAULT.</li>
 * <li>Check whether a menu is registered for TextSpanType.DEFAULT and TextResponseType.LONG_PRESS.</li>
 * <li>Check whether a menu is registered for TextSpanType.DEFAULT and TextResponseType.DEFAULT.</li>
 * </ol>
 * </p>
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TextSpanType {
    /**
     * Only contains text.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TEXT = 0,
    /**
     * Only contains image.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    IMAGE = 1,
    /**
     * Contains both text and image.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MIXED = 2,
    /**
     * When no other types are explicitly specified, this type will be matched.
     * When this type is registered but TEXT, IMAGE, or MIXED types are not registered,
     * this type will be triggered and displayed for those registered types.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DEFAULT = 3
}
/**
 * ResponseType for contextMenu
 *
 * <p><strong>NOTE</strong>:
 * <br>The order for menu type matching is as follows. When the user interacts with text,
 * the system follows this order to decides which type of menu to display.
 * <ol>
 * <li>Check whether a menu is registered for TextSpanType.TEXT and TextResponseType.LONG_PRESS.</li>
 * <li>Check whether a menu is registered for TextSpanType.TEXT and TextResponseType.DEFAULT.</li>
 * <li>Check whether a menu is registered for TextSpanType.DEFAULT and TextResponseType.LONG_PRESS.</li>
 * <li>Check whether a menu is registered for TextSpanType.DEFAULT and TextResponseType.DEFAULT.</li>
 * </ol>
 * </p>
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TextResponseType {
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
     * When this type is registered but RIGHT_CLICK, LONG_PRESS, or SELECT types are not registered,
     * this type will be triggered and displayed for right-click, long press, and mouse selection actions.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DEFAULT = 3
}
/**
 * Defines marquee state.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum MarqueeState {
    /**
     * The marquee started.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    START = 0,
    /**
     * The marquee a round finished and start next round.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BOUNCE = 1,
    /**
     * The marquee all finished.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FINISH = 2
}
/**
 * Defines marquee start policy.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum MarqueeStartPolicy {
    /**
     * Start marquee in any case. This is the default policy.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DEFAULT = 0,
    /**
     * Start marquee only when get focus.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ON_FOCUS = 1
}
/**
 * Defines the options of Text.
 *
 * @interface TextOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextOptions {
    /**
     * Text controller.
     *
     * @type { TextController }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    controller: TextController;
}
/**
 * Defines the marquee options.
 *
 * @interface TextMarqueeOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextMarqueeOptions {
    /**
     * Is need start marquee.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    start: boolean;
    /**
     * The step size of the marquee.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    step?: number;
    /**
     * The rounds of the marquee.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    loop?: number;
    /**
     * The running direction of the marquee.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fromStart?: boolean;
    /**
     * The waiting time between each round of the marquee.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    delay?: number;
    /**
     * Set whether the text is faded out.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fadeout?: boolean;
    /**
     * The start policy for marquee.
     *
     * @type { ?MarqueeStartPolicy }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    marqueeStartPolicy?: MarqueeStartPolicy;
}
/**
 * Defines the controller of Text.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class TextController {
    /**
     * Close the select menu when menu is on.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    closeSelectionMenu(): void;
    /**
     * Update the styles of StyledString by setStyledString.
     *
     * <p><strong>NOTE</strong>:
     * <br>The child class MutableStyledString of StyledString can also serve as the argument.
     * </p>
     *
     * @param { StyledString } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setStyledString(value: StyledString): void;
    /**
     * Get LayoutManager.
     *
     * @returns { LayoutManager } - Return the LayoutManager.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getLayoutManager(): LayoutManager;
}

/**
 * Defines Text Component.
 *
 * @param { string | Resource } [content]
 * @param { TextOptions } [value]
 * @param { function } [content_]
 * @returns { TextAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
@memo
@ComponentBuilder
export declare function Text(
    content?: string | Resource, value?: TextOptions, 
    @memo
    content_?: () => void,
): TextAttribute