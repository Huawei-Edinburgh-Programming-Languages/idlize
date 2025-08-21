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
import { BusinessError } from './@ohos.base';
import intl from './@ohos.intl';
import { StyledString, TextStyle } from './arkui/component/styledString';

/**
 * Provides international settings related APIs.
 *
 * @namespace i18n
 * @syscap SystemCapability.Global.I18n
 * @since 20
 */
declare namespace i18n {
    
    
    /**
     * Provides system functions.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class System {
        
        
        /**
         * Obtains the country/region display name in the specified language.
         *
         * @param { string } country - Valid country/region code.
         * @param { string } locale - System locale, which consists of the language, script, and country/region.
         * @param { boolean } [sentenceCase] - Whether to use sentence case to display the text. The value "true" means to
         *                                     display the text in title case format, and the value "false" means to
         *                                     display the text in the default case format of the locale. The default value
         *                                     is true.
         * @returns { string } Country/region display name in the specified language.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getDisplayCountry(country: string, locale: string, sentenceCase?: boolean): string;
        
        
        /**
         * Obtains the language display name in the specified language.
         *
         * @param { string } language - Valid language ID.
         * @param { string } locale - System locale, which consists of the language, script, and country/region.
         * @param { boolean } [sentenceCase] - Whether to use sentence case to display the text. The value "true" means to
         *                                     display the text in title case format, and the value "false" means to
         *                                     display the text in the default case format of the locale. The default value
         *                                     is true.
         * @returns { string } Language display name in the specified language.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getDisplayLanguage(language: string, locale: string, sentenceCase?: boolean): string;
        
        /**
         * Obtains the list of system languages.
         *
         * @returns { Array<string> } List of system languages.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getSystemLanguages(): Array<string>;
        
        /**
         * Obtains the list of countries/regions supported for the specified language.
         *
         * @param { string } language - Valid language ID.
         * @returns { Array<string> } List of countries/regions supported for the specified language.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getSystemCountries(language: string): Array<string>;
        
        /**
         * Checks whether a language is a suggested language in the specified region. It can be used for region-based
         * language recommendation or language-based region recommendation.
         *
         * @param { string } language - Valid language ID, for example, "zh".
         * @param { string } [region] - Valid region ID, for example, "CN". The default value is the country/region of the
         *                              SIM card.
         * @returns { boolean } Whether a language is a suggested language. The value "true" indicates that the language
         *                      is a suggested language of the region, the the value "false" indicates the opposite.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static isSuggested(language: string, region?: string): boolean;
        
        
        /**
         * Obtains the current system language.
         *
         * @returns { string } Language ID.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getSystemLanguage(): string;
        /**
         * Sets the system language.
         *
         * @permission ohos.permission.UPDATE_CONFIGURATION
         * @param { string } language - Valid language ID.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission
         *                                 required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        static setSystemLanguage(language: string): void;
        
        
        /**
         * Obtains the current system country/region.
         *
         * @returns { string } Country/region ID.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getSystemRegion(): string;
        /**
         * Sets the system region.
         *
         * @permission ohos.permission.UPDATE_CONFIGURATION
         * @param { string } region - Valid region ID.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission
         *                                 required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        static setSystemRegion(region: string): void;
        /**
         * Obtains the locale object currently used by the system.
         *
         * @returns { Intl.Locale } the locale object currently used by the system.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getSystemLocaleInstance(): Intl.Locale;
        
        
        
        /**
         * Checks whether the 24-hour clock is used.
         *
         * @returns { boolean } Whether the 24-hour clock is used. The value "true" indicates that the 24-hour clock is
         *                      used, the the value "false" means the opposite.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static is24HourClock(): boolean;
        /**
         * Sets whether to use the 24-hour clock.
         *
         * @permission ohos.permission.UPDATE_CONFIGURATION
         * @param { boolean } option - Whether to use the 24-hour clock. The value "true" means to use the 24-hour clock,
         *                             the the value "false" means the opposite.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission
         *                                 required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        static set24HourClock(option: boolean): void;
        /**
         * Adds a preferred language to the specified position on the preferred language list.
         *
         * @permission ohos.permission.UPDATE_CONFIGURATION
         * @param { string } language - Valid ID of the language to be added as a preferred language.
         * @param { int } [index] - Position to which the preferred language is added. The default value is the length
         *                             of the preferred language list.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission
         *                                 required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        static addPreferredLanguage(language: string, index?: int): void;
        /**
         * Removes a preferred language from the specified position on the preferred language list.
         *
         * @permission ohos.permission.UPDATE_CONFIGURATION
         * @param { int } index - Position of the preferred language to delete.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission
         *                                 required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        static removePreferredLanguage(index: int): void;
        
        /**
         * Obtains the list of preferred languages.
         *
         * @returns { Array<string> } List of preferred languages.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getPreferredLanguageList(): Array<string>;
        
        /**
         * Obtains the first language in the preferred language list.
         *
         * @returns { string } First language in the preferred language list.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getFirstPreferredLanguage(): string;
        
        
        /**
         * Sets the preferred language of the application. Resources are loaded in the preferred language when the
         * application is launched. If the preferred language is set to default, the application's language will be the
         * same as the system language, and the setting will take effect upon cold starting of the application.
         *
         * @param { string } language - Valid language ID or default.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static setAppPreferredLanguage(language: string): void;
        
        
        /**
         * Obtains the preferred language of an application.
         *
         * @returns { string } Preferred language of the application.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getAppPreferredLanguage(): string;
        /**
         * Specifies whether to enable use of local digits.
         *
         * @permission ohos.permission.UPDATE_CONFIGURATION
         * @param { boolean } flag - Whether to turn on the local digit switch. The value "true" means to turn on the local
         *                           digit switch, and the value "false" indicates the opposite.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission
         *                                 required to call the API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        static setUsingLocalDigit(flag: boolean): void;
        
        /**
         * Checks whether use of local digits is enabled.
         *
         * @returns { boolean } Whether use of local digits is enabled. The value "true" indicates that use of local digits
         *                      is enabled, and the value "false" indicates the opposite.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getUsingLocalDigit(): boolean;
        /**
         * Obtains the simplified representation of a language. For example, the simplified representation of "en-Latn-US"
         * is "en", and that of "en-Latn-GB" is "en-GB".
         *
         * @param { string } [language] - Valid language ID. The default value is the system language.
         * @returns { string } If language is not passed, the application checks for dialects supported by the system based
         *                     on the system language and locale. If such a dialect is found, the simplified representation
         *                     of the dialect is returned. Otherwise, the simplified representation of the system language
         *                     is returned. If language is passed, the simplified representation of the specified language
         *                     is returned.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getSimplifiedLanguage(language?: string): string;
        /**
         * Sets the temperature unit of the system.
         *
         * @permission ohos.permission.UPDATE_CONFIGURATION
         * @param { TemperatureType } type - Temperature unit.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission
         *                                 required to call the API.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        static setTemperatureType(type: TemperatureType): void;
        /**
         * Obtains the temperature unit of the system.
         *
         * @returns { TemperatureType } Temperature unit.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getTemperatureType(): TemperatureType;
        /**
         * Obtains the name of a temperature unit.
         *
         * @param { TemperatureType } type - Temperature unit.
         * @returns { string } Name of the temperature unit, which can be "celsius", "fahrenheit", and "kelvin".
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getTemperatureName(type: TemperatureType): string;
        /**
         * Sets the first day of a week.
         *
         * @permission ohos.permission.UPDATE_CONFIGURATION
         * @param { WeekDay } type - Start day of a week.
         * @throws { BusinessError } 201 - Permission verification failed. The application does not have the permission
         *                                 required to call the API.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        static setFirstDayOfWeek(type: WeekDay): void;
        /**
         * Obtains the first day of a week in the system settings.
         *
         * @returns { WeekDay } Start day of a week.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getFirstDayOfWeek(): WeekDay;
    }
    /**
     * Enumerates the first day of a week. The value ranges from Monday to Sunday.
     *
     * @enum { int }
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export enum WeekDay {
        /**
         * Monday.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        MON = 1,
        /**
         * Tuesday.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        TUE = 2,
        /**
         * Wednesday.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        WED = 3,
        /**
         * Thursday.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        THU = 4,
        /**
         * Friday.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        FRI = 5,
        /**
         * Saturday.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        SAT = 6,
        /**
         * Sunday.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        SUN = 7
    }
    /**
     * Enumerates temperature units.
     *
     * @enum { int }
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export enum TemperatureType {
        /**
         * Celesius.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        CELSIUS = 1,
        /**
         * Fahrenheit.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        FAHRENHEIT = 2,
        /**
         * Kelvin.
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        KELVIN = 3
    }
    
    
    /**
     * Provides util functions.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class I18NUtil {
        
        /**
         * Converts one measurement unit into another and formats the unit based on the specified locale and style.
         *
         * @param { UnitInfo } fromUnit - Measurement unit to be converted.
         * @param { UnitInfo } toUnit - Measurement unit to be converted to.
         * @param { double } value - Value of the measurement unit to be converted.
         * @param { string } locale - Locale ID, which consists of the language, script, and country/region, for example,
         *                            "zh-Hans-CN".
         * @param { string } [style] - Style used for formatting. The value can be long, short, or narrow. The default
         *                             value is short. For details about the meaning or display effect of different values,
         *                             see Number and Unit of Measurement Formatting.
         * @returns { string } String converted to the measurement unit after formatting.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static unitConvert(fromUnit: UnitInfo, toUnit: UnitInfo, value: double, locale: string, style?: string): string;
        
        
        /**
         * Obtains the sequence of the year, month, and day in the specified locale.
         *
         * @param { string } locale - Locale ID, which consists of the language, script, and country/region, for example,
         *                            "zh-Hans-CN".
         * @returns { string } Sequence of the year, month, and day in the locale. "y" indicates the year, "L" indicates
         *                     the month, and "d" indicates the day.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getDateOrder(locale: string): string;
        
        /**
         * Obtains the localized expression of the specified time in the specified locale.
         *
         * @param { int } hour - Specified time, for example, 16.
         * @param { string } [locale] - System locale, which consists of the language, script, and country/region. for
         *                              example, "zh-Hans-CN". The default value is the current system locale.
         * @returns { string } Localized expression of the specified time in the specified locale.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getTimePeriodName(hour: int, locale?: string): string;
        /**
         * Obtains the locale that best matches a region from the specified locale list.
         *
         * @param { string } locale - Locale ID, for example, "zh-Hans-CN".
         * @param { string[] } localeList - List of locale IDs.
         * @returns { string } ID of the locale that best matches a region. If no matching locale is found, an empty string
         *                     is returned.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getBestMatchLocale(locale: string, localeList: string[]): string;
        /**
         * Converts a language code from two letters to three letters. For example, the two-letter language code of Chinese
         * is "zh", and the corresponding three-letter language code is "zho". For details, see
         * [ISO 639](https://www.iso.org/iso-639-language-code).
         *
         * @param { string } locale - Two-letter code of the language to be converted, for example, "zh".
         * @returns { string } Language code after conversion.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getThreeLetterLanguage(locale: string): string;
        /**
         * Converts a region code from two letters to three letters. For example, the two-letter region code of China is
         * "CN", and the corresponding three-letter region code is "CHN". For details, see
         * [ISO 3166](https://www.iso.org/iso-3166-country-codes.html).
         *
         * @param { string } locale - Two-letter country/region code to be converted, for example, "CN".
         * @returns { string } Region code after conversion.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getThreeLetterRegion(locale: string): string;
    }
    
    /**
     * Defines the measurement unit information.
     *
     * @interface UnitInfo
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export interface UnitInfo {
        
        /**
         * Name of the measurement unit, for example, "meter", "inch", or "cup".
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        unit: string;
        
        /**
         * Measurement system. The value can be "SI", "US", or "UK".
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        measureSystem: string;
    }
    
    
    /**
     * Options for PhoneNumberFormat object initialization.
     *
     * @interface PhoneNumberFormatOptions
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export interface PhoneNumberFormatOptions {
        
        
        
        /**
         * Type of the phone number. The value can be "E164", "INTERNATIONAL", "NATIONAL", "RFC3966", or "TYPING".
         * In API version 8, type is mandatory. In API version 9 or later, type is optional.
         * In API version 12 or later, "TYPING" is supported, which indicates that the dialed number is formatted in real
         * time.
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        type?: string;
    }
    
    
    /**
     * Provides the API for formatting phone number strings
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class PhoneNumberFormat {
        
        
        /**
         * Creates a PhoneNumberFormat object.
         *
         * @param { string } country - Country/region to which the phone number to be formatted belongs.
         * @param { PhoneNumberFormatOptions } [options] - Options for PhoneNumberFormat object initialization.
         *                                                 The default value is "NATIONAL".
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        constructor(country: string, options?: PhoneNumberFormatOptions);
        
        
        /**
         * Checks whether the phone number is valid for the country/region in the PhoneNumberFormat object.
         *
         * @param { string } phoneNumber - Phone number to be checked.
         * @returns { boolean } Whether the phone number is valid. The value "true" indicates that the phone number is
         *                      valid, and the value "false" indicates the opposite.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        isValidNumber(phoneNumber: string): boolean;
        
        
        /**
         * Formats a phone number.
         *
         * @param { string } phoneNumber - Phone number to be formatted.
         * @returns { string } Formatted phone number.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        format(phoneNumber: string): string;
        
        /**
         * Obtains the home location of a phone number.
         *
         * @param { string } phoneNumber - Phone number. To obtain the home location of a number in other countries/regions,
         *                            you need to prefix the number with 00 and the country code.
         * @param { string } locale - System locale, which consists of the language, script, and country/region.
         * @returns { string } Home location of the phone number. If the number is invalid, an empty string is returned.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getLocationName(phoneNumber: string, locale: string): string;
    }
    
    
    /**
     * Obtains the Calendar object for the specified locale and calendar type.
     *
     * @param { string } locale - Locale ID, which consists of the language, script, and country/region,
     *                            for example, zh-Hans-CN.
     * @param { string } [type] - Calendar. The value can be: "buddhist", "chinese", "coptic", "ethiopic",
     *                            "hebrew", "gregory", "indian", "islamic_civil", "islamic_tbla",
     *                            "islamic_umalqura", "japanese", or "persian". The default value is the default
     *                            calendar of the locale. For details about the meanings and application scenarios of
     *                            different values, see Calendar Setting.
     * @returns { Calendar } Calendar object
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export function getCalendar(locale: string, type?: string): Calendar;
    
    
    /**
     * Provides the API for accessing Calendar name, time and date related information.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class Calendar {
        
        
        /**
         * Sets the date and time for a Calendar object.
         *
         * @param { Date } date - Date and time. Note: The month starts from 0. For example, 0 indicates January.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        setTime(date: Date): void;
        
        
        /**
         * Sets the date and time for a Calendar object.
         *
         * @param { double } time - Unix timestamp, which indicates the number of milliseconds that have elapsed since the
         *                          Unix epoch.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        setTime(time: double): void;
        
        
        /**
         * Sets the year, month, day, hour, minute, and second for this Calendar object.
         *
         * @param { int } year - Year to set.
         * @param { int } month - Month to set. Note: The month starts from 0. For example, 0 indicates January.
         * @param { int } date - Day to set.
         * @param { int } hour - Hour to set. The default value is the current system time.
         * @param { int } minute - Minute to set. The default value is the current system time.
         * @param { int } second - Second to set. The default value is the current system time.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        set(year: int, month: int, date: int, hour?: int, minute?: int, second?: int): void;
        
        
        /**
         * Sets the time zone of this Calendar object.
         *
         * @param { string } timezone - Valid time zone ID, for example, Asia/Shanghai.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        setTimeZone(timezone: string): void;
        
        
        /**
         * Obtains the time zone ID of this Calendar object.
         *
         * @returns { string } Time zone ID.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getTimeZone(): string;
        
        
        /**
         * Obtains the first day of a week for this Calendar object.
         *
         * @returns { int } First day of a week. The value 1 indicates Sunday, and the value 7 indicates Saturday.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getFirstDayOfWeek(): int;
        
        
        /**
         * Sets the first day of a week for this Calendar object.
         *
         * @param { int } value - Start day of a week. The value 1 indicates Sunday, and the value 7 indicates Saturday.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        setFirstDayOfWeek(value: int): void;
        
        
        /**
         * Obtains the minimum number of days in the first week for this Calendar object.
         *
         * @returns { int } Minimum number of days in the first week of a year.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getMinimalDaysInFirstWeek(): int;
        
        
        /**
         * Sets the minimum number of days in the first week for this Calendar object.
         *
         * @param { int } value - Minimum number of days in the first week of a year.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        setMinimalDaysInFirstWeek(value: int): void;
        
        
        /**
         * Obtains the values of the calendar attributes in this Calendar object.
         *
         * @param { string } field - Calendar attributes. The following table lists the supported attribute values.
         * @returns { int } Value of the calendar attribute. For example, if the year of the internal date of the
         *                     current Calendar object is 1990, get('year') returns 1990.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        get(field: string): int;
        
        /**
         * Obtains calendar display name in the specified language.
         *
         * @param { string } locale - System locale, which consists of the language, script, and country/region.
         * @returns { string } Calendar display name in the specified language. For example, buddhist is displayed as
         *                     Buddhist Calendar if the locale is en-US.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getDisplayName(locale: string): string;
        
        
        /**
         * Checks whether a given date is a weekend in this Calendar object.
         *
         * @param { Date } [date] - Date and time. Note: The month starts from 0. For example, 0 indicates January.
         *                          The default value is current date of the Calendar object.
         * @returns { boolean } The value "true" indicates that the specified date is a weekend, and the value "false"
         *                      indicates the opposite.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        isWeekend(date?: Date): boolean;
        
        /**
         * Performs addition or subtraction on the calendar attributes of this Calendar object.
         *
         * @param { string } field - Calendar attribute. The value can be any of the following: year, month, week_of_year,
         *                           week_of_month, date, day_of_year, day_of_week, day_of_week_in_month, hour,
         *                           hour_of_day, minute, second, millisecond. For details about the values, see get.
         * @param { int } amount - Addition or subtraction amount.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        add(field: string, amount: int): void;
        
        /**
         * Obtains the timestamp of this Calendar object.
         *
         * @returns { long } Unix timestamp, which indicates the number of milliseconds that have elapsed since the
         *                     Unix epoch.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getTimeInMillis(): long;
        
        /**
         * Compares the current date of this Calendar object with the specified date for the difference in the number of
         * days.
         *
         * @param { Date } date - Date and time. Note: The month starts from 0. For example, 0 indicates January.
         * @returns { int } Difference in the number of days. A positive number indicates that the calendar date is
         *                     earlier, and a negative number indicates the opposite. The value is accurate to
         *                     milliseconds. If the value is less than one day, it is considered as one day.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        compareDays(date: Date): int;
    }
    
    
    /**
     * Checks whether the input character is of the right to left (RTL) language.
     *
     * @param { string } locale - Input character. If the input is a string, only the type of the first character is checked.
     * @returns { boolean } true if the input character is of the RTL language, and false otherwise.
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export function isRTL(locale: string): boolean;
    
    /**
     * Obtains a BreakIterator object. The BreakIterator object maintains an internal break iterator that can be used to
     * access various line break points.
     *
     * @param { string } locale - System locale, which consists of the language, script, and country/region. The
     *                            generated BreakIterator object calculates the positions of line breaks based on
     *                            the rules of the specified locale.
     * @returns { BreakIterator } BreakIterator object.
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export function getLineInstance(locale: string): BreakIterator;
    
    /**
     * The BreakIterator class is used for finding the location of break point in text.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class BreakIterator {
        
        /**
         * Obtains the position of the break iterator in the text.
         *
         * @returns { int } Position of the break iterator in the text.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        current(): int;
        
        /**
         * Moves the break iterator to the first line break point, which is always at the beginning of the processed text.
         *
         * @returns { int } Offset of the first line break point in the processed text.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        first(): int;
        
        /**
         * Moves the break iterator to the last line break point, which is always the next position after the end of the
         * processed text.
         *
         * @returns { int } Offset of the last line break point in the processed text.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        last(): int;
        
        /**
         * Moves the break iterator backward by the specified number of line break points.
         *
         * @param { int } [index] - Number of line break points for moving the break iterator. The value is an integer.
         *                             A positive number means to move the break iterator backward, and a negative number
         *                             means to move the break iterator forward. The default value is 1.
         * @returns { int } Position of the break iterator in the text after movement. The value -1 is returned if the
         *                     position of the break iterator is outside of the processed text after movement.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        next(index?: int): int;
        
        /**
         * Moves the break iterator foreward by one line break point.
         *
         * @returns { int } Position of the break iterator in the text after movement. The value -1 is returned if the
         *                     position of the break iterator is outside of the processed text after movement.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        previous(): int;
        
        /**
         * Sets the text to be processed by the BreakIterator object.
         *
         * @param { string } text - Input text.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        setLineBreakText(text: string): void;
        
        /**
         * Moves the line break iterator to the line break point after the specified position.
         *
         * @param { int } offset - Offset of the line break point.
         * @returns { int } Position of the break iterator in the text after movement. The value -1 is returned if the
         *                     position of the break iterator is outside of the processed text after movement.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        following(offset: int): int;
        
        /**
         * Obtains the text processed by the BreakIterator object.
         *
         * @returns { string } Text being processed by the BreakIterator object.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getLineBreakText(): string;
        
        /**
         * Checks whether the specified position is a line break point.
         *
         * @param { int } offset - Specified position in the text.
         * @returns { boolean } Whether the specified position is a line break point. The value "true" indicates that the
         *                      specified position is a line break point, and the value "false" indicates the opposite.
         *                      If true is returned, the break iterator is moved to the position specified by offset.
         *                      Otherwise, the break iterator is moved to the text line break point after the position
         *                      specified by offset, which is equivalent to calling following.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        isBoundary(offset: int): boolean;
    }
    
    /**
     * Creates an IndexUtil object.
     *
     * @param { string } [locale] - System locale, which consists of the language, script, and country/region.
     *                              The default value is the current system locale.
     * @returns { IndexUtil } IndexUtil object created based on the specified locale ID.
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export function getInstance(locale?: string): IndexUtil;
    
    /**
     * Sequence text can be grouped under the specified area,
     * and grouping index with different lengths can be specified.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class IndexUtil {
        
        /**
         * Obtains the index list of the current locale.
         *
         * @returns { Array<string> } Index list of the current locale. The first and last elements are "...".
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getIndexList(): Array<string>;
        
        /**
         * Adds the index list of a new locale to the index list of the current locale to form a composite list.
         *
         * @param { string } locale - System locale, which consists of the language, script, and country/region.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        addLocale(locale: string): void;
        
        /**
         * Obtains the index of the text object.
         *
         * @param { string } text - text object.
         * @returns { string } Index of the text object. If no proper index is found, an empty string is returned.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getIndex(text: string): string;
    }
    
    
    /**
     * Provides the API for accessing unicode character properties. For example, determine whether a character is a number.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class Unicode {
        
        
        /**
         * Checks whether the input character is a digit.
         *
         * @param { string } ch - Input character. If the input is a string, only the type of the first character is
         *                          checked.
         * @returns { boolean } true if the input character is a digit, and false otherwise.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static isDigit(ch: string): boolean;
        
        
        /**
         * Checks whether the input character is a space.
         *
         * @param { string } ch - Input character. If the input is a string, only the type of the first character is
         *                          checked.
         * @returns { boolean } true if the input character is a space, and false otherwise.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static isSpaceChar(ch: string): boolean;
        
        
        /**
         * Checks whether the input character is a whitespace.
         *
         * @param { string } ch - Input character. If the input is a string, only the type of the first character is
         *                          checked.
         * @returns { boolean } true if the input character is a white space, and false otherwise.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static isWhitespace(ch: string): boolean;
        
        
        /**
         * Checks whether the input character is of the right to left (RTL) language.
         *
         * @param { string } ch - Input character. If the input is a string, only the type of the first character is
         *                          checked.
         * @returns { boolean } true if the input character is of the RTL language, and false otherwise.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static isRTL(ch: string): boolean;
        
        
        /**
         * Checks whether the input character is an ideographic character.
         *
         * @param { string } ch - Input character. If the input is a string, only the type of the first character is
         *                          checked.
         * @returns { boolean } true if the input character an ideographic character, and false otherwise.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static isIdeograph(ch: string): boolean;
        
        
        /**
         * Checks whether the input character is a letter.
         *
         * @param { string } ch - Input character. If the input is a string, only the type of the first character is
         *                          checked.
         * @returns { boolean } true if the input character a letter, and false otherwise.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static isLetter(ch: string): boolean;
        
        
        /**
         * Checks whether the input character is a lowercase letter.
         *
         * @param { string } ch - Input character. If the input is a string, only the type of the first character is
         *                          checked.
         * @returns { boolean } true if the input character a lowercase letter, and false otherwise.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static isLowerCase(ch: string): boolean;
        
        
        /**
         * Checks whether the input character is an uppercase letter.
         *
         * @param { string } ch - Input character. If the input is a string, only the type of the first character is
         *                          checked.
         * @returns { boolean } true if the input character an uppercase letter, and false otherwise.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static isUpperCase(ch: string): boolean;
        
        
        /**
         * Obtains the type of the input character.
         *
         * @param { string } ch - Input character. If the input is a string, only the type of the first character is
         *                          checked.
         * @returns { string } Type of the input character.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getType(ch: string): string;
    }
    
    
    /**
     * Obtains the TimeZone object corresponding to the specified time zone ID.
     *
     * @param { string } [zoneID] - Time zone ID. The default value is the system time zone.
     * @returns { TimeZone } TimeZone object corresponding to the time zone ID.
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export function getTimeZone(zoneID?: string): TimeZone;
    
    
    /**
     * Provides the API for accessing TimeZone name, rawOffset and offset information.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class TimeZone {
        
        
        /**
         * Obtains the ID of the specified TimeZone object.
         *
         * @returns { string } Time zone ID corresponding to the TimeZone object.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getID(): string;
        
        /**
         * Obtains time zone display name in the specified language.
         *
         * @param { string } [locale] - System locale, which consists of the language, script, and country/region.
         *                              The default value is the current system locale.
         * @param { boolean } [isDST] - Whether DST information is displayed. The value "true" indicates that DST
         *                              information is displayed, and the value "false" indicates the opposite.
         *                              The default value is false.
         * @returns { string } Time zone display name in the specified language.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getDisplayName(locale?: string, isDST?: boolean): string;
        
        
        /**
         * Obtains the raw offset of the specified time zone.
         *
         * @returns { int } Raw offset of the time zone, in milliseconds.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getRawOffset(): int;
        
        
        /**
         * Obtains the offset of the specified time zone at the specified time.
         *
         * @param { double } [date] - Specified time, in milliseconds. The default value is the system time.
         * @returns { int } Time zone offset, in milliseconds. When the DST is used, the time zone offset
         *                     is the raw time zone offset plus the DST offset.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getOffset(date?: double): int;
        
        
        /**
         * Obtains the list of time zone IDs supported by the system.
         *
         * @returns { Array<string> } List of time zone IDs supported by the system.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getAvailableIDs(): Array<string>;
        
        /**
         * Obtains the list of time zone city IDs supported by the system.
         *
         * @returns { Array<string> } List of time zone city IDs supported by the system.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getAvailableZoneCityIDs(): Array<string>;
        
        /**
         * Obtains time zone city display name in the specified language.
         *
         * @param { string } cityID - Time zone city ID.
         * @param { string } locale - System locale, which consists of the language, script, and country/region.
         * @returns { string } Time zone city display name in the specified language.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getCityDisplayName(cityID: string, locale: string): string;
        
        /**
         * Creates a TimeZone object corresponding to the specified time zone city.
         *
         * @param { string } cityID - Time zone city ID. The value must be a time zone city ID supported by the system.
         * @returns { TimeZone } TimeZone object corresponding to the specified time zone city ID.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getTimezoneFromCity(cityID: string): TimeZone;
        
        /**
         * Creates an array of TimeZone objects corresponding to the specified location.
         *
         * @param { double } longitude - Longitude. The value range is [-180, 179.9). A positive value is used for east
         *                               longitude and a negative value is used for west longitude.
         * @param { double } latitude - Latitude. The value range is [-90, 89.9). A positive value is used for north
         *                              latitude and a negative value is used for south latitude.
         * @returns { Array<TimeZone> } TimeZone objects corresponding to the specified location.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @static
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getTimezonesByLocation(longitude: double, latitude: double): Array<TimeZone>;
    }
    
    /**
     * Provides the API for transliterate text from one format to another.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class Transliterator {
        
        /**
         * Obtains a list of IDs supported by the Transliterator object.
         *
         * @returns { string[] } List of IDs supported by the Transliterator object.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getAvailableIDs(): string[];
        
        /**
         * Creates a Transliterator object based on the specified ID.
         *
         * @param { string } id - ID supported by the Transliterator object.
         * @returns { Transliterator } Transliterator object.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getInstance(id: string): Transliterator;
        
        /**
         * Converts the input text from the source format to the target format.
         *
         * @param { string } text - Input text.
         * @returns { string } Text after conversion.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        transform(text: string): string;
    }
    
    /**
     * Enumerates text normalization modes.
     *
     * @enum { int }
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export enum NormalizerMode {
        
        /**
         * Normalization form C, characters are decomposed and then re-composed by canonical equivalence
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        NFC = 1,
        
        /**
         * Normalization form D, characters are decomposed by canonical equivalence
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        NFD = 2,
        
        /**
         * Normalization form KC, characters are decomposed by compatibility, then re-composed by canonical equivalence
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        NFKC = 3,
        
        /**
         * Normalization form KD, characters are decomposed by compatibility
         *
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        NFKD = 4
    }
    
    /**
     * Provides the API for text encoding normalization.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class Normalizer {
        
        /**
         * Obtains a Normalizer object.
         *
         * @param { NormalizerMode } mode - Text normalization mode.
         * @returns { Normalizer } Normalizer object for text normalization.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        static getInstance(mode: NormalizerMode): Normalizer;
        
        /**
         * Normalizes input strings.
         *
         * @param { string } text - Input strings.
         * @returns { string } Normalized strings.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        normalize(text: string): string;
    }
    /**
     * Represents the language or country/region suggestion type.
     *
     * @enum { int }
     * @syscap SystemCapability.Global.I18n
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum SuggestionType {
        /**
         * Not a recommended language or country/region.
         *
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SUGGESTION_TYPE_NONE = 0,
        /**
         * Country/region recommended by the system language or language recommended by the system country/region.
         *
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SUGGESTION_TYPE_RELATED = 1,
        /**
         * Language recommended by the country/region of the SIM card.
         *
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SUGGESTION_TYPE_SIM = 2
    }
    /**
     * Represents the language or country/region sorting option.
     *
     * @interface SortOptions
     * @syscap SystemCapability.Global.I18n
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface SortOptions {
        /**
         * Locale information, which consists of the language, script, and country/region, for example, "zh-Hans-CN".
         * The default value is the current system locale.
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        locale?: string;
        /**
         * Whether to use the local name for sorting. The value "true" means to use the local name for sorting, and the
         * value "false" means the opposite. If getLanguageInfoArray is called, the default value of isUseLocalName is
         * true. If getRegionInfoArray is called, the default value of isUseLocalName is false.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        isUseLocalName?: boolean;
        /**
         * Whether to move the recommended language or country/region to the top in the sorting result. The value "true"
         * means to move the recommended language or country/region to the top, and the value "false" means the opposite.
         * The default value is true.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        isSuggestedFirst?: boolean;
    }
    /**
     * Represents the locale information, which consists of the language, script, and country/region.
     *
     * @interface LocaleItem
     * @syscap SystemCapability.Global.I18n
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface LocaleItem {
        /**
         * Language code or country/region code, for example, "zh" or "CN".
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        id: string;
        /**
         * Language or country/region suggestion type.
         *
         * @type { SuggestionType }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        suggestionType: SuggestionType;
        /**
         * Representation of ID in the specified locale in SystemLocaleManager.
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        displayName: string;
        /**
         * Local name of the ID.
         *
         * @type { ?string }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        localName?: string;
    }
    /**
     * Represents a time zone and city combination item.
     *
     * @interface TimeZoneCityItem
     * @syscap SystemCapability.Global.I18n
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export interface TimeZoneCityItem {
        /**
         * Time zone ID, for example, "Asia/Shanghai".
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        zoneId: string;
        /**
         * City ID, for example, "Shanghai".
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        cityId: string;
        /**
         * City display name in the system locale.
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        cityDisplayName: string;
        /**
         * Offset of the time zone ID.
         *
         * @type { int }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        offset: int;
        /**
         * Time zone display name in the system locale.
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        zoneDisplayName: string;
        /**
         * Fixed offset of the time zone ID.
         *
         * @type { ?int }
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        rawOffset?: int;
    }
    /**
     * Provide some functions for settings and startup guide to select language or region.
     *
     * @syscap SystemCapability.Global.I18n
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export class SystemLocaleManager {
        /**
         * Creates a SystemLocaleManager object.
         *
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        constructor();
        
        /**
         * Obtains the list of languages after sorting.
         *
         * @param { Array<string> } languages - Valid IDs of the languages to be sorted.
         * @param { SortOptions } options - Language sorting option.
         * @returns { Array<LocaleItem> } Language list after sorting.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        getLanguageInfoArray(languages: Array<string>, options?: SortOptions): Array<LocaleItem>;
        
        /**
         * Obtains the IDs of the countries or regions after sorting.
         *
         * @param { Array<string>  } regions - Valid IDs of the countries or regions to be sorted.
         * @param { SortOptions } options - Country/region sorting option. By default, locale is the current system
         *                                  locale, isUseLocalName is false, and isSuggestedFirst is true.
         * @returns { Array<LocaleItem> } IDs of the countries or regions after sorting.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        getRegionInfoArray(regions: Array<string>, options?: SortOptions): Array<LocaleItem>;
        
        /**
         * Obtains list of time zone city items after sorting.
         *
         * @returns { Array<TimeZoneCityItem> } List of time zone city items after sorting.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.Global.I18n
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        static getTimeZoneCityItemArray(): Array<TimeZoneCityItem>;
    }
    
    /**
     * Represents the holiday information.
     *
     * @interface HolidayInfoItem
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export interface HolidayInfoItem {
        
        /**
         * Holiday name.
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        baseName: string;
        
        /**
         * Year of the holiday.
         *
         * @type { int }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        year: int;
        
        /**
         * Month of the holiday.
         *
         * @type { int }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        month: int;
        
        /**
         * Day of the holiday.
         *
         * @type { int }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        day: int;
        
        /**
         * Local names of the holiday.
         *
         * @type { ?Array<HolidayLocalName> }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        localNames?: Array<HolidayLocalName>;
    }
    
    /**
     * Represents the name of a holiday in different languages.
     *
     * @interface HolidayLocalName
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export interface HolidayLocalName {
        
        /**
         * Language, for example, "ar", "en", or "tr".
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        language: string;
        
        /**
         * Local name of a holiday. For example, the Turkish name of Sacrifice Feast is Kurban Bayrami.
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        name: string;
    }
    
    /**
     * Provide some functions to manage holidays in a country or region. Partly follows the RFC2445 standard.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class HolidayManager {
        
        /**
         * Creates a HolidayManager object for parsing holiday data.
         *
         * @param { String } icsPath - Path of the .ics file with the read permission granted for applications.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        constructor(icsPath: String);
        
        /**
         * Determines whether the specified date is a holiday.
         *
         * @param { Date } [date] - Date and time. Note: The month starts from 0. For example, 0 indicates January.
         *                          The default value is the current date.
         * @returns { boolean } true if the specified date is a holiday, and false otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        isHoliday(date?: Date): boolean;
        
        /**
         * Obtains the holiday information list of the specified year.
         *
         * @param { int } [year] - Specified year, for example, 2023.<br>The default value is the current year.
         * @returns { Array<HolidayInfoItem> } Holiday information list.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        getHolidayInfoItemArray(year?: int): Array<HolidayInfoItem>;
    }
    
    /**
     * Defines a list of entities.
     *
     * @interface EntityInfoItem
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export interface EntityInfoItem {
        
        /**
         * Start position of the entity in the input string.
         *
         * @type { int }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        begin: int;
        
        /**
         * End position of the entity the input string.
         *
         * @type { int }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        end: int;
        
        /**
         * Entity type. The value can be "phone_number" or "date". "phone_number" indicates that the entity is a phone
         * number, and "date" indicates that the entity is a date.
         *
         * @type { string }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        type: string;
    }
    
    /**
     * Provide some functions to find named entity in text.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class EntityRecognizer {
        
        /**
         * Creates an entityRecognizer object. This object is used to recognize entities in the text for the specified
         * locale.
         *
         * @param { string } [locale] - Locale ID, which consists of the language, script, and country/region, for example,
         *                              "zh-Hans-CN". The default value is the current system locale.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @throws { BusinessError } 890001 - Invalid parameter. Possible causes: Parameter verification failed.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        constructor(locale?: string);
        
        /**
         * Obtains entity information in the text object.
         *
         * @param { string } text - text object.
         * @returns { Array<EntityInfoItem> } List of entities in the text.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified;
         *                                 2.Incorrect parameter types.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        findEntityInfo(text: string): Array<EntityInfoItem>;
    }
    /**
     * Provide a simple date time formatting interface.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class SimpleDateTimeFormat {
        /**
         * Formats the date and time.
         *
         * @param { Date } date - Date and time. Note: The month starts from 0. For example, 0 indicates January.
         * @returns { string } A string containing the formatted date and time.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        format(date: Date): string;
    }
    /**
     * Provide a simple number formatting interface.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class SimpleNumberFormat {
        /**
         * Formats a number.
         *
         * @param { double } value - Number to be formatted.
         * @returns { string } Formatted number.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        format(value: double): string;
    }
    /**
     * Provide a number formatting interface which could format number to StyleString.
     *
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export class StyledNumberFormat {
        /**
         * Creates a NumberFormat object for rich text display.
         *
         * @param { intl.NumberFormat | SimpleNumberFormat } numberFormat - NumberFormat object.
         * @param { StyledNumberFormatOptions } [ options ] - Configuration options of the NumberFormat object.
         *                                                    The default value is the default text style.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         * @deprecated since 20
         * @useinstead constructor
         */
        constructor(numberFormat: intl.NumberFormat | SimpleNumberFormat, options?: StyledNumberFormatOptions);
        /**
         * Formats a number as a rich text object.
         *
         * @param { double } value - Number to be formatted.
         * @returns { StyledString } Rich text object after formatting.
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        format(value: double): StyledString;
    }
    /**
     * Represents optional configuration items for the NumberFormat object.
     *
     * @interface StyledNumberFormatOptions
     * @syscap SystemCapability.Global.I18n
     * @since 20
     */
    export interface StyledNumberFormatOptions {
        /**
         * Text style for the integer part. The default value is the default text style.
         *
         * @type { ?TextStyle }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        integer?: TextStyle;
        /**
         * Text style for the decimal point. The default value is the default text style.
         *
         * @type { ?TextStyle }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        decimal?: TextStyle;
        /**
         * Text style for the fraction part. The default value is the default text style.
         *
         * @type { ?TextStyle }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        fraction?: TextStyle;
        /**
         * Text style for the unit. The default value is the default text style.
         *
         * @type { ?TextStyle }
         * @syscap SystemCapability.Global.I18n
         * @since 20
         */
        unit?: TextStyle;
    }
}
export default i18n;
