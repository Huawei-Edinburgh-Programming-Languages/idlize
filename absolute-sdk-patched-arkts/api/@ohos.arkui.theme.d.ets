'use static';
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
import { ResourceColor } from './arkui/component/units';
/**
 * Defines the struct of Theme.
 *
 * @interface Theme
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface Theme {
    /**
    *  Define tokens associated with color resources.
    *
    * @type { Colors }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    colors: Colors;
}
/**
 * Defines the struct of Colors.
 *
 * @interface Colors
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface Colors {
    /**
    * System brand Color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    brand: ResourceColor;
    /**
    * System warning Color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    warning: ResourceColor;
    /**
    * System alert Color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    alert: ResourceColor;
    /**
    * System confirm Color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    confirm: ResourceColor;
    /**
    * First level text color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    fontPrimary: ResourceColor;
    /**
    * Secondary text color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    fontSecondary: ResourceColor;
    /**
    * tertiary text color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    fontTertiary: ResourceColor;
    /**
    * Fourth text color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    fontFourth: ResourceColor;
    /**
    * Emphasize text color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    fontEmphasize: ResourceColor;
    /**
    * First level text inversion, used on colored backgrounds.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    fontOnPrimary: ResourceColor;
    /**
    * Secondary level text inversion, used on colored backgrounds.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    fontOnSecondary: ResourceColor;
    /**
    * Tertiary level text inversion, used on colored backgrounds.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    fontOnTertiary: ResourceColor;
    /**
    * Fourth level text inversion, used on colored backgrounds.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    fontOnFourth: ResourceColor;
    /**
    * First level icon color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    iconPrimary: ResourceColor;
    /**
    * Secondary level icon color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    iconSecondary: ResourceColor;
    /**
    * Tertiary level icon color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    iconTertiary: ResourceColor;
    /**
    * Fourth level icon color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    iconFourth: ResourceColor;
    /**
    * Emphasize level icon color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    iconEmphasize: ResourceColor;
    /**
    * Secondary emphasize level icon color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    iconSubEmphasize: ResourceColor;
    /**
    * First level icon reversed, used on a colored background.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    iconOnPrimary: ResourceColor;
    /**
    * Secondary level icon reversed, used on a colored background.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    iconOnSecondary: ResourceColor;
    /**
    * Tertiary level icon reversed, used on a colored background.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    iconOnTertiary: ResourceColor;
    /**
    * Fourth level icon reversed, used on a colored background.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    iconOnFourth: ResourceColor;
    /**
    * System Primary level background color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    backgroundPrimary: ResourceColor;
    /**
    * System Secondary level background color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    backgroundSecondary: ResourceColor;
    /**
    * System tertiary level background color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    backgroundTertiary: ResourceColor;
    /**
    * System fourth level background color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    backgroundFourth: ResourceColor;
    /**
    * System emphasize level background color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    backgroundEmphasize: ResourceColor;
    /**
    * CompForegroundPrimary color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compForegroundPrimary: ResourceColor;
    /**
    * CompBackgroundPrimary color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compBackgroundPrimary: ResourceColor;
    /**
    * CompBackgroundPrimaryTran color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compBackgroundPrimaryTran: ResourceColor;
    /**
    * CompBackgroundPrimaryContrary color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compBackgroundPrimaryContrary: ResourceColor;
    /**
    * CompBackgroundGray color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compBackgroundGray: ResourceColor;
    /**
    * 10% black universal control background.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compBackgroundSecondary: ResourceColor;
    /**
    * 5% black universal control background.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compBackgroundTertiary: ResourceColor;
    /**
    * 100% bright brand background color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compBackgroundEmphasize: ResourceColor;
    /**
    * Black neutral high gloss color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compBackgroundNeutral: ResourceColor;
    /**
    * 20% High gloss brand background color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compEmphasizeSecondary: ResourceColor;
    /**
    * 10% High gloss brand background color.
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compEmphasizeTertiary: ResourceColor;
    /**
    * Universal Division Line Color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compDivider: ResourceColor;
    /**
    * CompCommonContrary Color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compCommonContrary: ResourceColor;
    /**
    * CompBackgroundFocus Color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compBackgroundFocus: ResourceColor;
    /**
    * CompFocusedPrimary Color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compFocusedPrimary: ResourceColor;
    /**
    * CompFocusedSecondary Color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compFocusedSecondary: ResourceColor;
    /**
    * CompFocusedTertiary Color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    compFocusedTertiary: ResourceColor;
    /**
    *  Hover interactive color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    interactiveHover: ResourceColor;
    /**
    * Pressed interactive color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    interactivePressed: ResourceColor;
    /**
    * Focus interactive color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    interactiveFocus: ResourceColor;
    /**
    * Active interactive color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    interactiveActive: ResourceColor;
    /**
    * Select interactive color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    interactiveSelect: ResourceColor;
    /**
    * Click interactive color
    *
    * @type { ResourceColor }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    interactiveClick: ResourceColor;
}
/**
 * Defines the struct of CustomTheme.
 *
 * @interface CustomTheme
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface CustomTheme {
    /**
    * Define tokens associated with color resources..
    *
    * @type { ?CustomColors }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    colors?: CustomColors;
}
/**
 * Defines the struct of CustomColors.
 *
 * @typedef { Partial<Colors> } CustomColors
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type CustomColors = Partial<Colors>;
/**
 * Class ThemeControl provides the Theme management for whole Ability and pages.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class ThemeControl {
    /**
    * Sets the default Theme:
    * - for whole Ability when invoked from the Ability level code.
    * - for the ArkUI page and for later opened pages when invoked at the ArkUI page level.
    *
    * @param { CustomTheme } theme
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    static setDefaultTheme(theme: CustomTheme): void;
}
