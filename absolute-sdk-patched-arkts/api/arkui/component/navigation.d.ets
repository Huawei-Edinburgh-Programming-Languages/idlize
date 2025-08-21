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

import window from '../../@ohos.window';
import { Resource } from '../../global/resource';
import { TextModifier } from '../../arkui/TextModifier';
import { LengthMetrics } from '../../arkui/Graphics';
import { Callback, BlurStyle, CommonMethod, LayoutSafeAreaType, LayoutSafeAreaEdge, BackgroundEffectOptions, 
  BackgroundBlurStyleOptions, PixelMap, Bindable } from './common';
import { CustomBuilder, PageMapBuilder } from './builder';
import { Length, ResourceStr, ResourceColor, Dimension, VoidCallback } from './units';
import { TitleHeight } from './enums';
import { SymbolGlyphModifier } from '../../arkui/SymbolGlyphModifier';
import { NavDestinationContext, NavDestinationMode } from './navDestination';
import { memo, ComponentBuilder } from './../stateManagement/runtime';

/**
 * Import the SystemBarStyle type for Navigation.
 *
 * @typedef { window.SystemBarStyle } SystemBarStyle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type SystemBarStyle = window.SystemBarStyle;

/**
 * Defines the navigation common title.
 *
 * @interface NavigationCommonTitle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface NavigationCommonTitle {
    /**
     * Sets the main title.
     *
     * @type { string | Resource }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    main: string | Resource;

    /**
     * Sets the sub title.
     *
     * @type { string | Resource }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    sub: string | Resource;
}

/**
 * Defines the navigation custom title.
 *
 * @interface NavigationCustomTitle
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface NavigationCustomTitle {
    /**
     * Sets the custom title builder.
     *
     * @type { CustomBuilder }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    builder: CustomBuilder;

    /**
     * Sets the custom title height.
     *
     * @type { TitleHeight | Length }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    height: TitleHeight | Length;
}

/**
 * Navigation mode
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum NavigationMode {
    /**
     * The navigation bar and the content area are displayed in stack.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Stack,

    /**
     * The navigation bar and the content area are displayed side by side.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Split,

    /**
     * If the window width is greater than the sum of minNavBarWidth and minContentWidth, the navigation component is displayed in split mode.
     * Otherwise it's displayed in stack mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Auto
}

/**
 * Navigation bar position
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum NavBarPosition {
    /**
     * The navigation bar is on the Start of the container
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Start,

    /**
     * The navigation bar is on the End of the container
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    End
}

/**
 * Navigation title mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum NavigationTitleMode {
    /**
     * The title is free mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
    Free = 0,

    /**
     * The title is full mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Full,

    /**
     * The title is mini mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Mini
}

/**
 * Navigation menu item, include menu icon and menu info
 *
 * @interface NavigationMenuItem
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
* @noninterop
 */
export declare interface NavigationMenuItem {
    /**
     * The value of navigation menu item.
     *
     * @type { string | Resource }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: string | Resource;

    /**
     * The value of navigation menu item.
     *
     * @type { ?(string | Resource) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    icon?: string | Resource;

    /**
     * The symbol of navigation menu item.
     *
     * @type { ?SymbolGlyphModifier }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    symbolIcon?: SymbolGlyphModifier;

    /**
     * Whether to enable this menu item.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isEnabled?: boolean;

    /**
     * Trigger by navigation menu item click.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    action?: () => void;
}

/**
 * Indicates the information of the popped page.
 *
 * @interface PopInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface PopInfo {
    /**
     * The info of the popped page.
     *
     * @type { NavPathInfo }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    info: NavPathInfo;

    /**
     * The result of the popped page.
     *
     * @type { Object }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    result: Object;
}

/**
 * Indicates the information of NavDestination.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class NavPathInfo {
    /**
     * Creates an instance of NavPathInfo.
     *
     * @param { string } name - The name of NavDestination.
     * @param { Object | null | undefined } param - The detailed parameter of the NavDestination.
     * @param { Callback<PopInfo> } [onPop] - The callback when next page returns.
     * @param { boolean } [isEntry] - Indicates whether it is an entry destination.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(name: string, param: Object | null | undefined, onPop?: Callback<PopInfo>, isEntry?: boolean);

    /**
     * The name of NavDestination.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    name: string;

    /**
     * The detailed parameter of the NavDestination.
     *
     * @type { ?(Object | null | undefined) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    param?: Object | null | undefined;

    /**
     * The callback when next page returns.
     *
     * @type { ?Callback<PopInfo> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onPop?: Callback<PopInfo>;

    /**
     * Indicates whether it is an entry destination.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isEntry?: boolean;

    /**
     * The unique id of NavDestination.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    navDestinationId?: string;
}

/**
 * Defines the mode of stack operation.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum LaunchMode {
    /**
     * The default mode of stack operation.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    STANDARD = 0,

    /**
     * When the NavDestination with a specified name exists, it will be moved to top of stack,
     * otherwise, the behavior will be consistent with the STANDARD mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MOVE_TO_TOP_SINGLETON = 1,

    /**
     * When the NavDestination with a specified name exists, the stack will pop until that NavDestination,
     * otherwise, the behavior will be consistent with the STANDARD mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    POP_TO_SINGLETON = 2,

    /**
     * Forced to create a new NavDestination instance.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NEW_INSTANCE = 3
}

/**
 * Indicates the options of stack operation.
 *
 * @interface NavigationOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface NavigationOptions {
    /**
     * Indicates the launchMode of stack operation.
     *
     * @type { ?LaunchMode }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    launchMode?: LaunchMode;

    /**
     * Indicates whether the transition is animated.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    animated?: boolean;
}

/**
 * Indicates the information of NavDestinations. Providers methods for controlling destination page in the stack
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class NavPathStack {
    /**
     * Creates an instance of NavPathStack.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor();

    /**
     * Pushes the NavDestination into the stack.
     *
     * @param { NavPathInfo } info - Indicates the NavDestination to be pushed.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pushPath(info: NavPathInfo, animated?: boolean): void;

    /**
     * Pushes the NavDestination into the stack.
     *
     * @param { NavPathInfo } info - Indicates the NavDestination to be pushed.
     * @param { NavigationOptions } [options] - Indicates options of stack operation.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pushPath(info: NavPathInfo, options?: NavigationOptions): void;

    /**
     * Pushes the NavDestination into the stack.
     *
     * @param { NavPathInfo } info - Indicates the NavDestination to be pushed.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *     1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameters types.
     *     3. Parameter verification failed.
     * @throws { BusinessError } 100001 - Internal error.
     * @throws { BusinessError } 100005 - Builder function not registered.
     * @throws { BusinessError } 100006 - NavDestination not found.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pushDestination(info: NavPathInfo, animated?: boolean): Promise<void>;

    /**
     * Pushes the NavDestination into the stack.
     *
     * @param { NavPathInfo } info - Indicates the NavDestination to be pushed.
     * @param { NavigationOptions } [options] - Indicates options of stack operation.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *     1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameters types.
     *     3. Parameter verification failed.
     * @throws { BusinessError } 100001 - Internal error.
     * @throws { BusinessError } 100005 - Builder function not registered.
     * @throws { BusinessError } 100006 - NavDestination not found.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pushDestination(info: NavPathInfo, options?: NavigationOptions): Promise<void>;

    /**
     * Pushes the specified NavDestination into the stack.
     *
     * @param { string } name - Indicates the name of the NavDestination to be pushed.
     * @param { Object | null | undefined } param - Indicates the detailed parameter of the NavDestination to be pushed.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pushPathByName(name: string, param: Object | null | undefined, animated?: boolean): void;

    /**
     * Pushes the specified NavDestination into the stack.
     *
     * @param { string } name - Indicates the name of the NavDestination to be pushed.
     * @param { Object } param - Indicates the detailed parameter of the NavDestination to be pushed.
     * @param { Callback<PopInfo> } onPop - The callback when next page returns.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pushPathByName(name: string, param: Object, onPop: Callback<PopInfo>, animated?: boolean): void;

    /**
     * Pushes the specified NavDestination into the stack.
     *
     * @param { string } name - Indicates the name of the NavDestination to be pushed.
     * @param { Object } param - Indicates the detailed parameter of the NavDestination to be pushed.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *     1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameters types.
     *     3. Parameter verification failed.
     * @throws { BusinessError } 100001 - Internal error.
     * @throws { BusinessError } 100005 - Builder function not registered.
     * @throws { BusinessError } 100006 - NavDestination not found.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pushDestinationByName(name: string, param: Object, animated?: boolean): Promise<void>;

    /**
     * Pushes the specified NavDestination into the stack.
     *
     * @param { string } name - Indicates the name of the NavDestination to be pushed.
     * @param { Object } param - Indicates the detailed parameter of the NavDestination to be pushed.
     * @param { Callback<PopInfo> } onPop - The callback when next page returns.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *     1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameters types.
     *     3. Parameter verification failed.
     * @throws { BusinessError } 100001 - Internal error.
     * @throws { BusinessError } 100005 - Builder function not registered.
     * @throws { BusinessError } 100006 - NavDestination not found.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pushDestinationByName(name: string, param: Object, onPop: Callback<PopInfo>, animated?: boolean): Promise<void>;

    /**
     * Replace the current NavDestination with the specific one.The current NavDestination will be destroyed.
     *
     * @param { NavPathInfo } info - Indicates the new NavDestination in top of the stack.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    replacePath(info: NavPathInfo, animated?: boolean): void;

    /**
     * Replace the current NavDestination with the specific one.The current NavDestination will be destroyed.
     *
     * @param { NavPathInfo } info - Indicates the new NavDestination in top of the stack.
     * @param { NavigationOptions } [options] - Indicates options of stack operation.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    replacePath(info: NavPathInfo, options?: NavigationOptions): void;

    /**
     * Replace the NavDestination into the stack.
     *
     * @param { NavPathInfo } info - Indicates the NavDestination to replace in stack.
     * @param { NavigationOptions } [options] - Indicates options of stack operation.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *     1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameters types.
     *     3. Parameter verification failed.
     * @throws { BusinessError } 100001 - Internal error.
     * @throws { BusinessError } 100005 - Builder function not registered.
     * @throws { BusinessError } 100006 - NavDestination not found.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    replaceDestination(info: NavPathInfo, options?: NavigationOptions): Promise<void>;

    /**
     * Replace the current NavDestination with the specific one.The current NavDestination will be destroyed.
     *
     * @param { string } name - Indicates name of the new NavDestination in top of stack.
     * @param { Object } param - Indicates the detailed parameter of the new NavDestination in top of the stack.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    replacePathByName(name: string, param: Object, animated?: boolean): void;

    /**
     * Remove the specified NavDestinations by indexes.
     *
     * @param { Array<number> } indexes - Indicates the indexes of the NavDestinations to be removed.
     * @returns { number } Returns the number of removed pages. Invalid indexes will be ignored.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    removeByIndexes(indexes: Array<number>): number;

    /**
     * Remove the specified NavDestination by name.
     *
     * @param { string } name - Indicates the name of the NavDestination to be removed.
     * @returns { number } Returns the number of removed NavDestinations.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    removeByName(name: string): number;

    /**
     * Remove the specified NavDestination by its navDestinationId.
     *
     * @param { string } navDestinationId - Indicates the navDestinationId of the NavDestination to be removed.
     * @returns { boolean } Returns true if remove successfully, otherwise returns false.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    removeByNavDestinationId(navDestinationId: string): boolean;

    /**
     * Pops the top NavDestination out of the stack.
     *
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @returns { NavPathInfo | undefined } Returns the top NavPathInfo if the stack is not empty, otherwise returns undefined.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pop(animated?: boolean): NavPathInfo | undefined;

    /**
     * Pops the top NavDestination out of the stack.
     *
     * @param { Object } result - The result of the NavDestination.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @returns { NavPathInfo | undefined } Returns the top NavPathInfo if the stack is not empty, otherwise returns undefined.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pop(result: Object, animated?: boolean): NavPathInfo | undefined;

    /**
     * Pops the specified NavDestination out of the stack.
     *
     * @param { string } name - Indicates the name of the NavDestination to be popped.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @returns { number } Returns the index of the NavDestination if it exists in the stack, otherwise returns -1;
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popToName(name: string, animated?: boolean): number;

    /**
     * Pops the specified NavDestination out of the stack.
     *
     * @param { string } name - Indicates the name of the NavDestination to be popped.
     * @param { Object } result - The result of the NavDestination.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @returns { number } Returns the index of the NavDestination if it exists in the stack, otherwise returns -1;
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popToName(name: string, result: Object, animated?: boolean): number;

    /**
     * Pops the specified NavDestination out of the stack.
     *
     * @param { number } index - Indicates the index of the NavDestination to be popped.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popToIndex(index: number, animated?: boolean): void;

    /**
     * Pops the specified NavDestination out of the stack.
     *
     * @param { number } index - Indicates the index of the NavDestination to be popped.
     * @param { Object } result - The result of the NavDestination.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    popToIndex(index: number, result: Object, animated?: boolean): void;

    /**
     * Moves the specified NavDestination to stack top.
     *
     * @param { string } name - Indicates the name of the NavDestination to be moved to the top.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @returns { number } Returns the index of the NavDestination if it exists in the stack, otherwise returns -1;
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    moveToTop(name: string, animated?: boolean): number;

    /**
     * Moves the specified NavDestination to stack top.
     *
     * @param { number } index - Indicates the index of the NavDestination to be moved to the top.
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    moveIndexToTop(index: number, animated?: boolean): void;

    /**
     * Clears the stack.
     *
     * @param { boolean } [animated] - Indicates whether the transition is animated.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    clear(animated?: boolean): void;

    /**
     * Obtains all the NavDestination name in the stack.
     *
     * @returns { Array<string> } Returns all the NavDestination name in the stack;
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getAllPathName(): Array<string>;

    /**
     * Obtains the param of the specified NavDestination.
     *
     * @param { number } index - Indicates the index of the NavDestination.
     * @returns { Object | null | undefined } Returns the detailed parameter of the NavDestination if it exists in the stack, otherwise returns undefined;
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getParamByIndex(index: number): Object | null | undefined;

    /**
     * Obtains the param of the specified NavDestination.
     *
     * @param { string } name - Indicates the name of the NavDestination.
     * @returns { Array<Object | null | undefined> } Returns the detailed parameter of all the NavDestinations.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getParamByName(name: string): Array<Object | null | undefined>;

    /**
     * Obtains the index of the specified NavDestination.
     *
     * @param { string } name - Indicates the name of the NavDestination.
     * @returns { Array<number> } Returns the index of all the NavDestinations.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getIndexByName(name: string): Array<number>;

    /**
     * Obtains the parent of the current stack.
     *
     * @returns { NavPathStack | null } Returns the parent of the current stack. If no parent, it returns null.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getParent(): NavPathStack | null;

    /**
     * Obtains the size of the stack.
     *
     * @returns { number } Returns the size of the stack.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    size(): number;

    /**
     * disable or enable all transition animation in this navigation stack.
     *
     * @param { boolean } value - Indicates whether the transition is animated.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    disableAnimation(value: boolean): void;

    /**
     * set navigation transition interception.It will be called in navPathStack changes or navigation mode changes.
     *
     * @param { NavigationInterception } interception - the instance to intercept in navigation changes.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setInterception(interception: NavigationInterception): void;

    /**
     * Get the NavPathInfo array.
     *
     * @returns { Array<NavPathInfo> } The NavPathInfo array.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getPathStack(): Array<NavPathInfo>;

    /**
     * Set the NavPathInfo array.
     *
     * @param { Array<NavPathInfo> } pathStack - The NavPathInfo array.
     * @param { boolean } [animated] - Indicate whether the operation has animation.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setPathStack(pathStack: Array<NavPathInfo>, animated?: boolean): void;
}

/**
 * Navigation home name
 *
 * @typedef { 'navBar' } NavBar
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type NavBar = 'navBar';

/**
 * navigation interception callback using in willShow and didShow
 *
 * @typedef { function } InterceptionShowCallback
 * @param { NavDestinationContext | NavBar } from - Indicates the starting NavDestination or NavBar.
 * @param { NavDestinationContext | NavBar } to - Indicates the destination NavDestination or NavBar.
 * @param { NavigationOperation } operation - Indicates the type of stack operation.
 * @param { boolean } isAnimated - Indicates whether the transition is animated.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type InterceptionShowCallback = (from: NavDestinationContext | NavBar, to: NavDestinationContext | NavBar, operation: NavigationOperation, isAnimated: boolean) => void;

/**
 * navigation interception callback using in navigation mode change
 *
 * @typedef { function } InterceptionModeCallback
 * @param { NavigationMode } mode - Indicates the mode of Navigation.
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type InterceptionModeCallback = (mode: NavigationMode) => void;

/**
 * Provide navigation transition interception
 *
 * @interface NavigationInterception
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface NavigationInterception {
    /**
     * Called before destination transition.NavPathStack can be changed in this callback,
     * it will takes effect during this transition.For details, see { @Link InterceptionShowCallback}.
     *
     * @type { ?InterceptionShowCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    willShow?: InterceptionShowCallback;

    /**
     * Called after destination transition.For details, see { @Link InterceptionShowCallback}.
     *
     * @type { ?InterceptionShowCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    didShow?: InterceptionShowCallback;

    /**
     * Called when navigation mode changed.For details, see { @Link InterceptionModeCallback}.
     *
     * @type { ?InterceptionModeCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    modeChange?: InterceptionModeCallback;
}

/**
 * Defines the status of toolbar item and it is used in the ToolbarItem interface.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ToolbarItemStatus {
    /**
     * Normal state of toolbar item.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NORMAL = 0,

    /**
     * Disable state of toolbar item.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DISABLED = 1,

    /**
     * Active state of toolbar item.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ACTIVE = 2
}

/**
 * Defines the operation of current navigation transition.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum NavigationOperation {
    /**
     * Push operation of navigation transition.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PUSH = 1,

    /**
     * Pop operation of navigation transition.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    POP = 2,

    /**
     * Replace operation of navigation transition.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    REPLACE = 3
}

/**
 * Defines configurable parameters for toolbar item.
 *
 * @interface ToolbarItem
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface ToolbarItem {
    /**
     * The value of navigation toolbar item.
     *
     * @type { ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    value: ResourceStr;

    /**
     * The icon of navigation toolbar item.
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    icon?: ResourceStr;

    /**
     * The symbol of navigation toolbar item.
     *
     * @type { ?SymbolGlyphModifier }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    symbolIcon?: SymbolGlyphModifier;

    /**
     * Trigger by navigation toolbar item click.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    action?: () => void;

    /**
     * The state of navigation toolbar item.
     *
     * @type { ?ToolbarItemStatus }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    status?: ToolbarItemStatus;

    /**
     * The icon of navigation toolbar item in active state.
     *
     * @type { ?ResourceStr }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    activeIcon?: ResourceStr;

    /**
     * The symbol of navigation toolbar item in active state.
     *
     * @type { ?SymbolGlyphModifier }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    activeSymbolIcon?: SymbolGlyphModifier;
}

/**
 * Indicates the options of Navigation's Titlebar.
 *
 * @interface NavigationTitleOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface NavigationTitleOptions {
    /**
     * Background color.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundColor?: ResourceColor;

    /**
     * Background blur style.
     *
     * @type { ?BlurStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyle?: BlurStyle;

    /**
     * Background blur style options.
     *
     * @type { ?BackgroundBlurStyleOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyleOptions?: BackgroundBlurStyleOptions;

    /**
     * Background effect options.
     *
     * @type { ?BackgroundEffectOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundEffect?: BackgroundEffectOptions;

    /**
     * Set title bar style.
     *
     * @type { ?BarStyle }
     * @default BarStyle.STANDARD
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barStyle?: BarStyle;

    /**
     * Set title bar start padding.
     *
     * @type { ?LengthMetrics }
     * @default LengthMetrics.resource($r('sys.float.margin_left'))
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    paddingStart?: LengthMetrics;

    /**
     * Set title bar end padding.
     *
     * @type { ?LengthMetrics }
     * @default LengthMetrics.resource($r('sys.float.margin_right'))
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    paddingEnd?: LengthMetrics;

    /**
     * Text modifier for main title.
     *
     * @type { ?TextModifier }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    mainTitleModifier?: TextModifier;

    /**
     * Text modifier for sub title.
     *
     * @type { ?TextModifier }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    subTitleModifier?: TextModifier;

    /**
     * Defines whether to respond to the hover mode.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableHoverMode?: boolean;
}

/**
 * Declare BarStyle enum.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum BarStyle {
    /**
     * Standard style means that the bar and content area are column layouts.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    STANDARD = 0,

    /**
     * Stack style means that the bar and content area are stack layouts.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    STACK = 1,

    /**
     * SafeAreaPadding style means the bar height will be taken as content's safeAreaPadding.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SAFE_AREA_PADDING = 2
}

/**
 * Indicates the options of Navigation's Toolbar.
 *
 * @interface NavigationToolbarOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface NavigationToolbarOptions {
    /**
     * Background color.
     *
     * @type { ?ResourceColor }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundColor?: ResourceColor;

    /**
     * Background blur style.
     *
     * @type { ?BlurStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyle?: BlurStyle;

    /**
     * Background blur style options.
     *
     * @type { ?BackgroundBlurStyleOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyleOptions?: BackgroundBlurStyleOptions;

    /**
     * Background effect options.
     *
     * @type { ?BackgroundEffectOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundEffect?: BackgroundEffectOptions;

    /**
     * More button options.
     *
     * @type { ?MoreButtonOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    moreButtonOptions?: MoreButtonOptions;

    /**
     * Set tool bar style.
     *
     * @type { ?BarStyle }
     * @default BarStyle.STANDARD
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    barStyle?: BarStyle;

    /**
     * Set whether toolbar displays text.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hideItemValue?: boolean;
}

/**
 * Indicates the options of Navigation's Menu.
 *
 * @interface NavigationMenuOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface NavigationMenuOptions {
    /**
     * More button options.
     *
     * @type { ?MoreButtonOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    moreButtonOptions?: MoreButtonOptions;
}

/**
 * Indicates the options of Navigation's Menu.
 *
 * @interface MoreButtonOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface MoreButtonOptions {
    /**
     * Background blur style.
     *
     * @type { ?BlurStyle }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyle?: BlurStyle;

    /**
     * Background blur style options.
     *
     * @type { ?BackgroundBlurStyleOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundBlurStyleOptions?: BackgroundBlurStyleOptions;

    /**
     * Background effect options.
     *
     * @type { ?BackgroundEffectOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backgroundEffect?: BackgroundEffectOptions;
}

/**
 * Declare Navigation view properties.
 *
 * @extends CommonMethod
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @noninterop
 */
export declare interface NavigationAttribute extends CommonMethod {
    /**
     * Sets the width of navigation bar.
     *
     * @param { Length | Bindable<Length> | undefined } value
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    navBarWidth(value: Length | Bindable<Length> | undefined): this;

    /**
     * Sets the position of navigation bar.
     *
     * @param { NavBarPosition | undefined } value
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    navBarPosition(value: NavBarPosition | undefined): this;

    /**
     * Sets the minimum width and the maximum width of navigation bar.
     *
     * @param { [Dimension, Dimension] | undefined } value - The minimum and the maximum width of navigation bar.
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    navBarWidthRange(value: [
        Dimension,
        Dimension
    ] | undefined): this;

    /**
     * Sets the minimum width of content.
     *
     * @param { Dimension | undefined } value - The minimum width of content.
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    minContentWidth(value: Dimension | undefined): this;

    /**
     * Sets the mode of navigation.
     *
     * @param { NavigationMode | undefined } value
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    mode(value: NavigationMode | undefined): this;

    /**
     * Sets the back button icon.
     *
     * @param { string | PixelMap | Resource | SymbolGlyphModifier | undefined } value
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backButtonIcon(value: string | PixelMap | Resource | SymbolGlyphModifier | undefined): this;

    /**
     * Sets the back button icon and accessibility broadcast content.
     *
     * @param { string | PixelMap | Resource | SymbolGlyphModifier } icon - Indicates icon of back button
     * @param { ResourceStr | undefined } accessibilityText - Indicates content needs to broadcast.
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    backButtonIcon(icon: string | PixelMap | Resource | SymbolGlyphModifier | undefined, accessibilityText?: ResourceStr | undefined): this;

    /**
     * Hide the NavBar, which includes title bar, the child of Navigation and tool bar. Supported in all mode.
     * It will show top page in the NavPathStack directly or empty if there is no page in the NavPathStack.
     *
     * @param { boolean | undefined } value
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hideNavBar(value: boolean | undefined): this;

    /**
     * Navigation title
     *
     * @param { ResourceStr | CustomBuilder | NavigationCommonTitle | NavigationCustomTitle | undefined } value
     * @param { NavigationTitleOptions | undefined } [options] - Indicates the options of titlebar.
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    title(value: ResourceStr | CustomBuilder | NavigationCommonTitle | NavigationCustomTitle | undefined, options?: NavigationTitleOptions | undefined): this;

    /**
     * Hide navigation title bar
     *
     * @param { boolean | undefined } value
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hideTitleBar(value: boolean | undefined): this;

    /**
     * Hide navigation title bar
     *
     * @param { boolean | undefined } hide
     * @param { boolean | undefined } animated
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hideTitleBar(hide: boolean | undefined, animated: boolean | undefined): this;

    /**
     * Hide navigation back button
     *
     * @param { boolean | undefined } value
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hideBackButton(value: boolean | undefined): this;

    /**
     * Navigation title mode
     *
     * @param { NavigationTitleMode | undefined } value
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    titleMode(value: NavigationTitleMode | undefined): this;

    /**
     * Navigation title bar's menus
     *
     * @param { Array<NavigationMenuItem> | CustomBuilder | undefined } value
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    menus(value: Array<NavigationMenuItem> | CustomBuilder | undefined): this;

    /**
     * Navigation title bar's menus
     *
     * @param { Array<NavigationMenuItem> | CustomBuilder | undefined } items
     * @param { NavigationMenuOptions | undefined } [options] - Indicates the options of menu.
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    menus(items: Array<NavigationMenuItem> | CustomBuilder | undefined, options?: NavigationMenuOptions | undefined): this;

    /**
      * Configure toolbar with default style parameter or custom parameter.
      *
      * @param { Array<ToolbarItem> | CustomBuilder | undefined } value - Toolbar configuration parameters.
      * @param { NavigationToolbarOptions | undefined } [options] - Indicates the options of toolbar.
      * @returns { NavigationAttribute }
      * @syscap SystemCapability.ArkUI.ArkUI.Full
     `* @since 20
      */
    toolbarConfiguration(value: Array<ToolbarItem> | CustomBuilder | undefined, options?: NavigationToolbarOptions | undefined): this;

    /**
     * Hide tool bar
     *
     * @param { boolean | undefined } value
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hideToolBar(value: boolean | undefined): this;

    /**
     * Hide tool bar
     *
     * @param { boolean | undefined } hide
     * @param { boolean | undefined } animated
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hideToolBar(hide: boolean | undefined, animated: boolean | undefined): this;

    /**
     * Enable tool bar adaptation
     *
     * @param { boolean | undefined } enable - Enable or disable tool bar adaptation.
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableToolBarAdaptation(enable: boolean | undefined): this;

    /**
     * Trigger callback when title mode change finished at free mode.
     *
     * @param { function | undefined } callback
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onTitleModeChange(callback: ((titleMode: NavigationTitleMode) => void) | undefined): this;

    /**
     * Trigger callback when the visibility of navigation bar change.
     *
     * @param { function | undefined } callback
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onNavBarStateChange(callback: ((isVisible: boolean) => void) | undefined): this;

    /**
     * Trigger callback when navigation mode changes.
     *
     * @param { function | undefined } callback
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onNavigationModeChange(callback: ((mode: NavigationMode) => void) | undefined): this;

    /**
     * Set builder for user-defined NavDestination component.
     *
     * @param { PageMapBuilder | undefined } builder - The builder function of NavDestination component.
     * @returns { NavigationAttribute } Returns the instance of the NavigationAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    navDestination(builder: PageMapBuilder | undefined): this;

    /**
     * Set custom navigation content transition animation.
     *
     * @param { function | undefined } delegate - Custom transition delegate.
     * @returns { NavigationAttribute } Returns the instance of the NavigationAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    customNavContentTransition(delegate: ((from: NavContentInfo, to: NavContentInfo, operation: NavigationOperation) => NavigationAnimatedTransition | undefined) | undefined): this;

    /**
     * Set navigation content expand types and edges.
     *
     * @param { Array<LayoutSafeAreaType> | undefined } [types] - Indicates the types of the safe area.
     * @param { Array<LayoutSafeAreaEdge> | undefined } [edges] - Indicates the edges of the safe area.
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ignoreLayoutSafeArea(types?: Array<LayoutSafeAreaType> | undefined, edges?: Array<LayoutSafeAreaEdge> | undefined): this;

    /**
     * Set the style of system bar
     *
     * @param { SystemBarStyle | undefined } style - The properties of system bar
     * @returns { NavigationAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    systemBarStyle(style: SystemBarStyle | undefined): this;

    /**
     * Set the Navigation can be restored after the application is terminated.
     * To enable this attribute, a navigation id must be set.
     *
     * @param { boolean | undefined } recoverable - navigation can be recovered.
     * @returns { NavigationAttribute } Returns the instance of the NavigationAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    recoverable(recoverable: boolean | undefined): this;

    /**
     * Enable dragbar
     *
     * @param { boolean | undefined } isEnabled - enable dragbar or disable dragbar.
     * @returns { NavigationAttribute } Returns the instance of the NavigationAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableDragBar(isEnabled: boolean | undefined): this;

    /**
     * whether to enable modeChangeAnimation
     *
     * @param { boolean | undefined } isEnabled - enableModeChangeAnimation.
     * @returns { NavigationAttribute } Returns the instance of the NavigationAttribute.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enableModeChangeAnimation(isEnabled: boolean | undefined): this;
}

/**
* Navigation transition animation protocol.
*
* @interface NavigationAnimatedTransition
* @syscap SystemCapability.ArkUI.ArkUI.Full
* @since 20
*/
export declare interface NavigationAnimatedTransition {
    /**
     * This method is called after the transition ends to notify whether the transition was successful.
     *
     * @type { ?function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onTransitionEnd?: (success: boolean) => void;

    /**
     * Define the limit duration of the transition animation.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    timeout?: number;

    /**
     * Indicates whether it is an interactive transition.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isInteractive?: boolean;

    /**
     * Configure the animations associated with custom transition.
     *
     * @type { function }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    transition: (transitionProxy: NavigationTransitionProxy) => void;
}

/**
 * Navigation transition proxy.
 *
 * @interface NavigationTransitionProxy
 * @syscap SystemCapability.ArkUI.ArkUI.Full
* @since 20
*/
export declare interface NavigationTransitionProxy {
    /**
     * From navigation content info.
     *
     * @type { NavContentInfo }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    from: NavContentInfo;

    /**
     * To navigation content info.
     *
     * @type { NavContentInfo }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    to: NavContentInfo;

    /**
     * Indicates whether it is an interactive transition.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isInteractive?: boolean;

    /**
     * Notification system transition animation completed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    finishTransition(): void;

    /**
     * Notification system transition animation canceled.
     *
     * @type { ?VoidCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    cancelTransition?: VoidCallback;

    /**
     * Notification system transition animation update.
     *
     * @type { ?UpdateTransitionCallback }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    updateTransition?: UpdateTransitionCallback;
}

/**
 * navigation update transition callback.
 *
 * @typedef { function } UpdateTransitionCallback
 * @param { number } progress - Indicates the process of transition
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type UpdateTransitionCallback = (progress: number) => void;

/**
 * Navigation content info.
 *
 * @interface NavContentInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface NavContentInfo {
    /**
     * Navigation content name.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    name?: string;

    /**
     * Navigation content index.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    index: number;

    /**
     * Navigation content mode.
     *
     * @type { ?NavDestinationMode }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    mode?: NavDestinationMode;

    /**
     * Navigation content param.
     *
     * @type { ?Object }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    param?: Object;

    /**
     * The unique id of NavDestination.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    navDestinationId?: string;
}

@memo
@ComponentBuilder
export declare function Navigation(
    pathInfos?: NavPathStack, 
    @memo
    content_?: () => void,
): NavigationAttribute
