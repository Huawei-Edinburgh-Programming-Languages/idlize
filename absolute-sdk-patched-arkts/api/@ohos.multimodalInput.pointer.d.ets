/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
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
import { AsyncCallback } from './@ohos.base';
import image from './@ohos.multimedia.image';

/**
 * The pointer module provides APIs related to pointer attribute management, such as querying and setting pointer attributes.
 *
 * @namespace pointer
 * @syscap SystemCapability.MultimodalInput.Input.Pointer
 * @since 20
 */
declare namespace pointer {
    
    /**
     * Enumerates mouse pointer styles.
     *
     * @enum { number }
     * @syscap SystemCapability.MultimodalInput.Input.Pointer
     * @since 20
     */
    enum PointerStyle {
        /**
         * Default
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        DEFAULT,
        /**
         * East arrow
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        EAST,
        /**
         * West arrow
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        WEST,
        /**
         * South arrow
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        SOUTH,
        /**
         * North arrow
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        NORTH,
        /**
         * East-west arrow
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        WEST_EAST,
        /**
         * North-south arrow
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        NORTH_SOUTH,
        /**
         * North-east arrow
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        NORTH_EAST,
        /**
         * North-west arrow
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        NORTH_WEST,
        /**
         * South-east arrow
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        SOUTH_EAST,
        /**
         * South-west arrow
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        SOUTH_WEST,
        /**
         * Northeast and southwest adjustment
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        NORTH_EAST_SOUTH_WEST,
        /**
         * Northwest and southeast adjustment
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        NORTH_WEST_SOUTH_EAST,
        /**
         * Cross (accurate selection)
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        CROSS,
        /**
         * Copy
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        CURSOR_COPY,
        /**
         * Forbid
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        CURSOR_FORBID,
        /**
         * Sucker
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        COLOR_SUCKER,
        /**
         * Grabbing hand
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        HAND_GRABBING,
        /**
         * Opening hand
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        HAND_OPEN,
        /**
         * Hand-shaped pointer
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        HAND_POINTING,
        /**
         * Help
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        HELP,
        /**
         * Move
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MOVE,
        /**
         * Left and right resizing
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        RESIZE_LEFT_RIGHT,
        /**
         * Up and down resizing
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        RESIZE_UP_DOWN,
        /**
         * Screenshot crosshair
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        SCREENSHOT_CHOOSE,
        /**
         * Screenshot
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        SCREENSHOT_CURSOR,
        /**
         * Text selection
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        TEXT_CURSOR,
        /**
         * Zoom in
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        ZOOM_IN,
        /**
         * Zoom out
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        ZOOM_OUT,
        /**
         * Scrolling east
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MIDDLE_BTN_EAST,
        /**
         * Scrolling west
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MIDDLE_BTN_WEST,
        /**
         * Scrolling south
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MIDDLE_BTN_SOUTH,
        /**
         * Scrolling north
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MIDDLE_BTN_NORTH,
        /**
         * Scrolling north and south
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MIDDLE_BTN_NORTH_SOUTH,
        /**
         * Scrolling northeast
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MIDDLE_BTN_NORTH_EAST,
        /**
         * Scrolling northwest
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MIDDLE_BTN_NORTH_WEST,
        /**
         * Scrolling southeast
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MIDDLE_BTN_SOUTH_EAST,
        /**
         * Scrolling southwest
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MIDDLE_BTN_SOUTH_WEST,
        /**
         * Moving as a cone in four directions
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MIDDLE_BTN_NORTH_SOUTH_WEST_EAST,
        /**
         * Horizontal text selection
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        HORIZONTAL_TEXT_CURSOR,
        /**
         * Precise selection
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        CURSOR_CROSS,
        /**
         * Cursor with circle style
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        CURSOR_CIRCLE,
        
        /**
         * Loading state with dynamic cursor
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        LOADING,
        
        /**
         * Running state with dynamic cursor
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        RUNNING,
        /**
         * Scrolling east and west
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        MIDDLE_BTN_EAST_WEST
    }
    /**
     * Mouse button.
     *
     * @enum { number }
     * @syscap SystemCapability.MultimodalInput.Input.Pointer
     * @since 20
     */
    enum PrimaryButton {
        /**
         * Left mouse button
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        LEFT = 0,
        /**
         * Right mouse button
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        RIGHT = 1
    }
    /**
     * Enumerates shortcut menu triggering modes.
     *
     * @enum { number }
     * @syscap SystemCapability.MultimodalInput.Input.Pointer
     * @since 20
     */
    enum RightClickType {
        /**
         * Tapping the right-button area of the touchpad.
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        TOUCHPAD_RIGHT_BUTTON = 1,
        /**
         * Tapping the left-button area of the touchpad.
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        TOUCHPAD_LEFT_BUTTON = 2,
        /**
         * Tapping or pressing the touchpad with two fingers.
         *
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        TOUCHPAD_TWO_FINGER_TAP = 3
    }
    /**
     * Defines the custom cursor configuration.
     *
     * @interface CursorConfig
     * @syscap SystemCapability.MultimodalInput.Input.Pointer
     * @since 20
     */
    interface CursorConfig {
        /**
         * Whether to adjust the cursor size based on system settings.
         * The value true means to adjust the cursor size based on system settings, and the value false means to use the custom cursor size.
         * The adjustment range is [size of the cursor image, 256 x 256].
         *
         * @type { boolean }
         * @syscap SystemCapability.MultimodalInput.Input.Pointer
         * @since 20
         */
        followSystem: boolean;
    }
    /**
     * Sets the mouse pointer style. This API uses an asynchronous callback to return the result.
     *
     * @param { int } windowId - Window ID.
     * @param { PointerStyle } pointerStyle - Pointer style.
     * @param { AsyncCallback<void> } callback - Callback used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.MultimodalInput.Input.Pointer
     * @since 20
     */
    function setPointerStyle(windowId: int, pointerStyle: PointerStyle, callback: AsyncCallback<void>): void;
    /**
     * Sets the mouse pointer style. This API uses a promise to return the result.
     *
     * @param { int } windowId - Window ID.
     * @param { PointerStyle } pointerStyle - Pointer style.
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.MultimodalInput.Input.Pointer
     * @since 20
     */
    function setPointerStyle(windowId: int, pointerStyle: PointerStyle): Promise<void>;
    /**
     * Sets the mouse pointer style. This API returns the result synchronously.
     *
     * @param { int } windowId - Window ID.
     * @param { PointerStyle } pointerStyle - Pointer style.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.MultimodalInput.Input.Pointer
     * @since 20
     */
    function setPointerStyleSync(windowId: int, pointerStyle: PointerStyle): void;
}
export default pointer;
