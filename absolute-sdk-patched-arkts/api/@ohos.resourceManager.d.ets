/*
 * Copyright (c) 2021-2024 Huawei Device Co., Ltd.
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
 * @kit LocalizationKit
 */
import { RawFileDescriptor as _RawFileDescriptor } from './global/rawFileDescriptor';
import { Resource as _Resource } from './global/resource';
import { AsyncCallback as _AsyncCallback } from './@ohos.base';
import { DrawableDescriptor } from './@ohos.arkui.drawableDescriptor';


/**
 * Provides resource related APIs.
 *
 * @namespace resourceManager
 * @syscap SystemCapability.Global.ResourceManager
 * @since 20
 */
declare namespace resourceManager {
    
    
    /**
     * Enumerates screen directions.
     *
     * @enum { int }
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    export enum Direction {
        
        
        /**
         * Indicates the vertical direction.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        DIRECTION_VERTICAL = 0,
        
        
        /**
         * Indicates the horizontal direction.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        DIRECTION_HORIZONTAL = 1
    }
    
    
    /**
     * Enumerates device types.
     *
     * @enum { int }
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    export enum DeviceType {
        
        
        /**
         * Indicates a phone.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        DEVICE_TYPE_PHONE = 0x00,
        
        
        /**
         * Indicates a tablet.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        DEVICE_TYPE_TABLET = 0x01,
        
        
        /**
         * Indicates a car.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        DEVICE_TYPE_CAR = 0x02,
        
        
        /**
         * Indicates a PC.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        DEVICE_TYPE_PC = 0x03,
        
        
        /**
         * Indicates a smart TV.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        DEVICE_TYPE_TV = 0x04,
        
        
        /**
         * Indicates a wearable device.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        DEVICE_TYPE_WEARABLE = 0x06,
        /**
         * Indicates a 2in1 device.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        DEVICE_TYPE_2IN1 = 0x07
    }
    
    
    /**
     * Enumerates screen density types.
     *
     * @enum { int }
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    export enum ScreenDensity {
        
        
        /**
         * Indicates small screen density.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        SCREEN_SDPI = 120,
        
        
        /**
         * Indicates medium screen density.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        SCREEN_MDPI = 160,
        
        
        /**
         * Indicates large screen density.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        SCREEN_LDPI = 240,
        
        
        /**
         * Indicates extra-large screen density.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        SCREEN_XLDPI = 320,
        
        
        /**
         * Indicates extra-extra-large screen density.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        SCREEN_XXLDPI = 480,
        
        
        /**
         * Indicates extra-extra-extra-large screen density.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        SCREEN_XXXLDPI = 640
    }
    /**
     * Enumerates color mode types.
     *
     * @enum { int }
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    export enum ColorMode {
        /**
         * Indicates dark mode.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        DARK = 0,
        /**
         * Indicates light mode.
         *
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        LIGHT = 1
    }
    
    
    /**
     * Provides the device configuration.
     *
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    export class Configuration {
        
        
        
        /**
         * Indicates the screen direction of the current device.
         *
         * @type { Direction }
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        direction: Direction;
        
        
        
        /**
         * Indicates the current system language, for example, zh-Hans-CN.
         *
         * @type { string }
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        locale: string;
        /**
         * Indicates the device type.
         *
         * @type { DeviceType }
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        deviceType: DeviceType;
        /**
         * Indicates the screen density.
         *
         * @type { ScreenDensity }
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        screenDensity: ScreenDensity;
        /**
         * Indicates the color mode.
         *
         * @type { ColorMode }
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        colorMode: ColorMode;
        /**
         * Indicates the mcc.
         *
         * @type { int }
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        mcc: int;
        /**
         * Indicates the mnc.
         *
         * @type { int }
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        mnc: int;
    }
    
    
    /**
     * Provides the device capability.
     *
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    export class DeviceCapability {
        
        
        
        /**
         * Indicates the screen density of the current device.
         *
         * @type { ScreenDensity }
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        screenDensity: ScreenDensity;
        
        
        
        /**
         * Indicates the type of the current device.
         *
         * @type { DeviceType }
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        deviceType: DeviceType;
    }
    
    /**
     * Obtains a global shared system ResourceManager object that provides access to only system resource, in which the
     * resConfig is default value(contains resLocale, screenDensityDpi, direction, etc).
     *
     * @returns { ResourceManager } The System ResourceManager object is returned.
     * @throws { BusinessError } 9001009 - Failed to access the system resource.
     *         which is not mapped to application sandbox, This error code will be thrown.
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    export function getSystemResourceManager(): ResourceManager;
    /**
     * Obtains a global shared system ResourceManager object that provides access to only system resource, in which the
     *     resConfig is current system resConfig(contains resLocale, screenDensityDpi, direction, etc).
     *
     * @returns { ResourceManager } The System ResourceManager object is returned.
     * @throws { BusinessError } 9001009 - Failed to access the system resource.
     *     which is not mapped to application sandbox, This error code will be thrown.
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    export function getSysResourceManager(): ResourceManager;
    
    
    /**
     * Provides the capability of accessing application resources.
     *
     * @interface ResourceManager
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    export interface ResourceManager {
        
        
        /**
         * Obtains the device capability in callback mode.
         *
         * @param { _AsyncCallback<DeviceCapability> } callback - Indicates the asynchronous callback used to return the obtained device capability.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getDeviceCapability(callback: _AsyncCallback<DeviceCapability>): void;
        
        
        /**
         * Obtains the device capability in Promise mode.
         *
         * @returns { Promise<DeviceCapability> } the device capability.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getDeviceCapability(): Promise<DeviceCapability>;
        
        
        /**
         * Obtains the device configuration in callback mode.
         *
         * @param { _AsyncCallback<Configuration> } callback - Indicates the asynchronous callback used to return the obtained device
         *                 configuration.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getConfiguration(callback: _AsyncCallback<Configuration>): void;
        
        
        /**
         * Obtains the device configuration in Promise mode.
         *
         * @returns { Promise<Configuration> } the device configuration.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getConfiguration(): Promise<Configuration>;
        
        
        /**
         * Obtains the character string corresponding to a specified resource name in callback mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { _AsyncCallback<string> } callback - Indicates the asynchronous callback used to return the obtained character string.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringByName(resName: string, callback: _AsyncCallback<string>): void;
        
        
        /**
         * Obtains string resources associated with a specified resource name in Promise mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { Promise<string> } The character string corresponding to the resource name.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringByName(resName: string): Promise<string>;
        
        
        /**
         * Obtains the array of character strings corresponding to a specified resource name in callback mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { _AsyncCallback<Array<string>> } callback - Indicates the asynchronous callback used to return the obtained array of character strings.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringArrayByName(resName: string, callback: _AsyncCallback<Array<string>>): void;
        
        
        /**
         * Obtains the array of character strings corresponding to a specified resource name in Promise mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { Promise<Array<string>> } the array of character strings corresponding to the specified resource name.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringArrayByName(resName: string): Promise<Array<string>>;
        
        
        /**
         * Obtains the content of the media file corresponding to a specified resource name in callback mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { _AsyncCallback<Uint8Array> } callback - Indicates the asynchronous callback used to return the obtained media file content.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaByName(resName: string, callback: _AsyncCallback<Uint8Array>): void;
        
        /**
         * Obtains the content of the specified screen density media file corresponding to a specified resource name in callback mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { int } density - The parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                 to use the density of current system dpi.
         * @param { _AsyncCallback<Uint8Array> } callback - Indicates the asynchronous callback used to return the obtained
         *                 specified screen density media file content.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaByName(resName: string, density: int, callback: _AsyncCallback<Uint8Array>): void;
        
        
        /**
         * Obtains the content of the media file corresponding to a specified resource name in Promise mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { Promise<Uint8Array> } The content of the media file corresponding to the specified resource name.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaByName(resName: string): Promise<Uint8Array>;
        
        /**
         * Obtains the content of the specified screen density media file corresponding to a specified resource name in Promise mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { int } density - The optional parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                 to use the density of current system dpi.
         * @returns { Promise<Uint8Array> } The content of the specified screen density media file corresponding to the
         *                 specified resource name.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaByName(resName: string, density: int): Promise<Uint8Array>;
        
        
        /**
         * Obtains the Base64 code of the image resource corresponding to the specified resource name in callback mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { _AsyncCallback<string> } callback - Indicates the asynchronous callback used to return the obtained Base64 code of the image
         *                 resource.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaBase64ByName(resName: string, callback: _AsyncCallback<string>): void;
        
        /**
         * Obtains the Base64 code of the specified screen density image resource corresponding to the specified resource name in callback mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { int } density - The parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                 to use the density of current system dpi.
         * @param { _AsyncCallback<string> } callback - Indicates the asynchronous callback used to return the obtained Base64 code of the
         *                 specified screen density image resource.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaBase64ByName(resName: string, density: int, callback: _AsyncCallback<string>): void;
        
        
        /**
         * Obtains the Base64 code of the image resource corresponding to the specified resource name in Promise mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { Promise<string> } The Base64 code of the image resource corresponding to the specified resource name.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaBase64ByName(resName: string): Promise<string>;
        
        /**
         * Obtains the Base64 code of the specified screen density image resource corresponding to the specified resource name in Promise mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { int } density - The optional parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                 to use the density of current system dpi.
         * @returns { Promise<string> } The Base64 code of the specified screen density image resource corresponding to the specified resource name.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaBase64ByName(resName: string, density: int): Promise<string>;
        
        
        /**
         * Obtains string resources associated with a specified resource ID.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { string } The character string corresponding to the resource ID.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringSync(resId: long): string;
        /**
         * Obtains string resources associated with a specified resource ID.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { (string | double)[] } args - Indicates the formatting string resource parameters.
         * @returns { string } The character string corresponding to the resource ID.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @throws { BusinessError } 9001007 - Failed to format the resource obtained based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringSync(resId: long, ...args: (string | double)[]): string;
        
        
        /**
         * Obtains string resources associated with a specified resource name.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { string } The character string corresponding to the resource name.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringByNameSync(resName: string): string;
        /**
         * Obtains string resources associated with a specified resource name.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { (string | double)[] } args - Indicates the formatting string resource parameters.
         * @returns { string } The character string corresponding to the resource name.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @throws { BusinessError } 9001008 - Failed to format the resource obtained based on the resource Name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringByNameSync(resName: string, ...args: (string | double)[]): string;
        
        
        /**
         * Obtains the boolean result with a specified resource ID.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { boolean } The boolean resource corresponding to the resource ID.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getBoolean(resId: long): boolean;
        
        
        /**
         * Obtains the boolean result with a specified resource name.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { boolean } The boolean resource corresponding to the resource name.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getBooleanByName(resName: string): boolean;
        /**
         * Obtains the number result with a specified resource ID.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { int } The number resource corresponding to the resource ID.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getInt(resId: long): int;
        /**
         * Obtains the number result with a specified resource ID.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { double } The number resource corresponding to the resource ID.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getDouble(resId: long): double;
        /**
         * Obtains the number result with a specified resource name.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { int } The number resource corresponding to the resource name.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getIntByName(resName: string): int;
        /**
         * Obtains the number result with a specified resource name.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { double } The number resource corresponding to the resource name.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getDoubleByName(resName: string): double;
        
        
        /**
         * Obtains the character string corresponding to a specified resource ID in callback mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { _AsyncCallback<string> } callback - Indicates the asynchronous callback used to return the obtained character string.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringValue(resId: long, callback: _AsyncCallback<string>): void;
        
        
        /**
         * Obtains string resources associated with a specified resource ID in Promise mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { Promise<string> } The character string corresponding to the resource ID.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringValue(resId: long): Promise<string>;
        
        
        /**
         * Obtains the array of character strings corresponding to a specified resource ID in callback mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { _AsyncCallback<Array<string>> } callback - Indicates the asynchronous callback used to return the obtained array of character strings.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringArrayValue(resId: long, callback: _AsyncCallback<Array<string>>): void;
        
        
        /**
         * Obtains the array of character strings corresponding to a specified resource ID in Promise mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { Promise<Array<string>> } The array of character strings corresponding to the specified resource ID.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringArrayValue(resId: long): Promise<Array<string>>;
        /**
         * Obtains the singular-plural character string represented by the ID string corresponding to
         * the specified number.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { int } num - An integer used to get the correct string for the current plural rules.
         * @param { (string | double)[] } args - Indicates the formatting string resource parameters.
         * @returns { string } The singular-plural character string represented by the ID string
         *         corresponding to the specified number.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @throws { BusinessError } 9001007 - Failed to format the resource obtained based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getIntPluralStringValueSync(resId: long, num: int, ...args: (string | double)[]): string;
        /**
         * Obtains the singular-plural character string represented by the name string corresponding to
         * the specified number.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { int } num - An integer used to get the correct string for the current plural rules.
         * @param { (string | double)[] } args - Indicates the formatting string resource parameters.
         * @returns { string } The singular-plural character string represented by the name string
         *         corresponding to the specified number.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @throws { BusinessError } 9001008 - Failed to format the resource obtained based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getIntPluralStringByNameSync(resName: string, num: int, ...args: (string | double)[]): string;
        /**
         * Obtains the singular-plural character string represented by the ID string corresponding to
         * the specified number.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { double } num - A double parameter used to get the correct string for the current plural rules.
         * @param { (string | double)[] } args - Indicates the formatting string resource parameters.
         * @returns { string } The singular-plural character string represented by the ID string
         *         corresponding to the specified number.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @throws { BusinessError } 9001007 - Failed to format the resource obtained based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getDoublePluralStringValueSync(resId: long, num: double, ...args: (string | double)[]): string;
        /**
         * Obtains the singular-plural character string represented by the name string corresponding to
         * the specified number.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { double } num - A double parameter used to get the correct string for the current plural rules.
         * @param { (string | double)[] } args - Indicates the formatting string resource parameters.
         * @returns { string } The singular-plural character string represented by the name string
         *         corresponding to the specified number.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @throws { BusinessError } 9001008 - Failed to format the resource obtained based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getDoublePluralStringByNameSync(resName: string, num: double, ...args: (string | double)[]): string;
        
        
        /**
         * Obtains the content of the media file corresponding to a specified resource ID in callback mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { _AsyncCallback<Uint8Array> } callback - Indicates the asynchronous callback used to return the obtained media file content.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaContent(resId: long, callback: _AsyncCallback<Uint8Array>): void;
        
        /**
         * Obtains the content of the specified screen density media file corresponding to a specified resource ID in callback mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { int } density - The parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                 to use the density of current system dpi.
         * @param { _AsyncCallback<Uint8Array> } callback - Indicates the asynchronous callback used to return the obtained
         *                 specified screen density media file content.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaContent(resId: long, density: int, callback: _AsyncCallback<Uint8Array>): void;
        
        
        /**
         * Obtains the content of the media file corresponding to a specified resource ID in Promise mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { Promise<Uint8Array> } The content of the media file corresponding to the specified resource ID.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaContent(resId: long): Promise<Uint8Array>;
        
        /**
         * Obtains the content of the specified screen density media file corresponding to a specified resource ID in Promise mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { int } density - The optional parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                 to use the density of current system dpi.
         * @returns { Promise<Uint8Array> } The content of the specified screen density media file corresponding to the specified resource ID.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaContent(resId: long, density: int): Promise<Uint8Array>;
        
        
        /**
         * Obtains the Base64 code of the image resource corresponding to the specified resource ID in callback mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { _AsyncCallback<string> } callback - Indicates the asynchronous callback used to return the obtained Base64 code of the image
         *                 resource.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaContentBase64(resId: long, callback: _AsyncCallback<string>): void;
        
        /**
         * Obtains the Base64 code of the specified screen density image resource corresponding to the specified resource ID in callback mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { int } density - The parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                 to use the density of current system dpi.
         * @param { _AsyncCallback<string> } callback - Indicates the asynchronous callback used to return the obtained Base64 code of the
         *                 specified screen density image resource.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaContentBase64(resId: long, density: int, callback: _AsyncCallback<string>): void;
        
        
        /**
         * Obtains the Base64 code of the image resource corresponding to the specified resource ID in Promise mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { Promise<string> } the Base64 code of the image resource corresponding to the specified resource ID.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaContentBase64(resId: long): Promise<string>;
        
        /**
         * Obtains the Base64 code of the specified screen density image resource corresponding to the specified resource ID in Promise mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { int } density - The optional parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                 to use the density of current system dpi.
         * @returns { Promise<string> } the Base64 code of the specified screen density image resource corresponding to the specified resource ID.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaContentBase64(resId: long, density: int): Promise<string>;
        
        
        /**
         * Obtains the raw file resource corresponding to the specified resource path in callback mode.
         *
         * @param { string } path - Indicates the resource relative path.
         * @param { _AsyncCallback<Uint8Array> } callback - Indicates the asynchronous callback used to return the raw file resource.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getRawFileContent(path: string, callback: _AsyncCallback<Uint8Array>): void;
        
        
        /**
         * Obtains the raw file resource corresponding to the specified resource path in Promise mode.
         *
         * @param { string } path - Indicates the resource relative path.
         * @returns { Promise<Uint8Array> } the raw file resource corresponding to the specified resource path.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getRawFileContent(path: string): Promise<Uint8Array>;
        
        
        /**
         * Obtains the raw file resource descriptor corresponding to the specified resource path in callback mode.
         *
         * @param { string } path - Indicates the resource relative path.
         * @param { _AsyncCallback<RawFileDescriptor> } callback - Indicates the asynchronous callback used to return the raw file resource descriptor.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getRawFd(path: string, callback: _AsyncCallback<RawFileDescriptor>): void;
        
        
        /**
         * Obtains the raw file resource descriptor corresponding to the specified resource path in Promise mode.
         *
         * @param { string } path - Indicates the resource relative path.
         * @returns { Promise<RawFileDescriptor> } The raw file resource descriptor corresponding to the specified resource path.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getRawFd(path: string): Promise<RawFileDescriptor>;
        
        
        /**
         * Obtains close raw file resource descriptor corresponding to the specified resource path in callback mode.
         *
         * @param { string } path - Indicates the resource relative path.
         * @param { _AsyncCallback<void> } callback - Indicates the asynchronous callback used to return result close raw file resource descriptor.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        closeRawFd(path: string, callback: _AsyncCallback<void>): void;
        
        
        /**
         * Obtains close raw file resource descriptor corresponding to the specified resource path in Promise mode.
         *
         * @param { string } path - Indicates the resource relative path.
         * @returns { Promise<void> } The result close raw file resource descriptor corresponding to the specified resource path.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        closeRawFd(path: string): Promise<void>;
        
        
        /**
         * Obtains the DrawableDescriptor of the media file corresponding to a specified resource ID.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { int } [density] - The optional parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *             to use the density of current system dpi.
         * @param { int } [type] - The optional parameter means the media type, the default value 0 means
         *             the normal media.
         * @returns { DrawableDescriptor } The DrawableDescriptor class to get drawable image.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getDrawableDescriptor(resId: long, density?: int, type?: int): DrawableDescriptor;
        
        
        /**
         * Obtains the DrawableDescriptor of the media file corresponding to a specified resource Name.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { int } [density] - The optional parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *             to use the density of current system dpi.
         * @param { int } [type] - The optional parameter means the media type, the default value 0 means
         *             the normal media.
         * @returns { DrawableDescriptor } The DrawableDescriptor class to get drawable image.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getDrawableDescriptorByName(resName: string, density?: int, type?: int): DrawableDescriptor;
        
        /**
         * Obtains the rawfile resource list corresponding to the specified resource path in callback mode.
         *
         * @param { string } path - Indicates the resource relative path.
         * @param { _AsyncCallback<Array<string>> } callback - Indicates the asynchronous callback used to return the raw file list.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getRawFileList(path: string, callback: _AsyncCallback<Array<string>>): void;
        
        /**
         * Obtains the rawfile resource list corresponding to the specified resource path in Promise mode.
         *
         * @param { string } path - Indicates the resource relative path.
         * @returns { Promise<Array<string>> } The rawfile list corresponding to the specified resource path.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getRawFileList(path: string): Promise<Array<string>>;
        
        /**
         * Obtains the color resource corresponding to the specified resource ID in callback mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { _AsyncCallback<long> } callback - Indicates the asynchronous callback used to
         *     return the integer reference value representing the color data.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getColor(resId: long, callback: _AsyncCallback<long>): void;
        
        /**
         * Obtains the color resource corresponding to the specified resource ID in promise mode.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { Promise<long> } Indicates return the integer reference value representing the color data.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getColor(resId: long): Promise<long>;
        
        /**
         * Obtains the color resource corresponding to the specified resource object in callback mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { _AsyncCallback<long> } callback - Indicates the asynchronous callback used to
         *     return the integer reference value representing the color data.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getColorByName(resName: string, callback: _AsyncCallback<long>): void;
        
        /**
         * Obtains the color resource corresponding to the specified resource object in promise mode.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { Promise<long> } Indicates return the integer reference value representing the color data.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getColorByName(resName: string): Promise<long>;
        
        /**
         * Obtains the color resource corresponding to the specified resource ID.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { long } Indicates the integer reference value representing the color data.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getColorSync(resId: long): long;
        
        /**
         * Obtains the color resource corresponding to the specified resource name.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { long } Indicates the integer reference value representing the color data.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getColorByNameSync(resName: string): long;
        
        /**
         * Add overlay resources during application runtime.
         *
         * @param { string } path - Indicates the application overlay path.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001010 - Invalid overlay path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        addResource(path: string): void;
        
        /**
         * Remove overlay resources during application runtime.
         *
         * @param { string } path - Indicates the application overlay path.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001010 - Invalid overlay path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        removeResource(path: string): void;
        
        /**
         * Obtains the raw file resource descriptor corresponding to the specified resource path.
         *
         * @param { string } path - Indicates the resource relative path.
         * @returns { RawFileDescriptor } The raw file resource descriptor.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getRawFdSync(path: string): RawFileDescriptor;
        
        /**
         * Close the raw file resource descriptor corresponding to the specified resource path.
         *
         * @param { string } path - Indicates the resource relative path.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        closeRawFdSync(path: string): void;
        
        /**
         * Obtains the rawfile resource list corresponding to the specified resource path.
         *
         * @param { string } path - Indicates the resource relative path.
         * @returns { Array<string> } The rawfile resource list.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getRawFileListSync(path: string): Array<string>;
        
        /**
         * Obtains the raw file resource corresponding to the specified resource path.
         *
         * @param { string } path - Indicates the resource relative path.
         * @returns { Uint8Array } the raw file resource corresponding to the specified resource path.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getRawFileContentSync(path: string): Uint8Array;
        
        /**
         * Obtains the content of the specified screen density media file corresponding to a specified resource ID.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { int } [density] - The optional parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                to use the density of current system dpi.
         * @returns { Uint8Array } Indicates the obtained media file content.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaContentSync(resId: long, density?: int): Uint8Array;
        
        /**
         * Obtains the Base64 code of the specified screen density media file corresponding to the specified resource ID.
         *
         * @param { long } resId - Indicates the resource ID.
         * @param { int } [density] - The optional parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                to use the density of current system dpi.
         * @returns { string } Indicates the obtained Base64 code of the media file.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaContentBase64Sync(resId: long, density?: int): string;
        
        /**
         * Obtains the array of character strings corresponding to a specified resource ID.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { Array<string> } The array of character strings corresponding to the specified resource ID.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringArrayValueSync(resId: long): Array<string>;
        
        /**
         * Obtains the content of the specified screen density media file corresponding to a specified resource name.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { int } [density] - The parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                 to use the density of current system dpi.
         * @returns { Uint8Array } The obtained specified screen density media file content.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaByNameSync(resName: string, density?: int): Uint8Array;
        
        /**
         * Obtains the Base64 code of the specified screen density media file corresponding to the specified resource name.
         *
         * @param { string } resName - Indicates the resource name.
         * @param { int } [density] - The parameter ScreenDensity{@link ScreenDensity}, A value of 0 means
         *                 to use the density of current system dpi.
         * @returns { string } The obtained Base64 code of the specified screen density media file.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: 1.Incorrect parameter types; 2.Parameter verification failed.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getMediaBase64ByNameSync(resName: string, density?: int): string;
        
        /**
         * Obtains the array of character strings corresponding to a specified resource name.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { Array<string> } the array of character strings corresponding to the specified resource name.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getStringArrayByNameSync(resName: string): Array<string>;
        
        /**
         * Obtains the device configuration.
         *
         * @returns { Configuration } the device configuration.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getConfigurationSync(): Configuration;
        
        /**
         * Obtains the device capability.
         *
         * @returns { DeviceCapability } the device capability.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getDeviceCapabilitySync(): DeviceCapability;
        /**
         * Obtains locales list.
         *
         * @param { boolean } [includeSystem] - the parameter controls whether to include system resources,
         *     the default value is false, it has no effect when only system resources query the locales list.
         * @returns { Array<string> } the list of strings for the locales.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getLocales(includeSystem?: boolean): Array<string>;
        /**
         * Obtains the symbol resource corresponding to the specified resource ID.
         *
         * @param { long } resId - Indicates the resource ID.
         * @returns { long } Indicates the integer reference value representing the symbol data.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001001 - Invalid resource ID.
         * @throws { BusinessError } 9001002 - No matching resource is found based on the resource ID.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getSymbol(resId: long): long;
        /**
         * Obtains the symbol resource corresponding to the specified resource name.
         *
         * @param { string } resName - Indicates the resource name.
         * @returns { long } Indicates the integer reference value representing the symbol data.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001003 - Invalid resource name.
         * @throws { BusinessError } 9001004 - No matching resource is found based on the resource name.
         * @throws { BusinessError } 9001006 - The resource is referenced cyclically.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getSymbolByName(resName: string): long;
        /**
         * Whether the rawfile resource is a directory or not.
         *
         * @param { string } path - Indicates the rawfile resource relative path.
         * @returns { boolean } True means the file path is directory, else false.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @throws { BusinessError } 9001005 - Invalid relative path.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        isRawDir(path: string): boolean;
        /**
         * Get the override ResourceManager object related to the specified Configuration.
         *
         * @param { Configuration } [configuration] - Indicates the override Configuration{@link Configuration}
         * @returns { ResourceManager } The ResourceManager object is returned.
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getOverrideResourceManager(configuration?: Configuration): ResourceManager;
        /**
         * Get the current override Configuration related to the specified override ResourceManager.
         *
         * @returns { Configuration } The Configuration object is returned.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        getOverrideConfiguration(): Configuration;
        /**
         * Update the current override Configuration.
         *
         * @param { Configuration } configuration - Indicates the override Configuration{@link Configuration}
         * @throws { BusinessError } 401 - If the input parameter invalid. Possible causes: Incorrect parameter types.
         * @syscap SystemCapability.Global.ResourceManager
         * @since 20
         */
        updateOverrideConfiguration(configuration: Configuration): void;
    }
    
    
    /**
     * Contains rawFile descriptor information.
     *
     * @typedef {_RawFileDescriptor}
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    export type RawFileDescriptor = _RawFileDescriptor;
    
    
    /**
     * Contains resource descriptor information.
     *
     * @typedef {_Resource}
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    export type Resource = _Resource;
}
export default resourceManager;
