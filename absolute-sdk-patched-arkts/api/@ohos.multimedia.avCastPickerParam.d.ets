/*
* Copyright (C) 2023 Huawei Device Co., Ltd.
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
 * @kit AVSessionKit
 */

/**
 * Definition of av cast picker state
 * @enum { int }
 * @syscap SystemCapability.Multimedia.AVSession.AVCast
 * @since 20
 */
export declare enum AVCastPickerState {
    
    /**
     * The picker starts showing.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    STATE_APPEARING,
    
    /**
     * The picker finishes presenting.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    STATE_DISAPPEARING
}
/**
 * Definition of av cast picker style
 * @enum { int }
 * @syscap SystemCapability.Multimedia.AVSession.AVCast
 * @since 20
 */
export declare enum AVCastPickerStyle {
    /**
     * The picker shows in a panel style.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    STYLE_PANEL,
    /**
     * The picker shows in a menu style.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    STYLE_MENU
}
/**
 * Definition of color mode of picker
 * @enum { int }
 * @syscap SystemCapability.Multimedia.AVSession.AVCast
 * @since 20
 */
export declare enum AVCastPickerColorMode {
    /**
     * Auto mode which follows the definition of system.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    AUTO,
    /**
     * Dark mode.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    DARK,
    /**
     * Light mode.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    LIGHT
}
