/*
 * Copyright (C) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,software
 * distributed under the License is distributed on an "ASIS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * @file
 * @kit TestKit
 */
import { Callback } from './@ohos.base';


/**
 * Enumerates the string value match pattern.
 *
 * @enum {number}
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 */
declare enum MatchPattern {
    
    
    /**
     * Equals to a string.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    EQUALS = 0,
    
    
    /**
     * Contains a substring.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    CONTAINS = 1,
    
    
    /**
     * StartsWith a substring.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    STARTS_WITH = 2,
    
    
    /**
     * EndsWith a substring.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    ENDS_WITH = 3,
    /**
     * Matches the given value using a regular expression, which is case sensitive.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    REG_EXP = 4,
    /**
     * Matches the given value using a regular expression, which is case insensitive.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    REG_EXP_ICASE = 5
}

/**
 * Enumerates the window mode of the tested window.
 *
 * @enum { number }
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 */
declare enum WindowMode {
    
    /**
     * The test window is a full screen window.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    FULLSCREEN = 0,
    
    /**
     * The test window is the first window in the split screen state.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    PRIMARY = 1,
    
    /**
     * The test window is the second window in the split screen state.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    SECONDARY = 2,
    
    /**
     * The test window is a floating window.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    FLOATING = 3
}

/**
 * Enumerates the resize direction for the window.
 *
 * @enum { number }
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 */
declare enum ResizeDirection {
    
    /**
     * Left.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    LEFT = 0,
    
    /**
     * Right.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    RIGHT = 1,
    
    /**
     * Up.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    UP = 2,
    
    /**
     * Down.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    DOWN = 3,
    
    /**
     * Upper left.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    LEFT_UP = 4,
    
    /**
     * Lower left.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    LEFT_DOWN = 5,
    
    /**
     * Upper right.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    RIGHT_UP = 6,
    
    /**
     * Lower right.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    RIGHT_DOWN = 7
}

/**
 * Enumerates the rotation of the device display.
 *
 * @enum { number }
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 */
declare enum DisplayRotation {
    
    /**
     * Device display does not rotate to display vertically.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    ROTATION_0 = 0,
    
    /**
     * Device display rotates 90 degrees clockwise to display horizontally.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    ROTATION_90 = 1,
    
    /**
     * Device display rotates clockwise 180 degrees to display vertically in reverse.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    ROTATION_180 = 2,
    
    /**
     * Device display rotates 270 degrees clockwise to display horizontally in reverse.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    ROTATION_270 = 3
}


/**
 * Represents the point on the device screen.
 *
 * @typedef Point
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 */
declare interface Point {
    
    
    
    /**
     * The x-coordinate of the coordinate point.
     *
     * @type { int }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     */
    x: int;
    
    
    
    /**
     * The y-coordinate of the coordinate point.
     *
     * @type { int }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     */
    y: int;
    /**
     * The displayId to which the coordinate point belongs, default is the displayId of the main scrren.
     *
     * @type { ?int }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     */
    displayId?: int;
}


/**
 * Represents the rectangle area on the device screen.
 *
 * @typedef Rect
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 */
declare interface Rect {
    
    
    
    /**
     * The x-coordinate of the top left corner of the rectangle.
     *
     * @type { int }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     */
    left: int;
    
    
    
    /**
     * The y-coordinate of the top left corner of the rectangle.
     *
     * @type { int }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     */
    top: int;
    
    
    
    /**
     * The x-coordinate at the bottom right corner of the rectangle.
     *
     * @type { int }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     */
    right: int;
    
    
    
    /**
     * The y-coordinate at the bottom right corner of the rectangle.
     *
     * @type { int }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     */
    bottom: int;
}

/**
 * Represents filer condition to get the window .
 *
 * @typedef WindowFilter
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 */
declare interface WindowFilter {
    
    /**
     * The package name of the application which the window belongs to.
     *
     * @type { ?string }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     */
    bundleName?: string;
    
    /**
     * The title of the window.
     *
     * @type { ?string }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     */
    title?: string;
    
    /**
     * The focal state of the window.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     */
    focused?: boolean;
    /**
     * The active state of the window.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     */
    active?: boolean;
}

/**
 * Represents the information of an UI element, can be a component or window.
 *
 * @typedef UIElementInfo
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 * @test
 */
declare interface UIElementInfo {
    
    /**
     * The bundle name of the host application.
     * @type { string }
     * @readonly
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    readonly bundleName: string;
    
    /**
     * The component type, set it as 'window' if it's a window.
     * @type { string }
     * @readonly
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    readonly type: string;
    
    /**
     * The text of component, set it as window's title if it's a window.
     * @type { string }
     * @readonly
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    readonly text: string;
}

/**
 * Observer to monitor UI events.
 *
 * @typedef UIEventObserver
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 * @test
 */
declare interface UIEventObserver {
    
    /**
     * Listen for toast show once
     *
     * @param { 'toastShow' } type -'toastShow'.
     * @param { Callback<UIElementInfo> } callback - function, returns the monitored UIElementInfo.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    once(type: 'toastShow', callback: Callback<UIElementInfo>): void;
    
    /**
     * Listen for dialog show once
     *
     * @param { 'dialogShow' } type - 'dialogShow'.
     * @param { Callback<UIElementInfo> } callback - function, returns the monitored UIElementInfo.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    once(type: 'dialogShow', callback: Callback<UIElementInfo>): void;
}


/**
 * Enumerates the direction for the UI operation .
 *
 * @enum { number }
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 */
declare enum UiDirection {
    
    
    /**
     * Left.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    LEFT = 0,
    
    
    /**
     * Right.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    RIGHT = 1,
    
    
    /**
     * Up.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    UP = 2,
    
    
    /**
     * Down.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    DOWN = 3
}

/**
 * Enumerates the id of the button on the mouse.
 *
 * @enum { number }
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 * @test
 */
declare enum MouseButton {
    
    /**
     * Left button of the mouse.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    MOUSE_BUTTON_LEFT = 0,
    
    /**
     * Right button of the mouse..
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    MOUSE_BUTTON_RIGHT = 1,
    
    /**
     * MIDDLE button of the mouse.
     *
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    MOUSE_BUTTON_MIDDLE = 2
}
/**
 * Additional options touchpad multi-finger swipe gestures.
 * @interface TouchPadSwipeOptions
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 * @test
 */
declare interface TouchPadSwipeOptions {
    /**
     * Whether stay for 1 second and lift up after swipe, default is false.
     * @type { ?boolean }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    stay?: boolean;
    /**
     * Speed(pixels per second) of touchpad multi-finger swipe, default is 2000, the value ranges from 200 to 40000,set it 2000 if out of range.
     * @type { ?int }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    speed?: int;
}
/**
 * Text input method options.
 * @interface InputTextMode
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 * @test
 */
declare interface InputTextMode {
    /**
     * Whether to use copy and paste mode to input text, default is false.
     * @type { ?boolean }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    paste?: boolean;
    /**
     * Whether input text appending to the end of paragraph without clearing the text, default is false.
     * @type { ?boolean }
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    addition?: boolean;
}


/**
 * Describes the attribute requirements for the target Components.
 *
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 */
declare class On {
    
    
    /**
     * Specifies the text for the target Component.
     *
     * @param { string } txt - the text value.
     * @param { MatchPattern } [pattern] - the {@link MatchPattern} of the text value,Set it default {@link MatchPattern.EQUALS} if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    text(txt: string, pattern?: MatchPattern): On;
    
    
    /**
     * Specifies the id of the target Component.
     *
     * @param { string } id - the id value.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    id(id: string): On;
    
    
    /**
     * Specifies the type of the target Component.
     *
     * @param { string } tp - The type value.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    type(tp: string): On;
    
    
    /**
     * Specifies the clickable status of the target Component.
     *
     * @param { boolean } [b] - the clickable status.Set it default true if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    clickable(b?: boolean): On;
    
    
    /**
     * Specifies the longClickable status of the target Component.
     *
     * @param { boolean } [b] - the longClickable status.Set it default true if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    longClickable(b?: boolean): On;
    
    
    /**
     * Specifies the scrollable status of the target Component.
     *
     * @param { boolean } [b] - the scrollable status.Set it default true if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    scrollable(b?: boolean): On;
    
    
    /**
     * Specifies the enabled status of the target Component.
     *
     * @param { boolean } [b] - the enabled status.Set it default true if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    enabled(b?: boolean): On;
    
    
    /**
     * Specifies the focused status of the target Component.
     *
     * @param { boolean } [b] - the focused status.Set it default true if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    focused(b?: boolean): On;
    
    
    /**
     * Specifies the selected status of the target Component.
     *
     * @param { boolean } [b] the - selected status.Set it default true if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    selected(b?: boolean): On;
    
    
    /**
     * Specifies the checked status of the target Component.
     *
     * @param { boolean } [b] - the checked status.Set it default true if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    checked(b?: boolean): On;
    
    
    /**
     * Specifies the checkable status of the target Component.
     *
     * @param { boolean } [b] - the checkable status.Set it default true if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. 1. Incorrect parameter types; 2. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    checkable(b?: boolean): On;
    
    /**
     * Requires that the target Component which is before another Component that specified by the given {@link On}
     * object,used to locate Component relatively.
     *
     * @param { On } on - describes the attribute requirements of Component which the target one is in front of.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isBefore(on: On): On;
    
    /**
     * Requires that the target Component which is after another Component that specified by the given {@link On}
     * object,used to locate Component relatively.
     *
     * @param { On } on - describes the attribute requirements of Component which the target one is in back of.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isAfter(on: On): On;
    
    /**
     * Requires that the target Component which is inside of another Component that specified by the given {@link On}
     * object,used to locate Component relatively.
     *
     * @param { On } on - describes the attribute requirements of Component which the target one is inside of.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    within(on: On): On;
    
    /**
     * Specifies the bundleName of the application which the window that the target Component is located belongs.
     *
     * @param { string } bundleName - the bundleName of the specified window.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    inWindow(bundleName: string): On;
    /**
     * Specifies the description for the target Component.
     *
     * @param { string } val - the description value.
     * @param { MatchPattern } [pattern] - the {@link MatchPattern} of description value,set it default {@link MatchPattern.EQUALS} if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    description(val: string, pattern?: MatchPattern): On;
    /**
     * Specifies the id of the target Component.
     *
     * @param { string } id - the id value.
     * @param { MatchPattern } pattern - the {@link MatchPattern} of the text value,Set it default {@link MatchPattern.EQUALS} if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    id(id: string, pattern: MatchPattern): On;
    /**
     * Specifies the type of the target Component.
     *
     * @param { string } tp - The type value.
     * @param { MatchPattern } pattern - the {@link MatchPattern} of the text value,Set it default {@link MatchPattern.EQUALS} if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    type(tp: string, pattern: MatchPattern): On;
    /**
     * Specifies the hint for the target Component.
     *
     * @param { string } val - the hint value.
     * @param { MatchPattern } [pattern] - the {@link MatchPattern} of the text value,Set it default {@link MatchPattern.EQUALS} if null or undefined.
     * @returns { On } this {@link On} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    hint(val: string, pattern?: MatchPattern): On;
}


/**
 * Represents an Component of the ohos application,user can perform operations or query attributes on it.
 *
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 * @test
 */
declare class Component {
    
    
    /**
     * Click this {@link Component}.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    click(): Promise<void>;
    
    
    /**
     * Double click this {@link Component}.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    doubleClick(): Promise<void>;
    
    
    /**
     * Long click this {@link Component}.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    longClick(): Promise<void>;
    
    
    /**
     * Get the id attribute value.
     *
     * @returns { Promise<string> } the id value.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getId(): Promise<string>;
    
    
    /**
     * Get the text attribute value.
     *
     * @returns { Promise<string> } the text value.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getText(): Promise<string>;
    
    
    /**
     * Get the type name.
     *
     * @returns { Promise<string> } the type name.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getType(): Promise<string>;
    
    
    /**
     * Get the clickable status of this {@link Component}.
     *
     * @returns { Promise<boolean> } the clickable status.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isClickable(): Promise<boolean>;
    
    
    /**
     * Get the clickable status of this {@link Component}.
     *
     * @returns { Promise<boolean> } the clickable status.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isLongClickable(): Promise<boolean>;
    
    
    /**
     * Get the scrollable status of this {@link Component}.
     *
     * @returns { Promise<boolean> } the scrollable status.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isScrollable(): Promise<boolean>;
    
    
    /**
     * Get the enabled status of this {@link Component}.
     *
     * @returns { Promise<boolean> } the enabled status.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isEnabled(): Promise<boolean>;
    
    
    /**
     * Get the focused status of this {@link Component}.
     *
     * @returns { Promise<boolean> } the focused status.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isFocused(): Promise<boolean>;
    
    
    /**
     * Get the selected status of this {@link Component}.
     *
     * @returns { Promise<boolean> } the selected status.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isSelected(): Promise<boolean>;
    
    
    /**
     * Get the checked status of this {@link Component}.
     *
     * @returns { Promise<boolean> } the checked status.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isChecked(): Promise<boolean>;
    
    
    /**
     * Get the checkable status of this {@link Component}.
     *
     * @returns { Promise<boolean> } the checkable status.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isCheckable(): Promise<boolean>;
    
    
    /**
     * Inject text to this {@link Component},applicable to TextInput.
     *
     * @param { string } text - the text to inject.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    inputText(text: string): Promise<void>;
    /**
     * Inject text to this {@link Component},applicable to TextInput.
     *
     * @param { string } text - the text to inject.
     * @param { InputTextMode } mode - specific the mode to input text.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported, function can not work correctly due to limited device capabilities.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    inputText(text: string, mode: InputTextMode): Promise<void>;
    
    
    /**
     * Clear text of this {@link Component},applicable to TextInput.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    clearText(): Promise<void>;
    
    
    /**
     * Scroll on this {@link Component} to the top,applicable to scrollable one.
     *
     * @param { int } [speed] - the speed of swipe(pixels per second),ranges from 200 to 40000.Set it default 600 if out of range or null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    scrollToTop(speed?: int): Promise<void>;
    
    
    /**
     * Scroll on this {@link Component} to the bottom,applicable to scrollable one.
     *
     * @param { int } [speed] - the speed of swipe(pixels per second),ranges from 200 to 40000. Set it default 600 if out of range or null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types; 2. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    scrollToBottom(speed?: int): Promise<void>;
    
    
    /**
     * Get the bounds rect of this {@link Component}.
     *
     * @returns { Promise<Rect> } the bounds rect object.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getBounds(): Promise<Rect>;
    
    
    /**
     * Get the boundsCenter of this {@link Component}.
     *
     * @returns { Promise<Point> } the boundsCenter object.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getBoundsCenter(): Promise<Point>;
    
    /**
     * Drag this {@link Component} to the bounds rect of target Component.
     *
     * @param { Component } target - the target {@link Component}.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    dragTo(target: Component): Promise<void>;
    
    /**
     * Pinch enlarge this {@link Component} to the target scale.
     *
     * @param { double } scale - the scale of the pinch enlarge this {@link Component}'s size, ranges greater than 1.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    pinchOut(scale: double): Promise<void>;
    
    /**
     * Pinch shrink this {@link Component} to the target scale.
     *
     * @param { double } scale - the scale of the pinch shrink this {@link Component}'s size, ranges from 0 to 1.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    pinchIn(scale: double): Promise<void>;
    /**
     * Scroll on this {@link Component}to find matched {@link Component},applicable to scrollable one.
     *
     * @param { On } on - the attribute requirements of the target {@link Component}.
     * @returns { Promise<Component | null> } the found result, or null if not found.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    scrollSearch(on: On): Promise<Component | null>;
    /**
     * Get the description attribute value.
     *
     * @returns { Promise<string> } the description value.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getDescription(): Promise<string>;
    /**
     * Get the hint attribute value.
     *
     * @returns { Promise<string> } the hint value.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getHint(): Promise<string>;
    /**
     * Scroll on this {@link Component}to find matched {@link Component},applicable to scrollable one.
     *
     * @param { On } on - the attribute requirements of the target {@link Component}.
     * @param { boolean } [vertical] - Whether the swipe direction is vertical, default is true.
     * @param { int } [offset] - Offset from the swipe start/end point to the component border, default is 80.
     * @returns { Promise<Component | null> } the found result,or null if not found.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    scrollSearch(on: On, vertical?: boolean, offset?: int): Promise<Component | null>;
}


/**
 * The unified facade of UiTest framework,can be used to find {@link Component},trigger keyEvents,perform
 * coordinates-based UI actions,capture screen and so on.
 *
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 * @test
 */
declare class Driver {
    
    
    /**
     * Create an {@link Driver} object.
     *
     * @returns { Driver } the {@link Driver} object.
     * @throws { BusinessError } 17000001 - Initialization failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    static create(): Driver;
    
    
    /**
     * Delay with specified duration.
     *
     * @param { int } duration - the delay duration in milliseconds, not less than 0.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    delayMs(duration: int): Promise<void>;
    /**
     * Find the first matched {@link Component} on current UI.
     *
     * @param { On } on - the attribute requirements of the target {@link Component}.
     * @returns { Promise<Component | null> } the first matched {@link Component} or undefined.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    findComponent(on: On): Promise<Component | null>;
    /**
     * Find the first matched {@link UiWindow} window.
     *
     * @param { WindowFilter } filter - the filer condition of the target {@link UiWindow}.
     * @returns { Promise<UiWindow | null> } the first matched {@link UiWindow} or undefined.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    findWindow(filter: WindowFilter): Promise<UiWindow | null>;
    /**
     * Find the first matched {@link Component} on current UI during the time given.
     *
     * @param { On } on - the attribute requirements of the target {@link Component}.
     * @param { int } time - duration of finding in milliseconds, not less than 0.
     * @returns { Promise<Component | null> } the first matched {@link Component} or undefined.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    waitForComponent(on: On, time: int): Promise<Component | null>;
    /**
     * Find all the matched {@link Component}s on current UI.
     *
     * @param { On } on - the attribute requirements of the target {@link Component}.
     * @returns { Promise<Array<Component> | null> } the matched {@link Component}s list.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    findComponents(on: On): Promise<Array<Component> | null>;
    
    
    /**
     * Assert t the matched {@link Component}s exists on current UI;if not,assertError will be raised.
     *
     * @param { On } on - the attribute requirements of the target {@link Component}.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000003 - Assertion failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    assertComponentExist(on: On): Promise<void>;
    
    
    /**
     * Press the BACK key.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    pressBack(): Promise<void>;
    /**
     * Press the BACK key on the specified display.
     *
     * @param { int } displayId - the Id of the specified display.
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000007 - Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    pressBack(displayId: int): Promise<void>;
    
    /**
     * Press the specified key.
     *
     * @param { int } keyCode - the target keyCode.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    triggerKey(keyCode: int): Promise<void>;
    /**
     * Press the specified key on the specified display.
     *
     * @param { int } keyCode - the target keyCode.
     * @param { int } displayId - the Id of the specified display.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    triggerKey(keyCode: int, displayId: int): Promise<void>;
    
    /**
     * Press two or three key combinations
     *
     * @param { int } key0 - the first keyCode.
     * @param { int } key1 - the second keyCode.
     * @param { int } [key2] - the third keyCode,set it default 0 if null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    triggerCombineKeys(key0: int, key1: int, key2?: int): Promise<void>;
    
    
    /**
     * Click on the specified location on the screen.
     *
     * @param { int } x - the x-coordinate, not less than 0.
     * @param { int } y - the y-coordinate, not less than 0.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    click(x: int, y: int): Promise<void>;
    
    
    /**
     * DoubleClick on the specified location on the screen.
     *
     * @param { int } x - the x-coordinate, not less than 0.
     * @param { int } y - the y-coordinate, not less than 0.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    doubleClick(x: int, y: int): Promise<void>;
    
    
    /**
     * LongClick on the specified location on the screen.
     *
     * @param { int } x - the x-coordinate, not less than 0.
     * @param { int } y - the y-coordinate, not less than 0.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    longClick(x: int, y: int): Promise<void>;
    
    
    /**
     * Swipe on the screen between the specified points.
     *
     * @param { int } startx - the x-coordinate of the starting point, not less than 0.
     * @param { int } starty - the y-coordinate of the starting point, not less than 0.
     * @param { int } endx - the x-coordinate of the ending point, not less than 0.
     * @param { int } endy - the y-coordinate of the ending point, not less than 0.
     * @param { int } [speed] - the speed of swipe(pixels per second),ranges from 200 to 40000. Set it default 600 if out of range or null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    swipe(startx: int, starty: int, endx: int, endy: int, speed?: int): Promise<void>;
    
    /**
     * Drag on the screen between the specified points.
     *
     * @param { int } startx - the x-coordinate of the starting point, not less than 0.
     * @param { int } starty - the y-coordinate of the starting point, not less than 0.
     * @param { int } endx - the x-coordinate of the ending point, not less than 0.
     * @param { int } endy - the y-coordinate of the ending point, not less than 0.
     * @param { int } [speed] the speed of drag(pixels per second),ranges from 200 to 40000. Set it default 600 if out of range or null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    drag(startx: int, starty: int, endx: int, endy: int, speed?: int): Promise<void>;
    
    /**
     * Capture current screen and save as picture which PNG format.
     *
     * @param { string } savePath - the path where to store the picture, must be in the application sandbox directory.
     * @returns { Promise<boolean> } true if screen-capturing and file-storing are completed successfully,false otherwise.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    screenCap(savePath: string): Promise<boolean>;
    
    /**
     * Set the rotation of the device display.
     *
     * @param { DisplayRotation } rotation - the target rotation to set.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    setDisplayRotation(rotation: DisplayRotation): Promise<void>;
    
    /**
     * Get the rotation of the device display.
     *
     * @returns { Promise<DisplayRotation> } the current display rotation.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getDisplayRotation(): Promise<DisplayRotation>;
    
    /**
     * Enable/disable the rotation of device display.
     *
     * @param { boolean } enabled - enable the rotation or not.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    setDisplayRotationEnabled(enabled: boolean): Promise<void>;
    
    /**
     * Get the size of the device display.
     *
     * @returns { Promise<Point> } the size of the device display.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getDisplaySize(): Promise<Point>;
    /**
     * Get the size of the specified device display.
     *
     * @param { int } displayId - the Id of the specified display.
     * @returns { Promise<Point> } the size of the device display.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000007 - Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getDisplaySize(displayId: int): Promise<Point>;
    
    /**
     * Get the density of the device display.
     *
     * @returns { Promise<Point> } the density of the device display.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getDisplayDensity(): Promise<Point>;
    
    /**
     * Wake up the device display.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    wakeUpDisplay(): Promise<void>;
    
    /**
     * Press the home key.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    pressHome(): Promise<void>;
    /**
     * Press the home key to the specified display.
     *
     * @param { int } displayId - the Id of the specified display.
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000007 - Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    pressHome(displayId: int): Promise<void>;
    
    /**
     * Wait for the UI become idle.
     *
     * @param { int } idleTime - the threshold of UI idle time, in millisecond, not less than 0.
     * @param { int } timeout - the maximum time to wait for idle, in millisecond, not less than 0.
     * @returns { Promise<boolean> } true if wait for idle succeed in the timeout, false otherwise.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    waitForIdle(idleTime: int, timeout: int): Promise<boolean>;
    
    
    /**
     * Inject fling on the device display.
     *
     * @param { Point } from - the coordinate point where the finger touches the screen.
     * @param { Point } to - the coordinate point where the finger leaves the screen.
     * @param { int } stepLen - the length of each step, in pixels.
     * @param { int } [speed] - the speed of fling(pixels per second),ranges from 200 to 40000. Set it default 600 if out of range or null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    fling(from: Point, to: Point, stepLen: int, speed: int): Promise<void>;
    
    /**
     * Inject multi-pointer action on the device display.
     *
     * @param { PointerMatrix } pointers - the two-dimensional array of pointers to inject.
     * @param { int } [speed] - the speed of swipe(pixels per second),ranges from 200 to 40000. Set it default 600 if out of range or null or undefined.
     * @returns { Promise<boolean> } true if the operation finished, false
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    injectMultiPointerAction(pointers: PointerMatrix, speed?: int): Promise<boolean>;
    
    
    /**
     * Inject fling on the device display.
     *
     * @param { UiDirection } direction - the direction of this action.
     * @param { int } speed - the speed of fling (pixels per second),default is 600,the value ranges from 200 to 40000,set it 600 if out of range.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    fling(direction: UiDirection, speed: int): Promise<void>;
    /**
     * Inject fling on the specified device display.
     *
     * @param { UiDirection } direction - the direction of this action.
     * @param { int } speed - the speed of fling (pixels per second),default is 600,the value ranges from 200 to 40000,set it 600 if out of range.
     * @param { int } displayId - the Id of the specified display.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    fling(direction: UiDirection, speed: int, displayId: int): Promise<void>;
    
    /**
     * Click on the specified location on the screen with the specified mouse button, and press the specified key simultaneously if necessary.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { MouseButton } btnId - the button of Mouse.
     * @param { int } [key1] - the first keyCode,set it default 0 if null or undefined.
     * @param { int } [key2] - the second keyCode,set it default 0 if null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    mouseClick(p: Point, btnId: MouseButton, key1?: int, key2?: int): Promise<void>;
    
    /**
     * Move the mouse cursor to the specified location.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    mouseMoveTo(p: Point): Promise<void>;
    
    /**
     * The mouse wheel scrolls the specified cell at the specified position, and press the specified key simultaneously if necessary.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { boolean } down - whether the mouse wheel rolls down.
     * @param { int } d - the number of cells that the mouse wheel scrolls, each cell will make the target point shift 120 pixels.
     * @param { int } [key1] - the first keyCode,set it default 0 if null or undefined.
     * @param { int } [key2] - the second keyCode,set it default 0 if null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    mouseScroll(p: Point, down: boolean, d: int, key1?: int, key2?: int): Promise<void>;
    /**
     * The mouse wheel scrolls the specified cell at the specified position, and press the specified key simultaneously if necessary.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { boolean } down - whether the mouse wheel rolls down.
     * @param { int } d - the number of cells that the mouse wheel scrolls, each cell will make the target point shift 120 pixels.
     * @param { int } [key1] - the first keyCode,set it default 0 if null or undefined.
     * @param { int } [key2] - the second keyCode,set it default 0 if null or undefined.
     * @param { int } [speed] - The Speed of mouse wheel rolls(cells per second),ranges from 1 to 500.Set it default 20 if out of range or null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    mouseScroll(p: Point, down: boolean, d: int, key1?: int, key2?: int, speed?: int): Promise<void>;
    
    /**
     * Capture the specified area of current screen and save as picture which PNG format.
     *
     * @param { string } savePath - the path where to store the picture, must be in the application sandbox directory.
     * @param { Rect } [rect] - the specified area of current screen, default to full screen.Set it default if null or undefined.
     * @returns { Promise<boolean> } true if screen-capturing and file-storing are completed successfully,false otherwise.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    screenCapture(savePath: string, rect?: Rect): Promise<boolean>;
    
    /**
     * Create an {@link UIEventObserver} object.
     *
     * @returns { UIEventObserver } the {@link UIEventObserver} object.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    createUIEventObserver(): UIEventObserver;
    /**
     * Double click on the specified location on the screen with the specified mouse button, and press the specified key simultaneously if necessary.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { MouseButton } btnId - the button of Mouse.
     * @param { int } [key1] - the first keyCode,set it default 0 if null or undefined.
     * @param { int } [key2] - the second keyCode,set it default 0 if null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    mouseDoubleClick(p: Point, btnId: MouseButton, key1?: int, key2?: int): Promise<void>;
    /**
     * Long click on the specified location on the screen with the specified mouse button, and press the specified key simultaneously if necessary.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { MouseButton } btnId - the button of Mouse.
     * @param { int } [key1] - the first keyCode,set it default 0 if null or undefined.
     * @param { int } [key2] - the second keyCode,set it default 0 if null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    mouseLongClick(p: Point, btnId: MouseButton, key1?: int, key2?: int): Promise<void>;
    /**
     * Swipe on the screen between the specified points with mouse.
     *
     * @param { Point } from - the starting point.
     * @param { Point } to - the ending point.
     * @param { int } [speed] - speed of swipe (pixels per second),the value ranges from 200 to 40000.Set it default 600 if out of range or null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    mouseMoveWithTrack(from: Point, to: Point, speed?: int): Promise<void>;
    /**
     * Hold down the left mouse button and drag on the screen between the specified points.
     *
     * @param { Point } from - the starting point.
     * @param { Point } to - the ending point.
     * @param { int } [speed] - speed of drag (pixels per second),the value ranges from 200 to 40000,Set it default 600 if out of range or null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    mouseDrag(from: Point, to: Point, speed?: int): Promise<void>;
    /**
     * Inject text on the specified location.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { string } text - the text to inject.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    inputText(p: Point, text: string): Promise<void>;
    /**
     * Inject text on the specified location, default to input at the coordinate of the specified location.
     *
     * @param { Point } p - the coordinate of the specified location.
     * @param { string } text - the text to inject.
     * @param { InputTextMode } mode - specific the mode to input text.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not support, function can not work correctly due to limited device capabilities.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    inputText(p: Point, text: string, mode: InputTextMode): Promise<void>;
    /**
     * Simulate touchpad multi-finger swipe gestures.
     * @param { int } fingers Finger count of touchpad multi-finger swipe, ranges from 3 to 4.
     * @param { UiDirection } direction Direction of touchpad multi-finger swipe.
     * @param { TouchPadSwipeOptions } [options] Additional options touchpad multi-finger swipe gestures, set its parameters to default values if null or undefined.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 The async function is not called with await.
     * @throws { BusinessError } 17000005 This operation is not supported.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    touchPadMultiFingerSwipe(fingers: int, direction: UiDirection, options?: TouchPadSwipeOptions): Promise<void>;
    /**
     * Simulate pen click operation.
     * @param { Point } point Coordinate of the specified location.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    penClick(point: Point): Promise<void>;
    /**
     * Simulate pen long click operation.
     * @param { Point } point Coordinate of the specified location.
     * @param { double } [pressure] Pressure of pen long click operation, default is 1.0, the value ranges from 0.0 to 1.0.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    penLongClick(point: Point, pressure?: double): Promise<void>;
    /**
     * Simulate pen double click operation.
     * @param { Point } point Coordinate of the specified location.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    penDoubleClick(point: Point): Promise<void>;
    /**
     * Simulate pen swipe operation.
     * @param { Point } startPoint Coordinate of the specified location.
     * @param { Point } endPoint Coordinate of the specified location.
     * @param { int } [speed] Speed(pixels per second) of pen swipe, default is 600,the value ranges from 200 to 40000,set it 600 if out of range.
     * @param { double } [pressure] Pressure of pen swipe operation, default is 1.0, the value ranges from 0.0 to 1.0.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    penSwipe(startPoint: Point, endPoint: Point, speed?: int, pressure?: double): Promise<void>;
    /**
     * Inject pen multi-pointer action on the device display.
     * @param { PointerMatrix } pointers The two-dimensional array of pointers to inject.
     * @param { int } [speed] Speed(pixels per second) of inject pen pointer action, default is 600,the value ranges from 200 to 40000,set it 600 if out of range.
     * @param { double } [pressure] Pressure of inject pen pointer action operation, default is 1.0, the value ranges from 0.0 to 1.0.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 The async function is not called with await.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    injectPenPointerAction(pointers: PointerMatrix, speed?: int, pressure?: double): Promise<void>;
}

/**
 * Represents a window of the ohos application,user can perform operations or query attributes on it.
 *
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 * @test
 */
declare class UiWindow {
    
    /**
     * Get the bundle name of this {@link UiWindow}.
     *
     * @returns { Promise<string> } the bundle name.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getBundleName(): Promise<string>;
    
    /**
     * Get the bounds rect of this {@link UiWindow}.
     *
     * @returns { Promise<Rect> } the bounds rect object.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getBounds(): Promise<Rect>;
    
    /**
     * Get the title of this {@link UiWindow}.
     *
     * @returns { Promise<string> } the title value.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getTitle(): Promise<string>;
    
    /**
     * Get the window mode of this {@link UiWindow}.
     *
     * @returns { Promise<WindowMode> } the {@link WindowMode} object
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    getWindowMode(): Promise<WindowMode>;
    
    /**
     * Get the focused status of this {@link UiWindow}.
     *
     * @returns { Promise<boolean> } the focused status
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isFocused(): Promise<boolean>;
    
    /**
     * Set the focused status of this {@link UiWindow}.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    focus(): Promise<void>;
    
    /**
     * Move this {@link UiWindow} to the specified points.
     *
     * @param { int } x - the x coordinate of destination, not less than 0.
     * @param { int } y - the y coordinate of destination, not less than 0.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessError } 17000005 - This operation is not supported.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    moveTo(x: int, y: int): Promise<void>;
    
    /**
     * Resize this {@link UiWindow} to the specified size for the specified direction.
     *
     * @param { int } wide - the expected wide of the window after resizing.
     * @param { int } height - the expected height of the window after resizing.
     * @param { ResizeDirection } direction - the expected direction of the window after resizing.
     * @returns { Promise<void> }
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessError } 17000005 - This operation is not supported.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    resize(wide: int, height: int, direction: ResizeDirection): Promise<void>;
    
    /**
     * Change this {@link UiWindow} into split screen mode.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessError } 17000005 - This operation is not supported.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    split(): Promise<void>;
    
    /**
     * Maximize this {@link UiWindow}.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessError } 17000005 - This operation is not supported.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    maximize(): Promise<void>;
    
    /**
     * Minimize this {@link UiWindow}.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessError } 17000005 - This operation is not supported.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
      */
    minimize(): Promise<void>;
    
    /**
     * Resume this {@link UiWindow}.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessError } 17000005 - This operation is not supported.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    resume(): Promise<void>;
    
    /**
     * Close this {@link UiWindow}.
     *
     * @returns { Promise<void> }
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @throws { BusinessError } 17000005 - This operation is not supported.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    close(): Promise<void>;
    /**
     * Get the active status of this {@link UiWindow}.
     *
     * @returns { Promise<boolean> } the active status.
     * @throws { BusinessError } 17000002 - The async function is not called with await.
     * @throws { BusinessError } 17000004 - The window or component is invisible or destroyed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    isActive(): Promise<boolean>;
}

/**
 * Represents a two-dimensional array of pointers on the device display, it's used to build a
 * multi-finger trace which can be injected with UiDriver.
 *
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 * @test
 */
declare class PointerMatrix {
    
    /**
     * Create an {@link PointerMatrix} object.
     *
     * @param { int } fingers - The number of fingers, ranges from 1 to 10.
     * @param { int } steps - The number of steps of each finger trace, ranges from 1 to 1000.
     * @returns { PointerMatrix } the {@link PointerMatrix} object.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    static create(fingers: int, steps: int): PointerMatrix;
    
    /**
     * Set the point value of an element in the PointerMatrix.
     *
     * @param { int } finger - the index of target finger to set.
     * @param { int } step - the index of target step to set.
     * @param { Point } point - the coordinate of target step to set.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified; 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Test.UiTest
     * @since 20
     * @test
     */
    setPoint(finger: int, step: int, point: Point): void;
}

/**
 * The static builder for building {@link On}object conveniently,usage example:ON.text('txt').enabled(true).
 *
 * @syscap SystemCapability.Test.UiTest
 * @since 20
 * @test
 */
declare const ON: On;
export { Component, Driver, UiWindow, ON, On, MatchPattern, DisplayRotation, ResizeDirection, WindowMode, Point, WindowFilter, Rect, PointerMatrix, UiDirection, MouseButton, UIElementInfo, UIEventObserver, TouchPadSwipeOptions, InputTextMode };
