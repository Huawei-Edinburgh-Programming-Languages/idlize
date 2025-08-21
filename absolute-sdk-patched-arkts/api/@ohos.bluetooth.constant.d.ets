/*
 * Copyright (C) 2023-2024 Huawei Device Co., Ltd.
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
 * @kit ConnectivityKit
 */


/**
 * The definition of constant.
 *
 * @namespace constant
 * @syscap SystemCapability.Communication.Bluetooth.Core
 * @since 20
 */
declare namespace constant {
    
    
    /**
     * The enum of profile connection state.
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    export enum ProfileConnectionState {
        
        
        /**
         * the current profile is disconnected
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        STATE_DISCONNECTED = 0,
        
        
        /**
         * the current profile is connected
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        STATE_CONNECTED = 2
    }
    
    /**
     * The enum of major class of a bluetooth device.
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    export enum MajorClass {
        /**
         * Mobile phone.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        MAJOR_PHONE = 0x0200,
        
        /**
         * Audio or video device.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        MAJOR_AUDIO_VIDEO = 0x0400,
        /**
         * Unclassified device.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        MAJOR_UNCATEGORIZED = 0x1F00
    }
    
    /**
     * The enum of major minor class of a bluetooth device.
     *
     * @enum { int }
     * @syscap SystemCapability.Communication.Bluetooth.Core
     * @since 20
     */
    export enum MajorMinorClass {
        
        /**
         * Wearable audio or video headset.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        AUDIO_VIDEO_WEARABLE_HEADSET = 0x0404,
        
        /**
         * Audio or video loudspeaker.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        AUDIO_VIDEO_LOUDSPEAKER = 0x0414,
        
        /**
         * Audio or video headphones.
         *
         * @syscap SystemCapability.Communication.Bluetooth.Core
         * @since 20
         */
        AUDIO_VIDEO_HEADPHONES = 0x0418
    }
}
export default constant;
