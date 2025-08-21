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
import { CancelButtonSymbolOptions, CancelButtonOptions } from "./search";
import { Callback, CommonMethod, TextContentControllerBase, SelectionOptions, InputCounterOptions, TextDecorationOptions, Optional, Bindable, AttributeModifier } from "./common";
import { CustomBuilder } from './builder';
import { BarState, LineBreakStrategy, TextAlign, FontStyle, FontWeight, WordBreak, TextOverflow, CopyOptions, TextHeightAdaptivePolicy, TextContentStyle, EllipsisMode } from "./enums";
import { Resource, ResourceStr, ResourceColor, Dimension, Font, Length } from "./units";
import { InsertValue, DeleteValue, CaretStyle, EditableTextOnChangeCallback, EditMenuOptions, AutoCapitalizationMode, EditableTextChangeValue, KeyboardAppearance } from "./textCommon";
import { KeyboardOptions, PasteEvent } from "./richEditor";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
/**
 * Declare the type of input box
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum InputType {
    /**
     * Basic input mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Normal,
    /**
     * Pure digital input mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Number,
    /**
     * Phone number entry mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PhoneNumber,
    /**
     * E-mail address input mode.
     *
     * <p><strong>NOTE</strong>:
     * <br>This mode accepts only digits, letters, underscores (_), dots (.),
     * and the following special characters: ! # $ % & ' " * + - / = ? ^ ` { | } ~ @ (which can only appear once)
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Email,
    /**
     * Password entry mode.
     *
     * <p><strong>NOTE</strong>:
     * <br>An eye icon is used to show or hide the password.
     * <br>By default, the entered characters are temporarily shown before being obscured by dots;
     * they are directly obscured by dots since API version 12 on certain devices.
     * <br>The password input mode does not support underlines.
     * <br>If Password Vault is enabled, autofill is available for the username and password.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Password,
    /**
     * Number Password entry mode.
     *
     * <p><strong>NOTE</strong>:
     * <br>An eye icon is used to show or hide the password.
     * <br>By default, the entered characters are temporarily shown before being obscured by dots;
     * they are directly obscured by dots since API version 12 on certain devices.
     * <br>The password input mode does not support underlines.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NUMBER_PASSWORD = 8,
    /**
     * Screen Lock Password entry mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    SCREEN_LOCK_PASSWORD = 9,
    /**
     * UserName entry mode.
     *
     * <p><strong>NOTE</strong>:
     * <br>If Password Vault is enabled, autofill is available for the username and password.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    USER_NAME = 10,
    /**
     * NewPassword entry mode.
     *
     * <p><strong>NOTE</strong>:
     * <br>An eye icon is used to show or hide the password.
     * <br>By default, the entered characters are temporarily shown before being obscured by dots;
     * they are directly obscured by dots since API version 12 on certain devices.
     * <br>If Password Vault is enabled, a new password can be automatically generated.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NEW_PASSWORD = 11,
    /**
     * Number decimal entry mode.
     *
     * <p><strong>NOTE</strong>:
     * <br>The value can contain digits and one decimal point.
     * </p>
     *
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
 * Declare the type of input content
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ContentType {
    /**
     * User name content type.
     * Password Vault, when enabled, can automatically save and fill in usernames.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    USER_NAME = 0,
    /**
     * Password content type.
     * Password Vault, when enabled, can automatically save and fill in passwords.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PASSWORD = 1,
    /**
     * New password content type.
     * Password Vault, when enabled, can automatically generate a new password.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NEW_PASSWORD = 2,
    /**
     * Full street address content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in full street addresses.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FULL_STREET_ADDRESS = 3,
    /**
     * House number content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in house numbers.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HOUSE_NUMBER = 4,
    /**
     * District address content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in districts and counties.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DISTRICT_ADDRESS = 5,
    /**
     * City address content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in cities.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CITY_ADDRESS = 6,
    /**
     * Province address content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in provinces.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PROVINCE_ADDRESS = 7,
    /**
     * Country address content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in countries.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    COUNTRY_ADDRESS = 8,
    /**
     * Person full name content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in full names.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PERSON_FULL_NAME = 9,
    /**
     * Person last name content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in last names.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PERSON_LAST_NAME = 10,
    /**
     * Person first name content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in first names.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PERSON_FIRST_NAME = 11,
    /**
     * Phone number content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in phone numbers.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PHONE_NUMBER = 12,
    /**
     * Phone country code content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in country codes.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PHONE_COUNTRY_CODE = 13,
    /**
     * Full phone number content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in phone numbers with country codes.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FULL_PHONE_NUMBER = 14,
    /**
     * Email address content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in email addresses.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    EMAIL_ADDRESS = 15,
    /**
     * Bank card number content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in bank card numbers.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BANK_CARD_NUMBER = 16,
    /**
     * ID card number content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in ID card numbers.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ID_CARD_NUMBER = 17,
    /**
     * Nickname content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in nicknames.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NICKNAME = 23,
    /**
     * Detail info without street content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in address information without street addresses.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DETAIL_INFO_WITHOUT_STREET = 24,
    /**
     * Format address content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in standard addresses.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FORMAT_ADDRESS = 25,
    /**
     * Passport number content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in passport numbers.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PASSPORT_NUMBER = 26,
    /**
     * Passport validity content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in passport validity periods.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    VALIDITY = 27,
    /**
     * Place of issue content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in the place of issue for passports.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ISSUE_AT = 28,
    /**
     * Invoice organization content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in invoice titles.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ORGANIZATION = 29,
    /**
     * Invoice tax id content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in tax IDs.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TAX_ID = 30,
    /**
     * Address city and state content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in locations.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ADDRESS_CITY_AND_STATE = 31,
    /**
     * Airline flight number content type.
     * Currently not supported for automatic saving and auto-filling.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FLIGHT_NUMBER = 32,
    /**
     * License number for drivers content type.
     * Currently not supported for automatic saving and auto-filling.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LICENSE_NUMBER = 33,
    /**
     * License file number for drivers content type.
     * Currently not supported for automatic saving and auto-filling.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LICENSE_FILE_NUMBER = 34,
    /**
     * License plate for vehicles content type.
     * The scenario-based autofill feature, when enabled,
     * can automatically save and fill in license plate numbers.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LICENSE_PLATE = 35,
    /**
     * Engine number for vehicles content type.
     * Currently not supported for automatic saving and auto-filling.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ENGINE_NUMBER = 36,
    /**
     * License chassis number for vehicles content type.
     * Currently not supported for automatic saving and auto-filling.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LICENSE_CHASSIS_NUMBER = 37
}
/**
 * Declare the type of soft keyboard.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum EnterKeyType {
    /**
     * Go.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Go = 2,
    /**
     * Search.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Search = 3,
    /**
     * Send.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Send = 4,
    /**
     * Next.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Next = 5,
    /**
     * Done.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Done = 6,
    /**
     * Showed as 'previous' pattern.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PREVIOUS = 7,
    /**
     * Showed as 'new line' pattern.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NEW_LINE = 8
}
/**
  * Defines the underline color width property.
  *
  * @interface UnderlineColor
  * @syscap SystemCapability.ArkUI.ArkUI.Full
  * @since 20
  */
export declare interface UnderlineColor {
    /**
      * Typing underline color width property.
      *
      * <p><strong>NOTE</strong>:
      * <br>If no value is specified or if the value specified is undefined,
      * null, or invalid, the default value is used.
      * </p>
      *
      * @type { ?(ResourceColor | undefined) }
      * @syscap SystemCapability.ArkUI.ArkUI.Full
      * @since 20
      */
    typing?: ResourceColor | undefined;
    /**
      * Normal underline color width property.
      *
      * <p><strong>NOTE</strong>:
      * <br>If no value is specified or if the value specified is undefined,
      * null, or invalid, the default value is used.
      * </p>
      *
      * @type { ?(ResourceColor | undefined) }
      * @syscap SystemCapability.ArkUI.ArkUI.Full
      * @since 20
      */
    normal?: ResourceColor | undefined;
    /**
      * Error underline color width property.
      *
      * <p><strong>NOTE</strong>:
      * <br>If no value is specified or if the value specified is undefined,
      * null, or invalid, the default value is used.
      * <br>This option changes the color used in the showCounter attribute
      * when the maximum number of characters is reached.
      * </p>
      *
      * @type { ?(ResourceColor | undefined) }
      * @syscap SystemCapability.ArkUI.ArkUI.Full
      * @since 20
      */
    error?: ResourceColor | undefined;
    /**
      * Disable underline color width property.
      *
      * <p><strong>NOTE</strong>:
      * <br>If no value is specified or if the value specified is undefined,
      * null, or invalid, the default value is used.
      * </p>
      *
      * @type { ?(ResourceColor | undefined) }
      * @syscap SystemCapability.ArkUI.ArkUI.Full
      * @since 20
      */
    disable?: ResourceColor | undefined;
}
/**
 * Provides the method of keeping TextInput editable state when submitted.
 *
 * @interface SubmitEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SubmitEvent {
    /**
     * Keeps TextInput editable state when submitted
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    keepEditableState(): void;
    /**
     * Sets the current value of TextInput.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    text: string;
}
/**
 * Provides the method of switching the cursor position.
 *
 * @extends TextContentControllerBase
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class TextInputController extends TextContentControllerBase {
    /**
     * constructor.
     * A constructor used to create a TextInputController object.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor();
    /**
     * Called when the position of the insertion cursor is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value is less than 0, the value 0 is used.
     * <br>If the value exceeds the text length, the caret is placed at the end of the text.
     * </p>
     *
     * @param { number } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    caretPosition(value: number): void;
    /**
     * Text selection is achieved by specifying the start and end positions of the text.
     *
     * <p><strong>NOTE</strong>:
     * <br>If selectionStart or selectionEnd is set to undefined, the value 0 will be used.
     * <br>If selectionMenuHidden is set to true or a 2-in-1 device is used,
     * calling setTextSelection does not display the context menu even when options is set to MenuPolicy.SHOW.
     * <br>If the selected text contains an emoji,
     * the emoji is selected when its start position is within the text selection range.
     * </p>
     *
     * @param { number } selectionStart - The start position of the selected text.The start position of text in the text box is 0.
     * @param { number } selectionEnd - The end position of the selected text.
     * @param { SelectionOptions } [options] - Indicates the options of the text selection.Default value is MenuPolicy.DEFAULT.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setTextSelection(selectionStart: number, selectionEnd: number, options?: SelectionOptions): void;
    /**
     * Exit edit state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stopEditing(): void;
}
/**
 * Defines the options of TextInput.
 *
 * @interface TextInputOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextInputOptions {
    /**
     * The place holder text string.
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    placeholder?: ResourceStr;
    /**
     * Sets the current value of TextInput.
     *
     * @type { ?(ResourceStr | Bindable<ResourceStr> | Bindable<Resource> | Bindable<string>) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    text?: ResourceStr | Bindable<ResourceStr> | Bindable<Resource> | Bindable<string>;
    /**
     * Called when the position of the insertion cursor is set.
     *
     * @type { ?TextInputController }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    controller?: TextInputController;
}
/**
 * Text input style.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TextInputStyle {
    /**
     * Text input default style.
     *
     * <p><strong>NOTE</strong>:
     * <br>The caret width is fixed at 1.5 vp,
     * and the caret height is subject to the background height and font size of the selected text.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Default,
    /**
     * Text input inline style.
     *
     * <p><strong>NOTE</strong>:
     * <br>The background height of the selected text is the same as the height of the text box.
     * <br>This style is used in scenarios where editing and non-editing states are obvious,
     * for example, renaming in the file list view.
     * <br>The showError attribute is not supported for this style.
     * <br>This style does not allow for text dragging and dropping.
     * </p>
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Inline
}
/**
 * PasswordIcon object.
 *
 * @interface PasswordIcon
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface PasswordIcon {
    /**
     * Define the on icon source of PasswordIcon.
     *
     * <p><strong>NOTE</strong>:
     * <br>Icon that can be used to hide the password in password input mode.
     * <br>The string type can be used to load network images and local images.
     * </p>
     *
     * @type { ?(string | Resource) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onIconSrc?: string | Resource;
    /**
     * Define the off icon source of PasswordIcon.
     *
     * <p><strong>NOTE</strong>:
     * <br>Icon that can be used to show the password in password input mode.
     * <br>The string type can be used to load network images and local images.
     * </p>
     *
     * @type { ?(string | Resource) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offIconSrc?: string | Resource;
}
/**
 * Defines a TextInput callback when onSubmit.
 *
 * Anonymous Object Rectification.
 * @typedef { function } OnSubmitCallback
 * @param { EnterKeyType } enterKey - Input method Enter key type.
 * @param { SubmitEvent } event - The event submitted.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnSubmitCallback = (enterKey: EnterKeyType, event: SubmitEvent) => void;
/**
 * Defines a TextInput callback when onTextSelectionChange.
 *
 * Anonymous Object Rectification.
 * @typedef { function } OnTextSelectionChangeCallback
 * @param { number } selectionStart - The starting position of the selected text, the starting position of the text is 0.
 * @param { number } selectionEnd - The end location of the selected text.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnTextSelectionChangeCallback = (selectionStart: number, selectionEnd: number) => void;
/**
 * Defines a TextInput callback when onContentScroll.
 *
 * Anonymous Object Rectification.
 * @typedef { function } OnContentScrollCallback
 * @param { number } totalOffsetX - The text is offset in px on the horizontal axis of the content area.
 * @param { number } totalOffsetY - The text is offset in px on the vertical axis of the content area.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnContentScrollCallback = (totalOffsetX: number, totalOffsetY: number) => void;
/**
 * Defines a TextInput callback when onPaste.
 *
 * Anonymous Object Rectification.
 * @typedef { function } OnPasteCallback
 * @param { string } content - The text content of the paste.
 * @param { PasteEvent } event - User-defined paste event.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnPasteCallback = (content: string, event: PasteEvent) => void;
/**
 * Defines the TextInput attribute functions.
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface TextInputAttribute extends CommonMethod {
    /**
     * Called when the input type is set.
     *
     * @param { InputType | undefined } value - Default value is InputType.Normal.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default type(value: InputType | undefined): this;
    /**
     * Called when the content type is set.
     *
     * @param { ContentType | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default contentType(value: ContentType | undefined): this;
    /**
     * Called when the color of the placeholder is set.
     *
     * @param { ResourceColor | undefined } value - Default value follows the theme.The default value on wearable devices is '#99ffffff'.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default placeholderColor(value: ResourceColor | undefined): this;
    /**
     * Called when the overflow mode of the font is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>This attribute is only available for the inline input style.
     * <br>Text is clipped at the transition between words.
     * <br>To clip text in the middle of a word, set wordBreak to WordBreak.BREAK_ALL.
     * <br>TextOverflow.None produces the same effect as TextOverflow.Clip.
     * <br>Default value in non-editing state in the inline input style: TextOverflow.Ellipsis.
     * <br>Default value in editing state in the inline input style: TextOverflow.Clip.
     * <br>The TextInput component does not support the TextOverflow.MARQUEE mode.
     * <br>If TextOverflow.MARQUEE is set, the component automatically switches to TextOverflow.Ellipsis
     * for the non-editing state in the inline input style and TextOverflow.Clip
     * for the non-inline input style and the editing state in the inline input style.
     * </p>
     *
     * @param { TextOverflow | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textOverflow(value: TextOverflow | undefined): this;
    /**
     * Specify the indentation of the first line in a text-block.
     *
     * @param { Dimension | undefined } value - The length of text indent.Default value is 0.
     * @returns { TextInputAttribute } The attribute of the text.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textIndent(value: Dimension | undefined): this;
    /**
     * Called when the font property of the placeholder is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>The 'HarmonyOS Sans' font and registered custom fonts are supported.
     * <br>The default value on wearable devices is 18fp.
     * </p>
     *
     * @param { Font | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default placeholderFont(value?: Font | undefined): this;
    /**
     * Called when the type of soft keyboard input button is set.
     *
     * @param { EnterKeyType | undefined } value - Default value is EnterKeyType.Done.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enterKeyType(value: EnterKeyType | undefined): this;
    /**
     * Called when the color of the insertion cursor is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>Since API version 12, this API can be used to set the text handle color, which is the same as the caret color.
     * </p>
     *
     * @param { ResourceColor | undefined } value - Default value is '#007DFF'.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default caretColor(value: ResourceColor | undefined): this;
    /**
     * Called when judging whether the text editing change finished.
     *
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>:
     * <br>The text box is in the editing state when it has the caret placed in it,
     * and is in the non-editing state otherwise.
     * <br>It returns true if the input operation is currently in progress.
     * </p>
     *
     * @param { Callback<boolean> | undefined } callback
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onEditChange(callback: Callback<boolean> | undefined): this;
    /**
     * Called when submitted.
     *
     * Anonymous Object Rectification.
     * @param { OnSubmitCallback | undefined } callback - Callback of the listened event.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onSubmit(callback: OnSubmitCallback | undefined): this;
    /**
     * Called when the input of the input box changes.
     *
     * <p><strong>NOTE</strong>:
     * <br>In this callback, if cursor operations are performed, you need to adjust the cursor logic
     * based on the previewText parameter to ensure it works seamlessly within the preview display scenario.
     * </p>
     *
     * @param { EditableTextOnChangeCallback | undefined } callback
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onChange(callback: EditableTextOnChangeCallback | undefined): this;
    /**
     * Called when the text selection changes.
     *
     * Anonymous Object Rectification.
     * @param { OnTextSelectionChangeCallback | undefined } callback - Callback of the listened event.
     * @returns { TextInputAttribute } Returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onTextSelectionChange(callback: OnTextSelectionChangeCallback | undefined): this;
    /**
     * Called when the content scrolls.
     *
     * Anonymous Object Rectification.
     * @param { OnContentScrollCallback | undefined } callback - Callback of the listened event.
     * @returns { TextInputAttribute } Returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onContentScroll(callback: OnContentScrollCallback | undefined): this;
    /**
     * Called when the input of maximum text length is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>If this attribute is not set or is set to an invalid value, the default value is used.
     * <br>If a decimal number is specified, the integer part is used.
     * </p>
     *
     * @param { number | undefined } value - Default value is Infinity, indicating that there is no upper limit on the number of characters that can be entered.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maxLength(value: number | undefined): this;
    /**
     * Called when the font color is set.
     *
     * @param { ResourceColor | undefined } value - The default value on wearable devices is '#dbffffff'.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontColor(value: ResourceColor | undefined): this;
    /**
     * Called when the font size is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>If fontSize is of the number type, the unit fp is used.
     * <br>The default font size is 16 fp.
     * <br>The value cannot be a percentage.
     * <br>The default value on wearable devices is 18fp.
     * </p>
     *
     * @param { Length | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontSize(value: Length | undefined): this;
    /**
     * Called when the font style of a font is set.
     *
     * @param { FontStyle | undefined } value - Default value is FontStyle.Normal.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontStyle(value: FontStyle | undefined): this;
    /**
    * Called when the font weight is set.
    *
    * @param { number | FontWeight | string | undefined } value
    * @returns { TextInputAttribute }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    default fontWeight(value: number | FontWeight | string | undefined): this;
    /**
     * Called when the font list of text is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>Default font: 'HarmonyOS Sans'
     * <br>The 'HarmonyOS Sans' font and registered custom fonts are supported for applications.
     * <br>Only the 'HarmonyOS Sans' font is supported for widgets.
     * </p>
     *
     * @param { ResourceStr | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontFamily(value: ResourceStr | undefined): this;
    /**
     * Called when the inputFilter of text is set.
     *
     * Anonymous Object Rectification.
     *
     * <p><strong>NOTE</strong>:
     * <br>Only inputs that comply with the regular expression can be displayed.
     * <br>Other inputs are filtered out.
     * <br>The specified regular expression can match single characters, but not strings.
     * <br>Since API version 11, if inputFilter is set and the entered characters are not null,
     * the filtering effect attached to the text box type (specified through the type attribute) does not take effect.
     * </p>
     *
     * @param { ResourceStr | undefined } value
     * @param { Callback<string> | undefined } [error]
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default inputFilter(value: ResourceStr | undefined, error?: Callback<string> | undefined): this;
    /**
     * Called when using the Clipboard menu.
     *
     * Anonymous Object Rectification.
     * @param { Callback<string> | undefined } callback - Callback used to return the copied text content.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onCopy(callback: Callback<string> | undefined): this;
    /**
     * Called when using the Clipboard menu.
     *
     * Anonymous Object Rectification.
     * @param { Callback<string> | undefined } callback
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onCut(callback: Callback<string> | undefined): this;
    /**
     * Called when using the Clipboard menu.
     *
     * Anonymous Object Rectification.
     * @param { OnPasteCallback | undefined } callback - Executed when a paste operation is performed.
     * @returns { TextInputAttribute } Returns the instance of the TextInputAttribute.
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
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default copyOption(value: CopyOptions | undefined): this;
    /**
     * Called when the password show/hide icon is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>This API has effect only when the input type is set to Password,
     * NEWPASSWORD, or NUMBERPASSWORD mode. It does not work in other modes.
     * <br>When in password mode, there may be inconsistency between the backend state of the text box
     * and the frontend application's state management variables.
     * <br>This can cause issues with the icon at the end of the password text box.
     * <br>To avoid such issues, use the onSecurityStateChange callback to sync the states.
     * </p>
     *
     * @param { boolean | undefined } value - Default value is false.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default showPasswordIcon(value: boolean | undefined): this;
    /**
     * Called when the text align is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>Available options are TextAlign.Start, TextAlign.Center, and TextAlign.End.
     * <br>To set vertical alignment for the text, use the align attribute.
     * <br>The align attribute alone does not control the horizontal position of the text.
     * <br>In other words, Alignment.TopStart, Alignment.Top, and Alignment.TopEnd produce the same effect, top-aligning the text;
     * Alignment.Start, Alignment.Center, and Alignment.End produce the same effect, centered-aligning the text vertically;
     * Alignment.BottomStart, Alignment.Bottom, and Alignment.BottomEnd produce the same effect, bottom-aligning the text.
     * </p>
     *
     * @param { TextAlign | undefined } value - Default value is TextAlign.Start.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default textAlign(value: TextAlign | undefined): this;
    /**
     * Text input style
     *
     * <p><strong>NOTE</strong>:
     * <br>The inline input style only supports InputType.Normal.
     * </p>
     *
     * @param { TextInputStyle | TextContentStyle | undefined } value - Text input style.Default value is TextInputStyle.Default.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default style(value: TextInputStyle | TextContentStyle | undefined): this;
    /**
     * Define the caret style of the text input
     *
     * @param { CaretStyle | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default caretStyle(value: CaretStyle | undefined): this;
    /**
     * Define the text selected background color of the text input.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the opacity is not set, a 20% opacity will be used.
     * </p>
     *
     * @param { ResourceColor | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default selectedBackgroundColor(value: ResourceColor | undefined): this;
    /**
     * Define the caret position of the text input.
     *
     * @param { number | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default caretPosition(value: number | undefined): this;
    /**
     * Sets whether request keyboard or not when on focus.
     * Sets whether to enable the input method when the TextInput component obtains focus in a way other than clicking.
     *
     * <p><strong>NOTE</strong>:
     * <br>Since API version 10, the TextInput component brings up the keyboard by default when it obtains focus.
     * </p>
     *
     * @param { boolean | undefined } value - Default value is true.
     * @returns { TextInputAttribute } Returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableKeyboardOnFocus(value: boolean | undefined): this;
    /**
     * Define the password icon of the text input.
     *
     * <p><strong>NOTE</strong>:
     * <br>Images in JPG, PNG, BMP, HEIC, and WEBP formats are supported.
     * <br>By default, the system-provided icon is used.
     * <br>The icon size is fixed at 24 vp (or 28 vp on wearable devices), regardless of the source image size.
     * </p>
     *
     * @param { PasswordIcon | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default passwordIcon(value: PasswordIcon | undefined): this;
    /**
     * Define the show error of the text input.
     *
     * <p><strong>NOTE</strong>:
     * <br>On wearable devices, the error message is displayed at a font size of 13 fp and center-aligned.
     * <br>If the data type is ResourceStr and the input content does not comply with specifications, the error message is displayed.
     * <br>If the error message does not fit in one line, an ellipsis (…) is displayed to represent clipped text.
     * <br>If the data type is undefined, no error message is displayed.
     * <br>By default, no error message is displayed.
     * </p>
     *
     * @param { ResourceStr | undefined } [value]
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default showError(value?: ResourceStr | undefined): this;
    /**
     * Define the show unit of the text input.
     *
     * <p><strong>NOTE</strong>:
     * <br>This attribute effective only when showUnderline is set to true.
     * </p>
     *
     * @param { CustomBuilder | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default showUnit(value: CustomBuilder | undefined): this;
    /**
     * Define the show underline of the text input.
     *
     * <p><strong>NOTE</strong>:
     * <br>By default, the underline comes in the color of '#33182431', thickness of 1 px, and text box size of 48 vp.
     * <br>The underline is only available for the InputType.Normal type.
     * </p>
     *
     * @param { boolean | undefined } value - Default value is false.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default showUnderline(value: boolean | undefined): this;
    /**
     * Define the underline color of the text input.
     *
     * <p><strong>NOTE</strong>:
     * <br>The underline color changes with the underline mode.
     * <br>If the underline color is only set for the normal state, you can directly enter a value of the ResourceColor type.
     * <br>If the value specified is undefined, null, or invalid, all underlines are restored to the default value.
     * <br>Default value: underline color configured for the theme, which is #33182431 by default.
     * </p>
     *
     * @param { ResourceColor | UnderlineColor | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default underlineColor(value: ResourceColor | UnderlineColor | undefined): this;
    /**
     * Controls whether the selection menu pops up.
     *
     * <p><strong>NOTE</strong>:
     * <br><em>true</em>:
     * <br>The system text selection menu does not appear under the following circumstances:
     * clicking the text box cursor, long-pressing the text box, double-tapping the text box,
     * triple-tapping the text box, or right-clicking the text box.
     * <br><em>false</em>:
     * <br>The system text selection menu appears under the following circumstances:
     * clicking the text box cursor, long-pressing the text box, double-tapping the text box,
     * triple-tapping the text box, or right-clicking the text box.
     * </p>
     *
     * @param { boolean | undefined } value - Default value is false.
     * @returns { TextInputAttribute } returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default selectionMenuHidden(value: boolean | undefined): this;
    /**
     * Define bar state of the text input.
     *
     * @param { BarState | undefined } value - Default value is BarState.Auto.
     * @returns { TextInputAttribute } returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default barState(value: BarState | undefined): this;
    /**
     * Define max lines of the text input.
     * Value range: (0, +∞)
     *
     * @param { number | undefined } value - Default value is 3.
     * @returns { TextInputAttribute } returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maxLines(value: number | undefined): this;
    /**
     * Set the text inline style word break type.
     *
     * <p><strong>NOTE</strong>:
     * <br>This attribute is effective for the inline input style,
     * but does not apply to the placeholder text.
     * <br>The component does not support the clip attribute.
     * <br>Therefore, setting this attribute does not affect text clipping.
     * </p>
     *
     * @param { WordBreak | undefined } value - The word break type.Default value is WordBreak.BREAK_WORD.
     * @returns { TextInputAttribute } returns the instance of the TextInputAttribute.
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
     * <br>This attribute does not take effect for the non-inline input style.
     * </p>
     *
     * @param { LineBreakStrategy | undefined } strategy - The text line break strategy type.Default value is LineBreakStrategy.GREEDY.
     * @returns { TextInputAttribute } The attribute of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default lineBreakStrategy(strategy: LineBreakStrategy | undefined): this;
    /**
     * Define custom keyboard of the text input.
     *
     * <p><strong>NOTE</strong>:
     * <br>When a custom keyboard is set, activating the text box opens the specified custom component,
     * instead of the system input method.
     * <br>The custom keyboard's height can be set through the height attribute of the custom component's root node,
     * and its width is fixed at the default value.
     * <br>The custom keyboard is presented by overlaying the original screen,
     * which is not compressed or lifted if avoid mode is not enabled or avoidance is not needed for the text box.
     * <br>The custom keyboard cannot obtain the focus, but it blocks gesture events.
     * <br>By default, the custom keyboard is closed when the input component loses the focus.
     * <br>You can also use the TextInputController.stopEditing API to close the keyboard.
     * <br>When a custom keyboard is set, the text box does not support camera input, even when the device supports.
     * <br>When setting a custom keyboard, you can bind the onKeyPrelme event to prevent input from the physical keyboard.
     * </p>
     *
     * @param { CustomBuilder | undefined } value - Set up a custom keyboard of TextInput
     * @param { KeyboardOptions | undefined } [options] - Indicates the custom keyboard options of TextInput
     * @returns { TextInputAttribute } returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default customKeyboard(value: CustomBuilder | undefined, options?: KeyboardOptions | undefined): this;
    /**
     * Show the counter when the number of characters entered exceeds the threshold through InputCounterOptions.
     *
     * <p><strong>NOTE</strong>:
     * <br>options can be set only when value is set to true, in which case a character counter is displayed below the text box.
     * <br>This attribute must be used together with maxLength.
     * <br>The character counter is displayed in this format: Number of characters entered/Character limit.
     * <br>It is visible when the number of characters entered is greater than the character limit multiplied by the threshold percentage value.
     * <br>If options is not set, the text box border and character counter subscript turn red
     * when the number of characters entered exceeds the limit.
     * <br>If value is set to true and options is set, the text box border and character counter subscript turn red
     * and the text box shakes when the number of characters entered reaches the limit,
     * provided that the value of thresholdPercentage is valid.
     * <br>If highlightBorder is set to false, the text box border does not turn red.
     * <br>By default, highlightBorder is set to true.
     * <br>The character counter is not displayed for text boxes in inline or password input style.
     * </p>
     *
     * @param { boolean | undefined } value - Set showcounter of the text input.
     * @param { InputCounterOptions | undefined } options - Set the percentage of counter.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default showCounter(value: boolean | undefined, options?: InputCounterOptions | undefined): this;
    /**
     * Set the cancel button style
     *
     * @param { CancelButtonOptions | CancelButtonSymbolOptions | undefined } symbolOptions - indicates the style of the cancel button.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default cancelButton(symbolOptions: CancelButtonOptions | CancelButtonSymbolOptions | undefined): this;
    /**
     * Sets selection when on focus.
     *
     * <p><strong>NOTE</strong>:
     * <br>This attribute is not available for the inline input style.
     * </p>
     *
     * @param { boolean | undefined } value - Sets selection or not.Default value is false.
     * @returns { TextInputAttribute } returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default selectAll(value: boolean | undefined): this;
    /**
     * Called when the minimum font size of the font is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>For the string type, numeric string values with optional units,
     * for example, "10" or "10fp", are supported.
     * <br>For the setting to take effect, this attribute must be used together with maxFontSize
     * and maxLines (when the component is in editing state in the inline input style), or layout constraint settings.
     * <br>When the adaptive font size is used, the fontSize settings do not take effect.
     * </p>
     *
     * @param { number | string | Resource | undefined } value -  The unit is fp.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default minFontSize(value: number | string | Resource | undefined): this;
    /**
     * Called when the maximum font size of the font is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>For the string type, numeric string values with optional units,
     * for example, "10" or "10fp", are supported.
     * <br>For the setting to take effect, this attribute must be used together with minFontSize
     * and maxLines (when the component is in editing state in the inline input style), or layout constraint settings.
     * <br>When the adaptive font size is used, the fontSize settings do not take effect.
     * </p>
     *
     * @param { number | string | Resource | undefined } value -  The unit is fp.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maxFontSize(value: number | string | Resource | undefined): this;
    /**
     * Called when the minimum font scale of the font is set.
     *
     * @param { number | Resource | undefined } scale
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default minFontScale(scale: number | Resource | undefined): this;
    /**
     * Called when the maximum font scale of the font is set.
     *
     * @param { number | Resource | undefined } scale
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default maxFontScale(scale: number | Resource | undefined): this;
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
     * <br>If the text can fit in one line with the minFontSize setting,
     * the text will enlarge to the largest possible font size between minFontSize and maxFontSize.</li>
     * <li>TextHeightAdaptivePolicy.LAYOUT_CONSTRAINT_FIRST produces the same effect as TextHeightAdaptivePolicy.MIN_FONT_SIZE_FIRST.</li>
     * </ul>
     * <br>When the component is in the non-inline input style, the three values of TextHeightAdaptivePolicy have the same effect,
     * that is, the text will shrink to a font size between minFontSize and maxFontSize to allow for more content to be shown.
     * <br>If the text box is in inline input style,
     * the font size in the editing state is different from that in the non-editing state.
     * </p>
     *
     * @param { TextHeightAdaptivePolicy | undefined } value - The height adaptive policy.Default value is TextHeightAdaptivePolicy.MAX_LINES_FIRST.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default heightAdaptivePolicy(value: TextHeightAdaptivePolicy | undefined): this;
    /**
     * Sets whether enable auto fill or not.
     *
     * @param { boolean | undefined } value - Indicates the flag whether autofill is enabled.Default value is rue.True: enable, false: disable.
     * @returns { TextInputAttribute } Returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableAutoFill(value: boolean | undefined): this;
    /**
     * Called when the text decoration of the text is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>This attribute does not take effect for the password input mode.
     * </p>
     *
     * @param { TextDecorationOptions | undefined } value - Default value is { type: TextDecorationType.None, color: Color.Black, style: TextDecorationStyle.SOLID }.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default decoration(value: TextDecorationOptions | undefined): this;
    /**
     * Called when the distance between text fonts is set.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value specified is a percentage or 0, the default value is used.
     * <br>For the string type, numeric string values with optional units,
     * for example, "10" or "10fp", are supported.
     * <br>If the value specified is a negative value, the text is compressed.
     * <br>A negative value too small may result in the text being compressed to 0
     * and no content being displayed.
     * </p>
     *
     * @param { number | string | Resource | undefined } value -  The unit is fp.
     * @returns { TextInputAttribute }
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
     * <br>For the string type, numeric string values with optional units, for example, "10" or "10fp", are supported.
     * </p>
     *
     * @param { number | string | Resource | undefined } value
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default lineHeight(value: number | string | Resource | undefined): this;
    /**
     * Define the password rules of the text input.
     *
     * <p><strong>NOTE</strong>:
     * <br>When autofill is used, these rules are transparently transmitted to Password Vault for generating a new password.
     * </p>
     *
     * @param { string | undefined } value - Indicates the password rules.
     * @returns { TextInputAttribute } Returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default passwordRules(value: string | undefined): this;
    /**
     * Set font feature.
     *
     * <p><strong>NOTE</strong>:
     * <br>This attribute is not available when type is set to an enum value that indicates the password input mode,
     * such as Password, NEW_PASSWORD, or NUMBER_PASSWORD.
     * </p>
     *
     * @param { string | undefined } value - The fontFeature.
     * normal | <feature-tag-value>,
     * where <feature-tag-value> = <string> [ <integer> | on | off ], like: "ss01" 0
     * the values of <feature-tag-value> reference to doc of TextInput component
     * number of <feature-tag-value> can be single or multiple, and separated by comma ','.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default fontFeature(value: string | undefined): this;
    /**
     * Define the password visible mode of the text input.
     *
     * <p><strong>NOTE</strong>:
     * <br>This API has effect only when the input type is set to Password, NEWPASSWORD, or NUMBERPASSWORD mode.
     * <br>It does not work in other modes.
     * <br>When in password mode, there may be inconsistency between the backend state of the text box
     * and the frontend application's state management variables.
     * <br>This can cause issues with the icon at the end of the password text box.
     * <br>To avoid such issues, use the onSecurityStateChange callback to sync the states.
     * </p>
     *
     * @param { boolean | undefined } visible - Indicates the password visible mode. Default value is false.
     * @returns { TextInputAttribute } Returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default showPassword(visible: boolean | undefined): this;
    /**
     * Called when changing the password visible mode of the text input.
     *
     * @param { Callback<boolean> | undefined } callback - callback of the password visible mode change event.
     * @returns { TextInputAttribute } Returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onSecurityStateChange(callback: Callback<boolean> | undefined): this;
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
     * @returns { TextInputAttribute }
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
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onDidInsert(callback: Callback<InsertValue> | undefined): this;
    /**
     * Get text value information when about to delete.
     *
     * <p><strong>NOTE</strong>:
     * <br>It returns true if the text is deleted; returns false otherwise.
     * <br>This callback is not called for text preview.
     * <br>It is available only for system input methods.
     * </p>
     *
     * @param { Callback<DeleteValue, boolean> | undefined } callback - The triggered function when text content is about to delete.
     * @returns { TextInputAttribute }
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
     * @returns { TextInputAttribute }
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
     * @returns { TextInputAttribute }
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
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enablePreviewText(enable: boolean | undefined): this;
    /**
     * Enable or disable haptic feedback.
     *
     * @param { boolean | undefined } isEnabled - Default value is true, set false to disable haptic feedback.
     * @returns { TextInputAttribute } returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableHapticFeedback(isEnabled: boolean | undefined): this;
    /**
     * Set text mode of automatic case mode switching.
     *
     * @param { AutoCapitalizationMode | undefined } mode - Automatic case mode switching.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default autoCapitalizationMode(mode: AutoCapitalizationMode | undefined): this;
    /**
     * Set the text with half leading.
     *
     * @param { boolean | undefined } halfLeading
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default halfLeading(halfLeading: boolean | undefined): this;
    /**
     * Set the ellipsis mode.
     *
     * @param { EllipsisMode | undefined } mode - The ellipsis mode.
     * @returns { TextInputAttribute } The attribute of TextInput.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default ellipsisMode(mode: EllipsisMode | undefined): this;
    /**
     * Set whether stop backPressed callback event or not.
     *
     * @param { boolean | undefined } isStopped - Default value is true, set false to trigger the latest callback event.
     * @returns { TextInputAttribute } returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default stopBackPress(isStopped: boolean | undefined): this;
    /**
     * Get text value information when about to change.
     *
     * @param { Callback<EditableTextChangeValue, boolean> | undefined } callback - The triggered function when text content is about to change.
     * @returns { TextInputAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onWillChange(callback: Callback<EditableTextChangeValue, boolean> | undefined): this;
    /**
     * Set the keyboard appearance.
     *
     * @param { KeyboardAppearance | undefined } appearance - Default value is KeyboardAppearance.NONE_IMMERSIVE
     * @returns { TextInputAttribute } returns the instance of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default keyboardAppearance(appearance: KeyboardAppearance | undefined): this;
    /**
     * Sets the attribute modifier.
     *
     * @param { AttributeModifier<TextInputAttribute> | AttributeModifier<CommonMethod> | undefined } modifier.
     * @returns { TextInputAttribute } the attribute of the TextInputAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    attributeModifier(modifier: AttributeModifier<TextInputAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines TextInput Component.
 *
 * @param { TextInputOptions } [value]
 * @param { function } [content_]
 * @returns { TextInputAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
@memo
@ComponentBuilder
export declare function TextInput(
    value?: TextInputOptions, 
    @memo
    content_?: () => void,
): TextInputAttribute