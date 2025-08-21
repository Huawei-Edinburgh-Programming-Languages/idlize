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
import { TextContentControllerBase, SelectionOptions, Callback, CommonMethod, Optional, TextDecorationOptions, Bindable, AttributeModifier } from "./common";
import { CustomBuilder } from './builder';
import { ResourceStr, Length, ResourceColor, Dimension, Font } from "./units";
import { CaretStyle, EditableTextOnChangeCallback, InsertValue, DeleteValue, EditMenuOptions, KeyboardAppearance, EditableTextChangeValue, AutoCapitalizationMode } from "./textCommon";
import { EnterKeyType, OnTextSelectionChangeCallback, OnContentScrollCallback, OnPasteCallback, SubmitEvent } from "./textInput";
import { CopyOptions, TextAlign } from "./enums";
import { KeyboardOptions } from "./richEditor";
import { Resource } from '../../global/resource';
import { SymbolGlyphModifier } from '../SymbolGlyphModifier';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";

/**
 * Provides the method of switching the cursor position.
 *
 * @extends TextContentControllerBase
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class SearchController extends TextContentControllerBase {
    /**
     * constructor.
     * A constructor used to create a SearchController object.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor();
    /**
     * Called when the position of the insertion cursor is set.
     *
     * @param { number } value - Length from the start of the character string to the position where the caret is located.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    caretPosition(value: number): void;
    /**
     * Exit edit state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stopEditing(): void;
    /**
     * Text selection is achieved by specifying the start and end positions of the text.
     *
     * <p><strong>NOTE</strong>:
     * <br>If selectionStart or selectionEnd is set to undefined, the value 0 will be used.
     * <br>If <em>selectionMenuHidden</em> is set to <em>true</em> or a 2-in-1 device is used,
     * calling setTextSelection does not display the context menu even when options is set to <em>MenuPolicy.SHOW</em>.
     * <br>If the selected text contains an emoji, the emoji is selected when its start position is within the text selection range.
     * <br>Sets the text selection range and highlights the selected text when the component is focused.
     * <br>This API works only when the value of selectionStart is less than that of selectionEnd.
     * </p>
     *
     * @param { number } selectionStart - The start position of the selected text.
     * The start position of text in the text box is 0.
     * A value less than 0 is handled as 0.
     * A value greater than the maximum text length is handled as the maximum text length.
     * @param { number } selectionEnd - The end position of the selected text.
     * A value less than 0 is handled as the value 0.
     * A value greater than the maximum text length is handled as the maximum text length.
     * @param { SelectionOptions } [options] - Indicates the options of the text selection.Default value is MenuPolicy.DEFAULT.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setTextSelection(selectionStart: number, selectionEnd: number, options?: SelectionOptions): void;
}
/**
 * Enum for the style of cancel button
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum CancelButtonStyle {
    /**
     * The value of button style constant
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CONSTANT,
    /**
     * The value of button style invisible
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    INVISIBLE,
    /**
     * The value of button style input
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    INPUT
}
/**
 * Declare the type of search input box
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SearchType {
    /**
     * Basic input mode.
     * The value can contain digits, letters, underscores (_), spaces, and special characters.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NORMAL = 0,
    /**
     * Pure digital input mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NUMBER = 2,
    /**
     * Phone number entry mode.
     * In this mode, the following are allowed: digits, spaces, plus signs (+), hyphens (-), asterisks (*), and number signs (#);
     * the length is not limited.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PHONE_NUMBER = 3,
    /**
     * E-mail address input mode.
     * This mode accepts only digits, letters, underscores (_), dots (.),
     * and the following special characters: ! # $ % & ' * + - / = ? ^ ` { | } ~ @ (which can only appear once)
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    EMAIL = 5,
    /**
     * Number decimal entry mode.
     * The value can contain digits and one decimal point.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NUMBER_DECIMAL = 12,
    /**
     * URL entry mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    URL = 13
}
/**
 * Options used to construct the search.
 *
 * Anonymous Object Rectification.
 * @typedef SearchOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SearchOptions {
    /**
     * Text input in the search text box.
     *
     * @type { ?(string | Bindable<string>)}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value?: string | Bindable<string>;
    /**
     * Text displayed when there is no input.
     *
     * Anonymous Object Rectification.
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    placeholder?: ResourceStr;
    /**
     * Path to the search icon.
     *
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>:
     * <br>The icon data source can be a local or online image.
     * <ul>
     * <li>The supported formats include PNG, JPG, BMP, SVG, GIF, pixelmap, and HEIF.</li>
     * <li>The Base64 string is supported in the following format:
     * data:image/[png|jpeg|bmp|webp|heif];base64,[base64 data], where [base64 data] is a Base64 string.</li>
     * </ul>
     * <br>If this attribute and the searchIcon attribute are both set, the searchIcon attribute takes precedence.
     * </p>
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    icon?: string;
    /**
     * Controller of the <Search> component.
     *
     * Anonymous Object Rectification.
     * @type { ?SearchController }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    controller?: SearchController;
}
/**
 * Defines the icon options
 *
 * @interface IconOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface IconOptions {
    /**
     * Set the icon size
     *
     * <p><strong>NOTE</strong>:
     * <br>It cannot be set in percentage.
     * </p>
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    size?: Length;
    /**
     * Set the icon color
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    color?: ResourceColor;
    /**
     * Set the icon resource
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    src?: ResourceStr;
}
/**
 * Defines the SearchButton options
 *
 * @interface SearchButtonOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface SearchButtonOptions {
    /**
     * Set the SearchButton fontSize
     *
     * <p><strong>NOTE</strong>:
     * <br>It cannot be set in percentage.
     * </p>
     *
     * @type { ?Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontSize?: Length;
    /**
     * Set the SearchButton fontColor
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fontColor?: ResourceColor;
    /**
     * Automatically disables the search button before the user enters text
     *
     * <p><strong>NOTE</strong>:
     * <br><em>true</em>: The search button is disabled when there is no text input.
     * <br><em>false</em>: The search button remains enabled regardless of the text input.
     * </p>
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    autoDisable?: boolean;
}
/**
 * Defines the CancelButton options
 *
 * @interface CancelButtonOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface CancelButtonOptions {
    /**
     * Set the CancelButton style
     * Display state of the Cancel button on the right.
     *
     * @type { ?CancelButtonStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style?: CancelButtonStyle;
    /**
     * Set the CancelButton icon
     * Icon of the Cancel button on the right.
     *
     * @type { ?IconOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    icon?: IconOptions;
}
/**
 * Defines the CancelButton symbol options
 *
 * @interface CancelButtonSymbolOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface CancelButtonSymbolOptions {
    /**
     * Set the CancelButton style.
     * Display state of the Cancel button on the right.
     *
     * @type { ?CancelButtonStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style?: CancelButtonStyle;
    /**
     * Set the CancelButton symbol icon.
     * Symbol icon of the Cancel button on the right.
     *
     * @type { ?SymbolGlyphModifier }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    icon?: SymbolGlyphModifier;
}
/**
 * Declare the event listener callback of the enter key.
 *
 * @typedef { function } SearchSubmitCallback
 * @param { string } searchContent - The submitted content of search.
 * @param { SubmitEvent } [event] - Provides the method of keeping Search editable state when submitted.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type SearchSubmitCallback = (searchContent: string, event?: SubmitEvent) => void;
/**
 * The attribute function of search
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface SearchAttribute extends CommonMethod {
    /**
     * Set the search button text, fontSize and fontColor
     *
     * @param { string | undefined } value - indicates the text of the search button.
     * @param { SearchButtonOptions | undefined } option - indicates the fontSize and fontColor of the search button.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default searchButton(value: string | undefined, option?: SearchButtonOptions | undefined): this;
    /**
     * Set the text Color
     *
     * <p><strong>NOTE</strong>:
     * <br>Universal text attributes fontSize, fontStyle, fontWeight, and fontFamily are set in the textFont attribute.
     * </p>
     *
     * @param { ResourceColor | undefined } value - indicates the color of the text.Default value is '#FF182431'.The default value on wearable devices is '#dbffffff'.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontColor(value: ResourceColor | undefined): this;
    /**
     * Set the search icon style
     *
     * <p><strong>NOTE</strong>:
     * <br>The default icon size on wearable devices is 16 vp.
     * <br>Default value in light mode:
     * <code>
     * {
     *    size: '16vp',
     *    color: '#99182431',
     *    src: ' '
     * }
     * </code>
     * <br>Default value in dark mode:
     * <code>
     * {
     *    size: '16vp',
     *    color: '#99ffffff',
     *    src: ' '
     * }
     * </code>
     * </p>
     *
     * @param { IconOptions | SymbolGlyphModifier | undefined } value - indicates the style of the search icon.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default searchIcon(value: IconOptions | SymbolGlyphModifier | undefined): this;
    /**
     * Set the cancel button style
     *
     * <p><strong>NOTE</strong>:
     * <br>The default icon size on wearable devices is 18 vp.
     * <br>When style is set to CancelButtonStyle.CONSTANT, the Cancel button is always displayed.
     * <br>Default value:
     * <code>
     * {
     *    style: CancelButtonStyle.INPUT,
     *    icon: {
     *    size: '16vp',
     *    color: '#99ffffff',
     *    src: ' '
     *    }
     * }
     * </code>
     * </p>
     *
     * @param { CancelButtonOptions | CancelButtonSymbolOptions | undefined } value - indicates the style of the cancel button.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default cancelButton(value: CancelButtonOptions | CancelButtonSymbolOptions | undefined): this;
    /**
     * Specify the indentation of the first line in a text-block.
     *
     * @param { Dimension | undefined } value - The length of text indent.Default value is 0.
     * @returns { SearchAttribute } The attribute of the text.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textIndent(value: Dimension | undefined): this;
    /**
     * Called when the inputFilter of text is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>Only inputs that comply with the regular expression can be displayed.
     * <br>Other inputs are filtered out.
     * <br>The specified regular expression can match single characters, but not strings.
     * <br>If inputFilter is set and the entered characters are not null,
     * the filtering effect attached to the text box type (specified through the type attribute) does not take effect.
     * </p>
     *
     * @param { ResourceStr | undefined } value - Regular expression.
     * @param { Callback<string> | undefined } error - Filtered-out content to return when regular expression matching fails.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default inputFilter(value: ResourceStr | undefined, error?: Callback<string> | undefined): this;
    /**
     * Called when judging whether the text editing change finished.
     * The text box is in the editing state when it has the caret placed in it, and is in the non-editing state otherwise.
     *
     * @param { Callback<boolean> | undefined } callback - Returns true if the component is in an editing state.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onEditChange(callback: Callback<boolean> | undefined): this;
    /**
     * Define the text selected background color of the text input.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the opacity is not set, a 20% opacity will be used.
     * </p>
     *
     * @param { ResourceColor | undefined } value
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default selectedBackgroundColor(value: ResourceColor | undefined): this;
    /**
     * Set the cursor style
     *
     * <p><strong>NOTE</strong>:
     * <br>Since API version 12, this API can be used to set the text handle color, which is the same as the caret color.
     * <br>Default value:
     * <code>
     * {
     *    width: '1.5vp',
     *    color: '#007DFF'
     * }
     * </code>
     * </p>
     *
     * @param { CaretStyle | undefined } value - indicates the style of the cursor.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default caretStyle(value: CaretStyle | undefined): this;
    /**
     * Set the place hold text color
     *
     * @param { ResourceColor | undefined } value - Default value is '#99182431'.The default value on wearable devices is '#99ffffff'.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default placeholderColor(value: ResourceColor | undefined): this;
    /**
     * Set the font used for place holder text
     *
     * <p><strong>NOTE</strong>:
     * <br>The 'HarmonyOS Sans' font and registered custom fonts are supported.
     * <br>The default font size on wearable devices is 18 px.
     * </p>
     *
     * @param { Font | undefined } value
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default placeholderFont(value?: Font | undefined): this;
    /**
     * Set the font used for input text
     *
     * <p><strong>NOTE</strong>:
     * <br>Currently, only the default font family is supported.
     * <br>The default font size on wearable devices is 18 fp.
     * </p>
     *
     * @param { Font | undefined } value
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textFont(value?: Font | undefined): this;
    /**
     * Set enter key type of soft keyboard
     *
     * @param { EnterKeyType | undefined } value - Default value is EnterKeyType.Search.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enterKeyType(value: EnterKeyType | undefined): this;
    /**
     * Call the function when clicked the search button.
     *
     * @param { Callback<string> | SearchSubmitCallback | undefined } callback - callback of the listened event.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onSubmit(callback: Callback<string> | SearchSubmitCallback | undefined): this;
    /**
     * Call the function when editing the input text
     *
     * <p><strong>NOTE</strong>:
     * <br>In this callback, if cursor operations are performed,
     * developers need to adjust the cursor logic based on the previewText parameter to ensure it works seamlessly within the preview display scenario.
     * </p>
     *
     * @param { EditableTextOnChangeCallback | undefined } callback
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onChange(callback: EditableTextOnChangeCallback | undefined): this;
    /**
     * Called when the text selection changes.
     *
     * Anonymous Object Rectification.
     * @param { OnTextSelectionChangeCallback | undefined } callback - Callback of the listened event.
     * @returns { SearchAttribute } Returns the instance of the SearchAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onTextSelectionChange(callback: OnTextSelectionChangeCallback | undefined): this;
    /**
     * Called when the content scrolls.
     *
     * Anonymous Object Rectification.
     * @param { OnContentScrollCallback | undefined } callback - Callback of the listened event.
     * @returns { SearchAttribute } Returns the instance of the SearchAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onContentScroll(callback: OnContentScrollCallback | undefined): this;
    /**
     * Called when using the Clipboard menu.
     *
     * Anonymous Object Rectification.
     * @param { Callback<string> | undefined } callback - Callback used to return the copied text content.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onCopy(callback: Callback<string> | undefined): this;
    /**
     * Called when using the Clipboard menu.
     *
     * Anonymous Object Rectification.
     * @param { Callback<string> | undefined } callback - Callback used to return the cut text content.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onCut(callback: Callback<string> | undefined): this;
    /**
     * Called when using the Clipboard menu.
     *
     * Anonymous Object Rectification.
     * @param { OnPasteCallback | undefined } callback - Executed when a paste operation is performed.Callback used to return the pasted text content.
     * @returns { SearchAttribute } Returns the instance of the SearchAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onPaste(callback: OnPasteCallback | undefined): this;
    /**
     * Called when the copy option is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>If this attribute is set to CopyOptions.None, the text can only be pasted;
     * all other actions, such as copying, cutting, and sharing, are disabled.
     * <br>Dragging is not allowed when CopyOptions.None is set.
     * </p>
     *
     * @param { CopyOptions | undefined } value - Default value is CopyOptions.LocalDevice.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default copyOption(value: CopyOptions | undefined): this;
    /**
     * Called when the input of maximum text length is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>By default, there is no maximum number of characters.
     * <br>When the maximum number is reached, no more characters can be entered.
     * </p>
     *
     * @param { number | undefined } value
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maxLength(value: number | undefined): this;
    /**
     * Called when the text align is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>Currently, the following alignment modes are supported: Start, Center, and End.
     * </p>
     *
     * @param { TextAlign | undefined } value - Default value is TextAlign.Start.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textAlign(value: TextAlign | undefined): this;
    /**
     * Sets whether request keyboard or not when on focus.
     *
     * <p><strong>NOTE</strong>:
     * <br>Since API version 10, the Search component brings up the keyboard by default when it obtains focus.
     * </p>
     *
     * @param { boolean | undefined } value - Default value is true.
     * @returns { SearchAttribute } Returns the instance of the SearchAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableKeyboardOnFocus(value: boolean | undefined): this;
    /**
     * Controls whether the selection menu pops up.
     *
     * <p><strong>NOTE</strong>:
     * <br><em>true</em>: Tapping, long-pressing, double-tapping, triple-tapping,
     * or right-clicking the text box will not trigger the system text selection menu.
     * <br><em>false</em>: Tapping, long-pressing, double-tapping, triple-tapping,
     * or right-clicking the text box will trigger the system text selection menu.
     * </p>
     *
     * @param { boolean | undefined } value - Default value is false.
     * @returns { SearchAttribute } returns the instance of the SearchAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default selectionMenuHidden(value: boolean | undefined): this;
    /**
     * Called when the minimum font size of the font is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>For the string type, numeric string values with optional units, for example, "10" or "10fp", are supported.
     * <br>For the setting to take effect, this attribute must be used together with maxFontSize or layout constraint settings.
     * <br>When the adaptive font size is used, the fontSize settings do not take effect.
     * </p>
     *
     * @param { number | string | Resource | undefined } value - The unit is fp.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default minFontSize(value: number | string | Resource | undefined): this;
    /**
     * Called when the maximum font size of the font is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>For the string type, numeric string values with optional units, for example, "10" or "10fp", are supported.
     * <br>For the setting to take effect, this attribute must be used together with minFontSize or layout constraint settings.
     * <br>When the adaptive font size is used, the fontSize settings do not take effect.
     * </p>
     *
     * @param { number | string | Resource | undefined } value - The unit is fp.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maxFontSize(value: number | string | Resource | undefined): this;
    /**
     * Called when the minimum font scale of the font is set.
     * Value range: [0, 1]
     *
     * <p><strong>NOTE</strong>:
     * <br>The undefined type is supported.
     * <br>A value less than 0 is handled as 0.
     * <br>A value greater than 1 is handled as 1.
     * <br>Abnormal values are ineffective by default.
     * </p>
     *
     * @param { number | Resource | undefined } scale
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default minFontScale(scale: number | Resource | undefined): this;
    /**
     * Called when the maximum font scale of the font is set.
     * Value range: [1, +∞)
     *
     * <p><strong>NOTE</strong>:
     * <br>The undefined type is supported.
     * <br>A value less than 1 is handled as 1.
     * <br>Abnormal values are ineffective by default.
     * </p>
     *
     * @param { number | Resource | undefined } scale
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maxFontScale(scale: number | Resource | undefined): this;
    /**
     * Define custom keyboard.
     *
     * <p><strong>NOTE</strong>:
     * <br>When a custom keyboard is set, activating the text box opens the specified custom component,
     * instead of the system input method.
     * <br>The custom keyboard's height can be set through the height attribute of the custom component's root node,
     * and its width is fixed at the default value.
     * <br>The custom keyboard is presented by overlaying the original screen.
     * <br>It is not compressed or lifted if avoid mode is not enabled or avoidance is not needed for the text box.
     * <br>The custom keyboard cannot obtain the focus, but it blocks gesture events.
     * <br>By default, the custom keyboard is closed when the input component loses the focus.
     * <br>You can also use the stopEditing API to close the keyboard.
     * <br>When a custom keyboard is set, the text box does not support camera input, even when the device supports.
     * <br>When setting a custom keyboard, you can bind the onKeyPrelme event to prevent input from the physical keyboard.
     * </p>
     *
     * @param { CustomBuilder | undefined } value - Set up a custom keyboard of Search
     * @param { KeyboardOptions | undefined } [options] - Indicates the custom keyboard options of Search
     * @returns { SearchAttribute } returns the instance of the SearchAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default customKeyboard(value: CustomBuilder | undefined, options?: KeyboardOptions | undefined): this;
    /**
     * Called when the text decoration of the text is set.
     *
     * @param { TextDecorationOptions | undefined } value - Default value is { type: TextDecorationType.None, color: Color.Black, style: TextDecorationStyle.SOLID }.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default decoration(value: TextDecorationOptions | undefined): this;
    /**
     * Called when the distance between text fonts is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value specified is a percentage or 0, the default value is used.
     * <br>For the string type, numeric string values with optional units, for example, "10" or "10fp", are supported.
     * <br>If the value specified is a negative value, the text is compressed.
     * <br>A negative value too small may result in the text being compressed to 0 and no content being displayed.
     * </p>
     *
     * @param { number | string | Resource | undefined } value - The unit is fp.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default letterSpacing(value: number | string | Resource | undefined): this;
    /**
     * Called when the line height of the font is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value is less than or equal to 0, the line height is not limited and the font size is adaptive.
     * <br>If the value is of the number type, the unit fp is used.
     * </p>
     *
     * @param { number | string | Resource | undefined } value
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default lineHeight(value: number | string | Resource | undefined): this;
    /**
     * Called when the search type is set.
     *
     * @param { SearchType | undefined } value - Default value is SearchType.Normal.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default type(value: SearchType | undefined): this;
    /**
     * Set font feature.
     *
     * @param { string | undefined } value - The fontFeature.
     * normal | <feature-tag-value>,
     * where <feature-tag-value> = <string> [ <integer> | on | off ], like: "ss01" 0
     * the values of <feature-tag-value> reference to doc of search component
     * number of <feature-tag-value> can be single or multiple, and separated by comma ','.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontFeature(value: string | undefined): this;
    /**
     * Get text value information when about to input.
     *
     * <p><strong>NOTE</strong>:
     * <br>It returns true if the text is inserted; returns false otherwise.
     * <br>This callback is not triggered for pre-edit or candidate word operations.
     * <br>It is available only for system input methods.
     * </p>
     *
     * @param { Callback<InsertValue, boolean> | undefined } callback - The triggered function when text content is about to insert.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onWillInsert(callback: Callback<InsertValue, boolean> | undefined): this;
    /**
     * Get text value information when completed input.
     *
     * <p><strong>NOTE</strong>:
     * <br>It is available only for system input methods.
     * </p>
     *
     * @param { Callback<InsertValue> | undefined } callback - The triggered function when text content has been inserted.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onDidInsert(callback: Callback<InsertValue> | undefined): this;
    /**
     * Get text value information when about to delete.
     *
     * <p><strong>NOTE</strong>:
     * <br>It returns true if the text is deleted; returns false otherwise.
     * <br>This callback is not invoked for text preview.
     * <br>It is available only for system input methods.
     * </p>
     *
     * @param { Callback<DeleteValue, boolean> | undefined } callback - The triggered function when text content is about to delete.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onWillDelete(callback: Callback<DeleteValue, boolean> | undefined): this;
    /**
     * Get text value information when the deletion has been completed
     *
     * <p><strong>NOTE</strong>:
     * <br>It is available only for system input methods.
     * </p>
     *
     * @param { Callback<DeleteValue> | undefined } callback - The triggered function when text content has been deleted.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onDidDelete(callback: Callback<DeleteValue> | undefined): this;
    /**
     * Set the custom text menu.
     * Sets the extended options of the custom context menu on selection,
     * including the text content, icon, and callback.
     *
     * @param { EditMenuOptions | undefined } editMenu - Customize text menu options.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default editMenuOptions(editMenu: EditMenuOptions | undefined): this;
    /**
     * Define the preview text mode of the text input.
     *
     * <p><strong>NOTE</strong>:
     * <br>Preview text is in a temporary state and does not support text interception.
     * <br>As such, it does not trigger onWillInsert, onDidInsert, onWillDelete, or onDidDelete callbacks.
     * </p>
     *
     * @param { boolean | undefined } enable - Indicates the preview text mode.Default value is true.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enablePreviewText(enable: boolean | undefined): this;
    /**
     * Enable or disable haptic feedback.
     *
     * <p><strong>NOTE</strong>:
     * <br>To enable haptic feedback,
     * you must declare the ohos.permission.VIBRATE permission under requestPermissions in the module.json5 file of the project.
     * <code>
     * "requestPermissions": [
     *   {
     *       "name": "ohos.permission.VIBRATE",
     *   }
     * ]
     * </code>
     * </p>
     *
     * @param { boolean | undefined } isEnabled - Default value is true, set false to disable haptic feedback.
     * @returns { SearchAttribute } returns the instance of the SearchAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableHapticFeedback(isEnabled: boolean | undefined): this;
    /**
     * Set text mode of automatic case mode switching.
     *
     * @param { AutoCapitalizationMode | undefined } mode - Automatic case mode switching.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default autoCapitalizationMode(mode: AutoCapitalizationMode | undefined): this;
    /**
     * Set the text with half leading.
     *
     * @param { Optional<boolean> | undefined } halfLeading - Default value is false.The value true means that half leading is enabled, and false means the opposite.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default halfLeading(halfLeading: boolean | undefined): this;
    /**
     * Set whether stop backPressed callback event or not.
     *
     * @param { Optional<boolean> | undefined } isStopped - Default value is true, set false to trigger the latest callback event.
     * @returns { SearchAttribute } returns the instance of the SearchAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default stopBackPress(isStopped: boolean | undefined): this;
    /**
     * Get text value information when about to change.
     *
     * <p><strong>NOTE</strong>:
     * <br>This callback is triggered after onWillInsert and onWillDelete, but before onDidInsert and onDidDelete.
     * </p>
     *
     * @param { Callback<EditableTextChangeValue, boolean> | undefined } callback - The triggered function when text content is about to change.
     * Returning true allows the change to proceed, while returning false cancels the change.
     * @returns { SearchAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onWillChange(callback: Callback<EditableTextChangeValue, boolean> | undefined): this;
    /**
     * Set the keyboard appearance.
     *
     * @param { Optional<KeyboardAppearance> | undefined } appearance - Default value is KeyboardAppearance.NONE_IMMERSIVE
     * @returns { SearchAttribute } returns the instance of the SearchAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default keyboardAppearance(appearance: KeyboardAppearance | undefined): this;
    /**
     * Sets the attribute modifier.
     *
     * @param { AttributeModifier<SearchAttribute> | AttributeModifier<CommonMethod> | undefined } modifier.
     * @returns { SearchAttribute } the attribute of the SearchAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<SearchAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines Search Component.
 *
 * @param { SearchOptions } [options]
 * @param { function } [content_]
 * @returns { SearchAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
@memo
@ComponentBuilder
export declare function Search(
    options?: SearchOptions, 
    @memo
    content_?: () => void,
): SearchAttribute