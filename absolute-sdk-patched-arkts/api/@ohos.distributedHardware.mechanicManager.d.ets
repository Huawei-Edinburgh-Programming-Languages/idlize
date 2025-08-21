/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License"),
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
 * @kit MechanicKit
 */
import type { Callback } from './@ohos.base';
/**
 * Provides capabilities for controlling and interacting with mechanical devices connected to this device.
 * The capabilities cover connection management, control, and monitoring.
 *
 * @namespace mechanicManager
 * @syscap SystemCapability.Mechanic.Core
 * @since 20
 */
declare namespace mechanicManager {
    /**
     * Subscribes to device attachment state change events.
     * @param { 'attachStateChange' } type Event type.
     * @param { Callback<AttachStateChangeInfo> } callback Callback used to return the state change.
     * @throws { BusinessError } 33300001 - Service exception.
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    function on(type: 'attachStateChange', callback: Callback<AttachStateChangeInfo>): void;
    /**
     * Unsubscribes from device attachment state change events.
     * @param { 'attachStateChange' } type Event type.
     * @param { Callback<AttachStateChangeInfo> } [callback] Callback used to return the state change.
     * @throws { BusinessError } 33300001 - Service exception.
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    function off(type: 'attachStateChange', callback?: Callback<AttachStateChangeInfo>): void;
    /**
     * Obtain the list of connected mechanical devices.
     * @returns { MechInfo[] } List of connected mechanical devices.
     * @throws { BusinessError } 33300001 - Service exception.
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    function getAttachedMechDevices(): MechInfo[];
    /**
     * Sets a user operation.
     * @permission ohos.permission.CONNECT_MECHANIC_HARDWARE
     * @param { Operation } operation Operation type.
     * @param { string } mac MAC address.
     * @param { string } params Operation parameters.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function setUserOperation(operation: Operation, mac: string, params: string): void;
    /**
     * Enables or disables camera tracking.
     * @param { boolean } isEnabled Whether to enable camera tracking.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @throws { BusinessError } 33300003 - Feature not supported.
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    function setCameraTrackingEnabled(isEnabled: boolean): void;
    /**
     * Checks whether camera tracking is enabled for this mechanical device.
     * @returns { boolean } Enabled status. The value true means that camera tracking is enabled, and false means
     * the opposite.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    function getCameraTrackingEnabled(): boolean;
    /**
     * Subscribes to tracking events.
     * @param { 'trackingStateChange' } type Event type.
     * @param { Callback<TrackingEventInfo> } callback Callback used to return the tracking event information.
     * @throws { BusinessError } 33300001 - Service exception.
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    function on(type: 'trackingStateChange', callback: Callback<TrackingEventInfo>): void;
    /**
     * Unsubscribes from tracking events.
     * @param { 'trackingStateChange' } type Event type.
     * @param { Callback<TrackingEventInfo> } [callback] Callback used to return the tracking event information.
     * @throws { BusinessError } 33300001 - Service exception.
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    function off(type: 'trackingStateChange', callback?: Callback<TrackingEventInfo>): void;
    /**
     * Sets the camera tracking layout for this mechanical device.
     * @param { CameraTrackingLayout } trackingLayout Camera tracking layout.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @throws { BusinessError } 33300003 - Feature not supported.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function setCameraTrackingLayout(trackingLayout: CameraTrackingLayout): void;
    /**
     * Obtains the camera tracking layout of this mechanical device.
     * @returns { CameraTrackingLayout } Camera tracking layout obtained.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    function getCameraTrackingLayout(): CameraTrackingLayout;
    /**
     * Rotates a mechanical device to the relative angles.
     * @param { number } mechId ID of the mechanical device.
     * @param { RotationAngles } angles Relative angles.
     * @param { number } duration Rotation duration. Unit: millisecond.
     * @returns { Promise<Result> } Promise that return the execution result.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function rotate(mechId: number, angles: RotationAngles, duration: number): Promise<Result>;
    /**
     * Rotates a mechanical device to the absolute angles.
     * @param { number } mechId ID of the mechanical device.
     * @param { EulerAngles } angles Absolute angles.
     * @param { number } duration Rotation duration. Unit: millisecond.
     * @returns { Promise<Result> } Promise that return the execution result.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function rotateToEulerAngles(mechId: number, angles: EulerAngles, duration: number): Promise<Result>;
    /**
     * Obtains the maximum continuous rotation duration of a mechanical device.
     *
     * @param { number } mechId ID of the mechanical device.
     * @returns { number } Maximum rotation duration. Unit: millisecond.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function getMaxRotationTime(mechId: number): number;
    /**
     * Obtains the maximum rotation speed of a mechanical device.
     *
     * @param { number } mechId ID of the mechanical device.
     * @returns { RotationSpeed } Maximum speed. Only the absolute value of the speed is returned.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function getMaxRotationSpeed(mechId: number): RotationSpeed;
    /**
     * Rotates a mechanical device at the specified speed.
     * @param { number } mechId ID of the mechanical device.
     * @param { RotationSpeed } speed Rotation speed.
     * @param { number } duration Rotation duration. Unit: millisecond.
     * @returns { Promise<Result> } Promise that return the execution result.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function rotateBySpeed(mechId: number, speed: RotationSpeed, duration: number): Promise<Result>;
    /**
     * Stops a mechanical device from moving.
     * @param { number } mechId ID of the mechanical device.
     * @returns { Promise<void> } Promise that returns no value.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function stopMoving(mechId: number): Promise<void>;
    /**
     * Obtains the current angles of a mechanical device.
     * @param { number } mechId ID of the mechanical device.
     * @returns { EulerAngles } Rotation angles.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function getCurrentAngles(mechId: number): EulerAngles;
    /**
     * Obtains the maximum rotation angles relative to the reference point for the specified mechanical device.
     *
     * @param { number } mechId ID of the mechanical device.
     * @returns { RotationLimits } Maximum rotation angles.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function getRotationLimits(mechId: number): RotationLimits;
    /**
     * Obtains the status of the rotation axes.
     * @param { number } mechId ID of the mechanical device.
     * @returns { RotationAxesStatus } Rotation axis status.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @throws { BusinessError } 33300002 - Device not connected.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function getRotationAxesStatus(mechId: number): RotationAxesStatus;
    /**
     * Register a listener for axis state changes.
     * The status of the rotation axis changes dynamically, which needs to be monitored.
     *
     * @param { 'rotationAxesStatusChange' } type - Event type.
     * @param { Callback<RotationAxesStateChangeInfo> } callback - Rotate axis state changes callback.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function on(type: 'rotationAxesStatusChange', callback: Callback<RotationAxesStateChangeInfo>): void;
    /**
     * Unregister a listener for axis state changes.
     *
     * @param { 'rotationAxesStatusChange' } type - Event type.
     * @param { Callback<RotationAxesStateChangeInfo> } [callback] - Rotate axis state changes callback.
     * @throws { BusinessError } 202 - Not system application.
     * @throws { BusinessError } 33300001 - Service exception.
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    function off(type: 'rotationAxesStatusChange', callback?: Callback<RotationAxesStateChangeInfo>): void;
    /**
     * Mechanical device information.
     * @typedef MechInfo
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    export interface MechInfo {
        /**
         * ID of the mechanical device.
         * @type { number }
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        mechId: number;
        /**
         * Type of the mechanical device.
         * @type { MechDeviceType }
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        mechDeviceType: MechDeviceType;
        /**
         * Name of the mechanical device.
         * @type { string }
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        mechName: string;
    }
    /**
     * The rotion angles, relative to the current position.
     * @typedef RotationAngles
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    export interface RotationAngles {
        /**
         * Yaw angle, ranging from -2*Math.PI to 2*Math.PI, measured in radians.
         * @type { ?number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        yaw?: number;
        /**
         * Roll angle, ranging from -2*Math.PI to 2*Math.PI, measured in radians.
         * @type { ?number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        roll?: number;
        /**
         * Pitch angle, ranging from -2*Math.PI to 2*Math.PI, measured in radians.
         * @type { ?number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        pitch?: number;
    }
    /**
     * Absolute euler angles relative to the home position.
     *
     * @typedef EulerAngles
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    export interface EulerAngles {
        /**
         * Yaw angle, ranging from -Math.PI to Math.PI, measured in radians.
         * @type { ?number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        yaw?: number;
        /**
         * Roll angle, ranging from -Math.PI to Math.PI, measured in radians.
         * @type { ?number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        roll?: number;
        /**
         * Pitch angle, ranging from -Math.PI to Math.PI, measured in radians.
         * @type { ?number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        pitch?: number;
    }
    /**
     * Rotational speed. A negative value indicates a clockwise rotation, and a positive value indicates a
     * counterclockwise rotation.
     * @typedef RotationSpeed
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    export interface RotationSpeed {
        /**
         * Yaw speed, measured in radians per second.
         * @type { ?number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        yawSpeed?: number;
        /**
         * Roll speed, measured in radians per second.
         * @type { ?number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        rollSpeed?: number;
        /**
         * Pitch speed, measured in radians per second.
         * @type { ?number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        pitchSpeed?: number;
    }
    /**
     * Rotation angle limits relative to the reference point.
     * @typedef RotationLimits
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    export interface RotationLimits {
        /**
         * Maximum yaw rotation angles in the negative direction, ranging from -2*Math.PI to 0, measured in radians.
         * If the value is less than or equal to -2*Math.PI, there is no restriction.
         * @type { number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        negativeYawMax: number;
        /**
         * Maximum yaw rotation angles in the positive direction, ranging from 0 to 2*Math.PI, measured in radians.
         * If the value is greater than or equal to 2*Math.PI, there is no restriction.
         * @type { number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        positiveYawMax: number;
        /**
         * Maximum roll rotation angles in the negative direction, ranging from -2*Math.PI to 0, measured in radians.
         * If the value is less than or equal to -2*Math.PI, there is no restriction.
         * @type { number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        negativeRollMax: number;
        /**
         * Maximum roll rotation angles in the positive direction, ranging from 0 to 2*Math.PI, measured in radians.
         * If the value is greater than or equal to 2*Math.PI, there is no restriction.
         * @type { number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        positiveRollMax: number;
        /**
         * Maximum pitch rotation angles in the negative direction, ranging from -2*Math.PI to 0, measured in radians.
         * If the value is less than or equal to -2*Math.PI, there is no restriction.
         * @type { number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        negativePitchMax: number;
        /**
         * Maximum pitch rotation angles in the positive direction, ranging from 0 to 2*Math.PI, measured in radians.
         * If the value is greater than or equal to 2*Math.PI, there is no restriction.
         * @type { number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        positivePitchMax: number;
    }
    /**
     * Rotation axes status
     *
     * @typedef RotationAxesStatus
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    export interface RotationAxesStatus {
        /**
         * Whether the yaw axis is enabled.
         * @type { boolean }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        yawEnabled: boolean;
        /**
         * Whether the roll axis is enabled.
         * @type { boolean }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        rollEnabled: boolean;
        /**
         * Whether the pitch axis is enabled.
         * @type { boolean }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        pitchEnabled: boolean;
        /**
         * Whether the yaw axis is limited.
         * @type { ?RotationAxisLimited } RotationAxisLimited
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        yawLimited?: RotationAxisLimited;
        /**
         * Whether the roll axis is limited.
         * @type { ?RotationAxisLimited }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        rollLimited?: RotationAxisLimited;
        /**
         * Whether the pitch axis is limited.
         * @type { ?RotationAxisLimited }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        pitchLimited?: RotationAxisLimited;
    }
    /**
     * Enumerates the rotation axis limit states.
     * @enum { int }
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    export enum RotationAxisLimited {
        /**
         * Not limited.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        NOT_LIMITED = 0,
        /**
         * Negative limited.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        NEGATIVE_LIMITED = 1,
        /**
         * Positive limited.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        POSITIVE_LIMITED = 2
    }
    /**
     * Rotation axes state change information.
     * @typedef RotationAxesStateChangeInfo
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    export interface RotationAxesStateChangeInfo {
        /**
         * ID of the mechanical device.
         * @type { number }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        mechId: number;
        /**
         * Rotate axis status.
         * @type { RotationAxesStatus }
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        status: RotationAxesStatus;
    }
    /**
     * Tracking event callback info.
     *
     * @typedef TrackingEventInfo
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    export interface TrackingEventInfo {
        /**
         * Tracking event.
         * @type { TrackingEvent } Tracking event.
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        event: TrackingEvent;
    }
    /**
     * Callback information about the device attachment state change.
     * @typedef AttachStateChangeInfo
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    export interface AttachStateChangeInfo {
        /**
         * Device attachment state.
         * @type { AttachState }
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        state: AttachState;
        /**
         * Mechanical device information.
         * @type { MechInfo }
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        mechInfo: MechInfo;
    }
    /**
     * Enumerates the user operations.
     * @enum { int }
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    export enum Operation {
        /**
         * Connection operation.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        CONNECT = 0,
        /**
         * Disconnection operation.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        DISCONNECT = 1
    }
    /**
     * Enumerates the tracking events.
     * @enum { int }
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    export enum TrackingEvent {
        /**
         * Camera tracking enabled by user.
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        CAMERA_TRACKING_USER_ENABLED = 0,
        /**
         * Camera tracking disabled by user.
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        CAMERA_TRACKING_USER_DISABLED = 1,
        /**
         * Camera tracking layout changed. You can call getCameraTrackingLayout to obtain the new layout.
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        CAMERA_TRACKING_LAYOUT_CHANGED = 2
    }
    /**
     * Rotation execution results.
     *
     * @enum { int }
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    export enum Result {
        /**
         * Rotation completed.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        COMPLETED = 0,
        /**
         * Rotation was interrupted.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        INTERRUPTED = 1,
        /**
         * Device reached limitation.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        LIMITED = 2,
        /**
         * Rotation time out.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        TIMEOUT = 3,
        /**
         * Rotation failed due to system error.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        SYSTEM_ERROR = 100
    }
    /**
     * Enumerates the mechanical device types.
     * @enum { int }
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    export enum MechDeviceType {
        /**
         * Gimbal device.
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        GIMBAL_DEVICE = 0
    }
    /**
     * Device attach states.
     *
     * @enum { int }
     * @syscap SystemCapability.Mechanic.Core
     * @since 20
     */
    export enum AttachState {
        /**
         * Device attached.
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        ATTACHED = 0,
        /**
         * Device detached.
         * @syscap SystemCapability.Mechanic.Core
         * @since 20
         */
        DETACHED = 1
    }
    /**
     * Enumerates the camera tracking layouts.
     * @enum { int }
     * @syscap SystemCapability.Mechanic.Core
     * @systemapi
     * @since 20
     */
    export enum CameraTrackingLayout {
        /**
         * Default layout.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        DEFAULT = 0,
        /**
         * Left-side layout.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        LEFT = 1,
        /**
         * Middle layout.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        MIDDLE = 2,
        /**
         * Right-side layout.
         * @syscap SystemCapability.Mechanic.Core
         * @systemapi
         * @since 20
         */
        RIGHT = 3
    }
}
export default mechanicManager;
