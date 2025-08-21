/*
 * Copyright (c) 2021 Huawei Device Co., Ltd.
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
 * @kit SensorServiceKit
 */
import { AsyncCallback, Callback } from './@ohos.base';

/**
 * This module provides the capability to control motor vibration.
 *
 * @namespace vibrator
 * @syscap SystemCapability.Sensors.MiscDevice
 * @since 20
 */
declare namespace vibrator {
    
    /**
     * Trigger vibrator vibration.
     *
     * @permission ohos.permission.VIBRATE
     * @param { VibrateEffect } effect - Indicate vibrate effect, {@code VibrateEffect}
     * @param { VibrateAttribute } attribute - Indicate vibrate attribute, {@code VibrateAttribute}
     * @param { AsyncCallback<void> } callback - The callback of startVibration
     * @throws { BusinessError } 201 - Permission denied
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported
     * @throws { BusinessError } 14600101 - Device operation failed
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    function startVibration(effect: VibrateEffect, attribute: VibrateAttribute, callback: AsyncCallback<void>): void;
    
    /**
     * Trigger vibrator vibration.
     *
     * @permission ohos.permission.VIBRATE
     * @param { VibrateEffect } effect - Indicate vibrate effect, {@code VibrateEffect}.
     * @param { VibrateAttribute } attribute - Indicate vibrate attribute, {@code VibrateAttribute}.
     * @returns { Promise<void> } Promise used to return the result.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameter types; 3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 14600101 - Device operation failed.
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    function startVibration(effect: VibrateEffect, attribute: VibrateAttribute): Promise<void>;
    /**
     * Stop the vibrator from vibrating.
     *
     * @permission ohos.permission.VIBRATE
     * @param { VibratorStopMode } stopMode - Indicate the stop mode in which the motor vibrates, {@code VibratorStopMode}.
     * @returns { Promise<void> } Promise used to return the result.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    function stopVibration(stopMode: VibratorStopMode): Promise<void>;
    /**
     * Stop the vibrator from vibrating.
     *
     * @permission ohos.permission.VIBRATE
     * @param { VibratorStopMode } stopMode - Indicate the stop mode in which the motor vibrates, {@code VibratorStopMode}.
     * @param { AsyncCallback<void> } callback - The callback of stopVibration.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    function stopVibration(stopMode: VibratorStopMode, callback: AsyncCallback<void>): void;
    
    /**
     * Stop any type of vibration.
     *
     * @permission ohos.permission.VIBRATE
     * @param { AsyncCallback<void> } callback - The callback of stopVibration.
     * @throws { BusinessError } 201 - Permission denied.
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    function stopVibration(callback: AsyncCallback<void>): void;
    
    /**
     * Stop any type of vibration.
     *
     * @permission ohos.permission.VIBRATE
     * @returns { Promise<void> } Promise used to return the result.
     * @throws { BusinessError } 201 - Permission denied.
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    function stopVibration(): Promise<void>;
    /**
     * Stop any type of vibration.
     *
     * @permission ohos.permission.VIBRATE
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 14600101 - Device operation failed.
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    function stopVibrationSync(): void;
    /**
     * Whether the preset vibration effect is supported.
     *
     * @param { string } effectId Indicate the specified effect of the preset, {@code EffectId}.
     * @param { AsyncCallback<boolean> } callback The callback of isSupportEffect.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    function isSupportEffect(effectId: string, callback: AsyncCallback<boolean>): void;
    /**
     * Whether the preset vibration effect is supported.
     *
     * @param { string } effectId Indicate the specified effect of the preset, {@code EffectId}.
     * @returns { Promise<boolean> } Promise used to return the result.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br> 2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    function isSupportEffect(effectId: string): Promise<boolean>;
    /**
     * Whether the high-definition haptic is supported.
     *
     * @returns { boolean } Returns whether the high-definition haptic is supported.
     * @throws { BusinessError } 14600101 - Device operation failed.
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    function isHdHapticSupported(): boolean;
    /**
     * Preset vibration effect string.
     *
     * @enum { string }
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    enum EffectId {
        /**
         * Describes the vibration effect of the vibrator when a user adjusts the timer.
         *
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        EFFECT_CLOCK_TIMER = 'haptic.clock.timer'
    }
    /**
     * Vibrator vibration stop mode.
     *
     * @enum { string }
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    enum VibratorStopMode {
        /**
         * Indicates the mode of stopping a one-shot vibration effect.
         *
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        VIBRATOR_STOP_MODE_TIME = 'time',
        /**
         * Indicates the mode of stopping a preset vibration effect.
         *
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        VIBRATOR_STOP_MODE_PRESET = 'preset'
    }
    
    /**
     * The use of vibration.
     *
     * @typedef {'unknown' | 'alarm' | 'ring' | 'notification' | 'communication' |
     * 'touch' | 'media' | 'physicalFeedback' | 'simulateReality'}
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    type Usage = 'unknown' | 'alarm' | 'ring' | 'notification' | 'communication' | 'touch' | 'media' | 'physicalFeedback' | 'simulateReality';
    
    /**
     * The attribute of vibration.
     *
     * @interface VibrateAttribute
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    interface VibrateAttribute {
        
        /**
         * Vibrator id, default is 0.
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        id?: int;
        
        /**
         * The use of vibration.
         *
         * @type { Usage }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        usage: Usage;
        /**
         * Indicates whether to bypass system management switches.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @systemapi
         * @since 20
         */
        systemUsage?: boolean;
    }
    
    
    
    /**
     * Describes the effect of vibration.
     *
     * @typedef { VibrateTime | VibratePreset | VibrateFromFile | VibrateFromPattern }
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    type VibrateEffect = VibrateTime | VibratePreset | VibrateFromFile | VibrateFromPattern;
    
    /**
     * Vibrate continuously for a period of time at the default intensity of the system.
     *
     * @interface VibrateTime
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    interface VibrateTime {
        
        /**
         * The value is "time", which triggers the motor vibration according to the specified duration.
         *
         * @type { 'time' }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        type: 'time';
        
        /**
         * The duration of the vibration, in ms.
         *
         * @type { int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        duration: int; /** The duration of the vibration, in ms */
    }
    /**
     * Preset vibration type vibration effect.
     *
     * @interface VibratePreset
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    interface VibratePreset {
        /**
         * The value is "preset", which triggers motor vibration according to preset vibration effect.
         *
         * @type { 'preset' }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        type: 'preset';
        /**
         * Preset type vibration.
         *
         * @type { string }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        effectId: string;
        
        /**
         * The number of vibration repetitions.
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        count?: int;
        /**
         * The intensity of vibration effect.
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        intensity?: int;
    }
    /**
     * Custom vibration, vibrate the effect from a haptic file.
     *
     * @interface VibrateFromFile
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    interface VibrateFromFile {
        /**
         * The value is "file", which triggers motor vibration according to the vibration profile.
         *
         * @type { 'file' }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        type: 'file';
        /**
         * Haptic file descriptor, some formats are supported.
         *
         * @type { HapticFileDescriptor }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        hapticFd: HapticFileDescriptor;
    }
    /**
     * Haptic file descriptor. The caller needs to ensure that the fd is valid and
     * the offset and length are correct.
     *
     * @interface HapticFileDescriptor
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    interface HapticFileDescriptor {
        /**
         * The file descriptor of haptic effect source from file system. The caller
         * is responsible to close the file descriptor.
         *
         * @type { number }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        fd: number;
        /**
         * The offset into the file where the data to be read, in bytes. By default,
         * the offset is zero.
         *
         * @type { ?number }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        offset?: number;
        /**
         * The length in bytes of the data to be read. By default, the length is the
         * rest of bytes in the file from the offset.
         *
         * @type { ?number }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        length?: number;
    }
    /**
     * Types of vibration events
     *
     * @enum { int }
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    enum VibratorEventType {
        /**
         * Steady state long vibration
         *
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        CONTINUOUS = 0,
        /**
         * Transient short vibration
         *
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        TRANSIENT = 1
    }
    /**
     * The vibration curve is valid when the vibration event type is 'continuous'
     *
     * @interface VibratorCurvePoint
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    interface VibratorCurvePoint {
        /**
          * The offset of the starting time of the relative event.
          *
          * @type { int }
          * @syscap SystemCapability.Sensors.MiscDevice
          * @since 20
          */
        time: int;
        /**
          * Gain in relative event vibration intensity
          *
          * @type { ?int }
          * @syscap SystemCapability.Sensors.MiscDevice
          * @since 20
          */
        intensity?: int;
        /**
         * Changes in relative event vibration frequency
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        frequency?: int;
    }
    /**
     * Vibration event.
     *
     * @interface VibratorEvent
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    interface VibratorEvent {
        /**
         * Types of vibration events
         *
         * @type { VibratorEventType }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        eventType: VibratorEventType;
        /**
         * Relative starting time of vibration
         *
         * @type { int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        time: int;
        /**
         * The duration of vibration
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        duration?: int;
        /**
         * Intensity of vibration events
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        intensity?: int;
        /**
         * Vibration event frequency
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        frequency?: int;
        /**
         * Channel number
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        index?: int;
        /**
         * An array representing vibration adjustment curves.
         *
         * @type { ?Array<VibratorCurvePoint> }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        points?: Array<VibratorCurvePoint>;
    }
    /**
     * Each 'events' attribute in the vibration sequence represents one vibration event
     *
     * @interface VibratorPattern
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    interface VibratorPattern {
        /**
         * Absolute starting time of vibration
         *
         * @type { int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        time: int;
        /**
         * Vibration event array, where each 'events' attribute represents one vibration event.
         *
         * @type { Array<VibratorEvent> }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        events: Array<VibratorEvent>;
    }
    /**
     * The continuous vibration parameters
     *
     * @interface ContinuousParam
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    interface ContinuousParam {
        /**
         * Intensity of vibration
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        intensity?: int;
        /**
         * Frequency of vibration
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        frequency?: int;
        /**
         * The points of vibration
         *
         * @type { ?VibratorCurvePoint[] }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        points?: VibratorCurvePoint[];
        /**
         * Index of vibration
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        index?: int;
    }
    /**
     * The transient vibration parameters
     *
     * @interface TransientParam
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    interface TransientParam {
        /**
         * Intensity of vibration
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        intensity?: int;
        /**
         * Frequency of vibration
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        frequency?: int;
        /**
         * Index of vibration
         *
         * @type { ?int }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        index?: int;
    }
    /**
     * Trigger motor vibration with custom vibration effects.
     *
     * @interface VibrateFromPattern
     * @syscap SystemCapability.Sensors.MiscDevice
     * @since 20
     */
    interface VibrateFromPattern {
        /**
         * The value is "pattern", which triggers motor vibration based on the combination pattern.
         *
         * @type { 'pattern' }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        type: 'pattern';
        /**
         * Customize the sequence of motor vibration events, the VibratorPattern object returned by the build() method.
         *
         * @type { VibratorPattern }
         * @syscap SystemCapability.Sensors.MiscDevice
         * @since 20
         */
        pattern: VibratorPattern;
    }
}
export default vibrator;
