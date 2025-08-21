/*
 * Copyright (c) 2024-2024 Huawei Device Co., Ltd.
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
 * @kit TelephonyKit
 */
import type { AsyncCallback } from './@ohos.base';
/**
 * This indicates that the eSIM card performs the profile management operation synchronously.
 * Includes methods defined by GSMA Spec (SGP.22) and customized methods.
 *
 * @namespace eSIM
 * @syscap SystemCapability.Telephony.CoreService.Esim
 * @since 20
 */
declare namespace eSIM {
    /**
     * Erase all specific profiles and reset the eUICC.
     *
     * @permission ohos.permission.SET_TELEPHONY_ESIM_STATE
     * @param { int } slotId - Indicates the card slot index number.
     * @param { ResetOption } [options] - Options for resetting eUICC memory.
     * @returns { Promise<ResultCode> } Returns the result of the reset operation.
     * @throws { BusinessError } 201 - Permission denied.
     * @throws { BusinessError } 202 - Non-system applications use system APIs.
     * @throws { BusinessError } 401 - Parameter error. Possible causes:
     *     1. Mandatory parameters are left unspecified.
     *     2. Incorrect parameter types.
     *     3. Parameter verification failed.
     * @throws { BusinessError } 801 - Capability not supported.
     * @throws { BusinessError } 3120001 - Service connection failed.
     * @throws { BusinessError } 3120002 - System internal error.
     * @syscap SystemCapability.Telephony.CoreService.Esim
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function resetMemory(slotId: int, options?: ResetOption): Promise<ResultCode>;
    /**
     * Options for resetting eUICC memory.
     *
     * @enum { int }
     * @syscap SystemCapability.Telephony.CoreService.Esim
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum ResetOption {
        /**
         * Deletes all operational profiles on reset.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DELETE_OPERATIONAL_PROFILES = 1,
        /**
         * Deletes all field-loaded testing profiles on reset.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DELETE_FIELD_LOADED_TEST_PROFILES = 1 << 1,
        /**
         * Resets the default SM-DP+ address on reset.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESET_DEFAULT_SMDP_ADDRESS = 1 << 2
    }
    /**
     * Result state.
     *
     * @enum { int }
     * @syscap SystemCapability.Telephony.CoreService.Esim
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    export enum ResultCode {
        /**
         * Indicates that the user must resolve a solvable error.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_SOLVABLE_ERRORS = -2,
        /**
         * Indicates that the active profile must be disabled to perform the operation.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_MUST_DISABLE_PROFILE = -1,
        /**
         * Operation succeeded.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_OK = 0,
        /**
         * Failed to obtain the EID.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_GET_EID_FAILED = 201,
        /**
         * The activation code is changed after the end user confirms the operation.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_ACTIVATION_CODE_CHANGED = 203,
        /**
         * The activation code is invalid.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_ACTIVATION_CODE_INVALID = 204,
        /**
         * The SM-DP+ server address is invalid.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_SMDP_ADDRESS_INVALID = 205,
        /**
         * Invalid eUICC information.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_EUICC_INFO_INVALID = 206,
        /**
         * TLS handshake fails.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_TLS_HANDSHAKE_FAILED = 207,
        /**
         * Certificate network connection error.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_CERTIFICATE_IO_ERROR = 208,
        /**
         * The certificate address is invalid or the response times out.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_CERTIFICATE_RESPONSE_TIMEOUT = 209,
        /**
         * Authentication fails.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_AUTHENTICATION_FAILED = 210,
        /**
         * HTTP response fails.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_RESPONSE_HTTP_FAILED = 211,
        /**
         * Incorrect confirmation code.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_CONFIRMATION_CODE_INCORRECT = 212,
        /**
         * The maximum number of confirmation code attempts is reached.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_EXCEEDED_CONFIRMATION_CODE_TRY_LIMIT = 213,
        /**
         * There is no profile on the server for download.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_NO_PROFILE_ON_SERVER = 214,
        /**
         * The transaction ID is invalid.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_TRANSACTION_ID_INVALID = 215,
        /**
         * The server address is invalid.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_SERVER_ADDRESS_INVALID = 216,
        /**
         * Failed to obtain the bound profile package.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_GET_BOUND_PROFILE_PACKAGE_FAILED = 217,
        /**
         * The download is canceled by the end user.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_USER_CANCEL_DOWNLOAD = 218,
        /**
         * The carrier server is unavailable.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_SERVER_UNAVAILABLE = 220,
        /**
         * The profile is attached to a non-delete profile policy rule.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_PROFILE_NON_DELETE = 223,
        /**
         * The authentication response server address does not match.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_SMDP_ADDRESS_INCORRECT = 226,
        /**
         * Failed to analyze the authentication server response.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_ANALYZE_AUTHENTICATION_SERVER_RESPONSE_FAILED = 228,
        /**
         * Failed to analyze the authentication client response.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_ANALYZE_AUTHENTICATION_CLIENT_RESPONSE_FAILED = 229,
        /**
         * Failed to analyze the authentication client response because the matching ID is rejected.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_ANALYZE_AUTHENTICATION_CLIENT_MATCHING_ID_REFUSED = 231,
        /**
         * Authentication stopped due to an error in the profile type.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_PROFILE_TYPE_ERROR_AUTHENTICATION_STOPPED = 233,
        /**
         * The carrier server refused errors of which the reason code is 3.8.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_CARRIER_SERVER_REFUSED_ERRORS = 249,
        /**
         * The certificate is invalid.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_CERTIFICATE_INVALID = 251,
        /**
         * Profile installation failed due to insufficient memory.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_OUT_OF_MEMORY = 263,
        /**
         * The profile policy rule prohibits this operation during download.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_PPR_FORBIDDEN = 268,
        /**
         * Nothing is to be deleted.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_NOTHING_TO_DELETE = 270,
        /**
         * The profile policy rule does not match.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_PPR_NOT_MATCH = 276,
        /**
         * A session is ongoing.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_CAT_BUSY = 283,
        /**
         * This eSIM profile is already in use or is invalid.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_PROFILE_EID_INVALID = 284,
        /**
         * Download times out.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_DOWNLOAD_TIMEOUT = 287,
        /**
         * Other errors defined in SGP.22.
         *
         * @syscap SystemCapability.Telephony.CoreService.Esim
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        RESULT_SGP_22_OTHER = 400
    }
}
export default eSIM;
