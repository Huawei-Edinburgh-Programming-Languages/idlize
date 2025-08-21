/*
 * Copyright (c) 2021 Huawei Device Co., Ltd.
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
 * @kit ArkUI
 */
import type { AsyncCallback, Callback } from './@ohos.base';
import type colorSpaceManager from './@ohos.graphics.colorSpaceManager';
import type hdrCapability from './@ohos.graphics.hdrCapability';


/**
 * Interface of display manager.
 *
 * @namespace display
 * @syscap SystemCapability.WindowManager.WindowManager.Core
 * @since 20
 */
declare namespace display {
    
    
    /**
     * Obtain the default display.
     *
     * @returns { Display } the result of display
     * @throws { BusinessError } 1400001 - Invalid display or screen.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    function getDefaultDisplaySync(): Display;
    /**
     * Obtain the target display.
     *
     * @param { long } displayId Display id to query. This parameter should be greater than or equal to 0.
     * @returns { Display } the result of display
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *                                                                   2. Incorrect parameter types.
     *                                                                   3. Parameter verification failed.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    function getDisplayByIdSync(displayId: long): Display;
    
    /**
     * Obtain all displays.
     *
     * @param { AsyncCallback<Array<Display>> } callback the result of all displays
     * @throws { BusinessError } 1400001 - Invalid display or screen.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    function getAllDisplays(callback: AsyncCallback<Array<Display>>): void;
    
    /**
     * Obtain all displays.
     *
     * @returns { Promise<Array<Display>> } the result of all displays
     * @throws { BusinessError } 1400001 - Invalid display or screen.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    function getAllDisplays(): Promise<Array<Display>>;
    /**
     * Obtain all display physical resolution
     *
     * @returns { Promise<Array<DisplayPhysicalResolution>> } the result of all display physical resolution
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    function getAllDisplayPhysicalResolution(): Promise<Array<DisplayPhysicalResolution>>;
    /**
     * Check whether there is a privacy window on the current display.
     *
     * @param { long } displayId Display id to query. This parameter should be greater than or equal to 0.
     * @returns { boolean } true means there is a privacy window on the current display
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3. Parameter verification failed.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function hasPrivateWindow(displayId: long): boolean;
    
    
    /**
     * Register the callback for display changes.
     *
     * @param { 'add' | 'remove' | 'change' } type the event of display change
     * @param { Callback<long> } callback the display id of changed
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    function on(type: 'add' | 'remove' | 'change', callback: Callback<long>): void;
    
    
    /**
     * Unregister the callback for display changes.
     *
     * @param { 'add' | 'remove' | 'change' } type the event of display change event
     * @param { Callback<long> } callback the display id of changed
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    function off(type: 'add' | 'remove' | 'change', callback?: Callback<long>): void;
    /**
     * Register the callback for private mode changes.
     *
     * @param { 'privateModeChange' } type the event of private mode changes
     * @param { Callback<boolean> } callback Callback used to return the result whether display is on private mode or not
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(type: 'privateModeChange', callback: Callback<boolean>): void;
    /**
     * Unregister the callback for private mode changes.
     *
     * @param { 'privateModeChange' } type the event of private mode changes
     * @param { Callback<boolean> } callback Callback used to return the result whether display is on private mode or not
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(type: 'privateModeChange', callback?: Callback<boolean>): void;
    
    
    /**
     * Check whether the device is foldable.
     *
     * @returns { boolean } true means the device is foldable.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function isFoldable(): boolean;
    
    
    /**
     * Get the current fold status of the foldable device.
     *
     * @returns { FoldStatus } fold status of device.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function getFoldStatus(): FoldStatus;
    
    
    /**
     * Register the callback for fold status changes.
     *
     * @param { 'foldStatusChange' } type the event of fold status changes
     * @param { Callback<FoldStatus> } callback Callback used to return the current fold status of device
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function on(type: 'foldStatusChange', callback: Callback<FoldStatus>): void;
    
    
    /**
     * Unregister the callback for fold status changes.
     *
     * @param { 'foldStatusChange' } type the event of fold status changes
     * @param { Callback<FoldStatus> } callback Callback used to return the current fold status of device
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function off(type: 'foldStatusChange', callback?: Callback<FoldStatus>): void;
    
    /**
     * Register the callback for fold angle changes.
     *
     * @param { 'foldAngleChange' } type the event of fold angle changes.
     * @param { Callback<Array<double>> } callback Callback used to return the current fold angle of device.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function on(type: 'foldAngleChange', callback: Callback<Array<double>>): void;
    
    /**
     * Unregister the callback for fold angle changes.
     *
     * @param { 'foldAngleChange' } type the event of fold angle changes.
     * @param { Callback<Array<double>> } callback Callback used to return the current fold angle of device.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function off(type: 'foldAngleChange', callback?: Callback<Array<double>>): void;
    /**
     * Register the callback for device capture, casting, or recording status changes.
     *
     * @param { 'captureStatusChange' } type the event of capture, casting, or recording status changes.
     * @param { Callback<boolean> } callback Callback used to return the device capture, casting, or recording status.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function on(type: 'captureStatusChange', callback: Callback<boolean>): void;
    /**
     * Unregister the callback for device capture, casting, or recording status changes.
     *
     * @param { 'captureStatusChange' } type the event of capture, casting, or recording status changes.
     * @param { Callback<boolean> } callback Callback used to return the device capture, casting, or recording status .
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function off(type: 'captureStatusChange', callback?: Callback<boolean>): void;
    /**
     * Check whether the device is captured, projected, or recorded.
     *
     * @returns { boolean } true means the device is captured, projected, or recorded.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function isCaptured(): boolean;
    
    
    /**
     * Get the display mode of the foldable device.
     *
     * @returns { FoldDisplayMode } display mode of the foldable device.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function getFoldDisplayMode(): FoldDisplayMode;
    /**
     * Change the display mode of the foldable device.
     *
     * @param { FoldDisplayMode } mode target display mode to change.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function setFoldDisplayMode(mode: FoldDisplayMode): void;
    /**
     * Change the display mode of the foldable device.
     *
     * @param { FoldDisplayMode } mode target display mode to change.
     * @param { string } reason set display mode reason.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function setFoldDisplayMode(mode: FoldDisplayMode, reason: string): void;
    
    
    /**
     * Register the callback for fold display mode changes.
     *
     * @param { 'foldDisplayModeChange' } type the event of fold display mode changes
     * @param { Callback<FoldDisplayMode> } callback Callback used to return the current fold display mode
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function on(type: 'foldDisplayModeChange', callback: Callback<FoldDisplayMode>): void;
    
    
    /**
     * Unregister the callback for fold display mode changes.
     *
     * @param { 'foldDisplayModeChange' } type the event of fold display mode changes
     * @param { Callback<FoldDisplayMode> } callback Callback used to return the current fold display mode
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function off(type: 'foldDisplayModeChange', callback?: Callback<FoldDisplayMode>): void;
    
    /**
     * Get the fold crease region in the current display mode.
     *
     * @returns { FoldCreaseRegion } fold crease region in the current display mode.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    function getCurrentFoldCreaseRegion(): FoldCreaseRegion;
    /**
     * set fold status locked or not.
     *
     * @param { boolean } locked - fold status is locked or not.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 1400003 - This display manager service works abnormally.
     * @syscap SystemCapability.Window.SessionManager
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function setFoldStatusLocked(locked: boolean): void;
    
    
    /**
     * Enumerates the fold status.
     *
     * @enum { number }
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    enum FoldStatus {
        
        
        /**
         * Fold Status Unknown.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_STATUS_UNKNOWN = 0,
        
        
        /**
         * Fold Status Expanded.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_STATUS_EXPANDED = 1,
        
        /**
         * Fold Status Folded. For dual-fold axis devices, the first fold axis is folded, and the second fold axis is folded.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_STATUS_FOLDED = 2,
        
        
        /**
         * Fold Status Half Folded.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_STATUS_HALF_FOLDED = 3,
        /**
         * Fold Status Expanded With Second Expanded.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_STATUS_EXPANDED_WITH_SECOND_EXPANDED = 11,
        /**
         * Fold Status Expanded With Second Half Folded.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_STATUS_EXPANDED_WITH_SECOND_HALF_FOLDED = 21,
        /**
         * Fold Status Folded With Second Expanded.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_STATUS_FOLDED_WITH_SECOND_EXPANDED = 12,
        /**
         * Fold Status Folded With Second Half Folded.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_STATUS_FOLDED_WITH_SECOND_HALF_FOLDED = 22,
        /**
         * Fold Status Half Folded With Second Expanded.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_STATUS_HALF_FOLDED_WITH_SECOND_EXPANDED = 13,
        /**
         * Fold Status Half Folded With Second Half Folded.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_STATUS_HALF_FOLDED_WITH_SECOND_HALF_FOLDED = 23
    }
    
    
    /**
     * Enumerates the fold display mode.
     *
     * @enum { number }
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    enum FoldDisplayMode {
        
        /**
         * Unknown Display.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_DISPLAY_MODE_UNKNOWN = 0,
        
        /**
         * Full Display.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_DISPLAY_MODE_FULL = 1,
        
        /**
         * Main Display.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_DISPLAY_MODE_MAIN = 2,
        
        /**
         * Sub Display.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_DISPLAY_MODE_SUB = 3,
        
        /**
         * Coordination Display.
         *
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        FOLD_DISPLAY_MODE_COORDINATION
    }
    
    /**
     * Enumerates the display states.
     *
     * @enum { number }
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    enum DisplayState {
        
        /**
         * Unknown.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        STATE_UNKNOWN = 0,
        
        /**
         * Screen off.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        STATE_OFF = 1,
        
        /**
         * Screen on.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        STATE_ON = 2,
        
        /**
         * Doze, but it will update for some important system messages.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        STATE_DOZE = 3,
        
        /**
         * Doze and not update.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        STATE_DOZE_SUSPEND = 4,
        
        /**
         * VR node.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        STATE_VR = 5,
        
        /**
         * Screen on and not update.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        STATE_ON_SUSPEND = 6
    }
    
    /**
     * Enumerates the display orientation.
     *
     * @enum { number }
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    enum Orientation {
        
        /**
         * Indicate that the display content is in portrait mode.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        PORTRAIT = 0,
        
        /**
         * Indicate that the display content is in landscape mode.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        LANDSCAPE = 1,
        
        /**
         * Indicate that the display content is in the opposite direction of the portrait mode.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        PORTRAIT_INVERTED = 2,
        
        /**
         * Indicate that the display content is in the opposite direction of the landscape mode.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        LANDSCAPE_INVERTED = 3
    }
    
    /**
     * Fold Crease Region
     *
     * @interface FoldCreaseRegion
     * @syscap SystemCapability.Window.SessionManager
     * @since 20
     */
    interface FoldCreaseRegion {
        
        /**
         * The display ID is used to identify the screen where the crease is located.
         *
         * @type { long }
         * @readonly
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        readonly displayId: long;
        
        /**
         * Crease Region.
         *
         * @type { Array<Rect> }
         * @readonly
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        readonly creaseRects: Array<Rect>;
    }
    
    /**
     * Rectangle
     *
     * @interface Rect
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    interface Rect {
        
        /**
         * The X-axis coordinate of the upper left vertex of the rectangle, in pixels.
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        left: long;
        
        /**
         * The Y-axis coordinate of the upper left vertex of the rectangle, in pixels.
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        top: long;
        
        /**
         * Width of the rectangle, in pixels.
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        width: long;
        
        /**
         * Height of the rectangle, in pixels.
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        height: long;
    }
    
    /**
     * Curved area rects of the waterfall display.
     *
     * @interface WaterfallDisplayAreaRects
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    interface WaterfallDisplayAreaRects {
        
        /**
         * Indicates the size of left side curved area of the waterfall screen.
         *
         * @type { Rect }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        readonly left: Rect;
        
        /**
         * Indicates the size of right side curved area of the waterfall screen.
         *
         * @type { Rect }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        readonly right: Rect;
        
        /**
         * Indicates the size of top side curved area of the waterfall screen.
         *
         * @type { Rect }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        readonly top: Rect;
        
        /**
         * Indicates the size of bottom side curved area of the waterfall screen.
         *
         * @type { Rect }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        readonly bottom: Rect;
    }
    
    /**
     * Cutout information of the display.
     *
     * @interface CutoutInfo
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    interface CutoutInfo {
        
        /**
         * Bounding rectangles of the cutout areas of the display.
         *
         * @type { Array<Rect> }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        readonly boundingRects: Array<Rect>;
        
        /**
         * Rectangles of curved parts on each side of a waterfall display.
         *
         * @type { WaterfallDisplayAreaRects }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        readonly waterfallDisplayAreaRects: WaterfallDisplayAreaRects;
    }
    /**
     * Define display physical resolution.
     *
     * @interface DisplayPhysicalResolution
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    interface DisplayPhysicalResolution {
        /**
         * fold display mode.
         *
         * @type { FoldDisplayMode }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        foldDisplayMode: FoldDisplayMode;
        /**
         * Display physical width, in pixels.
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        physicalWidth: long;
        /**
         * Display physical height, in pixels.
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        physicalHeight: long;
    }
    
    
    /**
     * Define properties of the display. They cannot be updated automatically.
     *
     * @interface Display
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @since 20
     */
    interface Display {
        
        
        /**
         * Display ID.
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        id: long;
        
        /**
         * Display name.
         *
         * @type { string }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        name: string;
        
        /**
         * Whether the display is alive.
         *
         * @type { boolean }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        alive: boolean;
        
        /**
         * The state of display.
         *
         * @type { DisplayState }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        state: DisplayState;
        
        /**
         * Refresh rate, in Hz.
         *
         * @type { int }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        refreshRate: int;
        
        /**
         * An enumeration value for rotation degrees of the display.
         * The value 0 indicates that the screen of the display rotates clockwise by 0°.
         * The value 1 indicates that the screen of the display rotates clockwise by 90°.
         * The value 2 indicates that the screen of the display rotates clockwise by 180°.
         * The value 3 indicates that the screen of the display rotates clockwise by 270°.
         *
         * @type { int }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        rotation: int;
        
        
        /**
         * Display width, in pixels.
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        width: long;
        
        
        /**
         * Display height, in pixels.
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        height: long;
        /**
         * Display available width, in pixels.
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        availableWidth: long;
        /**
         * Display available height, in pixels.
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        availableHeight: long;
        
        
        /**
         * Display resolution, that is, the number of pixels per inch.
         *
         * @type { double }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        densityDPI: double;
        
        /**
         * Display orientation.
         *
         * @type { Orientation }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        orientation: Orientation;
        
        /**
         * Display density, in pixels. which is the scaling coefficient between physical pixels and logical pixels. The value for a low-resolution display is 1.0.
         *
         * @type { double }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        densityPixels: double;
        
        
        /**
         * Text scale density of the display.
         *
         * @type { double }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        scaledDensity: double;
        
        
        /**
         * DPI on the x-axis.
         *
         * @type { double }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        xDPI: double;
        
        /**
         * Obtain the cutout info of the display.
         *
         * @param { AsyncCallback<CutoutInfo> } callback
         * @throws { BusinessError } 1400001 - Invalid display or screen.
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        getCutoutInfo(callback: AsyncCallback<CutoutInfo>): void;
        
        /**
         * Obtain the cutout info of the display.
         *
         * @returns { Promise<CutoutInfo> }
         * @throws { BusinessError } 1400001 - Invalid display or screen.
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @since 20
         */
        getCutoutInfo(): Promise<CutoutInfo>;
        /**
         * Check if current display has immersive window.
         *
         * @param { AsyncCallback<boolean> } callback
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 801 - Capability not supported. Failed to call the API due to limited device capabilities.
         * @throws { BusinessError } 1400001 - Invalid display or screen.
         * @throws { BusinessError } 1400003 - This display manager service works abnormally.
         * @syscap SystemCapability.Window.SessionManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        hasImmersiveWindow(callback: AsyncCallback<boolean>): void;
        /**
         * Check if current display has immersive window.
         *
         * @returns { Promise<boolean> }
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 801 - Capability not supported. Failed to call the API due to limited device capabilities.
         * @throws { BusinessError } 1400001 - Invalid display or screen.
         * @throws { BusinessError } 1400003 - This display manager service works abnormally.
         * @syscap SystemCapability.Window.SessionManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        hasImmersiveWindow(): Promise<boolean>;
        /**
         * Obtain the available area of the display.
         *
         * @returns { Promise<Rect> }
         * @throws { BusinessError } 801 - Capability not supported. Failed to call the API due to limited device capabilities.
         * @throws { BusinessError } 1400001 - Invalid display or screen.
         * @syscap SystemCapability.Window.SessionManager
         * @since 20
         */
        getAvailableArea(): Promise<Rect>;
        /**
        * Register the callback for available area changes.
        *
        * @param { 'availableAreaChange' } type - the event of available area changes
        * @param { Callback<Rect> } callback - Callback used to return the available area
        * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
        * <br>2. Incorrect parameter types.
        * @throws { BusinessError } 801 - Capability not supported. Failed to call the API due to limited device capabilities.
        * @throws { BusinessError } 1400003 - This display manager service works abnormally.
        * @syscap SystemCapability.Window.SessionManager
        * @since 20
        */
        on(type: 'availableAreaChange', callback: Callback<Rect>): void;
        /**
        * Unregister the callback for available area changes.
        *
        * @param { 'availableAreaChange' } type - the event of available area changes
        * @param { Callback<Rect> } [callback] - Callback used to return the available area
        * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
        * <br>2. Incorrect parameter types.
        * @throws { BusinessError } 801 - Capability not supported. Failed to call the API due to limited device capabilities.
        * @throws { BusinessError } 1400003 - This display manager service works abnormally.
        * @syscap SystemCapability.Window.SessionManager
        * @since 20
        */
        off(type: 'availableAreaChange', callback?: Callback<Rect>): void;
    }
}
export default display;
