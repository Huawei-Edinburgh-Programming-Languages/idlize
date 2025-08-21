/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/**
 * @file
 * @kit InputKit
 */
import type { InputEvent } from './@ohos.multimodalInput.inputEvent';
import type { KeyCode } from './@ohos.multimodalInput.keyCode';
/**
 * Action
 *
 * @enum { number }
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare enum Action {
    /**
     * Cancel
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    CANCEL = 0,
    /**
     * Moving of the mouse pointer
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    MOVE = 1,
    /**
     * Pressing down of the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    BUTTON_DOWN = 2,
    /**
     * Lifting of the mouse button
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    BUTTON_UP = 3,
    /**
     * Beginning of the axis event associated with the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    AXIS_BEGIN = 4,
    /**
     * Updating of the axis event associated with the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    AXIS_UPDATE = 5,
    /**
     * Ending of the axis event associated with the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    AXIS_END = 6,
    /**
     * Indicates a pointer action representing that a finger is pressed on touchpad.
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    ACTION_DOWN = 7,
    /**
     * Indicates a pointer action representing that a finger leaves touchpad.
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    ACTION_UP = 8
}
/**
 * Mouse button
 *
 * @enum { number }
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare enum Button {
    /**
     * Left button on the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    LEFT = 0,
    /**
     * Middle button on the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    MIDDLE = 1,
    /**
     * Right button on the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    RIGHT = 2,
    /**
     * Side button on the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    SIDE = 3,
    /**
     * Extended button on the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    EXTRA = 4,
    /**
     * Forward button on the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    FORWARD = 5,
    /**
     * Back button on the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    BACK = 6,
    /**
     * Task key on the mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    TASK = 7
}
/**
 * Axis
 *
 * @enum { number }
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare enum Axis {
    /**
     * Vertical scroll axis
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    SCROLL_VERTICAL = 0,
    /**
     * Horizontal scroll axis
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    SCROLL_HORIZONTAL = 1,
    /**
     * Pinch axis
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    PINCH = 2
}
/**
 * AxisValue
 *
 * @interface AxisValue
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare interface AxisValue {
    /**
     * Axis type
     * @type { Axis }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    axis: Axis;
    /**
     * Axis value
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    value: int;
}
/**
 * ToolType
 *
 * @enum { number }
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare enum ToolType {
    /**
     * Unknown type
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    UNKNOWN = 0,
    /**
     * Mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    MOUSE = 1,
    /**
     * Joystick
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    JOYSTICK = 2,
    /**
     * Touch pad
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    TOUCHPAD = 3
}
/**
 * MouseEvent
 *
 * @extends InputEvent
 * @interface MouseEvent
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare interface MouseEvent extends InputEvent {
    /**
     * Mouse event action
     * @type { Action }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    action: Action;
    /**
     * X coordinate of the mouse pointer on the screen
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    screenX: int;
    /**
     * Y coordinate of the mouse pointer on the screen
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    screenY: int;
    /**
     * X coordinate of the mouse pointer in the window
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    windowX: int;
    /**
     * Y coordinate of the mouse pointer in the window
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    windowY: int;
    /**
     * X axis offset relative to the previous reported mouse pointer position. When the mouse pointer is at
     * the edge of the screen, the value may be less than the difference of the X coordinate reported twice.
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    rawDeltaX: int;
    /**
     * Y axis offset relative to the previous reported mouse pointer position
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    rawDeltaY: int;
    /**
     * Button that is currently pressed or released
     * @type { Button }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    button: Button;
    /**
     * Button that is being pressed
     * @type { Button[] }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    pressedButtons: Button[];
    /**
     * All axis data contained in the event
     * @type { AxisValue[] }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    axes: AxisValue[];
    /**
     * List of pressed keys
     * @type { KeyCode[] }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    pressedKeys: KeyCode[];
    /**
     * Whether ctrlKey is being pressed
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    ctrlKey: boolean;
    /**
     * Whether altKey is being pressed
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    altKey: boolean;
    /**
     * Whether shiftKey is being pressed
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    shiftKey: boolean;
    /**
     * Whether logoKey is being pressed
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    logoKey: boolean;
    /**
     * Whether fnKey is being pressed
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    fnKey: boolean;
    /**
     * Whether capsLock is active
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    capsLock: boolean;
    /**
     * Whether numLock is active
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    numLock: boolean;
    /**
     * Whether scrollLock is active
     * @type { boolean }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    scrollLock: boolean;
    /**
     * Tool type
     *
     * @type { ToolType }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    toolType: ToolType;
}
