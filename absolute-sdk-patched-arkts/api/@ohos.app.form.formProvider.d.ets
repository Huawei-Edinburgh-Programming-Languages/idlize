/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
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
 * @kit FormKit
 */
import { AsyncCallback } from './@ohos.base';
import formBindingData from './@ohos.app.form.formBindingData';
import Want from './@ohos.app.ability.Want';

/**
 * Interface of formProvider.
 *
 * @namespace formProvider
 * @syscap SystemCapability.Ability.Form
 * @since 20
 */
declare namespace formProvider {
    /**
     * Set next update time for a specified form.
     *
     * @param { string } formId - Indicates the form ID.
     * @param { int } minute - Indicates duration minute before next update.
     * @param { AsyncCallback<void> } callback - The callback of setFormNextRefreshTime.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
     * @throws { BusinessError } 16500050 - IPC connection error.
     * @throws { BusinessError } 16500060 - Service connection error.
     * @throws { BusinessError } 16500100 - Failed to obtain the configuration information.
     * @throws { BusinessError } 16501000 - An internal functional error occurred.
     * @throws { BusinessError } 16501001 - The ID of the form to be operated does not exist.
     * @throws { BusinessError } 16501002 - The number of forms exceeds the maximum allowed.
     * @throws { BusinessError } 16501003 - The form cannot be operated by the current application.
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    function setFormNextRefreshTimeWithCallback(formId: string, minute: int, callback: AsyncCallback<void>): void;
    /**
     * Set next update time for a specified form.
     *
     * @param { string } formId - Indicates the form ID.
     * @param { int } minute - Indicates duration minute before next update.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *     1.Mandatory parameters are left unspecified; 2.Incorrect parameter types; 3.Parameter verification failed.
     * @throws { BusinessError } 16500050 - IPC connection error.
     * @throws { BusinessError } 16500060 - Service connection error.
     * @throws { BusinessError } 16500100 - Failed to obtain the configuration information.
     * @throws { BusinessError } 16501000 - An internal functional error occurred.
     * @throws { BusinessError } 16501001 - The ID of the form to be operated does not exist.
     * @throws { BusinessError } 16501002 - The number of forms exceeds the maximum allowed.
     * @throws { BusinessError } 16501003 - The form cannot be operated by the current application.
     * @syscap SystemCapability.Ability.Form
     * @since 20
     */
    function setFormNextRefreshTimeReturnsPromise(formId: string, minute: int): Promise<void>;
    /**
     */
    overload setFormNextRefreshTime {
        setFormNextRefreshTimeWithCallback,
        setFormNextRefreshTimeReturnsPromise
    };
}
export default formProvider;
