/*
 * Copyright (c) 2021-2025 Huawei Device Co., Ltd.
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
 * @kit IMEKit
 */
import type { Callback, AsyncCallback } from './@ohos.base';
import InputMethodSubtype from './@ohos.InputMethodSubtype';
import { ElementName } from './bundleManager/ElementName';
import { PanelInfo } from './@ohos.inputMethod.Panel';
/**
 * Input method
 *
 * @namespace inputMethod
 * @syscap SystemCapability.MiscServices.InputMethodFramework
 * @since 20
 */
declare namespace inputMethod {
    /**
     * Input method setting
     *
     * @returns { InputMethodSetting } the object of InputMethodSetting.
     * @throws { BusinessError } 12800007 - input method setter error. Possible cause:
     *     create InputmethodSetting object failed.
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    function getSetting(): InputMethodSetting;
    /**
     * Input method controller
     *
     * @returns { InputMethodController } the object of InputMethodController.
     * @throws { BusinessError } 12800006 - input method controller error. Possible cause:
     *     create InputmethodController object failed.
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    function getController(): InputMethodController;
    /**
     * Get default input method
     *
     * @returns { InputMethodProperty } property of the default input method.
     * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
     *     a system error, such as null pointer, IPC exception.
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    function getDefaultInputMethod(): InputMethodProperty;
    /**
     * Get system input method config ability
     *
     * @returns { ElementName } the information of system input method config ability.
     * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
     *     a system error, such as null pointer, IPC exception.
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    function getSystemInputMethodConfigAbility(): ElementName;
    
    /**
     * Switch input method. The caller must be the current inputmethod.
     *
     * @param { InputMethodProperty } target - indicates the target input method.
     * @param { AsyncCallback<boolean> } callback - the callback of switchInputMethod.
     * @throws { BusinessError } 401 - parameter error. Possible causes:
     *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
     * @throws { BusinessError } 12800005 - configuration persistence error.
     * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
     *     a system error, such as null pointer, IPC exception.
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    function switchInputMethod(target: InputMethodProperty, callback: AsyncCallback<boolean>): void;
    
    /**
     * Switch input method. The caller must be the current inputmethod.
     *
     * @param { InputMethodProperty } target - indicates the target input method.
     * @returns { Promise<boolean> } the promise returned by the function.
     * @throws { BusinessError } 401 - parameter error. Possible causes:
     *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
     * @throws { BusinessError } 12800005 - configuration persistence error.
     * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
     *     a system error, such as null pointer, IPC exception.
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    function switchInputMethod(target: InputMethodProperty): Promise<boolean>;
    /**
     * Get current input method
     *
     * @returns { InputMethodProperty } the property of current inputmethod.
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    function getCurrentInputMethod(): InputMethodProperty;
    
    
    /**
     * Switch current input method subtype. The caller must be the current inputmethod.
     *
     * @param { InputMethodSubtype } target - indicates the target input method subtype.
     * @param { AsyncCallback<boolean> } callback - the callback of switchCurrentInputMethodSubtype.
     * @throws { BusinessError } 401 - parameter error. Possible causes:
     *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
     * @throws { BusinessError } 12800005 - configuration persistence error.
     * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
     *     a system error, such as null pointer, IPC exception.
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    function switchCurrentInputMethodSubtype(target: InputMethodSubtype, callback: AsyncCallback<boolean>): void;
    
    
    /**
     * Switch current input method subtype. The caller must be the current inputmethod.
     *
     * @param { InputMethodSubtype } target - indicates the target input method subtype.
     * @returns { Promise<boolean> } the promise returned by the function.
     * @throws { BusinessError } 401 - parameter error. Possible causes:
     *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
     * @throws { BusinessError } 12800005 - configuration persistence error.
     * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
     *     a system error, such as null pointer, IPC exception.
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    function switchCurrentInputMethodSubtype(target: InputMethodSubtype): Promise<boolean>;
    /**
     * Get the current input method subtype
     *
     * @returns { InputMethodSubtype } the subtype of the current input method.
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    function getCurrentInputMethodSubtype(): InputMethodSubtype;
    /**
     * Switch input method and subtype
     *
     * @permission ohos.permission.CONNECT_IME_ABILITY
     * @param { string } bundleName - indicates the bundleName of target input method.
     * @param { string } [subtypeId] - indicates the id of the input method subtype.
     *     If the param is not set, switch to the target input method with a default subtype.
     * @returns { Promise<void> } the promise returned by the function.
     * @throws { BusinessError } 201 - permissions check fails.
     * @throws { BusinessError } 202 - not system application.
     * @throws { BusinessError } 401 - parameter error. Possible causes:
     *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
     * @throws { BusinessError } 12800005 - configuration persistence error.
     * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
     *     a system error, such as null pointer, IPC exception.
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @systemapi
     * @since 20
     */
    function switchInputMethod(bundleName: string, subtypeId?: string): Promise<void>;
    /**
     * @interface InputMethodSetting
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    interface InputMethodSetting {
        /**
         * Subscribe input method or subtype change.
         *
         * @param { 'imeChange' } type - Indicates the event type.
         * @param { function } callback - the callback of 'imeChange'
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'imeChange', callback: (inputMethodProperty: InputMethodProperty, inputMethodSubtype: InputMethodSubtype) => void): void;
        /**
         * Unsubscribe input method or subtype change.
         *
         * @param { 'imeChange' } type - Indicates the event type.
         * @param { function } [callback] - the callback of 'imeChange',
         *        when subscriber unsubscribes all callback functions of event 'imeChange', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'imeChange', callback?: (inputMethodProperty: InputMethodProperty, inputMethodSubtype: InputMethodSubtype) => void): void;
        /**
         * Subscribes to input window show events.
         *
         * @param { 'imeShow' } type - Indicates the event type.
         * @param { function } callback - the callback of 'imeShow'.
         * @throws { BusinessError } 202 - not system application.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @systemapi
         * @since 20
         */
        on(type: 'imeShow', callback: (info: Array<InputWindowInfo>) => void): void;
        /**
         * Unsubscribe input window show event.
         *
         * @param { 'imeShow' } type - Indicates the event type.
         * @param { function } [callback] - the callback of 'imeShow',
         *        when subscriber unsubscribes all callback functions of event 'imeShow', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @systemapi
         * @since 20
         */
        off(type: 'imeShow', callback?: (info: Array<InputWindowInfo>) => void): void;
        /**
         * Subscribes to input window hidden events.
         *
         * @param { 'imeHide' } type - Indicates the event type.
         * @param { function } callback - the callback of 'imeHide'.
         * @throws { BusinessError } 202 - not system application.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @systemapi
         * @since 20
         */
        on(type: 'imeHide', callback: (info: Array<InputWindowInfo>) => void): void;
        /**
         * Unsubscribe input window hide event.
         *
         * @param { 'imeHide' } type - Indicates the event type.
         * @param { function } [callback] - the callback of 'imeHide',
         *        when subscriber unsubscribes all callback functions of event 'imeHide', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @systemapi
         * @since 20
         */
        off(type: 'imeHide', callback?: (info: Array<InputWindowInfo>) => void): void;
        /**
         * Query whether a panel with specified information is shown.
         *
         * @param { PanelInfo } panelInfo - the information of panel which is queried.
         * @returns { boolean }
         *     If true, the panel being queried is shown.
         *     If false, the panel being queried is hidden.
         * @throws { BusinessError } 202 - not system application.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @systemapi
         * @since 20
         */
        isPanelShown(panelInfo: PanelInfo): boolean;
        /**
         * List subtype of the specified input method.
         *
         * @param { InputMethodProperty } inputMethodProperty - the property of the specified inputmethod.
         * @param { AsyncCallback<Array<InputMethodSubtype>> } callback - the callback of listInputMethodSubtype.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800001 - bundle manager error.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        listInputMethodSubtype(inputMethodProperty: InputMethodProperty, callback: AsyncCallback<Array<InputMethodSubtype>>): void;
        /**
         * List subtype of the specified input method.
         *
         * @param { InputMethodProperty } inputMethodProperty - Indicates the specified input method.
         * @returns { Promise<Array<InputMethodSubtype>> } the promise returned by the function.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800001 - bundle manager error.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        listInputMethodSubtype(inputMethodProperty: InputMethodProperty): Promise<Array<InputMethodSubtype>>;
        /**
         * List subtype of current input method
         *
         * @param { AsyncCallback<Array<InputMethodSubtype>> } callback - the callback of listCurrentInputMethodSubtype.
         * @throws { BusinessError } 12800001 - bundle manager error.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        listCurrentInputMethodSubtype(callback: AsyncCallback<Array<InputMethodSubtype>>): void;
        /**
         * List subtype of current input method
         *
         * @returns { Promise<Array<InputMethodSubtype>> } the promise returned by the function.
         * @throws { BusinessError } 12800001 - bundle manager error.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        listCurrentInputMethodSubtype(): Promise<Array<InputMethodSubtype>>;
        /**
         * List input methods
         *
         * @param { boolean } enable -
         *     If true, collect enabled input methods.
         *     If false, collect disabled input methods.
         * @param { AsyncCallback<Array<InputMethodProperty>> } callback - the callback of getInputMethods.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
         * @throws { BusinessError } 12800001 - bundle manager error.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        getInputMethods(enable: boolean, callback: AsyncCallback<Array<InputMethodProperty>>): void;
        /**
         * List input methods
         *
         * @param { boolean } enable -
         *     If true, collect enabled input methods.
         *     If false, collect disabled input methods.
         * @returns { Promise<Array<InputMethodProperty>> } the promise returned by the function.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *      1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
         * @throws { BusinessError } 12800001 - bundle manager error.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        getInputMethods(enable: boolean): Promise<Array<InputMethodProperty>>;
        /**
         * List enabled or disabled input methods sync
         *
         * @param { boolean } enable -
         *     If true, collect enabled input methods.
         *     If false, collect disabled input methods.
         * @returns { Array<InputMethodProperty> } the list of inputmethod.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
         * @throws { BusinessError } 12800001 - bundle manager error.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        getInputMethodsSync(enable: boolean): Array<InputMethodProperty>;
        /**
         * List all input methods
         *
         * @param { AsyncCallback<Array<InputMethodProperty>> } callback - the callback of getInputMethods.
         * @throws { BusinessError } 12800001 - bundle manager error.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        getAllInputMethods(callback: AsyncCallback<Array<InputMethodProperty>>): void;
        /**
         * List all input methods
         *
         * @returns { Promise<Array<InputMethodProperty>> } the promise returned by the function.
         * @throws { BusinessError } 12800001 - bundle manager error.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        getAllInputMethods(): Promise<Array<InputMethodProperty>>;
        /**
         * List all input methods sync
         *
         * @returns { Array<InputMethodProperty> } the list of all inputmethod.
         * @throws { BusinessError } 12800001 - bundle manager error.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        getAllInputMethodsSync(): Array<InputMethodProperty>;
    }
    /**
     * @interface InputMethodController
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    interface InputMethodController {
        /**
         * Attach application to the input method service.
         *
         * @param { boolean } showKeyboard - show the keyboard or not when attach the input method.
         * @param { TextConfig } textConfig - indicates the config of the textInput.
         * @param { AsyncCallback<void> } callback - the callback of attach.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        attach(showKeyboard: boolean, textConfig: TextConfig, callback: AsyncCallback<void>): void;
        /**
         * Attach application to the input method service.
         *
         * @param { boolean } showKeyboard - show the keyboard or not when attach the input method.
         * @param { TextConfig } textConfig - indicates the config of the textInput.
         * @returns { Promise<void> } the promise returned by the function.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        attach(showKeyboard: boolean, textConfig: TextConfig): Promise<void>;
        /**
         * Attach application to the input method service.
         *
         * @param { boolean } showKeyboard - show the keyboard or not when attach the input method.
         * @param { TextConfig } textConfig - indicates the config of the textInput.
         * @param { RequestKeyboardReason } requestKeyboardReason - requestKeyboardReason of show the keyboard .
         * @returns { Promise<void> } the promise returned by the function.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        attach(showKeyboard: boolean, textConfig: TextConfig, requestKeyboardReason: RequestKeyboardReason): Promise<void>;
        /**
         * Show the text input and start typing.
         *
         * @param { AsyncCallback<void> } callback - the callback of showTextInput.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        showTextInput(callback: AsyncCallback<void>): void;
        /**
         * Show the text input and start typing.
         *
         * @returns { Promise<void> } the promise returned by the function.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        showTextInput(): Promise<void>;
        /**
         * Show the text input and start typing.
         *
         * @param { RequestKeyboardReason } requestKeyboardReason - requestKeyboardReason of show the keyboard .
         * @returns { Promise<void> } the promise returned by the function.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        showTextInput(requestKeyboardReason: RequestKeyboardReason): Promise<void>;
        /**
         * Hide the text input and stop typing.
         *
         * @param { AsyncCallback<void> } callback - the callback of hideTextInput.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        hideTextInput(callback: AsyncCallback<void>): void;
        /**
         * Hide the text input and stop typing.
         *
         * @returns { Promise<void> } the promise returned by the function.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        hideTextInput(): Promise<void>;
        /**
         * Detach the applications from the input method manager service.
         *
         * @param { AsyncCallback<void> } callback - the callback of detach.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        detach(callback: AsyncCallback<void>): void;
        /**
         * Detach the applications from the input method manager service.
         *
         * @returns { Promise<void> } the promise returned by the function.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        detach(): Promise<void>;
        /**
         * Hide soft keyboard.
         * This API can be called only by system applications.
         *
         * @permission ohos.permission.CONNECT_IME_ABILITY
         * @param { AsyncCallback<void> } callback - the callback of hideSoftKeyboard.
         * @throws { BusinessError } 201 - permissions check fails.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        hideSoftKeyboard(callback: AsyncCallback<void>): void;
        /**
         * Hide soft keyboard.
         * This API can be called only by system applications.
         *
         * @permission ohos.permission.CONNECT_IME_ABILITY
         * @returns { Promise<void> } the promise returned by the function.
         * @throws { BusinessError } 201 - permissions check fails.
         * @throws { BusinessError } 12800003 - input method client error. Possible causes:
         *     1.the edit box is not focused. 2.no edit box is bound to current input method application.
         * @throws { BusinessError } 12800008 - input method manager service error. Possible cause:
         *     a system error, such as null pointer, IPC exception.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        hideSoftKeyboard(): Promise<void>;
        /**
         * Register a callback and when IME sends select event with range of selection,
         * the callback will be invoked.
         *
         * @param { 'selectByRange' } type - event type, fixed as 'selectByRange'.
         * @param { Callback<Range> } callback - processes selectByRange command. The range of selection is provided for
         *        this callback, and subscribers are expected to select corresponding text in callback according to
         *        the range.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'selectByRange', callback: Callback<Range>): void;
        /**
         * Unregister the callback of selectedByRange.
         *
         * @param { 'selectByRange' } type - event type, fixed as 'selectByRange'.
         * @param { Callback<Range> } [callback] - the callback of 'selectByRange',
         *        when subscriber unsubscribes all callback functions of event 'selectByRange', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'selectByRange', callback?: Callback<Range>): void;
        /**
         * Register a callback and when IME sends select event witch movement of cursor,
         * the callback will be invoked.
         *
         * @param { 'selectByMovement' } type - event type, fixed as 'selectByMovement'.
         * @param { Callback<Movement> } callback - processes selectByMovement command. The movement of cursor is provided
         *        for this callback, and subscribers are expected to select corresponding text in callback according to
         *        the movement.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'selectByMovement', callback: Callback<Movement>): void;
        /**
         * Unregister the callback of selectedByMovement.
         *
         * @param { 'selectByMovement' } type - event type, fixed as 'selectByMovement'.
         * @param { Callback<Movement> } [callback] - the callback of 'selectByMovement',
         *        when subscriber unsubscribes all callback functions of event 'selectByMovement', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'selectByMovement', callback?: Callback<Movement>): void;
        /**
         * Register a callback and when IME sends insert text event, the callback will be invoked.
         *
         * @param { 'insertText' } type - event type, fixed as 'insertText'.
         * @param { function } callback - processes insertText command. The text of insert is provided for this callback.
         *        Subscribers are expected to process the inserted text and update changes in editor by changeSelection and updateCursor as needed.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'insertText', callback: (text: string) => void): void;
        /**
         * Unregister the callback of insertText.
         *
         * @param { 'insertText' } type - event type, fixed as 'insertText'.
         * @param { function } [callback] - the callback of 'insertText',
         *        when subscriber unsubscribes all callback functions of event 'insertText', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'insertText', callback?: (text: string) => void): void;
        /**
         * Register a callback and when IME sends delete left event with length,
         * the callback will be invoked.
         *
         * @param { 'deleteLeft' } type - event type, fixed as 'deleteLeft'.
         * @param { function } callback - processes deleteLeft command. The length of
         *     delete is provided for this callback. Subscribers are expected to delete specified length of text
         *     to the left of the cursor and update changes in editor by changeSelection and updateCursor as needed.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'deleteLeft', callback: (length: int) => void): void;
        /**
         * Unregister the callback of deleteLeft.
         *
         * @param { 'deleteLeft' } type - event type, fixed as 'deleteLeft'.
         * @param { function } [callback] - the callback of 'deleteLeft',
         *        when subscriber unsubscribes all callback functions of event 'deleteLeft', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'deleteLeft', callback?: (length: int) => void): void;
        /**
         * Register a callback and when IME sends delete right event with length,
         * the callback will be invoked.
         *
         * @param { 'deleteRight' } type - event type, fixed as 'deleteRight'.
         * @param { function } callback - processes deleteRight command. The length of
         *     delete is provided for this callback. Subscribers are expected to delete specified length of text
         *     to the right of the cursor and update changes in editor by changeSelection and updateCursor as needed.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'deleteRight', callback: (length: int) => void): void;
        /**
         * Unregister the callback of deleteRight.
         *
         * @param { 'deleteRight' } type - event type, fixed as 'deleteRight'.
         * @param { function } [callback] - the callback of 'deleteRight',
         *        when subscriber unsubscribes all callback functions of event 'deleteRight', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'deleteRight', callback?: (length: int) => void): void;
        /**
         * Register a callback and when IME sends keyboard status, the callback will be invoked.
         *
         * @param { 'sendKeyboardStatus' } type - event type, fixed as 'sendKeyboardStatus'.
         * @param { function } callback - processes sendKeyboardStatus command.
         *     The keyboardStatus is provided for this callback.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'sendKeyboardStatus', callback: (keyboardStatus: KeyboardStatus) => void): void;
        /**
         * Unregister the callback of sendKeyboardStatus.
         *
         * @param { 'sendKeyboardStatus' } type - event type, fixed as 'sendKeyboardStatus'.
         * @param { function } [callback] - the callback of 'sendKeyboardStatus',
         *        when subscriber unsubscribes all callback functions of event 'sendKeyboardStatus', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'sendKeyboardStatus', callback?: (keyboardStatus: KeyboardStatus) => void): void;
        /**
         * Register a callback and when IME sends functionKey, the callback will be invoked.
         *
         * @param { 'sendFunctionKey' } type - event type, fixed as 'sendFunctionKey'.
         * @param { function } callback - processes sendFunctionKey command.
         *     The functionKey is provided for this callback.Subscribers are expected to complete the
         *     corresponding task based on the value of functionKey.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'sendFunctionKey', callback: (functionKey: FunctionKey) => void): void;
        /**
         * Unregister the callback of sendFunctionKey.
         *
         * @param { 'sendFunctionKey' } type - event type, fixed as 'sendFunctionKey'.
         * @param { function } [callback] - the callback of 'sendFunctionKey',
         *        when subscriber unsubscribes all callback functions of event 'sendFunctionKey', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'sendFunctionKey', callback?: (functionKey: FunctionKey) => void): void;
        /**
         * Register a callback and when IME sends move cursor, the callback will be invoked.
         *
         * @param { 'moveCursor' } type - event type, fixed as 'moveCursor'.
         * @param { function } callback - processes moveCursor command. The direction of
         *     cursor is provided for this callback. Subscribers are expected to move the cursor and update changes
         *     in editor by changeSelection and updateCursor.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'moveCursor', callback: (direction: Direction) => void): void;
        /**
         * Unregister the callback of moveCursor.
         *
         * @param { 'moveCursor' } type - event type, fixed as 'moveCursor'.
         * @param { function } [callback] - the callback of 'moveCursor',
         *        when subscriber unsubscribes all callback functions of event 'moveCursor', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'moveCursor', callback?: (direction: Direction) => void): void;
        /**
         * Register a callback and when IME sends extend action code, the callback will be invoked.
         *
         * @param { 'handleExtendAction' } type - event type, fixed as 'handleExtendAction'.
         * @param { function } callback - processes handleExtendAction command. The action code
         *     is provided for this callback.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'handleExtendAction', callback: (action: ExtendAction) => void): void;
        /**
         * Unregister the callback of handleExtendAction.
         *
         * @param { 'handleExtendAction' } type - event type, fixed as 'handleExtendAction'.
         * @param { function } [callback] - the callback of 'handleExtendAction',
         *        when subscriber unsubscribes all callback functions of event 'handleExtendAction', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'handleExtendAction', callback?: (action: ExtendAction) => void): void;
        /**
         * Register a callback and when input method ability gets left text of cursor, the callback will be invoked.
         *
         * @param { 'getLeftTextOfCursor' } type - event type, fixed as 'getLeftTextOfCursor'.
         * @param { function } callback - processes getLeftTextOfCursor command. The callback
         *     must be a synchronization method and will block the input method application.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'getLeftTextOfCursor', callback: (length: int) => string): void;
        /**
         * Unregister the callback of getLeftTextOfCursor event.
         *
         * @param { 'getLeftTextOfCursor' } type - event type, fixed as 'getLeftTextOfCursor'.
         * @param { function } [callback] - the callback of 'getLeftTextOfCursor',
         *     when subscriber unsubscribes all callback functions of event 'getLeftTextOfCursor', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'getLeftTextOfCursor', callback?: (length: int) => string): void;
        /**
         * Register a callback and when input method ability gets right text of cursor, the callback will be invoked.
         *
         * @param { 'getRightTextOfCursor' } type - event type, fixed as 'getRightTextOfCursor'.
         * @param { function } callback - processes getRightTextOfCursor command. The callback
         *     must be a synchronization method and will block the input method application.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'getRightTextOfCursor', callback: (length: int) => string): void;
        /**
         * Unregister the callback of getRightTextOfCursor event.
         *
         * @param { 'getRightTextOfCursor' } type - event type, fixed as 'getRightTextOfCursor'.
         * @param { function } [callback] - the callback of 'getRightTextOfCursor',
         *     when subscriber unsubscribes all callback functions of event 'getRightTextOfCursor', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'getRightTextOfCursor', callback?: (length: int) => string): void;
        /**
         * Register a callback and when input method ability gets the text index at cursor, the callback will be invoked.
         *
         * @param { 'getTextIndexAtCursor' } type - event type, fixed as 'getTextIndexAtCursor'.
         * @param { function } callback - processes getTextIndexAtCursor command. The callback
         *     must be a synchronization method, and should return the text index at the cursor.
         * @throws { BusinessError } 401 - parameter error. Possible causes:
         *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
         * @throws { BusinessError } 12800009 - input method client detached.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        on(type: 'getTextIndexAtCursor', callback: () => int): void;
        /**
         * Unregister the callback of getTextIndexAtCursor.
         *
         * @param { 'getTextIndexAtCursor' } type - event type, fixed as 'getTextIndexAtCursor'.
         * @param { function } [callback] - the callback of 'getTextIndexAtCursor',
         *     when subscriber unsubscribes all callback functions of event 'getTextIndexAtCursor', this parameter can be left blank.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        off(type: 'getTextIndexAtCursor', callback?: () => int): void;
    }
    /**
     * input method property
     *
     * @interface InputMethodProperty
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    interface InputMethodProperty {
        /**
         * The name of input method
         *
         * @type { string }
         * @readonly
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        readonly name: string;
        /**
         * The id of input method
         *
         * @type { string }
         * @readonly
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        readonly id: string;
        /**
         * The label of input method
         *
         * @type { ?string }
         * @readonly
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        readonly label?: string;
        /**
         * The label id of input method
         *
         * @type { ?double }
         * @readonly
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        readonly labelId?: double;
        /**
         * The icon of input method
         *
         * @type { ?string }
         * @readonly
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        readonly icon?: string;
        /**
         * The icon id of input method
         *
         * @type { ?double }
         * @readonly
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        readonly iconId?: double;
    }
    /**
     * Enumerates the moving direction of cursor
     *
     * @enum { int }
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export enum Direction {
        /**
         * Cursor moves up
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        CURSOR_UP = 1,
        /**
         * Cursor moves down
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        CURSOR_DOWN,
        /**
         * Cursor moves left
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        CURSOR_LEFT,
        /**
         * Cursor moves right
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        CURSOR_RIGHT
    }
    /**
     * Range of selected text.
     *
     * @typedef Range
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export interface Range {
        /**
         * Indicates the index of the first character of the selected text.
         *
         * @type { int }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        start: int;
        /**
         * Indicates the index of the last character of the selected text.
         *
         * @type { int }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        end: int;
    }
    /**
     * Movement of cursor.
     *
     * @typedef Movement
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export interface Movement {
        /**
         * Indicates the direction of cursor movement
         *
         * @type { Direction }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        direction: Direction;
    }
    /**
     * Enumerates the text input type.
     *
     * @enum { int }
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export enum TextInputType {
        /**
         * The text input type is NONE.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        NONE = -1,
        /**
         * The text input type is TEXT.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        TEXT = 0,
        /**
         * The text input type is MULTILINE.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        MULTILINE,
        /**
         * The text input type is NUMBER.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        NUMBER,
        /**
         * The text input type is PHONE.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        PHONE,
        /**
         * The text input type is DATETIME.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        DATETIME,
        /**
         * The text input type is EMAIL_ADDRESS.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        EMAIL_ADDRESS,
        /**
         * The text input type is URL.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        URL,
        /**
         * The text input type is VISIBLE_PASSWORD.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        VISIBLE_PASSWORD,
        /**
         * The text input type is NUMBER_PASSWORD.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        NUMBER_PASSWORD
    }
    /**
     * Enumerates the enter key type.
     *
     * @enum { int }
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export enum EnterKeyType {
        /**
         * The enter key type is UNSPECIFIED.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        UNSPECIFIED = 0,
        /**
         * The enter key type is NONE.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        NONE,
        /**
         * The enter key type is GO.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        GO,
        /**
         * The enter key type is SEARCH.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        SEARCH,
        /**
         * The enter key type is SEND.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        SEND,
        /**
         * The enter key type is NEXT.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        NEXT,
        /**
         * The enter key type is DONE.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        DONE,
        /**
         * The enter key type is PREVIOUS.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        PREVIOUS,
        /**
       * The enter key type is NEWLINE.
       *
       * @syscap SystemCapability.MiscServices.InputMethodFramework
       * @since 20
       */
        NEWLINE
    }
    /**
     * Enumerates the keyboard status.
     *
     * @enum { int }
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export enum KeyboardStatus {
        /**
         * The keyboard status is none.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        NONE = 0,
        /**
         * The keyboard status is hide.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        HIDE = 1,
        /**
         * The keyboard status is show.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        SHOW = 2
    }
    /**
     * Attribute of Input.
     *
     * @typedef InputAttribute
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export interface InputAttribute {
        /**
         * Indicates the text input type of the input method.
         *
         * @type { TextInputType }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        textInputType: TextInputType;
        /**
         * Indicates the enter key type of the input method.
         *
         * @type { EnterKeyType }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        enterKeyType: EnterKeyType;
    }
    /**
     * FunctionKey of Input.
     *
     * @typedef FunctionKey
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export interface FunctionKey {
        /**
         * Indicates the enter key type of the input method.
         *
         * @type { EnterKeyType }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        enterKeyType: EnterKeyType;
    }
    /**
     * Information of Cursor.
     *
     * @typedef CursorInfo
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export interface CursorInfo {
        /**
         * Indicates the left point of the cursor info and must be absolute coordinate of the physical screen.
         *
         * @type { double }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        left: double;
        /**
         * Indicates the top point of the cursor info and must be absolute coordinate of the physical screen.
         *
         * @type { double }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        top: double;
        /**
         * Indicates the width point of the cursor info.
         *
         * @type { double }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        width: double;
        /**
         * Indicates the height point of the cursor info.
         *
         * @type { double }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        height: double;
    }
    /**
     * Config of editor.
     *
     * @typedef TextConfig
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export interface TextConfig {
        /**
         * Attribute of Input.
         *
         * @type { InputAttribute }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        inputAttribute: InputAttribute;
        /**
         * Cursor information.
         *
         * @type { ?CursorInfo }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        cursorInfo?: CursorInfo;
        /**
         * Selection information.
         *
         * @type { ?Range }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        selection?: Range;
        /**
         * The window ID of the application currently bound to the input method.
         *
         * @type { ?int }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        windowId?: int;
    }
    /**
     * Enumerates the extend action.
     *
     * @enum { int }
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export enum ExtendAction {
        /**
         * Select all text.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        SELECT_ALL = 0,
        /**
         * Cut selecting text.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        CUT = 3,
        /**
         * Copy selecting text.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        COPY = 4,
        /**
         * Paste from paste board.
         *
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        PASTE = 5
    }
    /**
     * Information of input window.
     *
     * @typedef InputWindowInfo
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export interface InputWindowInfo {
        /**
         * Indicates name of the input window.
         *
         * @type { string }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        name: string;
        /**
         * Indicates the abscissa of the upper-left vertex of input window.
         *
         * @type { int }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        left: int;
        /**
         * Indicates the ordinate of the upper-left vertex of input window.
         *
         * @type { int }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        top: int;
        /**
         * Indicates the width of the input window.
         *
         * @type { double }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        width: double;
        /**
         * Indicates the height of the input window.
         *
         * @type { double }
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        height: double;
    }
    /**
     *  requestKeyboardReason of input click
     *
     * @enum { int }
     * @syscap SystemCapability.MiscServices.InputMethodFramework
     * @since 20
     */
    export enum RequestKeyboardReason {
        /**
          * The request keyboard reason is NONE.
          * @syscap SystemCapability.MiscServices.InputMethodFramework
          * @since 20
          */
        NONE = 0,
        /**
         * The request keyboard reason is MOUSE.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        MOUSE = 1,
        /**
         * The request keyboard reason is TOUCH.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        TOUCH = 2,
        /**
         * The request keyboard reason is OTHER.
         * @syscap SystemCapability.MiscServices.InputMethodFramework
         * @since 20
         */
        OTHER = 20
    }
}
export default inputMethod;
