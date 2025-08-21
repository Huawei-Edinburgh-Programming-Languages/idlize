/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
import { BaseEvent, SourceTool, Callback } from './common';
import { InteractionHand } from './enums';
/**
 * Creating an Object
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum PanDirection {
    /**
     * Default.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None,
    /**
     * Sliding horizontally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Horizontal,
    /**
     * Sliding left.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Left,
    /**
     * Sliding right.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Right,
    /**
     * Sliding Vertical
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Vertical,
    /**
     * Sliding up.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Up,
    /**
     * Sliding Down.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Down,
    /**
     * Sliding in all directions.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    All
}
/**
 * Creating an Object
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SwipeDirection {
    /**
     * Default.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None,
    /**
     * Sliding horizontally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Horizontal,
    /**
     * Sliding Vertical
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Vertical,
    /**
     * Sliding in all directions.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    All
}
/**
 * Creating an Object
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum GestureMode {
    /**
     * Sequential gesture recognition is performed in sequence according to the gesture registration sequence.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Sequence,
    /**
     * Simultaneous recognition. Registration gestures participate in recognition. Everything can be triggered.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Parallel,
    /**
     * Mutually exclusive recognition. Only one gesture is successfully recognized.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Exclusive
}
/**
 * Creating an Object
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum GestureMask {
    /**
     * High-priority response to the current gesture.When the current gesture fails to be recognized,
     * other gesture responses are triggered.For gestures with the same priority,
     * responses are performed based on the recognition sequence.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Normal,
    /**
     * Ignore internal gestures and recognize the current gesture first.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    IgnoreInternal
}
/**
 * Creating an Object
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum GestureJudgeResult {
    /**
     * The system gesture determination is not affected.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CONTINUE = 0,
    /**
     * The user-defined gesture determination result of the current component is fail.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    REJECT = 1
}
/**
 * Creating an Object
 *
 * @namespace GestureControl
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare namespace GestureControl {
    /**
     * Creating an Object
     *
     * @enum { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    enum GestureType {
        /**
         * TapGesture.
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        TAP_GESTURE = 0,
        /**
         * LongPressGesture.
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        LONG_PRESS_GESTURE = 1,
        /**
         * PanGesture.
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        PAN_GESTURE = 2,
        /**
         * PinchGesture.
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        PINCH_GESTURE = 3,
        /**
         * SwipeGesture.
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        SWIPE_GESTURE = 4,
        /**
         * RotationGesture.
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        ROTATION_GESTURE = 5,
        /**
         * Drag.
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        DRAG = 6,
        /**
         * Click.
         *
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        CLICK = 7
    }
}
/**
 * The description of gesture information.
 *
 * @interface GestureInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface GestureInfo {
    /**
     * The tag of gesture.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    tag?: string;
    /**
     * The type of gesture.
     *
     * @type { GestureControl.GestureType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type: GestureControl.GestureType;
    /**
     * The flag whether it is a system gesture.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isSystemGesture: boolean;
}
/**
 * Type of the finger information.
 *
 * @interface FingerInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface FingerInfo {
    /**
     * Finger unique identifier.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    id: number;
    /**
     * X coordinate of the touch point relative to the left edge of the device screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    globalX: number;
    /**
     * The Y coordinate of the touch point relative to the upper edge of the device screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    globalY: number;
    /**
     * X coordinate of the touch point relative to the left edge of the touched element.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    localX: number;
    /**
     * Y coordinate of the touch point relative to the upper edge of the touched element.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    localY: number;
    /**
     * X coordinate of the touch point relative to the left edge of the device screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    displayX: number;
    /**
     * Y coordinate of the touch point relative to the upper edge of the device screen.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    displayY: number;
    /**
     * Type of the touch hand.
     *
     * @type { ?InteractionHand }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    hand?: InteractionHand;
}
/**
 * Defines the Gesture Type.
 *
 * @typedef { Gesture | GestureGroup } GestureType
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type GestureType = Gesture | GestureGroup;
/**
 * Defines the gesture base event.
 *
 * @extends BaseEvent
 * @interface BaseGestureEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface BaseGestureEvent extends BaseEvent {
    /**
     * All finger information.
     *
     * @type { FingerInfo[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fingerList: FingerInfo[];
}
/**
 * Defines event info for tap gesture.
 *
 * @extends BaseGestureEvent
 * @interface TapGestureEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface TapGestureEvent extends BaseGestureEvent {
}
/**
 * Defines event info for long press gesture.
 *
 * @extends BaseGestureEvent
 * @interface LongPressGestureEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface LongPressGestureEvent extends BaseGestureEvent {
    /**
     * Indicates whether an event is triggered repeatedly.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    repeat: boolean;
}
/**
 * Defines event info for pan gesture.
 *
 * @extends BaseGestureEvent
 * @interface PanGestureEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface PanGestureEvent extends BaseGestureEvent {
    /**
     * Gesture event offset X.
     * The unit is vp.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offsetX: number;
    /**
     * Gesture event offset Y.
     * The unit is vp.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offsetY: number;
    /**
     * X-axis velocity of the gesture.
     * @type {number}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    velocityX: number;
    /**
     * Y-axis velocity of the gesture.
     * @type {number}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    velocityY: number;
    /**
     * velocity of the gesture.
     * @type {number}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    velocity: number;
}
/**
 * Defines event info for pinch gesture.
 *
 * @extends BaseGestureEvent
 * @interface PinchGestureEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface PinchGestureEvent extends BaseGestureEvent {
    /**
     * Scaling ratio.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scale: number;
    /**
     * X-axis coordinate of the kneading center point.
     * The unit is vp.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pinchCenterX: number;
    /**
     * Y-axis coordinate of the kneading center point.
     * The unit is vp.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pinchCenterY: number;
}
/**
 * Defines event info for rotation gesture.
 *
 * @extends BaseGestureEvent
 * @interface RotationGestureEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface RotationGestureEvent extends BaseGestureEvent {
    /**
     * Gesture event direction angle.
     * The unit is deg.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    angle: number;
}
/**
 * Defines event info for swipe gesture.
 *
 * @extends BaseGestureEvent
 * @interface SwipeGestureEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface SwipeGestureEvent extends BaseGestureEvent {
    /**
     * Gesture event direction angle.
     * The unit is deg.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    angle: number;
    /**
     * Gesture event slide speed.
     * The unit is vp.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    speed: number;
}
/**
 * Defines event info for gesture.
 *
 * @extends BaseEvent
 * @interface GestureEvent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface GestureEvent extends BaseEvent {
    /**
     * Indicates whether an event is triggered repeatedly.
     * Used in LongPressGesture.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    repeat: boolean;
    /**
     * All finger information.
     * Used in LongPressGesture and TapGesture.
     *
     * @type { FingerInfo[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fingerList: FingerInfo[];
    /**
     * Gesture event offset X.
     * The unit is vp.
     * Used in PanGesture.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offsetX: number;
    /**
     * Gesture event offset Y.
     * The unit is vp.
     * Used in PanGesture.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offsetY: number;
    /**
     * Gesture event direction angle.
     * The unit is deg.
     * Used in RotationGesture and SwipeGesture.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    angle: number;
    /**
     * Gesture event slide speed.
     * The unit is vp.
     * Used in SwipeGesture.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    speed: number;
    /**
     * Scaling ratio.
     * Used in PinchGesture.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    scale: number;
    /**
     * X-axis coordinate of the kneading center point.
     * The unit is vp.
     * Used in PinchGesture.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pinchCenterX: number;
    /**
     * Y-axis coordinate of the kneading center point.
     * The unit is vp.
     * Used in PinchGesture.
     *
     * @type { number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pinchCenterY: number;
    /**
     * X-axis velocity of the gesture.
     * @type {number}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    velocityX: number;
    /**
     * Y-axis velocity of the gesture.
     * @type {number}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    velocityY: number;
    /**
     * velocity of the gesture.
     * @type {number}
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    velocity: number;
}
/**
 * Defines the BaseHandlerOptions options.
 * @interface BaseHandlerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface BaseHandlerOptions {
    /**
     * The flag to strict verification fingers, if touch finger size is over or less than fingers, gesture can not be
     * accepted.
     * The default value is false.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isFingerCountLimited?: boolean;
}
/**
 * Defines Gesture interface.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class Gesture {
    /**
     * Set gesture's tag.
     *
     * @param { string } tag
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    tag(tag: string): this;
    /**
     * Input source type for gesture response.
     *
     * @param { Array<SourceTool> } types - indicate the allowed input source for gesture to response
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    allowedTypes(types: Array<SourceTool>): this;
}
/**
 * Defines TapGesture parameters.
 *
 * @extends BaseHandlerOptions
 * @interface TapGestureParameters
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface TapGestureParameters extends BaseHandlerOptions {
    /**
     * Number of consecutive clicks recognized. If the value is less than 1, the default value is used.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    count?: number;
    /**
     * The hand index that triggers the click. If the value is less than 1, the default value is used.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fingers?: number;
    /**
     * The limited move distance of click. If the value is less than 0, the default value is used.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    distanceThreshold?: number;
}
/**
 * Defines TapGesture.
 *
 * @extends Gesture
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class TapGesture extends Gesture {
    /**
     * Set the value.
     * TapGestureParameters: The parameters of the tapGesture.
     *
     * @param { function } factory
     * @param { TapGestureParameters } [value]
     * @returns { TapGesture }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    static $_instantiate(factory: () => TapGesture, value?: TapGestureParameters): TapGesture;
    /**
     * Tap gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAction(event: Callback<GestureEvent>): this;
}
/**
 * Defines LongPressGesture.
 *
 * @extends Gesture
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class LongPressGesture extends Gesture {
    /**
     * Set the value.
     * fingers: Indicates the hand index that triggers the long press.
     * repeat: Indicates whether to trigger event callback continuously.
     * duration: Minimum press and hold time, in milliseconds.
     *
     * @param { function } factory
     * @param { LongPressGestureHandlerOptions } [value]
     * @returns { LongPressGesture }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    static $_instantiate(factory: () => LongPressGesture, value?: LongPressGestureHandlerOptions): LongPressGesture;
    /**
     * LongPress gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAction(event: Callback<GestureEvent>): this;
    /**
     * The LongPress gesture is successfully recognized. When the finger is lifted, the callback is triggered.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionEnd(event: Callback<GestureEvent>): this;
    /**
     * The LongPress gesture is successfully recognized and a callback is triggered when the touch cancel event is
     * received.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionCancel(event: Callback<GestureEvent>): this;
}
/**
 * Defines the PanGesture options.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class PanGestureOptions {
    /**
     * Constructor parameters.
     *
     * @param { PanGestureHandlerOptions } [value]
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(value?: PanGestureHandlerOptions);
    /**
     * Sets the direction attribute.
     *
     * @param { PanDirection } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setDirection(value: PanDirection): void;
    /**
     * Sets the setDistance attribute.
     *
     * @param { number } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setDistance(value: number): void;
    /**
     * Sets the setFingers attribute.
     *
     * @param { number } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setFingers(value: number): void;
    /**
     * Get the pan direction attribute.
     *
     * @returns { PanDirection } - Pan gesture direction
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getDirection(): PanDirection;
    /**
     * Returns the pan gesture's distance.
     * The unit is vp.
     *
     * @returns { number } - the distance of the pan gesture.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getDistance(): number;
}
/**
 * Defines PanGesture.
 *
 * @extends Gesture
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class PanGesture extends Gesture {
    /**
     * Set the value.
     *
     * @param { function } factory
     * @param { PanGestureHandlerOptions | PanGestureOptions } [value]
     * @returns { PanGesture }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    static $_instantiate(factory: () => PanGesture, value?: PanGestureHandlerOptions | PanGestureOptions): PanGesture;
    /**
     * Pan gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionStart(event: Callback<GestureEvent>): this;
    /**
     * Callback when the Pan gesture is moving.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionUpdate(event: Callback<GestureEvent>): this;
    /**
     * The Pan gesture is successfully recognized. When the finger is lifted, the callback is triggered.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionEnd(event: Callback<GestureEvent>): this;
    /**
     * The Pan gesture is successfully recognized and a callback is triggered when the touch cancel event is received.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionCancel(event: Callback<GestureEvent>): this;
}
/**
 * Defines SwipeGesture.
 *
 * @extends Gesture
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class SwipeGesture extends Gesture {
    /**
     * Set the value.
     *
     * @param { function } factory
     * @param { SwipeGestureHandlerOptions } [value]
     * @returns { SwipeGesture }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    static $_instantiate(factory: () => SwipeGesture, value?: SwipeGestureHandlerOptions): SwipeGesture;
    /**
     * Slide gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAction(event: Callback<GestureEvent>): this;
}
/**
 * Defines PinchGesture.
 *
 * @extends Gesture
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class PinchGesture extends Gesture {
    /**
     * Set the value.
     *
     * @param { function } factory
     * @param { PinchGestureHandlerOptions } [value]
     * @returns { PinchGesture }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    static $_instantiate(factory: () => PinchGesture, value?: PinchGestureHandlerOptions): PinchGesture;
    /**
     * Pinch gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionStart(event: Callback<GestureEvent>): this;
    /**
     * Callback when the Pinch gesture is moving.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionUpdate(event: Callback<GestureEvent>): this;
    /**
     * The Pinch gesture is successfully recognized. When the finger is lifted, the callback is triggered.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionEnd(event: Callback<GestureEvent>): this;
    /**
     * The Pinch gesture is successfully recognized and a callback is triggered when the touch cancel event is received.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionCancel(event: Callback<GestureEvent>): this;
}
/**
 * Defines RotationGesture.
 *
 * @extends Gesture
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class RotationGesture extends Gesture {
    /**
     * Set the value.
     *
     * @param { function } factory
     * @param { RotationGestureHandlerOptions } [value]
     * @returns { RotationGesture }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    static $_instantiate(factory: () => RotationGesture, value?: RotationGestureHandlerOptions): RotationGesture;
    /**
     * Rotation gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionStart(event: Callback<GestureEvent>): this;
    /**
     * Callback when the Rotation gesture is moving.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionUpdate(event: Callback<GestureEvent>): this;
    /**
     * The Rotation gesture is successfully recognized. When the finger is lifted, the callback is triggered.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionEnd(event: Callback<GestureEvent>): this;
    /**
     * The Rotation gesture is successfully recognized and a callback is triggered when the touch cancel event is
     * received.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionCancel(event: Callback<GestureEvent>): this;
}
/**
 * Defines the GestureGroup.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class GestureGroup {
    /**
     * Return to Obtain GestureGroup.
     *
     * @param { function } factory
     * @param { GestureMode } mode
     * @param { GestureType[] } gesture
     * @returns { GestureGroup }
     * @static
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    static $_instantiate(factory: () => GestureGroup, mode: GestureMode, ...gesture: GestureType[]): GestureGroup;
    /**
     * The Gesture group is successfully recognized and a callback is triggered when the touch cancel event is received.
     *
     * @param { Callback<void> } event
     * @returns { GestureGroup }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onCancel(event: Callback<void>): GestureGroup;
}
/**
 * Defines the gesture handler.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class GestureHandler {
    /**
     * Set the GestureHandler's tag.
     *
     * @param { string } tag
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    tag(tag: string): this;
    /**
     * Input source type for gesture response.
     *
     * @param { Array<SourceTool> } types - indicate the allowed input source for gesture to response
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    allowedTypes(types: Array<SourceTool>): this;
}
/**
 * Defines the TapGestureHandler options.
 *
 * @extends BaseHandlerOptions
 * @interface TapGestureHandlerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface TapGestureHandlerOptions extends BaseHandlerOptions {
    /**
     * Indicates the number of consecutive clicks recognized. If the value is less than 1, the default value is used.
     * The default value is 1.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    count?: number;
    /**
     * Indicates the hand index that triggers the click. If the value is less than 1, the default value is used.
     * The default value is 1.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fingers?: number;
}
/**
 * Defines the TapGesture handler.
 *
 * @extends GestureHandler
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class TapGestureHandler extends GestureHandler {
    /**
     * Constructor parameters.
     *
     * @param { TapGestureHandlerOptions } [options]
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(options?: TapGestureHandlerOptions);
    /**
     * Tap gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAction(event: Callback<GestureEvent>): this;
}
/**
 * Defines the LongPressGestureHandler options.
 *
 * @extends BaseHandlerOptions
 * @interface LongPressGestureHandlerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface LongPressGestureHandlerOptions extends BaseHandlerOptions {
    /**
     * Indicates the hand index that triggers the long press. If the value is less than 1, the default value is used.
     * The default value is 1.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fingers?: number;
    /**
     * Indicates whether an event is triggered repeatedly.
     * The default value is false.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    repeat?: boolean;
    /**
     * Indicates minimum press and hold time, in milliseconds.
     * The default value is 500ms.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    duration?: number;
}
/**
 * Defines the LongPressGesture handler.
 *
 * @extends GestureHandler
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class LongPressGestureHandler extends GestureHandler {
    /**
     * Constructor parameters.
     *
     * @param { LongPressGestureHandlerOptions } [options]
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(options?: LongPressGestureHandlerOptions);
    /**
     * LongPress gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAction(event: Callback<GestureEvent>): this;
    /**
     * The LongPress gesture is successfully recognized. When the finger is lifted, the callback is triggered.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionEnd(event: Callback<GestureEvent>): this;
    /**
     * The LongPress gesture is successfully recognized and a callback is triggered when the touch cancel event is
     * received.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionCancel(event: Callback<GestureEvent>): this;
}
/**
 * Defines the PanGestureHandler options.
 *
 * @extends BaseHandlerOptions
 * @interface PanGestureHandlerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface PanGestureHandlerOptions extends BaseHandlerOptions {
    /**
     * Indicates the hand index that triggers the pan. If the value is less than 1, the default value is used.
     * The default value is 1.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fingers?: number;
    /**
     * Indicates the move direction of the pan gesture.
     * The default value is PanDirection.All.
     *
     * @type { ?PanDirection }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    direction?: PanDirection;
    /**
     * Indicates minimum move distance.
     * The default value is 5vp.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    distance?: number;
}
/**
 * Defines the PanGesture handler.
 *
 * @extends GestureHandler
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class PanGestureHandler extends GestureHandler {
    /**
     * Constructor parameters.
     *
     * @param { PanGestureHandlerOptions } [options]
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(options?: PanGestureHandlerOptions);
    /**
     * Pan gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionStart(event: Callback<GestureEvent>): this;
    /**
     * Callback when the Pan gesture is moving.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionUpdate(event: Callback<GestureEvent>): this;
    /**
     * The Pan gesture is successfully recognized. When the finger is lifted, the callback is triggered.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionEnd(event: Callback<GestureEvent>): this;
    /**
     * The Pan gesture is successfully recognized and a callback is triggered when the touch cancel event is received.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionCancel(event: Callback<GestureEvent>): this;
}
/**
 * Defines the SwipeGestureHandler options.
 *
 * @extends BaseHandlerOptions
 * @interface SwipeGestureHandlerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface SwipeGestureHandlerOptions extends BaseHandlerOptions {
    /**
     * Indicates the hand index that triggers the swipe. If the value is less than 1, the default value is used.
     * The default value is 1.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fingers?: number;
    /**
     * Indicates the move direction of the swipe gesture.
     * The default value is SwipeDirection.All.
     *
     * @type { ?SwipeDirection }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    direction?: SwipeDirection;
    /**
     * Indicates minimum move speed.
     * The default value is 100vp/s.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    speed?: number;
}
/**
 * Defines the SwipeGesture handler.
 *
 * @extends GestureHandler
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class SwipeGestureHandler extends GestureHandler {
    /**
     * Constructor parameters.
     *
     * @param { SwipeGestureHandlerOptions } [options]
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(options?: SwipeGestureHandlerOptions);
    /**
     * Swipe gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onAction(event: Callback<GestureEvent>): this;
}
/**
 * Defines the PinchGestureHandler options.
 *
 * @extends BaseHandlerOptions
 * @interface PinchGestureHandlerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface PinchGestureHandlerOptions extends BaseHandlerOptions {
    /**
     * Indicates the hand index that triggers the pinch. If the value is less than 1, the default value is used.
     * The default value is 1.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fingers?: number;
    /**
     * Indicates minimum pinch move distance.
     * The default value is 5vp.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    distance?: number;
}
/**
 * Defines the PinchGesture handler.
 *
 * @extends GestureHandler
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class PinchGestureHandler extends GestureHandler {
    /**
     * Constructor parameters.
     *
     * @param { PinchGestureHandlerOptions } [options]
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(options?: PinchGestureHandlerOptions);
    /**
     * Pinch gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionStart(event: Callback<GestureEvent>): this;
    /**
     * Callback when the Pinch gesture is moving.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionUpdate(event: Callback<GestureEvent>): this;
    /**
     * The Pinch gesture is successfully recognized. When the finger is lifted, the callback is triggered.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionEnd(event: Callback<GestureEvent>): this;
    /**
     * The Pinch gesture is successfully recognized and a callback is triggered when the touch cancel event is received.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionCancel(event: Callback<GestureEvent>): this;
}
/**
 * Defines the RotationGestureHandler options.
 *
 * @extends BaseHandlerOptions
 * @interface RotationGestureHandlerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface RotationGestureHandlerOptions extends BaseHandlerOptions {
    /**
     * Indicates the hand index that triggers the rotation. If the value is less than 1, the default value is used.
     * The default value is 1.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fingers?: number;
    /**
     * Indicates minimum rotate angle.
     * The default value is 1deg.
     *
     * @type { ?number }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    angle?: number;
}
/**
 * Defines the RotationGesture handler.
 *
 * @extends GestureHandler
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class RotationGestureHandler extends GestureHandler {
    /**
     * Constructor parameters.
     *
     * @param { RotationGestureHandlerOptions } [options]
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(options?: RotationGestureHandlerOptions);
    /**
     * Rotation gesture recognition success callback.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionStart(event: Callback<GestureEvent>): this;
    /**
     * Callback when the Rotation gesture is moving.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionUpdate(event: Callback<GestureEvent>): this;
    /**
     * The Rotation gesture is successfully recognized. When the finger is lifted, the callback is triggered.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionEnd(event: Callback<GestureEvent>): this;
    /**
     * The Rotation gesture is successfully recognized and a callback is triggered when the touch cancel event is
     * received.
     *
     * @param { Callback<GestureEvent> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onActionCancel(event: Callback<GestureEvent>): this;
}
/**
 * Defines the GestureGroupGestureHandler options.
 *
 * @interface GestureGroupGestureHandlerOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface GestureGroupGestureHandlerOptions {
    /**
     * Indicates the mode of gesture group.
     *
     * @type { GestureMode }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    mode: GestureMode;
    /**
     * Indicates the gestures included in the gesture group.
     *
     * @type { GestureHandler[] }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    gestures: GestureHandler[];
}
/**
 * Defines the GestureGroup handler.
 *
 * @extends GestureHandler
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class GestureGroupHandler extends GestureHandler {
    /**
     * Constructor parameters.
     *
     * @param { GestureGroupGestureHandlerOptions } [options]
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor(options?: GestureGroupGestureHandlerOptions);
    /**
     * The GestureGroup gesture is successfully recognized and a callback is triggered when the touch cancel event is
     * received.
     *
     * @param { Callback<void> } event
     * @returns { this }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onCancel(event: Callback<void>): this;
}
/**
 * Creating an Object
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum GesturePriority {
    /**
     * The normal gesture priority.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NORMAL = 0,
    /**
     * The high gesture priority.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PRIORITY = 1
}
/**
 * Creating an Object
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum GestureRecognizerState {
    /**
     * Ready state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    READY = 0,
    /**
     * Detecting state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DETECTING = 1,
    /**
     * Pending state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PENDING = 2,
    /**
     * Blocked state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BLOCKED = 3,
    /**
     * Successful state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SUCCESSFUL = 4,
    /**
     * Failed state.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FAILED = 5
}
/**
 * Defines the scrollable target information.
 *
 * @extends EventTargetInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class ScrollableTargetInfo extends EventTargetInfo {
    /**
     * Returns whether the scrollable component is at begin.
     *
     * @returns { boolean } - true is at begin, false is not at begin
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isBegin(): boolean;
    /**
     * Returns whether the scrollable component is at end.
     *
     * @returns { boolean } - true is at end, false is not at end
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isEnd(): boolean;
}
/**
 * Defines the event target information.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class EventTargetInfo {
    /**
     * Returns the component's inspector id.
     *
     * @returns { string } - the inspector id of the component
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getId(): string;
}
/**
 * Defines the gesture recognizer.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class GestureRecognizer {
    /**
     * Returns the gesture's tag.
     *
     * @returns { string } - the gesture's tag
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getTag(): string;
    /**
     * Returns the gesture's type.
     *
     * @returns { GestureControl.GestureType } - the gesture's type
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getType(): GestureControl.GestureType;
    /**
     * Returns whether the gesture recognizer is built in recognizer.
     *
     * @returns { boolean } - true is built in recognizer, false is not built in recognizer
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isBuiltIn(): boolean;
    /**
     * set the enabled state of the gesture recognizer.
     *
     * @param { boolean } isEnabled - Indicates the enabled state.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setEnabled(isEnabled: boolean): void;
    /**
     * Returns whether the gesture recognizer is enabled.
     *
     * @returns { boolean } - true is enabled, false is not enabled
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isEnabled(): boolean;
    /**
     * Returns the gesture recognizer's state.
     *
     * @returns { GestureRecognizerState } - the gesture recognizer's state
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getState(): GestureRecognizerState;
    /**
     * Returns the event target information of the component.
     *
     * @returns { EventTargetInfo } - the event target information of the component.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getEventTargetInfo(): EventTargetInfo;
    /**
     * Returns whether the gesture recognizer is valid.
     *
     * @returns { boolean } - true is valid, false is invalid
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isValid(): boolean;
    /**
     * Returns the tap gesture's finger count.
     *
     * @returns { number } - the finger count of the tap gesture.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getFingerCount(): number;
    /**
     * Returns the tap gesture's limitFingerCount.
     *
     * @returns { boolean } - the limitFingerCount of the tap gesture.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isFingerCountLimit(): boolean;
}
/**
 * Defines the tap gesture recognizer.
 *
 * @extends GestureRecognizer
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class TapRecognizer extends GestureRecognizer {
    /**
     * Returns the tap gesture's count.
     *
     * @returns { number } - the count of the tap gesture.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getTapCount(): number;
}
/**
 * Defines the long press gesture recognizer.
 *
 * @extends GestureRecognizer
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class LongPressRecognizer extends GestureRecognizer {
    /**
     * Returns the long press gesture's repeat state.
     *
     * @returns { boolean } - the repeat state of the long press gesture.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    isRepeat(): boolean;
    /**
     * Returns the long press gesture's duration.
     * The unit is ms.
     *
     * @returns { number } - the duration of the long press gesture.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getDuration(): number;
}
/**
 * Defines the swipe gesture recognizer.
 *
 * @extends GestureRecognizer
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class SwipeRecognizer extends GestureRecognizer {
    /**
     * Returns the swipe gesture's speed.
     * The unit is vp/s.
     *
     * @returns { number } - the velocity threshold of the swipe gesture.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getVelocityThreshold(): number;
    /**
     * Returns the swipe gesture's direction.
     *
     * @returns { SwipeDirection } - the direction of the swipe gesture.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getDirection(): SwipeDirection;
}
/**
 * Defines the pinch gesture recognizer.
 *
 * @extends GestureRecognizer
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class PinchRecognizer extends GestureRecognizer {
    /**
     * Returns the pinch gesture's distance.
     * The unit is vp.
     *
     * @returns { number } - the distance of the pinch gesture.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getDistance(): number;
}
/**
 * Defines the rotation gesture recognizer.
 *
 * @extends GestureRecognizer
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class RotationRecognizer extends GestureRecognizer {
    /**
     * Returns the rotation gesture's angle.
     *
     * @returns { number } - the angle of the rotation gesture.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getAngle(): number;
}
/**
 * Defines the gesture recognizer.
 *
 * @extends GestureRecognizer
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class PanRecognizer extends GestureRecognizer {
    /**
     * Returns the the pan gesture options of the recognizer.
     *
     * @returns { PanGestureOptions } - Pan gesture options
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getPanGestureOptions(): PanGestureOptions;
}
