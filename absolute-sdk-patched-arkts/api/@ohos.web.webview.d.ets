/*
 * Copyright (c) 2021-2022 Huawei Device Co., Ltd.
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
 * @kit ArkWeb
 */
import { Resource } from './global/resource';
import { AsyncCallback, BusinessError } from './@ohos.base';
import { Callback } from './@ohos.base';
import type cert from './@ohos.security.cert';
import type image from './@ohos.multimedia.image';
import type print from './@ohos.print';
import { WebNetErrorList } from './@ohos.web.netErrorList';


/**
 * This module provides the capability to manage web modules.
 *
 * @namespace webview
 * @syscap SystemCapability.Web.Webview.Core
 * @since 20
 */
declare namespace webview {
    
    
    
    /**
     * Defines the Web's request/response header.
     *
     * @typedef WebHeader
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface WebHeader {
        
        
        /**
         * Gets the key of the request/response header.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        headerKey: string;
        
        
        /**
         * Gets the value of the request/response header.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        headerValue: string;
    }
    
    /**
     * Enum type supplied to {@link getHitTest} for indicating the cursor node HitTest.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum WebHitTestType {
        
        /**
         * The edit text.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        EditText,
        
        /**
         * The email address.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        Email,
        
        /**
         * The HTML::a tag with src=http.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        HttpAnchor,
        
        /**
         * The HTML::a tag with src=http + HTML::img.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        HttpAnchorImg,
        
        /**
         * The HTML::img tag.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        Img,
        
        /**
         * The map address.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        Map,
        
        /**
         * The phone number.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        Phone,
        
        /**
         * Other unknown HitTest.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        Unknown
    }
    
    /**
     * Defines the mode for using HttpDns.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum SecureDnsMode {
        
        /**
         * Do not use HttpDns, can be used to revoke previously used HttpDns configuration.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        OFF = 0,
        
        /**
         * By default, the user-settings of HttpDns is used for dns resolution, and if it fails,
         * the system dns is used for resolution.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        AUTO = 1,
        
        /**
         * Use the user-settings of HttpDns for dns resolution. If it fails, it will not
         * fall back to the system dns, which will directly cause the page to fail to load.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SECURE_ONLY = 2
    }
    /**
     * Defines the security level for the page.
     *
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum SecurityLevel {
        /**
         * Unable to determine whether it is safe or not, the non-http/https protocol used.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NONE = 0,
        /**
         * Indicates the HTTPS protocol used by the page and the authentication is successful.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SECURE = 1,
        /**
         * The page is insecure. For example, the HTTP protocol is used or the HTTPS protocol
         * is used but use an legacy TLS version.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        WARNING = 2,
        /**
         * Attempted HTTPS and failed, the authentication is failed.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        DANGEROUS = 3
    }
    /**
     * The playback status of all audio and video.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum MediaPlaybackState {
        /**
         * No audio or video currently.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NONE = 0,
        /**
         * The audio and video on the page are being played.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        PLAYING = 1,
        /**
         * The audio and video on the page are paused.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        PAUSED = 2,
        /**
         * The audio and video on the page are stopped.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        STOPPED = 3
    }
    /**
     * The memory pressure level that can be set.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum PressureLevel {
        /**
         * Modules are advised to free buffers that are cheap to re-allocate and not immediately needed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        MEMORY_PRESSURE_LEVEL_MODERATE = 1,
        /**
         * At this level, modules are advised to free all possible memory.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        MEMORY_PRESSURE_LEVEL_CRITICAL = 2
    }
    
    
    /**
     * Provides element information of the click area. related to {@link getLastHitTest} method.
     *
     * @typedef HitTestValue
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface HitTestValue {
        
        /**
         * Get the hit test type.
         *
         * @type { WebHitTestType }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        type: WebHitTestType;
        
        /**
         * Get the hit test extra data.
         * If the clicked area is an image or a link, the additional parameter information is it's URL address.
         *
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        extra: string;
    }
    
    
    /**
     * Defines the configuration of web custom scheme, related to {@link customizeSchemes} method.
     *
     * @typedef WebCustomScheme
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface WebCustomScheme {
        
        /**
         * Name of the custom scheme.
         *
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        schemeName: string;
        
        /**
         * Whether Cross-Origin Resource Sharing is supported.
         *
         * @type { boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isSupportCORS: boolean;
        
        /**
         * Whether fetch request is supported.
         *
         * @type { boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isSupportFetch: boolean;
        /**
         * If isStandard is true, the scheme will be handled as a standard scheme. The standard
         * schemes needs to comply with the URL normalization and parsing rules defined in Section 3.1 of RFC 1738,
         * which can be found in the http://www.ietf.org/rfc/rfc1738.txt.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isStandard?: boolean;
        /**
         * If isLocal is true, the same security rules as those applied to the "file" URL will be
         * used to handle the scheme.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isLocal?: boolean;
        /**
         * If isDisplayIsolated is true, then the scheme can only be displayed from other content
         * hosted using the same scheme.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isDisplayIsolated?: boolean;
        /**
         * If isSecure is true, the same security rules as those applied to the "https" URL will be
         * used to handle the scheme.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isSecure?: boolean;
        /**
         * If isCspBypassing is true, then this scheme can bypass Content Security Policy (CSP)
         * checks. In most cases, this value should not be true when isStandard is true.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isCspBypassing?: boolean;
        /**
         * If isCodeCacheSupported is true, then the js of this scheme can generate code cache.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isCodeCacheSupported?: boolean;
    }
    /**
     * Defines the callback of createPdf, related to {@link createPDF} method.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class PdfData {
        /**
         * Return the data stream generated by the webpage.
         *
         * @returns { Uint8Array } return pdf data.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        pdfArrayBuffer(): Uint8Array;
    }
    /**
     * Defines the configuration of creating pdf, related to {@Link createPdf} method.
     *
     * @typedef PdfConfiguration
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface PdfConfiguration {
        /**
         * Number of the width.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        width: double;
        /**
         * Number of the height.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        height: double;
        /**
         * Number of the marginTop.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        marginTop: double;
        /**
         * Number of the marginBottom.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        marginBottom: double;
        /**
         * Number of the marginRight.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        marginRight: double;
        /**
         * Number of the marginLeft.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        marginLeft: double;
        /**
         * Number of the scaling.
         *
         * @type { ?double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        scale?: double;
        /**
         * Whether background should be printed when creating pdf.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        shouldPrintBackground?: boolean;
    }
    
    
    
    /**
     * Provides basic information of web storage.
     *
     * @typedef WebStorageOrigin
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface WebStorageOrigin {
        
        
        /**
         * Url source.
         *
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        origin: string;
        
        
        /**
         * Specify the amount of storage for the source.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        usage: double;
        
        
        /**
         * the callback of getOriginUsage.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        quota: double;
    }
    /**
     * Defines the Web's request info.
     *
     * @typedef RequestInfo
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface RequestInfo {
        /**
         * Gets the url of the request.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        url: string;
        /**
         * Gets the method of the request.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        method: string;
        /**
         * Gets the form data of the request.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        formData: string;
    }
    /**
     * Defines the scroll offset of the webpage in view port, the unit is virtual pixel.
     * Related to {@link getScrollOffset} method.
     *
     * @typedef ScrollOffset
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface ScrollOffset {
        /**
         * Get the horizontal offset.
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        x: double;
        /**
         * Get the vertical offset.
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        y: double;
    }
    
    /**
     * Subscribe to a callback of a specified type of web event once.
     *
     * @param {string} type Types of web event.
     * @param {Callback<void>} callback Indicate callback used to receive the web event.
     *
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3.Parameter verification failed.
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    function once(type: string, callback: Callback<void>): void;
    
    
    /**
     * Implements a WebStorage object to manage the Web SQL database and HTML5 Web Storage APIs.
     * All Web components in an application share a WebStorage object.
     *
     * <p><strong>API Note</strong>:<br>
     * You must load the Web component before calling the APIs in WebStorage.
     * </p>
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebStorage {
        
        
        /**
         * Deletes all data in the Web SQL Database.
         *
         * @param { boolean } incognito - Whether to delete all data in the Web SQL Database in incognito mode.
         *                                {@code true} means to delete all data in the Web SQL Database in incognito mode;
         *                                {@code false} means to delete all data in the Web SQL Database in normal non-incognito mode.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static deleteAllData(incognito?: boolean): void;
        
        
        /**
         * Deletes all data in the specified origin.
         *
         * @param { string } origin - Index of the origin, which is obtained through {@link getOrigins}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100011 - Invalid origin.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static deleteOrigin(origin: string): void;
        
        
        /**
         * Obtains information about all origins that are currently using the Web SQL Database.
         * This API uses a promise to return the result.
         *
         * @returns { Promise<Array<WebStorageOrigin>> } - Promise used to return the information about the origins.
         *                                                 For details, see {@link WebStorageOrigin}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100012 - Invalid web storage origin.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getOrigins(): Promise<Array<WebStorageOrigin>>;
        
        
        /**
         * Obtains information about all origins that are currently using the Web SQL Database.
         * This API uses an asynchronous callback to return the result.
         *
         * @param { AsyncCallback<Array<WebStorageOrigin>> } callback - Callback used to return the information about the
         *                                                              origins. For details, see {@link WebStorageOrigin}.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100012 - Invalid web storage origin.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getOrigins(callback: AsyncCallback<Array<WebStorageOrigin>>): void;
        
        
        /**
         * Get the web storage quota with the origin.
         * @param { string } origin -  The origin which to be inquired.
         * @returns { Promise<double> } - the promise returned by the function
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100011 - Invalid origin.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getOriginQuota(origin: string): Promise<double>;
        
        
        /**
         * Get the web storage quota with the origin.
         * @param { string } origin -  The origin which to be inquired.
         * @param { AsyncCallback<double> } callback - the callback of getOriginQuota.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100011 - Invalid origin.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getOriginQuota(origin: string, callback: AsyncCallback<double>): void;
        
        
        /**
         * Get the web amount of storage with the origin.
         * @param { string } origin -  The origin which to be inquired.
         * @returns { Promise<double> } - the promise returned by the function
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100011 - Invalid origin.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getOriginUsage(origin: string): Promise<double>;
        
        
        /**
         * Get the web amount of storage with the origin.
         * @param { string } origin -  The origin which to be inquired.
         * @param { AsyncCallback<double> } callback - the callback of getOriginUsage.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100011 - Invalid origin.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getOriginUsage(origin: string, callback: AsyncCallback<double>): void;
    }
    
    /**
     * Implements a WebDataBase object.
     *
     * <p><strong>API Note</strong>:<br>
     * You must load the Web component before calling the APIs in WebDataBase.
     * </p>
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebDataBase {
        
        /**
         * Get whether instances holds any http authentication credentials.
         * @returns { boolean } true if instances saved any http authentication credentials otherwise false.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static existHttpAuthCredentials(): boolean;
        
        /**
         * Deletes all HTTP authentication credentials saved in the cache. This API returns the result synchronously.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static deleteHttpAuthCredentials(): void;
        
        /**
         * Get http authentication credentials.
         * @param { string } host - The host to which the credentials apply.
         * @param { string } realm - The realm to which the credentials apply.
         * @returns { Array<string> } Return an array containing username and password.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getHttpAuthCredentials(host: string, realm: string): Array<string>;
        
        /**
         * Saves HTTP authentication credentials for a given host and realm. This API returns the result synchronously.
         * @param { string } host - Host to which HTTP authentication credentials apply.
         * @param { string } realm - Realm to which HTTP authentication credentials apply.
         * @param { string } username - User name.
         * @param { string } password - Password.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static saveHttpAuthCredentials(host: string, realm: string, username: string, password: string): void;
    }
    
    
    /**
     * Implements a GeolocationPermissions object.
     *
     * <p><strong>API Note</strong>:<br>
     * You must load the Web component before calling the APIs in GeolocationPermissions.
     * </p>
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class GeolocationPermissions {
        
        
        /**
         * Allows the specified origin to use the geolocation information.
         * @param { string } origin - Index of the origin.
         * @param { boolean } incognito - Whether to allow the specified origin to use the geolocation information
         *                                in incognito mode. {@code true} means to allow the specified origin to use the
         *                                geolocation information in incognito mode; {@code false} means to allow the
         *                                specified origin to use the geolocation information in normal non-incognito mode.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100011 - Invalid origin.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static allowGeolocation(origin: string, incognito?: boolean): void;
        
        
        /**
         * Delete geolocation permissions for specifies source.
         * @param { string } origin - Url source.
         * @param { boolean } incognito - {@code true} delete geolocation permissions for specifies source
         *                                in incognito mode; {@code false} otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100011 - Invalid origin.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static deleteGeolocation(origin: string, incognito?: boolean): void;
        
        
        /**
         * Clears the geolocation permission status of all sources.
         * Delete all geolocation permissions.
         *
         * @param { boolean } incognito - Whether to clear the geolocation permission status of all sources in incognito
         *                                mode. {@code true} means to clear the geolocation permission status of
         *                                all sources in incognito mode; {@code false} means to clear the geolocation
         *                                permission status of all sources in normal non-incognito mode.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static deleteAllGeolocation(incognito?: boolean): void;
        
        
        /**
         * Gets the geolocation permission status of the specified source.
         * @param { string } origin - Url source.
         * @param { boolean } incognito - {@code true} gets the geolocation permission status of the
         *                                specified source in incognito mode; {@code false} otherwise.
         * @returns { Promise<boolean> } A Promise instance that obtains the permission
         *                               status of the specified source and obtains successfully,
         *                               true for authorization, false for access denial. Failed
         *                               to get, indicating that the permission status of the
         *                               specified source does not exist.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100011 - Invalid origin.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getAccessibleGeolocation(origin: string, incognito?: boolean): Promise<boolean>;
        
        
        /**
         * Gets the geolocation permission status of the specified source.
         * @param { string } origin - Url source.
         * @param { AsyncCallback<boolean> } callback - Returns the geolocation permission status for
         *                                              the specified source. Successful acquisition,
         *                                              true means authorized, false means access is
         *                                              denied. Failed to get, indicating that the
         *                                              permission status of the specified source does
         *                                              not exist.
         * @param { boolean } incognito - {@code true} gets the geolocation permission status of the
         *                                specified source in incognito mode; {@code false} otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100011 - Invalid origin.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getAccessibleGeolocation(origin: string, callback: AsyncCallback<boolean>, incognito?: boolean): void;
        
        
        /**
         * Get all stored geolocation permission url source.
         * @param { boolean } incognito - {@code true} get all stored geolocation permission url source
         *                                in incognito mode; {@code false} otherwise.
         * @returns { Promise<Array<string>> } A Promise instance that gets all source information about
         *                                     the stored geolocation permission state.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getStoredGeolocation(incognito?: boolean): Promise<Array<string>>;
        
        
        /**
         * Get all stored geolocation permission url source.
         * @param { AsyncCallback<Array<string>> } callback - Returns all source information for
         *                                                    stored geolocation permission states.
         * @param { boolean } incognito - {@code true} gets all stored geolocation permission url
         *                                source in incognito mode; {@code false} otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getStoredGeolocation(callback: AsyncCallback<Array<string>>, incognito?: boolean): void;
    }
    
    /**
     * Provides methods for managing the web cookies.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebCookieManager {
        /**
         * Gets all cookies for the given URL.
         *
         * @param { string } url - The URL for which the cookies are requested.
         * @param { boolean } incognito - {@code true} gets all cookies for the given URL
         *                                in incognito mode; {@code false} otherwise.
         * @returns { string } - The cookie value for the given URL.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100002 - URL error. No valid cookie found for the specified URL.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static fetchCookieSync(url: string, incognito?: boolean): string;
        /**
         * Gets all cookies for the given URL Asynchronously.
         *
         * @param { string } url - The URL for which the cookies are requested.
         * @returns { Promise<string> } - A promise resolved after the cookies of given URL have been gotten.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100002 - URL error. No valid cookie found for the specified URL.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static fetchCookie(url: string): Promise<string>;
        /**
        * Gets all cookies for the given URL Asynchronously.
        *
        * @param { string } url - The URL for which the cookies are requested.
        * @param { boolean } incognito - {@code true} gets all cookies for the given URL
        *                                in incognito mode; {@code false} otherwise.
        * @returns { Promise<string> } - A promise resolved after the cookies of given URL have been gotten.
        * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
        * <br>2. Incorrect parameter types.
        * @throws { BusinessError } 17100002 - URL error. No valid cookie found for the specified URL.
        * @syscap SystemCapability.Web.Webview.Core
        * @since 20
        */
        static fetchCookie(url: string, incognito: boolean): Promise<string>;
        /**
         * Gets all cookies for the given URL Asynchronously.
         *
         * @param { string } url - The URL for which the cookies are requested.
         * @param { AsyncCallback<string> } callback - Called after the cookies of given URL have been gotten.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100002 - URL error. No valid cookie found for the specified URL.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static fetchCookie(url: string, callback: AsyncCallback<string>): void;
        /**
         * Set a single cookie (key-value pair) for the given URL.
         *
         * @param { string } url - The URL for which the cookie is to be set.
         * @param { string } value - The cookie as a string, using the format of the 'Set-Cookie' HTTP response header.
         * @param { boolean } incognito - {@code true} set a single cookie (key-value pair) for the given URL
         *                                in incognito mode; {@code false} otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100002 - URL error. No valid cookie found for the specified URL.
         * @throws { BusinessError } 17100005 - The provided cookie value is invalid. It must follow the format specified
         * <br>in RFC 6265.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static configCookieSync(url: string, value: string, incognito?: boolean): void;
        /**
         * Set a single cookie (key-value pair) for the given URL.
         *
         * @param { string } url - The URL for which the cookie is to be set.
         * @param { string } value - The cookie as a string, using the format of the 'Set-Cookie' HTTP response header.
         * @param { boolean } incognito - {@code true} set a single cookie (key-value pair) for the given URL
         *                                in incognito mode; {@code false} otherwise.
         * @param { boolean } includeHttpOnly - {@code true} HTTP-only cookies can also be overwritten;
         *                                      {@code false} otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100002 - URL error. No valid cookie found for the specified URL.
         * @throws { BusinessError } 17100005 - The provided cookie value is invalid. It must follow the format specified
         * <br>in RFC 6265.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static configCookieSync(url: string, value: string, incognito: boolean, includeHttpOnly: boolean): void;
        /**
         * Set a single cookie (key-value pair) for the given URL Asynchronously.
         *
         * @param { string } url - The URL for which the cookie is to be set.
         * @param { string } value - The cookie as a string, using the format of the 'Set-Cookie' HTTP response header.
         * @returns { Promise<void> } - A promise resolved after the cookies of given URL have been set.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100002 - URL error. No valid cookie found for the specified URL.
         * @throws { BusinessError } 17100005 - The provided cookie value is invalid. It must follow the format specified
         * <br>in RFC 6265.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static configCookie(url: string, value: string): Promise<void>;
        /**
         * Set a single cookie (key-value pair) for the given URL Asynchronously.
         *
         * @param { string } url - The URL for which the cookie is to be set.
         * @param { string } value - The cookie as a string, using the format of the 'Set-Cookie' HTTP response header.
         * @param { boolean } incognito - {@code true} set a single cookie (key-value pair) for the given URL
         *                                in incognito mode; {@code false} otherwise.
         * @param { boolean } includeHttpOnly - {@code true} HTTP-only cookies can also be overwritten;
         *                                      {@code false} otherwise.
         * @returns { Promise<void> } - A promise resolved after the cookies of given URL have been set.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100002 - URL error. No valid cookie found for the specified URL.
         * @throws { BusinessError } 17100005 - The provided cookie value is invalid. It must follow the format specified
         * <br>in RFC 6265.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static configCookie(url: string, value: string, incognito: boolean, includeHttpOnly: boolean): Promise<void>;
        /**
         * Set a single cookie (key-value pair) for the given URL Asynchronously.
         *
         * @param { string } url - The URL for which the cookie is to be set.
         * @param { string } value - The cookie as a string, using the format of the 'Set-Cookie' HTTP response header.
         * @param { AsyncCallback<void> } callback - Called after the cookies have been set.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100002 - URL error. No valid cookie found for the specified URL.
         * @throws { BusinessError } 17100005 - The provided cookie value is invalid. It must follow the format specified
         * <br>in RFC 6265.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static configCookie(url: string, value: string, callback: AsyncCallback<void>): void;
        /**
         * Save the cookies synchronously.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static saveCookieSync(): void;
        
        /**
         * Save the cookies Asynchronously.
         * @returns { Promise<void> } - A promise resolved after the cookies have been saved.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static saveCookieAsync(): Promise<void>;
        
        /**
         * Save the cookies Asynchronously.
         * @param { AsyncCallback<void> } callback - Called after the cookies have been saved.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static saveCookieAsync(callback: AsyncCallback<void>): void;
        
        /**
         * Get whether the instance can send and accept cookies.
         *
         * @returns { boolean } True if the instance can send and accept cookies else false.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static isCookieAllowed(): boolean;
        
        /**
         * Set whether the instance should send and accept cookies.
         * By default this is set to be true.
         *
         * @param { boolean } accept - Whether the instance should send and accept cookies.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static putAcceptCookieEnabled(accept: boolean): void;
        
        /**
         * Get whether the instance can send and accept thirdparty cookies.
         *
         * @returns { boolean } True if the instance can send and accept thirdparty cookies else false.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static isThirdPartyCookieAllowed(): boolean;
        
        /**
         * Set whether the instance should send and accept thirdparty cookies.
         * By default this is set to be false.
         *
         * @param { boolean } accept - Whether the instance should send and accept thirdparty cookies.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static putAcceptThirdPartyCookieEnabled(accept: boolean): void;
        
        
        /**
         * Check whether exists any cookies.
         *
         * @param { boolean } incognito - {@code true} check whether exists any cookies.
         *                                in incognito mode; {@code false} otherwise.
         * @returns { boolean } True if exists more than one cookie else false;
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static existCookie(incognito?: boolean): boolean;
        /**
         * Remove all cookies.
         *
         * @param { boolean } incognito - {@code true} remove all cookies in incognito mode;
         *                                {@code false} otherwise.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static clearAllCookiesSync(incognito?: boolean): void;
        /**
         * Remove all cookies Asynchronously.
         * @returns { Promise<void> } - A promise resolved after the cookies have been deleted.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static clearAllCookies(): Promise<void>;
        /**
         * Remove all cookies Asynchronously.
         * @param { AsyncCallback<void> } callback - Called after the cookies have been deleted.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static clearAllCookies(callback: AsyncCallback<void>): void;
        /**
         * Delete the session cookies.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static clearSessionCookieSync(): void;
        /**
         * Delete the session cookies Asynchronously.
         * @returns { Promise<void> } - A promise resolved after the cookies have been deleted.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static clearSessionCookie(): Promise<void>;
        
        /**
         * Delete the session cookies Asynchronously.
         * @param { AsyncCallback<void> } callback - Called after the cookies have been deleted.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static clearSessionCookie(callback: AsyncCallback<void>): void;
    }
    
    
    /**
     * Enum type supplied to {@link onMessageEventExt} for indicating the type of web message.
     *
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum WebMessageType {
        
        /**
         * Unsupported data type.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NOT_SUPPORT,
        
        
        /**
         * The string data type.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        STRING,
        
        
        /**
         * The number data type.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NUMBER,
        
        
        /**
         * The boolean data type.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        BOOLEAN,
        
        /**
         * The arraybuffer data type.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        ARRAY_BUFFER,
        
        
        /**
         * The array data type.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        ARRAY,
        
        
        /**
         * The error data type.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        ERROR
    }
    
    
    /**
     * The message received or sent from web message port.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebMessageExt {
        
        
        /**
         * Get the type of the web message.
         * @returns { WebMessageType } - Returns data of WebMessageType type
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getType(): WebMessageType;
        
        
        /**
         * Get the string value of the web message.
         * @returns { string } - Returns data of string type
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getString(): string;
        
        
        /**
         * Get the number value of the web message.
         * @returns { number } - Returns data of number type
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getNumber(): number;
        
        
        /**
         * Get the boolean value of the web message.
         * @returns { boolean } - Returns data of Boolean type
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getBoolean(): boolean;
        
        /**
         * Get the array buffer value of the web message.
         * @returns { ArrayBuffer } - Returns data of ArrayBuffer type
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getArrayBuffer(): ArrayBuffer;
        
        
        /**
         * Get the array value of the web message.
         * @returns { Array<string | number | boolean> } - Returns data of Array type
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getArray(): Array<string | number | boolean>;
        
        
        /**
         * Get the error value of the web message.
         * @returns { Error } - Returns data of Error type
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getError(): Error;
        
        
        /**
         * Set the type of the web message.
         * @param { WebMessageType } type - set WebMessageType type data
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setType(type: WebMessageType): void;
        
        
        /**
         * Set the string value of the web message.
         * @param { string } message - set string type data
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setString(message: string): void;
        
        
        /**
         * Set the number value of the web message.
         * @param { number } message - set number type data
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setNumber(message: number): void;
        
        
        /**
         * Set the boolean value of the web message.
         * @param { boolean } message - set boolean type data
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setBoolean(message: boolean): void;
        
        /**
         * Set the array buffer value of the web message.
         * @param { ArrayBuffer } message - set ArrayBuffer type data
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setArrayBuffer(message: ArrayBuffer): void;
        
        
        /**
         * Set the array value of the web message.
         * @param { Array<string | number | boolean> } message - set Array type data
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setArray(message: Array<string | number | boolean>): void;
        
        
        /**
         * Set the error value of the web message.
         * @param { Error } message - set Error type data
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setError(message: Error): void;
    }
    
    /**
     * WebMessage type supplied to {@link onMessageEventExt} for indicating the type of web message.
     *
     * @typedef { ArrayBuffer | string }
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    type WebMessage = ArrayBuffer | string;
    
    
    /**
     * Define html web message port.
     * @typedef WebMessagePort
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface WebMessagePort {
        
        /**
         * The flag indicates whether more formats are supported than string and array buffers.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isExtentionType?: boolean;
        
        /**
         * Close port.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        close(): void;
        
        /**
         * Post a message to other port.
         * @param { WebMessage } message - Message to send.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100010 - Failed to post messages through the port.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        postMessageEvent(message: WebMessage): void;
        
        /**
         * Receive message from other port.
         * @param { function } callback - Callback function for receiving messages.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100006 - Failed to register a message event for the port.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        onMessageEvent(callback: (result: WebMessage) => void): void;
        
        
        /**
         * Post a message to other port.
         * @param { WebMessageExt } message - Message to send.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100010 - Failed to post messages through the port.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        postMessageEventExt(message: WebMessageExt): void;
        
        
        /**
         * Receive message from other port.
         * @param { function } callback - Callback function for receiving messages.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100006 - Failed to register a message event for the port.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        onMessageEventExt(callback: (result: WebMessageExt) => void): void;
    }
    
    
    /**
     * Provides information for history item in BackForwardList.
     * @typedef HistoryItem
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface HistoryItem {
        
        /**
         * Pixelmap of icon.
         * @type { image.PixelMap }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        icon: image.PixelMap;
        
        /**
         * Url of this history item.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        historyUrl: string;
        
        /**
         * Original request url of this history item.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        historyRawUrl: string;
        
        /**
         * Title of this history item.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        title: string;
    }
    
    
    /**
     * Provides back and forward history list information method. related to {@link HistoryItem}.
     * @typedef BackForwardList
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface BackForwardList {
        
        /**
         * Current index in BackForwardList.
         * @type { int }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        currentIndex: int;
        
        /**
         * Size of in BackForwardList.
         * @type { int }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        size: int;
        
        /**
         * Get history entry at given index.
         *
         * @param { int } index Index of back forward list entry.
         * @returns { HistoryItem } HistoryItem at given index in back forward list.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getItemAtIndex(index: int): HistoryItem;
    }
    /**
     * Defines the snapshot info.
     *
     * @typedef SnapshotInfo
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface SnapshotInfo {
        /**
         * Id of the snapshot.
         *
         * @type { ?string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        id?: string;
    }
    /**
     * Defines the snapshot result.
     *
     * @typedef SnapshotResult
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface SnapshotResult {
        /**
         * Id of the snapshot.
         *
         * @type { ?string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        id?: string;
        /**
         * The status of the snapshot.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        status?: boolean;
        /**
         * The image in PixelMap format.
         *
         * @type { ?image.PixelMap }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        imagePixelMap?: image.PixelMap;
    }
    
    
    /**
     * Enum type supplied to {@link runJavaScriptExt} for indicating the result of JavaScript code execution.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum JsMessageType {
        
        /**
         * Unsupported data type.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NOT_SUPPORT,
        
        
        /**
         * The string data type.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        STRING,
        
        
        /**
         * The number data type.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NUMBER,
        
        
        /**
         * The boolean data type.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        BOOLEAN,
        
        /**
         * The arraybuffer data type.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        ARRAY_BUFFER,
        
        
        /**
         * The array data type.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        ARRAY
    }
    
    
    /**
     * The message for indicating the of result of JavaScript code execution.
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class JsMessageExt {
        
        
        /**
         * Get the type of the JavaScript code execution result.
         * @returns { JsMessageType } - Returns data of JsMessageType type
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getType(): JsMessageType;
        
        
        /**
         * Get the string value of the JavaScript code execution result.
         * @returns { string } - Returns data of string type
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getString(): string;
        
        
        /**
         * Get the number value of the JavaScript code execution result.
         * @returns { number } - Returns data of number type
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getNumber(): number;
        
        
        /**
         * Get the boolean value of the JavaScript code execution result.
         * @returns { boolean } - Returns data of Boolean type
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getBoolean(): boolean;
        
        /**
         * Get the array buffer value of the JavaScript code execution result.
         * @returns { ArrayBuffer } - Returns data of ArrayBuffer
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getArrayBuffer(): ArrayBuffer;
        
        
        /**
         * Get the array value of the the JavaScript code execution result.
         * @returns { Array<string | number | boolean> } - Returns data of Array type
         * @throws { BusinessError } 17100014 - The type and value of the message do not match.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getArray(): Array<string | number | boolean>;
    }
    /**
     * Defines the render process mode.
     *
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum RenderProcessMode {
        /**
         * ArkWeb single rendering subprocess mode. In this mode, multiple Web pages reuse a rendering subprocess.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SINGLE = 0,
        /**
         * ArkWeb multi-rendering subprocess mode. In this mode, there is one rendering subprocess per Web.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        MULTIPLE
    }
    /**
     * Options of generating code cache
     * @typedef CacheOptions
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface CacheOptions {
        /**
         * Response headers used to configure the validation key of code cache.
         * Currently only support E-Tag and Last-Modified.
         *
         * @type { Array<WebHeader> }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        responseHeaders: Array<WebHeader>;
    }
    /**
     * Enum type supplied to {@link OfflineResourceMap} for indicating the type of resource.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum OfflineResourceType {
        /**
         * Resource of the image type.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        IMAGE,
        /**
         * Resource of the CSS type.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        CSS,
        /**
         * Javascript resource loaded through the <script src="" /> tag.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        CLASSIC_JS,
        /**
         * Javascript resource loaded through the <script src="" type="module" /> tag.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        MODULE_JS
    }
    /**
     * Define offline resource's content and info.
     * @typedef OfflineResourceMap
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface OfflineResourceMap {
        /**
         * Url list of resource. Url of urlList must be HTTP/HTTPS protocol and no longer than 2048.
         *
         * @type { Array<string> }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        urlList: Array<string>;
        /**
         * Arraybuffer of resource. Size must less than 10Mb and cannot be empty.
         *
         * @type { Uint8Array }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        resource: Uint8Array;
        /**
         * Response headers of resource.
         *
         * @type { Array<WebHeader> }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        responseHeaders: Array<WebHeader>;
        /**
         * Resource type
         *
         * @type { OfflineResourceType }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        type: OfflineResourceType;
    }
    /**
     * Enum type supplied to {@link setScrollable} for indicating the type of scroll.
     *
     * @enum { number }
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum ScrollType {
        /**
         * Indicates scrolling the web page through scroll event, include touch screen, touch pad, and mouse wheel.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        EVENT
    }
    
    
    /**
     * WebviewController can control various behaviors of Web components
     * (including page navigation, declaring cycle state, JavaScript interaction and so on).
     * A WebviewController object can only control one Web component,
     * and methods on the Webviewcontroller (except static methods) can only be called
     * after the web component is bound to the WebviewController.
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebviewController {
        /**
         * A constructor used to create a WebviewController object.
         *
         * @param { string } [webTag] - specified the name of the web component, Empty by default.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        constructor(webTag?: string);
        
        /**
         * Initialize the web engine before loading the Web components.
         * This is a global static API that must be called on the UI thread, and it will have no effect if any
         * Web components are loaded.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static initializeWebEngine(): void;
        
        /**
         * Set web engine to use HttpDns server to resolve dns.
         * @param { SecureDnsMode } secureDnsMode - using HttpDns.
         * @param { string } secureDnsConfig - The configuration of the HttpDns server.
         *                   Must be https protocol and only allow one server to be configured.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3. Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static setHttpDns(secureDnsMode: SecureDnsMode, secureDnsConfig: string): void;
        
        
        /**
         * Sets whether to enable web debugging. By default, web debugging is disabled.
         * For details, see Debugging Frontend Pages by Using DevTools.
         *
         * <p><strong>API Note</strong>:<br>
         * Enabling web debugging allows users to check and modify the internal status of the web page,
         * which poses security risks. Therefore, you are advised not to enable this function
         * in the officially released version of the app.
         * </p>
         *
         * @param { boolean } webDebuggingAccess - Sets whether to enable web debugging.{@code true} enable web debugging;
                                                   {@code false} disable web debugging. The default value is false.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static setWebDebuggingAccess(webDebuggingAccess: boolean): void;
        /**
         * Enable the ability to check website security risks.
         * Illegal and fraudulent websites are mandatory enabled and can't be disabled by this function.
         * @param { boolean } enable - {@code true} enable check the website security risks; {@code false} otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        enableSafeBrowsing(enable: boolean): void;
        /**
         * Get whether checking website security risks is enabled.
         * @returns { boolean } True if enable the ability to check website security risks else false.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isSafeBrowsingEnabled(): boolean;
        
        /**
         * Checks whether the web page can go forward.
         * @returns { boolean } True if the web page can go forward else false.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        accessForward(): boolean;
        
        /**
         * Checks whether the web page can go back.
         * @returns { boolean } True if the web page can go back else false.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        accessBackward(): boolean;
        
        /**
         * Checks whether the web page can go back or forward the given number of steps.
         *
         * @param { number } step - The number of steps.
         * @returns { boolean } True if the web page can go back else false.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        accessStep(step: number): boolean;
        
        /**
         * Goes forward in the history of the web page.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        forward(): void;
        
        /**
         * Goes back in the history of the web page.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        backward(): void;
        
        /**
         * Clears the history in the Web.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        clearHistory(): void;
        
        /**
         * Call this interface to notify the Web component to enter the foreground activation state.
         * The activation state is the state in which the application interacts with the user.
         * The application will remain in this state until something happens,
         * such as receiving an incoming call or closing the screen of the device,
         * to shift the focus away from the application.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        onActive(): void;
        
        /**
         * Call this interface to notify the Web component to enter the inactive state.
         * In this callback, the developer can realize the appropriate behavior when the application loses focus.
         * In this state, any content that can be safely paused will be paused as much as possible,
         * such as animation and geographical location. However, JavaScript will not be paused.
         * To pause JavaScript globally, please use {@link pauseAllTimers}.To reactivate the Web component, call onActive.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        onInactive(): void;
        
        /**
         * Refreshes the current URL.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        refresh(): void;
        
        /**
         * Loads the data or URL.
         *
         * @param { string } data - A string encoded according to "Base64" or "URL".
         * @param { string } mimeType - Media type. For example: "text/html".
         * @param { string } encoding - Encoding type. For example: "UTF-8".
         * @param { string } [baseUrl] - A specified URL path ("http"/"https"/"data" protocol),
         *                             which is assigned to window.origin by the Web component.
         * @param { string } [historyUrl] - History URL. When it is not empty, it can be managed by
         *                                history records to realize the back and forth function.
         *                                This property is invalid when baseUrl is empty.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        loadData(data: string, mimeType: string, encoding: string, baseUrl?: string, historyUrl?: string): void;
        
        
        /**
         * Loads the data or URL.
         *
         * @param { string | Resource } url - The URL to load.
         * @param { Array<WebHeader> } [headers] - Additional HTTP request header for URL.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 17100002 - URL error. The webpage corresponding to the URL is invalid, or the URL
         *                           length exceeds 2048.
         * @throws { BusinessError } 17100003 - Invalid resource path or file type.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        loadUrl(url: string | Resource, headers?: Array<WebHeader>): void;
        
        /**
         * Stores the current page as a web archive.
         *
         * @param { string } baseName - Where the generated offline webpage is stored, This value cannot be null.
         * @param { boolean } autoName - Decide whether to automatically generate the file name. If false, it is
         *                               stored by the file name of baseName. If true, the file name is
         *                               automatically generated based on the current URL and stored in the file
         *                               directory of baseName.
         * @returns { Promise<string> } a promise resolved after the web archive has been stored. The parameter
         *                              will either be the filename under which the file was stored, or empty
         *                              if storing the file failed.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3. Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 17100003 - Invalid resource path or file type.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        storeWebArchive(baseName: string, autoName: boolean): Promise<string>;
        
        /**
         * Stores the current page as a web archive.
         *
         * @param { string } baseName - Where the generated offline webpage is stored, This value cannot be null.
         * @param { boolean } autoName - Decide whether to automatically generate the file name. If false, it is
         *                               stored by the file name of baseName. If true, the file name is
         *                               automatically generated based on the current URL and stored in the file
         *                               directory of baseName.
         * @param { AsyncCallback<string> } callback - called after the web archive has been stored. The parameter
         *                                             will either be the filename under which the file was stored,
         *                                             or empty if storing the file failed.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3. Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 17100003 - Invalid resource path or file type.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        storeWebArchive(baseName: string, autoName: boolean, callback: AsyncCallback<string>): void;
        
        /**
         * Let the Web zoom by.
         *
         * <p><strong>API Note</strong>:<br>
         * zoomAccess must be true.
         * </p>
         *
         * @param { double } factor - The zoom factor.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 17100004 - Function not enabled.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        zoom(factor: double): void;
        
        
        /**
         * Let the Web zoom in.
         * Call this interface to enlarge the current page by 25%.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 17100004 - Function not enabled.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        zoomIn(): void;
        
        
        /**
         * Let the Web zoom out.
         * Call this interface to shrink the current page by 20%.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 17100004 - Function not enabled.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        zoomOut(): void;
        
        
        /**
         * Gets the index value of the current Web component for the management of multiple Web components.
         * @returns { int } Returns the index value of the current Web component.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getWebId(): int;
        
        /**
         * Gets the default user agent.
         * @returns { string } Return user agent information.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getUserAgent(): string;
        
        /**
         * Gets the title of current Web page.
         * @returns { string } Return to File Selector Title.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getTitle(): string;
        
        /**
         * Obtains the height of this web page.
         * @returns { int } Height of the current web page. Unit: vp.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getPageHeight(): int;
        
        /**
         * Goes forward or back backOrForward in the history of the web page.
         *
         * @param { number } step - Steps to go forward or backward.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        backOrForward(step: number): void;
        
        /**
         * Gets the request focus.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        requestFocus(): void;
        
        
        /**
         * Create web message ports
         * @param { boolean } isExtentionType - Set whether the web message port supports extention type.
         * @returns { Array<WebMessagePort> } An array represent 2 WebMessagePort, then can use
         *                                    those ports to communication with html pages.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        createWebMessagePorts(isExtentionType?: boolean): Array<WebMessagePort>;
        
        /**
         * Post web message port to html
         *
         * @param { string } name - Data name information to send.
         * @param { Array<WebMessagePort> } ports - Port number array information to send.
         * @param { string } uri - URI to receive this information.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        postMessage(name: string, ports: Array<WebMessagePort>, uri: string): void;
        
        /**
         * Stops the current load.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        stop(): void;
        
        
        
        /**
         * Registers the supplied ArkTS object into this Web component.
         * The object is registered into all frames of the web page, including all iframes, using the specified name.
         * This allows the methods of the ArkTS object to be accessed from JavaScript.
         * <p><strong>API Note</strong>:<br>
         * Registed objects will not appear in JavaScript until the page is next (re)load.
         * To avoid memory leaks, registerJavaScriptProxy must be used together with deleteJavaScriptProxy.
         * To avoid security risks, it is recommended that registerJavaScriptProxy be used with trusted web components.
         * If the same method is registered repeatedly in both synchronous and asynchronous list, it will default to an asynchronous method.
         * The synchronous function list and asynchronous function list cannot be empty at the same time.<br>
         * otherwise, this registration will fail.
         *  <p>
         *
         * @param { object } jsObject - Application side JavaScript objects participating in registration.
         * @param { string } name - The name of the registered object, which is consistent with the
         *                          object name called in the window.
         * @param { Array<string> } methodList - The method of the application side JavaScript object participating
         *                                       in the registration.
         * @param { Array<string> } [asyncMethodList] - The async method of the application side JavaScript object
         *                                            participating in the registration.
         * @param { string } [permission] - permission configuration defining web page URLs that can access JavaScriptProxy methods.
         *                                The configuration can be defined at two levels, object level and method level.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        registerJavaScriptProxy(jsObject: object, name: string, methodList: Array<string>, asyncMethodList?: Array<string>, permission?: string): void;
        
        
        /**
         * Deletes a registered JavaScript object with given name.
         *
         * @param { string } name - The name of a registered JavaScript object to be deleted.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 17100008 - Failed to delete JavaScriptProxy because it does not exist.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        deleteJavaScriptRegister(name: string): void;
        
        /**
         * Search all instances of 'searchString' on the page and highlights them,
         * result will be notify through callback onSearchResultReceive.
         *
         * @param { string } searchString - String to be search.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                         The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        searchAllAsync(searchString: string): void;
        
        /**
         * Clears the highlighting surrounding text matches created by searchAllAsync.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        clearMatches(): void;
        
        /**
         * Highlights and scrolls to the next match search.
         *
         * @param { boolean } forward - Step of search is back or forward.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        searchNext(forward: boolean): void;
        
        /**
         * Clears the ssl cache in the Web.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        clearSslCache(): void;
        
        /**
         * Clears the client authentication certificate cache in the Web.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        clearClientAuthenticationCache(): void;
        
        /**
         * Asynchronously execute JavaScript in the context of the currently displayed page.
         * The result of the script execution will be returned through a via Promise.
         * This method must be used on the UI thread, and the callback will also be invoked on the UI thread.
         * <p><strong>API Note</strong>:<br>
         * The state of JavaScript is no longer persisted across navigations like loadUrl.
         * For example, global variables and functions defined before calling loadUrl will not exist in the loaded page.<br>
         * It is recommended that applications use registerJavaScriptProxy to ensure that the JavaScript state can be persisted across page navigations.<br>
         * If you cannot obtain the return value by executing the asynchronous method,
         * you need to determine whether to use synchronous or asynchronous mode based on the specific situation.
         * <p>
         *
         * @param { string } script - JavaScript Script.
         * @returns { Promise<string> } A promise is solved after the JavaScript script is executed.
         *                              This parameter will be the result of JavaScript script execution.
         *                              If the JavaScript script fails to execute or has no return value,
         *                              null will be returned.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        runJavaScript(script: string): Promise<string>;
        
        /**
         * Asynchronously execute JavaScript in the context of the currently displayed page.
         * The result of the script execution will be returned through an asynchronous callback.
         * This method must be used on the UI thread, and the callback will also be invoked on the UI thread.
         * <p><strong>API Note</strong>:<br>
         * The state of JavaScript is no longer persisted across navigations like loadUrl.
         * For example, global variables and functions defined before calling loadUrl will not exist in the loaded page.
         * It is recommended that applications use registerJavaScriptProxy to ensure that the JavaScript state can be persisted across page navigations.
         * <p>
         *
         * @param { string } script - JavaScript Script.
         * @param { AsyncCallback<string> } callback - Callbacks execute JavaScript script results.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        runJavaScript(script: string, callback: AsyncCallback<string>): void;
        
        
        
        /**
        * Execute JavaScript code in the context of the currently displayed page, and return the result.
        *
        * @param { string | ArrayBuffer } script - JavaScript Script.
        * @returns { Promise<JsMessageExt> } A promise is solved after the JavaScript script is executed.
        *                              This parameter will be the result of JavaScript script execution.
        *                              If the JavaScript script fails to execute or has no return value,
        *                              a none type value will be returned.
        * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
        * <br>2. Incorrect parameter types. 3.Parameter verification failed.
        * @throws { BusinessError } 17100001 - Init error.
        *                           The WebviewController must be associated with a Web component.
        * @syscap SystemCapability.Web.Webview.Core
        * @since 20
        */
        runJavaScriptExt(script: string | ArrayBuffer): Promise<JsMessageExt>;
        
        
        
        /**
         * Execute JavaScript code in the context of the currently displayed page, and return the result.
         *
         * @param { string | ArrayBuffer } script - JavaScript Script.
         * @param { AsyncCallback<JsMessageExt> } callback - Callbacks execute JavaScript script results.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        runJavaScriptExt(script: string | ArrayBuffer, callback: AsyncCallback<JsMessageExt>): void;
        /**
         * Rendering current Web page into Pdf data, return the result in async mode.
         *
         * @param { PdfConfiguration } configuration - configuration for createPdf,
         *                                             including page width and height, etc.
         *                                             {@Link PdfConfiguration}
         * @param { AsyncCallback<PdfData> } callback - Callbacks execute createPdf results.
         *                                              PdfData is pdf data stream of current web page in Uint8Array
         *                                              {@Link PdfData}.
         * @throws { BusinessError } 401 - Invalid input parameter.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        createPdf(configuration: PdfConfiguration, callback: AsyncCallback<PdfData>): void;
        /**
         * Rendering current Web page into Pdf data, return the result in promise mode.
         *
         * @param { PdfConfiguration } configuration - configuration for createPdf,
         *                                             including page width and height, etc.
         *                                             {@Link PdfConfiguration}
         * @returns { Promise<PdfData> } The promise returned by the function.
         *                               PdfData is pdf data stream of current web page in Uint8Array
         *                               {@Link PdfData}.
         *                               If createPdf fails or no return value,
         *                               a none type value will be returned.
         * @throws { BusinessError } 401 - Invalid input parameter.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        createPdf(configuration: PdfConfiguration): Promise<PdfData>;
        
        /**
         * Gets the url of current Web page.
         * @returns { string } Return the url of the current page.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getUrl(): string;
        
        
        /**
         * Scroll the contents of this Webview up by half the view size.
         *
         * @param { boolean } top - Whether to jump to the top of the page, if set to false,
         *                          the page content will scroll up half the size of the viewframe,
         *                          and when set to true, it will jump to the top of the page.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        pageUp(top: boolean): void;
        
        
        /**
         * Scroll the contents of this Webview down by half the view size.
         *
         * @param { boolean } bottom - Whether to jump to the top of the page, if set to false,
         *                             the page content will scroll up half the size of the viewframe,
         *                             and when set to true, it will jump to the top of the page.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        pageDown(bottom: boolean): void;
        
        
        /**
         * Gets the original url of current Web page.
         * @returns { string } Return the original url of the current page.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getOriginalUrl(): string;
        
        /**
         * Gets the favicon of current Web page.
         * @returns { image.PixelMap } Return the favicon bitmap of the current page.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getFavicon(): image.PixelMap;
        
        /**
         * Put network state for web. Which is used to set window.navigator.onLine property in
         * JavaScript.
         * @param { boolean } enable - Whether enable window.navigator.onLine.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setNetworkAvailable(enable: boolean): void;
        
        /**
         * Asynchronous search for image existence on the current page through Promise method.
         *
         * @returns { Promise<boolean> } A promise resolved after query image has finished.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        hasImage(): Promise<boolean>;
        
        /**
         * Asynchronous search for the presence of an image on the current page through callback method.
         *
         * @param { AsyncCallback<boolean> } callback - Called after query image has finished.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        hasImage(callback: AsyncCallback<boolean>): void;
        
        /**
         * Get back forward stack list from current webview.
         * @returns { BackForwardList } Back forward list for current webview.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getBackForwardEntries(): BackForwardList;
        
        /**
         * Clears the cache in the application. This API will clear the cache for all webviews in the same application.
         *
         * <p><strong>API Note</strong>:<br>
         * You can view the Webview cache in the data/storage/el2/base/cache/web/Cache directory.
         * </p>
         *
         * @param { boolean } clearRom - Whether to clear the cache in the ROM and RAM at the same time.
         *                               {@code true} means to clear the cache in the ROM and RAM at the same time;
         *                               {@code false} means to only clear the cache in the RAM.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        removeCache(clearRom: boolean): void;
        /**
         * Remove resource cache in application. So this method will remove all cache for all web components in the
         * same application.
         *
         * @param { boolean } clearRom - Remove cache in both rom and ram if true. Otherwise only clear cache
         *                               in ram.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static removeAllCache(clearRom: boolean): void;
        
        
        /**
         * Scroll to the position.
         *
         * @param { double } x - the x of the position.Unit: vp.
         * @param { double } y - the y of the position.Unit: vp.
         * @param { int } duration - the scroll animation duration. Unit: millisecond.
         *                              If the value is not passed, or is negative or 0, there is no animation.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        scrollTo(x: double, y: double, duration?: int): void;
        
        
        /**
         * Scroll by the delta position.
         *
         * <p><strong>API Note</strong>:<br>
         * In nested scroll scenarios, calling scrollBy does not trigger nested scrolling in the parent component.
         * </p>
         *
         * @param { double } deltaX - the delta x of the position.Unit: vp.
         * @param { double } deltaY - the delta y of the position.Unit: vp.
         * @param { int } duration - the scroll animation duration. Unit: millisecond.
         *                              If the value is not passed, or is negative or 0, there is no animation.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        scrollBy(deltaX: double, deltaY: double, duration?: int): void;
        
        /**
         * Slide by the speed.
         *
         * @param { double } vx - the x speed of the speed.
         * @param { double } vy - the y speed of the speed.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        slideScroll(vx: double, vy: double): void;
        
        /**
         * Serialize the access stack of the web, that is, the history of access.
         * @returns { Uint8Array } Web access stack after serialization.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        serializeWebState(): Uint8Array;
        
        /**
         * Restoring the web access stack, that is, the history of access.
         * @param { Uint8Array } state - Web access stack after serialization.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        restoreWebState(state: Uint8Array): void;
        
        
        /**
         * Register Web custom schemes.
         * @param { Array<WebCustomScheme> } schemes - Configuration of web custom scheme.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100020 - Failed to register custom schemes.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static customizeSchemes(schemes: Array<WebCustomScheme>): void;
        
        /**
         * Get certificate for the current website.
         * @returns { Promise<Array<cert.X509Cert>> } the promise of the current website's certificate.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getCertificate(): Promise<Array<cert.X509Cert>>;
        
        /**
         * Get certificate for the current website.
         * @param {AsyncCallback<Array<cert.X509Cert>>} callback - the callback of getCertificate.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getCertificate(callback: AsyncCallback<Array<cert.X509Cert>>): void;
        
        /**
         * Set webpage mute.
         * @param { boolean } mute - Set the audio muted or not.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setAudioMuted(mute: boolean): void;
        
        /**
         * Prefetch the resources required by the page, but will not execute js or render the page.
         * @param { string } url - Which url to preresolve/preconnect.
         * @param { Array<WebHeader> } [additionalHeaders] - Additional HTTP request header of the URL.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 17100002 - URL error. The webpage corresponding to the URL is invalid, or the URL
         *                           length exceeds 2048.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        prefetchPage(url: string, additionalHeaders?: Array<WebHeader>): void;
        
        /**
         * Preresolve or Preconnect the url. This API can be called before loading the url to make loading faster.
         * @param { string } url - Which url to preresolve/preconnect.
         * @param { boolean } preconnectable - Indicates whether to preconnect.
         * @param { number } numSockets - If preconnectable is true, this parameter indicates the number of sockets to be preconnected.
         * @throws { BusinessError } 17100002 - URL error. The webpage corresponding to the URL is invalid, or the URL
         *                           length exceeds 2048.
         * @throws { BusinessError } 17100013 - The number of preconnect sockets is invalid.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static prepareForPageLoad(url: string, preconnectable: boolean, numSockets: number): void;
        
        /**
         * Set custom user agent.
         * @param { string } userAgent - User custom agent information.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setCustomUserAgent(userAgent: string): void;
        
        /**
         * Get custom user agent.
         * @returns { string } Get custom User agent information.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getCustomUserAgent(): string;
        /**
         * Set web engine socket connection timeout.
         * @param { number } timeout - Socket connection timeout.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3. Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static setConnectionTimeout(timeout: number): void;
        
        /**
         * Set delegate for download.
         * Used to notify the progress of the download triggered from web.
         * @param { WebDownloadDelegate } delegate - Delegate used for download triggered from web.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setDownloadDelegate(delegate: WebDownloadDelegate): void;
        
        /**
         * Start a download.
         * @param { string } url - The download url.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 17100002 - URL error. The webpage corresponding to the URL is invalid, or the URL
         *                           length exceeds 2048.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        startDownload(url: string): void;
        
        /**
         * Loads the URL use "POST" method with post data.
         *
         * @param { string } url - Request the URL use "POST" method.
         * @param { ArrayBuffer } postData - This data will passed to "POST" request.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 17100002 - URL error. The webpage corresponding to the URL is invalid, or the URL
         *                           length exceeds 2048.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        postUrl(url: string, postData: ArrayBuffer): void;
        /**
         * Creates a PrintDocumentAdapter instance to provide content for printing.
         * @param { string } jobName - Name of the file to print.
         * @returns { print.PrintDocumentAdapter } Return PrintDocumentAdapter instance created.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        createWebPrintDocumentAdapter(jobName: string): print.PrintDocumentAdapter;
        /**
         * Get the security level of the current page.
         *
         * @returns { SecurityLevel } the security level of current page.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getSecurityLevel(): SecurityLevel;
        /**
         * Whether the incognito mode is set.
         *
         * @returns { boolean } {@code true} has been set the incognito mode; {@code false} otherwise.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isIncognitoMode(): boolean;
        /**
         * Set whether scroll is allowed
         *
         * @param { boolean } enable - Set whether scrolling is allowed
         *                             {@code true} means scrolling is allowed.
         *                             {@code false} means scrolling is disabled.
         * @param { ScrollType } type - Enable scrolling type
         *                              When the input parameter enable is false, it indicates that scrolling of the ScrollType type is prohibited.When ScrollType
         *                              is not specified,it indicates that all types of webpage scrolling are prohibited.
         *                              When the input parameter enable is true, regardless of whether ScrollType is specified, it indicates that all types
         *                              of webpage scrolling are allowed.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setScrollable(enable: boolean, type?: ScrollType): void;
        /**
         * Get whether scrolling is allowed.
         * @returns { boolean } Get scrolling is allowed information.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getScrollable(): boolean;
        /**
         * Set whether print web page background.
         *
         * @param { boolean } enable - Set whether print web page background
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setPrintBackground(enable: boolean): void;
        /**
         * Get whether print web page background.
         * @returns { boolean } Get whether print web page background.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getPrintBackground(): boolean;
        /**
         * Get the url of the last frame that calls the JavaScriptProxy.
         * This should be called on the UI thread.
         *
         * @returns { string } The url of the last frame that calls the JavaScriptProxy.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getLastJavascriptProxyCallingFrameUrl(): string;
        /**
         * Start current camera.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        startCamera(): void;
        /**
         * Stop current camera.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        stopCamera(): void;
        /**
         * Close current camera.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        closeCamera(): void;
        /**
         * Pause all WebView timers.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static pauseAllTimers(): void;
        /**
         * Resume all timers suspended from the pauseAllTimers() interface.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static resumeAllTimers(): void;
        /**
         * Stop all audio and video playback on the web page.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        stopAllMedia(): void;
        /**
         * Resumes the playback of the audio and video that are paused by the pauseAllMedia interface.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        resumeAllMedia(): void;
        /**
         * Pause all audio and video playback on the web page.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        pauseAllMedia(): void;
        /**
         * Closes all full-screen videos on a web page.
         *
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        closeAllMediaPresentations(): void;
        /**
         * View the playback status of all audio and video on the web page.
         *
         * @returns { MediaPlaybackState } The playback status of all audio and video.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getMediaPlaybackState(): MediaPlaybackState;
        /**
         * Set web scheme handler for specific scheme. This is only used for related web component.
         *
         * @param { string } scheme - String value for url scheme.
         * @param { WebSchemeHandler } handler - Web scheme handler.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setWebSchemeHandler(scheme: string, handler: WebSchemeHandler): void;
        /**
         * Clear all web scheme handlers for related web component.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        clearWebSchemeHandler(): void;
        /**
         * Set web scheme handler for specific scheme. This is used for service worker.
         * @param { string } scheme - String value for url scheme.
         * @param { WebSchemeHandler } handler - Web scheme handler.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static setServiceWorkerWebSchemeHandler(scheme: string, handler: WebSchemeHandler): void;
        /**
         * Clear all web service worker scheme handlers.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static clearServiceWorkerWebSchemeHandler(): void;
        
        /**
         * Enable the ability to use Intelligent Tracking Prevention; default is disabled.
         *
         * @param { boolean } enable {@code true} enable Intelligent Tracking Prevention; {@code false} otherwise.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        enableIntelligentTrackingPrevention(enable: boolean): void;
        
        /**
         * Get whether Intelligent Tracking Prevention is enabled.
         *
         * @returns { boolean } True if enable the Intelligent Tracking Prevention; else false.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isIntelligentTrackingPreventionEnabled(): boolean;
        
        /**
         * Add bypassing hosts for Intelligent Tracking Prevention.
         *
         * @param { Array<string> } hostList - Hosts that bypass the Intelligent Tracking Prevention.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static addIntelligentTrackingPreventionBypassingList(hostList: Array<string>): void;
        
        /**
         * Remove bypassing hosts for Intelligent Tracking Prevention.
         *
         * @param { Array<string> } hostList - Hosts needs to remove from bypass list.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static removeIntelligentTrackingPreventionBypassingList(hostList: Array<string>): void;
        
        /**
         * Clear bypassing hosts for Intelligent Tracking Prevention.
         *
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static clearIntelligentTrackingPreventionBypassingList(): void;
        /**
         * Get the default user agent.
         *
         * @returns {string} The default user agent string.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getDefaultUserAgent(): string;
        /**
         * Register a callback to intercept web pages playing media.
         *
         * @param { CreateNativeMediaPlayerCallback } callback - Called everytime when web pages try to play media.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        onCreateNativeMediaPlayer(callback: CreateNativeMediaPlayerCallback): void;
        /**
         * Enables the full drawing capability for the web page.
         * This API works only during Web component initialization.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static enableWholeWebPageDrawing(): void;
        /**
         * Web page snapshot.
         *
         * <p><strong>API Note</strong>:<br>
         * Only screenshots of assets on the rendering process are supported: still images and text.
         * If there is a video on the page, the placeholder image of the video will be displayed when you take a screenshot,
         * and blank if there is no placeholder.
         * </p>
         *
         * @param { SnapshotInfo } info - The snapshot info.
         * @param { AsyncCallback<SnapshotResult> } callback - the callback of snapshot.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        webPageSnapshot(info: SnapshotInfo, callback: AsyncCallback<SnapshotResult>): void;
        /**
         * Prefetches resource requests based on specified request information and additional HTTP request headers,
         * saves the requests to the memory cache, and specifies the cache key and validity period to accelerate loading.
         * Currently, only POST requests whose Content-Type is application/x-www-form-urlencoded are supported.
         * A maximum of six POST requests can be pre-obtained. To prefetch the seventh post request,
         * call API{@link clearPrefetchedResource} to clear the cache of unnecessary post requests.
         * Otherwise, the cache of the earliest prefetched POST request will be automatically cleared.
         * To use the prefetched resource cache, you need to add the key value ArkWebPostCacheKey to the header of the POST request.
         * The content of the key value is the cacheKey of the corresponding cache.
         * @param { RequestInfo } request - The information of the request.
         * @param { Array<WebHeader> } [additionalHeaders] - Additional HTTP request header of the request.
         * @param { string } [cacheKey] - The key for memory cache. Default value is the url of the request.
         *    Only support number and letters.
         * @param { int } [cacheValidTime] - The valid time of the cache for request, ranges greater than 0.
         *    The unit is second. Default value is 300s.
         *    The value of cacheValidTime must between 1 and 2147483647.
         * @throws { BusinessError } 401 - Invalid input parameter.Possible causes: 1. Mandatory parameters are left unspecified.
         *    2. Incorrect parameter types. 3. Parameter verification failed.
         * @throws { BusinessError } 17100002 - URL error. The webpage corresponding to the URL is invalid, or the URL
         *                           length exceeds 2048.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static prefetchResource(request: RequestInfo, additionalHeaders?: Array<WebHeader>, cacheKey?: string, cacheValidTime?: int): void;
        /**
        * Clears the cache of prefetched resources based on the specified cache key list.
        * The cache key in the input parameter must be the prefetched resource cache key specified by API{@link prefetchResource}.
        * @param { Array<string> } cacheKeyList - The keys for memory cache.
        *    The key in cacheKeyList only support number and letters.
        * @syscap SystemCapability.Web.Webview.Core
        * @since 20
        */
        static clearPrefetchedResource(cacheKeyList: Array<string>): void;
        /**
         * Set render process mode of the ArkWeb.
         *
         * @param { RenderProcessMode } mode - The render process mode for the ArkWeb.
         *        Call {@link getRenderProcessMode} to get the ArkWeb rendering subprocess mode of the current device.
         *        The enumerated value **0** indicates the single render subprocess mode,
         *        and **1** indicates the multi-render subprocess mode.
         *        If an invalid number other than the enumerated value of **RenderProcessMode** is passed,
         *        the multi-render subprocess mode is used by default.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static setRenderProcessMode(mode: RenderProcessMode): void;
        /**
         * Get render process mode of the ArkWeb.
         *
         * @returns { RenderProcessMode } mode - The render process mode of the ArkWeb.
         *          Call {@link getRenderProcessMode} to get the ArkWeb rendering subprocess mode of the current device,
         *          with an enumeration value of 0 as a single subprocess mode and an enumeration value of 1 as a multi-subprocess mode.
         *          If the obtained value is not within the range of the RenderProcessMode enumeration value,
         *          it defaults to the multi-rendering subprocess mode.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static getRenderProcessMode(): RenderProcessMode;
        /**
         * Destroy the rendering process.
         * Calling this interface will actively destroy the associated rendering process.
         * If the rendering process has not been started or destroyed, it has no effect.
         * In addition, destroying the rendering process will also affect all other instances associated with
         * the rendering process.
         *
         * @returns { boolean } true if it was possible to terminate the render process, otherwise false.
         *         Calling this on a not yet started, or an already terminated render will have no effect.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        terminateRenderProcess(): boolean;
        /**
         * Compile javascript and generate code cache.
         * @param { string } url - Url of the javascript. Only support HTTP/HTTPS protocol and length no longer than 2048.
         * @param { string | Uint8Array } script - Javascript source code. script must not be empty.
         * @param { CacheOptions } cacheOptions - Generate code cache option.
         * @returns { Promise<int> } - The promise returned by the function.
         *    0 means generate code cache successfully, -1 means internal error.
         * @throws { BusinessError } 401 - Invalid input parameter.
         *    Possible causes: 1. Mandatory parameters are left unspecified.
         *    2. Incorrect parameter types. 3. Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *    The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        precompileJavaScript(url: string, script: string | Uint8Array, cacheOptions: CacheOptions): Promise<int>;
        /**
         * Set IP address for host name.
         *
         * @param { string } hostName - Which host name to be resolved.
         * @param { string } address - Resolved IP address.
         * @param { number } aliveTime - The validity seconds for resolve cache.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static setHostIP(hostName: string, address: string, aliveTime: number): void;
        /**
         * Clear the host name IP address.
         *
         * @param { string } hostName - Which host name to be cleared.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static clearHostIP(hostName: string): void;
        /**
         * Warmup the registered service worker associated the url.
         * @param { string } url - The url.
         * @throws { BusinessError } 17100002 - URL error. The webpage corresponding to the URL is invalid, or the URL
         *                           length exceeds 2048.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static warmupServiceWorker(url: string): void;
        /**
         * Inject offline resources into cache.
         *
         * @param { Array<OfflineResourceMap> } resourceMaps - Array of offline resource info maps.
         *    The count of array must between 1 and 30.
         * @throws { BusinessError } 401 - Invalid input parameter.
         *    Possible causes: 1. Mandatory parameters are left unspecified.
         *    2. Incorrect parameter types. 3. Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *    The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 17100002 - URL error. The webpage corresponding to the URL is invalid, or the URL
         *                           length exceeds 2048.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        injectOfflineResources(resourceMaps: Array<OfflineResourceMap>): void;
        
        /**
         * Enable the ability to block Ads, disabled by default.
         *
         * @param { boolean } enable {@code true} Enable Ads block; {@code false} otherwise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Parameter string is too long. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *     The WebviewController must be associated with a Web component.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        enableAdsBlock(enable: boolean): void;
        
        /**
         * Get whether Ads block is enabled.
         *
         * @returns { boolean } True if the ability of AdsBlock is enabled; else false.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isAdsBlockEnabled(): boolean;
        
        /**
         * Get whether Ads block is enabled for current Webpage.
         *
         * @returns { boolean } True if the ability of AdsBlock is enabled for current Webpage; else false.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isAdsBlockEnabledForCurPage(): boolean;
        /**
         * Get the ID of the surface created by ArkWeb. This ID can be used for web page screenshots.
         *
         * @returns { string } The ID of the surface created by ArkWeb.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getSurfaceId(): string;
        /**
         * Set the URL trust list for the ArkWeb.
         * When the URL trust list has been set, only the URLs in the list can be accessed.
         *
         * @param { string } urlTrustList - the URL trust list in JSON format.
         *     An empty string means that all URLs are allowed to access.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Parameter string is too long. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *     The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setUrlTrustList(urlTrustList: string): void;
        /**
         * Sets a path list. When a file protocol accesses resources in the path list, it can access the local files across
         * domains. In addition, when a path list is set, the file protocol can access only the resources in the path list.
         * The behavior of {@link fileAccess} will be overwritten by that of this API.
         *
         * The paths in the list must be any of the following(sub path and module name must be provided):
         *
         * 1. The path of subdirectory of the application file directory, like "/data/storage/el2/base/files/example"
         *    or "/data/storage/el2/base/haps/entry/files/example".
         *    The application file directory is obtained using Context.filesDir in the Ability Kit.
         * 2. The path of application resource directory or its subdirectory, like "/data/storage/el1/bundle/entry/resource/resfile"
         *    or "/data/storage/el1/bundle/entry/resource/resfile/example".
         *    The application resource directory is obtained from Context.resourceDir in the Ability Kit.
         *
         * If a path in the list is not of the preceding paths, error code 401 is reported and the path list fails
         * to be set. When the path list is set to empty, the accessible files for the file protocol are subject to
         * the behavior of the {@link fileAccess}.
         *
         * @param { Array<string> } pathList - The path list allow universal access.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Parameter string is too long. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *     The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setPathAllowingUniversalAccess(pathList: Array<string>): void;
        /**
         * Trim memory by different memory pressure level.
         *
         * @param { PressureLevel } level - The memory pressure level for the ArkWeb.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Parameter string is too long. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static trimMemoryByPressureLevel(level: PressureLevel): void;
        /**
         * Enable the BackForwardCache and indicate features that are allowed to enter BackForwardCache.
         * Default is disabled.
         *
         * @param { BackForwardCacheSupportedFeatures } [features] - The features that supports BackForwardCache.
         * @static
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static enableBackForwardCache(features?: BackForwardCacheSupportedFeatures): void;
        /**
         * Configure the BackForwardCache.
         *
         * @param { BackForwardCacheOptions } [options] - The configuration of BackForwardCache.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setBackForwardCacheOptions(options?: BackForwardCacheOptions): void;
        /**
         * Get the scroll offset of the webpage in view port, the coordinates of the top left corner of the view port are X: 0, Y: 0.
         * And the unit is virtual pixel.
         *
         * @returns { ScrollOffset } scroll offset
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getScrollOffset(): ScrollOffset;
        /**
         * Scrolls by the specified delta position and returns a result indicating whether the scrolling operation was successful or not.
         *
         * @param { double } deltaX - the delta x of the position.
         * @param { double } deltaY - the delta y of the position.
         * @returns { boolean } true if the scroll operation is successful, otherwise false.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        scrollByWithResult(deltaX: double, deltaY: double): boolean;
        /**
         * Gets the last hit test value of HitTest.
         * @returns { HitTestValue } Return the element information of the clicked area.
         * @throws { BusinessError } 17100001 - Init error.
         *                           The WebviewController must be associated with a Web component.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getLastHitTest(): HitTestValue;
        /**
         * Enables debugging of web contents.
         * <p><strong>API Note</strong>:<br>
         * The port numbers from 0 to 1024 are prohibited. Ports less than 0 or greater than 65535 are considered invalid.
         * If an attempt is made to set these disabled or invalid ports, an exception will be thrown.
         * </p>
         *
         * @param { boolean } webDebuggingAccess {@code true} enables debugging of web contents; {@code false} otherwise.
         * @param { number } port Indicates the port of the devtools server. After the port is specified, a tcp server
         * socket is created instead of a unix domain socket.
         * @throws { BusinessError } 17100023 - The port number is not within the allowed range.
         * @static
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static setWebDebuggingAccess(webDebuggingAccess: boolean, port: number): void;
    }
    
    /**
     * Defines the state for download.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum WebDownloadState {
        
        /**
         * The web download is in progress.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        IN_PROGRESS = 0,
        
        /**
         * The web download has been completed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        COMPLETED,
        
        /**
         * The web download was canceled.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        CANCELED,
        
        /**
         * The web download was interrupted.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        INTERRUPTED,
        
        /**
         * The web download is pending.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        PENDING,
        
        /**
         * The web download has been paused.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        PAUSED,
        
        /**
         * Unknown state.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        UNKNOWN
    }
    
    /**
     * Defines the error code for download.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum WebDownloadErrorCode {
        /**
         * Unknown error.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        ERROR_UNKNOWN = 0,
        /**
         * Generic file operation failure.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FILE_FAILED = 1,
        /**
         * The file cannot be accessed due to certain restrictions.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FILE_ACCESS_DENIED = 2,
        /**
         * There is not enough disk space.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FILE_NO_SPACE = 3,
        /**
         * The file name is too long.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FILE_NAME_TOO_LONG = 5,
        /**
         * The file is too large.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FILE_TOO_LARGE = 6,
        /**
         * Some temporary problems occurred, such as not enough memory, files in use, and too many files open at the same time.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FILE_TRANSIENT_ERROR = 10,
        /**
         * The file is blocked from accessing because of some local policy.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FILE_BLOCKED = 11,
        /**
         * When trying to resume the download, Found that the file is not long enough, maybe the file no longer exists.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FILE_TOO_SHORT = 13,
        /**
         * Hash mismatch.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FILE_HASH_MISMATCH = 14,
        /**
         * The file already exists.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FILE_SAME_AS_SOURCE = 15,
        /**
         * Generic network error.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NETWORK_FAILED = 20,
        /**
         * The network operation timed out.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NETWORK_TIMEOUT = 21,
        /**
         * The network was disconnected.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NETWORK_DISCONNECTED = 22,
        /**
         * Server down.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NETWORK_SERVER_DOWN = 23,
        /**
         * Invalid network requests，may redirect to unsupported scheme or an invalid URL.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NETWORK_INVALID_REQUEST = 24,
        /**
         * The server returned a generic error.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SERVER_FAILED = 30,
        /**
         * The server does not support range requests.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SERVER_NO_RANGE = 31,
        /**
         * The server does not have the requested data.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SERVER_BAD_CONTENT = 33,
        /**
         * The server does not allow the file to be downloaded.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SERVER_UNAUTHORIZED = 34,
        /**
         * Server certificate error.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SERVER_CERT_PROBLEM = 35,
        /**
         * Server access forbidden.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SERVER_FORBIDDEN = 36,
        /**
         * Server unreachable.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SERVER_UNREACHABLE = 37,
        /**
         * The received data does not match content-length.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SERVER_CONTENT_LENGTH_MISMATCH = 38,
        /**
         * An unexpected cross-origin redirect happened.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SERVER_CROSS_ORIGIN_REDIRECT = 39,
        
        /**
         * User cancel.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        USER_CANCELED = 40,
        /**
         * User shut down the application.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        USER_SHUTDOWN = 41,
        /**
         * Application crash.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        CRASH = 50
    }
    
    /**
     * Represents a download task, You can use this object to operate the corresponding download task.
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebDownloadItem {
        
        /**
        * Get guid.
        * @returns { string } - Returns the download's guid.
        * @syscap SystemCapability.Web.Webview.Core
        * @since 20
        */
        getGuid(): string;
        
        /**
         * Get current speed, in bytes per second.
         * @returns { number } - Returns the current download speed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getCurrentSpeed(): number;
        
        /**
         * Get percent complete.
         * @returns { number } - Returns -1 if progress is unknown. 100 if the download is already complete.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getPercentComplete(): number;
        
        /**
         * Get total bytes.
         * @returns { number } - Returns the total bytes received, -1 if the total size is unknown.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getTotalBytes(): number;
        
        /**
         * Get state of the web download.
         * @returns { WebDownloadState } - Returns the current download state.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getState(): WebDownloadState;
        
        /**
         * Get last error code of the web download.
         * @returns { WebDownloadErrorCode } - Returns the last error code.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getLastErrorCode(): WebDownloadErrorCode;
        
        /**
         * Get http method of the web download request.
         * @returns { string } - Returns the http request method.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getMethod(): string;
        
        /**
         * Get mime type of the web download.
         * @returns { string } - Returns the mimetype.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getMimeType(): string;
        
        /**
         * Get url of the web download request.
         * @returns { string } - Returns the url.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getUrl(): string;
        
        /**
         * Get suggested file name of the web download request.
         * @returns { string } - Returns the suggested file name.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getSuggestedFileName(): string;
        
        /**
         * Start the web download.
         * Used in onBeforeDownload, If you want to start the current download, call this function.
         * @param { string } downloadPath - The content will be downloaded to this file.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types.
         * <br>2. Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        start(downloadPath: string): void;
        
        /**
         * Cancel the web download.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        cancel(): void;
        
        /**
         * Pause the web download.
         * @throws { BusinessError } 17100019 - The download task is not started yet.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        pause(): void;
        
        /**
         * Resume the web download.
         * Use WebDownloadManager.resumeDownload to resume deserialized downloads.
         * WebDownloadItem.resume is only used to resume the currently paused download.
         * @throws { BusinessError } 17100016 - The download task is not paused.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        resume(): void;
        
        /**
         * Get received bytes.
         * @returns { number } - Returns the received bytes.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getReceivedBytes(): number;
        
        /**
         * Get full path of the web download.
         * @returns { string } - Returns the full path of the download.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getFullPath(): string;
        /**
         * Serialize web download to typed array.
         * @returns { Uint8Array } - Returns the serialized data.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        serialize(): Uint8Array;
        /**
         * Deserialize web download from typed array.
         * @param { Uint8Array } serializedData - The serialized data.
         * @returns { WebDownloadItem } - Deserialize the serialized data into a WebDownloadItem.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types.
         * <br>2. Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static deserialize(serializedData: Uint8Array): WebDownloadItem;
    }
    
    /**
     * The download state is notified through this delegate.
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebDownloadDelegate {
        
        /**
         * Callback will be triggered before web download start.
         * @param { Callback<WebDownloadItem> } callback - The callback of download will be start.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        onBeforeDownload(callback: Callback<WebDownloadItem>): void;
        
        /**
         * Callback will be triggered when web download is processing.
         * @param { Callback<WebDownloadItem> } callback - The callback of download did update.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        onDownloadUpdated(callback: Callback<WebDownloadItem>): void;
        
        /**
         * Callback will be triggered when web download is completed.
         * @param { Callback<WebDownloadItem> } callback - The callback of download did finish.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        onDownloadFinish(callback: Callback<WebDownloadItem>): void;
        
        /**
         * Callback will be triggered when web download is interrupted or canceled.
         * @param { Callback<WebDownloadItem> } callback - The callback of download did fail.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        onDownloadFailed(callback: Callback<WebDownloadItem>): void;
    }
    
    /**
     * You can trigger download manually through this interface, or resume failed or canceled downloads.
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebDownloadManager {
        
        /**
         * Set a delegate used to receive the progress of the download triggered from WebDownloadManager.
         * @param { WebDownloadDelegate } delegate - Delegate used for download triggered from WebDownloadManager.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static setDownloadDelegate(delegate: WebDownloadDelegate): void;
        /**
         * Resume the canceled or failed download.
         * @param { WebDownloadItem } webDownloadItem - Download that need to be resume.
         * @throws { BusinessError } 17100018 - No WebDownloadDelegate has been set yet.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static resumeDownload(webDownloadItem: WebDownloadItem): void;
    }
    /**
     * The http body stream of the request.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebHttpBodyStream {
        /**
         * Initialize data stream.
         *
         * @returns { Promise<void> } The promise of data stream is initialized.
         * @throws { BusinessError } 17100022 - Failed to initialize the HTTP body stream.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        initialize(): Promise<void>;
        /**
         * Read the data stream to the buffer.
         *
         * @param { number } size - Read size.
         * @returns { Promise<ArrayBuffer> } Read array buffer of result.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        read(size: number): Promise<ArrayBuffer>;
        /**
         * Get the total size of the data stream. When data is chunked, always return zero.
         *
         * @returns { number } Return size of data stream size.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getSize(): number;
        /**
         * Get the current position of the data stream.
         *
         * @returns { number } Return position in post data stream.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getPosition(): number;
        /**
         * Whether data stream is chunked.
         *
         * @returns { boolean } Whether data stream is chunked.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isChunked(): boolean;
        /**
         * Whether all data stream has been consumed. For chunked uploads,
         * returns false until the first read attempt.
         *
         * @returns { boolean } Whether data stream has been consumed.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isEof(): boolean;
        /**
         * Returns true if the upload data in the stream is entirely in memory, and all read requests will succeed
         * synchronously. Expected to return false for chunked requests.
         *
         * @returns { boolean } Whether the data stream is in memory.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isInMemory(): boolean;
    }
    /**
     * Defines the resource type of request.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum WebResourceType {
        /**
         * Top level page.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        MAIN_FRAME = 0,
        /**
         * Frame or Iframe.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SUB_FRAME = 1,
        /**
         * CSS stylesheet.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        STYLE_SHEET = 2,
        /**
         * External script.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SCRIPT = 3,
        /**
         * Image (jpg/gif/png/etc).
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        IMAGE = 4,
        /**
         * Font.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FONT_RESOURCE = 5,
        /**
         * Some other subresource. This is the default type if the actual type is unknown.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SUB_RESOURCE = 6,
        /**
         * Object (or embed) tag for a plugin, or a resource that a plugin requested.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        OBJECT = 7,
        /**
         * Media resource.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        MEDIA = 8,
        /**
         * Main resource of a dedicated worker.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        WORKER = 9,
        /**
         * Main resource of a shared worker.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SHARED_WORKER = 10,
        /**
         * Explicitly requested prefetch.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        PREFETCH = 11,
        /**
         * Favicon.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FAVICON = 12,
        /**
         * XMLHttpRequest.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        XHR = 13,
        /**
         * Ping request for <a ping>/sendBeacon.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        PING = 14,
        /**
         * The main resource of a service worker.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        SERVICE_WORKER = 15,
        /**
         * Report of Content Security Policy violations.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        CSP_REPORT = 16,
        /**
         * Resource that a plugin requested.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        PLUGIN_RESOURCE = 17,
        /**
         * A main-frame service worker navigation preload request.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NAVIGATION_PRELOAD_MAIN_FRAME = 19,
        /**
         * A sub-frame service worker navigation preload request.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NAVIGATION_PRELOAD_SUB_FRAME = 20
    }
    /**
     * Defines the Web resource request used for scheme handler.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebSchemeHandlerRequest {
        /**
         * Gets request headers.
         *
         * @returns { Array<WebHeader> } Return the request headers.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getHeader(): Array<WebHeader>;
        /**
         * Gets the request URL.
         *
         * @returns { string } Return the request URL.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getRequestUrl(): string;
        /**
         * Get request method.
         *
         * @returns { string } Return the request method.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getRequestMethod(): string;
        /**
         * Get referrer of request.
         *
         * @returns { string } Return referrer of request.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getReferrer(): string;
        /**
         * Check whether the request is for getting the main frame.
         *
         * @returns { boolean } Whether request is main frame.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isMainFrame(): boolean;
        /**
         * Check whether the request is associated with gesture.
         *
         * @returns { boolean } Whether request has user gesture.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        hasGesture(): boolean;
        /**
         * Get http body stream.
         *
         * @returns { WebHttpBodyStream | null } Return http body stream. If request has no http body stream, return null.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getHttpBodyStream(): WebHttpBodyStream | null;
        /**
         * Get request's resource type.
         *
         * @returns { WebResourceType } Return the request's resource type.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getRequestResourceType(): WebResourceType;
        /**
         * Gets the URL of frame which trigger this request.
         *
         * @returns { string } Return the URL of frame which trigger this request.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getFrameUrl(): string;
    }
    /**
     * Defines the Web resource response used for scheme handler.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebSchemeHandlerResponse {
        /**
         * Constructor.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        constructor();
        /**
         * Set the resolved URL after redirects or changed as a result of HSTS.
         *
         * @param { string } url - Set response url for redirects.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setUrl(url: string): void;
        /**
         * Get the resolved URL after redirects or changed as a result of HSTS.
         *
         * @returns { string } Return response url for redirects.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getUrl(): string;
        /**
         * Set net error code.
         * @param { WebNetErrorList } code - Set net error code.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setNetErrorCode(code: WebNetErrorList): void;
        /**
         * Get net error code.
         *
         * @returns { WebNetErrorList } Return response error code.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getNetErrorCode(): WebNetErrorList;
        /**
         * Set http status code.
         *
         * @param { number } code - Http status code.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setStatus(code: number): void;
        /**
         * Get http status code.
         *
         * @returns { number } Return http status code.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getStatus(): number;
        /**
         * Set status text.
         *
         * @param { string } text - Status text.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setStatusText(text: string): void;
        /**
         * Get status text.
         *
         * @returns { string } Return http status text.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getStatusText(): string;
        /**
         * Set mime type.
         *
         * @param { string } type - Mime type.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setMimeType(type: string): void;
        /**
         * Get mime type.
         *
         * @returns { string } Return mime type of response.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getMimeType(): string;
        /**
         * Set the response encoding.
         *
         * @param { string } encoding - Encoding.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setEncoding(encoding: string): void;
        /**
         * Get the response encoding.
         *
         * @returns { string } Return encoding of response.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getEncoding(): string;
        /**
         * Set response hander value by name.
         *
         * @param { string } name - Header name.
         * @param { string } value - Header value.
         * @param { boolean } overwrite - Whether to overwrite.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setHeaderByName(name: string, value: string, overwrite: boolean): void;
        /**
         * Get the header value by name from the response.
         *
         * @param { string } name - Header name.
         * @returns { string } Return header value by name.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getHeaderByName(name: string): string;
    }
    /**
     * Used to intercept url requests. Response headers and body can be sent through
     * WebResourceHandler.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebResourceHandler {
        /**
         * Pass response headers to intercepted requests.
         *
         * @param { WebSchemeHandlerResponse } response - Set response header to intercept.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * @throws { BusinessError } 17100021 - The resource handler is invalid.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        didReceiveResponse(response: WebSchemeHandlerResponse): void;
        /**
         * Pass response body data to intercepted requests.
         *
         * @param { ArrayBuffer } data - Set response body to intercept.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * @throws { BusinessError } 17100021 - The resource handler is invalid.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        didReceiveResponseBody(data: ArrayBuffer): void;
        /**
         * Notify that this request should be finished and there is no more data available.
         *
         * @throws { BusinessError } 17100021 - The resource handler is invalid.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        didFinish(): void;
        /**
         * Notify that this request should be failed.
         *
         * @param { WebNetErrorList } code - Set response error code to intercept.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types.
         * @throws { BusinessError } 17100021 - The resource handler is invalid.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        didFail(code: WebNetErrorList): void;
    }
    /**
     * This class is used to intercept requests for a specified scheme.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class WebSchemeHandler {
        /**
         * Callback for handling the request.
         *
         * @param { function } callback - Callback of handling the request. If callback return false,
         *                                it means no interception.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        onRequestStart(callback: (request: WebSchemeHandlerRequest, handler: WebResourceHandler) => boolean): void;
        /**
         * Callback when the request is completed.
         *
         * @param { Callback<WebSchemeHandlerRequest> } callback - Callback of request is completed.
         * @throws { BusinessError } 401 - Invalid input parameter.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        onRequestStop(callback: Callback<WebSchemeHandlerRequest>): void;
    }
    /**
     * Enum type supplied to {@link handleStatusChanged} for indicating the playback status.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum PlaybackStatus {
        /**
         * Player status is paused.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        PAUSED = 0,
        /**
         * Player status is playing.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        PLAYING
    }
    /**
     * Enum type supplied to {@link handleNetworkStateChanged} for indicating the native player network state.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum NetworkState {
        /**
         * Player does not do any download tasks.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        EMPTY = 0,
        /**
         * Player downloads finished, waiting for next task.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        IDLE,
        /**
         * Player is downloading contents.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        LOADING,
        /**
         * Player downloads failed, due to network error.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NETWORK_ERROR
    }
    /**
     * Enum type supplied to {@link handleReadyStateChanged} for indicating the native player network state.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum ReadyState {
        /**
         * Player hasn't downloaded anything.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        HAVE_NOTHING = 0,
        /**
         * Player has downloaded metadata.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        HAVE_METADATA,
        /**
         * Player has played all downloaded media data.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        HAVE_CURRENT_DATA,
        /**
         * The buffered media data is not enough, and will cause jank.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        HAVE_FUTURE_DATA,
        /**
         * The buffered media data is enough.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        HAVE_ENOUGH_DATA
    }
    /**
     * Enum type supplied to {@link handleError} for indicating the error type of native media player.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum MediaError {
        /**
         * Network error
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NETWORK_ERROR = 1,
        /**
         * Media format error, such as not a valid file.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        FORMAT_ERROR,
        /**
         * Decode error, such as decoder doesn't support this format.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        DECODE_ERROR
    }
    /**
     * The native media player status handler.
     * Apps should use this class to handle native media player's status.
     *
     * @typedef NativeMediaPlayerHandler
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface NativeMediaPlayerHandler {
        /**
         * Handle native media player playback status.
         *
         * @param { PlaybackStatus } status - Playback status of native media player.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleStatusChanged(status: PlaybackStatus): void;
        /**
         * Handle native media player volume.
         *  volume: float
         *   value range: [0 - 1.0]
         *
         * @param { double } volume - Current volume of native media player.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleVolumeChanged(volume: double): void;
        /**
         * Handle native media player muted status.
         *
         * @param { boolean } muted - Current mute status of native media player.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleMutedChanged(muted: boolean): void;
        /**
         * Handle playback rate of native media player.
         *  playbackRate: float
         *   value range: [0 - infinity]
         *
         * @param { double } playbackRate - Current playback rate of native media player.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handlePlaybackRateChanged(playbackRate: double): void;
        /**
         * Handle duration time of media.
         *  duration: float
         *   value range: [0 - infinity]
         *
         * @param { double } duration - Duration time (in seconds) of media.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleDurationChanged(duration: double): void;
        /**
         * Handle current playing time of media.
         *  currentPlayTime: float
         *   value range: [0 - duration]
         *
         * @param { double } currentPlayTime - Current playing time (in seconds) of media.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleTimeUpdate(currentPlayTime: double): void;
        /**
         * Handle buffered end time of media.
         *  bufferedEndTime: float
         *   value range: [0 - duration]
         *
         * @param { double } bufferedEndTime - Buffered end time (in seconds) of media.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleBufferedEndTimeChanged(bufferedEndTime: double): void;
        /**
         * Handle native player ended event.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleEnded(): void;
        /**
         * Handle network state of native media player.
         *
         * @param { NetworkState } state - Network state of native media player.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleNetworkStateChanged(state: NetworkState): void;
        /**
         * Handle ready state of native media player.
         *
         * @param { ReadyState } state - Ready state of native media player.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleReadyStateChanged(state: ReadyState): void;
        /**
         * Handle native media player fullscreen state changed event.
         *
         * @param { boolean } fullscreen - Fullscreen state of native media player.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleFullscreenChanged(fullscreen: boolean): void;
        /**
         * Handle native media player seeking state.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleSeeking(): void;
        /**
         * Handle native media player seek finished state.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleSeekFinished(): void;
        /**
         * Handle native media player error event.
         *
         * @param { MediaError } error - Error type of native media player.
         * @param { string } errorMessage - Description of current error.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleError(error: MediaError, errorMessage: string): void;
        /**
         * Handle size of video.
         *
         * @param { double } width - Width of video.
         * @param { double } height - Height of video.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        handleVideoSizeChanged(width: double, height: double): void;
    }
    /**
     * The scenarios for suspending the media player.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum SuspendType {
        /**
         * Page enters the BackForwardCache.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        ENTER_BACK_FORWARD_CACHE = 0,
        /**
         * Page enters background.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        ENTER_BACKGROUND,
        /**
         * Cleanup when the number of paused media player over limit.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        AUTO_CLEANUP
    }
    /**
     * The function of reusme media play.
     *
     * @typedef { function } ResumePlayerFn
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    type ResumePlayerFn = () => void;
    /**
     * The function of suspend media play.
     *
     * @typedef { function } SuspendPlayerFn
     * @param { SuspendType } type - The scenario for suspending the media player.
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    type SuspendPlayerFn = (type: SuspendType) => void;
    /**
     * The bridge between web core and native media player.
     * Apps should implements this interface, and pass an instance to web core.
     * Then web core can control native media player by this bridge.
     *
     * @typedef NativeMediaPlayerBridge
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface NativeMediaPlayerBridge {
        /**
         * Notify native media player that the rect of video tag has changed.
         *
         * @param { double } x - The x position of video tag in web component.
         * @param { double } y - The y position of video tag in web component.
         * @param { double } width - The width of video tag.
         * @param { double } height - The height of video tag.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        updateRect(x: double, y: double, width: double, height: double): void;
        /**
         * Request to play.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        play(): void;
        /**
         * Request to pause.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        pause(): void;
        /**
         * Request to fast forward / back forward to targetTime.
         *  targetTime: float
         *   value range: [0 - duration]
         *
         * @param { double } targetTime - The target time (in seconds) to FF/BF to.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        seek(targetTime: double): void;
        /**
         * Request to change volume of native media player.
         *  volume: float
         *   value range: [0 - 1.0]
         *
         * @param { double } volume - The volume of native media player.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setVolume(volume: double): void;
        /**
         * Request to mute native media player.
         *
         * @param { boolean } muted - Should mute native media player.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setMuted(muted: boolean): void;
        /**
         * Request to change playback rate of native media player.
         *  playbackRate: float
         *   value range: [0 - 10.0]
         *
         * @param { double } playbackRate - The playback rate of native media player.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        setPlaybackRate(playbackRate: double): void;
        /**
         * Request to release native media player.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        release(): void;
        /**
         * Request to enter fullscreen.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        enterFullscreen(): void;
        /**
         * Request to exit fullscreen.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        exitFullscreen(): void;
        /**
         * Resume the native media player.
         *
         * @type { ?ResumePlayerFn }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        resumePlayer?: ResumePlayerFn;
        /**
         * Suspend to release native media player, not the NativeMediaPlayerBridge. The
         * embedder should save the status of player when release the native media player
         * through NativeMediaPlayerBridge.
         *
         * @type { ?SuspendPlayerFn }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        suspendPlayer?: SuspendPlayerFn;
    }
    /**
     * Enum type for indicating the media type of native media player.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum MediaType {
        /**
         * Media type is video.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        VIDEO = 0,
        /**
         * Media type is audio.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        AUDIO
    }
    /**
     * Enum type for indicating the media source type of native media player.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum SourceType {
        /**
         * The type of media source is URL.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        URL = 0,
        /**
         * The type of media source is blob.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        MSE
    }
    /**
     * Media source information. Uri and format.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class MediaSourceInfo {
        /**
         * Source type, most time is URL.
         * @type { SourceType }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        type: SourceType;
        /**
         * Media source, most time is Uri.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        source: string;
        /**
         * Media format, such as mp4, webm, m3u8 etc.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        format: string;
    }
    /**
     * Rectangle definition.
     *
     * @typedef RectEvent
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface RectEvent {
        /**
         * X coordinator of top left point.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        x: double;
        /**
         * Y coordinator of top left point.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        y: double;
        /**
         * Width of this rectangle.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        width: double;
        /**
         * Height of this rectangle.
         *
         * @type { double }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        height: double;
    }
    /**
     * Surface information.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class NativeMediaPlayerSurfaceInfo {
        /**
         * Id of surface.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        id: string;
        /**
         * Surface rect info.
         * @type { RectEvent }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        rect: RectEvent;
    }
    /**
     * Enum type for indicating the preload type.
     * @enum {number}
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum Preload {
        /**
         * Doesn't do preload.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        NONE = 0,
        /**
         * Only preload metadata.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        METADATA,
        /**
         * Preload enough data to ensure playing is smooth.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        AUTO
    }
    /**
     * Media information.
     *
     * @typedef MediaInfo
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    interface MediaInfo {
        /**
         * Id of media element.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        embedID: string;
        /**
         * Media type : Video or Audio.
         * @type { MediaType }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        mediaType: MediaType;
        /**
         * Media source list, player should choose an appropriate one to play.
         * @type { MediaSourceInfo[] }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        mediaSrcList: MediaSourceInfo[];
        /**
         * Surface to render media content on.
         * @type { NativeMediaPlayerSurfaceInfo }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        surfaceInfo: NativeMediaPlayerSurfaceInfo;
        /**
         * Should show media controls.
         * @type { boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        controlsShown: boolean;
        /**
         * Limit media controls items.
         *  Such as 'nodownload', 'nofullscreen', 'noremoteplayback'
         * @type { string[] }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        controlList: string[];
        /**
         * Player should be muted;
         * @type { boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        muted: boolean;
        /**
         * Player should show poster before media first frame shown.
         * @type { string }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        posterUrl: string;
        /**
         * Preload type.
         * @type { Preload }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        preload: Preload;
        /**
         * Header information of a media network request.
         * @type { Record<string, string> }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        headers: Record<string, string>;
        /**
         * The information list of attributes of media tag.
         * @type { Record<string, string> }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        attributes: Record<string, string>;
    }
    /**
     * The callback of creating a native media player.
     *
     * @typedef { function }
     * @param { NativeMediaPlayerHandler } handler - callback information of onCreateNativeMediaPlayer.
     * @param { MediaInfo } mediaInfo - callback information of onCreateNativeMediaPlayer.
     * @returns { NativeMediaPlayerBridge } Returns whether the app takes over the media.
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    type CreateNativeMediaPlayerCallback = (handler: NativeMediaPlayerHandler, mediaInfo: MediaInfo) => NativeMediaPlayerBridge;
    /**
     * This class is used to set adblock config.
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class AdsBlockManager {
        
        /**
         * set Ads Block ruleset file, containing easylist rules.
         * @param {string} rulesFile - absolute file path contains app customized ads block rules.
         * @param {boolean} replace - (@code true)replace internal rules;(@code false) add to internal rules.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static setAdsBlockRules(rulesFile: string, replace: boolean): void;
        
        /**
         * Add items to Ads Block Disallow list.
         * @param { Array<string> } domainSuffixes - list of domain suffix, if web page url matches someone in the list,
         * Ads Block will be disallowed for the web page.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static addAdsBlockDisallowedList(domainSuffixes: Array<string>): void;
        
        /**
         * Add items to Ads Block Allow list.
         * By default, ads block is allowed for all pages unless they are added to the
         * disallow list. The priority of allowlist is higher than the disallowlist. It is
         * used to re-enable ads block on the page that matches disallow list.
         * @param { Array<string> } domainSuffixes - list of domain suffix, if web page url matches someone in the list,
         * Ads Block will be allowed for the web page.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static addAdsBlockAllowedList(domainSuffixes: Array<string>): void;
        
        /**
         * remove items from Ads Block Disallowed list.
         * @param { Array<string> } domainSuffixes - list of domain suffix needed be removed from disallow list
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static removeAdsBlockDisallowedList(domainSuffixes: Array<string>): void;
        
        /**
         * remove items from Ads Block Allowed list.
         * @param { Array<string> } domainSuffixes - list of domain suffix needed be removed from allow list
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static removeAdsBlockAllowedList(domainSuffixes: Array<string>): void;
        
        /**
         * clear Ads Block Disallowed list.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static clearAdsBlockDisallowedList(): void;
        
        /**
         * clear Ads Block Allowed list.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static clearAdsBlockAllowedList(): void;
    }
    /**
     * This class is used to enable back forward cache supported features.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class BackForwardCacheSupportedFeatures {
        /**
         * Whether cache the pages that use native embed.
         * Default is false;
         *
         * @type { boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        nativeEmbed: boolean;
        /**
         * Whether cache the pages that use media take over.
         * Default is false;
         *
         * @type { boolean }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        mediaTakeOver: boolean;
        /**
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        constructor();
    }
    /**
     * This class is used to set back forward cache options.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class BackForwardCacheOptions {
        /**
         * Set the maximum size of pages that can cache.
         * Default is 1, max is 50.
         *
         * @type { number }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        size: number;
        /**
         * Set the lifetime in seconds in the BackForwardCache.
         * Default is 600.
         *
         * @type { number }
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        timeToLive: number;
        /**
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        constructor();
    }
    
    /**
     * Enum type supplied to {@link insertProxyRule} for indicating the scheme filter for proxy.
     * @enum { number }
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    enum ProxySchemeFilter {
        
        /**
         * This indicates all the schemes will use the proxy.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        MATCH_ALL_SCHEMES = 0,
        
        /**
         * This indicates only the HTTP requests will use the proxy.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        MATCH_HTTP = 1,
        
        /**
         * This indicates only the HTTPS requests will use the proxy.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        MATCH_HTTPS = 2
    }
    
    /**
     * The ProxyConfig used by applyProxyOverride.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class ProxyConfig {
        
        /**
         * Insert a bypass rule that indicates URLs that should skip the override proxy and connect the server directly instead.
         * These maybe URLs or IP addresses and wildcards are supported. e.g. "*.example.com" means that requests to
         * "https://www.example.com" and "http://test.example.com" will connect the server directly.
         *
         * @param { string } bypassRule - The bypass rule.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        insertBypassRule(bypassRule: string): void;
        
        /**
         * Insert a proxy rule that indicates URLs that match the schemeFilter will connect the server directly.
         *
         * @param { ProxySchemeFilter } schemeFilter - The scheme filter for this rule.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        insertDirectRule(schemeFilter?: ProxySchemeFilter): void;
        
        /**
         * Insert a proxy rule which indicates that requests matching the schemeFilter should use an override proxy, all requests will
         * use the proxy rule if schemeFilter is null.
         *
         * The format for proxy is [scheme://]host[:port]. Scheme is optional and must be HTTP, HTTPS, or SOCKS if present. Scheme defaults to HTTP.
         * Host is an IPv6 literal with brackets, an IPv4 literal or one or more labels seperated by a period. Port number is optional and defaults
         * to 80 for HTTP, 443 for HTTPS and 1080 for SOCKS.
         *
         * e.g. example.com host: example.com
         *      https://example.com  scheme: https  host: example.com
         *      example.com:8888     host: example.com  port: 8888
         *      https://example.com:8888  scheme:https  host: example.com  port:8888
         *      192.168.1.1  host: 192.168.1.1
         *      192.168.1.1:8888  host:192.168.1.1 port: 8888
         *      [10:20:30:40:50:60:70:80]
         *
         * @param { string } proxyRule - The proxy rule.
         * @param { ProxySchemeFilter } schemeFilter - The scheme filter for this rule.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        insertProxyRule(proxyRule: string, schemeFilter?: ProxySchemeFilter): void;
        
        /**
         * Hostnames without a period in them (and that are not IP literals) will skip the proxy and connect the server directly.
         * Examples: "abc", "local", "some-domain".
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        bypassHostnamesWithoutPeriod(): void;
        
        /**
         * By default, certain hostnames implicitly bypass the proxy if they are link-local IPs, or localhost addresses. For instance
         * hostnames matching any of (non-exhaustive list): localhost *.localhost [::1] 127.0.0.1/8 169.254/16 [FE80::]/10
         * Call this function to override the default behavior and force localhost and link-local URLs to be sent through the proxy.
         *
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        clearImplicitRules(): void;
        
        /**
         * Reverse the bypass rules.
         *
         * If false all URLs will use proxy settings except URLs match the bypass rules.
         * If true only URLs in the bypass list will use proxy, and all other URLs will be connected to directly.
         *
         * @param { boolean } reverse - If reverse the bypass rule.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        enableReverseBypass(reverse: boolean): void;
        
        /**
         * Returns the bypass rules.
         *
         * @returns { Array<string> } The bypass rules.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getBypassRules(): Array<string>;
        
        /**
         * Returns the proxy rules.
         *
         * @returns { Array<ProxyRule> } The proxy rules.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getProxyRules(): Array<ProxyRule>;
        
        /**
         * Returns if reverse bypass rules.
         *
         * @returns { boolean } If reverse bypass enabled.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        isReverseBypassEnabled(): boolean;
    }
    
    /**
     * The ProxyRule used by insertProxyRule.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class ProxyRule {
        
        /**
         * Returns the scheme filter used for this rule.
         *
         * @returns { ProxySchemeFilter } The scheme filter used for this rule.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getSchemeFilter(): ProxySchemeFilter;
        
        /**
         * Returns the proxy URL.
         *
         * @returns { string } The proxy URL.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        getUrl(): string;
    }
    
    /**
     * The callback for proxy changed.
     *
     * @typedef { function }
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    type OnProxyConfigChangeCallback = () => void;
    
    /**
     * This class is used for set proxy for ArkWeb.
     *
     * @syscap SystemCapability.Web.Webview.Core
     * @since 20
     */
    class ProxyController {
        
        /**
         * Sets ProxyConfig which will be used by all Webs in the app. URLs that match patterns in the bypass list will connect the server directly.
         * Instead, the request will use the proxy specified by the config. Requests are not guaranteed to use the new proxy immediately; wait for
         * the listener before loading a page. This listener will be called on the UI thread.
         * Note: calling applyProxyOverride will cause any existing system wide setting to be ignored.
         *
         * @param { ProxyConfig } proxyConfig - The proxy config.
         * @param { OnProxyConfigChangeCallback } callback - Called when the proxy has been changed.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static applyProxyOverride(proxyConfig: ProxyConfig, callback: OnProxyConfigChangeCallback): void;
        
        /**
         * Remove the proxy config. Requests are not guaranteed to not use the proxy; Wait for the listener before loading a page. This listener
         * will be called on the UI thread.
         *
         * @param { OnProxyConfigChangeCallback } callback - Called when the proxy has been changed.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types.
         * @syscap SystemCapability.Web.Webview.Core
         * @since 20
         */
        static removeProxyOverride(callback: OnProxyConfigChangeCallback): void;
    }
}
export default webview;
