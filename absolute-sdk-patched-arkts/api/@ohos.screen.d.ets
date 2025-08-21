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
 * @kit ArkUI
 */
import { AsyncCallback, Callback } from './@ohos.base';
import image from './@ohos.multimedia.image';
/**
 * Interface of screen manager
 *
 * @namespace screen
 * @syscap SystemCapability.WindowManager.WindowManager.Core
 * @systemapi Hide this for inner system use.
 * @since 20
 */
declare namespace screen {
    /**
     * Get all screen instances, then can get or set detail information.
     *
     * @param { AsyncCallback<Array<Screen>> } callback the callback of all screens info
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 1400001 - Invalid display or screen.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getAllScreens(callback: AsyncCallback<Array<Screen>>): void;
    /**
     * Get all screen instances, then can get or set detail information.
     *
     * @returns { Promise<Array<Screen>> } the result of all screens info
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 1400001 - Invalid display or screen.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getAllScreens(): Promise<Array<Screen>>;
    /**
     * Register the callback for screen changes.
     *
     * @param { 'connect' | 'disconnect' | 'change' } eventType the event of screen changes. This parameter is of string
     * type and cannot be empty.
     * @param { Callback<long> } callback Callback used to return the screen ID. This parameter is callable.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function on(eventType: 'connect' | 'disconnect' | 'change', callback: Callback<long>): void;
    /**
     * Unregister the callback for screen changes.
     *
     * @param { 'connect' | 'disconnect' | 'change' } eventType the event of screen changes. This parameter is of string
     * type and cannot be empty.
     * @param { Callback<long> } callback Callback used to return the screen ID. If this parameter is specified, it must
     * be a callback.
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function off(eventType: 'connect' | 'disconnect' | 'change', callback?: Callback<long>): void;
    /**
     * Make screens as mirror-screen
     *
     * @param { long } mainScreen ID of the primary screen. It's type should be int.
     * @param { Array<long> } mirrorScreen IDs of secondary screens
     * @param { AsyncCallback<long> } callback Callback used to return the group ID of the secondary screens
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 1400001 - Invalid display or screen.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function makeMirror(mainScreen: long, mirrorScreen: Array<long>, callback: AsyncCallback<long>): void;
    /**
     * Make screens as mirror-screen
     *
     * @param { long } mainScreen ID of the primary screen. It's type should be int.
     * @param { Array<long> } mirrorScreen IDs of secondary screens
     * @returns { Promise<long> } Promise used to return the group ID of the secondary screens
     * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 1400001 - Invalid display or screen.
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function makeMirror(mainScreen: long, mirrorScreen: Array<long>): Promise<long>;
    /**
     * Indicate the source mode of the screen
     *
     * @enum { number }
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    enum ScreenSourceMode {
        /**
         * Indicate that the screen is the default screen.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SCREEN_MAIN = 0,
        /**
         * Indicate that the screen is in mirror mode.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SCREEN_MIRROR = 1,
        /**
         * Indicate that the screen is in extend mode.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SCREEN_EXTEND = 2,
        /**
         * Indicate that the screen stands alone.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        SCREEN_ALONE = 3
    }
    /**
     * Interface for screen
     *
     * @interface Screen
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface Screen {
        /**
         * Screen id
         *
         * @type { long }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        readonly id: long;
        /**
         * Group id
         *
         * @type { long }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        readonly parent: long;
        /**
         * Mode supported by the screen
         *
         * @type { Array<ScreenModeInfo> }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        readonly supportedModeInfo: Array<ScreenModeInfo>;
        /**
         * Currently active mode
         *
         * @type { long }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        readonly activeModeIndex: long;
        /**
         * Orientation of the screen
         *
         * @type { Orientation }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        readonly orientation: Orientation;
        /**
         * Source mode of the screen
         *
         * @type { ScreenSourceMode }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        readonly sourceMode: ScreenSourceMode;
        /**
         * Screen Serial Number
         *
         * @type { ?string }
         * @readonly
         * @syscap SystemCapability.WindowManager.WindowManager
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        readonly serialNumber?: string;
        /**
         * Set display density of the screen
         *
         * @param { double } densityDpi Pixel density. The value ranges from 80 to 640.
         * @param { AsyncCallback<void> } callback Callback used to return the result.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 1400003 - This display manager service works abnormally.
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        setDensityDpi(densityDpi: double, callback: AsyncCallback<void>): void;
        /**
         * Set display density of the screen
         *
         * @param { double } densityDpi Pixel density. The value ranges from 80 to 640.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 1400003 - This display manager service works abnormally.
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        setDensityDpi(densityDpi: double): Promise<void>;
    }
    /**
     * Screen orientation
     *
     * @enum { number }
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    enum Orientation {
        /**
         * Indicates that the orientation of the screen is unspecified.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        UNSPECIFIED = 0,
        /**
         * Indicates that the orientation of the screen is vertical.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        VERTICAL = 1,
        /**
         * Indicates that the orientation of the screen is horizontal.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        HORIZONTAL = 2,
        /**
         * Indicates that the orientation of the screen is reverse_vertical.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        REVERSE_VERTICAL = 3,
        /**
         * Indicates that the orientation of the screen is reverse_horizontal.
         *
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        REVERSE_HORIZONTAL = 4
    }
    /**
     * The information of the screen mode
     *
     * @interface ScreenModeInfo
     * @syscap SystemCapability.WindowManager.WindowManager.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface ScreenModeInfo {
        /**
         * Mode id
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        id: long;
        /**
         * Indicates the width of the screen
         *
         * @type { long }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        width: long;
        /**
          * Indicates the height of the screen
          *
          * @type { long }
          * @syscap SystemCapability.WindowManager.WindowManager.Core
          * @systemapi Hide this for inner system use.
          * @since 20
          */
        height: long;
        /**
         * Indicates the refreshRate of the screen
         *
         * @type { int }
         * @syscap SystemCapability.WindowManager.WindowManager.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        refreshRate: int;
    }
}
export default screen;
