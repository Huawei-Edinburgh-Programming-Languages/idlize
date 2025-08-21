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
 * @kit NetworkKit
 */
import type { AsyncCallback, ErrorCallback, Callback } from './@ohos.base';
import type connection from './@ohos.net.connection';


/**
 * Provides WebSocket APIs.
 * @namespace webSocket
 * @syscap SystemCapability.Communication.NetStack
 * @since 20
 */
declare namespace webSocket {
    /**
     * @typedef { connection.HttpProxy }
     * @syscap SystemCapability.Communication.NetManager.Core
     * @since 20
     */
    type HttpProxy = connection.HttpProxy;
    
    
    /**
     * Creates a web socket connection.
     * @returns { WebSocket } the WebSocket of the createWebSocket.
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    function createWebSocket(): WebSocket;
    
    
    /**
     * Defines the optional parameters carried in the request for establishing a WebSocket connection.
     * @interface WebSocketRequestOptions
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface WebSocketRequestOptions {
        
        
        /**
         * HTTP request header.
         * @type {?Object}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        header?: Object;
        
        /**
         * File path for client cert.
         * @type {?string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        caPath?: string;
        
        /**
         * Client cert.
         * @type {?ClientCert}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        clientCert?: ClientCert;
        /**
         * HTTP proxy configuration. Use 'system' if this filed is not set.
         * @type {?ProxyConfiguration}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        proxy?: ProxyConfiguration;
        /**
         * Self defined protocol.
         * @type {?string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        protocol?: string;
    }
    /**
     * HTTP proxy configuration.
     * system: means that use system proxy configuration.
     * no-proxy: means do not use proxy.
     * object of @type {connection.HttpProxy} means providing custom proxy settings
     * @typedef { 'system' | 'no-proxy' | HttpProxy }
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export type ProxyConfiguration = 'system' | 'no-proxy' | HttpProxy;
    
    /**
     * The clientCert field of the client certificate, which includes three attributes:
     * client certificate (certPath) and only support PEM format, certificate private key (keyPath),
     * and passphrase (keyPassword).
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
         * The path of the client certificate private key file.
         * @type {string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        keyPath: string;
        
        /**
         * Client certificate password.
         * @type {?string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        keyPassword?: string;
    }
    
    
    /**
     * Defines the optional parameters carried in the request for closing a WebSocket connection.
     * @interface WebSocketCloseOptions
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface WebSocketCloseOptions {
        
        
        /**
         * Error code.
         * @type {?int}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        code?: int;
        
        
        /**
         * Error cause.
         * @type {?string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        reason?: string;
    }
    
    /**
     * The result for closing a WebSocket connection.
     * @interface CloseResult
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface CloseResult {
        
        /**
         * Error code.
         * @type {int}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        code: int;
        
        /**
         * Error cause.
         * @type {string}
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        reason: string;
    }
    
    
    /**
     * <p>Defines a WebSocket object. Before invoking WebSocket APIs,
     * you need to call webSocket.createWebSocket to create a WebSocket object.</p>
     * @interface WebSocket
     * @syscap SystemCapability.Communication.NetStack
     * @since 20
     */
    export interface WebSocket {
        
        
        
        /**
         * Initiates a WebSocket request to establish a WebSocket connection to a given URL.
         * @permission ohos.permission.INTERNET
         * @param { string } url URL for establishing a WebSocket connection.
         * @param { AsyncCallback<boolean> } callback - the callback of connect.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 2302001 - Websocket url error.
         * @throws { BusinessError } 2302002 - Websocket certificate file does not exist.
         * @throws { BusinessError } 2302003 - Websocket connection already exists.
         * @throws { BusinessError } 2302998 - It is not allowed to access this domain.
         * @throws { BusinessError } 2302999 - Internal error.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        connect(url: string, callback: AsyncCallback<boolean>): void;
        
        
        
        /**
         * Initiates a WebSocket request to establish a WebSocket connection to a given URL.
         * @permission ohos.permission.INTERNET
         * @param { string } url URL for establishing a WebSocket connection.
         * @param { WebSocketRequestOptions } options - Optional parameters {@link WebSocketRequestOptions}.
         * @param { AsyncCallback<boolean> } callback - the callback of connect.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 2302001 - Websocket url error.
         * @throws { BusinessError } 2302002 - Websocket certificate file does not exist.
         * @throws { BusinessError } 2302003 - Websocket connection already exists.
         * @throws { BusinessError } 2302998 - It is not allowed to access this domain.
         * @throws { BusinessError } 2302999 - Internal error.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        connect(url: string, options: WebSocketRequestOptions, callback: AsyncCallback<boolean>): void;
        
        
        
        /**
         * Initiates a WebSocket request to establish a WebSocket connection to a given URL.
         * @permission ohos.permission.INTERNET
         * @param { string } url URL for establishing a WebSocket connection.
         * @param { WebSocketRequestOptions } options - Optional parameters {@link WebSocketRequestOptions}.
         * @returns { Promise<boolean> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 2302001 - Websocket url error.
         * @throws { BusinessError } 2302002 - Websocket certificate file does not exist.
         * @throws { BusinessError } 2302003 - Websocket connection already exists.
         * @throws { BusinessError } 2302998 - It is not allowed to access this domain.
         * @throws { BusinessError } 2302999 - Internal error.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        connect(url: string, options?: WebSocketRequestOptions): Promise<boolean>;
        
        
        /**
         * Sends data through a WebSocket connection.
         * @permission ohos.permission.INTERNET
         * @param { string | ArrayBuffer } data - Data to send. It can be a string(API 6) or an ArrayBuffer(API 8).
         * @param { AsyncCallback<boolean> } callback - the callback of send.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        send(data: string | ArrayBuffer, callback: AsyncCallback<boolean>): void;
        
        
        /**
         * Sends data through a WebSocket connection.
         * @permission ohos.permission.INTERNET
         * @param { string | ArrayBuffer } data - Data to send. It can be a string(API 6) or an ArrayBuffer(API 8).
         * @returns { Promise<boolean> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        send(data: string | ArrayBuffer): Promise<boolean>;
        
        
        /**
         * Closes a WebSocket connection.
         * @permission ohos.permission.INTERNET
         * @param { AsyncCallback<boolean> } callback - the callback of close.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        close(callback: AsyncCallback<boolean>): void;
        
        
        /**
         * Closes a WebSocket connection.
         * @permission ohos.permission.INTERNET
         * @param { WebSocketCloseOptions } options - Optional parameters {@link WebSocketCloseOptions}.
         * @param { AsyncCallback<boolean> } callback - the callback of close.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        close(options: WebSocketCloseOptions, callback: AsyncCallback<boolean>): void;
        
        
        /**
         * Closes a WebSocket connection.
         * @permission ohos.permission.INTERNET
         * @param { WebSocketCloseOptions } options - Optional parameters {@link WebSocketCloseOptions}.
         * @returns { Promise<boolean> } The promise returned by the function.
         * @throws { BusinessError } 401 - Parameter error.
         * @throws { BusinessError } 201 - Permission denied.
         * @syscap SystemCapability.Communication.NetStack
         * @since 20
         */
        close(options?: WebSocketCloseOptions): Promise<boolean>;
    }
}
export default webSocket;
