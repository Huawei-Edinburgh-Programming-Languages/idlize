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
import { Resource, ResourceColor, Offset, Dimension, ResourceStr } from './units';
import { CommonMethod, PickerTextStyle, PickerDialogButtonStyle, Rectangle, BlurStyle, ShadowOptions, ShadowStyle, HoverModeAreaType, BackgroundBlurStyleOptions, BackgroundEffectOptions, Optional, Callback, Bindable } from './common';
import { DialogAlignment } from './alertDialog';
import { CrownSensitivity, TextOverflow } from "./enums";
import { LengthMetrics } from './../Graphics';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Define the contents of each selector item.
 *
 * @interface TextPickerRangeContent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextPickerRangeContent {
    /**
     * Image resource.
     * If the value is a string, such as **"/common/hello.png"**, it represents the path to the image.
     *
     * @type { string | Resource }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    icon: string | Resource;
    /**
     * Text information.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the text length exceeds the column width, the text will be truncated.
     * </p>
     *
     * @type { ?(string | Resource) }
     * @default ""
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    text?: string | Resource;
}
/**
 * Define the contents of text cascade picker.
 *
 * @interface TextCascadePickerRangeContent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextCascadePickerRangeContent {
    /**
     * Text information.
     *
     * <p><strong>NOTE</strong>:
     * If the text length exceeds the column width, the text will be truncated.
     * </p>
     *
     * @type { string | Resource }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    text: string | Resource;
    /**
     * Linkage data.
     *
     * @type { ?TextCascadePickerRangeContent[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    children?: TextCascadePickerRangeContent[];
}
/**
 * Defines the options of TextPicker.
 *
 * @interface TextPickerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextPickerOptions {
    /**
     * Data selection range of the picker.
     * Support the display of pictures, text and pictures plus text, or multi column plain text.
     *
     * @type {string[] | string[][] | Resource | TextPickerRangeContent[] | TextCascadePickerRangeContent[]}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    range: string[] | string[][] | Resource | TextPickerRangeContent[] | TextCascadePickerRangeContent[];
    /**
     * Value of the current selection.
     * Only valid when only text is displayed.
     *
     * @type { ?(ResourceStr | ResourceStr[] | Bindable<ResourceStr> | Bindable<ResourceStr[]>) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value?: ResourceStr | ResourceStr[] | Bindable<ResourceStr> | Bindable<ResourceStr[]>;
    /**
     * Current selected subscript.
     *
     * @type { ?(number | number[] | Bindable<number> | Bindable<number[]>) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selected?: number | number[] | Bindable<number> | Bindable<number[]>;
    /**
     * Width of each column in the picker.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the text length exceeds the column width, the text will be truncated.
     * </p>
     *
     * @type { ?LengthMetrics[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    columnWidths?: LengthMetrics[];
}
/**
 * Defines the struct of DividerOptions.
 *
 * @interface DividerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface DividerOptions {
    /**
     * Stroke width of the divider.
     * The unit is vp by default. You can also specify it as px. The percentage type is not supported.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the value is less than 0, the default value is used.
     * <br>The maximum value allowed is half the height of the column.
     * </p>
     *
     * @type { ?Dimension }
     * @default 2.0px
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    strokeWidth?: Dimension;
    /**
     * Color of the divider.
     *
     * @type { ?ResourceColor }
     * @default "#33000000"
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    color?: ResourceColor;
    /**
     * Distance between the divider and the start edge of the picker.
     * The unit is vp by default. You can also specify it as px. The percentage type is not supported.
     *
     * <p><strong>NOTE</strong>:
     * Values less than 0 are invalid. The maximum value allowed is the width of the column.
     * </p>
     *
     * @type { ?Dimension }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    startMargin?: Dimension;
    /**
     * Distance between the divider and the end edge of the picker.
     * The unit is vp by default. You can also specify it as px. The percentage type is not supported.
     *
     * <p><strong>NOTE</strong>:
     * <br>Values less than 0 are invalid. The maximum value allowed is the width of the column.
     * </p>
     *
     * @type { ?Dimension }
     * @default 0
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    endMargin?: Dimension;
}
/**
 * Defines the text style options.
 *
 * @extends PickerTextStyle
 * @interface TextPickerTextStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextPickerTextStyle extends PickerTextStyle {
    /**
     * Minimum font size, used in conjunction with maxFontSize.
     * When minFontSize and maxFontSize are set,
     * the size setting in font is ineffective.
     * The default maximum number of lines is 1,
     * and the default height adaptation mode is MIN_FONT_SIZE_FIRST.
     *
     * @type { ?(number | string | Resource) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    minFontSize?: number | string | Resource;
    /**
     * Maximum font size.
     *
     * @type { ?(number | string | Resource) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    maxFontSize?: number | string | Resource;
    /**
     * Display mode when the text is too long.
     *
     * <p><strong>NOTE</strong>:
     * Ineffective when set to MARQUEE.
     * </p>
     *
     * @type { ?TextOverflow }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    overflow?: TextOverflow;
}
/**
 * Callback of the listened scroll stop event.
 *
 * @typedef {function} TextPickerScrollStopCallback
 * @param { string | string[] } value - Value of the selected item.
 * @param { number | number[] } index - Index of the selected item.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type TextPickerScrollStopCallback = (value: string | string[], index: number | number[]) => void;
/**
 * Callback of TextPicker item is selected event.
 *
 * @typedef {function} OnTextPickerChangeCallback
 * @param { string | string[] } selectItem - Value of the selected item.
 * @param { number | number[] } index - Index of the selected item.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnTextPickerChangeCallback = (selectItem: string | string[], index: number | number[]) => void;
/**
 * Callback of the listened onEnterSelectedArea event.
 *
 * @typedef {function} TextPickerEnterSelectedAreaCallback
 * @param { string | string[] } value - Value of the selected item.
 * @param { number | number[] } index - Index of the selected item.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type TextPickerEnterSelectedAreaCallback = (value: string | string[], index: number | number[]) => void;
export declare interface TextPickerAttribute extends CommonMethod {
    /**
     * Sets the height of each item in the picker.
     *
     * @param { number | string } value - Height of each item in the picker.
     * <br>For the number type, the value range is [0, +∞]. For the string type,
     * <br>only numeric string values, for example, "56", are supported.
     * @returns { TextPickerAttribute }
     * @default 56 vp (selected) and 36 vp (unselected).
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    defaultPickerItemHeight(value: number | string | undefined): this;
    /**
     * Sets whether scrolling is loopable.
     *
     * @param { boolean } value - Whether scrolling is loopable. true: loopable; false: not loopable.
     * @default true
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    canLoop(value: boolean | undefined): this;
    /**
     * Sets the font color, font size, and font weight for the top and bottom items.
     *
     * @param { PickerTextStyle } value - Font color, font size, and font weight of the top and bottom items.
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    disappearTextStyle(value: PickerTextStyle | undefined): this;
    /**
     * Sets the font color, font size, and font weight for all items except the top, bottom, and selected items.
     *
     * @param { PickerTextStyle } value - indicates the text style of normal items.
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textStyle(value: PickerTextStyle | undefined): this;
    /**
     * Sets the font color, font size, and font weight for the selected item.
     *
     * @param { PickerTextStyle } value - Font color, font size, and font weight of the selected item.
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedTextStyle(value: PickerTextStyle | undefined): this;
    /**
     * Sets whether to enable the text style change animation during the scrolling process.
     *
     * @param { boolean } disabled
     * @default false
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    disableTextStyleAnimation(disabled: boolean | undefined): this;
    /**
     * Sets the style of the text items when the text style change animation during the scrolling process is disabled.
     *
     * @param { TextPickerTextStyle } style
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    defaultTextStyle(style: TextPickerTextStyle | undefined): this;
    /**
     * Triggered when the text picker snaps to the selected item.
     * Compared to onChange, this API supports the undefined type for the callback parameter.
     *
     * @param { Optional<OnTextPickerChangeCallback> } callback - the callback of onChange.
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onChange(callback: OnTextPickerChangeCallback | undefined): this;
    /**
     * Triggered when the scrolling in the text picker stops.
     * If the scrolling is initiated by a gesture,
     * this event is triggered when the finger is lifted from the screen and the scrolling stops.
     *
     * @param { TextPickerScrollStopCallback } callback - Triggered when the scrolling
     * <br>in the text picker stops.
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onScrollStop(callback: TextPickerScrollStopCallback | undefined): this;
    /**
     * Triggered during the scrolling of the text picker when an item enters the divider area.
     * When the picker contains text only or a combination of images and text,
     * value indicates the text of the selected item. When the picker contains images only, value is empty.
     *
     * @param { TextPickerEnterSelectedAreaCallback } callback - Triggered during the scrolling of
     * <br>the text picker when an item enters the divider area.
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onEnterSelectedArea(callback: TextPickerEnterSelectedAreaCallback | undefined): this;
    /**
     * Sets the index of the default selected item in the array.
     * Its priority is higher than that of the selected value in options.
     * For a single-column picker, use a value of the number type.
     * For a multi-column (linked) picker, use a value of the number[] type.
     *
     * @param { number | number[] } value - Index of the default selected item in the array.
     * @default 0
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedIndex(value: number | number[] | undefined): this;
    /**
     * Sets the divider style.
     *
     * @param { DividerOptions | null } value
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    divider(value: DividerOptions | null | undefined): this;
    /**
     * Sets the height for the fade effect.
     * If this attribute is not set, the default fade effect is displayed.
     *
     * <p><strong>NOTE</strong>:
     * <br>Avoid changing the attribute data during the animation process of this component.
     * </p>
     *
     * @param { Dimension } value - Height of the fade effect at the top and bottom edges of the content area.
     * @default 36vp
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    gradientHeight(value: Dimension | undefined): this;
    /**
     * Specifies whether to enable haptic feedback.
     *
     * @param { Optional<boolean> } enable - Whether to enable haptic feedback.
     * @default true
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableHapticFeedback(enable: boolean | undefined): this;
    /**
     * Sets the sensitivity to the digital crown rotation.
     *
     * @param { Optional<CrownSensitivity> } sensitivity - Sensitivity to the digital crown rotation.
     * @default CrownSensitivity.MEDIUM
     * @returns { TextPickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    digitalCrownSensitivity(sensitivity: CrownSensitivity | undefined): this;
    attributeModifier(modifier: AttributeModifier<TextPickerAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Defines the struct of TextPickerResult.
 *
 * @interface TextPickerResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextPickerResult {
    /**
     * The currently selected value.
     * Only valid when only text is displayed.When picture or picture plus text is displayed, the value of value is "".
     *
     * @type { string | string[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: string | string[];
    /**
     * The subscript of the current selection.
     *
     * @type { number | number[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    index: number | number[];
}
/**
 * Defines the TextPickerDialogOptions for Text Picker Dialog.
 *
 * @extends TextPickerOptions
 * @interface TextPickerDialogOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TextPickerDialogOptions extends TextPickerOptions {
    /**
     * Height of the picker item.
     *
     * @type { ?(number | string) }
     * @default 56 vp (selected) and 36 vp (unselected)
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    defaultPickerItemHeight?: number | string;
    /**
     * Whether to support scroll looping.
     * The value true means to support scroll looping, and false means the opposite.
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    canLoop?: boolean;
    /**
     * Font color, font size, and font weight of the top and bottom items.
     *
     * @type { ?PickerTextStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    disappearTextStyle?: PickerTextStyle;
    /**
     * Font color, font size, and font weight of all items except the top, bottom, and selected items.
     *
     * @type { ?PickerTextStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textStyle?: PickerTextStyle;
    /**
     * Style of accept button.
     *
     * <p><strong>NOTE</strong>:
     * <br>In the acceptButtonStyle and cancelButtonStyle configurations,
     * <br>only one primary field can be set to true at most.
     * <br>If both the primary fields are set to true, neither will take effect.
     * </p>
     *
     * @type { ?PickerDialogButtonStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    acceptButtonStyle?: PickerDialogButtonStyle;
    /**
     * Style of cancel button.
     *
     * <p><strong>NOTE</strong>:
     * <br>In the acceptButtonStyle and cancelButtonStyle configurations,
     * <br>only one primary field can be set to true at most.
     * <br>If both the primary fields are set to true, neither will take effect.
     * </p>
     *
     * @type { ?PickerDialogButtonStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    cancelButtonStyle?: PickerDialogButtonStyle;
    /**
     * Font color, font size, and font weight of the selected item.
     *
     * @type { ?PickerTextStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedTextStyle?: PickerTextStyle;
    /**
     * Sets whether to enable the text style change animation during the scrolling process.
     * true: Disable the text style change animation.
     * false: Enable the text style change animation.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    disableTextStyleAnimation?: boolean;
    /**
     * Style of the text items when the text style change animation during the scrolling process is disabled.
     *
     * <p><strong>NOTE</strong>:
     * <br>It is effective only when disableTextStyleAnimation is true.
     * </p>
     *
     * @type { ?TextPickerTextStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    defaultTextStyle?: TextPickerTextStyle;
    /**
     * Callback invoked when the OK button in the dialog box is clicked.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAccept?: (value: TextPickerResult) => void;
    /**
     * Callback invoked when the Cancel button in the dialog box is clicked.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onCancel?: () => void;
    /**
     * Callback invoked when the text picker in the dialog box snaps to the selected item.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onChange?: (value: TextPickerResult) => void;
    /**
     * Callback invoked when the scrolling in the text picker of the dialog box stops.
     *
     * @type { ?Callback<TextPickerResult> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onScrollStop?: Callback<TextPickerResult>;
    /**
     * Represents the callback triggered during the scrolling of the text picker when an item enters the divider area.
     * Compared to the onChange event, this event is triggered earlier,
     * specifically when the scroll distance of the current column exceeds half the height of the selected item,
     * which indicates that the item has entered the divider area.
     *
     * <p><strong>NOTE</strong>:
     * <br>In scenarios where the picker contains linked columns,
     * <br>the use of this callback is not recommended.
     * <br>The reason is that it identifies nodes where items enter the divider area during scrolling.
     * <br>However, items that change in response to the scrolling do not themselves scroll. As a result,
     * <br>he callback's return values will only reflect changes for the currently scrolling column,
     * <br>while other non-scrolling columns will remain unchanged.
     * </p>
     *
     * @type { ?Callback<TextPickerResult> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onEnterSelectedArea?: Callback<TextPickerResult>;
    /**
     * Mask area of the dialog box.
     * Events outside the mask area are transparently transmitted, and events within the mask area are not.
     *
     * @type { ?Rectangle }
     * @default { x: 0, y: 0, width: '100%', height: '100%' }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    maskRect?: Rectangle;
    /**
     * Alignment mode of the dialog box in the vertical direction.
     *
     * @type { ?DialogAlignment }
     * @default DialogAlignment.Default
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    alignment?: DialogAlignment;
    /**
     * Offset of the dialog box based on the alignment settings.
     *
     * @type { ?Offset }
     * @default { dx: 0 , dy: 0 }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offset?: Offset;
    /**
     * Backplane color of the dialog box.
     *
     * @type { ?ResourceColor }
     * @default Color.Transparent
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundColor?: ResourceColor;
    /**
     * Background blur style of the dialog box.
     *
     * @type { ?BlurStyle }
     * @default BlurStyle.COMPONENT_ULTRA_THICK
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyle?: BlurStyle;
    /**
     * Options for customizing the background blur style.
     *
     * @type { ?BackgroundBlurStyleOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyleOptions?: BackgroundBlurStyleOptions;
    /**
     * Options for customizing the background effect.
     *
     * @type { ?BackgroundEffectOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundEffect?: BackgroundEffectOptions;
    /**
     * Event callback when the dialog box appears.
     *
     * <p><strong>NOTE</strong>:
     * <br>1. The normal timing sequence is as follows:
     * onWillAppear > onDidAppear > (onAccept/onCancel/onChange/onScrollStop) > onWillDisappear > onDidDisappear.
     * <br>2. You can set the callback event for changing the dialog box display effect in onDidAppear.
     * The settings take effect next time the dialog box appears.
     * <br>3. If the user closes the dialog box immediately after it appears,
     * onWillDisappearis invoked before onDidAppear.
     * <br>4. If the dialog box is closed before its entrance animation is finished, this callback is not invoked.
     * </p>
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDidAppear?: () => void;
    /**
     * Event callback when the dialog box disappears.
     *
     * <p><strong>NOTE</strong>:
     * <br>The normal timing sequence is as follows:
     * <br>onWillAppear > onDidAppear > (onAccept/onCancel/onChange/onScrollStop) > onWillDisappear > onDidDisappear.
     * </p>
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDidDisappear?: () => void;
    /**
     * Event callback when the dialog box is about to appear.
     *
     * <p><strong>NOTE</strong>:
     * <br>1. The normal timing sequence is as follows:
     * <br>onWillAppear > onDidAppear > (onAccept/onCancel/onChange/onScrollStop) > onWillDisappear > onDidDisappear.
     * <br>2. You can set the callback event for changing the dialog box display effect in onWillAppear.
     * <br>the settings take effect next time the dialog box appears.
     * </p>
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onWillAppear?: () => void;
    /**
     * Event callback when the dialog box is about to disappear.
     *
     * <p><strong>NOTE</strong>:
     * <br>1. The normal timing sequence is as follows:
     * onWillAppear > onDidAppear > (onAccept/onCancel/onChange/onScrollStop) > onWillDisappear > onDidDisappear.
     * <br>2. If the user closes the dialog box immediately after it appears,
     * onWillDisappear is invoked before onDidAppear.
     * </p>
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onWillDisappear?: () => void;
    /**
     * Shadow of the dialog box.
     * Default value on 2-in-1 devices: ShadowStyle.OUTER_FLOATING_MD when the dialog box is focused
     * and ShadowStyle.OUTER_FLOATING_SM otherwise.
     *
     * @type { ?(ShadowOptions | ShadowStyle) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    shadow?: ShadowOptions | ShadowStyle;
    /**
     * Whether to enable the hover mode.
     *
     * @type { ?boolean }
     * @default false - meaning not to enable the hover mode.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableHoverMode?: boolean;
    /**
     * Display area of the dialog box in hover mode.
     *
     * @type { ?HoverModeAreaType }
     * @default HoverModeAreaType.BOTTOM_SCREEN
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hoverModeArea?: HoverModeAreaType;
    /**
     * Whether to enable haptic feedback.
     * true (default): Haptic feedback is enabled.
     * false: Haptic feedback is disabled.
     *
     * <p><strong>NOTE</strong>:
     * <br>To enable haptic feedback, you must declare the ohos.permission.VIBRATE permission
     * <br>under requestPermissions in the module.json5 file of the project.
     * <br>"requestPermissions": [{"name": "ohos.permission.VIBRATE"}].
     * </p>
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableHapticFeedback?: boolean;
}
/**
 * A text picker dialog box is a dialog box that allows users to select text from the given range.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class TextPickerDialog {
}
/**
 * Defines the TextPicker constructor.
 *
 * @param { TextPickerOptions } options
 * @returns { TextPickerAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function TextPicker(
    options?: TextPickerOptions, 
    @memo
    content_?: () => void,
): TextPickerAttribute