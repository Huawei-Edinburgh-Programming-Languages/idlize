'use static'
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
import { CommonMethod, Bindable } from './common';
import { CustomBuilder } from './builder';
import { Length } from './units';
import { ComponentContent } from '../ComponentContent';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * Sliding effect
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SwipeEdgeEffect {
    /**
     * Elastic physical action, sliding to the edge can continue to slide for a distance based on the initial speed or touch event, and spring back when released.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 20
     */
    Spring,
    /**
     * Sliding to the edge has no effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 20
     */
    None
}
/**
 * Declare enum SwipeActionState.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SwipeActionState {
    /**
     * Collapsed type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    COLLAPSED,
    /**
     * EXPANDED type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    EXPANDED,
    /**
     * Action type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ACTIONING
}
/**
 * Defines the swipe action item for SwipeActionOptions.
 *
 * @interface SwipeActionItem
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SwipeActionItem {
    /**
     * An action item that appears when a list item slides right (when list direction is Vertical) or
     * slides down (when list direction Horizontal).
     *
     * @type { ?CustomBuilder }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 20
     */
    builder?: CustomBuilder;
    /**
      * An action item that appears when a list item slides right (when list direction is Vertical) or
      * slides down (when list direction Horizontal).
      *
      * @type { ?ComponentContent }
      * @syscap SystemCapability.ArkUI.ArkUI.Full
      * @since 20
      */
    builderComponent?: ComponentContent;
    /**
     * Defines distance for the delete area.
     *
     * @type { ?Length }
     * @default 56vp
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 20
     */
    actionAreaDistance?: Length;
    /**
     * Called when ListItem need to be deleted.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 20
     */
    onAction?: () => void;
    /**
     * Called when swipe entry delete area.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 20
     */
    onEnterActionArea?: () => void;
    /**
     * Called when swipe exit delete area.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 20
     */
    onExitActionArea?: () => void;
    /**
     * Called when component swipe action state changed.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @crossplatform
     * @since 20
     */
    onStateChange?: (state: SwipeActionState) => void;
}
/**
 * Defines the SwipeActionOption of swipeAction attribute method.
 *
 * @interface SwipeActionOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SwipeActionOptions {
    /**
     * An action item that appears when a list item slides right (when list direction is Vertical) or
     * slides down (when list direction Horizontal).
     *
     * @type { ?(CustomBuilder | SwipeActionItem) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    start?: CustomBuilder | SwipeActionItem;
    /**
     * An action item that appears when a list item slides left (when list direction is Vertical) or
     * slides up (when list direction Horizontal).
     *
     * @type { ?(CustomBuilder | SwipeActionItem) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    end?: CustomBuilder | SwipeActionItem;
    /**
     * Sets whether sliding to a boundary has a spring effect.
     *
     * @type { ?SwipeEdgeEffect }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    edgeEffect?: SwipeEdgeEffect;
    /**
     * Called when swipe action offset changed.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onOffsetChange?: (offset: number) => void;
}
/**
 * Defines the list item style.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ListItemStyle {
    /**
     * Show custom style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NONE = 0,
    /**
     * Show default style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CARD = 1
}
/**
 * Defines the list item options.
 *
 * @interface ListItemOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ListItemOptions {
    /**
     * Describes the ListItem style.
     *
     * @type { ?ListItemStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    style?: ListItemStyle;
}

/**
 * The ListItemAttribute.
 * 
 * @extends CommonMethod
 * @interface ListItemAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface ListItemAttribute extends CommonMethod {
    /**
     * Called when judging whether it is selectable.
     *
     * @param { boolean | undefined } value
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default selectable(value: boolean | undefined): this;
    /**
     * Called when judging whether it is selected.
     * This parameter supports $$ for two-way binding of variables.
     *
     * @param { boolean | Bindable<boolean> | undefined } value - if the listItem is selected.
     * @returns { this } the attribute of the listItem.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default selected(value: boolean | Bindable<boolean> | undefined): this;
    /**
     * Sets the action item that appears when the list item slides in the cross axis direction of the list.
     *
     * @param { SwipeActionOptions | undefined } value - items defines in the SwipeActionOption.
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default swipeAction(value: SwipeActionOptions | undefined): this;
    /**
     * Called when the listItem is selected.
     *
     * @param { function | undefined } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onSelect(event: ((isSelected: boolean) => void) | undefined): this;
    /**
     * Called attributeModifier.
     *
     * @param { AttributeModifier<ListAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<ListItemAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines ListItem Component.
 *
 * @param { ListItemOptions } [value]
 * @param { function } [content_]
 * @returns { ListItemAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function ListItem(
    value?: ListItemOptions, 
    @memo
    content_?: () => void,
): ListItemAttribute