/*
* Copyright (c) 2022-2024 Huawei Device Co., Ltd.
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
 * @kit AVSessionKit
 */
import type { ErrorCallback, AsyncCallback, Callback } from './@ohos.base';
import { WantAgent } from './@ohos.wantAgent';
import { KeyEvent } from './@ohos.multimodalInput.keyEvent';
import { ElementName } from './bundleManager/ElementName';
import image from './@ohos.multimedia.image';
import audio from './@ohos.multimedia.audio';
import { AVCastPickerState, AVCastPickerColorMode } from './@ohos.multimedia.avCastPickerParam';
import type media from './@ohos.multimedia.media';
import type Context from './application/BaseContext';
import type hdrCapability from './@ohos.graphics.hdrCapability';

/**
 * @namespace avSession
 * @syscap SystemCapability.Multimedia.AVSession.Core
 * @since 20
 */
declare namespace avSession {
    /**
     * Create an AVSession instance. An ability can only create one AVSession
     * @param { Context } context - The context of application
     * @param { string } tag - A user-defined name for this session
     * @param { AVSessionType } type - The type of session {@link AVSessionType}
     * @param { AsyncCallback<AVSession> } callback - async callback for AVSession.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    function createAVSession(context: Context, tag: string, type: AVSessionType, callback: AsyncCallback<AVSession>): void;
    
    /**
     * Create an AVSession instance. An ability can only create one AVSession
     * @param { Context } context - The context of application
     * @param { string } tag - A user-defined name for this session
     * @param { AVSessionType } type - The type of session {@link AVSessionType}
     * @returns { Promise<AVSession> } Promise for AVSession
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    function createAVSession(context: Context, tag: string, type: AVSessionType): Promise<AVSession>;
    /**
     * Get all avsession descriptors of the system
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { AsyncCallback<Array<Readonly<AVSessionDescriptor>>> } callback - async callback for an array of AVSessionDescriptors.
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function getAllSessionDescriptors(callback: AsyncCallback<Array<Readonly<AVSessionDescriptor>>>): void;
    /**
     * Get all avsession descriptors of the system
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @returns { Promise<Array<Readonly<AVSessionDescriptor>>> } Promise for an array of AVSessionDescriptors
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function getAllSessionDescriptors(): Promise<Array<Readonly<AVSessionDescriptor>>>;
    /**
     * Get history avsession records. These sessions have been destroyed.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { int } maxSize - Specifies the maximum size of the returned value array.
     * @param { AsyncCallback<Array<Readonly<AVSessionDescriptor>>> } callback - async callback for an array of AVSessionDescriptors.
     * If provided '0' or not provided, the maximum value is determined by the system.
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App
     * @throws { BusinessError } 401 - parameter check failed. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi Hide this for inner system use
     * @since 20
     */
    function getHistoricalSessionDescriptors(maxSize: int, callback: AsyncCallback<Array<Readonly<AVSessionDescriptor>>>): void;
    /**
     * Get history avsession records. These sessions have been destroyed.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { int } maxSize - Specifies the maximum size of the returned value array.
     * If provided '0' or not provided, the maximum value is determined by the system.
     * @returns { Promise<Array<Readonly<AVSessionDescriptor>>> } Promise for an array of AVSessionDescriptors
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi Hide this for inner system use
     * @since 20
     */
    function getHistoricalSessionDescriptors(maxSize?: int): Promise<Array<Readonly<AVSessionDescriptor>>>;
    /**
     * Get history play list information records.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { int } maxSize - Specifies the maximum size of the returned value array.
     * @param { int } maxAppSize - Specifies the maximum app size of the returned value array.
     * @param { AsyncCallback<Array<Readonly<AVQueueInfo>>> } callback - async callback for an array of AVQueueInfo.
     * If provided '0' or not provided, the maximum value is determined by the system.
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi Hide this for inner system use
     * @since 20
     */
    function getHistoricalAVQueueInfos(maxSize: int, maxAppSize: int, callback: AsyncCallback<Array<Readonly<AVQueueInfo>>>): void;
    /**
     * Get history play list information records.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { int } maxSize - Specifies the maximum size of the returned value array.
     * @param { int } maxAppSize - Specifies the maximum app size of the returned value array.
     * @returns { Promise<Array<Readonly<AVQueueInfo>>> } Promise for an array of AVQueueInfo
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi Hide this for inner system use
     * @since 20
     */
    function getHistoricalAVQueueInfos(maxSize: int, maxAppSize: int): Promise<Array<Readonly<AVQueueInfo>>>;
    /**
     * Create an avsession controller
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { string } sessionId - Specifies the sessionId to create the controller.
     * @param { AsyncCallback<AVSessionController> } callback - async callback for AVSessionController.
     * If provided 'default', the system will create a default controller, Used to control the system default session
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600102 - The session does not exist.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function createController(sessionId: string, callback: AsyncCallback<AVSessionController>): void;
    /**
     * Create an avsession controller
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { string } sessionId - Specifies the sessionId to create the controller.
     * If provided 'default', the system will create a default controller, Used to control the system default session
     * @returns { Promise<AVSessionController> } Promise for AVSessionController
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600102 - The session does not exist.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function createController(sessionId: string): Promise<AVSessionController>;
    /**
     * Cast Audio to the remote devices or cast back local device
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { SessionToken | 'all' } session - Specifies the sessionId which to send to remote.
     * @param { Array<audio.AudioDeviceDescriptor> } audioDevices - Specifies the audio devices to cast.
     * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
     * 'all' means cast all the media audio of this device to remote.
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600102 - The session does not exist.
     * @throws { BusinessError } 6600104 - The remote session connection failed.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function castAudio(session: SessionToken | 'all', audioDevices: Array<audio.AudioDeviceDescriptor>, callback: AsyncCallback<void>): void;
    /**
     * Cast Audio to the remote devices or cast back local device
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { SessionToken | 'all' } session - Specifies the sessionId which to send to remote.
     * @param { Array<audio.AudioDeviceDescriptor> } audioDevices - Specifies the audio devices to cast.
     * @returns { Promise<void> } void promise when executed successfully
     * 'all' means cast all the media audio of this device to remote.
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600102 - The session does not exist.
     * @throws { BusinessError } 6600104 - The remote session  connection failed.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function castAudio(session: SessionToken | 'all', audioDevices: Array<audio.AudioDeviceDescriptor>): Promise<void>;
    /**
     * Start an application for media playback.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { string } bundleName - Specifies the bundleName which to be started.
     * @param { string } assetId - Specifies the assetId to be started.
     * @returns { Promise<void> } void promise when executed successfully
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App. Interface caller is not a system app.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function startAVPlayback(bundleName: string, assetId: string): Promise<void>;
    /**
     * Get distributed avsession controller
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { DistributedSessionType } distributedSessionType - Specifies the distributed session type.
     * @returns { Promise<Array<AVSessionController>> } Promise for AVSessionController.
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600109 - The remote connection is not established.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function getDistributedSessionController(distributedSessionType: DistributedSessionType): Promise<Array<AVSessionController>>;
    /**
     * Session token. Used to judge the legitimacy of the session.
     * @typedef SessionToken
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    interface SessionToken {
        /**
         * The unique session id of the avsession object
         * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
         * @type { string }
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        sessionId: string;
        /**
         * Process id of session
         * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
         * @type { ?long }
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        pid?: long;
        /**
         * User id
         * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
         * @type { ?long }
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        uid?: long;
    }
    /**
     * Register session create callback
     * @param { 'sessionCreate' } type - Registration Type, 'sessionCreate'
     * @param { function } callback - Used to handle ('sessionCreate' command)
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function on(type: 'sessionCreate', callback: (session: AVSessionDescriptor) => void): void;
    /**
     * Register session destroy callback
     * @param { 'sessionDestroy' } type - Registration Type, 'sessionDestroy'
     * @param { function } callback - Used to handle ('sessionDestroy' command)
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function on(type: 'sessionDestroy', callback: (session: AVSessionDescriptor) => void): void;
    /**
     * Register top session changed callback
     * @param { 'topSessionChange' } type - Registration Type, top priority session change, 'topSessionChange'
     * @param { function } callback - Used to handle ('topSessionChange' command)
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function on(type: 'topSessionChange', callback: (session: AVSessionDescriptor) => void): void;
    /**
     * Unregister session create callback
     * @param { 'sessionCreate' } type - Registration Type, session creation, 'sessionCreate'
     * @param { function } callback - Used to unregister listener for ('sessionCreate') command
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function off(type: 'sessionCreate', callback?: (session: AVSessionDescriptor) => void): void;
    /**
     * Unregister session destroy callback
     * @param { 'sessionDestroy' } type - Registration Type, session deletion, 'sessionDestroy'
     * @param { function } callback - Used to unregister listener for ('sessionDestroy') command
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function off(type: 'sessionDestroy', callback?: (session: AVSessionDescriptor) => void): void;
    /**
     * Unregister top session changed callback
     * @param { 'topSessionChange' } type - Registration Type, top priority session change, 'topSessionChange'
     * @param { function } callback - Used to unregister listener for ('topSessionChange') command
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function off(type: 'topSessionChange', callback?: (session: AVSessionDescriptor) => void): void;
    /**
     * Register Session service death callback, notifying the application to clean up resources.
     * @param { 'sessionServiceDie' } type - Registration Type, 'sessionServiceDie'
     * @param { function } callback - Used to handle ('sessionServiceDie') command.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @systemapi
     * @since 20
     */
    function on(type: 'sessionServiceDie', callback: () => void): void;
    /**
     * Unregister Session service death callback, notifying the application to clean up resources.
     * @param { 'sessionServiceDie' } type - Registration Type, 'sessionServiceDie'
     * @param { function } callback -  Used to unregister listener for ('sessionServiceDie') command.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @systemapi
     * @since 20
     */
    function off(type: 'sessionServiceDie', callback?: () => void): void;
    /**
     * Register distributed   session changed callback
     * @param { 'distributedSessionChange' } type - Registration Type, distributed session change
     * @param { DistributedSessionType } distributedSessionType - Indicates the distributed session type
     * @param { Callback<Array<AVSessionController>> } callback - The callback will return remote changed AVSessionController.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function on(type: 'distributedSessionChange', distributedSessionType: DistributedSessionType, callback: Callback<Array<AVSessionController>>): void;
    /**
     * Unregister distributed session changed callback
     * @param { 'distributedSessionChange' } type - Registration Type, distributed session change
     * @param { DistributedSessionType } distributedSessionType - Indicates the distributed session type
     * @param { Callback<Array<AVSessionController>> } callback - The callback will return remote changed AVSessionController.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function off(type: 'distributedSessionChange', distributedSessionType: DistributedSessionType, callback?: Callback<Array<AVSessionController>>): void;
    /**
     * Send system media key event.The system automatically selects the recipient.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { KeyEvent } event - The key event to be sent
     * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600105 - Invalid session command.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function sendSystemAVKeyEvent(event: KeyEvent, callback: AsyncCallback<void>): void;
    /**
     * Send system media key event.The system automatically selects the recipient.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { KeyEvent } event - The key event to be sent
     * @returns { Promise<void> } void promise when executed successfully
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600105 - Invalid session command.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function sendSystemAVKeyEvent(event: KeyEvent): Promise<void>;
    /**
     * Send system control command.The system automatically selects the recipient.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { AVControlCommand } command - The command to be sent. See {@link AVControlCommand}
     * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600105 - Invalid session command.
     * @throws { BusinessError } 6600107 - Too many commands or events.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function sendSystemControlCommand(command: AVControlCommand, callback: AsyncCallback<void>): void;
    /**
     * Send system control command.The system automatically selects the recipient.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { AVControlCommand } command - The command to be sent. See {@link AVControlCommand}
     * @returns { Promise<void> } void promise when executed successfully
     * @throws { BusinessError } 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600105 - Invalid session command.
     * @throws { BusinessError } 6600107 - Too many commands or events.
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    function sendSystemControlCommand(command: AVControlCommand): Promise<void>;
    
    /**
     * Define different protocol capability
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    enum ProtocolType {
        
        /**
         * The default cast type "local", media can be routed on the same device,
         * including internal speakers or audio jack on the device itself, A2DP devices.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        TYPE_LOCAL = 0,
        /**
         * Cast+ mirror capability
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        TYPE_CAST_PLUS_MIRROR = 1,
        
        /**
         * The Cast+ Stream indicating the media is presenting on a different device
         * the application need get an AVCastController to control remote playback.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        TYPE_CAST_PLUS_STREAM = 2,
        /**
         * The DLNA type indicates the device supports DLNA protocol,
         * the application needs to get an AVCastController to control remote playback.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        TYPE_DLNA = 4
    }
    /**
     * Define different distributed session type
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    enum DistributedSessionType {
        /**
         * Remote session sensed from remote device.
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        TYPE_SESSION_REMOTE = 0,
        /**
         * Migrated session from remote device to this device.
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        TYPE_SESSION_MIGRATE_IN = 1,
        /**
         * Migrated session from this device to remote device.
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        TYPE_SESSION_MIGRATE_OUT = 2
    }
    /**
     * Start device discovery.
     * @param { AsyncCallback<void> } callback a callback function
     * @throws { BusinessError } 202 - Not System App.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function startCastDeviceDiscovery(callback: AsyncCallback<void>): void;
    /**
     * Start device discovery.
     * @param { int } filter device filter when discovering, can be an union of {@link ProtocolType}
     * @param { AsyncCallback<void> } callback a callback function
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function startCastDeviceDiscovery(filter: int, callback: AsyncCallback<void>): void;
    
    /**
     * Start device discovery.
     * @param { int } [filter] - device filter when discovering, can be an union of {@link ProtocolType}
     * @param { Array<string> } [drmSchemes] - filter drm-enabled devices which are represented by uuid.
     * It is effective when protocol type is TYPE_CAST_PLUS_STREAM.
     * @returns { Promise<void> } Promise for the result
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function startCastDeviceDiscovery(filter?: int, drmSchemes?: Array<string>): Promise<void>;
    /**
     * Stop device discovery.
     * @param { AsyncCallback<void> } callback a callback function
     * @throws { BusinessError } 202 - Not System App.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function stopCastDeviceDiscovery(callback: AsyncCallback<void>): void;
    /**
     * Stop device discovery.
     * @returns { Promise<void> } Promise for the result
     * @throws { BusinessError } 202 - Not System App.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function stopCastDeviceDiscovery(): Promise<void>;
    /**
     * Enable or disable device to be discoverable, used at sink side.
     * @param { boolean } enable true: can be discoverable, false: cannot be discoverable.
     * @param { AsyncCallback<void> } callback a callback function
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function setDiscoverable(enable: boolean, callback: AsyncCallback<void>): void;
    /**
     * Enable or disable device to be discoverable, used at sink side.
     * @param { boolean } enable true: can be discoverable, false: cannot be discoverable.
     * @returns { Promise<void> } Promise for the result
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function setDiscoverable(enable: boolean): Promise<void>;
    /**
     * Register device discovery callback
     * @param { 'deviceAvailable' } type Registration Type
     * @param { function } callback Used to returns the device info
     * @throws { BusinessError } 202 - Not System App.
     * @throws {BusinessError} 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function on(type: 'deviceAvailable', callback: (device: OutputDeviceInfo) => void): void;
    /**
     * Unregister device discovery callback
     * @param { 'deviceAvailable' } type Registration Type
     * @param { function } callback Used to returns the device info
     * @throws { BusinessError } 202 - Not System App.
     * @throws {BusinessError} 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function off(type: 'deviceAvailable', callback?: (device: OutputDeviceInfo) => void): void;
    /**
     * Register device offline callback
     * @param { 'deviceOffline' } type - Registration Type
     * @param { function } callback - Used to returns the device info
     * @throws { BusinessError } 202 - Not System App.
     * @throws {BusinessError} 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function on(type: 'deviceOffline', callback: (deviceId: string) => void): void;
    /**
     * Unregister device offline callback
     * @param { 'deviceOffline' } type - Registration Type
     * @param { function } callback - Used to returns the device info
     * @throws { BusinessError } 202 - Not System App.
     * @throws {BusinessError} 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function off(type: 'deviceOffline', callback?: (deviceId: string) => void): void;
    /**
     * Register a callback to retrieve an avsession cast controller.
     * This function can be used at both side to get the same controller to do the playback control.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { string } sessionId Specifies the sessionId to get controller.
     * @param { AsyncCallback<AVCastController> } callback - async callback for the AVCastController.
     * @throws {BusinessError} 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws {BusinessError} 6600101 - Session service exception
     * @throws {BusinessError} 6600102 - session does not exist
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function getAVCastController(sessionId: string, callback: AsyncCallback<AVCastController>): void;
    /**
     * Get the current session's remote controller client.
     * If the avsession is not under casting state, the controller will return null.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { string } sessionId Specifies the sessionId to get controller.
     * @returns { Promise<AVCastController> } Promise for the AVCastController
     * @throws {BusinessError} 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Parameter verification failed.
     * @throws {BusinessError} 6600101 - server exception
     * @throws {BusinessError} 6600102 - session does not exist
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function getAVCastController(sessionId: string): Promise<AVCastController>;
    /**
     * Cast resource to remote device.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { SessionToken } session Specifies the sessionId which is to be casted.
     * @param { OutputDeviceInfo } device Specifies the device to cast.
     * @param { AsyncCallback<void> } callback A callback instance used to return when start casting.
     * @throws {BusinessError} 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws {BusinessError} 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed.
     * @throws {BusinessError} 6600101 - Session service exception
     * @throws {BusinessError} 6600108 - Device connecting failed
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function startCasting(session: SessionToken, device: OutputDeviceInfo, callback: AsyncCallback<void>): void;
    /**
     * Cast resource to remote device.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { SessionToken } session Specifies the sessionId which is to be casted.
     * @param { OutputDeviceInfo } device Specifies the device to cast.
     * @returns { Promise<void> } Promise for the result
     * @throws {BusinessError} 201 - permission denied
     * @throws { BusinessError } 202 - Not System App.
     * @throws {BusinessError} 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed.
     * @throws {BusinessError} 6600101 - Session service exception
     * @throws {BusinessError} 6600108 - Device connecting failed
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function startCasting(session: SessionToken, device: OutputDeviceInfo): Promise<void>;
    /**
     * Stop current cast and disconnect device connection.
     * @param { SessionToken } session Specifies the sessionId which is to be stopped.
     * @param { AsyncCallback<void> } callback A callback instance used to return when cast stopped completed.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed.
     * @throws { BusinessError } 6600109 - The remote connection is not established
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function stopCasting(session: SessionToken, callback: AsyncCallback<void>): void;
    /**
     * Stop current cast and disconnect device connection.
     * @param { SessionToken } session Specifies the sessionId which is to be stopped.
     * @returns { Promise<void> } Promise for the result
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed.
     * @throws { BusinessError } 6600109 - The remote connection is not established
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function stopCasting(session: SessionToken): Promise<void>;
    /**
     * Begin to write device logs into a file descriptor for the purpose of problem locating.
     * If the logs exceed max file size, no logs will be written and DEVICE_LOG_FULL event will be omitted.
     * @param { string } url - The file descriptor to be written.
     * @param { int } maxSize - The max size to be written in kilobyte.
     * if not set, then written process will exit when there is no space to write.
     * @returns { Promise<void> } Promise for the result
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600102 - The session does not exist.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function startDeviceLogging(url: string, maxSize?: int): Promise<void>;
    /**
     * Stop the current device written even the discovery is ongoing.
     * @returns { Promise<void> } Promise for the result
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600102 - The session does not exist.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function stopDeviceLogging(): Promise<void>;
    /**
     * Register log event callback.
     * @param { 'deviceLogEvent' } type - Command to register 'deviceLogEvent'.
     * @param { Callback<DeviceLogEventCode> } callback - Used to handle ('deviceLogEvent') command
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600102 - The session does not exist.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function on(type: 'deviceLogEvent', callback: Callback<DeviceLogEventCode>): void;
    /**
     * UnRegister log event callback.
     * @param { 'deviceLogEvent' } type - Command to register 'deviceLogEvent'.
     * @param { Callback<DeviceLogEventCode> } callback - Used to handle ('deviceLogEvent') command
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
     * 2. Incorrect parameter types.
     * @throws { BusinessError } 6600101 - Session service exception.
     * @throws { BusinessError } 6600102 - The session does not exist.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function off(type: 'deviceLogEvent', callback?: Callback<DeviceLogEventCode>): void;
    /**
     * Enumerates device log event code.
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    enum DeviceLogEventCode {
        /**
         * Log is full.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        DEVICE_LOG_FULL = 1,
        /**
         * Log is written with exception, such as the fd cannot be written and so on.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        DEVICE_LOG_EXCEPTION = 2
    }
    /**
     * Device state used to describe states including discovery, authentication and other scenes.
     * @typedef DeviceState
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    interface DeviceState {
        /**
         * Unique device descriptor.
         * @type { string }
         * @readonly
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        readonly deviceId: string;
        /**
         * Device connection state.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        readonly deviceState: int;
        /**
         * Reason for connection failure, for example, user cancellation and timeout.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        readonly reasonCode: int;
        /**
         * System radar error code returned by cast+services.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        readonly radarErrorCode: int;
    }
    /**
     * Registers a system callback for the device connection phase.
     * The callback includes information such as error codes, connection status, radar errors, and user behavior codes.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { 'deviceStateChanged' } type - Event Type.
     * @param { Callback<DeviceState> } callback - Used to returns the device info
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function on(type: 'deviceStateChanged', callback: Callback<DeviceState>): void;
    /**
     * Unregisters a system callback for the device connection phase.
     * @permission ohos.permission.MANAGE_MEDIA_RESOURCES
     * @param { 'deviceStateChanged' } type - Event Type.
     * @param { Callback<DeviceState> } [callback] - Used to returns the device info
     * @throws { BusinessError } 201 - permission denied.
     * @throws { BusinessError } 202 - Not System App.
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @systemapi
     * @since 20
     */
    function off(type: 'deviceStateChanged', callback?: Callback<DeviceState>): void;
    
    
    /**
     * Session type supports audio & video, voice_call, video_call
     * @typedef { 'audio' | 'video' | 'voice_call' | 'video_call' } AVSessionType
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    type AVSessionType = 'audio' | 'video' | 'voice_call' | 'video_call';
    
    /**
     * AVSession object.
     * @interface AVSession
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface AVSession {
        
        /**
         * unique session Id
         * @type { string }
         * @readonly
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        readonly sessionId: string;
        
        /**
         * Get current session type
         * @type { AVSessionType }
         * @readonly
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        readonly sessionType: AVSessionType;
        /**
         * Set the metadata of this session.
         * In addition to the required properties, users can fill in partially supported properties
         * @param { AVMetadata } data {@link AVMetadata}
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setAVMetadata(data: AVMetadata, callback: AsyncCallback<void>): void;
        
        /**
         * Set the metadata of this session.
         * In addition to the required properties, users can fill in partially supported properties
         * @param { AVMetadata } data {@link AVMetadata}
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setAVMetadata(data: AVMetadata): Promise<void>;
        /**
         * Set the metadata related with current call.
         * @param { CallMetadata } data - {@link CallMetadata}
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setCallMetadata(data: CallMetadata, callback: AsyncCallback<void>): void;
        /**
         * Set the metadata related with current call.
         * @param { CallMetadata } data - {@link CallMetadata}
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setCallMetadata(data: CallMetadata): Promise<void>;
        /**
         * Set the playback state of this session.
         * @param { AVPlaybackState } state {@link AVPlaybackState}
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setAVPlaybackState(state: AVPlaybackState, callback: AsyncCallback<void>): void;
        
        /**
         * Set the playback state of this session.
         * @param { AVPlaybackState } state {@link AVPlaybackState}
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setAVPlaybackState(state: AVPlaybackState): Promise<void>;
        /**
         * Set the call state of this session.
         * @param { AVCallState } state - {@link AVCallState}
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setAVCallState(state: AVCallState, callback: AsyncCallback<void>): void;
        /**
         * Set the call state of this session.
         * @param { AVCallState } state - {@link AVCallState}
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setAVCallState(state: AVCallState): Promise<void>;
        /**
         * Set the ability to start the session corresponding to
         * @param { WantAgent } ability - The WantAgent for launch the ability
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setLaunchAbility(ability: WantAgent, callback: AsyncCallback<void>): void;
        
        /**
         * Set the ability to start the session corresponding to
         * @param { WantAgent } ability - The WantAgent for launch the ability
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setLaunchAbility(ability: WantAgent): Promise<void>;
        
        /**
         * Dispatch the session event of this session.
         * @param { string } event - Session event name to dispatch
         * @param { Record<string, Object> } args - The parameters of session event
         * @param { AsyncCallback<void>} callback - The asyncCallback triggered when the command is executed successfully
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        dispatchSessionEvent(event: string, args: Record<string, Object>, callback: AsyncCallback<void>): void;
        
        
        /**
         * Dispatch the session event of this session.
         * @param { string } event - Session event name to dispatch
         * @param { Record<string, Object> } args - The parameters of session event
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        dispatchSessionEvent(event: string, args: Record<string, Object>): Promise<void>;
        /**
         * Set the playlist of queueItem. Identifies the content of the playlist presented by this session.
         * @param { Array<AVQueueItem> } items - An array of the AVQueueItem
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setAVQueueItems(items: Array<AVQueueItem>, callback: AsyncCallback<void>): void;
        
        /**
         * Set the playlist of queueItem. Identifies the content of the playlist presented by this session.
         * @param { Array<AVQueueItem> } items - An array of the AVQueueItem
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setAVQueueItems(items: Array<AVQueueItem>): Promise<void>;
        /**
         * Set the name of the playlist presented by this session.
         * @param { string } title - The name of the playlist
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setAVQueueTitle(title: string, callback: AsyncCallback<void>): void;
        
        /**
         * Set the name of the playlist presented by this session.
         * @param { string } title - The name of the playlist
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setAVQueueTitle(title: string): Promise<void>;
        
        /**
         * Set the custom media packets for this session.
         * @param { Record<string, Object> } extras - The custom media packets
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setExtras(extras: Record<string, Object>, callback: AsyncCallback<void>): void;
        
        
        /**
         * Set the custom media packets for this session.
         * @param { Record<string, Object> } extras - The custom media packets
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        setExtras(extras: Record<string, Object>): Promise<void>;
        /**
         * Get the current session's own controller
         * @param { AsyncCallback<AVSessionController> } callback - async callback for the AVSessionController.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getController(callback: AsyncCallback<AVSessionController>): void;
        
        /**
         * Get the current session's own controller
         * @returns { Promise<AVSessionController> } Promise for the AVSessionController
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getController(): Promise<AVSessionController>;
        /**
         * Get the cast controller when the session is casted to remote device.
         * If the avsession is not under casting state, the controller will return null.
         * @param { AsyncCallback<AVCastController> } callback - async callback for the AVCastController.
         * @throws {BusinessError} 6600102 - The session does not exist
         * @throws {BusinessError} 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getAVCastController(callback: AsyncCallback<AVCastController>): void;
        
        /**
         * Get the cast controller when the session is casted to remote device.
         * If the avsession is not under casting state, the controller will return null.
         * @returns { Promise<AVCastController> } Promise for the AVCastController
         * @throws {BusinessError} 6600102 - The session does not exist
         * @throws {BusinessError} 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getAVCastController(): Promise<AVCastController>;
        /**
         * Get output device information
         * @param { AsyncCallback<OutputDeviceInfo> } callback - async callback for the OutputDeviceInfo.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getOutputDevice(callback: AsyncCallback<OutputDeviceInfo>): void;
        
        /**
         * Get output device information
         * @returns { Promise<OutputDeviceInfo> } Promise for the OutputDeviceInfo
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getOutputDevice(): Promise<OutputDeviceInfo>;
        
        /**
         * Get output device information
         * @returns { OutputDeviceInfo } the OutputDeviceInfo
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getOutputDeviceSync(): OutputDeviceInfo;
        /**
         * Get all the current virtual display information for extended display.
         * @returns { Promise<Array<CastDisplayInfo>> } Promise for the CastDisplayInfo
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
         * @since 20
         */
        getAllCastDisplays(): Promise<Array<CastDisplayInfo>>;
        
        /**
         * Register play command callback.
         * As long as it is registered, it means that the ability supports this command.
         * If you cancel the callback, you need to call off {@link off}
         * When canceling the callback, need to update the supported commands list.
         * Each playback command only supports registering one callback,
         * and the new callback will replace the previous one.
         * @param { 'play' } type - Command to register 'play'.
         * @param { function } callback - Used to handle ('play') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'play', callback: () => void): void;
        
        /**
         * Register pause command callback.
         * As long as it is registered, it means that the ability supports this command.
         * If you cancel the callback, you need to call off {@link off}
         * When canceling the callback, need to update the supported commands list.
         * Each playback command only supports registering one callback,
         * and the new callback will replace the previous one.
         * @param { 'pause' } type - Command to register 'pause'.
         * @param { function } callback - Used to handle ('pause') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'pause', callback: () => void): void;
        
        /**
         * Register stop command callback.
         * As long as it is registered, it means that the ability supports this command.
         * If you cancel the callback, you need to call off {@link off}
         * When canceling the callback, need to update the supported commands list.
         * Each playback command only supports registering one callback,
         * and the new callback will replace the previous one.
         * @param { 'stop' } type - Command to register 'stop'.
         * @param { function } callback - Used to handle ('stop') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'stop', callback: () => void): void;
        
        /**
         * Register playNext command callback.
         * As long as it is registered, it means that the ability supports this command.
         * If you cancel the callback, you need to call off {@link off}
         * When canceling the callback, need to update the supported commands list.
         * Each playback command only supports registering one callback,
         * and the new callback will replace the previous one.
         * @param { 'playNext' } type - Command to register 'playNext'.
         * @param { function } callback - Used to handle ('playNext') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'playNext', callback: () => void): void;
        
        /**
         * Register playPrevious command callback.
         * As long as it is registered, it means that the ability supports this command.
         * If you cancel the callback, you need to call off {@link off}
         * When canceling the callback, need to update the supported commands list.
         * Each playback command only supports registering one callback,
         * and the new callback will replace the previous one.
         * @param { 'playPrevious' } type - Command to register 'playPrevious'.
         * @param { function } callback - Used to handle ('playPrevious') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'playPrevious', callback: () => void): void;
        
        /**
         * Register fastForward command callback.
         * As long as it is registered, it means that the ability supports this command.
         * If you cancel the callback, you need to call off {@link off}
         * When canceling the callback, need to update the supported commands list.
         * Each playback command only supports registering one callback,
         * and the new callback will replace the previous one.
         * @param { 'fastForward' } type - Command to register 'fastForward'.
         * @param { function } callback - Used to handle ('fastForward') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'fastForward', callback: (time?: long) => void): void;
        
        /**
         * Register rewind command callback.
         * As long as it is registered, it means that the ability supports this command.
         * If you cancel the callback, you need to call off {@link off}
         * When canceling the callback, need to update the supported commands list.
         * Each playback command only supports registering one callback,
         * and the new callback will replace the previous one.
         * @param { 'rewind' } type - Command to register 'rewind'.
         * @param { function } callback - Used to handle ('rewind') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'rewind', callback: (time?: long) => void): void;
        
        /**
         * Unregister play command callback.
         * When canceling the callback, need to update the supported commands list.
         * @param { 'play' } type - Command to register 'play'.
         * @param { function } callback - Used to handle ('play') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'play', callback?: () => void): void;
        
        /**
         * Unregister pause command callback.
         * When canceling the callback, need to update the supported commands list.
         * @param { 'pause' } type - Command to register 'pause'.
         * @param { function } callback - Used to handle ('pause') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'pause', callback?: () => void): void;
        
        /**
         * Unregister stop command callback.
         * When canceling the callback, need to update the supported commands list.
         * @param { 'stop' } type - Command to register 'stop'.
         * @param { function } callback - Used to handle ('stop') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'stop', callback?: () => void): void;
        
        /**
         * Unregister playNext command callback.
         * When canceling the callback, need to update the supported commands list.
         * @param { 'playNext' } type - Command to register 'playNext'.
         * @param { function } callback - Used to handle ('playNext') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'playNext', callback?: () => void): void;
        
        /**
         * Unregister playPrevious command callback.
         * When canceling the callback, need to update the supported commands list.
         * @param { 'playPrevious' } type - Command to register 'playPrevious'.
         * @param { function } callback - Used to handle ('playPrevious') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'playPrevious', callback?: () => void): void;
        
        /**
         * Unregister fastForward command callback.
         * When canceling the callback, need to update the supported commands list.
         * @param { 'fastForward' } type - Command to register 'fastForward'.
         * @param { function } callback - Used to handle ('fastForward') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'fastForward', callback?: () => void): void;
        
        /**
         * Unregister rewind command callback.
         * When canceling the callback, need to update the supported commands list.
         * @param { 'rewind' } type - Command to register 'rewind'.
         * @param { function } callback - Used to handle ('rewind') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'rewind', callback?: () => void): void;
        
        /**
         * Register seek command callback
         * @param { 'seek' } type - Registration Type 'seek'
         * @param { function } callback - Used to handle seek command.The callback provides the seek time(ms)
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'seek', callback: (time: long) => void): void;
        
        /**
         * Unregister seek command callback
         * @param { 'seek' } type - Registration Type 'seek'
         * @param { function } callback - Used to handle seek command.The callback provides the seek time(ms)
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'seek', callback?: (time: long) => void): void;
        
        /**
         * Register setSpeed command callback
         * @param { 'setSpeed' } type - Registration Type 'setSpeed'
         * @param { function } callback - Used to handle setSpeed command.The callback provides the speed value
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'setSpeed', callback: (speed: double) => void): void;
        
        /**
         * Unregister setSpeed command callback
         * @param { 'setSpeed' } type - Registration Type 'setSpeed'
         * @param { function } callback - Used to handle setSpeed command.The callback provides the speed value
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'setSpeed', callback?: (speed: double) => void): void;
        
        /**
         * Register setLoopMode command callback
         * @param { 'setLoopMode' } type - Registration Type 'setLoopMode'
         * @param { function } callback - Used to handle setLoopMode command.The callback provides the {@link LoopMode}
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'setLoopMode', callback: (mode: LoopMode) => void): void;
        
        /**
         * Unregister setLoopMode command callback
         * @param { 'setLoopMode' } type - Registration Type 'setLoopMode'
         * @param { function } callback - Used to handle setLoopMode command.The callback provides the {@link LoopMode}
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'setLoopMode', callback?: (mode: LoopMode) => void): void;
        
        /**
         * Register toggle favorite command callback
         * @param { 'toggleFavorite' } type - Registration Type 'toggleFavorite'
         * @param { function } callback - Used to handle toggleFavorite command.The callback provides
         * the assetId for which the favorite status needs to be switched.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'toggleFavorite', callback: (assetId: string) => void): void;
        
        /**
         * Unregister toggle favorite command callback
         * @param { 'toggleFavorite' } type - Registration Type 'toggleFavorite'
         * @param { function } callback - Used to handle toggleFavorite command.The callback provides
         * the assetId for which the favorite status needs to be switched.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'toggleFavorite', callback?: (assetId: string) => void): void;
        
        /**
         * Register media key handling callback
         * @param { 'handleKeyEvent' } type - Registration Type 'handleKeyEvent'
         * @param { function } callback - Used to handle key events.The callback provides the KeyEvent
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'handleKeyEvent', callback: (event: KeyEvent) => void): void;
        
        /**
         * Unregister media key handling callback
         * @param { 'handleKeyEvent' } type - Registration Type 'handleKeyEvent'
         * @param { function } callback - Used to handle key events.The callback provides the KeyEvent
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'handleKeyEvent', callback?: (event: KeyEvent) => void): void;
        
        /**
         * Register session output device change callback
         * @param { 'outputDeviceChange' } type - Registration Type 'outputDeviceChange'
         * @param { function } callback - Used to handle output device changed.
         * The callback provide the new device info {@link OutputDeviceInfo} and related connection state {@link ConnectionState}.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @throws { BusinessError } 6600102 - The session does not exist
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'outputDeviceChange', callback: (state: ConnectionState, device: OutputDeviceInfo) => void): void;
        
        /**
         * Unregister session output device change callback
         * @param { 'outputDeviceChange' } type - Registration Type 'outputDeviceChange'
         * @param { function } callback - Used to handle output device changed.
         * The callback provide the new device info {@link OutputDeviceInfo} and related connection state {@link ConnectionState}.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @throws { BusinessError } 6600102 - The session does not exist
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'outputDeviceChange', callback?: (state: ConnectionState, device: OutputDeviceInfo) => void): void;
        
        
        /**
         * Register session custom command change callback
         * @param { 'commonCommand' } type - Registration Type 'commonCommand'
         * @param { function } callback - Used to handle event when the common command is received
         *     The callback provide the command name and command args
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'commonCommand', callback: (command: string, args: Record<string, Object>) => void): void;
        
        
        /**
         * Unregister session custom command change callback
         * @param { 'commonCommand' } type - Registration Type 'commonCommand'
         * @param { function } callback - Used to cancel a specific listener
         *     The callback provide the command name and command args
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'commonCommand', callback?: (command: string, args: Record<string, Object>) => void): void;
        
        /**
         * Register the item to play from the playlist change callback
         * @param { 'skipToQueueItem' } type - Registration Type 'skipToQueueItem'
         * @param { function } callback - Used to handle the item to be played.
         * The callback provide the new device info {@link OutputDeviceInfo}
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'skipToQueueItem', callback: (itemId: int) => void): void;
        
        /**
         * Unregister the item to play from the playlist change callback
         * @param { 'skipToQueueItem' } type - Registration Type 'skipToQueueItem'
         * @param { function } callback - Used to handle the item to be played.
         * The callback provide the new device info {@link OutputDeviceInfo}
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'skipToQueueItem', callback?: (itemId: int) => void): void;
        
        /**
         * Register answer command callback.
         * As long as it is registered, it means that the ability supports this command.
         * If you cancel the callback, you need to call off {@link off}
         * @param { 'answer' } type - Command to register 'answer'.
         * @param { Callback<void> } callback - Used to handle ('answer') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'answer', callback: Callback<void>): void;
        
        /**
         * Unregister answer command callback.
         * @param { 'answer' } type - Command to register 'answer'.
         * @param { Callback<void> } callback - Used to handle ('answer') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'answer', callback?: Callback<void>): void;
        
        /**
         * Register hangUp command callback.
         * As long as it is registered, it means that the ability supports this command.
         * If you cancel the callback, you need to call off {@link off}
         * @param { 'hangUp' } type - Command to register 'hangUp'.
         * @param { Callback<void> } callback - Used to handle ('hangUp') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'hangUp', callback: Callback<void>): void;
        
        /**
         * Unregister hangUp command callback.
         * @param { 'hangUp' } type - Command to register 'hangUp'.
         * @param { Callback<void> } callback - Used to handle ('hangUp') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'hangUp', callback?: Callback<void>): void;
        
        /**
         * Register toggleCallMute command callback.
         * As long as it is registered, it means that the ability supports this command.
         * If you cancel the callback, you need to call off {@link off}
         * @param { 'toggleCallMute' } type - Command to register 'toggleCallMute'.
         * @param { Callback<void> } callback - Used to handle ('toggleCallMute') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'toggleCallMute', callback: Callback<void>): void;
        
        /**
         * Unregister toggleCallMute command callback.
         * @param { 'toggleCallMute' } type - Command to register 'toggleCallMute'.
         * @param { Callback<void> } callback - Used to handle ('toggleCallMute') command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'toggleCallMute', callback?: Callback<void>): void;
        /**
         * Register listener for cast display information changed.
         * @param { 'castDisplayChange' } type - Type of the 'castDisplayChange' to listen for.
         * @param { Callback<CastDisplayInfo> } callback - Callback used to return cast display information.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @throws { BusinessError } 6600102 - The session does not exist
         * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
         * @since 20
         */
        on(type: 'castDisplayChange', callback: Callback<CastDisplayInfo>): void;
        /**
         * Unregister listener for cast display information changed.
         * @param { 'castDisplayChange' } type - Type of the 'castDisplayChange' to listen for.
         * @param { Callback<CastDisplayInfo> } callback - Callback used to return cast display information.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @throws { BusinessError } 6600102 - The session does not exist
         * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
         * @since 20
         */
        off(type: 'castDisplayChange', callback?: Callback<CastDisplayInfo>): void;
        /**
         * Stop current cast and disconnect device connection.
         * @param { AsyncCallback<void> } callback A callback instance used to return when cast stopped completed.
         * @throws { BusinessError } 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        stopCasting(callback: AsyncCallback<void>): void;
        
        /**
         * Stop current cast and disconnect device connection.
         * @returns { Promise<void> } void result promise when executed successfully
         * @throws { BusinessError } 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        stopCasting(): Promise<void>;
        /**
         * Activate the session, indicating that the session can accept control commands
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the session is activated.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        activate(callback: AsyncCallback<void>): void;
        
        /**
         * Activate the session, indicating that the session can accept control commands
         * @returns { Promise<void> } void result promise when executed successfully
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        activate(): Promise<void>;
        /**
         * Deactivate the session, indicating that the session not ready to accept control commands
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the session is deactivated.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        deactivate(callback: AsyncCallback<void>): void;
        
        /**
         * Deactivate the session, indicating that the session not ready to accept control commands
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        deactivate(): Promise<void>;
        /**
         * Destroy this session, the server will clean up the session resources
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        destroy(callback: AsyncCallback<void>): void;
        
        /**
         * Destroy this session, the server will clean up the session resources
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        destroy(): Promise<void>;
    }
    
    /**
     * The type of control command
     * @typedef { 'play' | 'pause' | 'stop' | 'playNext' | 'playPrevious' | 'fastForward' | 'rewind' | 'seek' |
     *     'setVolume' | 'setSpeed' | 'setLoopMode' | 'toggleFavorite' | 'toggleMute' } AVCastControlCommandType
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    type AVCastControlCommandType = 'play' | 'pause' | 'stop' | 'playNext' | 'playPrevious' | 'fastForward' | 'rewind' | 'seek' | 'setVolume' | 'setSpeed' | 'setLoopMode' | 'toggleFavorite' | 'toggleMute';
    
    /**
     * The definition of command to be sent to the session
     * @interface AVCastControlCommand
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    interface AVCastControlCommand {
        
        /**
         * The command value {@link AVCastControlCommandType}
         * @type { AVCastControlCommandType }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        command: AVCastControlCommandType;
        
        /**
         * Parameter carried in the command.
         * The seek command must carry the number parameter.
         * The setVolume command must carry the number parameter.
         * The toggleFavorite command must carry the {@link AVMediaDescription.assetId} parameter.
         * The setSpeed command must carry the {@link #media.PlaybackSpeed} parameter.
         * The setLoopMode command must carry the {@link LoopMode} parameter.
         * Other commands do not need to carry parameters.
         * @type { ?(media.PlaybackSpeed | double | string | LoopMode) }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        parameter?: media.PlaybackSpeed | double | string | LoopMode;
    }
    
    /**
     * AVCastController definition used to implement a remote control when a cast is connected
     * @interface AVCastController
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    interface AVCastController {
        /**
         * Set a surface instance to display playing view, used at sink side.
         * @param { string } surfaceId - surface id, video player will use this id get a surface instance.
         * @param { AsyncCallback<void> } callback - A callback instance used to return when set surface completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        setDisplaySurface(surfaceId: string, callback: AsyncCallback<void>): void;
        /**
         * Set a surface instance to display playing view, used at sink side.
         * @param { string } surfaceId - surface id, video player will use this id get a surface instance.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        setDisplaySurface(surfaceId: string): Promise<void>;
        /**
         * Get the playback status of the current player
         * @param { AsyncCallback<AVPlaybackState> } callback - The triggered asyncCallback when (getAVPlaybackState).
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getAVPlaybackState(callback: AsyncCallback<AVPlaybackState>): void;
        
        /**
         * Get the playback status of the current player
         * @returns { Promise<AVPlaybackState> } (AVPlaybackState) returned through promise
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getAVPlaybackState(): Promise<AVPlaybackState>;
        /**
         * Get supported decoders of remote player.
         * @returns { Promise<Array<DecoderType>> } (DecoderType) returned through promise
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getSupportedDecoders(): Promise<Array<DecoderType>>;
        /**
         * Get recommended resolution of remote player based on each decoder.
         * @param { DecoderType } decoderType - The decoder type.
         * @returns { Promise<ResolutionLevel> } ResolutionLevel returned through promise
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getRecommendedResolutionLevel(decoderType: DecoderType): Promise<ResolutionLevel>;
        /**
         * Get supported hdr capabilities of remote player.
         * @returns { Promise<Array<hdrCapability.HDRFormat>> } HDRFormat returned through promise
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getSupportedHdrCapabilities(): Promise<Array<hdrCapability.HDRFormat>>;
        /**
         * Get supported speed of remote player.
         * @returns { Promise<Array<double>> } supported speed returned through promise
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getSupportedPlaySpeeds(): Promise<Array<double>>;
        /**
         * Send control commands to remote player
         * @param { AVCastControlCommand } command The command to be send.
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception
         * @throws { BusinessError } 6600105 - Invalid session command
         * @throws { BusinessError } 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        sendControlCommand(command: AVCastControlCommand, callback: AsyncCallback<void>): void;
        
        /**
         * Send control commands to remote player
         * @param { AVCastControlCommand } command The command to be send.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception
         * @throws { BusinessError } 6600105 - Invalid session command
         * @throws { BusinessError } 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        sendControlCommand(command: AVCastControlCommand): Promise<void>;
        /**
         * Play the current item, should contain mediaUri otherwise the playback will fail.
         * @param { AVQueueItem } item media item info.
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
         * @throws {BusinessError} 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws {BusinessError} 6600101 - Session service exception
         * @throws {BusinessError} 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        start(item: AVQueueItem, callback: AsyncCallback<void>): void;
        
        /**
         * Play the current item, should contain mediaUri otherwise the playback will fail.
         * @param { AVQueueItem } item media item info.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws {BusinessError} 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws {BusinessError} 6600101 - Session service exception
         * @throws {BusinessError} 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        start(item: AVQueueItem): Promise<void>;
        /**
         * Load the current item and mediaUri can be null, this is needed for sink media information displaying
         * @param { AVQueueItem } item media item info.
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
         * @throws {BusinessError} 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws {BusinessError} 6600101 - Session service exception
         * @throws {BusinessError} 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        prepare(item: AVQueueItem, callback: AsyncCallback<void>): void;
        
        /**
         * Load the current item and mediaUri can be null, this is needed for sink media information displaying
         * @param { AVQueueItem } item media item info.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws {BusinessError} 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws {BusinessError} 6600101 - Session service exception
         * @throws {BusinessError} 6600109 - The remote connection is not established
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        prepare(item: AVQueueItem): Promise<void>;
        /**
         * Get the current playing item
         * @param { AsyncCallback<AVQueueItem> } callback - The triggered asyncCallback.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getCurrentItem(callback: AsyncCallback<AVQueueItem>): void;
        
        /**
         * Get the current playing item
         * @returns { Promise<AVQueueItem> } (AVQueueItem) returned through promise
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getCurrentItem(): Promise<AVQueueItem>;
        /**
         * Get commands supported by the current cast controller
         * @param { AsyncCallback<Array<AVCastControlCommandType>> } callback - The triggered asyncCallback when (getValidCommands).
         * @throws { BusinessError } 6600101 - Session service exception.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getValidCommands(callback: AsyncCallback<Array<AVCastControlCommandType>>): void;
        /**
         * Get commands supported by the current cast controller
         * @returns { Promise<Array<AVCastControlCommandType>> } array of AVCastControlCommandType promise
         * @throws { BusinessError } 6600101 - Session service exception.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        getValidCommands(): Promise<Array<AVCastControlCommandType>>;
        /**
         * Process the response corresponding to the media key request obtained by the application.
         * @param { string } assetId - The assetId of resource which provides the response.
         * @param { Uint8Array } response - Response corresponding to the request.
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        processMediaKeyResponse(assetId: string, response: Uint8Array): Promise<void>;
        /**
         * Destroy the controller
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        release(callback: AsyncCallback<void>): void;
        
        /**
         * Destroy the controller
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 6600101 - Session service exception.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        release(): Promise<void>;
        
        /**
         * Register playback state changed callback
         * @param { 'playbackStateChange' } type
         * @param { Array<string> | 'all' } filter - The properties of {@link AVPlaybackState} that you cared about
         * @param { function } callback - The callback used to handle playback state changed event.
         * The callback function provides the {@link AVPlaybackState} parameter.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'playbackStateChange', filter: Array<string> | 'all', callback: (state: AVPlaybackState) => void): void;
        
        /**
         * Unregister playback state changed callback
         * @param { 'playbackStateChange' } type
         * @param { function } callback - The callback used to handle playback state changed event.
         * The callback function provides the {@link AVPlaybackState} parameter.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'playbackStateChange', callback?: (state: AVPlaybackState) => void): void;
        
        /**
         * Register listener for current media item playback events.
         * @param { 'mediaItemChange' } type Type of the playback event to listen for.
         * @param { Callback<AVQueueItem> } callback Callback used to listen for current item changed.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'mediaItemChange', callback: Callback<AVQueueItem>): void;
        
        /**
         * Unregister listener for current media item playback events.
         * @param { 'mediaItemChange' } type Type of the playback event to listen for.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'mediaItemChange'): void;
        
        /**
         * Register playback command callback sent by remote side or media center.
         * Application needs update the new media resource when receive these commands by using playItem.
         * @param { 'playNext' } type - Type of the 'playNext' event to listen for.
         * @param { Callback<void> } callback - Used to handle 'playNext' command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'playNext', callback: Callback<void>): void;
        
        /**
         * Unregister playback command callback sent by remote side or media center.
         * When canceling the callback, need to update the supported commands list.
         * @param { 'playNext' } type - Type of the 'playNext' event to listen for.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'playNext'): void;
        
        /**
         * Register playback command callback sent by remote side or media center.
         * Application needs update the new media resource when receive these commands by using playItem.
         * @param { 'playPrevious' } type - Type of the 'playPrevious' to listen for.
         * @param { Callback<void> } callback - Used to handle 'playPrevious' command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'playPrevious', callback: Callback<void>): void;
        
        /**
         * Unregister playback command callback sent by remote side or media center.
         * When canceling the callback, need to update the supported commands list.
         * @param { 'playPrevious' } type - Type of the 'playPrevious' to listen for.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'playPrevious'): void;
        /**
         * Register requested playback command callback sent by remote side or media center.
         * The AVQueueItem may include the requested assetId, starting position and other configurations.
         * @param { 'requestPlay' } type - Type of the 'requestPlay' to listen for.
         * @param { Callback<AVQueueItem> } callback - Used to handle 'requestPlay' command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'requestPlay', callback: Callback<AVQueueItem>): void;
        /**
         * Unregister requested playback command callback sent by remote side or media center.
         * @param { 'requestPlay' } type - Type of the 'requestPlay' to listen for.
         * @param { Callback<AVQueueItem> } callback - Used to handle 'requestPlay' command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'requestPlay', callback?: Callback<AVQueueItem>): void;
        /**
         * Register endOfStream state callback.
         * Application needs update the new media resource when receive these commands by using playItem.
         * @param { 'endOfStream' } type - Type of the 'endOfStream' to listen for.
         * @param { Callback<void> } callback - Used to handle 'endOfStream' command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'endOfStream', callback: Callback<void>): void;
        /**
         * Unregister endOfStream state callback.
         * @param { 'endOfStream' } type - Type of the 'endOfStream' to listen for.
         * @param { Callback<void> } callback - Used to handle 'endOfStream' command
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'endOfStream', callback?: Callback<void>): void;
        
        /**
         * Register listens for playback events.
         * @param { 'seekDone' } type - Type of the 'seekDone' to listen for.
         * @param { Callback<int> } callback - Callback used to listen for the playback seekDone event.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'seekDone', callback: Callback<int>): void;
        
        /**
         * Unregister listens for playback events.
         * @param { 'seekDone' } type - Type of the 'seekDone' to listen for.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'seekDone'): void;
        
        /**
         * Register the valid commands of the casted session changed callback
         * @param { 'validCommandChange' } type - 'validCommandChange'
         * @param { Callback<Array<AVCastControlCommandType>> } callback - The callback used to handle the changes.
         * The callback function provides an array of AVCastControlCommandType.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'validCommandChange', callback: Callback<Array<AVCastControlCommandType>>): void;
        
        /**
         * Unregister the valid commands of the casted session changed callback
         * @param { 'validCommandChange' } type - 'validCommandChange'
         * @param { Callback<Array<AVCastControlCommandType>> } callback - The callback used to handle the changes.
         * The callback function provides an array of AVCastControlCommandType.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'validCommandChange', callback?: Callback<Array<AVCastControlCommandType>>): void;
        /**
         * Register listener for video size change event, used at remote side.
         * @param { 'videoSizeChange' } type - Type of the 'videoSizeChange' to listen for.
         * @param { function } callback - Callback used to return video size.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'videoSizeChange', callback: (width: int, height: int) => void): void;
        /**
         * Unregister listener for video size change event, used at remote side.
         * @param { 'videoSizeChange' } type - Type of the 'videoSizeChange' to listen for.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'videoSizeChange'): void;
        
        /**
         * Register listeners for playback error events.
         * @param { 'error' } type Type of the 'error' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the playback error event.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 5400101 - No memory.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @throws { BusinessError } 5400103 - I/O error.
         * @throws { BusinessError } 5400104 - Time out.
         * @throws { BusinessError } 5400105 - Service died.
         * @throws { BusinessError } 5400106 - Unsupport format.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'error', callback: ErrorCallback): void;
        
        /**
         * Unregister listens for playback error events.
         * @param { 'error' } type Type of the 'error' to listen for.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 5400101 - No memory.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @throws { BusinessError } 5400103 - I/O error.
         * @throws { BusinessError } 5400104 - Time out.
         * @throws { BusinessError } 5400105 - Service died.
         * @throws { BusinessError } 5400106 - Unsupport format.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'error'): void;
        /**
         * Register listeners for cast control generic error events.
         * @param { 'castControlGenericError' } type Type of the 'castControlGenericError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @throws { BusinessError } 6611000 - The error code for cast control is unspecified.
         * @throws { BusinessError } 6611001 - An unspecified error occurs in the remote player.
         * @throws { BusinessError } 6611002 - The playback position falls behind the live window.
         * @throws { BusinessError } 6611003 - The process of cast control times out.
         * @throws { BusinessError } 6611004 - The runtime check failed.
         * @throws { BusinessError } 6611100 - Cross-device data transmission is locked.
         * @throws { BusinessError } 6611101 - The specified seek mode is not supported.
         * @throws { BusinessError } 6611102 - The position to seek to is out of the range of the media asset
         * or the specified seek mode is not supported.
         * @throws { BusinessError } 6611103 - The specified playback mode is not supported.
         * @throws { BusinessError } 6611104 - The specified playback speed is not supported.
         * @throws { BusinessError } 6611105 - The action failed because either the media source device or the media sink device has been revoked.
         * @throws { BusinessError } 6611106 - The parameter is invalid, for example, the url is illegal to play.
         * @throws { BusinessError } 6611107 - Allocation of memory failed.
         * @throws { BusinessError } 6611108 - Operation is not allowed.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'castControlGenericError', callback: ErrorCallback): void;
        /**
         * Unregister listeners for cast control generic error events.
         * @param { 'castControlGenericError' } type Type of the 'castControlGenericError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'castControlGenericError', callback?: ErrorCallback): void;
        /**
         * Register listeners for cast control input/output error events.
         * @param { 'castControlIoError' } type Type of the 'castControlIoError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @throws { BusinessError } 6612000 - An unspecified input/output error occurs.
         * @throws { BusinessError } 6612001 - Network connection failure.
         * @throws { BusinessError } 6612002 - Network timeout.
         * @throws { BusinessError } 6612003 - Invalid "Content-Type" HTTP header.
         * @throws { BusinessError } 6612004 - The HTTP server returns an unexpected HTTP response status code.
         * @throws { BusinessError } 6612005 - The file does not exist.
         * @throws { BusinessError } 6612006 - No permission is granted to perform the IO operation.
         * @throws { BusinessError } 6612007 - Access to cleartext HTTP traffic is not allowed by the app's network security configuration.
         * @throws { BusinessError } 6612008 - Reading data out of the data bound.
         * @throws { BusinessError } 6612100 - The media does not contain any contents that can be played.
         * @throws { BusinessError } 6612101 - The media cannot be read, for example, because of dust or scratches.
         * @throws { BusinessError } 6612102 - This resource is already in use.
         * @throws { BusinessError } 6612103 - The content using the validity interval has expired.
         * @throws { BusinessError } 6612104 - Using the requested content to play is not allowed.
         * @throws { BusinessError } 6612105 - The use of the allowed content cannot be verified.
         * @throws { BusinessError } 6612106 - The number of times this content has been used as requested has reached the maximum allowed number of uses.
         * @throws { BusinessError } 6612107 - An error occurs when sending packet from source device to sink device.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'castControlIoError', callback: ErrorCallback): void;
        /**
         * Unregister listeners for cast control input/output error events.
         * @param { 'castControlIoError' } type Type of the 'castControlIoError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'castControlIoError', callback?: ErrorCallback): void;
        /**
         * Register listeners for cast control parsing error events.
         * @param { 'castControlParsingError' } type Type of the 'castControlParsingError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @throws { BusinessError } 6613000 - Unspecified error related to content parsing.
         * @throws { BusinessError } 6613001 - Parsing error associated with media container format bit streams.
         * @throws { BusinessError } 6613002 - Parsing error associated with the media manifest.
         * @throws { BusinessError } 6613003 - An error occurs when attempting to extract a file with an unsupported media container format
         * or an unsupported media container feature.
         * @throws { BusinessError } 6613004 - Unsupported feature in the media manifest.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'castControlParsingError', callback: ErrorCallback): void;
        /**
         * Unregister listeners for cast control parsing error events.
         * @param { 'castControlParsingError' } type Type of the 'castControlParsingError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'castControlParsingError', callback?: ErrorCallback): void;
        /**
         * Register listeners for cast control decoding error events.
         * @param { 'castControlDecodingError' } type Type of the 'castControlDecodingError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @throws { BusinessError } 6614000 - Unspecified decoding error.
         * @throws { BusinessError } 6614001 - Decoder initialization failed.
         * @throws { BusinessError } 6614002 - Decoder query failed.
         * @throws { BusinessError } 6614003 - Decoding the media samples failed.
         * @throws { BusinessError } 6614004 - The format of the content to decode exceeds the capabilities of the device.
         * @throws { BusinessError } 6614005 - The format of the content to decode is not supported.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'castControlDecodingError', callback: ErrorCallback): void;
        /**
         * Unregister listeners for cast control decoding error events.
         * @param { 'castControlDecodingError' } type Type of the 'castControlDecodingError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'castControlDecodingError', callback?: ErrorCallback): void;
        /**
         * Register listeners for cast control audio renderer error error events.
         * @param { 'castControlAudioRendererError' } type Type of the 'castControlAudioRendererError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @throws { BusinessError } 6615000 - Unspecified errors related to the audio renderer.
         * @throws { BusinessError } 6615001 - Initializing the audio renderer failed.
         * @throws { BusinessError } 6615002 - The audio renderer fails to write data.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'castControlAudioRendererError', callback: ErrorCallback): void;
        /**
         * Unregister listeners for cast control audio renderer error events.
         * @param { 'castControlAudioRendererError' } type Type of the 'castControlAudioRendererError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'castControlAudioRendererError', callback?: ErrorCallback): void;
        /**
         * Register listeners for cast control drm error events.
         * @param { 'castControlDrmError' } type Type of the 'castControlDrmError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @throws { BusinessError } 6616000 - Unspecified error related to DRM.
         * @throws { BusinessError } 6616001 - The chosen DRM protection scheme is not supported by the device.
         * @throws { BusinessError } 6616002 - Device provisioning failed.
         * @throws { BusinessError } 6616003 - The DRM-protected content to play is incompatible.
         * @throws { BusinessError } 6616004 - Failed to obtain a license.
         * @throws { BusinessError } 6616005 - The operation is disallowed by the license policy.
         * @throws { BusinessError } 6616006 - An error occurs in the DRM system.
         * @throws { BusinessError } 6616007 - The device has revoked DRM privileges.
         * @throws { BusinessError } 6616008 - The DRM license being loaded into the open DRM session has expired.
         * @throws { BusinessError } 6616100 - An error occurs when the DRM processes the key response.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'castControlDrmError', callback: ErrorCallback): void;
        /**
         * Unregister listeners for cast control drm error events.
         * @param { 'castControlDrmError' } type Type of the 'castControlDrmError' to listen for.
         * @param { ErrorCallback } callback Callback used to listen for the cast control error event.
         * @throws { BusinessError } 401 - Parameter check failed. 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'castControlDrmError', callback?: ErrorCallback): void;
        /**
         * Register listener for drm key request.
         * @param { 'keyRequest' } type - Type of the 'keyRequest' to listen for.
         * @param { KeyRequestCallback } callback - Callback used to request drm key.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'keyRequest', callback: KeyRequestCallback): void;
        /**
         * Unregister listener for drm key request.
         * @param { 'keyRequest' } type - Type of the 'keyRequest' to listen for.
         * @param { KeyRequestCallback } callback - Callback used to request drm key.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'keyRequest', callback?: KeyRequestCallback): void;
    }
    /**
     * A helper to enable a picker to select output devices
     *
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    class AVCastPickerHelper {
        /**
         * The constructor used to create a AVCastPickerHelper object.
         *
         * @param { Context } context - represents the context.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        constructor(context: Context);
        /**
         * Pull up the avcastpicker based on the options.
         *
         * @param { AVCastPickerOptions } [options] - represents the options provided to  the picker.
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        select(options?: AVCastPickerOptions): Promise<void>;
        /**
         * Register picker state change callback.
         * @param { 'pickerStateChange' } type - 'pickerStateChange'
         * @param { Callback<AVCastPickerState> } callback - The callback used to handle picker state changed event.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        on(type: 'pickerStateChange', callback: Callback<AVCastPickerState>): void;
        /**
         * Unregister picker state change callback.
         * @param { 'pickerStateChange' } type - 'pickerStateChange'
         * @param { Callback<AVCastPickerState> } callback - The callback used to handle picker state changed event.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        off(type: 'pickerStateChange', callback?: Callback<AVCastPickerState>): void;
    }
    /**
     * An option to make different picker usage
     *
     * @typedef AVCastPickerOptions
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    interface AVCastPickerOptions {
        /**
         * Indicates current session type to show different picker ui.
         * If not set, default value is 'audio'.
         *
         * @type { ? AVSessionType }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        sessionType?: AVSessionType;
    }
    /**
     * The callback of key request.
     *
     * @typedef { function } KeyRequestCallback
     * @param { string } assetId - request key for current assetId
     * @param { Uint8Array } requestData - media key request data sent to media key server
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    type KeyRequestCallback = (assetId: string, requestData: Uint8Array) => void;
    /**
     * Enumerates the cast display states.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
     * @since 20
     */
    enum CastDisplayState {
        /**
         * Screen off.
         *
         * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
         * @since 20
         */
        STATE_OFF = 1,
        /**
         * Screen on.
         *
         * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
         * @since 20
         */
        STATE_ON = 2
    }
    /**
     * Define the information for extended display screen.
     * @typedef CastDisplayInfo
     * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
     * @since 20
     */
    interface CastDisplayInfo {
        /**
         * Display ID.
         * The application can get more display information based on the same id from display interface.
         * @type { long }
         * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
         * @since 20
         */
        id: long;
        /**
         * Display name.
         * @type { string }
         * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
         * @since 20
         */
        name: string;
        /**
         * The state of display.
         * @type { CastDisplayState }
         * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
         * @since 20
         */
        state: CastDisplayState;
        /**
         * Display width, in pixels.
         * @type { int }
         * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
         * @since 20
         */
        width: int;
        /**
         * Display height, in pixels.
         * @type { int }
         * @syscap SystemCapability.Multimedia.AVSession.ExtendedDisplayCast
         * @since 20
         */
        height: int;
    }
    
    /**
     * Define the device connection state.
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    enum ConnectionState {
        
        /**
         * A connection state indicating the device is in the process of connecting.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        STATE_CONNECTING = 0,
        
        /**
         * A connection state indicating the device is connected.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        STATE_CONNECTED = 1,
        
        /**
         * The default connection state indicating the device is disconnected.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        STATE_DISCONNECTED = 6
    }
    /**
     * The pre-defined display tag by system.
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    enum DisplayTag {
        /**
         * Indicate the AUDIO VIVID property of current media resource.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        TAG_AUDIO_VIVID = 1
    }
    /**
     * The defination of decoder type.
     * @enum { string }
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    enum DecoderType {
        /**
         * Defination of avc codec type.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        OH_AVCODEC_MIMETYPE_VIDEO_AVC = "video/avc",
        /**
         * Defination of hevc codec type.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        OH_AVCODEC_MIMETYPE_VIDEO_HEVC = "video/hevc",
        /**
         * Defination of audio vivid codec type.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        OH_AVCODEC_MIMETYPE_AUDIO_VIVID = "audio/av3a"
    }
    /**
     * The defination of suggested resolution.
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    enum ResolutionLevel {
        /**
         * Defination of 480P which typically resolution is 640*480.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        RESOLUTION_480P = 0,
        /**
         * Defination of 720P which typically resolution is 1280*720.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        RESOLUTION_720P = 1,
        /**
         * Defination of 1080P which typically resolution is 1920*1080.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        RESOLUTION_1080P = 2,
        /**
         * Defination of 2K which typically resolution is 2560*1440.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        RESOLUTION_2K = 3,
        /**
         * Defination of 4K which typically resolution is 4096*3840.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        RESOLUTION_4K = 4
    }
    /**
     * The play list information definition.
     * @interface AVQueueInfo
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @systemapi
     * @since 20
     */
    interface AVQueueInfo {
        /**
         * The bundle name of application which current play list belongs to.
         * @type { string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @systemapi
         * @since 20
         */
        bundleName: string;
        /**
         * The name of play list
         * @type { string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @systemapi
         * @since 20
         */
        avQueueName: string;
        /**
         * The id of play list
         * @type { string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @systemapi
         * @since 20
         */
        avQueueId: string;
        /**
         * The artwork of play list, can be a {@link PixelMap} or a URI formatted string,
         * @type { image.PixelMap | string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @systemapi
         * @since 20
         */
        avQueueImage: image.PixelMap | string;
        /**
         * The time when the user last played the playlist.
         * The time format can be system, such as 1611081385000, it means 2021-01-20 02:36:25.
         * @type { ?long }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @systemapi
         * @since 20
         */
        lastPlayedTime?: long;
    }
    
    /**
     * The metadata of the current media.Used to set the properties of the current media file
     * @interface AVMetadata
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface AVMetadata {
        
        /**
         * Unique ID used to represent this media.
         * @type { string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        assetId: string;
        
        /**
         * The title of this media, for display in media center.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        title?: string;
        
        /**
         * The artist of this media
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        artist?: string;
        
        /**
         * The author of this media
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        author?: string;
        /**
         * The name of play list which current media belongs to
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        avQueueName?: string;
        /**
         * The id of play list which current media belongs to, it should be an unique identifier in the application.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        avQueueId?: string;
        /**
         * The artwork of play list as a {@link PixelMap} or an uri formatted String,
         * @type { ?(image.PixelMap | string) }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        avQueueImage?: image.PixelMap | string;
        
        /**
         * The album of this media
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        album?: string;
        
        /**
         * The writer of this media
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        writer?: string;
        /**
         * The composer of this media
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        composer?: string;
        
        /**
         * The duration of this media, used to automatically calculate playback position
         * @type { ?long }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        duration?: long;
        
        /**
         * The image of the media as a {@link PixelMap} or an uri formatted String,
         * used to display in media center.
         * @type { ?(image.PixelMap | string) }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        mediaImage?: image.PixelMap | string;
        /**
         * The image of the bundle icon as a {@link PixelMap}, no need to be set by application.
         * @type { ?image.PixelMap }
         * @readonly
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        readonly bundleIcon?: image.PixelMap;
        /**
         * The publishDate of the media
         * @type { ?Date }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        publishDate?: Date;
        
        /**
         * The subtitle of the media, used for display
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        subtitle?: string;
        
        /**
         * The discription of the media, used for display
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        description?: string;
        /**
         * The lyric of the media, it should be in standard lyric format
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        lyric?: string;
        /**
         * The single lyric text of the media, not including time prefix
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        singleLyricText?: string;
        
        /**
         * The previous playable media id.
         * Used to tell the controller if there is a previous playable media
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        previousAssetId?: string;
        
        /**
         * The next playable media id.
         * Used to tell the controller if there is a next playable media
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        nextAssetId?: string;
        
        /**
         * The protocols supported by this session, if not set, the default is {@link TYPE_CAST_PLUS_STREAM}.
         * See {@link ProtocolType}
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        filter?: int;
        /**
         * The drm schemes supported by this session which are represented by uuid.
         * @type { ?Array<string> }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        drmSchemes?: Array<string>;
        /**
         * The supported skipIntervals when doing fast forward and rewind operation, the default is {@link SECONDS_15}.
         * See {@link SkipIntervals}
         * @type { ?SkipIntervals }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        skipIntervals?: SkipIntervals;
        /**
         * The display tags supported by application to be displayed on media center
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        displayTags?: int;
    }
    
    /**
     * The description of the media for an item in the playlist of the session
     * @interface AVMediaDescription
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface AVMediaDescription {
        
        /**
         * Unique ID used to represent this media.
         * @type { string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        assetId: string;
        
        /**
         * The title of this media, for display in media center.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        title?: string;
        
        /**
         * The subtitle of the media, used for display
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        subtitle?: string;
        
        /**
         * The description of this media
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        description?: string;
        
        /**
         * The image of this media asset displayed in the media center.
         * It can be a {@link PixelMap} or a URI formatted string,
         * @type { ?(image.PixelMap | string) }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        mediaImage?: image.PixelMap | string;
        
        /**
         * Any additional attributes that can be represented as key-value pairs
         * @type { ?Record<string, Object> }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        extras?: Record<string, Object>;
        
        /**
         * The type of this media, such as video, audio and so on.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        mediaType?: string;
        
        /**
         * The size of this media.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        mediaSize?: int;
        
        /**
         * The album title of this media
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        albumTitle?: string;
        
        /**
         * The album cover uri of this media
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        albumCoverUri?: string;
        
        /**
         * The lyric content of the media, it should be in standard lyric format
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        lyricContent?: string;
        
        /**
         * The lyric uri of the media.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        lyricUri?: string;
        
        /**
         * The artist of this media.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        artist?: string;
        
        /**
         * The uri of the media, used to locate the media in some special cases
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        mediaUri?: string;
        
        /**
         * Media file descriptor.
         * @type { ?media.AVFileDescriptor }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        fdSrc?: media.AVFileDescriptor;
        /**
         * DataSource descriptor. The caller ensures the fileSize and callback are valid.
         * @type { ?media.AVDataSrcDescriptor }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        dataSrc?: media.AVDataSrcDescriptor;
        /**
         * The drm scheme supported by this resource which is represented by uuid.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        drmScheme?: string;
        
        /**
         * The duration of this media
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        duration?: int;
        
        /**
         * Media start position, described by milliseconds.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        startPosition?: int;
        
        /**
         * Media credits position, described by milliseconds.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        creditsPosition?: int;
        
        /**
         * Application name.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        appName?: string;
        
        /**
         * The display tags supported by application to be displayed on media center
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        displayTags?: int;
    }
    
    /**
     * The item in the playlist of the session
     * @interface AVQueueItem
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface AVQueueItem {
        
        /**
         * Sequence number of the item in the playlist.
         * @type { int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        itemId: int;
        
        /**
         * The media description of the item in the playlist.
         * @type { ?AVMediaDescription }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        description?: AVMediaDescription;
    }
    
    /**
     * Used to indicate the playback state of the current media.
     * If the playback state of the media changes, it needs to be updated synchronously
     * @interface AVPlaybackState
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface AVPlaybackState {
        
        /**
         * Current playback state. See {@link PlaybackState}
         * @type { ?PlaybackState }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        state?: PlaybackState;
        
        /**
         * Current playback speed
         * @type { ?double }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        speed?: double;
        
        /**
         * Current playback position of this media. See {@link PlaybackPosition}
         * @type { ?PlaybackPosition }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        position?: PlaybackPosition;
        
        /**
         * The current buffered time, the maximum playable position
         * @type { ?long }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        bufferedTime?: long;
        
        /**
         * Current playback loop mode. See {@link LoopMode}
         * @type { ?LoopMode }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        loopMode?: LoopMode;
        
        /**
         * Current Favorite Status
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        isFavorite?: boolean;
        
        /**
         * Current active item id
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        activeItemId?: int;
        
        /**
         * Current player volume
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        volume?: int;
        
        /**
         * maximum  volume
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        maxVolume?: int;
        
        /**
         * Current muted status
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        muted?: boolean;
        /**
         * The duration of this media asset.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        duration?: int;
        
        /**
         * The video width of this media asset.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        videoWidth?: int;
        
        /**
         * The video height of this media asset.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        videoHeight?: int;
        
        
        /**
         * Current custom media packets
         * @type { ?Record<string, Object> }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        extras?: Record<string, Object>;
    }
    
    /**
     * Playback position definition
     * @interface PlaybackPosition
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface PlaybackPosition {
        
        /**
         * Elapsed time(position) of this media set by the app.
         * @type { long }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        elapsedTime: long;
        
        /**
         * Record the system time when elapsedTime is set.
         * @type { long }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        updateTime: long;
    }
    
    /**
     * The metadata of the current call.
     * @typedef CallMetadata
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface CallMetadata {
        
        /**
         * The displayed user name of current call.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        name?: string;
        
        /**
         * The phone number of current call.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        phoneNumber?: string;
        
        /**
         * The displayed picture that represents a particular user.
         * @type { ?image.PixelMap }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        avatar?: image.PixelMap;
    }
    
    /**
     * Used to indicate the call state of the current call.
     * @typedef AVCallState
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface AVCallState {
        
        /**
         * Current call state. See {@link CallState}
         * @type { CallState }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        state: CallState;
        
        /**
         * Current muted status.
         * @type { boolean }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        muted: boolean;
    }
    
    /**
     * Enumeration of current call state
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    enum CallState {
        
        /**
         * Idle state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        CALL_STATE_IDLE = 0,
        
        /**
         * Incoming state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        CALL_STATE_INCOMING = 1,
        
        /**
         * Active state in calling.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        CALL_STATE_ACTIVE = 2,
        
        /**
         * Dialing state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        CALL_STATE_DIALING = 3,
        
        /**
         * Waiting state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        CALL_STATE_WAITING = 4,
        
        /**
         * Holding state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        CALL_STATE_HOLDING = 5,
        
        /**
         * Disconnecting state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        CALL_STATE_DISCONNECTING = 6
    }
    
    /**
     * cast category indicating different playback scenes
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.AVCast
     * @since 20
     */
    enum AVCastCategory {
        
        /**
         * The default cast type "local", media can be routed on the same device,
         * including internal speakers or audio jack on the device itself, A2DP devices.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        CATEGORY_LOCAL = 0,
        
        /**
         * The remote category indicating the media is presenting on a remote device,
         * the application needs to get an AVCastController to control remote playback.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        CATEGORY_REMOTE = 1
    }
    
    /**
     * Device type definition
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    enum DeviceType {
        
        /**
         * A device type indicating the route is on internal speakers or audio jack on the device itself.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        DEVICE_TYPE_LOCAL = 0,
        
        /**
         * A device type indicating the route is on a TV.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        DEVICE_TYPE_TV = 2,
        
        /**
         * A device type indicating the route is on a smart speaker.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        DEVICE_TYPE_SMART_SPEAKER = 3,
        
        /**
         * A device type indicating the route is on a bluetooth device.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        DEVICE_TYPE_BLUETOOTH = 10
    }
    
    /**
     * Device Information Definition
     * @interface DeviceInfo
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface DeviceInfo {
        
        /**
         * The playback type supported by the device. See {@link AVCastCategory}
         * @type { AVCastCategory }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        castCategory: AVCastCategory;
        
        /**
         * Audio device id.The length of the audioDeviceId array is greater than 1
         * if output to multiple devices at the same time.
         * @type { string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        deviceId: string;
        
        /**
         * Device name. The length of the deviceName array is greater than 1
         * if output to multiple devices at the same time.
         * @type { string }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        deviceName: string;
        /**
         * Device manufacturer.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        manufacturer?: string;
        /**
         * Device model name.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        modelName?: string;
        /**
         * Network id.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        networkId?: string;
        /**
         * device ip address if available.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        ipAddress?: string;
        /**
         * device provider which supplies the route capability.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        providerId?: int;
        
        /**
         * The protocols supported by current device, can be union of {@link ProtocolType}.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        supportedProtocols?: int;
        /**
         * The drm capability supported by current device, each drm is represented by uuid.
         * @type { ?Array<string> }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        supportedDrmCapabilities?: Array<string>;
        /**
         * Define different authentication status.
         * 0: Device not authenticated.
         * 1: Device already authenticated.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        authenticationStatus?: int;
        /**
         * Indicates the current device is legacy or not.
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        isLegacy?: boolean;
        /**
         * Medium types used to discover devices.
         * 1: BLE
         * 2: COAP
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @systemapi
         * @since 20
         */
        mediumTypes?: int;
    }
    
    /**
     * Target Device Information Definition
     * @interface OutputDeviceInfo
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface OutputDeviceInfo {
        
        /**
         * Arrays of device information
         * @type { Array<DeviceInfo> }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        devices: Array<DeviceInfo>;
    }
    
    /**
     * Loop Play Mode Definition
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    enum LoopMode {
        
        /**
         * The default mode is sequential playback
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        LOOP_MODE_SEQUENCE = 0,
        
        /**
         * Single loop mode
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        LOOP_MODE_SINGLE = 1,
        
        /**
         * List loop mode
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        LOOP_MODE_LIST = 2,
        
        /**
         * Shuffle playback mode
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        LOOP_MODE_SHUFFLE = 3,
        
        /**
         * Custom playback mode supported by application
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        LOOP_MODE_CUSTOM = 4
    }
    /**
     * Supported skip intervals definition
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    enum SkipIntervals {
        /**
         * 10 seconds
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        SECONDS_10 = 10,
        /**
         * 15 seconds
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        SECONDS_15 = 15,
        /**
         * 30 seconds
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        SECONDS_30 = 30
    }
    
    /**
     * Definition of current playback state
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    enum PlaybackState {
        
        /**
         * Initial state. The initial state of media file
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_INITIAL = 0,
        
        /**
         * Preparing state. Indicates that the media file is not ready to play,
         * the media is loading or buffering
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_PREPARE = 1,
        
        /**
         * Playing state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_PLAY = 2,
        
        /**
         * Paused state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_PAUSE = 3,
        
        /**
         * Fast forwarding state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_FAST_FORWARD = 4,
        
        /**
         * Rewinding state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_REWIND = 5,
        
        /**
         * Stopped state.The server will clear the media playback position and other information.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_STOP = 6,
        
        /**
         * Completed state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_COMPLETED = 7,
        
        /**
         * Released state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_RELEASED = 8,
        
        /**
         * error state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_ERROR = 9,
        
        /**
         * Idle state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_IDLE = 10,
        
        /**
         * Buffering state.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        PLAYBACK_STATE_BUFFERING = 11
    }
    /**
     * The description of the session
     * @interface AVSessionDescriptor
     * @syscap SystemCapability.Multimedia.AVSession.Manager
     * @systemapi
     * @since 20
     */
    interface AVSessionDescriptor {
        /**
         * Unique ID of the session
         * @type { string }
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        sessionId: string;
        /**
         * Session type, currently supports audio or video
         * @type { AVSessionType }
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        type: AVSessionType;
        /**
         * The session tag set by the application
         * @type { string }
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        sessionTag: string;
        /**
         * The elementName of the ability that created this session. See {@link ElementName} in bundle/elementName.d.ts
         * @type { ElementName }
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        elementName: ElementName;
        /**
         * Session active state
         * @type { boolean }
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        isActive: boolean;
        /**
         * Is it the top priority session
         * @type { boolean }
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        isTopSession: boolean;
        /**
         * The current output device information.
         * It will be undefined if this is a local session.
         * @type { OutputDeviceInfo }
         * @syscap SystemCapability.Multimedia.AVSession.Manager
         * @systemapi
         * @since 20
         */
        outputDevice: OutputDeviceInfo;
    }
    /**
     * The extra info object.
     *
     * @typedef { Record<string, Object> } ExtraInfo
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    type ExtraInfo = Record<string, Object>;
    
    /**
     * Session controller,used to control media playback and get media information
     * @typedef AVSessionController
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface AVSessionController {
        
        /**
         * Unique session Id
         * @type { string }
         * @readonly
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        readonly sessionId: string;
        /**
         * Get the playback status of the current session
         * @param { AsyncCallback<AVPlaybackState> } callback - The triggered asyncCallback when (getAVPlaybackState).
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVPlaybackState(callback: AsyncCallback<AVPlaybackState>): void;
        
        /**
         * Get the playback status of the current session
         * @returns { Promise<AVPlaybackState> } (AVPlaybackState) returned through promise
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVPlaybackState(): Promise<AVPlaybackState>;
        
        /**
         * Get the playback status of the current session
         * @returns { AVPlaybackState } (AVPlaybackState) returned
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVPlaybackStateSync(): AVPlaybackState;
        /**
         * Get the metadata of the current session
         * @param { AsyncCallback<AVMetadata> } callback - The triggered asyncCallback when (getAVMetadata).
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVMetadata(callback: AsyncCallback<AVMetadata>): void;
        
        /**
         * Get the metadata of the current session
         * @returns { Promise<AVMetadata> } (AVMetadata) returned through promise
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVMetadata(): Promise<AVMetadata>;
        
        /**
         * Get the metadata of the current session
         * @returns { AVMetadata } (AVMetadata) returned
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVMetadataSync(): AVMetadata;
        /**
         * Get the call status of the current session
         * @param { AsyncCallback<AVCallState> } callback - The triggered asyncCallback when (getAVCallState).
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVCallState(callback: AsyncCallback<AVCallState>): void;
        /**
         * Get the call status of the current session
         * @returns { Promise<AVCallState> } (AVCallState) returned through promise
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVCallState(): Promise<AVCallState>;
        /**
         * Get the call metadata of the current session
         * @param { AsyncCallback<CallMetadata> } callback - The triggered asyncCallback when (getCallMetadata).
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getCallMetadata(callback: AsyncCallback<CallMetadata>): void;
        /**
         * Get the call metadata of the current session
         * @returns { Promise<CallMetadata> } (CallMetadata) returned through promise
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getCallMetadata(): Promise<CallMetadata>;
        /**
         * Get the name of the playlist of the current session
         * @param { AsyncCallback<string> } callback - The triggered asyncCallback when (getAVQueueTitle).
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVQueueTitle(callback: AsyncCallback<string>): void;
        
        /**
         * Get the name of the playlist of the current session
         * @returns { Promise<string> } (string) returned through promise
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVQueueTitle(): Promise<string>;
        
        /**
         * Get the name of the playlist of the current session
         * @returns { string } (string) returned
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVQueueTitleSync(): string;
        /**
         * Get the playlist of the current session
         * @param { AsyncCallback<Array<AVQueueItem>> } callback - The triggered asyncCallback when (getAVQueueItems).
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVQueueItems(callback: AsyncCallback<Array<AVQueueItem>>): void;
        
        /**
         * Get the playlist of the current session
         * @returns { Promise<Array<AVQueueItem>> } (Array<AVQueueItem>) returned through promise
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVQueueItems(): Promise<Array<AVQueueItem>>;
        
        /**
         * Get the playlist of the current session
         * @returns { Array<AVQueueItem> } (Array<AVQueueItem>) returned
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getAVQueueItemsSync(): Array<AVQueueItem>;
        /**
         * Set the item in the playlist to be played
         * @param { int } itemId - The serial number of the item to be played
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        skipToQueueItem(itemId: int, callback: AsyncCallback<void>): void;
        
        /**
         * Set the item in the playlist to be played
         * @param { int } itemId - The serial number of the item to be played
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        skipToQueueItem(itemId: int): Promise<void>;
        /**
         * Get output device information
         * @param { AsyncCallback<OutputDeviceInfo> } callback - The triggered asyncCallback when (getOutputDevice).
         * @throws { BusinessError } 600101 - Session service exception.
         * @throws { BusinessError } 600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getOutputDevice(callback: AsyncCallback<OutputDeviceInfo>): void;
        
        /**
         * Get output device information
         * @returns { Promise<OutputDeviceInfo> } (OutputDeviceInfo) returned through promise
         * @throws { BusinessError } 600101 - Session service exception.
         * @throws { BusinessError } 600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getOutputDevice(): Promise<OutputDeviceInfo>;
        
        /**
         * Get output device information
         * @returns { OutputDeviceInfo } (OutputDeviceInfo) returned
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getOutputDeviceSync(): OutputDeviceInfo;
        /**
         * Send media key event to this session
         * @param { KeyEvent } event - The KeyEvent
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 600101 - Session service exception.
         * @throws { BusinessError } 600102 - The session does not exist.
         * @throws { BusinessError } 600103 - The session controller does not exist.
         * @throws { BusinessError } 600105 - Invalid session command.
         * @throws { BusinessError } 600106 - The session is not activated.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        sendAVKeyEvent(event: KeyEvent, callback: AsyncCallback<void>): void;
        
        /**
         * Send media key event to this session
         * @param { KeyEvent } event - The KeyEvent
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 600101 - Session service exception.
         * @throws { BusinessError } 600102 - The session does not exist.
         * @throws { BusinessError } 600103 - The session controller does not exist.
         * @throws { BusinessError } 600105 - Invalid session command.
         * @throws { BusinessError } 600106 - The session is not activated.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        sendAVKeyEvent(event: KeyEvent): Promise<void>;
        /**
         * Get the {@link WantAgent} of this session that can launch the session ability
         * @param { AsyncCallback<WantAgent> } callback - The asyncCallback triggered when getting the WantAgent.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getLaunchAbility(callback: AsyncCallback<WantAgent>): void;
        
        /**
         * Get the {@link WantAgent} of this session that can launch the session ability
         * @returns { Promise<WantAgent> } WantAgent promise
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getLaunchAbility(): Promise<WantAgent>;
        
        /**
         * Get the adjusted playback position. The time automatically calculated by the system
         * taking into account factors such as playback status, playback speed, and application update time.
         * @returns { long } current playback position in ms.Note that the returns value of each call will be different.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getRealPlaybackPositionSync(): long;
        /**
         * Check if the current session is active
         * @param { AsyncCallback<boolean> } callback - The triggered asyncCallback when (isActive).
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        isActive(callback: AsyncCallback<boolean>): void;
        
        /**
         * Check if the current session is active
         * @returns { Promise<boolean> } boolean promise
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        isActive(): Promise<boolean>;
        
        /**
         * Check if the current session is active
         * @returns { boolean } boolean
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        isActiveSync(): boolean;
        /**
         * Destroy the server controller
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        destroy(callback: AsyncCallback<void>): void;
        
        /**
         * Destroy the server controller
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        destroy(): Promise<void>;
        /**
         * Get commands supported by the current session
         * @param { AsyncCallback<Array<AVControlCommandType>> } callback - The triggered asyncCallback when (getValidCommands).
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getValidCommands(callback: AsyncCallback<Array<AVControlCommandType>>): void;
        
        /**
         * Get commands supported by the current session
         * @returns { Promise<Array<AVControlCommandType>> } array of AVControlCommandType promise
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getValidCommands(): Promise<Array<AVControlCommandType>>;
        
        /**
         * Get commands supported by the current session
         * @returns {Array<AVControlCommandType> } array of AVControlCommandType
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getValidCommandsSync(): Array<AVControlCommandType>;
        /**
         * Send control commands to this session
         * @param { AVControlCommand } command - The command to be sent. See {@link AVControlCommand}
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @throws { BusinessError } 6600105 - Invalid session command.
         * @throws { BusinessError } 6600106 - The session is not activated.
         * @throws { BusinessError } 6600107 - Too many commands or events.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        sendControlCommand(command: AVControlCommand, callback: AsyncCallback<void>): void;
        
        /**
         * Send control commands to this session
         * @param { AVControlCommand } command - The command to be sent. See {@link AVControlCommand}
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Parameter verification failed.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @throws { BusinessError } 6600105 - Invalid session command.
         * @throws { BusinessError } 6600106 - The session is not activated.
         * @throws { BusinessError } 6600107 - Too many commands or events.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        sendControlCommand(command: AVControlCommand): Promise<void>;
        
        /**
         * Send common commands to this session
         * @param { string } command - The command name to be sent.
         * @param { Record<string, Object> } args - The parameters of session event
         * @param { AsyncCallback<void> } callback - The asyncCallback triggered when the command is executed successfully.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @throws { BusinessError } 6600105 - Invalid session command.
         * @throws { BusinessError } 6600106 - The session is not activated.
         * @throws { BusinessError } 6600107 - Too many commands or events.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        sendCommonCommand(command: string, args: Record<string, Object>, callback: AsyncCallback<void>): void;
        
        
        /**
         * Send common commands to this session
         * @param { string } command - The command name to be sent.
         * @param { Record<string, Object> } args - The parameters of session event
         * @returns { Promise<void> } void promise when executed successfully
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @throws { BusinessError } 6600105 - Invalid session command.
         * @throws { BusinessError } 6600106 - The session is not activated.
         * @throws { BusinessError } 6600107 - Too many commands or events.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        sendCommonCommand(command: string, args: Record<string, Object>): Promise<void>;
        
        /**
         * Get custom media packets provided by the corresponding session
         * @param { AsyncCallback<Record<string, Object>> } callback - The triggered asyncCallback when (getExtras).
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @throws { BusinessError } 6600105 - Invalid session command.
         * @throws { BusinessError } 6600107 - Too many commands or events.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getExtras(callback: AsyncCallback<Record<string, Object>>): void;
        
        
        /**
         * Get custom media packets provided by the corresponding session
         * @returns { Promise<Record<string, Object>> } the parameters of extras
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @throws { BusinessError } 6600105 - Invalid session command.
         * @throws { BusinessError } 6600107 - Too many commands or events.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getExtras(): Promise<Record<string, Object>>;
        /**
         * Get extra information for remote device, such as volume level, connected devices.
         * @param { string } extraEvent - the event name to get
         * @returns { Promise<ExtraInfo> } the value returned for such event
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600102 - The session does not exist.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @throws { BusinessError } 6600105 - Invalid session command.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        getExtrasWithEvent(extraEvent: string): Promise<ExtraInfo>;
        
        
        /**
         * Register metadata changed callback
         * @param { 'metadataChange' } type
         * @param { Array<string> | 'all' } filter - The properties of {@link AVMetadata} that you cared about
         * @param { function } callback - The callback used to handle metadata changed event.
         *     The callback function provides the {@link AVMetadata} parameter.
         *     It only contains the properties set in the filter.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'metadataChange', filter: Array<string> | 'all', callback: (data: AVMetadata) => void): void;
        
        
        /**
         * Unregister metadata changed callback
         * @param { 'metadataChange' } type
         * @param { function } callback - The callback used to handle metadata changed event.
         * The callback function provides the {@link AVMetadata} parameter.
         * It only contains the properties set in the filter.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'metadataChange', callback?: (data: AVMetadata) => void): void;
        
        
        /**
         * Register playback state changed callback
         * @param { 'playbackStateChange' } type
         * @param { Array<string> | 'all' } filter - The properties of {@link AVPlaybackState}
         *     that you cared about
         * @param { function } callback - The callback used to handle playback state changed event.
         *     The callback function provides the {@link AVPlaybackState} parameter.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'playbackStateChange', filter: Array<string> | 'all', callback: (state: AVPlaybackState) => void): void;
        
        
        /**
         * Unregister playback state changed callback
         * @param { 'playbackStateChange' } type
         * @param { function } callback - The callback used to handle playback state changed event.
         * The callback function provides the {@link AVPlaybackState} parameter.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'playbackStateChange', callback?: (state: AVPlaybackState) => void): void;
        
        /**
         * Register call metadata changed callback
         * @param { 'callMetadataChange' } type - 'callMetadataChange'
         * @param { Array<string> | 'all' } filter - The properties of {@link CallMetadata} that you cared about
         * @param { Callback<CallMetadata> } callback - The callback used to handle call metadata changed event.
         * The callback function provides the {@link CallMetadata} parameter.
         * It only contains the properties set in the filter.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'callMetadataChange', filter: Array<string> | 'all', callback: Callback<CallMetadata>): void;
        
        /**
         * Unregister call metadata changed callback
         * @param { 'callMetadataChange' } type - 'callMetadataChange'
         * @param { Callback<CallMetadata> } callback - The callback used to handle call metadata changed event.
         *     The callback function provides the {@link CallMetadata} parameter.
         * It only contains the properties set in the filter.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'callMetadataChange', callback?: Callback<CallMetadata>): void;
        
        /**
         * Register call state changed callback
         * @param { 'callStateChange' } type - 'callStateChange'
         * @param { Array<string> | 'all' } filter - The properties of {@link AVCallState} that you cared about
         * @param { Callback<AVCallState> } callback - The callback used to handle call state changed event.
         *     The callback function provides the {@link AVCallState} parameter.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         *     2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'callStateChange', filter: Array<string> | 'all', callback: Callback<AVCallState>): void;
        
        /**
         * Unregister playback state changed callback
         * @param { 'callStateChange' } type - 'callStateChange'
         * @param { Callback<AVCallState> } callback - The callback used to handle call state changed event.
         * The callback function provides the {@link AVCallState} parameter.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'callStateChange', callback?: Callback<AVCallState>): void;
        
        
        /**
         * Register current session destroyed callback
         * @param { 'sessionDestroy' } type
         * @param { function } callback - The callback used to handle current session destroyed event.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'sessionDestroy', callback: () => void): void;
        
        
        /**
         * Unregister current session destroyed callback
         * @param { 'sessionDestroy' } type - 'sessionDestroy'
         * @param { function } callback - The callback used to handle current session destroyed event.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'sessionDestroy', callback?: () => void): void;
        
        
        /**
         * Register the active state of this session changed callback
         * @param { 'activeStateChange' } type - 'activeStateChange'
         * @param { function } callback - The callback used to handle the active state of this session changed event.
         * The callback function provides the changed session state.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'activeStateChange', callback: (isActive: boolean) => void): void;
        
        
        /**
         * Unregister the active state of this session changed callback
         * @param { 'activeStateChange' } type - 'activeStateChange'
         * @param { function } callback - The callback used to handle the active state of this session changed event.
         *     The callback function provides the changed session state.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'activeStateChange', callback?: (isActive: boolean) => void): void;
        
        
        /**
         * Register the valid commands of the session changed callback
         * @param { 'validCommandChange' } type - 'validCommandChange'
         * @param { function } callback - The callback used to handle the changes.
         * The callback function provides an array of AVControlCommandType.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'validCommandChange', callback: (commands: Array<AVControlCommandType>) => void): void;
        
        
        /**
         * Unregister the valid commands of the session changed callback
         * @param { 'validCommandChange' } type - 'validCommandChange'
         * @param { function } callback - The callback used to handle the changes.
         * The callback function provides an array of AVControlCommandType.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'validCommandChange', callback?: (commands: Array<AVControlCommandType>) => void): void;
        
        /**
         * Register session output device change callback
         * @param { 'outputDeviceChange' } type - Registration Type 'outputDeviceChange'
         * @param { function } callback - Used to handle output device changed.
         * The callback provide the new device info {@link OutputDeviceInfo} and related connection state {@link ConnectionState}.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @throws { BusinessError } 6600103 - The session controller does not exist
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'outputDeviceChange', callback: (state: ConnectionState, device: OutputDeviceInfo) => void): void;
        
        /**
         * Unregister session output device change callback
         * @param { 'outputDeviceChange' } type - Registration Type 'outputDeviceChange'
         * @param { function } callback - Used to handle output device changed.
         * The callback provide the new device info {@link OutputDeviceInfo} and related connection state {@link ConnectionState}.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception
         * @throws { BusinessError } 6600103 - The session controller does not exist
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'outputDeviceChange', callback?: (state: ConnectionState, device: OutputDeviceInfo) => void): void;
        
        
        /**
         * Register session event callback
         * @param { 'sessionEvent' } type - 'sessionEvent'
         * @param { function } callback - The callback used to handle session event changed event.
         *     The callback function provides the event string and key-value pair parameters.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'sessionEvent', callback: (sessionEvent: string, args: Record<String, Object>) => void): void;
        
        
        /**
         * Unregister session event callback
         * @param { 'sessionEvent' } type - 'sessionEvent'
         * @param { function } callback - Used to cancel a specific listener
         *     The callback function provides the event string and key-value pair parameters.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'sessionEvent', callback?: (sessionEvent: string, args: Record<String, Object>) => void): void;
        
        /**
         * Register session playlist change callback
         * @param { 'queueItemsChange' } type - Registration Type 'queueItemsChange'
         * @param { function } callback - Used to handle playlist changed.
         * The callback provides the new array of AVQueueItem {@link AVQueueItem}
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'queueItemsChange', callback: (items: Array<AVQueueItem>) => void): void;
        
        /**
         * Unregister session playlist change callback
         * @param { 'queueItemsChange' } type - Registration Type 'queueItemsChange'
         * @param { function } callback - Used to handle playlist changed.
         * The callback provides the new array of AVQueueItem {@link AVQueueItem}
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'queueItemsChange', callback?: (items: Array<AVQueueItem>) => void): void;
        
        /**
         * Register the name of session playlist change callback
         * @param { 'queueTitleChange' } type - Registration Type 'queueTitleChange'
         * @param { function } callback - Used to handle name of playlist changed.
         * The callback provides the new name.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'queueTitleChange', callback: (title: string) => void): void;
        
        /**
         * Unregister the name of session playlist change callback
         * @param { 'queueTitleChange' } type - Registration Type 'queueTitleChange'
         * @param { function } callback - Used to handle name of playlist changed.
         * The callback provides the new name.
         * @throws { BusinessError } 401 - parameter check failed. 1.Mandatory parameters are left unspecified.
         * 2.Incorrect parameter types.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'queueTitleChange', callback?: (title: string) => void): void;
        
        
        /**
         * Register the custom media packets change callback
         * @param { 'extrasChange' } type - Registration Type 'extrasChange'
         * @param { function } callback - Used to handle custom media packets changed.
         *     The callback provides the new media packets.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        on(type: 'extrasChange', callback: (extras: Record<string, Object>) => void): void;
        
        
        /**
         * Unregister the custom media packets change callback
         * @param { 'extrasChange' } type - Registration Type 'extrasChange'
         * @param { function } callback - Used to handle custom media packets changed.
         *     The callback provides the new media packets.
         * @throws { BusinessError } 6600101 - Session service exception.
         * @throws { BusinessError } 6600103 - The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        off(type: 'extrasChange', callback?: (extras: Record<string, Object>) => void): void;
    }
    
    
    
    
    /**
     * The type of control command, add new support 'playWithAssetId'
     * @typedef { 'play' | 'pause' | 'stop' | 'playNext' | 'playPrevious' | 'fastForward' | 'rewind' | 'seek' |
     *     'setSpeed' | 'setLoopMode' | 'toggleFavorite' | 'playFromAssetId' | 'playWithAssetId' | 'answer' | 'hangUp' |
     *     'toggleCallMute' | 'setTargetLoopMode'} AVControlCommandType
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    type AVControlCommandType = 'play' | 'pause' | 'stop' | 'playNext' | 'playPrevious' | 'fastForward' | 'rewind' | 'seek' | 'setSpeed' | 'setLoopMode' | 'toggleFavorite' | 'playFromAssetId' | 'playWithAssetId' | 'answer' | 'hangUp' | 'toggleCallMute' | 'setTargetLoopMode';
    
    /**
     * The definition of command to be sent to the session
     * @typedef AVControlCommand
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    interface AVControlCommand {
        
        /**
         * The command value {@link AVControlCommandType}
         * @type { AVControlCommandType }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        command: AVControlCommandType;
        
        /**
         * parameter of the command. Whether this command requires parameters, see {@link AVSessionCommand}
         * seek command requires a number parameter
         * setSpeed command requires a number parameter
         * setLoopMode command requires a {@link LoopMode} parameter.
         * toggleFavorite command requires assetId {@link AVMetadata.assetId} parameter
         * other commands need no parameter
         * @type { ?(LoopMode | string | double) }
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        parameter?: LoopMode | string | double;
    }
    
    /**
     * Enumerates ErrorCode types, returns in BusinessError.code.
     * @enum { int }
     * @syscap SystemCapability.Multimedia.AVSession.Core
     * @since 20
     */
    enum AVSessionErrorCode {
        
        /**
         * Session service exception.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        ERR_CODE_SERVICE_EXCEPTION = 6600101,
        
        /**
         * The session does not exist
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        ERR_CODE_SESSION_NOT_EXIST = 6600102,
        
        /**
         * The session controller does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        ERR_CODE_CONTROLLER_NOT_EXIST = 6600103,
        
        /**
         * The remote session connection failed.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        ERR_CODE_REMOTE_CONNECTION_ERR = 6600104,
        
        /**
         * Invalid session command.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        ERR_CODE_COMMAND_INVALID = 6600105,
        
        /**
         * The session is not activated.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        ERR_CODE_SESSION_INACTIVE = 6600106,
        
        /**
         * Too many commands or events.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        ERR_CODE_MESSAGE_OVERLOAD = 6600107,
        
        /**
         * Device connecting failed.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        ERR_CODE_DEVICE_CONNECTION_FAILED = 6600108,
        
        /**
         * The remote connection is not established.
         * @syscap SystemCapability.Multimedia.AVSession.Core
         * @since 20
         */
        ERR_CODE_REMOTE_CONNECTION_NOT_EXIST = 6600109,
        /**
         * The error code for cast control is unspecified.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_UNSPECIFIED = 6611000,
        /**
         * An unspecified error occurs in the remote player.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_REMOTE_ERROR = 6611001,
        /**
         * The playback position falls behind the live window.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_BEHIND_LIVE_WINDOW = 6611002,
        /**
         * The process of cast control times out.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_TIMEOUT = 6611003,
        /**
         * The runtime check failed.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_RUNTIME_CHECK_FAILED = 6611004,
        /**
         * Cross-device data transmission is locked.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_PLAYER_NOT_WORKING = 6611100,
        /**
         * The specified seek mode is not supported.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_SEEK_MODE_UNSUPPORTED = 6611101,
        /**
         * The position to seek to is out of the range of the media asset or the specified seek mode is not supported.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_ILLEGAL_SEEK_TARGET = 6611102,
        /**
         * The specified playback mode is not supported.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_PLAY_MODE_UNSUPPORTED = 6611103,
        /**
         * The specified playback speed is not supported.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_PLAY_SPEED_UNSUPPORTED = 6611104,
        /**
         * The action failed because either the media source device or the media sink device has been revoked.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DEVICE_MISSING = 6611105,
        /**
         * The parameter is invalid, for example, the url is illegal to play.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_INVALID_PARAM = 6611106,
        /**
         * Allocation of memory failed.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_NO_MEMORY = 6611107,
        /**
         * Operation is not allowed.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_OPERATION_NOT_ALLOWED = 6611108,
        /**
         * An unspecified input/output error occurs.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_UNSPECIFIED = 6612000,
        /**
         * Network connection failure.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_NETWORK_CONNECTION_FAILED = 6612001,
        /**
         * Network timeout.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_NETWORK_CONNECTION_TIMEOUT = 6612002,
        /**
         * Invalid "Content-Type" HTTP header.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_INVALID_HTTP_CONTENT_TYPE = 6612003,
        /**
         * The HTTP server returns an unexpected HTTP response status code.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_BAD_HTTP_STATUS = 6612004,
        /**
         * The file does not exist.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_FILE_NOT_FOUND = 6612005,
        /**
         * No permission is granted to perform the IO operation.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_NO_PERMISSION = 6612006,
        /**
         * Access to cleartext HTTP traffic is not allowed by the app's network security configuration.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_CLEARTEXT_NOT_PERMITTED = 6612007,
        /**
         * Reading data out of the data bound.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_READ_POSITION_OUT_OF_RANGE = 6612008,
        /**
         * The media does not contain any contents that can be played.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_NO_CONTENTS = 6612100,
        /**
         * The media cannot be read, for example, because of dust or scratches.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_READ_ERROR = 6612101,
        /**
         * This resource is already in use.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_CONTENT_BUSY = 6612102,
        /**
         * The content using the validity interval has expired.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_CONTENT_EXPIRED = 6612103,
        /**
         * Using the requested content to play is not allowed.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_USE_FORBIDDEN = 6612104,
        /**
         * The use of the allowed content cannot be verified.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_NOT_VERIFIED = 6612105,
        /**
         * The number of times this content has been used as requested has reached the maximum allowed number of uses.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_EXHAUSTED_ALLOWED_USES = 6612106,
        /**
         * An error occurs when sending packet from source device to sink device.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_IO_NETWORK_PACKET_SENDING_FAILED = 6612107,
        /**
         * Unspecified error related to content parsing.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_PARSING_UNSPECIFIED = 6613000,
        /**
         * Parsing error associated with media container format bit streams.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_PARSING_CONTAINER_MALFORMED = 6613001,
        /**
         * Parsing error associated with the media manifest.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_PARSING_MANIFEST_MALFORMED = 6613002,
        /**
         * An error occurs when attempting to extract a file with an unsupported media container format
         * or an unsupported media container feature.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_PARSING_CONTAINER_UNSUPPORTED = 6613003,
        /**
         * Unsupported feature in the media manifest.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_PARSING_MANIFEST_UNSUPPORTED = 6613004,
        /**
         * Unspecified decoding error.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DECODING_UNSPECIFIED = 6614000,
        /**
         * Decoder initialization failed.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DECODING_INIT_FAILED = 6614001,
        /**
         * Decoder query failed.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DECODING_QUERY_FAILED = 6614002,
        /**
         * Decoding the media samples failed.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DECODING_FAILED = 6614003,
        /**
         * The format of the content to decode exceeds the capabilities of the device.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DECODING_FORMAT_EXCEEDS_CAPABILITIES = 6614004,
        /**
         * The format of the content to decode is not supported.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DECODING_FORMAT_UNSUPPORTED = 6614005,
        /**
         * Unspecified errors related to the audio renderer.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_AUDIO_RENDERER_UNSPECIFIED = 6615000,
        /**
         * Initializing the audio renderer failed.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_AUDIO_RENDERER_INIT_FAILED = 6615001,
        /**
         * The audio renderer fails to write data.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_AUDIO_RENDERER_WRITE_FAILED = 6615002,
        /**
         * Unspecified error related to DRM.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DRM_UNSPECIFIED = 6616000,
        /**
         * The chosen DRM protection scheme is not supported by the device.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DRM_SCHEME_UNSUPPORTED = 6616001,
        /**
         * Device provisioning failed.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DRM_PROVISIONING_FAILED = 6616002,
        /**
         * The DRM-protected content to play is incompatible.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DRM_CONTENT_ERROR = 6616003,
        /**
         * Failed to obtain a license.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DRM_LICENSE_ACQUISITION_FAILED = 6616004,
        /**
         * The operation is disallowed by the license policy.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DRM_DISALLOWED_OPERATION = 6616005,
        /**
         * An error occurs in the DRM system.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DRM_SYSTEM_ERROR = 6616006,
        /**
         * The device has revoked DRM privileges.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DRM_DEVICE_REVOKED = 6616007,
        /**
         * The DRM license being loaded into the open DRM session has expired.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DRM_LICENSE_EXPIRED = 6616008,
        /**
         * An error occurs when the DRM processes the key response.
         * @syscap SystemCapability.Multimedia.AVSession.AVCast
         * @since 20
         */
        ERR_CODE_CAST_CONTROL_DRM_PROVIDE_KEY_RESPONSE_ERROR = 6616100
    }
}
export default avSession;
