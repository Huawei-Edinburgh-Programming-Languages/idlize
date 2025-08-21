/*
 * Copyright (c) 2021 Huawei Device Co., Ltd.
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
 * @kit LocalizationKit
 */



/**
 * Provides internationalization related APIs.
 *
 * @namespace intl
 * @syscap SystemCapability.Global.I18n
 * @since 20
 */
declare namespace intl {
    
    
    
    /**
     * Defines the options for a DateTimeOptions object. Since API version 9, the DateTimeOptions attribute is changed
     * from mandatory to optional.
     *
     * @interface DateTimeOptions
     * @syscap SystemCapability.Global.I18n
     * @since 20
     * @deprecated since 20
     * @useinstead Intl.DateTimeFormatOptions
     */
    export interface DateTimeOptions {
        
        
        
        
        /**
         * Valid locale ID, for example, "zh-Hans-CN". The default value is the current system locale.
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         */
        locale?: string;
        
        
        
        
        /**
         * Date display format. The value can be: "long", "short", "medium", "full", or "auto".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.dateStyle
         */
        dateStyle?: string;
        
        
        
        
        /**
         * Time display format. The value can be: "long", "short", "medium", "full", or "auto".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.timeStyle
         */
        timeStyle?: string;
        
        
        
        
        /**
         * Hour cycle. The value can be: "h11", "h12", "h23", or "h24".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.hourCycle
         */
        hourCycle?: string;
        
        
        
        
        /**
         * Time zone in use. The value is a valid IANA time zone ID.
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.timeZone
         */
        timeZone?: string;
        
        
        
        
        /**
         * Numbering system. The value can be: "adlm", "ahom", "arab", "arabext", "bali", "beng", "bhks",
         * "brah", "cakm", "cham", "deva", "diak", "fullwide", "gong", "gonm", "gujr", "guru", "hanidec", "hmng", "hmnp",
         * "java", "kali", "khmr", "knda", "lana", "lanatham", "laoo", "latn", "lepc", "limb", "mathbold", "mathdbl",
         * "mathmono", "mathsanb", "mathsans", "mlym", "modi", "mong", "mroo", "mtei", "mymr", "mymrshan", "mymrtlng",
         * "newa", "nkoo", "olck", "orya", "osma", "rohg", "saur", "segment", "shrd", "sind", "sinh", "sora", "sund",
         * "takr", "talu", "tamldec", "telu", "thai", "tibt", "tirh", "vaii", "wara", or "wcho".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.numberingSystem
         */
        numberingSystem?: string;
        
        
        
        
        /**
         * Whether to use the 12-hour clock. The value true means to use the 12-hour clock, and the value false means the
         * opposite. If both hour12 and hourCycle are set, hourCycle does not take effect. If hour12 and hourCycle are not
         * set and the 24-hour clock is turned on, the default value of hour12 is false.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.hour12
         */
        hour12?: boolean;
        
        
        
        
        /**
         * Week display format. The value can be: "long", "short", "narrow", or "auto".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.weekday
         */
        weekday?: string;
        
        
        
        
        /**
         * Epoch display format. The value can be: "long", "short", "narrow", or "auto".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.era
         */
        era?: string;
        
        
        
        
        /**
         * Year display format. The value can be: "numeric" or "2-digit".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.year
         */
        year?: string;
        
        
        
        
        /**
         * Month display format. The value can be: "numeric", "2-digit", "long", "short", "narrow", or "auto".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.month
         */
        month?: string;
        
        
        
        
        /**
         * Day display format. The value can be: "numeric" or "2-digit".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.day
         */
        day?: string;
        
        
        
        
        /**
         * Hour display format. The value can be: "numeric" or "2-digit".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.hour
         */
        hour?: string;
        
        
        
        
        /**
         * Minute display format. The value can be: "numeric" or "2-digit".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.minute
         */
        minute?: string;
        
        
        
        
        /**
         * Second display format. The value can be: "numeric" or "2-digit".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.second
         */
        second?: string;
        
        
        
        
        /**
         * Localized representation of a time zone name. The value can be: "long", "short", or "auto".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.timeZoneName
         */
        timeZoneName?: string;
        
        
        
        
        /**
         * Time period display format. The value can be: "long", "short", "narrow", or "auto".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.dayPeriod
         */
        dayPeriod?: string;
        
        
        
        
        /**
         * Locale matching algorithm. The value can be:
         * "lookup": exact match.
         * "best fit": best match.
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.localeMatcher
         */
        localeMatcher?: string;
        
        
        
        
        /**
         * Format matching algorithm. The value can be:
         * "basic": exact match.
         * "best fit": best match.
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormatOptions.formatMatcher
         */
        formatMatcher?: string;
    }
    
    
    
    /**
     * Provides the API for formatting date strings.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     * @deprecated since 20
     * @useinstead Intl.DateTimeFormat
     */
    export class DateTimeFormat {
        
        
        
        /**
         * Creates a DateTimeOptions object for the specified locale.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormat.constructor
         */
        constructor();
        
        
        
        /**
         * Creates a DateTimeOptions object for the specified locale.
         *
         * @param { string | Array<string> } locale - Locale ID or locale ID array. If the input is a locale ID array, the
         *                                            first valid locale ID is used.
         * @param { DateTimeOptions } [options] - Options for creating the DateTimeOptions object.<br>If no options are
         *                                        set, the default values of year, month, and day are numeric.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormat.constructor
         */
        constructor(locale: string | Array<string>, options?: DateTimeOptions);
        
        
        
        /**
         * Formats the date and time.
         *
         * @param { Date } date - Date and time. Note: The month starts from 0. For example, 0 indicates January.
         * @returns { string } A string containing the formatted date and time.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormat.format
         */
        format(date: Date): string;
        
        
        
        /**
         * Formats date and time ranges.
         *
         * @param { Date } startDate - Start date and time. Note: The month starts from 0. For example, 0 indicates
         *                             January.
         * @param { Date } endDate - End date and time. Note: The month starts from 0. For example, 0 indicates January.
         * @returns { string } a date string formatted based on the specified locale.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormat.formatRange
         */
        formatRange(startDate: Date, endDate: Date): string;
        
        
        
        /**
         * Obtains the options for creating a DateTimeOptions object.
         *
         * @returns { DateTimeOptions } Options for the DateTimeOptions object.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead Intl.DateTimeFormat.resolvedOptions
         */
        resolvedOptions(): DateTimeOptions;
    }
    
    
    /**
     * Options for creating the NumberFormat object. Since API version 9, the NumberOptions attribute is changed from
     * mandatory to optional.
     *
     * @interface NumberOptions
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export interface NumberOptions {
        
        
        
        /**
         * Valid locale ID, for example, "zh-Hans-CN". The default value is the current system locale.
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        locale?: string;
        
        
        
        /**
         * Currency unit. The value must comply with the [ISO-4217 standard](https://www.iso.org/iso-4217-currency-codes.html),
         * for example, "EUR", "CNY", and "USD". From API version 12, a three-digit number is supported, for example, "978",
         * "156", or "840".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        currency?: string;
        
        
        
        /**
         * urrency unit symbol. The value can be "standard" or "accounting". The default value is "standard".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        currencySign?: string;
        
        
        
        /**
         * Currency display mode. The value can be "symbol", "narrowSymbol", "code", or "name".
         * The default value is "symbol".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        currencyDisplay?: string;
        
        
        
        /**
         * Unit name, for example, "meter", "inch", or "hectare". The combination units supported since API version 18 are
         * as follows: "beat-per-minute", "body-weight-per-second", "breath-per-minute", "foot-per-hour",
         * "jump-rope-per-minute", "meter-per-hour", "milliliter-per-minute-per-kilogram", "rotation-per-minute",
         * "step-per-minute", and "stroke-per-minute".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        unit?: string;
        
        
        
        /**
         * Display format of units. The value can be "long", "short", or "narrow". The default value is "short".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        unitDisplay?: string;
        
        
        
        /**
         * Application scenario of units. The value can be any of the following: "default", "area-land-agricult",
         * "area-land-commercl", "area-land-residntl", "length-person", "length-person-small", "length-rainfall",
         * "length-road", "length-road-small", "length-snowfall", "length-vehicle", "length-visiblty",
         * "length-visiblty-small", "length-person-informal", "length-person-small-informal", "length-road-informal",
         * "speed-road-travel", "speed-wind", "temperature-person", "temperature-weather", "volume-vehicle-fuel",
         * "elapsed-time-second", "size-file-byte", or "size-shortfile-byte". The default value is "default".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        unitUsage?: string;
        
        
        
        /**
         * Number sign display format. The value can be:
         * "auto": automatically determines whether to display the plus or minus sign.
         * "never": do not display the plus or minus sign.
         * "always": always displays the plus or minus sign.
         * "exceptZero": displays the plus or minus sign for all values except 0.
         * Default value: "auto".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        signDisplay?: string;
        
        
        
        /**
         * Compact display format. The value can be "long" or "short". The default value is "short".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        compactDisplay?: string;
        
        
        
        /**
         * Number notation. The value can be: "standard", "scientific", "engineering", or "compact".
         * The default value is "standard".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        notation?: string;
        
        
        
        /**
         * Locale matching algorithm. The value can be "lookup" or "best fit". The default value is "best fit".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        localeMatcher?: string;
        
        
        
        /**
         * Number display format. The value can be "decimal", "currency", "percent", or "unit".
         * The default value is "decimal".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        style?: string;
        
        
        
        /**
         * Numbering system. The value can be: "adlm", "ahom", "arab", "arabext", "bali", "beng", "bhks",
         * "brah", "cakm", "cham", "deva", "diak", "fullwide", "gong", "gonm", "gujr", "guru", "hanidec", "hmng", "hmnp",
         * "java", "kali", "khmr", "knda", "lana", "lanatham", "laoo", "latn", "lepc", "limb", "mathbold", "mathdbl",
         * "mathmono", "mathsanb", "mathsans", "mlym", "modi", "mong", "mroo", "mtei", "mymr", "mymrshan", "mymrtlng",
         * "newa", "nkoo", "olck", "orya", "osma", "rohg", "saur", "segment", "shrd", "sind", "sinh", "sora", "sund",
         * "takr", "talu", "tamldec", "telu", "thai", "tibt", "tirh", "vaii", "wara", or "wcho".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        numberingSystem?: string;
        
        
        
        /**
         * Whether to enable grouping for display. The value "true" means to enable grouping for display, and the value
         * "false" means the opposite. The default value is "true".
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        useGrouping?: boolean;
        
        
        
        /**
         * Minimum number of digits allowed in the integer part of a number. The value ranges from 1 to 21.
         * The default value is 1.
         *
         * @type { ?int }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        minimumIntegerDigits?: int;
        
        
        
        /**
         * Minimum number of digits in the fraction part of a number. The value ranges from 0 to 20.
         * The default value is 0.
         *
         * @type { ?int }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        minimumFractionDigits?: int;
        
        
        
        /**
         * Maximum number of digits in the fraction part of a number. The value ranges from 1 to 21.
         * The default value is 3.
         *
         * @type { ?int }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        maximumFractionDigits?: int;
        
        
        
        /**
         * Minimum number of the least significant digits. The value ranges from 1 to 21. The default value is 1.
         *
         * @type { ?int }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        minimumSignificantDigits?: int;
        
        
        
        /**
         * Maximum number of the least significant digits. The value ranges from 1 to 21. The default value is 21.
         *
         * @type { ?int }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        maximumSignificantDigits?: int;
        /**
         * Rounding priority used when both the maximum number of fraction digits and the maximum number of valid digits
         * are set. The value can be: "auto", "morePrecision", or "lessPrecision". The value "morePrecision" indicates that
         * the maximum number of fraction digits is used. The value "lessPrecision" indicates that the maximum number of
         * valid digits is used. The default value is "auto".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        roundingPriority?: string;
        /**
         * Rounding increment. The value can be: 1, 2, 5, 10, 20, 25, 50, 100, 200, 250, 500, 1000, 2000, 2500, or 5000.
         * The default value is 1.
         *
         * @type { ?int }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        roundingIncrement?: int;
        /**
         * Rounding mode. The value can be:
         * "ceil": rounding up.
         * "floor": rounding down.
         * "expand": rounding away from 0.
         * "trunc": rounding toward 0.
         * "halfCeil": half-rounding up; that is, rounding up when the decimal number is greater than or equal to half of
         *             the increment, and rounding down otherwise.
         * "halfFloor": half-rounding down; that is, rounding up when the decimal number is greater than half of the
         *              increment, and rounding down otherwise.
         * "halfExpand": half-rounding away from 0; that is, rounding away from 0 when the decimal number is greater than
         *               or equal to half of the increment, and rounding toward 0 otherwise.
         * "halfTrunc": half-rounding toward 0; that is, rounding away from 0 when the decimal number is greater than half
         *              of the increment, and rounding toward 0 otherwise.
         * "halfEven": half-rounding to the nearest even number; that is, rounding away from 0 when the decimal number is
         *             greater than half of the increment, rounding toward 0 when the decimal number is less than half of
         *             the increment, and rounding to the nearest even number when the decimal number is exactly half of
         *             the increment.
         * The default value is "halfExpand".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        roundingMode?: string;
    }
    
    
    /**
     * Provides the API for formatting number strings.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class NumberFormat {
        
        
        /**
         * Creates a NumberFormat object for the specified locale.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        constructor();
        
        
        /**
         * Creates a NumberFormat object for the specified locale.
         *
         * @param { string | Array<string> } locale - Locale ID or locale ID array. If the input is a locale ID array,
         *                                            the first valid locale ID is used.
         * @param { NumberOptions } [options] - Options for creating the NumberFormat object.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        constructor(locale: string | Array<string>, options?: NumberOptions);
        
        
        /**
         * Formats a number.
         *
         * @param { double } num - Number to be formatted.
         * @returns { string } Formatted number.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        format(num: double): string;
        /**
         * Formats a number range.
         *
         * @param { double } startRange - Start number.
         * @param { double } endRange - End number.
         * @returns { string } Formatted number range.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        formatRange(startRange: double, endRange: double): string;
        
        
        /**
         * Obtains the options for creating a NumberFormat object.
         *
         * @returns { NumberOptions } Options for creating the NumberFormat object.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        resolvedOptions(): NumberOptions;
    }
    
    
    /**
     * Defines the options for creating a Collator object.
     *
     * @interface CollatorOptions
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export interface CollatorOptions {
        
        
        
        /**
         * Locale matching algorithm. The value can be "lookup" or "best fit". The default value is "best fit".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        localeMatcher?: string;
        
        
        
        /**
         * Whether the comparison is for sorting or for searching. The value can be "sort" or "search".
         * The default value is "sort".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        usage?: string;
        
        
        
        /**
         * Differences in the strings that lead to non-zero return values. The value can be "base", "accent", "case", or
         * "letiant". The default value is "variant".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        sensitivity?: string;
        
        
        
        /**
         * Whether to ignore punctuation. The value "true" means to ignore punctuation, and the value "false" means the
         * opposite. The default value is "false".
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        ignorePunctuation?: boolean;
        
        
        
        /**
         * Collation rule. The value can be any of the following: "big5han", "compat", "dict", "direct", "ducet", "eor",
         * "gb2312", "phonebk", "phonetic", "pinyin", "reformed", "searchjl", "stroke", "trad", "unihan", or "zhuyin".
         * The default value is "default".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        collation?: string;
        
        
        
        /**
         * Whether to use numeric collation. The value "true" means to use numeric collation, and the value "false" means
         * the opposite. The default value is "false".
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        numeric?: boolean;
        
        
        
        /**
         * Whether upper case or lower case is sorted first. The value can be "upper", "lower", or "false".
         * The default value is "false".
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        caseFirst?: string;
    }
    
    
    /**
     * Enable language-sensitive string comparison.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class Collator {
        
        
        /**
         * Creates a Collator object.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        constructor();
        
        
        /**
         * Creates a Collator object.
         *
         * @param { string | Array<string> } locale - Locale ID or locale ID array. If the input is a locale ID array,
         *                                            the first valid locale ID is used.
         * @param { CollatorOptions } [options] - Options for creating a Collator object.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        constructor(locale: string | Array<string>, options?: CollatorOptions);
        
        
        /**
         * Compares two strings based on the specified collation rules.
         *
         * @param { string } first - First string to compare.
         * @param { string } second - Second string to compare.
         * @returns { int } Comparison result. If the value is a negative number, the first string comes before the
         *                     second string. If the value is 0, the first and second strings are in the same sequence.
         *                     If the value is a positive number, the first string is comes after the second string.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        compare(first: string, second: string): int;
        
        
        /**
         * Obtains the options for creating a Collator object.
         *
         * @returns { CollatorOptions } Options for creating a Collator object.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        resolvedOptions(): CollatorOptions;
    }
}
export default intl;
