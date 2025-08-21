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
import { ResourceColor, Offset } from './units';
import { CommonMethod, PickerTextStyle, PickerDialogButtonStyle, Rectangle, BlurStyle, ShadowOptions, ShadowStyle, HoverModeAreaType, BackgroundBlurStyleOptions, BackgroundEffectOptions, Optional, Callback, DateTimeOptions, Bindable } from './common';
import { DialogAlignment } from './alertDialog';
import { CrownSensitivity } from "./enums";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Defines the struct of TimePickerResult.
 *
 * @interface TimePickerResult
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TimePickerResult {
    /**
     * Hour portion of the selected time.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hour: number;
    /**
     * Minute portion of the selected time.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    minute: number;
    /**
     * Second portion of the selected time.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    second: number;
}
/**
 * Type of the TimePicker that need to be displayed.
 * @enum {number}
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TimePickerFormat {
    /**
     * Hour and minute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HOUR_MINUTE,
    /**
     * Hour and minute and second
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HOUR_MINUTE_SECOND
}
/**
 * Defines the options of TimePicker.
 *
 * @interface TimePickerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TimePickerOptions {
    /**
     * Specifies the time selector check time.
     *
     * @type { ?(Date | Bindable<Date>) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selected?: Date | Bindable<Date>;
    /**
     * Specifies the format of the TimePicker that need to be displayed.
     *
     * @type { ?TimePickerFormat }
     * @default HOUR_MINUTE
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    format?: TimePickerFormat;
    /**
     * Defines the start time of the time picker.
     *
     * @type { ?Date }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    start?: Date;
    /**
     * Defines the end time of the time picker.
     *
     * @type { ?Date }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    end?: Date;
}
/**
 * Callback of the timePicker time is selected event.
 *
 * @typedef {function} OnTimePickerChangeCallback
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnTimePickerChangeCallback = (result: TimePickerResult) => void;
export declare interface TimePickerAttribute extends CommonMethod {
    /**
     * Time Selector: indicates whether to display the 24-hour clock.
     *
     * @param { boolean } value
     * @returns { TimePickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    useMilitaryTime(value: boolean | undefined): this;
    /**
     * Sets whether to enable the wheel mode.
     * @param { boolean } value - indicates whether to enable the wheel mode.
     * @returns { TimePickerAttribute } the attribute of the time picker
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    loop(value: boolean | undefined): this;
    /**
     * Sets the text style of disappearing items
     *
     * @param { PickerTextStyle } value - indicates the text style of disappearing items.
     * @returns { TimePickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    disappearTextStyle(value: PickerTextStyle | undefined): this;
    /**
     * Sets the text style of normal items
     *
     * @param { PickerTextStyle } value - indicates the text style of normal items.
     * @returns { TimePickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textStyle(value: PickerTextStyle | undefined): this;
    /**
     * Sets the text style of selected items
     *
     * @param { PickerTextStyle } value - indicates the text style of selected items.
     * @returns { TimePickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedTextStyle(value: PickerTextStyle | undefined): this;
    /**
     * Set time format
     *
     * @param { DateTimeOptions } value - indicates the format of the time display.
     * @returns { TimePickerAttribute } the attribute of the time picker
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    dateTimeOptions(value: DateTimeOptions | undefined): this;
    /**
     * This event is triggered when a TimePicker time is selected.
     *
     * @param { Optional<OnTimePickerChangeCallback> } callback
     * @returns { TimePickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onChange(callback: OnTimePickerChangeCallback | undefined): this;
    /**
     * This event is triggered when an item enters the selected area.
     *
     * @param { Callback<TimePickerResult> } callback
     * @returns { TimePickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onEnterSelectedArea(callback: Callback<TimePickerResult> | undefined): this;
    /**
     * Enable or disable haptic feedback.
     *
     * @param { boolean } enable - Default value is true, set false to disable haptic feedback.
     * @returns { TimePickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableHapticFeedback(enable: boolean | undefined): this;
    /**
     * If the attribute is set, the crown rotation sensitivity can be changed.
     *
     * @param { Optional<CrownSensitivity> } sensitivity
     * @returns { TimePickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    digitalCrownSensitivity(sensitivity: CrownSensitivity | undefined): this;
    /**
     * Defines whether the AM/PM option is cascaded with the time in 12-hour mode.
     *
     * @param { boolean } enabled - Default value is false, set true to enable.
     * @returns { TimePickerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableCascade(enabled: boolean | undefined): this;
    attributeModifier(modifier: AttributeModifier<TimePickerAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}
/**
 * Defines the TimePickerDialogOptions for Data Picker Dialog.
 *
 * @extends TimePickerOptions
 * @interface TimePickerDialogOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TimePickerDialogOptions extends TimePickerOptions {
    /**
     * Time Selector: indicates whether to display the 24-hour clock.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    useMilitaryTime?: boolean;
    /**
     * Text style of disappearing items
     *
     * @type { ?PickerTextStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    disappearTextStyle?: PickerTextStyle;
    /**
     * Text style of normal items
     *
     * @type { ?PickerTextStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    textStyle?: PickerTextStyle;
    /**
     * Style of accept button.
     *
     * @type { ?PickerDialogButtonStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    acceptButtonStyle?: PickerDialogButtonStyle;
    /**
     * Style of cancel button.
     *
     * @type { ?PickerDialogButtonStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    cancelButtonStyle?: PickerDialogButtonStyle;
    /**
     * Text style of selected items
     *
     * @type { ?PickerTextStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedTextStyle?: PickerTextStyle;
    /**
     * Mask Region of dialog. The size cannot exceed the main window.
     *
     * @type { ?Rectangle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    maskRect?: Rectangle;
    /**
     * Defines the dialog alignment of the screen.
     *
     * @type { ?DialogAlignment }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    alignment?: DialogAlignment;
    /**
     * Defines the dialog offset.
     *
     * @type { ?Offset }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offset?: Offset;
    /**
     * Called when the OK button in the dialog is clicked.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAccept?: (value: TimePickerResult) => void;
    /**
     * Called when the Cancel button in the dialog is clicked.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onCancel?: () => void;
    /**
     * This event is triggered when a TimePicker Time or time is selected in dialog.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onChange?: (value: TimePickerResult) => void;
    /**
     * This event is triggered when an item enters the selected area in dialog.
     *
     * @type { ?Callback<TimePickerResult> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onEnterSelectedArea?: Callback<TimePickerResult>;
    /**
     * Defines the timePickerDialog's background color
     *
     * @type { ?ResourceColor }
     * @default Color.Transparent
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundColor?: ResourceColor;
    /**
     * Defines the timePickerDialog's background blur Style
     *
     * @type { ?BlurStyle }
     * @default BlurStyle.COMPONENT_ULTRA_THICK
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyle?: BlurStyle;
    /**
     * Defines the timePickerDialog's background blur style with options
     *
     * @type { ?BackgroundBlurStyleOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyleOptions?: BackgroundBlurStyleOptions;
    /**
     * Defines the timePickerDialog's background effect with options
     *
     * @type { ?BackgroundEffectOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundEffect?: BackgroundEffectOptions;
    /**
     * Defines whether the AM/PM option is cascaded with the time in 12-hour mode.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableCascade?: boolean;
    /**
     * Callback function when the dialog appears.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDidAppear?: () => void;
    /**
     * Callback function when the dialog disappears.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onDidDisappear?: () => void;
    /**
     * Callback function before the dialog openAnimation starts.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onWillAppear?: () => void;
    /**
     * Callback function before the dialog closeAnimation starts.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onWillDisappear?: () => void;
    /**
     * Defines the dialog's shadow.
     *
     * @type { ?(ShadowOptions | ShadowStyle) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    shadow?: ShadowOptions | ShadowStyle;
    /**
     * Set time format
     *
     * @type { ?DateTimeOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    dateTimeOptions?: DateTimeOptions;
    /**
     * Defines whether to respond to the hover mode.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableHoverMode?: boolean;
    /**
     * Defines the dialog's display area in hover mode.
     *
     * @type { ?HoverModeAreaType }
     * @default HoverModeAreaType.BOTTOM_SCREEN
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hoverModeArea?: HoverModeAreaType;
    /**
     * Enable or disable haptic feedback.
     *
     * @type { ?boolean }
     * @default true
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableHapticFeedback?: boolean;
}
/**
 * Defines TimePickerDialog which uses show method to show TimePicker dialog.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class TimePickerDialog {
}
/**
 * Defines the TimePicker constructor.
 *
 * @param { TimePickerOptions } options
 * @returns { TimePickerAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function TimePicker(
    options?: TimePickerOptions, 
    @memo
    content_?: () => void,
): TimePickerAttribute