/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
import { Callback } from './@ohos.base';
import window from './@ohos.window';
/**
 * uiExtension.
 *
 * @namespace uiExtension
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
declare namespace uiExtension {
    /**
     * The proxy of the UIExtension window.
     *
     * @interface WindowProxy
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export interface WindowProxy {
        /**
         * Obtains the area where this window cannot be displayed, for example, the system bar area, notch, gesture area, and soft keyboard area.
         *
         * @param { window.AvoidAreaType } type - Type of the avoid area.
         * @returns { window.AvoidArea } Area where the window cannot be displayed.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * <br> 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameters types.
         * <br> 3. Parameter verification failed.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        getWindowAvoidArea(type: window.AvoidAreaType): window.AvoidArea;
        /**
         * Subscribes to the event indicating changes to the area where the window cannot be displayed.
         *
         * @param { 'avoidAreaChange' } type - Event type. The value is fixed at 'avoidAreaChange',
         *     indicating the event of changes to the area where the window cannot be displayed.
         * @param { Callback<AvoidAreaInfo> } callback - Callback used to return the avoid area information.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * <br> 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameters types.
         * <br> 3. Parameter verification failed.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        on(type: 'avoidAreaChange', callback: Callback<AvoidAreaInfo>): void;
        /**
         * Unsubscribes from the event indicating changes to the area where the window cannot be displayed.
         *
         * @param { 'avoidAreaChange' } type - Event type. The value is fixed at 'avoidAreaChange',
         *     indicating the event of changes to the area where the window cannot be displayed.
         * @param { Callback<AvoidAreaInfo> } callback - Callback used to return the avoid area information.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * <br> 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameters types.
         * <br> 3. Parameter verification failed.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        off(type: 'avoidAreaChange', callback?: Callback<AvoidAreaInfo>): void;
        /**
         * Subscribes to the window size change event of the host application.
         *
         * @param { 'windowSizeChange' } type - Event type. The value is fixed at 'windowSizeChange', indicating the window size change event.
         * @param { Callback<window.Size> } callback - Callback used to return the window size.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * <br> 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameters types.
         * <br> 3. Parameter verification failed.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        on(type: 'windowSizeChange', callback: Callback<window.Size>): void;
        /**
         * Unsubscribes from the window size change event of the host application.
         *
         * @param { 'windowSizeChange' } type - Event type. The value is fixed at 'windowSizeChange', indicating the window size change event.
         * @param { Callback<window.Size> } callback - Callback used to return the window size.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * <br> 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameters types.
         * <br> 3. Parameter verification failed.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        off(type: 'windowSizeChange', callback?: Callback<window.Size>): void;
        /**
         * Sets whether to hide insecure windows.
         * When called by modal UIExtension and shouldHide == false, the "ohos.permission.ALLOW_SHOW_NON_SECURE_WINDOWS" permission is required.
         *
         * @permission ohos.permission.ALLOW_SHOW_NON_SECURE_WINDOWS
         * @param { boolean } shouldHide - Whether to hide insecure windows. The value true means to hide insecure windows, and false means the opposite.
         * @returns { Promise<void> } - The promise returned by the function.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * <br> 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameters types.
         * <br> 3. Parameter verification failed.
         * @throws { BusinessError } 1300002 - Abnormal state. Possible causes:
         * <br> 1. Permission denied. Interface caller does not have permission "ohos.permission.ALLOW_SHOW_NON_SECURE_WINDOWS".
         * <br> 2. The UIExtension window proxy is abnormal.
         * @throws { BusinessError } 1300003 - This window manager service works abnormally.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @systemapi
         * @since 20
         */
        hideNonSecureWindows(shouldHide: boolean): Promise<void>;
        /**
         * Creates a subwindow for this window proxy. This API uses a promise to return the result.
         *
         * @param { string } name - Name of the subwindow.
         * @param { window.SubWindowOptions } subWindowOptions - Parameters used for creating the subwindow.
         * @returns { Promise<window.Window> } Promise used to return the subwindow.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * <br> 1. Mandatory parameters are left unspecified.
         * <br> 2. Incorrect parameters types.
         * <br> 3. Parameter verification failed.
         * @throws { BusinessError } 801 - Capability not supported. Failed to call the API due to limited device capabilities.
         * @throws { BusinessError } 1300002 - This window state is abnormal.
         * @throws { BusinessError } 1300005 - This window proxy is abnormal.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @StageModelOnly
         * @since 20
         */
        createSubWindowWithOptions(name: string, subWindowOptions: window.SubWindowOptions): Promise<window.Window>;
        /**
         * Adds or deletes the watermark flag for this window. This API uses a promise to return the result.
         *
         * @param { boolean } enable - Whether to add or delete the flag. The value true means to add the watermark flag,
         *     and false means to delete the watermark flag.
         * @returns { Promise<void> } - The promise returned by the function
         * @throws { BusinessError } 1300002 - The UIExtension window proxy is abnormal.
         * @throws { BusinessError } 1300003 - This window manager service works abnormally.
         * @throws { BusinessError } 1300008 - The display device is abnormal.
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @systemapi
         * @since 20
         */
        setWaterMarkFlag(enable: boolean): Promise<void>;
    }
    /**
     * Defines the avoid area information.
     *
     * @interface AvoidAreaInfo
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    export interface AvoidAreaInfo {
        /**
         * Type of the area where the window cannot be displayed.
         *
         * @type { window.AvoidAreaType }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        type: window.AvoidAreaType;
        /**
         * Area where the window cannot be displayed.
         *
         * @type { window.AvoidArea }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        area: window.AvoidArea;
    }
    /**
     * Properties of UIExtension window
     *
     * @interface WindowProxyProperties
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     *
     */
    export interface WindowProxyProperties {
        /**
         * Position and size of the component (EmbeddedComponent or UIExtensionComponent).
         *
         * @type { window.Rect }
         * @syscap SystemCapability.ArkUI.ArkUI.Full
         * @since 20
         */
        uiExtensionHostWindowProxyRect: window.Rect;
    }
}
export default uiExtension;
