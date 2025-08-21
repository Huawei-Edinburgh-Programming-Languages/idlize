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
 */
import curves from '../../@ohos.curves';
import { memo, ComponentBuilder } from "./../stateManagement/runtime";
import { AttributeModifier, CommonMethod } from "./common";
/**
 * common enum of the checkbox shape
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum CheckBoxShape {
    /**
     * Circle.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CIRCLE = 0,
    /**
     * Rounded Square.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ROUNDED_SQUARE = 1
}
/**
 * common enum of color
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum Color {
    /**
     * White.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    White,
    /**
     * Black.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Black,
    /**
     * Blue.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Blue,
    /**
     * Brown.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Brown,
    /**
     * Gray.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Gray,
    /**
     * Green.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Green,
    /**
     * Grey.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Grey,
    /**
     * Orange.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Orange,
    /**
     * color.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Pink,
    /**
     * Red.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Red,
    /**
     * Yellow.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Yellow,
    /**
     * Transparent.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Transparent
}
/**
 * Common enum of color strategy
 *
 * @enum { string }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ColoringStrategy {
    /**
     * Use the inverse color strategy. Gets the inverse of the background color. Only applies to foregroundColor.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    INVERT = 'invert',
    /**
     * Use the average color strategy. Get the average color of the background. Only applies to shadow.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    AVERAGE = 'average',
    /**
     * Use the primary color strategy. Get the color that dominate the background color. Only applies to shadow.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PRIMARY = 'primary'
}
/**
 * Image display mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ImageFit {
    /**
     * Keep the aspect ratio to zoom out or zoom in so that the image is completely displayed within the display boundary.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Contain,
    /**
     * Keep the aspect ratio to zoom out or zoom in so that both sides of the image are greater than or equal to the display boundary.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Cover,
    /**
     * Adaptive display
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Auto,
    /**
     * Zoom in or out without maintaining the aspect ratio so that the image fills the display boundary.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Fill,
    /**
     * Keep the aspect ratio displayed, and the image zooms out or remains unchanged.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ScaleDown,
    /**
     * Keep the original size and display it in the center.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None,
    /**
     * Top Start.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TOP_START = 7,
    /**
     * The top is centered horizontally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TOP = 8,
    /**
     * Top tail end.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TOP_END = 9,
    /**
     * The starting end is centered longitudinally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    START = 10,
    /**
     * Center horizontal and vertical.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CENTER = 11,
    /**
     * The tail end is centered longitudinally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    END = 12,
    /**
     * Bottom starting end.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BOTTOM_START = 13,
    /**
     * The bottom is centered horizontally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BOTTOM = 14,
    /**
     * Bottom end.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BOTTOM_END = 15,
    /**
     * Matrix of Image.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MATRIX = 16
}
/**
 * Border Style
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum BorderStyle {
    /**
     * Displays as a series of dots with a radius of half the borderWidth.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Dotted,
    /**
     * Shows as a series of short square dashed lines.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Dashed,
    /**
     * Shows as a solid line.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Solid
}
/**
 * Line Join Style
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum LineJoinStyle {
    /**
     * Connect path segments using bevels.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Miter,
    /**
     * Connect path segments using sharp corners.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Round,
    /**
     * Connect path segments using fillets.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Bevel
}
/**
 * Function Called by Touch
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TouchType {
    /**
     * Triggered when the finger is pressed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Down,
    /**
     * Triggered when the finger is raised.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Up,
    /**
     * Triggered when the finger presses on the screen.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Move,
    /**
     * Triggers when the touch event cancels.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Cancel
}
/**
 * Function Called by Touch or Gesture.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum InteractionHand {
    /**
     * Unknown hand.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NONE = 0,
    /**
     * Left hand.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LEFT = 1,
    /**
     * Right hand.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RIGHT = 2
}
/**
 * Function Called by Mouse
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum MouseButton {
    /**
     * Mouse Left Button.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Left,
    /**
     * Mouse Right Button.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Right,
    /**
     * Mouse Middle Button.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Middle,
    /**
     * Mouse Back Button.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Back,
    /**
     * Mouse Forward Button.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Forward,
    /**
     * Mouse None Button.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None
}
/**
 * Function Called by Mouse
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum MouseAction {
    /**
     * Triggered when the mouse is pressed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Press,
    /**
     * Triggered when the mouse is released.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Release,
    /**
     * Triggered when the mouse is Moved.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Move,
    /**
     * Triggered when the mouse is Hovered.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Hover,
    /**
     * Triggered when the mouse event is canceled.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CANCEL = 13
}
/**
 * Animation status.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum AnimationStatus {
    /**
     * Initial state of the animation.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Initial,
    /**
     * The animation is playing.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Running,
    /**
     * The animation is paused.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Paused,
    /**
     * The animation is stopped.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Stopped
}
/**
 * enum Curve.
 *
 * @typedef { curves.Curve } Curve
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type Curve = curves.Curve;
/**
 * Sets the state before and after the animation starts.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum FillMode {
    /**
     * Restores to the initial state after the playback is complete.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None,
    /**
     * Retains the state at the end of the animation when the playback is complete.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Forwards,
    /**
     * Applies the start attribute value for the period specified by animation-delay before the animation is displayed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Backwards,
    /**
     * Both forward and backward fill modes are applied.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Both
}
/**
 * Play Mode
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum PlayMode {
    /**
     * The animation plays normally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Normal,
    /**
     * The animation plays backwards.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Reverse,
    /**
     * The animation plays forward on odd numbers (1, 3, 7...) and backward on even numbers (2, 4, 6...).
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Alternate,
    /**
     * The animation plays backwards on odd numbers (1, 3, 7...) and forwards on even numbers (2, 4, 6...)..
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    AlternateReverse
}
/**
 * Type of a key.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum KeyType {
    /**
     * Press the key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Down,
    /**
     * The key is released.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Up
}
/**
 * Type of the input device that triggers the current key.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum KeySource {
    /**
     * The input device type is unknown.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Unknown,
    /**
     * Set Device Type to Keyboard.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Keyboard,
    /**
     * Set Device Type to Joystic.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    JOYSTICK
}
/**
 * Edge.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum Edge {
    /**
     * The top is centered horizontally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Top,
    /**
     * The bottom is centered horizontally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Bottom,
    /**
     * Align the head of the cross axis direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Start,
    /**
     * Align the head of the cross axis direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    End
}
/**
 * Set Weekend
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum Week {
    /**
     * Monday.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Mon,
    /**
     * Tuesday.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Tue,
    /**
     * Wednesday.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Wed,
    /**
     * Thursday.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Thur,
    /**
     * Friday.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Fri,
    /**
     * Saturday.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Sat,
    /**
     * Sunday.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Sun
}
/**
 * Sets the horizontal layout of elements.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum Direction {
    /**
     * Elements are laid out from left to right.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Ltr,
    /**
     * Elements are laid out from right to left.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Rtl,
    /**
     * Use the default layout direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Auto
}
/**
 * Used to set the status of the scroll bar.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum BarState {
    /**
     * Not displayed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Off,
    /**
     * On-demand display (displayed when you touch it and disappears after 2 seconds).
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Auto,
    /**
     * Resident display.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    On
}
/**
 * Sliding effect
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum EdgeEffect {
    /**
     * Elastic physical action, sliding to the edge can continue to slide for a distance based on the initial speed or touch event, and spring back when released.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Spring,
    /**
     * Fade.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Fade,
    /**
     * Sliding to the edge has no effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None
}
/**
 * Alignment enumeration description.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum Alignment {
    /**
     * Top Start.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TopStart,
    /**
     * The top is centered horizontally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Top,
    /**
     * Top tail end.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TopEnd,
    /**
     * The starting end is centered longitudinally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Start,
    /**
     * Center horizontal and vertical.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Center,
    /**
     * The tail end is centered longitudinally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    End,
    /**
     * Bottom starting end.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BottomStart,
    /**
     * The bottom is centered horizontally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Bottom,
    /**
     * Bottom end.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BottomEnd
}
/**
 * TransitionType enumeration description.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TransitionType {
    /**
     * Specifies that the current transition action takes effect in all change scenarios of the component.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    All,
    /**
     * Specifies the insertion scenario in which the current transition action takes effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Insert,
    /**
     * Specifies the deletion scenario in which the current transition action takes effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Delete
}
/**
 * RelateType enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum RelateType {
    /**
     * Scales the current component to fill the parent component.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FILL,
    /**
     * Scales the current component to fit the parent component.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FIT
}
/**
 * Controls the display or hide of the current component
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum Visibility {
    /**
     * Show
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Visible,
    /**
     * Hide, but participate in layout for placeholder.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Hidden,
    /**
     * Hides but does not participate in layout and does not take place.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None
}
/**
 * LineCapStyle enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum LineCapStyle {
    /**
     * The two ends of the dividing line are parallel lines.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Butt,
    /**
     * The two ends of the dividing line are semicircles.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Round,
    /**
     * Extends half a circle at the end of the path with a width equal to half the line width and a height equal to the line width.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Square
}
/**
 * Axis enumeration description.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum Axis {
    /**
     * Longitudinal arrangement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Vertical,
    /**
     * Horizontal arrangement.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Horizontal
}
/**
 * HorizontalAlign enumeration description.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum HorizontalAlign {
    /**
     * Aligns the start end in the language direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Start,
    /**
     * Center alignment. The default alignment mode is used.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Center,
    /**
     * Aligns the ends in the language direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    End
}
/**
 * FlexAlign enumeration description.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum FlexAlign {
    /**
     * The element is aligned at the head of the principal axis,
     * the first element is aligned with the head of the row, and subsequent elements are aligned with the previous one.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Start,
    /**
     * The elements are centered in the direction of the principal axis,
     * and the first element is the same distance from the beginning of the row as the last element is from the end of the row.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Center,
    /**
     * The element is aligned at the tail of the principal axis,
     * the last element is aligned at the end of the row, and the other elements are aligned with the next.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    End,
    /**
     * Elastic elements are evenly distributed in the direction of the Flex principal axis,
     * with the same distance between adjacent elements.
     * The first element aligns with the beginning of the line, and the last element aligns with the end of the line.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SpaceBetween,
    /**
     * Elastic elements are evenly distributed in the direction of the Flex principal axis,
     *  with the same distance between adjacent elements. Half the distance between adjacent elements as the distance between
     * the first element and the distance between the last element and the end of the row.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SpaceAround,
    /**
     * Elements in the Flex axis direction are evenly spaced.
     * The spacing between adjacent elements, the spacing between the first element and the beginning of the row,
     * and the spacing between the last element and the end of the row are the same.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SpaceEvenly
}
/**
 * ItemAlign enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ItemAlign {
    /**
     * Use the default configuration in the Flex container.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Auto,
    /**
     * The element is in the Flex container with the cross-axis direction head aligned.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Start,
    /**
     * The element is centered in the Flex container with the cross axis direction aligned.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Center,
    /**
     * The element is bottom aligned in the Flex container with the cross axis direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    End,
    /**
     * Element In the Flex container, the cross-axis direction text baseline is aligned.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Baseline,
    /**
     * Element In a Flex container, the fill is stretched across the axis and, when no dimension is set, to the container size.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Stretch
}
/**
 * FlexDirection enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum FlexDirection {
    /**
     * The main axis is consistent with the row direction as the layout mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Row,
    /**
     * The main axis is consistent with the column direction as the layout mode.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Column,
    /**
     * The layout is in the opposite direction to the Row direction.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RowReverse,
    /**
     * Layout in the opposite direction to the column.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ColumnReverse
}
/**
 * Pixel Round Direction
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum PixelRoundCalcPolicy {
    /**
     * No Force round the component boundary coordinates to integer pixel.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NO_FORCE_ROUND = 0,
    /**
     * Force ceil the component boundary coordinates to integer pixel.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FORCE_CEIL = 1,
    /**
     * Force floor the component boundary coordinates to integer pixel.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FORCE_FLOOR = 2
}
/**
 * Pixel Round Mode
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum PixelRoundMode {
    /**
     * Do pixel round on layout finish.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PIXEL_ROUND_ON_LAYOUT_FINISH = 0,
    /**
     * Do pixel round after measure.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PIXEL_ROUND_AFTER_MEASURE = 1
}
/**
 * FlexWrap enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum FlexWrap {
    /**
     * The Flex container has a single row/column layout of elements, and children are allowed to go beyond the container.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NoWrap,
    /**
     * The elements of the Flex container are arranged in multiple rows or columns, and the sub-items are allowed to exceed the container.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Wrap,
    /**
     * The elements of the Flex container are arranged in reverse multiple rows/columns, and children are allowed to exceed the container.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    WrapReverse
}
/**
 * VerticalAlign enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum VerticalAlign {
    /**
     * Top alignment.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Top,
    /**
     * Center alignment. The default alignment mode is used.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Center,
    /**
     * Bottom alignment.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Bottom
}
/**
 * ImageRepeat enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ImageRepeat {
    /**
     * Do not draw the picture again.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NoRepeat,
    /**
     * Repeat the drawing only on the horizontal axis.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    X,
    /**
     * Repeat the drawing only on the vertical axis.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Y,
    /**
     * Draw the picture repeatedly on both axes.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    XY
}
/**
 * ImageSize enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ImageSize {
    /**
     * Keep the scale of the original image unchanged.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Auto,
    /**
     * Keep the aspect ratio to zoom in or out the image so that both sides of the image are greater than or equal to the display boundary.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Cover,
    /**
     * Keep the aspect ratio to zoom out or zoom in so that the image is completely displayed within the display boundary.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Contain,
    /**
     * Zoom in or out without maintaining the aspect ratio so that the image fills the display boundary.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FILL = 3
}
/**
 * GradientDirection enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum GradientDirection {
    /**
     * Right to left.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Left,
    /**
     * From the bottom up.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Top,
    /**
     * From left to right.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Right,
    /**
     * From the top down.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Bottom,
    /**
     * Top Left
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LeftTop,
    /**
     * Left Bottom
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LeftBottom,
    /**
     * Right Top
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RightTop,
    /**
     * Right Bottom
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RightBottom,
    /**
     * None
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None
}
/**
 * SharedTransitionEffectType enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SharedTransitionEffectType {
    /**
     * The location of the destination page element remains unchanged, and you can configure the transparency animation. Currently,
     * only the static effect configured for redirecting to the target page takes effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Static,
    /**
     * Move the source page element to the destination page element location and scale it appropriately.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Exchange
}
/**
 * Text style
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum FontStyle {
    /**
     * Default style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Normal,
    /**
     * Italic style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Italic
}
/**
 * The font weight of the text
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum FontWeight {
    /**
     * Defines a lighter value than [Inherited Value]..
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Lighter,
    /**
     * Normal font. Equivalent to a digital value of 400.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Normal,
    /**
     * Defines a more general value than [Inherited Value].
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Regular,
    /**
     * Defines a value that is more centered than [Inherited Value].
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Medium,
    /**
     * Bold. Equivalent to a numeric value of 700.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Bold,
    /**
     * Defines a value that is heavier than [Inherited Value].
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Bolder
}
/**
 * Alignment of text.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TextAlign {
    /**
     * Center the text.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Center,
    /**
     * The text is aligned in the same direction as the writing
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Start,
    /**
     * The text is aligned in the opposite direction of writing
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    End,
    /**
     * Justify the text.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    JUSTIFY
}
/**
 * Declare how text overflows.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TextOverflow {
    /**
     * When the text overflows its dimensions, the text will not be cropped.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None,
    /**
     * When the text overflows its dimensions, the text will be cropped and displayed.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Clip,
    /**
     * If the text overflows its dimensions, the text that cannot be displayed shall be replaced by ellipsis.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Ellipsis,
    /**
     * When the text overflows its dimensions, the text will scroll for displaying.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MARQUEE
}
/**
 * Type of text modifier.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TextDecorationType {
    /**
     * Do not use text decorative lines.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None,
    /**
     * Underline the words.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Underline,
    /**
     * Text is in all uppercase.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Overline,
    /**
     * A modifier line that passes through the text.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LineThrough
}
/**
 * Letter type in text
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TextCase {
    /**
     * The default is normal.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Normal,
    /**
     * The text is all lowercase.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LowerCase,
    /**
     * The text is all uppercase.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    UpperCase
}
/**
 * Enum of text height adaptation
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TextHeightAdaptivePolicy {
    /**
     * Priority is given to using the maxLines attribute to adapt the text height.
     * If the layout size using the maxLines attribute exceeds the layout constraint, try reducing the font size to
     * display more text.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MAX_LINES_FIRST,
    /**
     * Priority is given to using the minFontSize attribute to adapt the text height.
     * If the text can be layout in a single line using the minFontSize property, try increasing the font size and using
     * the maximum possible font size.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MIN_FONT_SIZE_FIRST,
    /**
     * Priority is given to using the layout constraint to adapt the text height.
     * If the layout size exceeds the layout constraint, try reducing the font size. If the layout size still exceeds
     * the layout constraint after reducing the font size to minFontSize, remove the lines that exceed the layout
     * constraint.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LAYOUT_CONSTRAINT_FIRST
}
/**
 * ResponseType for contextMenu
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ResponseType {
    /**
     * Right click.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RightClick,
    /**
     * Long press.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LongPress
}
/**
 * HoverEffect enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum HoverEffect {
    /**
     * Default effect
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Auto,
    /**
     * Zoom in and out effect
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Scale,
    /**
     * Highlight effect
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Highlight,
    /**
     * None effect
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None
}
/**
 * Placement enumeration description
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum Placement {
    /**
     * Left placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Left,
    /**
     * Right placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Right,
    /**
     * Top placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Top,
    /**
     * Bottom placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Bottom,
    /**
     * TopLeft placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TopLeft,
    /**
     * TopRight placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TopRight,
    /**
     * BottomLeft placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BottomLeft,
    /**
     * BottomRight placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BottomRight,
    /**
     * LeftTop placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LeftTop,
    /**
     * LeftBottom placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LeftBottom,
    /**
     * RightTop placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RightTop,
    /**
     * RightBottom placement
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RightBottom
}
/**
 * ArrowPointPosition enumeration description
 *
 * @enum { string }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ArrowPointPosition {
    /**
     * Target start position
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    START = 'Start',
    /**
     * Target center position
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CENTER = 'Center',
    /**
     * Target end position
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    END = 'End'
}
/**
 * Indicates the share option.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum CopyOptions {
    /**
     * Not allow share.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None = 0,
    /**
     * Share in app.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    InApp = 1,
    /**
     * Share in local device.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LocalDevice = 2
}
/**
 * Defines the hit test mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum HitTestMode {
    /**
     * Both self and children nodes respond to the hit test for touch events,
     * but block hit test of the other nodes which is masked by this node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Default,
    /**
     * Self respond to the hit test for touch events,
     * but block hit test of children and other nodes which is masked by this node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Block,
    /**
     * Self and children respond to the hit test for touch events,
     * and allow hit test of other nodes which is masked by this node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Transparent,
    /**
     * Self not respond to the hit test for touch events,
     * but children respond to the hit test for touch events.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    None
}
/**
 * Title height.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TitleHeight {
    /**
     * Title height when only main title is available.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MainOnly,
    /**
     * Title height when main title and subtitle are both available.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MainWithSub
}
/**
 * Modifier key for hot key.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ModifierKey {
    /**
     * ctrl.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CTRL,
    /**
     * shift.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SHIFT,
    /**
     * alt.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ALT
}
/**
 * Function key for hot key.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum FunctionKey {
    /**
     * Escape key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ESC,
    /**
     * F1 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F1,
    /**
     * F2 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F2,
    /**
     * F3 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F3,
    /**
     * F4 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F4,
    /**
     * F5 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F5,
    /**
     * F6 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F6,
    /**
     * F7 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F7,
    /**
     * F8 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F8,
    /**
     * F9 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F9,
    /**
     * F10 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F10,
    /**
     * F11 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F11,
    /**
     * F12 key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    F12,
    /**
     * Tab key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TAB,
    /**
     * Up arrow key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DPAD_UP,
    /**
     * Down arrow key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DPAD_DOWN,
    /**
     * Left arrow key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DPAD_LEFT,
    /**
     * Right arrow key.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DPAD_RIGHT
}
/**
 * The alignment of ImageSpan
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ImageSpanAlignment {
    /**
     * Indicating that the bottom of the ImageSpan should be aligned with the baseline of the surrounding text.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BASELINE,
    /**
     * Indicating that the bottom of the ImageSpan should be aligned with the bottom of the surrounding text.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BOTTOM,
    /**
     * Indicating that the center of the ImageSpan should be aligned with the center of the surrounding text.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CENTER,
    /**
     * Indicating that the top of the ImageSpan should be aligned with the top of the surrounding text.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TOP
}
/**
 * ObscuredReasons.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ObscuredReasons {
    /**
     * Displayed data should appear as generic placeholders.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PLACEHOLDER = 0
}
/**
 * Text content style.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TextContentStyle {
    /**
     * Text content default style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DEFAULT,
    /**
     * Text content inline style.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    INLINE
}
/**
 * Enum of click effect level.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ClickEffectLevel {
    /**
     * Click effect level1.
     * The default scale number of this click effect level1 is 0.90.
     * The animation type is interpolatingSpring, velocity:10, mass:1, stiffness:410, damping:38.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LIGHT,
    /**
     * Click effect level2.
     * The default scale number of this click effect level2 is 0.95.
     * The animation type is interpolatingSpring, velocity:10, mass:1, stiffness:350, damping:35.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MIDDLE,
    /**
     * Click effect level3.
     * The default scale number of this click effect level3 is 0.95.
     * The animation type is interpolatingSpring, velocity:0, mass:1, stiffness:240, damping:28.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HEAVY
}
/**
 * The type of XComponent
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum XComponentType {
    /**
     * Surface type. The default type is used.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SURFACE,
    /**
     * Texture type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TEXTURE
}
/**
 * Nested scroll nested mode

 * @enum { number } NestedScrollMode
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum NestedScrollMode {
    /**
     * Only Self response scrolling.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SELF_ONLY,
    /**
     * Self priority response scrolling.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SELF_FIRST,
    /**
     * Parent scrollable component priority response scrolling.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PARENT_FIRST,
    /**
     * Both self and parent scrollable component response scrolling.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PARALLEL
}
/**
 * The possible source of scroll event
 * @enum { number } ScrollSource
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum ScrollSource {
    /**
     * Drag events.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DRAG = 0,
    /**
     * Fling after the drag has ended with velocity.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FLING,
    /**
     * Over scroll with EdgeEffect.Spring.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    EDGE_EFFECT,
    /**
     * Other user input except drag, such as mouse wheel, key event.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    OTHER_USER_INPUT,
    /**
     * Drag events of scroll bar.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SCROLL_BAR,
    /**
     * Fling after the drag on scroll bar has ended with velocity.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SCROLL_BAR_FLING,
    /**
     * Member methods of Scroller without animation.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SCROLLER,
    /**
     * Member methods of Scroller with animation.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SCROLLER_ANIMATION
}
/**
 * Enum of RenderFit
 *
 * @enum { number } RenderFit
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum RenderFit {
    /**
     * Without scaling the content area, the content area is drawn in the center of the node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CENTER = 0,
    /**
     * Without scaling the content area, the content area is drawn in the top center of the node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TOP = 1,
    /**
     * Without scaling the content area, the content area is drawn in the bottom center of the node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BOTTOM = 2,
    /**
     * Without scaling the content area, the content area is drawn in the left center of the node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LEFT = 3,
    /**
     * Without scaling the content area, the content area is drawn in the right center of the node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RIGHT = 4,
    /**
     * Without scaling the content area, the content area is drawn in the top left of the node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TOP_LEFT = 5,
    /**
     * Without scaling the content area, the content area is drawn in the top right of the node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TOP_RIGHT = 6,
    /**
     * Without scaling the content area, the content area is drawn in the bottom left of the node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BOTTOM_LEFT = 7,
    /**
     * Without scaling the content area, the content area is drawn in the bottom right of the node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BOTTOM_RIGHT = 8,
    /**
     * Scale the length and width of the content area to the node size to fill the node.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RESIZE_FILL = 9,
    /**
     * Scale the length or width of the content to the length or width of the node, ensuring that one side is equal,
     * the other side is less than or equal to the corresponding side of the node, and the content after scaling
     * is centered.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RESIZE_CONTAIN = 10,
    /**
     * Scale the length or width of the content to the length or width of the node, ensuring that one side is equal,
     * the other side is less than or equal to the corresponding side of the node. If the height of the scaled content
     * is less than or equal to the height of the node, the scaled content area is displayed at the top; otherwise,
     * the width of the scaled content is less than or equal to the width of the node, the scaled content area is
     * displayed at the left.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RESIZE_CONTAIN_TOP_LEFT = 11,
    /**
     * Scale the length or width of the content to the length or width of the node, ensuring that one side is equal,
     * the other side is less than or equal to the corresponding side of the node. If the height of the scaled content
     * is less than or equal to the height of the node, the scaled content area is displayed at the bottom; otherwise,
     * the width of the scaled content is less than or equal to the width of the node, the scaled content area is
     * displayed at the right.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RESIZE_CONTAIN_BOTTOM_RIGHT = 12,
    /**
     * Scale the length or width of the content to the length or width of the node, ensuring that one side is equal,
     * the other side is greater than or equal to the corresponding side of the node, and the content after scaling
     * displays the center area.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RESIZE_COVER = 13,
    /**
     * Scale the length or width of the content to the length or width of the node, ensuring that one side is equal,
     * the other side is greater than or equal to the corresponding side of the node. If the height of the scaled content
     * is greater than or equal to the height of the node, the scaled content area displays the top area; otherwise,
     * the width of the scaled content is greater than or equal to the width of the node, the scaled content area
     * displays the left area.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RESIZE_COVER_TOP_LEFT = 14,
    /**
     * Scale the length or width of the content to the length or width of the node, ensuring that one side is equal,
     * the other side is greater than or equal to the corresponding side of the node. If the height of the scaled content
     * is greater than or equal to the height of the node, the scaled content area displays the bottom area; otherwise,
     * the width of the scaled content is greater than or equal to the width of the node, the scaled content area
     * displays the right area.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    RESIZE_COVER_BOTTOM_RIGHT = 15
}
/**
 * The Button Style of dialog,
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum DialogButtonStyle {
    /**
     * Default Style.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DEFAULT = 0,
    /**
     * Highlight Style.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HIGHLIGHT = 1
}
/**
 * Enum of word break
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum WordBreak {
    /**
     * By default, CJK text can be wrapped between any 2 characters, and non-CJK text can only be wrapped in spaces.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NORMAL = 0,
    /**
     * Non-CJK text be wrapped at any character
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BREAK_ALL = 1,
    /**
     * Non-CJK text can be wrapped at any character
     * and if a complete word can be preserved in space breaks, the word must be kept on the line.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BREAK_WORD = 2,
    /**
     * For supported languages, line breaks can be performed by syllables.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HYPHENATION = 3
}
/**
 * Enum of line break strategy
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum LineBreakStrategy {
    /**
     * By default. Display as many characters as possible on each line until no more characters
     * can be displayed on that line, and do not automatically add hyphens under this strategy
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    GREEDY = 0,
    /**
     * High quality folding. Optimize the layout of the entire text's line breaks and automatically
     * add hyphens if necessary.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HIGH_QUALITY = 1,
    /**
     * Balanced folding. We will try our best to ensure that the width of each line in a paragraph
     * is the same, and if necessary, we will add conjunction
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BALANCED = 2
}
/**
 * Enum of Illuminated type
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @systemapi
 * @since 20
 */
export declare enum IlluminatedType {
    /**
     * Component is not illuminated.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    NONE = 0,
    /**
     * Border is illuminated.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    BORDER = 1,
    /**
     * Content is illuminated.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    CONTENT = 2,
    /**
     * Border and Content is illuminated.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    BORDER_CONTENT = 3,
    /**
     * Border is illuminated, and the border have a bloom effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    BLOOM_BORDER = 4,
    /**
     * Border and Content is illuminated, and the border have a bloom effect.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */
    BLOOM_BORDER_CONTENT = 5
}
/**
 * Enum of ellipsisMode
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum EllipsisMode {
    /**
     * The ellipsis is in the head.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    START = 0,
    /**
     * The ellipsis is in the middle.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CENTER = 1,
    /**
     * The ellipsis is at the end.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    END = 2
}
/**
 * A type which can be undefined
 *
 * @typedef { T | undefined } Nullable<T>
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type Nullable<T> = T | undefined;
/**
 * Decide whether the width of select menu fit the trigger or content
 *
 * @enum { string }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum OptionWidthMode {
    /**
     * The menu width fit the content.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FIT_CONTENT = 'fit_content',
    /**
     * The menu width fit the trigger.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FIT_TRIGGER = 'fit_trigger'
}
/**
 * Enumerates the fold status.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum FoldStatus {
    /**
     * Fold Status Unknown.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FOLD_STATUS_UNKNOWN = 0,
    /**
     * Fold Status Expanded.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FOLD_STATUS_EXPANDED = 1,
    /**
     * Fold Status Folded.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FOLD_STATUS_FOLDED = 2,
    /**
     * Fold Status Half Folded.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FOLD_STATUS_HALF_FOLDED = 3
}
/**
 * Enumerates the app rotation.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum AppRotation {
    /**
     * App does not rotate to display vertically.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ROTATION_0 = 0,
    /**
     * App rotates 90 degrees clockwise to display horizontally.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ROTATION_90 = 1,
    /**
     * App rotates 180 degrees clockwise to display vertically in reverse.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ROTATION_180 = 2,
    /**
     * App rotates 270 degrees clockwise to display horizontally in reverse.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ROTATION_270 = 3
}
/**
 * Enum of EmbeddedType
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum EmbeddedType {
    /**
     * The EmbeddedComponent show the UI in EmbeddedUIExtensionAbility.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    EMBEDDED_UI_EXTENSION = 0
}
/**
 * Marquee scrolling strategy after text update
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum MarqueeUpdateStrategy {
    /**
     * Reset scroll position and restart scroll.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DEFAULT = 0,
    /**
     * Preserve scroll position, just change to new text
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PRESERVE_POSITION = 1
}
/**
 * Type of text decoration line style.
 *
 * @enum {number}
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TextDecorationStyle {
    /**
     * Solid line.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SOLID = 0,
    /**
     * Double lines.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DOUBLE = 1,
    /**
     * Dotted line.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DOTTED = 2,
    /**
     * Dashed line.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    DASHED = 3,
    /**
     * Wavy line.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    WAVY = 4
}
/**
 * Type of text selectable.
 *
 * @enum {number}
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum TextSelectableMode {
    /**
     * set text selectable and unfocusable.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SELECTABLE_UNFOCUSABLE = 0,
    /**
     * set text selectable and focusable.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SELECTABLE_FOCUSABLE = 1,
    /**
     * set text unselectable and unfocusable.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    UNSELECTABLE = 2
}
/**
 * Type of accessibility hover event.
 *
 * @enum {number}
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum AccessibilityHoverType {
    /**
     * Hover enter type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HOVER_ENTER = 0,
    /**
     * Hover move type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HOVER_MOVE = 1,
    /**
     * Hover exit type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HOVER_EXIT = 2,
    /**
     * Hover cancel type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HOVER_CANCEL = 3
}
/**
 * Type of window width breakpoint.
 *
 * @enum {number}
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum WidthBreakpoint {
    /**
     * Window width < 320vp type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    WIDTH_XS = 0,
    /**
     * Window width >= 320vp and < 600vp type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    WIDTH_SM = 1,
    /**
     * Window width >= 600vp and < 840vp type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    WIDTH_MD = 2,
    /**
     * Window width >= 840vp and < 1440vp type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    WIDTH_LG = 3,
    /**
     * Window width >= 1440vp type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    WIDTH_XL = 4
}
/**
 * Type of window height breakpoint.
 *
 * @enum {number}
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum HeightBreakpoint {
    /**
     * Window aspectRatio < 0.8 type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HEIGHT_SM = 0,
    /**
     * Window aspectRatio >= 0.8 and < 1.2 type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HEIGHT_MD = 1,
    /**
     * Window aspectRatio >= 1.2 type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HEIGHT_LG = 2
}
/**
 * Type of axis.
 *
 * @enum {number}
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum AxisModel {
    /**
     * ABS_X axis type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ABS_X = 0,
    /**
    
     * ABS_Y axis type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ABS_Y = 1,
    /**
     * ABS_Z axis type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ABS_Z = 2,
    /**
     * ABS_RZ axis type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ABS_RZ = 3,
    /**
     * ABS_GAS axis type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ABS_GAS = 4,
    /**
     * ABS_BRAKE axis type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ABS_BRAKE = 5,
    /**
     * ABS_HAT0X axis type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ABS_HAT0X = 6,
    /**
     * ABS_HAT0Y axis type.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ABS_HAT0Y = 7
}
/**
 * Page flip mode of Swiper and Tabs on mouse wheel event.

 * @enum { number } PageFlipMode
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum PageFlipMode {
    /**
     * Turn pages continuously according to the number of mouse wheel events.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CONTINUOUS = 0,
    /**
     * The page-turning animation remains unresponsive to other mouse wheel events until it completes.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SINGLE = 1
}
/**
 * Rotating crown event behavior.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum CrownAction {
    /**
     * Rotation crown behavior begins.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BEGIN = 0,
    /**
     * Rotation crown behavior update.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    UPDATE = 1,
    /**
     * The rotation crown behavior ends.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    END = 2
}
/**
 * Sensitivity of rotating crown.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum CrownSensitivity {
    /**
     * Low sensitivity.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    LOW = 0,
    /**
     * Medium sensitivity.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    MEDIUM = 1,
    /**
     * High sensitivity.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    HIGH = 2
}
/**
 * Type of axis action.
 *
 * @enum {number}
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum AxisAction {
    /**
     * None action.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NONE = 0,
    /**
     * Triggered when an axis event starts.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    BEGIN = 1,
    /**
     * Triggered when the axis event is updated.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    UPDATE = 2,
    /**
     * Triggered when the axis event ends.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    END = 3,
    /**
     * Triggered when the axis event is cancelled.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    CANCEL = 4
}
/**
 * Type of focus draw level.
 *
 * @enum {number}
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum FocusDrawLevel {
    /**
     * Draw focus on node self level.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    SELF = 0,
    /**
     * Draw focus on top level.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    TOP = 1
}
/**
 * Menu divider mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum DividerMode {
    /**
     * Menu divider mode floating above menu.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    FLOATING_ABOVE_MENU = 0,
    /**
     * Menu divider mode embedded in menu.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    EMBEDDED_IN_MENU = 1
}
