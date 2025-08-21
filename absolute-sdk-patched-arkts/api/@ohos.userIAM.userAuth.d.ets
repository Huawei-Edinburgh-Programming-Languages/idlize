/*
 * Copyright (c) 2023-2025 Huawei Device Co., Ltd.
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
 * @kit UserAuthenticationKit
 */
import Context from './application/Context';

/**
 * The userAuth module provides APIs for user authentication, which applies to scenarios such as device unlocking,
 * payment, and application login.
 *
 * @namespace userAuth
 * @syscap SystemCapability.UserIAM.UserAuth.Core
 * @since 20
 */
declare namespace userAuth {
    /**
     * Maximum reuse duration of the authentication result, in milliseconds. The value is 300000.
     *
     * @constant
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    const MAX_ALLOWABLE_REUSE_DURATION: int = 300000;
    
    /**
     * Enumerates the identity authentication types.
     *
     * @enum { int }
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    enum UserAuthType {
        
        /**
         * PIN authentication.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        PIN = 1,
        
        /**
         * Facial authentication.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        FACE = 2,
        
        /**
         * Fingerprint authentication.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        FINGERPRINT = 4,
        /**
         * Privacy password authentication.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        PRIVATE_PIN = 16
    }
    
    /**
     * Enumerates the trust levels of the authentication result.
     * For details about typical scenarios and examples, see Principles for Classifying Biometric
     * Authentication Trust Levels.
     *
     * @enum { int }
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    enum AuthTrustLevel {
        
        /**
         * Authentication trust level 1. The authentication of this level can identify individual users and provides
         * limited liveness detection capabilities. It is applicable to scenarios such as service risk control and
         * access to common personal data.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        ATL1 = 10000,
        
        /**
         * Authentication trust level 2. The authentication of this level can accurately identify individual users and
         * provides regular liveness detection capabilities. It is applicable to scenarios such as device unlocking
         * and application login.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        ATL2 = 20000,
        
        /**
         * Authentication trust level 3. The authentication of this level can accurately identify individual users and
         * provides strong liveness detection capabilities. It is applicable to scenarios such as device unlocking.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        ATL3 = 30000,
        
        /**
         * Authentication trust level 4. The authentication of this level can accurately identify individual users and
         * provides powerful liveness detection capabilities. It is applicable to scenarios such as small-amount payment.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        ATL4 = 40000
    }
    
    /**
     * Checks whether the specified authentication capability is supported.
     *
     * <p><strong>NOTE</strong>:
     * <br>Error code 12500005 is returned if the authentication executor is not registered and the specified
     * authentication capability is not supported.
     * <br>Error code 12500006 is returned if the authentication executor has been registered, the authentication
     * functionality is not disabled, but the authentication trust level is lower than that specified by the service.
     * <br>Error code 12500010 is returned if the authentication executor has been registered, the authentication
     * functionality is not disabled, but the user has not enrolled credential.
     * <br>Error code 12500013 is returned if the authentication executor has been registered, the authentication
     * functionality is not disabled, but the password has expired.
     * <br>If getAvailableStatus is called to check whether lock screen password authentication at ATL4 is supported
     * for a user who has enrolled a 4-digit PIN as the lock screen password (the authentication trust level is ATL3),
     * error code 12500010 will be returned.
     * </p>
     *
     * @permission ohos.permission.ACCESS_BIOMETRIC
     * @param { UserAuthType } authType - Authentication type. PIN is supported since API version 11.
     * @param { AuthTrustLevel } authTrustLevel - Authentication trust level.
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 401 - Incorrect parameters. Possible causes:
     * <br>1. Mandatory parameters are left unspecified.
     * @throws { BusinessError } 12500002 - General operation error.
     * @throws { BusinessError } 12500005 - The authentication type is not supported.
     * @throws { BusinessError } 12500006 - The authentication trust level is not supported.
     * @throws { BusinessError } 12500010 - The type of credential has not been enrolled.
     * @throws { BusinessError } 12500013 - Operation failed because of PIN expired.
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    function getAvailableStatus(authType: UserAuthType, authTrustLevel: AuthTrustLevel): void;
    /**
     * Represents the state of a credential enrolled.
     *
     * @typedef EnrolledState
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    interface EnrolledState {
        /**
         * Credential digest, which is randomly generated when a credential is added.
         *
         * @type { int }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        credentialDigest: int;
        /**
         * Number of enrolled credentials.
         *
         * @type { int }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        credentialCount: int;
    }
    /**
     * Obtains the credential state.
     *
     * @permission ohos.permission.ACCESS_BIOMETRIC
     * @param { UserAuthType } authType - Authentication type.
     * @returns { EnrolledState } Credential state obtained if the operation is successful.
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 401 - Incorrect parameters. Possible causes:
     * <br>1. Mandatory parameters are left unspecified.
     * @throws { BusinessError } 12500002 - General operation error.
     * @throws { BusinessError } 12500005 - The authentication type is not supported.
     * @throws { BusinessError } 12500010 - The type of credential has not been enrolled.
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    function getEnrolledState(authType: UserAuthType): EnrolledState;
    /**
     * Enumerates the window types of the authentication widget.
     *
     * @enum { int }
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    enum WindowModeType {
        /**
         * Window mode type is dialog box.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        DIALOG_BOX = 1,
        /**
         * Window mode type is full screen.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        FULLSCREEN = 2
    }
    /**
     * Enumerates the modes for reusing authentication results.
     *
     * @enum { int }
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    enum ReuseMode {
        /**
         * The device unlock authentication result can be reused within the validity period if the authentication type
         * matches any of the authentication types specified for this authentication.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        AUTH_TYPE_RELEVANT = 1,
        /**
         * The device unlock authentication result can be reused within the validity period regardless of the
         * authentication type.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        AUTH_TYPE_IRRELEVANT = 2,
        /**
         * Any identity authentication result (including device unlock authentication result) can be reused within the
         * validity period if the authentication type matches any of the authentication types specified for
         * this authentication.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        CALLER_IRRELEVANT_AUTH_TYPE_RELEVANT = 3,
        /**
         * Any identity authentication result (including device unlock authentication result) can be reused within the
         * validity period regardless of the authentication type.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        CALLER_IRRELEVANT_AUTH_TYPE_IRRELEVANT = 4
    }
    /**
     * Represents information about the authentication result reuse.
     *
     * <p><strong>NOTE</strong>:
     * <br>If the credential changes within the reuse duration after a successful identity authentication
     * (including device unlock authentication), the authentication result can still be reused and the actual
     * EnrolledState is returned in the authentication result.
     * <br>If the credential used for the previous authentication has been deleted when the authentication
     * result is used:
     * 1.If the deleted credential is face or fingerprint, the authentication result can still be reused, but
     * credentialCount and credentialDigest in the EnrolledState returned are both 0.
     * 2.If the deleted credential is a lock screen password, the reuse will fail.
     * </p>
     *
     * @typedef ReuseUnlockResult
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    interface ReuseUnlockResult {
        /**
         * Authentication result reuse mode.
         *
         * @type { ReuseMode }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        reuseMode: ReuseMode;
        /**
         * Period for which the authentication result can be reused. The value must be greater than 0 and less
         * than MAX_ALLOWABLE_REUSE_DURATION.
         *
         * @type { int }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        reuseDuration: int;
    }
    
    /**
     * Defines the user authentication parameters.
     *
     * @typedef AuthParam
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    interface AuthParam {
        
        /**
         * Random challenge value, which can be used to prevent replay attacks.
         * It cannot exceed 32 bytes and can be passed in Uint8Array([]) format.
         *
         * @type { Uint8Array }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        challenge: Uint8Array;
        
        /**
         * Authentication type list, which specifies the types of authentication provided on the user authentication page.
         *
         * @type { UserAuthType[] }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        authType: UserAuthType[];
        
        /**
         * Authentication trust level. For details, see Principles for Classifying Biometric Authentication Trust Levels.
         *
         * @type { AuthTrustLevel }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        authTrustLevel: AuthTrustLevel;
        /**
         * Information about the authentication result reuse.
         *
         * @type { ?ReuseUnlockResult }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        reuseUnlockResult?: ReuseUnlockResult;
        /**
         * ID of the user to be authenticated.
         *
         * @type { ?int }
         * @default The ID of the current user. The value is a positive integer greater than or equal to 0.
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        userId?: int;
    }
    
    /**
     * Represents the information presented on the user authentication page.
     *
     * @typedef WidgetParam
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    interface WidgetParam {
        
        /**
         * Title of the user authentication page. It cannot exceed 500 characters.
         *
         * @type { string }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        title: string;
        
        /**
         * Text on the navigation button. It cannot exceed 60 characters. It is supported in single fingerprint or facial
         * authentication before API version 18. Since API version 18, it is also supported in combined facial and
         * fingerprint authentication.
         *
         * @type { ?string }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        navigationButtonText?: string;
        /**
         * Display format of the user authentication page.
         *
         * @type { ?WindowModeType }
         * @default WindowModeType.DIALOG_BOX
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        windowMode?: WindowModeType;
        /**
         * Whether to display the authentication dialog box in modal application mode. This mode is applicable only
         * to 2-in-1 devices. If this mode is not used or other types of devices are used, the authentication dialog
         * box is displayed in modal system mode.
         *
         * @type { ?Context }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        uiContext?: Context;
    }
    
    /**
     * Represents the user authentication result. If the authentication is successful, the authentication type and token
     * information are returned.
     *
     * @typedef UserAuthResult
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    interface UserAuthResult {
        
        /**
         * User authentication result. If the authentication is successful, SUCCESS is returned. Otherwise, an error code
         * is returned. For details, see UserAuthResultCode.
         *
         * @type { int }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        result: int;
        
        /**
         * Authentication token information.
         *
         * @type { ?Uint8Array }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        token?: Uint8Array;
        
        /**
         * Authentication type.
         *
         * @type { ?UserAuthType }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        authType?: UserAuthType;
        /**
         * Credential state.
         *
         * @type { ?EnrolledState }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        enrolledState?: EnrolledState;
    }
    
    /**
     * Provides callbacks to return the authentication result.
     *
     * @interface IAuthCallback
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    interface IAuthCallback {
        /**
         * Called to return the authentication result. If the authentication is successful,
         * UserAuthResult contains the token information.
         *
         * @type { function }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        onResult: (result: UserAuthResult) => void;
    }
    
    /**
     * Provides APIs for user authentication. The user authentication widget is supported. Before using the APIs
     * of UserAuthInstance, you must obtain a UserAuthInstance instance by using getUserAuthInstance.
     *
     * @interface UserAuthInstance
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    interface UserAuthInstance {
        
        /**
         * Subscribes to the user authentication result.
         *
         * @param { 'result' } type - Event type. The value is result, which indicates the authentication result.
         * @param { IAuthCallback } callback - Callback used to return the user authentication result.
         * @throws { BusinessError } 401 - Incorrect parameters. Possible causes:
         * <br>1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * <br>3. Parameter verification failed.
         * @throws { BusinessError } 12500002 - General operation error.
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        on(type: 'result', callback: IAuthCallback): void;
        
        /**
         * Unsubscribes from the user authentication result.
         *
         * <p><strong>NOTE</strong>:
         * <br>The UserAuthInstance instance used to invoke this API must be the one used to subscribe to the event.
         * </p>
         *
         * @param { 'result' } type - Event type. The value is result, which indicates the authentication result.
         * @param { IAuthCallback } callback - Callback to unregister.
         * @throws { BusinessError } 401 - Incorrect parameters. Possible causes:
         * <br>1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * <br>3. Parameter verification failed.
         * @throws { BusinessError } 12500002 - General operation error.
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        off(type: 'result', callback?: IAuthCallback): void;
        
        
        /**
         * Starts authentication.
         *
         * <p><strong>NOTE</strong>:
         * <br>Each UserAuthInstance can be used for authentication only once.
         * <br>Starting from API version 20, only system applications can apply for the
         * ohos.permission.USER_AUTH_FROM_BACKGROUND permission.
         * </p>
         *
         * @permission ohos.permission.ACCESS_BIOMETRIC or ohos.permission.USER_AUTH_FROM_BACKGROUND
         * @throws { BusinessError } 201 - Permission verification failed. Possible causes:
         * <br>1. No permission to access biometric.
         * <br>2. No permission to start authentication from background.
         * @throws { BusinessError } 401 - Incorrect parameters. Possible causes:
         * <br>1. Incorrect parameter types.
         * @throws { BusinessError } 12500001 - Authentication failed.
         * @throws { BusinessError } 12500002 - General operation error.
         * @throws { BusinessError } 12500003 - Authentication canceled.
         * @throws { BusinessError } 12500004 - Authentication timeout.
         * @throws { BusinessError } 12500005 - The authentication type is not supported.
         * @throws { BusinessError } 12500006 - The authentication trust level is not supported.
         * @throws { BusinessError } 12500007 - Authentication service is busy.
         * @throws { BusinessError } 12500009 - Authentication is locked out.
         * @throws { BusinessError } 12500010 - The type of credential has not been enrolled.
         * @throws { BusinessError } 12500011 - Switched to the custom authentication process.
         * @throws { BusinessError } 12500013 - Operation failed because of PIN expired.
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        start(): void;
        
        /**
         * Cancels this authentication.
         *
         * <p><strong>NOTE</strong>:
         * <br>UserAuthInstance must be the instance being authenticated.
         * </p>
         *
         * @permission ohos.permission.ACCESS_BIOMETRIC
         * @throws { BusinessError } 201 - Permission verification failed.
         * @throws { BusinessError } 401 - Incorrect parameters. Possible causes:
         * <br>1. Incorrect parameter types.
         * @throws { BusinessError } 12500002 - General operation error.
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        cancel(): void;
    }
    
    /**
     * Obtains a UserAuthInstance instance for user authentication. The user authentication widget is also supported.
     *
     * <p><strong>NOTE</strong>:
     * <br>Each UserAuthInstance can be used for authentication only once.
     * </p>
     *
     * @param { AuthParam } authParam - Auth parameter.
     * @param { WidgetParam } widgetParam - Widget parameter.
     * @returns { UserAuthInstance } Returns an authentication instance with widget.
     * @throws { BusinessError } 401 - Incorrect parameters. Possible causes:
     * <br>1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * <br>3. Parameter verification failed.
     * @throws { BusinessError } 12500002 - General operation error.
     * @throws { BusinessError } 12500005 - The authentication type is not supported.
     * @throws { BusinessError } 12500006 - The authentication trust level is not supported.
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    function getUserAuthInstance(authParam: AuthParam, widgetParam: WidgetParam): UserAuthInstance;
    /**
     * Defines the type of the user authentication notification.
     *
     * @enum { int }
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    enum NoticeType {
        /**
         * Notification from the user authentication widget.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        WIDGET_NOTICE = 1
    }
    /**
     * Sends a notification from the user authentication widget.
     *
     * @permission ohos.permission.SUPPORT_USER_AUTH
     * @param { NoticeType } noticeType - Notification type.
     * @param { string } eventData - Event data. The data cannot exceed 65536 bytes.
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - Incorrect parameters. Possible causes:
     * <br>1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * <br>3. Parameter verification failed.
     * @throws { BusinessError } 12500002 - General operation error.
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function sendNotice(noticeType: NoticeType, eventData: string): void;
    
    /**
     * Enumerates the authentication result codes.
     *
     * @enum { int }
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @since 20
     */
    enum UserAuthResultCode {
        
        /**
         * The authentication is successful.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        SUCCESS = 12500000,
        
        /**
         * The authentication failed.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        FAIL = 12500001,
        
        /**
         * A general operation error occurred.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        GENERAL_ERROR = 12500002,
        
        /**
         * The authentication is canceled.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        CANCELED = 12500003,
        
        /**
         * The authentication has timed out.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        TIMEOUT = 12500004,
        
        /**
         * The authentication type is not supported.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        TYPE_NOT_SUPPORT = 12500005,
        
        /**
         * The authentication trust level is not supported.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        TRUST_LEVEL_NOT_SUPPORT = 12500006,
        
        /**
         * The system does not respond.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        BUSY = 12500007,
        
        /**
         * The authentication executor is locked.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        LOCKED = 12500009,
        
        /**
         * The user has not enrolled the specified system identity authentication credential.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        NOT_ENROLLED = 12500010,
        
        /**
         * The user cancels the system authentication and selects a custom authentication of the application.
         * The caller needs to launch the custom authentication page.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        CANCELED_FROM_WIDGET = 12500011,
        /**
         * The authentication failed because the lock screen password has expired.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @since 20
         */
        PIN_EXPIRED = 12500013,
        /**
         * The AuthToken is invalid.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        AUTH_TOKEN_CHECK_FAILED = 12500015,
        /**
         * The interval between the AuthToken issuance time and the AuthToken verification time exceeds
         * the maximum validity period.
         *
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        AUTH_TOKEN_EXPIRED = 12500016
    }
    /**
     * Provides APIs for managing the user authentication widget. You can use the APIs to register the user
     * authentication widget with UserAuthWidgetMgr for management and scheduling.
     *
     * @interface UserAuthWidgetMgr
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface UserAuthWidgetMgr {
        /**
         * Subscribes to commands from the user authentication framework for the user authentication widget.
         *
         * @param { 'command' } type - Event type. The vlaue is command, which indicates the command sent from the user
         * authentication framework to the user authentication widget.
         * @param { IAuthWidgetCallback } callback - Callback used to return the command from the user authentication
         * framework to the user authentication widget.
         * @throws { BusinessError } 401 - Incorrect parameters. Possible causes:
         * <br>1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * <br>3. Parameter verification failed.
         * @throws { BusinessError } 12500002 - General operation error.
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        on(type: 'command', callback: IAuthWidgetCallback): void;
        /**
         * Unsubscribes from commands sent from the user authentication framework.
         *
         * @param { 'command' } type - Event type. The value is command, which indicates the command sent from the user
         * authentication framework to the user authentication widget.
         * @param { IAuthWidgetCallback } callback - Callback to unregister.
         * @throws { BusinessError } 401 - Incorrect parameters. Possible causes:
         * <br>1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * <br>3. Parameter verification failed.
         * @throws { BusinessError } 12500002 - General operation error.
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        off(type: 'command', callback?: IAuthWidgetCallback): void;
    }
    /**
     * Obtains a UserAuthWidgetMgr instance for user authentication.
     *
     * <p><strong>NOTE</strong>:
     * <br>A UserAuthInstance instance can be used for an authentication only once.
     * </p>
     *
     * @permission ohos.permission.SUPPORT_USER_AUTH
     * @param { int } version - Version of the user authentication widget.
     * @returns { UserAuthWidgetMgr } UserAuthWidgetMgr instance obtained.
     * @throws { BusinessError } 201 - Permission verification failed.
     * @throws { BusinessError } 202 - The caller is not a system application.
     * @throws { BusinessError } 401 - Incorrect parameters. Possible causes:
     * <br>1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types.
     * @throws { BusinessError } 12500002 - General operation error.
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    function getUserAuthWidgetMgr(version: int): UserAuthWidgetMgr;
    /**
     * Provides the callback for returning the commands sent from the user authentication framework
     * to the user authentication widget.
     *
     * @interface IAuthWidgetCallback
     * @syscap SystemCapability.UserIAM.UserAuth.Core
     * @systemapi Hide this for inner system use.
     * @since 20
     */
    interface IAuthWidgetCallback {
        /**
         * Called to return the command sent from the user authentication framework to the user authentication widget.
         *
         * @type { function }
         * @syscap SystemCapability.UserIAM.UserAuth.Core
         * @systemapi Hide this for inner system use.
         * @since 20
         */
        sendCommand: (cmdData: string) => void;
    }
}
export default userAuth;
