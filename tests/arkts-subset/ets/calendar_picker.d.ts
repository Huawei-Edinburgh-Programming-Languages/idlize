
declare enum CalendarAlign {
    START = 0,
    CENTER = 1,
    END = 2
}

declare interface CalendarPickerInterface { 
    (): CalendarPickerAttribute
}

declare class CalendarPickerAttribute extends CommonMethod<CalendarPickerAttribute> {
    /**
     * Set the alignment between entry and calendar dialog.
     * @param { CalendarAlign } alignType - The type of alignment between entry and calendar dialog.
     * @param { Offset } offset - The offset between entry and calendar dialog.
     * @returns { CalendarPickerAttribute } the attribute of the CalendarPicker.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Set the alignment between entry and calendar dialog.
     * @param { CalendarAlign } alignType - The type of alignment between entry and calendar dialog.
     * @param { Offset } offset - The offset between entry and calendar dialog.
     * @returns { CalendarPickerAttribute } the attribute of the CalendarPicker.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    edgeAlign(alignType: CalendarAlign, offset?: Offset): CalendarPickerAttribute;

    /**
     * Sets the text style of entry
     * @param { PickerTextStyle } value - indicates the text style of entry.
     * @returns { CalendarPickerAttribute } the attribute of the CalendarPicker.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Sets the text style of entry
     * @param { PickerTextStyle } value - indicates the text style of entry.
     * @returns { CalendarPickerAttribute } the attribute of the CalendarPicker.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    textStyle(value: PickerTextStyle): CalendarPickerAttribute;

    /**
     * Callback for selected date changed.
     * @param { function } callback - Callback for selected date changed.
     * @returns { CalendarPickerAttribute } the attribute of the CalendarPicker.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 10
     */
    /**
     * Callback for selected date changed.
     * @param { function } callback - Callback for selected date changed.
     * @returns { CalendarPickerAttribute } the attribute of the CalendarPicker.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 11
     */
    /**
     * Callback for selected date changed.
     * @param { Callback<Date> } callback - callback for selected date changed.
     * @returns { CalendarPickerAttribute } the attribute of the CalendarPicker.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @atomicservice
     * @since 13
     */
    onChange(callback: Callback<Date>): CalendarPickerAttribute;
}

declare const CalendarPicker: CalendarPickerInterface