'use static'
/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License"),
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

import { CommonMethod, BlurStyle, Bindable } from './common';
import { ResourceColor, Length, Position } from "./units";
import { Font } from "./units";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * indexer align property.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum IndexerAlign {
    /**
     * A dialog box is displayed on the right of the index bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Left,
    /**
     * A dialog box is displayed on the left of the index bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Right,
    /**
     * A dialog box is displayed on the start of the index bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    START,
    /**
     * A dialog box is displayed on the end of the index bar.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    END
}
/**
 * AlphabetIndexer constructor options.
 *
 * @interface AlphabetIndexerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface AlphabetIndexerOptions {
    /**
     * Alphabetical index string array.
     * Anonymous Object Rectification.
     *
     * @type { Array<string> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    arrayValue: Array<string>;
    /**
     * ID of the selected item.
     *
     * @type { number | Bindable<number> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selected: number | Bindable<number>;
}
/**
 * Defines an AlphabetIndexer callback when onSelect.
 *
 * @typedef { function } OnAlphabetIndexerSelectCallback
 * @param { number } index - selected index
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnAlphabetIndexerSelectCallback = (index: number) => void;
/**
 * Defines an AlphabetIndexer callback when onPopupSelect.
 *
 * @typedef { function } OnAlphabetIndexerPopupSelectCallback
 * @param { number } index - selected index
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnAlphabetIndexerPopupSelectCallback = (index: number) => void;
/**
 * Defines an AlphabetIndexer callback when onRequestPopupData.
 *
 * @typedef { function } OnAlphabetIndexerRequestPopupDataCallback
 * @param { number } index - selected index
 * @returns { Array<string> } string array corresponding to the index
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type OnAlphabetIndexerRequestPopupDataCallback = (index: number) => Array<string>;

/**
 * The AlphabetIndexerAttribute.
 * 
 * @extends CommonMethod
 * @interface AlphabetIndexerAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface AlphabetIndexerAttribute extends CommonMethod {
    /**
     * Definitions color.
     *
     * @param { ResourceColor } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    color(value: ResourceColor | undefined): this;
    /**
     * Select the text color.
     *
     * @param { ResourceColor } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedColor(value: ResourceColor | undefined): this;
    /**
     * Font color of the pop-up prompt text.
     *
     * @param { ResourceColor } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popupColor(value: ResourceColor | undefined): this;
    /**
     * Select the text background color.
     *
     * @param { ResourceColor } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedBackgroundColor(value: ResourceColor | undefined): this;
    /**
     * Background color of the pop-up window index.
     *
     * @param { ResourceColor } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popupBackground(value: ResourceColor | undefined): this;
    /**
     * Set the selected font color of non-alphabetic part of the pop-up window.
     *
     * @param { ResourceColor } value - indicates the color of the selected font.
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popupSelectedColor(value: ResourceColor | undefined): this;
    /**
     * Set the unselected font color of non-alphabetic part of the pop-up window.
     *
     * @param { ResourceColor } value - indicates the color of the unselected font.
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popupUnselectedColor(value: ResourceColor | undefined): this;
    /**
     * Set the background color of non-alphabetic part of the pop-up window.
     *
     * @param { ResourceColor } value - indicates the color of background.
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popupItemBackgroundColor(value: ResourceColor | undefined): this;
    /**
     * Whether to use pop-up index hints.
     *
     * @param { boolean } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    usingPopup(value: boolean | undefined): this;
    /**
     * Select the text text style,
     *
     * @param { Font } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selectedFont(value: Font | undefined): this;
    /**
     * Select the text background color.
     *
     * @param { Font } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popupFont(value: Font | undefined): this;
    /**
     * Set the font style of non-alphabetic part of the prompt pop-up window.
     * Family and style are not supported currently and will be fixed in future.
     *
     * @param { Font } value - indicates the style of the font.
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popupItemFont(value: Font | undefined): this;
    /**
     * Size of the letter area on the letter index bar. The letter area is a square. Set the length of the square side.
     *
     * @param { string | number } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    itemSize(value: string | number | undefined): this;
    /**
     * Definitions fonts.
     *
     * @param { Font } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    font(value: Font | undefined): this;
    /**
     * Alphabet index bar alignment style. The left and right alignment styles are supported,
     * which affects the pop-up position of the pop-up window.
     *
     * @param { IndexerAlign } value - indicates the alignment style of Alphabet index.
     * @param { Length } [offset] - indicates the horizontal space between pop-up window and indexer bar.
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    alignStyle(value: IndexerAlign | undefined, offset?: Length | undefined): this;
    /**
     * Index bar selection callback.
     * Anonymous Object Rectification.
     *
     * @param { OnAlphabetIndexerSelectCallback } callback
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onSelect(callback: OnAlphabetIndexerSelectCallback | undefined): this;
    /**
     * Index bar selection callback and return the strings which display on pop-up.
     * Anonymous Object Rectification.
     *
     * @param { OnAlphabetIndexerRequestPopupDataCallback } callback
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onRequestPopupData(callback: OnAlphabetIndexerRequestPopupDataCallback | undefined): this;
    /**
     * Pop-up selection callback.
     * Anonymous Object Rectification.
     *
     * @param { OnAlphabetIndexerPopupSelectCallback } callback
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onPopupSelect(callback: OnAlphabetIndexerPopupSelectCallback | undefined): this;
    /**
     * Sets the selected index.
     *
     * @param { number | Bindable<number> } index
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    selected(index: number | Bindable<number> | undefined): this;
    /**
     * Position of the pop-up windows, relative to the midpoint of the top border of the indexer bar.
     *
     * @param { Position } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popupPosition(value: Position | undefined): this;
    /**
     * Automatically collapses the characters when the indexer bar not high enough to display all characters.
     *
     * @param { boolean } value - A boolean value determines whether auto collapses is enabled for indexer bar.
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    autoCollapse(value: boolean | undefined): this;
    /**
     * Set the radius of the item of the pop-up window.
     *
     * @param { number } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popupItemBorderRadius(value: number | undefined): this;
    /**
     * Set the radius of the item of the indexer.
     *
     * @param { number } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    itemBorderRadius(value: number | undefined): this;
    /**
     * Set the background blurStyle of title of the pop-up window.
     *
     * @param { BlurStyle } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popupBackgroundBlurStyle(value: BlurStyle | undefined): this;
    /**
     * Set the background color of title of the pop-up window.
     *
     * @param { ResourceColor } value
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popupTitleBackground(value: ResourceColor | undefined): this;
    /**
     * Enable or disable haptic feedback.
     *
     * @param { boolean } value - Default value is true, set false to disable haptic feedback.
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableHapticFeedback(value: boolean | undefined): this;

    /**
     * Set the attribute modifier of the component.
     *
     * @param { AttributeModifier<AlphabetIndexerAttribute> | AttributeModifier<CommonMethod> | undefined } modifier -
     *  Set the AlphabetIndexer modifier to the component.
     * @returns { AlphabetIndexerAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    attributeModifier(modifier: AttributeModifier<AlphabetIndexerAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines AlphabetIndexer Component
 *
 * @param { AlphabetIndexerOptions } options - indexer constructor options
 * @param { function } [content_] - container
 * @returns { AlphabetIndexerAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function AlphabetIndexer(
    options: AlphabetIndexerOptions, 
    @memo
    content_?: () => void,
): AlphabetIndexerAttribute
