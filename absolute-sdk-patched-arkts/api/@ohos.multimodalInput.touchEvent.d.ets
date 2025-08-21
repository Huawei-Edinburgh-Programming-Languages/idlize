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
/**
 * Action
 *
 * @enum { number }
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare enum Action {
    /**
     * Touch cancelled
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    CANCEL = 0,
    /**
     * Touch pressed
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    DOWN = 1,
    /**
     * Touch moved
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    MOVE = 2,
    /**
     * Touch lifted
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    UP = 3
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
     * Finger
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    FINGER = 0,
    /**
     * Stylus
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    PEN = 1,
    /**
     * Rubber
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    RUBBER = 2,
    /**
     * Brush
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    BRUSH = 3,
    /**
     * Pencil
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    PENCIL = 4,
    /**
     * Air brush
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    AIRBRUSH = 5,
    /**
     * Mouse
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    MOUSE = 6,
    /**
     * lens
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    LENS = 7
}
/**
 * SourceType
 *
 * @enum { number }
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare enum SourceType {
    /**
     * Touchscreen
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    TOUCH_SCREEN = 0,
    /**
     * Stylus
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    PEN = 1,
    /**
     * Touchpad
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    TOUCH_PAD = 2
}
/**
 * Fixed mode of screenX and screenY.
 *
 * @enum { number }
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @systemapi Hide this for inner system use.
 * @since 20
 */
export declare enum FixedMode {
    /**
     * Not fix.
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    NONE = 0,
    /**
     * One hand mode.
     *
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    AUTO = 1
}
/**
 * Touch
 *
 * @interface Touch
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare interface Touch {
    /**
     * Pointer identifier
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    id: int;
    /**
     * Time stamp when touch is pressed
     * @type { long }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    pressedTime: long;
    /**
     * X coordinate of the touch position on the screen
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    screenX: int;
    /**
     * Y coordinate of the touch position on the screen
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    screenY: int;
    /**
     * X coordinate of the touch position in the window
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    windowX: int;
    /**
     * Y coordinate of the touch position in the window
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    windowY: int;
    /**
     * Pressure value. The value range is [0.0, 1.0]. The value 0.0 indicates that the pressure is not supported.
     * @type { double }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    pressure: double;
    /**
     * Width of the contact area when touch is pressed
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    width: int;
    /**
     * Height of the contact area when touch is pressed
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    height: int;
    /**
     * Angle relative to the YZ plane. The value range is [-90, 90]. A positive value indicates a rightward tilt.
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    tiltX: int;
    /**
     * Angle relative to the XZ plane. The value range is [-90, 90]. A positive value indicates a downward tilt.
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    tiltY: int;
    /**
     * Center point X of the tool area
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    toolX: int;
    /**
     * Center point Y of the tool area
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    toolY: int;
    /**
     * Width of the tool area
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    toolWidth: int;
    /**
     * Height of the tool area
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    toolHeight: int;
    /**
     * X coordinate of the input device
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    rawX: int;
    /**
     * Y coordinate of the input device
     * @type { int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    rawY: int;
    /**
     * Tool type
     * @type { ToolType }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    toolType: ToolType;
    /**
     * fixedDisplayX - Corrected value of the screen x coordinate.
     * @type { ?int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    fixedDisplayX?: int;
    /**
     * fixedDisplayY - Corrected value of the screen y coordinate.
     * @type { ?int }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    fixedDisplayY?: int;
}
/**
 * TouchEvent
 *
 * @extends InputEvent
 * @interface TouchEvent
 * @syscap SystemCapability.MultimodalInput.Input.Core
 * @since 20
 */
export declare interface TouchEvent extends InputEvent {
    /**
     * Touch action
     * @type { Action }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    action: Action;
    /**
     * Current touch point
     * @type { Touch }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    touch: Touch;
    /**
     * All touch points
     * @type { Touch[] }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    touches: Touch[];
    /**
     * Device type of the touch source
     * @type { SourceType }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @since 20
     */
    sourceType: SourceType;
    /**
     * fixedMode - Fixed mode of Touch.
     *
     * @type { FixedMode }
     * @syscap SystemCapability.MultimodalInput.Input.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    fixedMode?: FixedMode;
}
