/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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
 * @kit NetworkKit
 */
import type { AsyncCallback, Callback } from './@ohos.base';
import type connection from './@ohos.net.connection';


/**
 * Provides http related APIs.
 * @namespace http
 * @syscap SystemCapability.Communication.NetStack
 * @since 20
 */
declare namespace http {
    
    
    /**
     * Http Proxy Configuration Information.
     * @typedef { connection.HttpProxy }
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    type HttpProxy = connection.HttpProxy;
    
    
    /**
     * Creates an HTTP request task.
     * @returns { HttpRequest } the HttpRequest of the createHttp.
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    function createHttp(): HttpRequest;
    /**
     * Enum for Address Family
     * @enum {string}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export enum AddressFamily {
        /**
         * Default, can use addresses of all IP versions that your system allows.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        DEFAULT = 'CURL_IPRESOLVE_WHATEVER',
        /**
         * ONLYV4 Uses only IPv4 addresses.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        ONLY_V4 = 'CURL_IPRESOLVE_V4',
        /**
         * ONLYV6 Uses only IPv6 addresses.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        ONLY_V6 = 'CURL_IPRESOLVE_V6'
    }
    
    
    /**
     * Specifies the type and value range of the optional parameters in the HTTP request.
     * @interface HttpRequestOptions
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface HttpRequestOptions {
        
        
        /**
         * Request method,default is GET.
         * @type {?RequestMethod}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        method?: RequestMethod;
        
        
        /**
         * Additional data of the request.
         * extraData can be a string or an Object (API 6) or an ArrayBuffer(API 8).
         * @type { ?(string | Object | ArrayBuffer) }
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        extraData?: string | Object | ArrayBuffer;
        
        
        /**
         * Data type to be returned. If this parameter is set, the system preferentially returns the specified type.
         * @type {?HttpDataType}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        expectDataType?: HttpDataType;
        
        
        /**
         * default is true
         * @type {?boolean}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        usingCache?: boolean;
        
        
        /**
         * [1, 1000], default is 1.
         * @type {?int}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        priority?: int;
        
        
        /**
         * HTTP request header. default is 'content-type': 'application/json'
         * @type {?Object}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        header?: Object;
        
        
        /**
         * Read timeout period. The default value is 60,000, in ms.
         * @type {?int}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        readTimeout?: int;
        
        
        /**
         * Connection timeout interval. The default value is 60,000, in ms.
         * @type {?int}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        connectTimeout?: int;
        
        
        /**
         * default is automatically specified by the system.
         * @type {?HttpProtocol}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        usingProtocol?: HttpProtocol;
        
        
        /**
         * If this parameter is set as type of boolean, the system will use default proxy or not use proxy.
         * If this parameter is set as type of HttpProxy, the system will use the specified HttpProxy.
         * @type { ?(boolean | HttpProxy) }
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        usingProxy?: boolean | HttpProxy;
        
        
        /**
         * If this parameter is set, the system will use ca path specified by user, or else use preset ca by the system.
         * @type {?string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        caPath?: string;
        
        /**
         * Used to set to uploading or downloading the start bytes. The default value is 0.
         * HTTP standard (RFC 7233 section 3.1) allows servers to ignore range requests.
         * For HTTP PUT uploads this option should not be used, since it may conflict with other options.
         * @type {?long}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        resumeFrom?: long;
        
        /**
         * Used to set to uploading or downloading the end bytes. Translate to the end if not set.
         * HTTP standard (RFC 7233 section 3.1) allows servers to ignore range requests.
         * For HTTP PUT uploads this option should not be used, since it may conflict with other options.
         * @type {?long}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        resumeTo?: long;
        
        /**
         * Support the application to pass in client certificates, allowing the server to verify the client's identity.
         * @type {?ClientCert}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        clientCert?: ClientCert;
        
        /**
         * If this parameter is set, incoming DNS resolution server URL for the DoH server to use for name resolving.
         * The parameter must be URL-encoded in the following format: "https://host:port/path".
         * It MUST specify an HTTPS URL.
         * @type {?string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        dnsOverHttps?: string;
        
        /**
         * If this parameter is set, use the specified DNS server for DNS resolution.
         * Multiple DNS resolution servers can be set up, with a maximum of 3 servers.
         * Only take the first three if there are more than three.
         * @type {?Array<string>}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        dnsServers?: Array<string>;
        
        /**
         * The maximum limit of the response body. The default value is 5 * 1024 * 1024, in Byte.
         * The maximum value is 100 * 1024 *1024, in Byte.
         * @type {?int}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        maxLimit?: int;
        
        /**
         * The data fields which is supported by the HTTP protocol to post
         * forms and by the SMTP and IMAP protocols to provide
         * the email data to send/upload.
         * @type {?Array<MultiFormData>}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        multiFormDataList?: Array<MultiFormData>;
        /**
         * Certificate pinning option. If server certificate's digest does not match
         * {@link CertificatePinning.publicKeyHash}, request will fail.
         * @type {?(CertificatePinning | CertificatePinning[])}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        certificatePinning?: CertificatePinning | CertificatePinning[];
        /**
         * Certificate authority(CA) which is used to verify the remote server's identification.
         * @type {?RemoteValidation}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        remoteValidation?: RemoteValidation;
        /**
         * TLS option.
         * @type {?TlsOptions}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        tlsOptions?: TlsOptions;
        /**
         * HTTP server authentication settings. No authentication by default.
         * @type {?ServerAuthentication}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        serverAuthentication?: ServerAuthentication;
        /**
         * Address family option.
         * @type {?AddressFamily}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        addressFamily?: AddressFamily;
    }
    /**
     * HTTP server authentication.
     * @typedef ServerAuthentication
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface ServerAuthentication {
        /**
         * Credential of server.
         * @type {Credential}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        credential: Credential;
        /**
         * Authentication type of server. If not set, negotiate with the server.
         * @type {?AuthenticationType}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        authenticationType?: AuthenticationType;
    }
    /**
     * TlsOptions.
     * 'system': use system tls configuration.
     * TlsOption: tls version range, and specify cipher suite.
     * @typedef {'system' | TlsConfig}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type TlsOptions = 'system' | TlsConfig;
    /**
     * Remote Validation Type.
     * @typedef {'system' | 'skip'}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type RemoteValidation = 'system' | 'skip';
    /**
     * The server's authentication type.
     * @typedef {'basic' | 'ntlm' | 'digest'}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type AuthenticationType = 'basic' | 'ntlm' | 'digest';
    /**
     * HTTP credential. Some server or proxy server need this.
     * @typedef Credential
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface Credential {
        /**
         * Username of credential. Default is ''.
         * @type {string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        username: string;
        /**
         * Password of credential. Default is ''.
         * @type {string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        password: string;
    }
    /**
     * TLS config.
     * @typedef TlsConfig
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface TlsConfig {
        /**
         * Minimum version num of Tls protocol.
         * @type {TlsVersion}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        tlsVersionMin: TlsVersion;
        /**
         * Maximum version num of Tls protocol.
         * @type {TlsVersion}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        tlsVersionMax: TlsVersion;
        /**
         * CipherSuites, cipherSuits must match tsl version, otherswise will set all system-supported cipherSuits.
         * @type {?CipherSuite[]}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        cipherSuites?: CipherSuite[];
    }
    /**
     * Cipher suite which TLS1.3+ support.
     * The framework has a built-in preference order, but your choice will be recorded.
     * @typedef {'TLS_AES_128_GCM_SHA256' | 'TLS_AES_256_GCM_SHA384' | 'TLS_CHACHA20_POLY1305_SHA256'}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type TlsV13SpecificCipherSuite = 'TLS_AES_128_GCM_SHA256' | 'TLS_AES_256_GCM_SHA384' | 'TLS_CHACHA20_POLY1305_SHA256';
    /**
     * Cipher suite which TLS1.2+ support.
     * @typedef {'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256' | 'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256' | 'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384' | 'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384' | 'TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256' | 'TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256' | 'TLS_RSA_WITH_AES_128_GCM_SHA256' | 'TLS_RSA_WITH_AES_256_GCM_SHA384'}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type TlsV12SpecificCipherSuite = 'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256' | 'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256' | 'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384' | 'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384' | 'TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256' | 'TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256' | 'TLS_RSA_WITH_AES_128_GCM_SHA256' | 'TLS_RSA_WITH_AES_256_GCM_SHA384';
    /**
     * Cipher suite which TLS1.0+ support.
     * @typedef {'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA' | 'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA' | 'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA' | 'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA' | 'TLS_RSA_WITH_AES_128_CBC_SHA' | 'TLS_RSA_WITH_AES_256_CBC_SHA' | 'TLS_RSA_WITH_3DES_EDE_CBC_SHA'}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type TlsV10SpecificCipherSuite = 'TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA' | 'TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA' | 'TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA' | 'TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA' | 'TLS_RSA_WITH_AES_128_CBC_SHA' | 'TLS_RSA_WITH_AES_256_CBC_SHA' | 'TLS_RSA_WITH_3DES_EDE_CBC_SHA';
    /**
     * Include all cipher suite.
     * @typedef {TlsV13CipherSuite}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type CipherSuite = TlsV13CipherSuite;
    /**
     * TLS1.3 cipher suite should include TLS1.2 cipher suite.
     * @typedef {TlsV12CipherSuite | TlsV13SpecificCipherSuite}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type TlsV13CipherSuite = TlsV12CipherSuite | TlsV13SpecificCipherSuite;
    /**
     * TLS1.2 cipher suite should include TLS1.1 cipher suite.
     * @typedef {TlsV11CipherSuite | TlsV12SpecificCipherSuite}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type TlsV12CipherSuite = TlsV11CipherSuite | TlsV12SpecificCipherSuite;
    /**
     * TLS1.1 cipher suite is same as TLS1.0 cipher suite.
     * @typedef {TlsV10CipherSuite}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type TlsV11CipherSuite = TlsV10CipherSuite;
    /**
     * TLS1.0 cipher suite.
     * @typedef {TlsV10SpecificCipherSuite}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type TlsV10CipherSuite = TlsV10SpecificCipherSuite;
    /**
   * Enum for Tls version
   * @enum {int}
   * @syscap SystemCapability.Communication.NetStack
   * @since 20
   */
    export enum TlsVersion {
        /**
         * Tls version 1.0
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        TLS_V_1_0 = 4,
        /**
         * Tls version 1.1
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        TLS_V_1_1 = 5,
        /**
         * Tls version 1.2
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        TLS_V_1_2 = 6,
        /**
         * Tls version 1.3
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        TLS_V_1_3 = 7
    }
    
    /**
     * Represents the properties of a form object.
     * @interface MultiFormData
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface MultiFormData {
        
        /**
         * MIME name for the data field.
         * @type {string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        name: string;
        
        /**
         * Content type of the data field.
         * @type {string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        contentType: string;
        
        /**
         * Remote file name for the data field.
         * @type {?string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        remoteFileName?: string;
        
        /**
         * This parameter sets a mime part's body content from memory data.
         * @type {?(string | Object | ArrayBuffer)}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        data?: string | Object | ArrayBuffer;
        
        /**
         * This parameter sets a mime part's body content from the file's contents.
         * This is an alternative to curl_mime_data for setting data to a mime part.
         * If data is empty, filePath must be set.
         * If data has a value, filePath does not take effect.
         * @type {?string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        filePath?: string;
    }
    
    /**
     * Enum for certificate types
     * @enum {string}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export enum CertType {
        
        /**
         * PEM format certificate
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        PEM = 'PEM',
        
        /**
         * DER format certificate
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        DER = 'DER',
        
        /**
         * P12 format certificate
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        P12 = 'P12'
    }
    
    /**
     * The clientCert field of the client certificate, which includes 4 attributes:
     * client certificate (cert), client certificate type (certType), certificate private key (key), and passphrase (keyPassword).
     * @interface ClientCert
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface ClientCert {
        
        /**
         * The path to the client certificate file.
         * @type {string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        certPath: string;
        
        /**
         * The type of the client certificate.
         * @type {?CertType}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        certType?: CertType;
        
        /**
         * The path of the client certificate private key file.
         * @type {string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        keyPath: string;
        
        /**
         * Password required to use the client certificate private key.
         * @type {?string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        keyPassword?: string;
    }
    /**
     * Certificate pinning option.
     * @interface CertificatePinning
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    interface CertificatePinning {
        /**
         * Public key hash.
         * @type {string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        publicKeyHash: string;
        /**
         * Certificate public key hash algorithm.
         * @type {'SHA-256'}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        hashAlgorithm: 'SHA-256';
    }
    
    
    /**
     * <p>Defines an HTTP request task. Before invoking APIs provided by HttpRequest,
     * you must call createHttp() to create an HttpRequestTask object.</p>
     * @interface HttpRequest
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface HttpRequest {
        
        
        
        
        /**
         * Initiates an HTTP request to a given URL.
         * @permission ohos.permission.INTERNET
         * @param { string } url - URL for initiating an HTTP request.
         * @param { AsyncCallback<HttpResponse> } callback - the callback of request.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 2300001 - Unsupported protocol.
         * @throws { BusinessError } 2300003 - Invalid URL format or missing URL.
         * @throws { BusinessError } 2300005 - Failed to resolve the proxy name.
         * @throws { BusinessError } 2300006 - Failed to resolve the host name.
         * @throws { BusinessError } 2300007 - Failed to connect to the server.
         * @throws { BusinessError } 2300008 - Invalid server response.
         * @throws { BusinessError } 2300009 - Access to the remote resource denied.
         * @throws { BusinessError } 2300016 - Error in the HTTP2 framing layer.
         * @throws { BusinessError } 2300018 - Transferred a partial file.
         * @throws { BusinessError } 2300023 - Failed to write the received data to the disk or application.
         * @throws { BusinessError } 2300025 - Upload failed.
         * @throws { BusinessError } 2300026 - Failed to open or read local data from the file or application.
         * @throws { BusinessError } 2300027 - Out of memory.
         * @throws { BusinessError } 2300028 - Operation timeout.
         * @throws { BusinessError } 2300047 - The number of redirections reaches the maximum allowed.
         * @throws { BusinessError } 2300052 - The server returned nothing (no header or data).
         * @throws { BusinessError } 2300055 - Failed to send data to the peer.
         * @throws { BusinessError } 2300056 - Failed to receive data from the peer.
         * @throws { BusinessError } 2300058 - Local SSL certificate error.
         * @throws { BusinessError } 2300059 - The specified SSL cipher cannot be used.
         * @throws { BusinessError } 2300060 - Invalid SSL peer certificate or SSH remote key.
         * @throws { BusinessError } 2300061 - Invalid HTTP encoding format.
         * @throws { BusinessError } 2300063 - Maximum file size exceeded.
         * @throws { BusinessError } 2300070 - Remote disk full.
         * @throws { BusinessError } 2300073 - Remote file already exists.
         * @throws { BusinessError } 2300077 - The SSL CA certificate does not exist or is inaccessible.
         * @throws { BusinessError } 2300078 - Remote file not found.
         * @throws { BusinessError } 2300094 - Authentication error.
         * @throws { BusinessError } 2300997 - Cleartext traffic not permitted.
         * @throws { BusinessError } 2300998 - It is not allowed to access this domain.
         * @throws { BusinessError } 2300999 - Internal error.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        request(url: string, callback: AsyncCallback<HttpResponse>): void;
        
        
        
        
        /**
         * Initiates an HTTP request to a given URL.
         * @permission ohos.permission.INTERNET
         * @param { string } url - URL for initiating an HTTP request.
         * @param { HttpRequestOptions } options - Optional parameters {@link HttpRequestOptions}.
         * @param { AsyncCallback<HttpResponse> } callback - the callback of request.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 2300001 - Unsupported protocol.
         * @throws { BusinessError } 2300003 - Invalid URL format or missing URL.
         * @throws { BusinessError } 2300005 - Failed to resolve the proxy name.
         * @throws { BusinessError } 2300006 - Failed to resolve the host name.
         * @throws { BusinessError } 2300007 - Failed to connect to the server.
         * @throws { BusinessError } 2300008 - Invalid server response.
         * @throws { BusinessError } 2300009 - Access to the remote resource denied.
         * @throws { BusinessError } 2300016 - Error in the HTTP2 framing layer.
         * @throws { BusinessError } 2300018 - Transferred a partial file.
         * @throws { BusinessError } 2300023 - Failed to write the received data to the disk or application.
         * @throws { BusinessError } 2300025 - Upload failed.
         * @throws { BusinessError } 2300026 - Failed to open or read local data from the file or application.
         * @throws { BusinessError } 2300027 - Out of memory.
         * @throws { BusinessError } 2300028 - Operation timeout.
         * @throws { BusinessError } 2300047 - The number of redirections reaches the maximum allowed.
         * @throws { BusinessError } 2300052 - The server returned nothing (no header or data).
         * @throws { BusinessError } 2300055 - Failed to send data to the peer.
         * @throws { BusinessError } 2300056 - Failed to receive data from the peer.
         * @throws { BusinessError } 2300058 - Local SSL certificate error.
         * @throws { BusinessError } 2300059 - The specified SSL cipher cannot be used.
         * @throws { BusinessError } 2300060 - Invalid SSL peer certificate or SSH remote key.
         * @throws { BusinessError } 2300061 - Invalid HTTP encoding format.
         * @throws { BusinessError } 2300063 - Maximum file size exceeded.
         * @throws { BusinessError } 2300070 - Remote disk full.
         * @throws { BusinessError } 2300073 - Remote file already exists.
         * @throws { BusinessError } 2300077 - The SSL CA certificate does not exist or is inaccessible.
         * @throws { BusinessError } 2300078 - Remote file not found.
         * @throws { BusinessError } 2300094 - Authentication error.
         * @throws { BusinessError } 2300997 - Cleartext traffic not permitted.
         * @throws { BusinessError } 2300998 - It is not allowed to access this domain.
         * @throws { BusinessError } 2300999 - Internal error.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        request(url: string, options: HttpRequestOptions, callback: AsyncCallback<HttpResponse>): void;
        
        
        
        
        /**
         * Initiates an HTTP request to a given URL.
         * @permission ohos.permission.INTERNET
         * @param { string } url - URL for initiating an HTTP request.
         * @param { HttpRequestOptions } [options] - Optional parameters {@link HttpRequestOptions}.
         * @returns { Promise<HttpResponse> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 2300001 - Unsupported protocol.
         * @throws { BusinessError } 2300003 - Invalid URL format or missing URL.
         * @throws { BusinessError } 2300005 - Failed to resolve the proxy name.
         * @throws { BusinessError } 2300006 - Failed to resolve the host name.
         * @throws { BusinessError } 2300007 - Failed to connect to the server.
         * @throws { BusinessError } 2300008 - Invalid server response.
         * @throws { BusinessError } 2300009 - Access to the remote resource denied.
         * @throws { BusinessError } 2300016 - Error in the HTTP2 framing layer.
         * @throws { BusinessError } 2300018 - Transferred a partial file.
         * @throws { BusinessError } 2300023 - Failed to write the received data to the disk or application.
         * @throws { BusinessError } 2300025 - Upload failed.
         * @throws { BusinessError } 2300026 - Failed to open or read local data from the file or application.
         * @throws { BusinessError } 2300027 - Out of memory.
         * @throws { BusinessError } 2300028 - Operation timeout.
         * @throws { BusinessError } 2300047 - The number of redirections reaches the maximum allowed.
         * @throws { BusinessError } 2300052 - The server returned nothing (no header or data).
         * @throws { BusinessError } 2300055 - Failed to send data to the peer.
         * @throws { BusinessError } 2300056 - Failed to receive data from the peer.
         * @throws { BusinessError } 2300058 - Local SSL certificate error.
         * @throws { BusinessError } 2300059 - The specified SSL cipher cannot be used.
         * @throws { BusinessError } 2300060 - Invalid SSL peer certificate or SSH remote key.
         * @throws { BusinessError } 2300061 - Invalid HTTP encoding format.
         * @throws { BusinessError } 2300063 - Maximum file size exceeded.
         * @throws { BusinessError } 2300070 - Remote disk full.
         * @throws { BusinessError } 2300073 - Remote file already exists.
         * @throws { BusinessError } 2300077 - The SSL CA certificate does not exist or is inaccessible.
         * @throws { BusinessError } 2300078 - Remote file not found.
         * @throws { BusinessError } 2300094 - Authentication error.
         * @throws { BusinessError } 2300997 - Cleartext traffic not permitted.
         * @throws { BusinessError } 2300998 - It is not allowed to access this domain.
         * @throws { BusinessError } 2300999 - Internal error.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        request(url: string, options?: HttpRequestOptions): Promise<HttpResponse>;
        
        
        
        /**
         * Initiates an HTTP request to a given URL, applicable to scenarios where http response supports streaming.
         * @permission ohos.permission.INTERNET
         * @param { string } url - URL for initiating an HTTP request.
         * @param { AsyncCallback<int> } callback - Returns the callback of requestInStream {@link ResponseCode},
         *     should use on_headersReceive and on_dataReceive to get http response.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 2300001 - Unsupported protocol.
         * @throws { BusinessError } 2300003 - Invalid URL format or missing URL.
         * @throws { BusinessError } 2300005 - Failed to resolve the proxy name.
         * @throws { BusinessError } 2300006 - Failed to resolve the host name.
         * @throws { BusinessError } 2300007 - Failed to connect to the server.
         * @throws { BusinessError } 2300008 - Invalid server response.
         * @throws { BusinessError } 2300009 - Access to the remote resource denied.
         * @throws { BusinessError } 2300016 - Error in the HTTP2 framing layer.
         * @throws { BusinessError } 2300018 - Transferred a partial file.
         * @throws { BusinessError } 2300023 - Failed to write the received data to the disk or application.
         * @throws { BusinessError } 2300025 - Upload failed.
         * @throws { BusinessError } 2300026 - Failed to open or read local data from the file or application.
         * @throws { BusinessError } 2300027 - Out of memory.
         * @throws { BusinessError } 2300028 - Operation timeout.
         * @throws { BusinessError } 2300047 - The number of redirections reaches the maximum allowed.
         * @throws { BusinessError } 2300052 - The server returned nothing (no header or data).
         * @throws { BusinessError } 2300055 - Failed to send data to the peer.
         * @throws { BusinessError } 2300056 - Failed to receive data from the peer.
         * @throws { BusinessError } 2300058 - Local SSL certificate error.
         * @throws { BusinessError } 2300059 - The specified SSL cipher cannot be used.
         * @throws { BusinessError } 2300060 - Invalid SSL peer certificate or SSH remote key.
         * @throws { BusinessError } 2300061 - Invalid HTTP encoding format.
         * @throws { BusinessError } 2300063 - Maximum file size exceeded.
         * @throws { BusinessError } 2300070 - Remote disk full.
         * @throws { BusinessError } 2300073 - Remote file already exists.
         * @throws { BusinessError } 2300077 - The SSL CA certificate does not exist or is inaccessible.
         * @throws { BusinessError } 2300078 - Remote file not found.
         * @throws { BusinessError } 2300094 - Authentication error.
         * @throws { BusinessError } 2300997 - Cleartext traffic not permitted.
         * @throws { BusinessError } 2300998 - It is not allowed to access this domain.
         * @throws { BusinessError } 2300999 - Internal error.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        requestInStream(url: string, callback: AsyncCallback<int>): void;
        
        
        
        /**
         * Initiates an HTTP request to a given URL, applicable to scenarios where http response supports streaming.
         * @permission ohos.permission.INTERNET
         * @param { string } url - URL for initiating an HTTP request.
         * @param { HttpRequestOptions } options - Optional parameters {@link HttpRequestOptions}.
         * @param { AsyncCallback<int> } callback - the callback of requestInStream.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 2300001 - Unsupported protocol.
         * @throws { BusinessError } 2300003 - Invalid URL format or missing URL.
         * @throws { BusinessError } 2300005 - Failed to resolve the proxy name.
         * @throws { BusinessError } 2300006 - Failed to resolve the host name.
         * @throws { BusinessError } 2300007 - Failed to connect to the server.
         * @throws { BusinessError } 2300008 - Invalid server response.
         * @throws { BusinessError } 2300009 - Access to the remote resource denied.
         * @throws { BusinessError } 2300016 - Error in the HTTP2 framing layer.
         * @throws { BusinessError } 2300018 - Transferred a partial file.
         * @throws { BusinessError } 2300023 - Failed to write the received data to the disk or application.
         * @throws { BusinessError } 2300025 - Upload failed.
         * @throws { BusinessError } 2300026 - Failed to open or read local data from the file or application.
         * @throws { BusinessError } 2300027 - Out of memory.
         * @throws { BusinessError } 2300028 - Operation timeout.
         * @throws { BusinessError } 2300047 - The number of redirections reaches the maximum allowed.
         * @throws { BusinessError } 2300052 - The server returned nothing (no header or data).
         * @throws { BusinessError } 2300055 - Failed to send data to the peer.
         * @throws { BusinessError } 2300056 - Failed to receive data from the peer.
         * @throws { BusinessError } 2300058 - Local SSL certificate error.
         * @throws { BusinessError } 2300059 - The specified SSL cipher cannot be used.
         * @throws { BusinessError } 2300060 - Invalid SSL peer certificate or SSH remote key.
         * @throws { BusinessError } 2300061 - Invalid HTTP encoding format.
         * @throws { BusinessError } 2300063 - Maximum file size exceeded.
         * @throws { BusinessError } 2300070 - Remote disk full.
         * @throws { BusinessError } 2300073 - Remote file already exists.
         * @throws { BusinessError } 2300077 - The SSL CA certificate does not exist or is inaccessible.
         * @throws { BusinessError } 2300078 - Remote file not found.
         * @throws { BusinessError } 2300094 - Authentication error.
         * @throws { BusinessError } 2300997 - Cleartext traffic not permitted.
         * @throws { BusinessError } 2300998 - It is not allowed to access this domain.
         * @throws { BusinessError } 2300999 - Internal error.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        requestInStream(url: string, options: HttpRequestOptions, callback: AsyncCallback<int>): void;
        
        
        
        /**
         * Initiates an HTTP request to a given URL, applicable to scenarios where http response supports streaming.
         * @permission ohos.permission.INTERNET
         * @param { string } url - URL for initiating an HTTP request.
         * @param { HttpRequestOptions } [options] - Optional parameters {@link HttpRequestOptions}.
         * @returns { Promise<int> } the promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 2300001 - Unsupported protocol.
         * @throws { BusinessError } 2300003 - Invalid URL format or missing URL.
         * @throws { BusinessError } 2300005 - Failed to resolve the proxy name.
         * @throws { BusinessError } 2300006 - Failed to resolve the host name.
         * @throws { BusinessError } 2300007 - Failed to connect to the server.
         * @throws { BusinessError } 2300008 - Invalid server response.
         * @throws { BusinessError } 2300009 - Access to the remote resource denied.
         * @throws { BusinessError } 2300016 - Error in the HTTP2 framing layer.
         * @throws { BusinessError } 2300018 - Transferred a partial file.
         * @throws { BusinessError } 2300023 - Failed to write the received data to the disk or application.
         * @throws { BusinessError } 2300025 - Upload failed.
         * @throws { BusinessError } 2300026 - Failed to open or read local data from the file or application.
         * @throws { BusinessError } 2300027 - Out of memory.
         * @throws { BusinessError } 2300028 - Operation timeout.
         * @throws { BusinessError } 2300047 - The number of redirections reaches the maximum allowed.
         * @throws { BusinessError } 2300052 - The server returned nothing (no header or data).
         * @throws { BusinessError } 2300055 - Failed to send data to the peer.
         * @throws { BusinessError } 2300056 - Failed to receive data from the peer.
         * @throws { BusinessError } 2300058 - Local SSL certificate error.
         * @throws { BusinessError } 2300059 - The specified SSL cipher cannot be used.
         * @throws { BusinessError } 2300060 - Invalid SSL peer certificate or SSH remote key.
         * @throws { BusinessError } 2300061 - Invalid HTTP encoding format.
         * @throws { BusinessError } 2300063 - Maximum file size exceeded.
         * @throws { BusinessError } 2300070 - Remote disk full.
         * @throws { BusinessError } 2300073 - Remote file already exists.
         * @throws { BusinessError } 2300077 - The SSL CA certificate does not exist or is inaccessible.
         * @throws { BusinessError } 2300078 - Remote file not found.
         * @throws { BusinessError } 2300094 - Authentication error.
         * @throws { BusinessError } 2300997 - Cleartext traffic not permitted.
         * @throws { BusinessError } 2300998 - It is not allowed to access this domain.
         * @throws { BusinessError } 2300999 - Internal error.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        requestInStream(url: string, options?: HttpRequestOptions): Promise<int>;
        
        
        /**
         * Destroys an HTTP request.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        destroy(): void;
    }
    
    
    /**
     * Defines an HTTP request method.
     * @enum {string}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export enum RequestMethod {
        
        
        /**
         * OPTIONS method.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        OPTIONS = "OPTIONS",
        
        
        /**
         * GET method.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        GET = "GET",
        
        
        /**
         * HEAD method.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        HEAD = "HEAD",
        
        
        /**
         * POST method.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        POST = "POST",
        
        
        /**
         * PUT method.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        PUT = "PUT",
        
        
        /**
         * DELETE method.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        DELETE = "DELETE",
        
        
        /**
         * TRACE method.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        TRACE = "TRACE",
        
        
        /**
         * CONNECT method.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        CONNECT = "CONNECT"
    }
    
    
    /**
     * Enumerates the response codes for an HTTP request.
     * @enum {int}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export enum ResponseCode {
        
        
        /**
         * The request was successful. Typically used for GET and POST requests.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        OK = 200,
        
        
        /**
         * Successfully requested and created a new resource.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        CREATED,
        
        
        /**
         * The request has been accepted but has not been processed completely.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        ACCEPTED,
        
        
        /**
         * Unauthorized information. The request was successful.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        NOT_AUTHORITATIVE,
        
        
        /**
         * No content. The server successfully processed, but did not return content.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        NO_CONTENT,
        
        
        /**
         * Reset the content.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        RESET,
        
        
        /**
         * Partial content. The server successfully processed some GET requests.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        PARTIAL,
        
        
        /**
         * Multiple options.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        MULT_CHOICE = 300,
        
        
        /**
         * <p>Permanently move. The requested resource has been permanently moved to a new URI,
         * and the returned information will include the new URI. The browser will automatically redirect to the new URI.</p>
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        MOVED_PERM,
        
        
        /**
         * Temporary movement.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        MOVED_TEMP,
        
        
        /**
         * View other addresses.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        SEE_OTHER,
        
        
        /**
         * Not modified.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        NOT_MODIFIED,
        
        
        /**
         * Using proxies.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        USE_PROXY,
        
        
        /**
         * The server cannot understand the syntax error error requested by the client.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        BAD_REQUEST = 400,
        
        
        /**
         * Request for user authentication.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        UNAUTHORIZED,
        
        
        /**
         * Reserved for future use.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        PAYMENT_REQUIRED,
        
        
        /**
         * The server understands the request from the requesting client, but refuses to execute it.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        FORBIDDEN,
        
        
        /**
         * The server was unable to find resources (web pages) based on the client's request.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        NOT_FOUND,
        
        
        /**
         * The method in the client request is prohibited.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        BAD_METHOD,
        
        
        /**
         * The server is unable to complete the request based on the content characteristics requested by the client.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        NOT_ACCEPTABLE,
        
        
        /**
         * Request authentication of the proxy's identity.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        PROXY_AUTH,
        
        
        /**
         * The request took too long and timed out.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        CLIENT_TIMEOUT,
        
        
        /**
         * <p>The server may have returned this code when completing the client's PUT request,
         * as there was a conflict when the server was processing the request.</p>
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        CONFLICT,
        
        
        /**
         * The resource requested by the client no longer exists.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        GONE,
        
        
        /**
         * The server is unable to process request information sent by the client without Content Length.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        LENGTH_REQUIRED,
        
        
        /**
         * The prerequisite for requesting information from the client is incorrect.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        PRECON_FAILED,
        
        
        /**
         * The request was rejected because the requested entity was too large for the server to process.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        ENTITY_TOO_LARGE,
        
        
        /**
         * The requested URI is too long (usually a URL) and the server cannot process it.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        REQ_TOO_LONG,
        
        
        /**
         * The server is unable to process the requested format.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        UNSUPPORTED_TYPE,
        /**
         * The server cannot process the requested data range.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        RANGE_NOT_SATISFIABLE,
        
        
        /**
         * Internal server error, unable to complete the request.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        INTERNAL_ERROR = 500,
        
        
        /**
         * The server does not support the requested functionality and cannot complete the request.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        NOT_IMPLEMENTED,
        
        
        /**
         * The server acting as a gateway or proxy received an invalid request from the remote server.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        BAD_GATEWAY,
        
        
        /**
         * Due to overload or system maintenance, the server is temporarily unable to process client requests.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        UNAVAILABLE,
        
        
        /**
         * The server acting as a gateway or proxy did not obtain requests from the remote server in a timely manner.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        GATEWAY_TIMEOUT,
        
        
        /**
         * The version of the HTTP protocol requested by the server.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        VERSION
    }
    
    
    /**
     * Supported protocols.
     * @enum {string}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export enum HttpProtocol {
        
        
        /**
         * Protocol http1.1
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        HTTP1_1,
        
        
        /**
         * Protocol http2
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        HTTP2,
        
        /**
         * Protocol http3 for https only.
         * Cause error if using http only or not supporting http3 on this device.
         * Fallback to http2 or http1.1 if needed.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        HTTP3
    }
    
    
    /**
     * Indicates the type of the returned data.
     * @enum {int}
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export enum HttpDataType {
        
        
        /**
         * The returned type is string.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        STRING,
        
        
        /**
         * The returned type is Object.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        OBJECT = 1,
        
        
        /**
         * The returned type is ArrayBuffer.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        ARRAY_BUFFER = 2
    }
    
    
    /**
     * Defines the response to an HTTP request.
     * @interface HttpResponse
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface HttpResponse {
        
        
        /**
         * result can be a string (API 6) or an ArrayBuffer(API 8). Object is deprecated from API 8.
         * If {@link HttpRequestOptions#expectDataType} is set, the system preferentially returns this parameter.
         * @type {string | Object | ArrayBuffer}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        result: string | Object | ArrayBuffer;
        
        
        /**
         * If the resultType is string, you can get result directly.
         * If the resultType is Object, you can get result such as this: result['key'].
         * If the resultType is ArrayBuffer, you can use ArrayBuffer to create the binary objects.
         * @type {HttpDataType}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        resultType: HttpDataType;
        
        
        /**
         * Server status code.
         * @type {ResponseCode | int}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        responseCode: ResponseCode | int;
        
        
        /**
         * All headers in the response from the server.
         * @type {Object}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        header: Object;
        
        
        /**
         * Cookies returned by the server.
         * @type {string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        cookies: string;
        
        /**
         * The time taken of various stages of HTTP request.
         * @type {PerformanceTiming}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        performanceTiming: PerformanceTiming;
    }
    
    /**
     * Counting the time taken of various stages of HTTP request.
     * @interface PerformanceTiming
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface PerformanceTiming {
        
        /**
         * Time taken from startup to DNS resolution completion, in milliseconds.
         * @type {double}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        dnsTiming: double;
        
        /**
         * Time taken from startup to TCP connection completion, in milliseconds.
         * @type {double}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        tcpTiming: double;
        
        /**
         * Time taken from startup to TLS connection completion, in milliseconds.
         * @type {double}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        tlsTiming: double;
        
        /**
         * Time taken from startup to start sending the first byte, in milliseconds.
         * @type {double}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        firstSendTiming: double;
        
        /**
         * Time taken from startup to receiving the first byte, in milliseconds.
         * @type {double}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        firstReceiveTiming: double;
        
        /**
         * Time taken from startup to the completion of the request, in milliseconds.
         * @type {double}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        totalFinishTiming: double;
        
        /**
         * Time taken from startup to completion of all redirection steps, in milliseconds.
         * @type {double}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        redirectTiming: double;
        
        /**
         * Time taken from HTTP request to header completion, in milliseconds.
         * @type {double}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        responseHeaderTiming: double;
        
        /**
         * Time taken from HTTP Request to body completion, in milliseconds.
         * @type {double}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        responseBodyTiming: double;
        
        /**
         * Time taken from HTTP Request to callback to the application, in milliseconds.
         * @type {double}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        totalTiming: double;
    }
    
    
    /**
     * This interface is used to obtain the progress information of file upload or download.
     * @interface DataReceiveProgressInfo
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface DataReceiveProgressInfo {
        
        
        /**
         * Number of data bytes received.
         * @type { int }
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        receiveSize: int;
        
        
        /**
         * Total number of bytes to receive.
         * @type { int }
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        totalSize: int;
    }
    
    
    /**
     * Creates a default {@code HttpResponseCache} object to store the responses of HTTP access requests.
     * @param { int } cacheSize - the size of cache(max value is 10MB), default is 10*1024*1024(10MB).
     * @returns { HttpResponseCache } the HttpResponseCache of the createHttpResponseCache.
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    function createHttpResponseCache(cacheSize?: int): HttpResponseCache;
    
    
    /**
     * Defines an object that stores the response to an HTTP request.
     * @interface HttpResponseCache
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface HttpResponseCache {
        
        
        /**
         * Writes data in the cache to the file system so that all the cached data can be accessed in the next HTTP request.
         * @param { AsyncCallback<void> } callback - the callback of flush.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        flush(callback: AsyncCallback<void>): void;
        
        
        /**
         * Writes data in the cache to the file system so that all the cached data can be accessed in the next HTTP request.
         * @returns { Promise<void> } The promise returned by the flush.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        flush(): Promise<void>;
        
        
        /**
         * Disables a cache and deletes the data in it.
         * @param { AsyncCallback<void> } callback - the callback of delete.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        delete(callback: AsyncCallback<void>): void;
        
        
        /**
         * Disables a cache and deletes the data in it.
         * @returns { Promise<void> } The promise returned by the delete.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        delete(): Promise<void>;
    }
}
export default http;
