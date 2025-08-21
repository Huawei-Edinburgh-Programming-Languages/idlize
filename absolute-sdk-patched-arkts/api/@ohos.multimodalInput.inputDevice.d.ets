/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
import { Callback, AsyncCallback } from './@ohos.base';
/**
 * The inputDevice module implements input device management functions such as listening for the connection
 * and disconnection of input devices and querying input device information such as the device name.
 *
 * @namespace inputDevice
 * @syscap SystemCapability.MultimodalInput.Input.InputDevice
 * @since 20
 */
declare namespace inputDevice {
    /**
     * Enumerates hot swap events.
     *
     * @typedef { 'add' | 'remove' }
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    type ChangedType = 'add' | 'remove';
    /**
     * Enumerates input source of the axis. For example, if a mouse reports an x-axis event, the input source of the x-axis is the mouse.
     *
     * @typedef { 'keyboard' | 'mouse' | 'touchpad' | 'touchscreen' | 'joystick' | 'trackball' }
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    type SourceType = 'keyboard' | 'mouse' | 'touchpad' | 'touchscreen' | 'joystick' | 'trackball';
    /**
     * Defines the axis type of an input device.
     *
     * @typedef { 'touchmajor'| 'touchminor' | 'orientation' | 'x' | 'y' | 'pressure' | 'toolminor' | 'toolmajor' | 'null' }
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    type AxisType = 'touchmajor' | 'touchminor' | 'orientation' | 'x' | 'y' | 'pressure' | 'toolminor' | 'toolmajor' | 'null';
    /**
     * Enumerates keyboard types.
     *
     * @enum { number }
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    enum KeyboardType {
        /**
         * Keyboard without keys.
         *
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        NONE = 0,
        /**
         * Keyboard with unknown keys.
         *
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        UNKNOWN = 1,
        /**
         * Full keyboard.
         *
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        ALPHABETIC_KEYBOARD = 2,
        /**
         * Keypad.
         *
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        DIGITAL_KEYBOARD = 3,
        /**
         * Stylus.
         *
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        HANDWRITING_PEN = 4,
        /**
         * Remote control.
         *
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        REMOTE_CONTROL = 5
    }
    /**
     * Enumerates function key types.
     *
     * @enum { number }
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    enum FunctionKey {
        /**
         * CapsLock key. This key can be enabled or disabled only for the input keyboard extension.
         *
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        CAPS_LOCK = 1
    }
    /**
     * Provides hot swap information about an input device.
     *
     * @interface DeviceListener
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    interface DeviceListener {
        /**
         * Device change type, which indicates whether an input device is inserted or removed.
         *
         * @type { ChangedType }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        type: ChangedType;
        /**
         * Unique ID of the input device.
         * If a physical device is repeatedly reinstalled or restarted, its ID may change.
         *
         * @type { int }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        deviceId: int;
    }
    /**
     * Enables listening for device hot swap events.
     * When performing this operation, you need to connect to external devices such as a mouse, keyboard, and touchscreen.
     *
     * @param { 'change' } type - Event type. This field has a fixed value of change.
     * @param { Callback<DeviceListener> } listener - Listener for events of the input device.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    function on(type: 'change', listener: Callback<DeviceListener>): void;
    /**
     * Defines the axis range of an input device.
     *
     * @interface AxisRange
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    interface AxisRange {
        /**
         * Input source of the axis.
         *
         * @type { SourceType }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        source: SourceType;
        /**
         * Axis type.
         *
         * @type { AxisType }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        axis: AxisType;
        /**
         * Maximum value of the axis.
         *
         * @type { int }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        max: int;
        /**
         * Minimum value of the axis.
         *
         * @type { int }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        min: int;
        /**
         * Fuzzy value of the axis.
         *
         * @type { int }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        fuzz: int;
        /**
         * Benchmark value of the axis.
         *
         * @type { int }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        flat: int;
        /**
         * Resolution of the axis.
         *
         * @type { int }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        resolution: int;
    }
    /**
     * Provides information about an input device.
     *
     * @interface InputDeviceData
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    interface InputDeviceData {
        /**
         * Unique ID of the input device.
         * If the same physical device is repeatedly reinstalled or restarted, its ID may change.
         *
         * @type { int }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        id: int;
        /**
         * Name of the input device.
         *
         * @type { string }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        name: string;
        /**
         * Input sources supported by the input device. An input device can have multiple input sources.
         * For example, if a keyboard is equipped with a touchpad, the input device supports both keyboard
         * and touchpad input capabilities.
         *
         * @type { Array<SourceType> }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        sources: Array<SourceType>;
        /**
         * Axis information of the input device.
         *
         * @type { Array<AxisRange> }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        axisRanges: Array<AxisRange>;
        /**
         * Bus type of the input device. By default, the bus type reported by the input device prevails.
         *
         * @type { int }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        bus: int;
        /**
         * Product information of the input device.
         *
         * @type { int }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        product: int;
        /**
         * Vendor information of the input device.
         *
         * @type { int }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        vendor: int;
        /**
         * Version information of the input device.
         *
         * @type { int }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        version: int;
        /**
         * Physical address of the input device.
         *
         * @type { string }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        phys: string;
        /**
         * Unique ID of the input device.
         *
         * @type { string }
         * @syscap SystemCapability.MultimodalInput.Input.InputDevice
         * @since 20
         */
        uniq: string;
    }
    /**
     * Obtains the IDs of all input devices.
     * This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<Array<number>> } callback - Callback used to return the IDs of all input devices. id is the unique ID of an input device.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    function getDeviceList(callback: AsyncCallback<Array<number>>): void;
    /**
     * Obtains the IDs of all input devices.
     * This API uses a promise to return the result.
     *
     * @returns { Promise<Array<number>> } - Promise used to return the IDs of all input devices.
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    function getDeviceList(): Promise<Array<number>>;
    /**
     * Obtains information about the specified input device.
     * This API uses an asynchronous callback to return the result.
     *
     * @param { number } deviceId - ID of the input device.
     * @param { AsyncCallback<InputDeviceData> } callback - Callback used to return information about the input device,
     * including device ID, name, supported source, physical address, version information, and product information.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    function getDeviceInfo(deviceId: number, callback: AsyncCallback<InputDeviceData>): void;
    /**
     * Obtains the information about the input device with the specified ID.
     * This API uses a promise to return the result.
     *
     * @param { number } deviceId - ID of the input device.
     * @returns { Promise<InputDeviceData> } Promise used to return the information about the input device.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;
     * <br>2. Incorrect parameter types; 3. Parameter verification failed.
     * @syscap SystemCapability.MultimodalInput.Input.InputDevice
     * @since 20
     */
    function getDeviceInfo(deviceId: number): Promise<InputDeviceData>;
}
export default inputDevice;
