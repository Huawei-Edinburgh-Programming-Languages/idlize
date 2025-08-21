/*
 * Copyright (C) 2022 Huawei Device Co., Ltd.
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
 * @kit CameraKit
 */
import { ErrorCallback, AsyncCallback, Callback } from './@ohos.base';
import type Context from './application/BaseContext';
import image from './@ohos.multimedia.image';
import type colorSpaceManager from './@ohos.graphics.colorSpaceManager';
import photoAccessHelper from './@ohos.file.photoAccessHelper';

/**
 * @namespace camera
 * @syscap SystemCapability.Multimedia.Camera.Core
 * @since 20
 */
declare namespace camera {
    
    /**
     * Creates a CameraManager instance.
     *
     * @param { Context } context - Current application context.
     * @returns { CameraManager } CameraManager instance.
     * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
     * @throws { BusinessError } 7400201 - Camera service fatal error.
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    function getCameraManager(context: Context): CameraManager;
    
    /**
     * Enum for camera status.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum CameraStatus {
        
        /**
         * Appear status.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_STATUS_APPEAR = 0,
        
        /**
         * Disappear status.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_STATUS_DISAPPEAR = 1,
        
        /**
         * Available status.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_STATUS_AVAILABLE = 2,
        
        /**
         * Unavailable status.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_STATUS_UNAVAILABLE = 3
    }
    
    /**
     * Enum for fold status.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum FoldStatus {
        
        /**
         * Non-foldable status.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        NON_FOLDABLE = 0,
        
        /**
         * Expanded status.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        EXPANDED = 1,
        
        /**
         * Folded status.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FOLDED = 2
    }
    
    /**
     * Profile for camera streams.
     *
     * @typedef Profile
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface Profile {
        
        /**
         * Camera format.
         *
         * @type { CameraFormat }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly format: CameraFormat;
        
        /**
         * Resolution. The settings are the width and height of the camera's resolution, not the width and height of the actual output image.
         *
         * @type { Size }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly size: Size;
    }
    
    /**
     * Frame rate range.
     *
     * @typedef FrameRateRange
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface FrameRateRange {
        
        /**
         * Min frame rate.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly min: int;
        
        /**
         * Max frame rate.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly max: int;
    }
    
    /**
     * Video profile.
     *
     * @extends Profile
     * @typedef VideoProfile
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface VideoProfile extends Profile {
        
        /**
         * Frame rate range, in fps (frames per second).
         *
         * @type { FrameRateRange }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly frameRateRange: FrameRateRange;
    }
    
    /**
     * Camera output capability.
     *
     * @typedef CameraOutputCapability
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface CameraOutputCapability {
        
        /**
         * Preview profiles.
         *
         * @type { Array<Profile> }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly previewProfiles: Array<Profile>;
        
        /**
         * Photo profiles.
         *
         * @type { Array<Profile> }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly photoProfiles: Array<Profile>;
        
        /**
         * Video profiles.
         *
         * @type { Array<VideoProfile> }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly videoProfiles: Array<VideoProfile>;
        /**
         * Depth profiles.
         *
         * @type { Array<DepthProfile> }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly depthProfiles: Array<DepthProfile>;
        
        /**
         * All the supported metadata Object Types.
         *
         * @type { Array<MetadataObjectType> }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly supportedMetadataObjectTypes: Array<MetadataObjectType>;
    }
    /**
     * Control center status info.
     *
     * @typedef ControlCenterStatusInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface ControlCenterStatusInfo {
        /**
         * Control center effect type.
         *
         * @type { ControlCenterEffectType }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly effectType: ControlCenterEffectType;
        /**
         * If effect type is active.
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly isActive: boolean;
    }
    
    /**
     * Enum for camera error code.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum CameraErrorCode {
        
        /**
         * Parameter missing or parameter type incorrect.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        INVALID_ARGUMENT = 7400101,
        
        /**
         * Operation not allowed.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        OPERATION_NOT_ALLOWED = 7400102,
        
        /**
         * Session not config.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        SESSION_NOT_CONFIG = 7400103,
        
        /**
         * Session not running.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        SESSION_NOT_RUNNING = 7400104,
        
        /**
         * Session config locked.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        SESSION_CONFIG_LOCKED = 7400105,
        
        /**
         * Device setting locked.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        DEVICE_SETTING_LOCKED = 7400106,
        
        /**
         * Can not use camera cause of conflict.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CONFLICT_CAMERA = 7400107,
        
        /**
         * Camera disabled cause of security reason.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        DEVICE_DISABLED = 7400108,
        
        /**
         * Can not use camera cause of preempted.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        DEVICE_PREEMPTED = 7400109,
        
        /**
         * Unresolved conflicts with current configurations.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        UNRESOLVED_CONFLICTS_WITH_CURRENT_CONFIGURATIONS = 7400110,
        /**
         * Camera frequently switched.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        DEVICE_FREQUENTLY_SWITCHED = 7400111,
        /**
         * Camera lens retracted.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        CAMERA_LENS_RETRACTED = 7400112,
        
        /**
         * Camera service fatal error.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        SERVICE_FATAL_ERROR = 7400201
    }
    /**
     * Enum for restore parameter.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum RestoreParamType {
        /**
         * No need set restore Stream Parameter, only prelaunch camera device.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        NO_NEED_RESTORE_PARAM = 0,
        /**
         * Presistent default parameter, long-lasting effect after T minutes.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        PRESISTENT_DEFAULT_PARAM = 1,
        /**
         * Transient active parameter, which has a higher priority than PRESISTENT_DEFAULT_PARAM when both exist.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        TRANSIENT_ACTIVE_PARAM = 2
    }
    /**
     * Setting parameter for stream.
     *
     * @typedef SettingParam
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface SettingParam {
        /**
         * Skin smooth level value for restore.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        skinSmoothLevel: int;
        /**
         * Face slender value for restore.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        faceSlender: int;
        /**
         * Skin tone value for restore.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        skinTone: int;
    }
    /**
     * Prelaunch config object.
     *
     * @typedef PrelaunchConfig
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface PrelaunchConfig {
        /**
         * Camera instance.
         *
         * @type { CameraDevice }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        cameraDevice: CameraDevice;
        /**
         * Restore parameter type.
         *
         * @type { ?RestoreParamType }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        restoreParamType?: RestoreParamType;
        /**
         * Begin active time.
         *
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        activeTime?: int;
        /**
         * Setting parameter.
         *
         * @type { ?SettingParam }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        settingParam?: SettingParam;
    }
    
    /**
     * Camera Manager class, the camera manager instance needs to be get from the getCameraManager interface before using it.
     *
     * @interface CameraManager
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface CameraManager {
        
        /**
         * Gets the supported camera device objects and return the results synchronously.
         *
         * @returns { Array<CameraDevice> } An array of supported cameras.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getSupportedCameras(): Array<CameraDevice>;
        
        /**
         * Gets supported scene mode for specific camera.
         *
         * @param { CameraDevice } camera - Camera device, obtained through the getSupportedCameras interface.
         * An error code will be returned if there is an exception in parameter passing.
         * @returns { Array<SceneMode> } An array of supported scene mode of camera.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getSupportedSceneModes(camera: CameraDevice): Array<SceneMode>;
        
        /**
         * Gets supported output capability for specific camera.
         *
         * @param { CameraDevice } camera - Camera device, obtained through the getSupportedCameras interface.
         * @param { SceneMode } mode - Scene mode, obtained through the getSupportedSceneModes interface.
         * @returns { CameraOutputCapability } The camera output capability.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getSupportedOutputCapability(camera: CameraDevice, mode: SceneMode): CameraOutputCapability;
        
        /**
         * Queries whether the current camera is muted.
         *
         * @returns { boolean } Is camera muted.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isCameraMuted(): boolean;
        
        /**
         * Determine whether camera mute is supported.
         *
         * @returns { boolean } Is camera mute supported.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isCameraMuteSupported(): boolean;
        /**
         * Mutes or unmutes camera for persistence purpose.
         *
         * @permission ohos.camera.CAMERA_CONTROL
         * @param { boolean } mute - Mute camera if TRUE, otherwise unmute camera.
         * @param { PolicyType } type - Type for indicating the calling role.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        muteCameraPersistent(mute: boolean, type: PolicyType): void;
        /**
         * @since 20
         */
        overload createCameraInput {
            createCameraInputWithCamera,
            createCameraInputWithPositionType
        };
        /**
         * Creates a CameraInput instance by camera.
         *
         * Before using this interface, first through the getSupportedCameras interface to query the current list of camera
         * devices supported by the device, the developer needs to be based on specific scenarios to choose the camera device
         * that meets the needs of the developer, and then use this interface to create a CameraInput instance.
         *
         * @permission ohos.permission.CAMERA
         * @param { CameraDevice } camera - Camera device used to create the instance.
         * @returns { CameraInput } Returns a CameraInput instance. Failure of an interface call returns the corresponding
         *     error code, which is of type CameraErrorCode.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        createCameraInputWithCamera(camera: CameraDevice): CameraInput;
        /**
         * Creates a CameraInput instance by camera position and type.
         *
         * @permission ohos.permission.CAMERA
         * @param { CameraPosition } position - Camera position, first get the supported camera device
         *     objects through the getSupportedCameras interface, and then get the device position information
         *     based on the returned camera device objects.
         * @param { CameraType } type - camera type, first get the supported camera device object through
         *     the getSupportedCameras interface, then get the device type information based on the returned
         *     camera device object.
         * @returns { CameraInput } Returns a CameraInput instance. Failure of an interface call returns
         *     the corresponding error code, which is of type CameraErrorCode.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        createCameraInputWithPositionType(position: CameraPosition, type: CameraType): CameraInput;
        /**
         * @since 20
         */
        overload createPreviewOutput {
            createPreviewOutputWithProfileSurfaceId,
            createPreviewOutputWithSurfaceId
        };
        /**
         * Creates a PreviewOutput instance.
         *
         * @param { Profile } profile - Supported preview configuration information,
         *     obtained through the getSupportedOutputCapability API.
         * @param { string } surfaceId - Surface object id used in camera photo output.
         * @returns { PreviewOutput } The PreviewOutput instance.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        createPreviewOutputWithProfileSurfaceId(profile: Profile, surfaceId: string): PreviewOutput;
        /**
         * Creates a PreviewOutput instance without profile.
         * You can use this method to create a preview output instance without a profile, This instance can
         * only be used in a preconfiged session.
         *
         * @param { string } surfaceId - Surface object id used in camera preview output.
         * @returns { PreviewOutput } The PreviewOutput instance.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        createPreviewOutputWithSurfaceId(surfaceId: string): PreviewOutput;
        
        
        /**
         * Creates a PhotoOutput instance without surfaceId.
         * Call PhotoOutput capture interface will give a callback,
         * {@link on(type: 'photoAvailable', callback: AsyncCallback<Photo>)}
         * You can use this method to create a photo output instance without a profile, This instance can
         * only be used in a preconfiged session.
         *
         * @param { Profile } profile - Supported photo configuration information, obtained through the
         * getSupportedOutputCapability API. This parameter is mandatory for API version 11.
         * Starting from API version 12, if the preconfig API is used for preconfiguration, the
         * profile parameter, if specified, will override the settings configured by the preconfig API.
         * @returns { PhotoOutput } The PhotoOutput instance.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        createPhotoOutput(profile?: Profile): PhotoOutput;
        /**
         * @since 20
         */
        overload createVideoOutput {
            createVideoOutputWithProfileSurfaceId,
            createVideoOutputWithSurfaceId
        };
        /**
         * Creates a VideoOutput instance.
         *
         * @param { VideoProfile } profile - Supported recording configuration information,
         *     obtained through the getSupportedOutputCapability API.
         * @param { string } surfaceId - Surface object id used in camera video output.
         * @returns { VideoOutput } The VideoOutput instance.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        createVideoOutputWithProfileSurfaceId(profile: VideoProfile, surfaceId: string): VideoOutput;
        /**
         * Creates a VideoOutput instance without profile.
         * You can use this method to create a video output instance without a profile, This instance can
         * only be used in a preconfiged session.
         *
         * @param { string } surfaceId - Surface object id used in camera video output.
         * @returns { VideoOutput } The VideoOutput instance.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        createVideoOutputWithSurfaceId(surfaceId: string): VideoOutput;
        
        
        /**
         * Creates a MetadataOutput instance.
         *
         * @param { Array<MetadataObjectType> } metadataObjectTypes - Metadata stream type information,
         * obtained through the getSupportedOutputCapability API.
         * @returns { MetadataOutput } The MetadataOutput instance.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        createMetadataOutput(metadataObjectTypes: Array<MetadataObjectType>): MetadataOutput;
        /**
         * Creates a DepthDataOutput instance.
         *
         * @param { DepthProfile } profile - Depth data profile.
         * @returns { DepthDataOutput } The DepthDataOutput instance.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        createDepthDataOutput(profile: DepthProfile): DepthDataOutput;
        
        /**
         * Gets a Session instance by specific scene mode.
         *
         * @param { SceneMode } mode - The modes supported by the camera. If the passed parameters are
         * abnormal (e.g. out of range, passed null or undefined, etc.), the actual interface will not take effect.
         * @returns { T } Session instance. Failure of an interface call returns the appropriate error code,
         * which is of type CameraErrorCode.
         * @throws { BusinessError } 7400101 - Parameter error. Possible causes:
         * 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types;
         * 3. Parameter verification failed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        createSession<T extends Session>(mode: SceneMode): T;
        
        /**
         * Determines whether the camera device supports prelaunch.
         * This function must be called in prior to the setPrelaunchConfig and prelaunch functions.
         *
         * @param { CameraDevice } camera - Camera device.
         * @returns { boolean } Whether prelaunch is supported.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isPrelaunchSupported(camera: CameraDevice): boolean;
        
        /**
         * Sets the camera prelaunch configuration.
         * The configuration is sent to the camera service when you exit the camera or change the configuration next time.
         *
         * @permission ohos.permission.CAMERA
         * @param { PrelaunchConfig } prelaunchConfig - Prelaunch configuration info.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setPrelaunchConfig(prelaunchConfig: PrelaunchConfig): void;
        
        /**
         * Enable the camera to prelaunch and start.
         * This function is called when the user clicks the system camera icon to start the camera application.
         *
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        prelaunch(): void;
        
        /**
         * Prepare the camera resources.
         * This function is called when the user touch down the camera switch icon in camera application.
         *
         * @param { string } cameraId - The camera to prepare.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        preSwitchCamera(cameraId: string): void;
        
        /**
         * Creates a deferred PreviewOutput instance.
         * You can use the method to create deferred preview output without profile, then you must add this output
         * to a session which already preconfiged.
         *
         * @param { Profile } profile - Preview output profile.
         * @returns { PreviewOutput } the PreviewOutput instance.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        createDeferredPreviewOutput(profile?: Profile): PreviewOutput;
        
        /**
         * Check if the device has a torch.
         *
         * @returns { boolean } this value that specifies whether the device has a torch.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isTorchSupported(): boolean;
        
        /**
         * Check if a specifies torch mode is supported.
         * @param { TorchMode } mode - torch mode.
         * @returns { boolean } is torch mode supported.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isTorchModeSupported(mode: TorchMode): boolean;
        
        /**
         * Get current torch mode.
         *
         * @returns { TorchMode } torch mode.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getTorchMode(): TorchMode;
        
        
        
        /**
         * Set torch mode to the device.
         *
         * @param { TorchMode } mode - torch mode.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setTorchMode(mode: TorchMode): void;
        /**
        * @since 20
        */
        overload on {
            onCameraStatus,
            onFoldStatusChange,
            onCameraMute,
            onTorchStatusChange,
            onControlCenterStatusChange
        };
        /**
         * Camera state callback to get the state change of the camera by registering a callback
         * function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'cameraStatus' } type - Event type.
         * @param { AsyncCallback<CameraStatusInfo> } callback - Callback used to get the camera status change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onCameraStatus(type: 'cameraStatus', callback: AsyncCallback<CameraStatusInfo>): void;
        /**
         * Registers a listener for fold state changes. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'foldStatusChange' } type - Event type.
         * @param { AsyncCallback<FoldStatusInfo> } callback - Callback used to get the fold status change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onFoldStatusChange(type: 'foldStatusChange', callback: AsyncCallback<FoldStatusInfo>): void;
        /**
         * Subscribes camera mute change event callback.
         *
         * @param { 'cameraMute' } type - Event type.
         * @param { AsyncCallback<boolean> } callback - Callback used to get the camera mute change.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onCameraMute(type: 'cameraMute', callback: AsyncCallback<boolean>): void;
        /**
         * Registers a listener for flashlight state changes to get flashlight state change by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'torchStatusChange' } type - Event type
         * @param { AsyncCallback<TorchStatusInfo> } callback - Callback used to return the torch status change
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onTorchStatusChange(type: 'torchStatusChange', callback: AsyncCallback<TorchStatusInfo>): void;
        /**
         * Subscribes control center status change event callback.
         *
         * @param { 'controlCenterStatusChange' } type - Event type.
         * @param { AsyncCallback<boolean> } callback - Callback used to get the control center status change.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onControlCenterStatusChange(type: 'controlCenterStatusChange', callback: AsyncCallback<boolean>): void;
        /**
        * @since 20
        */
        overload off {
            offCameraStatus,
            offFoldStatusChange,
            offCameraMute,
            offTorchStatusChange,
            offControlCenterStatusChange
        };
        /**
         * Unsubscribes from camera status change event callback.
         *
         * @param { 'cameraStatus' } type - Event type.
         * @param { AsyncCallback<CameraStatusInfo> } [callback] - Callback used to get the camera status change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offCameraStatus(type: 'cameraStatus', callback?: AsyncCallback<CameraStatusInfo>): void;
        /**
         * Unsubscribes from fold status change event callback.
         *
         * @param { 'foldStatusChange' } type - Event type.
         * @param { AsyncCallback<FoldStatusInfo> } [callback] - Callback used to get the fold status change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offFoldStatusChange(type: 'foldStatusChange', callback?: AsyncCallback<FoldStatusInfo>): void;
        /**
         * Unsubscribes from camera mute change event callback.
         *
         * @param { 'cameraMute' } type - Event type.
         * @param { AsyncCallback<boolean> } [callback] - Callback used to get the camera mute change.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offCameraMute(type: 'cameraMute', callback?: AsyncCallback<boolean>): void;
        /**
         * Unsubscribes torch status change event callback.
         *
         * @param { 'torchStatusChange' } type - Event type
         * @param { AsyncCallback<TorchStatusInfo> } [callback] - Callback used to return the torch status change
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offTorchStatusChange(type: 'torchStatusChange', callback?: AsyncCallback<TorchStatusInfo>): void;
        /**
         * Unsubscribes control center status change event callback.
         *
         * @param { 'controlCenterStatusChange' } type - Event type.
         * @param { AsyncCallback<boolean> } [callback] - Callback used to get the control center status change.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offControlCenterStatusChange(type: 'controlCenterStatusChange', callback?: AsyncCallback<boolean>): void;
    }
    
    /**
     * Torch status info.
     *
     * @typedef TorchStatusInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface TorchStatusInfo {
        
        /**
         * is torch available
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly isTorchAvailable: boolean;
        
        /**
         * Whether the flashlight is activated or not. True means the flashlight is activated, false means the flashlight
         * is not activated.
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly isTorchActive: boolean;
        
        /**
         * Flashlight brightness level, value range is [0,1], the closer to 1, the brighter it is.
         *
         * @type { double }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly torchLevel: double;
    }
    
    /**
     * Enum for torch mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum TorchMode {
        
        /**
         * The device torch is always off.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        OFF = 0,
        
        /**
         * The device torch is always on.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        ON = 1,
        
        /**
         * The device continuously monitors light levels and uses the torch when necessary.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        AUTO = 2
    }
    
    /**
     * An instance of the interface returned by the camera manager's callback that represents camera state information.
     *
     * @typedef CameraStatusInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface CameraStatusInfo {
        
        /**
         * Camera instance.
         *
         * @type { CameraDevice }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        camera: CameraDevice;
        
        /**
         * Current camera status.
         *
         * @type { CameraStatus }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        status: CameraStatus;
    }
    
    /**
     * Fold status info.
     *
     * @typedef FoldStatusInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface FoldStatusInfo {
        
        /**
         * Gets supported camera devices under the current fold status.
         *
         * @type { Array<CameraDevice> }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly supportedCameras: Array<CameraDevice>;
        
        /**
         * Current fold status.
         *
         * @type { FoldStatus }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly foldStatus: FoldStatus;
    }
    
    /**
     * Enum for camera position.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum CameraPosition {
        
        /**
         * Unspecified position.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_POSITION_UNSPECIFIED = 0,
        
        /**
         * Back position.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_POSITION_BACK = 1,
        
        /**
         * Front position.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_POSITION_FRONT = 2
    }
    
    /**
     * Enum for camera type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum CameraType {
        
        /**
         * Default camera type
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_TYPE_DEFAULT = 0,
        
        /**
         * Wide camera
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_TYPE_WIDE_ANGLE = 1,
        
        /**
         * Ultra wide camera
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_TYPE_ULTRA_WIDE = 2,
        
        /**
         * Telephoto camera
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_TYPE_TELEPHOTO = 3,
        
        /**
         * True depth camera
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_TYPE_TRUE_DEPTH = 4
    }
    
    /**
     * Enum for camera connection type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum ConnectionType {
        
        /**
         * Built-in camera.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_CONNECTION_BUILT_IN = 0,
        
        /**
         * Camera connected using USB
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_CONNECTION_USB_PLUGIN = 1,
        
        /**
         * Remote camera
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_CONNECTION_REMOTE = 2
    }
    
    
    /**
     * Enum for remote camera device type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum HostDeviceType {
        
        
        /**
         * Indicates an unknown device camera.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        UNKNOWN_TYPE = 0,
        
        
        /**
         * Indicates a smartphone camera.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        PHONE = 0x0E,
        
        
        /**
         * Indicates a tablet camera.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        TABLET = 0x11
    }
    
    /**
     * Camera device object.
     *
     * @typedef CameraDevice
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface CameraDevice {
        
        /**
         * Camera ID attribute.
         *
         * @type { string }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly cameraId: string;
        
        /**
         * Camera position attribute.
         *
         * @type { CameraPosition }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly cameraPosition: CameraPosition;
        
        /**
         * Camera type attribute.
         *
         * @type { CameraType }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly cameraType: CameraType;
        
        /**
         * Camera connection type attribute.
         *
         * @type { ConnectionType }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly connectionType: ConnectionType;
        
        
        /**
         * Camera remote camera device name attribute.
         *
         * @type { string }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly hostDeviceName: string;
        
        
        /**
         * Camera remote camera device type attribute.
         *
         * @type { HostDeviceType }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly hostDeviceType: HostDeviceType;
        
        /**
         * The camera mounting angle, which does not change with screen rotation, takes values from 0° to 360° in degrees.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly cameraOrientation: int;
        /**
         * Camera device retractable attribute
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly isRetractable?: boolean;
    }
    
    /**
     * Size parameter.
     *
     * @typedef Size
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface Size {
        
        /**
         * Height.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        height: int;
        
        /**
         * Width.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        width: int;
    }
    
    /**
     * Point coordinates are used for focus and exposure configuration.
     *
     * @typedef Point
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface Point {
        
        /**
         * x co-ordinate
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        x: double;
        
        /**
         * y co-ordinate
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        y: double;
    }
    
    /**
     * Camera input object.
     *
     * @interface CameraInput
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface CameraInput {
        /**
         * @since 20
         */
        overload open {
            openWithCallback,
            openReturnsPromise,
            openWithisSecureEnabledReturnsPromiseofBigint,
            openWithCameraConcurrentTypeReturnsPromise
        };
        /**
         * Open camera.
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @throws { BusinessError } 7400107 - Can not use camera cause of conflict.
         * @throws { BusinessError } 7400108 - Camera disabled cause of security reason.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        openWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Open camera.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400107 - Can not use camera cause of conflict.
         * @throws { BusinessError } 7400108 - Camera disabled cause of security reason.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        openReturnsPromise(): Promise<void>;
        /**
         * Open camera.
         *
         * @param { boolean } isSecureEnabled - Setting true enables the camera to be opened in a safe way,
         *     setting false does the opposite. Failure of an interface call returns an error code of type
         *     CameraErrorCode.
         * @returns { Promise<bigint> } Promise used to return the result.
         * @throws { BusinessError } 7400107 - Can not use camera cause of conflict.
         * @throws { BusinessError } 7400108 - Camera disabled cause of security reason.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        openWithisSecureEnabledReturnsPromiseofBigint(isSecureEnabled: boolean): Promise<bigint>;
        /**
         * Open camera with specified concurrent type.
         *
         * @param { CameraConcurrentType } type - Camera concurrent type.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400107 - Can not use camera cause of conflict.
         * @throws { BusinessError } 7400108 - Camera disabled cause of security reason.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        openWithCameraConcurrentTypeReturnsPromise(type: CameraConcurrentType): Promise<void>;
        /**
         * @since 20
         */
        overload close {
            closeWithCallback,
            closeReturnsPromise
        };
        /**
         * Close camera.
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        closeWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Close camera.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        closeReturnsPromise(): Promise<void>;
        /**
         * Delay close camera.
         *
         * @param { int } time - delay time for turning off camera.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        closeDelayed(time: int): Promise<void>;
        /**
        * @since 20
        */
        overload on {
            onError,
            onCameraOcclusionDetection
        };
        /**
         * Registers a listener for CameraInput error events to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'error' } type - Event type.
         * @param { CameraDevice } camera - Camera device.
         * @param { ErrorCallback } callback - Callback used to get the camera input errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onError(type: 'error', camera: CameraDevice, callback: ErrorCallback): void;
        /**
         * Subscribes to camera occlusion detection results.
         *
         * @param { 'cameraOcclusionDetection' } type - Event type.
         * @param { AsyncCallback<CameraOcclusionDetectionResult> } callback - Callback used to get detection results.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onCameraOcclusionDetection(type: 'cameraOcclusionDetection', callback: AsyncCallback<CameraOcclusionDetectionResult>): void;
        /**
        * @since 20
        */
        overload off {
            offError,
            offCameraOcclusionDetection
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { CameraDevice } camera - Camera device.
         * @param { ErrorCallback } [callback] - Callback used to get the camera input errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offError(type: 'error', camera: CameraDevice, callback?: ErrorCallback): void;
        /**
         * Unsubscribes from camera occlusion detection results.
         *
         * @param { 'cameraOcclusionDetection' } type - Event type.
         * @param { AsyncCallback<CameraOcclusionDetectionResult> } [callback] - Callback used to get detection results.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offCameraOcclusionDetection(type: 'cameraOcclusionDetection', callback?: AsyncCallback<CameraOcclusionDetectionResult>): void;
        /**
         * Control auxiliary.
         *
         * @param { AuxiliaryType } auxiliaryType - Auxiliary type.
         * @param { AuxiliaryStatus } auxiliaryStatus - Auxiliary status.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        controlAuxiliary(auxiliaryType: AuxiliaryType, auxiliaryStatus: AuxiliaryStatus): Promise<void>;
    }
    
    /**
     * Enumerates the camera scene modes.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum SceneMode {
        
        /**
         * Normal photo mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        NORMAL_PHOTO = 1,
        
        /**
         * Normal video mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        NORMAL_VIDEO = 2,
        /**
         * Portrait photo mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        PORTRAIT_PHOTO = 3,
        /**
         * Night photo mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        NIGHT_PHOTO = 4,
        /**
         * Professional photo mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        PROFESSIONAL_PHOTO = 5,
        /**
         * Professional video mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        PROFESSIONAL_VIDEO = 6,
        /**
         * Slow motion video mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        SLOW_MOTION_VIDEO = 7,
        /**
         * Macro photo mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        MACRO_PHOTO = 8,
        /**
         * Macro video mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        MACRO_VIDEO = 9,
        /**
         * Light painting photo mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        LIGHT_PAINTING_PHOTO = 10,
        /**
         * High resolution mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        HIGH_RESOLUTION_PHOTO = 11,
        
        /**
         * Secure camera mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        SECURE_PHOTO = 12,
        /**
         * Quick shot mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        QUICK_SHOT_PHOTO = 13,
        /**
         * Aperture video mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        APERTURE_VIDEO = 14,
        /**
         * Panorama photo camera mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        PANORAMA_PHOTO = 15,
        /**
         * Timelapse photo camera mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        TIME_LAPSE_PHOTO = 16,
        /**
         * Fluorescence photo mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        FLUORESCENCE_PHOTO = 17
    }
    
    /**
     * Enum for camera format type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum CameraFormat {
        
        /**
         * RGBA 8888 Format.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_FORMAT_RGBA_8888 = 3,
        /**
         * Digital negative Format.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        CAMERA_FORMAT_DNG = 4,
        
        /**
         * YUV 420 Format.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_FORMAT_YUV_420_SP = 1003,
        
        /**
         * JPEG Format.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_FORMAT_JPEG = 2000,
        
        /**
         * YCBCR P010 Format.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_FORMAT_YCBCR_P010,
        
        /**
         * YCRCB P010 Format.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_FORMAT_YCRCB_P010,
        
        /**
         * HEIC Format.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_FORMAT_HEIC = 2003,
        /**
         * Depth Data Format: float 16.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        CAMERA_FORMAT_DEPTH_16 = 3000,
        /**
         * Depth Data Format: float 32.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        CAMERA_FORMAT_DEPTH_32 = 3001
    }
    
    /**
     * Enum for flash mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum FlashMode {
        
        /**
         * Close mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FLASH_MODE_CLOSE = 0,
        
        /**
         * Open mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FLASH_MODE_OPEN = 1,
        
        /**
         * Auto mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FLASH_MODE_AUTO = 2,
        
        /**
         * Always open mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FLASH_MODE_ALWAYS_OPEN = 3
    }
    /**
     * LCD Flash Status.
     *
     * @typedef LcdFlashStatus
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface LcdFlashStatus {
        /**
         * Check whether lcd flash is needed.
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly isLcdFlashNeeded: boolean;
        /**
         * Compensate value for lcd flash.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly lcdCompensation: int;
    }
    
    /**
     * Flash Query object.
     *
     * @interface FlashQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface FlashQuery {
        
        
        /**
         * Check if device has flash light.
         * Move to FlashQuery interface from Flash since 12.
         *
         * @returns { boolean } The flash light support status.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        hasFlash(): boolean;
        
        
        /**
         * Checks whether a specified flash mode is supported.
         * Move to FlashQuery interface from Flash since 12.
         *
         * @param { FlashMode } flashMode - Flash mode
         * @returns { boolean } Is the flash mode supported.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isFlashModeSupported(flashMode: FlashMode): boolean;
        /**
         * Checks whether lcd flash is supported.
         *
         * @returns { boolean } Is lcd flash supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isLcdFlashSupported(): boolean;
    }
    
    /**
     * Flash object.
     *
     * @extends FlashQuery
     * @interface Flash
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface Flash extends FlashQuery {
        
        /**
         * Gets current flash mode.
         *
         * @returns { FlashMode } The current flash mode.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getFlashMode(): FlashMode;
        
        /**
         * Sets flash mode.
         *
         * @param { FlashMode } flashMode - Target flash mode.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setFlashMode(flashMode: FlashMode): void;
        /**
         * Enable lcd flash.
         *
         * @param { boolean } enabled - Target lcd flash status.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableLcdFlash(enabled: boolean): void;
    }
    
    /**
     * Enum for exposure mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum ExposureMode {
        
        /**
         * Lock exposure mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        EXPOSURE_MODE_LOCKED = 0,
        
        /**
         * Auto exposure mode. Exposure area center point can be set by AutoExposure.setMeteringPoint interface.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        EXPOSURE_MODE_AUTO = 1,
        
        /**
         * Continuous automatic exposure.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        EXPOSURE_MODE_CONTINUOUS_AUTO = 2,
        /**
         * Manual exposure mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        EXPOSURE_MODE_MANUAL = 3
    }
    /**
     * Enum for exposure metering mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum ExposureMeteringMode {
        /**
         * Matrix metering.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        MATRIX = 0,
        /**
         * Center metering.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        CENTER = 1,
        /**
         * Spot metering.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        SPOT = 2
    }
    
    /**
     * AutoExposureQuery object.
     *
     * @interface AutoExposureQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface AutoExposureQuery {
        
        
        /**
         * Checks whether a specified exposure mode is supported.
         * Move to AutoExposureQuery interface from AutoExposure interface since 12.
         *
         * @param { ExposureMode } aeMode - Exposure mode
         * @returns { boolean } Is the exposure mode supported.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isExposureModeSupported(aeMode: ExposureMode): boolean;
        
        
        /**
         * Query the exposure compensation range.
         * Move to AutoExposureQuery interface from AutoExposure interface since 12.
         *
         * @returns { Array<double> } The array of compensation range.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getExposureBiasRange(): Array<double>;
        /**
         * Checks whether a specified exposure metering mode is supported.
         *
         * @param { ExposureMeteringMode } aeMeteringMode - Exposure metering mode
         * @returns { boolean } Is the exposure metering mode supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isExposureMeteringModeSupported(aeMeteringMode: ExposureMeteringMode): boolean;
    }
    
    /**
     * AutoExposure object.
     *
     * @extends AutoExposureQuery
     * @interface AutoExposure
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface AutoExposure extends AutoExposureQuery {
        
        /**
         * Gets current exposure mode.
         *
         * @returns { ExposureMode } The current exposure mode.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getExposureMode(): ExposureMode;
        
        /**
         * Sets Exposure mode.
         *
         * @param { ExposureMode } aeMode - Exposure mode
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setExposureMode(aeMode: ExposureMode): void;
        
        /**
         * Gets current metering point.
         *
         * @returns { Point } The current metering point.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getMeteringPoint(): Point;
        
        /**
         * Set the center point of the metering area.
         *
         * @param { Point } point - metering point
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setMeteringPoint(point: Point): void;
        
        
        /**
         * Set exposure compensation.
         *
         * @param { double } exposureBias - Exposure compensation
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setExposureBias(exposureBias: double): void;
        
        /**
         * Query the exposure value.
         *
         * @returns { double } The exposure value.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getExposureValue(): double;
        /**
         * Gets current exposure metering mode.
         *
         * @returns { ExposureMeteringMode } The current exposure metering mode.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getExposureMeteringMode(): ExposureMeteringMode;
        /**
         * Sets exposure metering mode.
         *
         * @param { ExposureMeteringMode } aeMeteringMode - Exposure metering mode
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setExposureMeteringMode(aeMeteringMode: ExposureMeteringMode): void;
    }
    
    /**
     * Enum for focus mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum FocusMode {
        
        /**
         * Manual mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FOCUS_MODE_MANUAL = 0,
        
        /**
         * Continuous auto mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FOCUS_MODE_CONTINUOUS_AUTO = 1,
        
        /**
         * Auto mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FOCUS_MODE_AUTO = 2,
        
        /**
         * Locked mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FOCUS_MODE_LOCKED = 3
    }
    
    /**
     * Enum for focus state.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum FocusState {
        
        /**
         * Scan state.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FOCUS_STATE_SCAN = 0,
        
        /**
         * Focused state.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FOCUS_STATE_FOCUSED = 1,
        
        /**
         * Unfocused state.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FOCUS_STATE_UNFOCUSED = 2
    }
    /**
     * Enum for focus range type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum FocusRangeType {
        /**
         * Automatic focus range type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        AUTO = 0,
        /**
         * Focus on near objects primarily.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        NEAR = 1
    }
    /**
     * Enum for focus driven type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum FocusDrivenType {
        /**
         * Automatic focus driven type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        AUTO = 0,
        /**
         * Face focus driven type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        FACE = 1
    }
    /**
     * Enum for focus tracking mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum FocusTrackingMode {
        /**
         * Automatic focus tracking mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        AUTO = 0
    }
    /**
     * Focus tracking info.
     *
     * @typedef FocusTrackingInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface FocusTrackingInfo {
        /**
         * mode of focus tracking.
         *
         * @type { FocusTrackingMode }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        trackingMode: FocusTrackingMode;
        /**
         * region of focus tracking.
         *
         * @type { Rect }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        trackingRegion: Rect;
    }
    
    /**
     * Focus Query object.
     *
     * @interface FocusQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface FocusQuery {
        
        
        /**
         * Checks whether a specified focus mode is supported.
         * Move to FocusQuery interface from Focus interface since 12.
         *
         * @param { FocusMode } afMode - Focus mode.
         * @returns { boolean } Is the focus mode supported.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isFocusModeSupported(afMode: FocusMode): boolean;
        /**
         * Checks whether a specified focus range type is supported.
         *
         * @param { FocusRangeType } type - Focus range type.
         * @returns { boolean } Is the focus range type supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types;
         * 3. Parameter verification failed.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isFocusRangeTypeSupported(type: FocusRangeType): boolean;
        /**
         * Checks whether a specified focus driven type is supported.
         *
         * @param { FocusDrivenType } type - Focus driven type.
         * @returns { boolean } Is the focus driven type supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types;
         * 3. Parameter verification failed.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isFocusDrivenTypeSupported(type: FocusDrivenType): boolean;
    }
    
    /**
     * Focus object.
     *
     * @extends FocusQuery
     * @interface Focus
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface Focus extends FocusQuery {
        
        /**
         * Gets current focus mode.
         *
         * @returns { FocusMode } The current focus mode.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getFocusMode(): FocusMode;
        
        /**
         * Sets focus mode.
         *
         * @param { FocusMode } afMode - Target focus mode.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setFocusMode(afMode: FocusMode): void;
        
        /**
         * Sets focus point.
         *
         * @param { Point } point - Target focus point.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setFocusPoint(point: Point): void;
        
        /**
         * Gets current focus point.
         *
         * @returns { Point } Used to get the current focus. Failure of the interface call will return the
         * corresponding error code, which is of type CameraErrorCode.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getFocusPoint(): Point;
        
        /**
         * Gets current focal length.
         *
         * @returns { double } The current focal point.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getFocalLength(): double;
        /**
         * Sets focus assist.
         *
         * @param { boolean } enabled - Enable focus assist if TRUE.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setFocusAssist(enabled: boolean): void;
        /**
         * Gets current focus range type.
         *
         * @returns { FocusRangeType } The current focus range type.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getFocusRange(): FocusRangeType;
        /**
         * Sets focus range type.
         *
         * @param { FocusRangeType } type - Target focus range type.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types;
         * 3. Parameter verification failed.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setFocusRange(type: FocusRangeType): void;
        /**
         * Gets current focus driven type.
         *
         * @returns { FocusDrivenType } The current focus driven type.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getFocusDriven(): FocusDrivenType;
        /**
         * Sets focus driven type.
         *
         * @param { FocusDrivenType } type - Target focus driven type.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types;
         * 3. Parameter verification failed.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setFocusDriven(type: FocusDrivenType): void;
    }
    /**
     * ManualFocus object.
     *
     * @interface ManualFocus
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ManualFocus {
        /**
         * Gets current focus distance.
         *
         * @returns { double } The current focus distance.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getFocusDistance(): double;
        /**
         * Sets focus distance.
         *
         * @param { double } distance - Focus distance
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setFocusDistance(distance: double): void;
    }
    
    /**
     * Enumerates the camera white balance modes.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum WhiteBalanceMode {
        
        /**
         * Automatic white balance mode.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        AUTO = 0,
        
        /**
         * Cloudy white balance mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CLOUDY = 1,
        
        /**
         * Incandescent white balance mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        INCANDESCENT = 2,
        
        /**
         * Fluorescent white balance mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FLUORESCENT = 3,
        
        /**
         * Daylight white balance mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        DAYLIGHT = 4,
        
        /**
         * Manual white balance mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        MANUAL = 5,
        
        /**
         * Lock white balance mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        LOCKED = 6
    }
    
    /**
     * White Balance Query object.
     *
     * @interface WhiteBalanceQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface WhiteBalanceQuery {
        
        /**
         * Checks whether the specified white balance mode is supported.
         * @param { WhiteBalanceMode } mode White balance mode.
         * @returns { boolean } Check result.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isWhiteBalanceModeSupported(mode: WhiteBalanceMode): boolean;
        
        /**
         * Query the white balance mode range.
         *
         * @returns { Array<int> } The array of white balance mode range.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getWhiteBalanceRange(): Array<int>;
    }
    
    /**
     * WhiteBalance object.
     *
     * @extends WhiteBalanceQuery
     * @interface WhiteBalance
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface WhiteBalance extends WhiteBalanceQuery {
        
        /**
         * Obtains the white balance mode in use.
         * @returns { WhiteBalanceMode } White balance mode.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getWhiteBalanceMode(): WhiteBalanceMode;
        
        /**
         * Sets white balance mode.
         *
         * @param { WhiteBalanceMode } mode - Target white balance mode.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setWhiteBalanceMode(mode: WhiteBalanceMode): void;
        
        /**
         * Gets current white balance.
         *
         * @returns { int } The current white balance.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getWhiteBalance(): int;
        
        /**
         * Sets white balance.
         *
         * @param { int } whiteBalance - White balance.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setWhiteBalance(whiteBalance: int): void;
    }
    /**
     * Manual ISO Query object.
     *
     * @interface ManualIsoQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ManualIsoQuery {
        /**
         * Checks whether ISO is supported.
         *
         * @returns { boolean } Is the ISO supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isManualIsoSupported(): boolean;
        /**
         * Get the ISO range.
         *
         * @returns { Array<int> } The array of ISO range.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getIsoRange(): Array<int>;
    }
    /**
     * ManualIso object.
     *
     * @extends ManualIsoQuery
     * @interface ManualIso
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ManualIso extends ManualIsoQuery {
        /**
         * Gets current ISO.
         *
         * @returns { int } The current ISO.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getIso(): int;
        /**
         * Sets ISO.
         *
         * @param { int } iso - ISO
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setIso(iso: int): void;
    }
    
    /**
     * Enum for smooth zoom mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum SmoothZoomMode {
        
        /**
         * Normal zoom mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        NORMAL = 0
    }
    
    /**
     * SmoothZoomInfo object
     *
     * @typedef SmoothZoomInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface SmoothZoomInfo {
        
        /**
         * The duration of smooth zoom.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        duration: int;
    }
    /**
     * ZoomPointInfo object.
     *
     * @typedef ZoomPointInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ZoomPointInfo {
        /**
         * The zoom ratio value.
         *
         * @type { double }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly zoomRatio: double;
        /**
         * The equivalent focal Length.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly equivalentFocalLength: int;
    }
    /**
     * Zoom info object
     *
     * @typedef ZoomInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ZoomInfo {
        /**
         * Zoom ratio range value.
         *
         * @type { ?Array<double> }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly zoomRatioRange?: Array<double>;
    }
    
    /**
     * Zoom query object.
     *
     * @interface ZoomQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface ZoomQuery {
        
        
        /**
         * Gets all supported zoom ratio range.
         * Move to ZoomQuery interface from Zoom since 12.
         *
         * @returns { Array<double> } The zoom ratio range.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getZoomRatioRange(): Array<double>;
        /**
         * Gets all important zoom ratio infos.
         *
         * @returns { Array<ZoomPointInfo> } The zoom point infos.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getZoomPointInfos(): Array<ZoomPointInfo>;
    }
    
    /**
     * Zoom object.
     *
     * @extends ZoomQuery
     * @interface Zoom
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface Zoom extends ZoomQuery {
        
        
        /**
         * Gets zoom ratio.
         *
         * @returns { double } The zoom ratio value.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getZoomRatio(): double;
        
        /**
         * Sets zoom ratio.
         *
         * @param { double } zoomRatio - Target zoom ratio.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setZoomRatio(zoomRatio: double): void;
        
        
        /**
         * Sets target zoom ratio by smooth method.
         *
         * @param { double } targetRatio - Target zoom ratio.
         * @param { SmoothZoomMode } mode - Smooth zoom mode.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setSmoothZoom(targetRatio: double, mode?: SmoothZoomMode): void;
        /**
         * Notify device to prepare for zoom.
         *
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        prepareZoom(): void;
        /**
         * Notify device of zoom completion.
         *
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        unprepareZoom(): void;
    }
    
    /**
     * Enum for video stabilization mode.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum VideoStabilizationMode {
        
        /**
         * Turn off video stablization.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        OFF = 0,
        
        /**
         * LOW mode provides basic stabilization effect.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        LOW = 1,
        
        /**
         * MIDDLE mode means algorithms can achieve better effects than LOW mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        MIDDLE = 2,
        
        /**
         * HIGH mode means algorithms can achieve better effects than MIDDLE mode.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        HIGH = 3,
        
        /**
         * The stabilization algorithm is selected automatically. Selection of the stabilization algorithm is performed automatically.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        AUTO = 4
    }
    
    /**
     * Stabilization Query object.
     *
     * @interface StabilizationQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface StabilizationQuery {
        
        
        /**
         * Check whether the specified video stabilization mode is supported.
         * Move to StabilizationQuery interface from Stabilization since 12.
         *
         * @param { VideoStabilizationMode } vsMode - Video Stabilization mode.
         * @returns { boolean } Is video stabilization mode supported.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isVideoStabilizationModeSupported(vsMode: VideoStabilizationMode): boolean;
    }
    
    /**
     * Stabilization object.
     *
     * @extends StabilizationQuery
     * @interface Stabilization
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface Stabilization extends StabilizationQuery {
        
        /**
         * Query the video stabilization mode currently in use.
         *
         * @returns { VideoStabilizationMode } The current video stabilization mode.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getActiveVideoStabilizationMode(): VideoStabilizationMode;
        
        /**
         * Set video stabilization mode.
         *
         * @param { VideoStabilizationMode } mode - video stabilization mode to set.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setVideoStabilizationMode(mode: VideoStabilizationMode): void;
    }
    /**
     * Enumerates the camera portrait theme types.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum PortraitThemeType {
        /**
         * Natural portrait theme type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        NATURAL = 0,
        /**
         * Delicate portrait theme type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        DELICATE = 1,
        /**
         * Stylish portrait theme type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        STYLISH = 2
    }
    /**
     * Enumerates the camera beauty effect types.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum BeautyType {
        /**
         * Auto beauty type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        AUTO = 0,
        /**
         * Skin smooth beauty type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        SKIN_SMOOTH = 1,
        /**
         * Face slender beauty type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        FACE_SLENDER = 2,
        /**
         * Skin tone beauty type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        SKIN_TONE = 3
    }
    /**
     * Beauty Query object.
     *
     * @interface BeautyQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface BeautyQuery {
        
        /**
         * Gets supported beauty effect types.
         * Move to BeautyQuery from Beauty since 12.
         *
         * @returns { Array<BeautyType> } List of beauty effect types.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedBeautyTypes(): Array<BeautyType>;
        
        /**
         * Gets the specific beauty effect type range.
         * Move to BeautyQuery from Beauty since 12.
         *
         * @param { BeautyType } type - The type of beauty effect.
         * @returns { Array<int> } The array of the specific beauty effect range.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedBeautyRange(type: BeautyType): Array<int>;
        /**
         * Gets supported portrait theme type.
         *
         * @returns { Array<PortraitThemeType> } Lists of portrait theme types
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedPortraitThemeTypes(): Array<PortraitThemeType>;
        /**
         * Checks whether portrait theme is supported.
         *
         * @returns { boolean } Is portrait theme supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isPortraitThemeSupported(): boolean;
    }
    /**
     * Beauty object.
     *
     * @extends BeautyQuery
     * @interface Beauty
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface Beauty extends BeautyQuery {
        /**
         * Gets the beauty effect in use.
         *
         * @param { BeautyType } type - The type of beauty effect.
         * @returns { int } the beauty effect in use.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getBeauty(type: BeautyType): int;
        /**
         * Sets a beauty effect for a camera device.
         *
         * @param { BeautyType } type - The type of beauty effect.
         * @param { int } value The number of beauty effect.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setBeauty(type: BeautyType, value: int): void;
        /**
         * Sets a portrait theme type for a camera device.
         *
         * @param { PortraitThemeType } type - The type of portrait theme.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setPortraitThemeType(type: PortraitThemeType): void;
    }
    /**
     * EffectSuggestion object.
     *
     * @typedef EffectSuggestion
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface EffectSuggestion {
        /**
         * Checks whether effect suggestion is supported.
         *
         * @returns { boolean } Is the effect suggestion supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isEffectSuggestionSupported(): boolean;
        /**
         * Enable effect suggestion for session.
         *
         * @param { boolean } enabled enable effect suggestion for session if TRUE..
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableEffectSuggestion(enabled: boolean): void;
        /**
         * Gets supported effect suggestion types.
         *
         * @returns { Array<EffectSuggestionType> } The array of the effect suggestion types.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedEffectSuggestionTypes(): Array<EffectSuggestionType>;
        /**
         * Set the range of effect suggestion type and enable status.
         * The application should fully set all data when it starts up.
         *
         * @param { Array<EffectSuggestionStatus> } status - The array of the effect suggestion status.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setEffectSuggestionStatus(status: Array<EffectSuggestionStatus>): void;
        /**
         * Update the enable status of the effect suggestion type.
         *
         * @param { EffectSuggestionType } type - The type of effect suggestion.
         * @param { boolean } enabled - The status of effect suggestion type.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        updateEffectSuggestion(type: EffectSuggestionType, enabled: boolean): void;
    }
    /**
     * Enumerates the camera color effect types.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum ColorEffectType {
        /**
         * Normal color effect type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        NORMAL = 0,
        /**
         * Bright color effect type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        BRIGHT = 1,
        /**
         * Soft color effect type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        SOFT = 2,
        /**
         * Black white color effect type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        BLACK_WHITE = 3
    }
    /**
     * Enumerates the control center effect types.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum ControlCenterEffectType {
        /**
         * Beauty type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        BEAUTY = 0,
        /**
         * Portrait type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        PORTRAIT = 1
    }
    /**
     * Enum for policy type
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum PolicyType {
        /**
         * PRIVACY type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        PRIVACY = 1
    }
    /**
     * Color Effect Query object.
     *
     * @interface ColorEffectQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ColorEffectQuery {
        
        /**
         * Gets supported color effect types.
         * Move to ColorEffectQuery from ColorEffect since 12.
         *
         * @returns { Array<ColorEffectType> } List of color effect types.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedColorEffects(): Array<ColorEffectType>;
    }
    /**
     * Color effect object.
     *
     * @extends ColorEffectQuery
     * @interface ColorEffect
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ColorEffect extends ColorEffectQuery {
        /**
         * Gets the specific color effect type.
         *
         * @returns { ColorEffectType } The array of the specific color effect type.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getColorEffect(): ColorEffectType;
        /**
         * Sets a color effect for a camera device.
         *
         * @param { ColorEffectType } type - The type of color effect.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setColorEffect(type: ColorEffectType): void;
    }
    
    /**
     * Color Management Query object.
     *
     * @interface ColorManagementQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface ColorManagementQuery {
        
        
        /**
         * Gets the supported color space types.
         *
         * @returns { Array<colorSpaceManager.ColorSpace> } The array of the supported color space for the session.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getSupportedColorSpaces(): Array<colorSpaceManager.ColorSpace>;
    }
    
    /**
     * Color Management object.
     *
     * @extends ColorManagementQuery
     * @interface ColorManagement
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface ColorManagement extends ColorManagementQuery {
        
        /**
         * Gets the specific color space type.
         *
         * @returns { colorSpaceManager.ColorSpace } Current color space.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getActiveColorSpace(): colorSpaceManager.ColorSpace;
        
        /**
         * Sets a color space for the session.
         *
         * @param { colorSpaceManager.ColorSpace } colorSpace - The type of color space.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400102 - The colorSpace does not match the format.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setColorSpace(colorSpace: colorSpaceManager.ColorSpace): void;
    }
    
    /**
     * Auto Device Switch Query object.
     *
     * @interface AutoDeviceSwitchQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface AutoDeviceSwitchQuery {
        
        
        /**
         * Check whether auto device switch is supported.
         *
         * @returns { boolean } Is auto device switch supported.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isAutoDeviceSwitchSupported(): boolean;
    }
    
    /**
     * Auto Device Switch object.
     *
     * @extends AutoDeviceSwitchQuery
     * @interface AutoDeviceSwitch
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface AutoDeviceSwitch extends AutoDeviceSwitchQuery {
        
        /**
         * Enable auto device switch for session.
         *
         * @param { boolean } enabled - enable auto device switch if TRUE.
         * @throws { BusinessError } 7400101 - Parameter error. Possible causes:
         * 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types;
         * 3. Parameters verification failed.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        enableAutoDeviceSwitch(enabled: boolean): void;
    }
    
    /**
     * Auto Device Switch Status.
     *
     * @typedef AutoDeviceSwitchStatus
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface AutoDeviceSwitchStatus {
        
        /**
         * Notify whether device is switched.
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly isDeviceSwitched: boolean;
        
        /**
         * Notify whether device capability is changed.
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly isDeviceCapabilityChanged: boolean;
    }
    
    /**
     * Macro Query object.
     *
     * @interface MacroQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface MacroQuery {
        
        
        /**
         * Determine whether camera macro is supported.
         *
         * @returns { boolean } Is camera macro supported.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isMacroSupported(): boolean;
    }
    
    /**
     * Macro object.
     *
     * @extends MacroQuery
     * @interface Macro
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface Macro extends MacroQuery {
        
        
        /**
         * Enable macro for camera.
         *
         * @param { boolean } enabled - enable macro for camera if TRUE.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        enableMacro(enabled: boolean): void;
    }
    /**
     * Enum for usage type used in capture session.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum UsageType {
        /**
         * Bokeh usage type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        BOKEH = 0
    }
    
    /**
     * Session object.
     *
     * @interface Session
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface Session {
        
        
        /**
         * Begin capture session config.
         *
         * @throws { BusinessError } 7400105 - Session config locked.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        beginConfig(): void;
        /**
         * @since 20
         */
        overload commitConfig {
            commitConfigWithCallback,
            commitConfigReturnsPromise
        };
        /**
         * Commit capture session config.
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        commitConfigWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Commit capture session config.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        commitConfigReturnsPromise(): Promise<void>;
        
        /**
         * Determines whether the camera input can be added into the session.
         * This method is valid between Session.beginConfig() and Session.commitConfig().
         *
         * @param { CameraInput } cameraInput - Target camera input to add.
         * @returns { boolean } You can add the input into the session.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        canAddInput(cameraInput: CameraInput): boolean;
        
        
        
        /**
         * Adds a camera input.
         * This method is valid between Session.beginConfig() and Session.commitConfig().
         *
         * @param { CameraInput } cameraInput - Target camera input to add.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        addInput(cameraInput: CameraInput): void;
        
        
        
        /**
         * Removes a camera input.
         * This method is valid between Session.beginConfig() and Session.commitConfig().
         *
         * @param { CameraInput } cameraInput - Target camera input to remove.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        removeInput(cameraInput: CameraInput): void;
        
        /**
         * Determines whether the camera output can be added into the session.
         * This method is valid after Session.addInput(cameraInput) and before Session.commitConfig().
         *
         * @param { CameraOutput } cameraOutput - Target camera output to add.
         * @returns { boolean } You can add the output into the session.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        canAddOutput(cameraOutput: CameraOutput): boolean;
        
        
        
        /**
         * Adds a camera output.
         * This method is valid after Session.addInput(cameraInput) and before Session.commitConfig().
         *
         * @param { CameraOutput } cameraOutput - Target camera output to add.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        addOutput(cameraOutput: CameraOutput): void;
        
        
        
        /**
         * Removes a camera output.
         * This method is valid between Session.beginConfig() and Session.commitConfig().
         *
         * @param { CameraOutput } cameraOutput - Target camera output to remove.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        removeOutput(cameraOutput: CameraOutput): void;
        /**
         * @since 20
         */
        overload start {
            startWithCallback,
            startReturnsPromise
        };
        /**
         * Starts capture session.
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        startWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Starts capture session.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        startReturnsPromise(): Promise<void>;
        /**
         * @since 20
         */
        overload stop {
            stopWithCallback,
            stopReturnsPromise
        };
        /**
         * Stops capture session.
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        stopWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Stops capture session.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        stopReturnsPromise(): Promise<void>;
        /**
         * @since 20
         */
        overload release {
            releaseWithCallback,
            releaseReturnsPromise
        };
        /**
         * Release capture session instance.
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        releaseWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Release capture session instance.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        releaseReturnsPromise(): Promise<void>;
        /**
         * Set usage for the capture session.
         *
         * @param { UsageType } usage - The capture session usage.
         * @param { boolean } enabled - Enable usage for session if TRUE.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setUsage(usage: UsageType, enabled: boolean): void;
        /**
         * Get the supported camera output capability set.
         *
         * @param { CameraDevice } camera - Camera device.
         * @returns { Array<CameraOutputCapability> } The array of the output capability.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getCameraOutputCapabilities(camera: CameraDevice): Array<CameraOutputCapability>;
    }
    
    /**
     * Types of preconfig, which used to configure session conveniently.
     * Preconfig type contains common use cases of camera output.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum PreconfigType {
        
        /**
         * 720P output for preconfig.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        PRECONFIG_720P = 0,
        
        /**
         * 1080P output for preconfig.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        PRECONFIG_1080P = 1,
        
        /**
         * 4K output for preconfig.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        PRECONFIG_4K = 2,
        
        /**
         * high quality output for preconfig.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        PRECONFIG_HIGH_QUALITY = 3
    }
    
    /**
     * The aspect ratios of preconfig, which used to configure session conveniently.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum PreconfigRatio {
        
        /**
         * Aspect ratio 1:1 for preconfig.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        PRECONFIG_RATIO_1_1 = 0,
        
        /**
         * Aspect ratio 4:3 for preconfig.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        PRECONFIG_RATIO_4_3 = 1,
        
        /**
         * Aspect ratio 16:9 for preconfig.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        PRECONFIG_RATIO_16_9 = 2
    }
    /**
     * Enum for feature type used in scene detection.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum SceneFeatureType {
        /**
         * Feature for boost moon capture.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        MOON_CAPTURE_BOOST = 0,
        /**
         * Feature for tripod detection.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        TRIPOD_DETECTION = 1,
        /**
         * Feature for low light boost.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        LOW_LIGHT_BOOST = 2
    }
    /**
     * Feature Detection Result.
     *
     * @typedef SceneFeatureDetectionResult
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface SceneFeatureDetectionResult {
        /**
         * Detected feature type.
         *
         * @type { SceneFeatureType }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly featureType: SceneFeatureType;
        /**
         * Check whether feature is detected.
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly detected: boolean;
    }
    /**
     * Enum for tripod status.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum TripodStatus {
        /**
         * Invalid tripod status.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        INVALID = 0,
        /**
         * Tripod is active.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        ACTIVE = 1,
        /**
         * Enter tripod stabilization state.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        ENTERING = 2,
        /**
         * Exit tripod stabilization state.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        EXITING = 3
    }
    /**
     * Tripod detection result.
     *
     * @extends SceneFeatureDetectionResult
     * @interface TripodDetectionResult
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface TripodDetectionResult extends SceneFeatureDetectionResult {
        /**
         * tripod status.
         *
         * @type { TripodStatus }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly tripodStatus: TripodStatus;
    }
    /**
     * Scene detection query.
     *
     * @interface SceneDetectionQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface SceneDetectionQuery {
        /**
         * Check whether specified feature is supported.
         *
         * @param { SceneFeatureType } type - Specified feature type.
         * @returns { boolean } - Is specified feature supported.
         * @throws { BusinessError } 202 - Not System Application, only throw in session usage.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isSceneFeatureSupported(type: SceneFeatureType): boolean;
    }
    /**
     * Scene detection.
     *
     * @extends SceneDetectionQuery
     * @interface SceneDetection
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface SceneDetection extends SceneDetectionQuery {
        /**
         * Enable specified feature.
         *
         * @param { SceneFeatureType } type - Specified feature type.
         * @param { boolean } enabled - Target feature status.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableSceneFeature(type: SceneFeatureType, enabled: boolean): void;
    }
    
    /**
     * Photo session object for system hap.
     *
     * @extends PhotoSession, Beauty, ColorEffect, ColorManagement, Macro, SceneDetection, EffectSuggestion, DepthFusion
     * @interface PhotoSessionForSys
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface PhotoSessionForSys extends PhotoSession, Beauty, ColorEffect, ColorManagement, Macro, SceneDetection, EffectSuggestion, DepthFusion {
    }
    
    
    
    /**
     * Photo session object.
     * @extends Session, Flash, AutoExposure, WhiteBalance, Focus, Zoom, ColorManagement, AutoDeviceSwitch, Macro
     * @interface PhotoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
       */
    interface PhotoSession extends Session, Flash, AutoExposure, WhiteBalance, Focus, Zoom, ColorManagement, AutoDeviceSwitch, Macro {
        
        /**
         * Gets whether the choosed preconfig type can be used to configure photo session.
         * Must choose preconfig type from {@link PreconfigType}.
         *
         * @param { PreconfigType } preconfigType - preconfig type.
         * @param { PreconfigRatio } preconfigRatio - the aspect ratio of surface for preconfig,
         *                                            default value {@link PreconfigRatio#PRECONFIG_RATIO_4_3}.
         * @returns { boolean } Whether the choosed preconfig type can be used.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        canPreconfig(preconfigType: PreconfigType, preconfigRatio?: PreconfigRatio): boolean;
        
        /**
         * Configure photo session with the preconfig type.
         * Must choose preconfig type from {@link PreconfigType}.
         *
         * @param { PreconfigType } preconfigType - preconfig type.
         * @param { PreconfigRatio } preconfigRatio - the aspect ratio of surface for preconfig,
         *                                            default value {@link PreconfigRatio#PRECONFIG_RATIO_4_3}
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        preconfig(preconfigType: PreconfigType, preconfigRatio?: PreconfigRatio): void;
        /**
        * @since 20
        */
        overload on {
            onError,
            onFocusStateChange,
            onSmoothZoomInfoAvailable,
            onMacroStatusChanged,
            onFeatureDetection,
            onEffectSuggestionChange,
            onAutoDeviceSwitchStatusChange,
            onLcdFlashStatus,
            onSystemPressureLevelChange
        };
        /**
         * Registers a listener for error events from a normal video session to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Registers a listener for camera focus state changes to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Registers a listener for state changes in the camera's smooth zoom to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Subscribes camera macro status event callback.
         *
         * @param { 'macroStatusChanged' } type - Event type.
         * @param { AsyncCallback<boolean> } callback - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onMacroStatusChanged(type: 'macroStatusChanged', callback: AsyncCallback<boolean>): void;
        /**
         * Subscribes to feature detection results.
         *
         * @param { 'featureDetection' } type - Event type.
         * @param { SceneFeatureType } featureType - Feature type.
         * @param { AsyncCallback<SceneFeatureDetectionResult> } callback - Callback used to get the detection result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFeatureDetection(type: 'featureDetection', featureType: SceneFeatureType, callback: AsyncCallback<SceneFeatureDetectionResult>): void;
        /**
         * Subscribes to effect suggestion event callback.
         *
         * @param { 'effectSuggestionChange' } type - Event type.
         * @param { AsyncCallback<EffectSuggestionType> } callback - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onEffectSuggestionChange(type: 'effectSuggestionChange', callback: AsyncCallback<EffectSuggestionType>): void;
        /**
         * Registers a listener for the camera's automatic lens switching state changes to get the result
         * by registering a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'autoDeviceSwitchStatusChange' } type - Event type.
         * @param { AsyncCallback<AutoDeviceSwitchStatus> } callback - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onAutoDeviceSwitchStatusChange(type: 'autoDeviceSwitchStatusChange', callback: AsyncCallback<AutoDeviceSwitchStatus>): void;
        /**
         * Subscribes to lcd flash status.
         *
         * @param { 'lcdFlashStatus' } type - Event type.
         * @param { AsyncCallback<LcdFlashStatus> } callback - Callback used to get the lcd flash status.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onLcdFlashStatus(type: 'lcdFlashStatus', callback: AsyncCallback<LcdFlashStatus>): void;
        /**
         * Subscribes to system pressure level event callback.
         *
         * @param { 'systemPressureLevelChange' } type - Event type.
         * @param { AsyncCallback<SystemPressureLevel> } callback - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onSystemPressureLevelChange(type: 'systemPressureLevelChange', callback: AsyncCallback<SystemPressureLevel>): void;
        /**
        * @since 20
        */
        overload off {
            offError,
            offFocusStateChange,
            offSmoothZoomInfoAvailable,
            offMacroStatusChanged,
            offFeatureDetection,
            offEffectSuggestionChange,
            offAutoDeviceSwitchStatusChange,
            offLcdFlashStatus,
            offSystemPressureLevelChange
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Unsubscribes camera macro status event callback.
         *
         * @param { 'macroStatusChanged' } type - Event type.
         * @param { AsyncCallback<boolean> } [callback] - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offMacroStatusChanged(type: 'macroStatusChanged', callback?: AsyncCallback<boolean>): void;
        /**
         * Unsubscribes from feature detection result.
         *
         * @param { 'featureDetection' } type - Event type.
         * @param { SceneFeatureType } featureType - Feature type.
         * @param { AsyncCallback<SceneFeatureDetectionResult> } [callback] - Callback used to get the detection result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFeatureDetection(type: 'featureDetection', featureType: SceneFeatureType, callback?: AsyncCallback<SceneFeatureDetectionResult>): void;
        /**
         * Unsubscribes from effect suggestion event callback.
         *
         * @param { 'effectSuggestionChange' } type - Event type.
         * @param { AsyncCallback<EffectSuggestionType> } [callback] - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offEffectSuggestionChange(type: 'effectSuggestionChange', callback?: AsyncCallback<EffectSuggestionType>): void;
        /**
         * Unsubscribes to auto device switch status event callback.
         *
         * @param { 'autoDeviceSwitchStatusChange' } type - Event type.
         * @param { AsyncCallback<AutoDeviceSwitchStatus> } [callback] - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offAutoDeviceSwitchStatusChange(type: 'autoDeviceSwitchStatusChange', callback?: AsyncCallback<AutoDeviceSwitchStatus>): void;
        /**
         * Unsubscribes from lcd flash status.
         *
         * @param { 'lcdFlashStatus' } type - Event type.
         * @param { AsyncCallback<LcdFlashStatus> } [callback] - Callback used to get the lcd flash status.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offLcdFlashStatus(type: 'lcdFlashStatus', callback?: AsyncCallback<LcdFlashStatus>): void;
        /**
         * Unsubscribes to system pressure level event callback.
         *
         * @param { 'systemPressureLevelChange' } type - Event type.
         * @param { AsyncCallback<SystemPressureLevel> } [callback] - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offSystemPressureLevelChange(type: 'systemPressureLevelChange', callback?: AsyncCallback<SystemPressureLevel>): void;
        /**
         * Gets session functions.
         *
         * @param { CameraOutputCapability } outputCapability - CameraOutputCapability to set.
         * @returns { Array<PhotoFunctions> } List of session functions.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSessionFunctions(outputCapability: CameraOutputCapability): Array<PhotoFunctions>;
        /**
         * Gets session conflict functions.
         *
         * @returns { Array<PhotoConflictFunctions> } List of session conflict functions.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSessionConflictFunctions(): Array<PhotoConflictFunctions>;
    }
    
    
    /**
     * Video session object used by the system camera.
     *
     * @extends VideoSession, Beauty, ColorEffect, ColorManagement, Macro, Aperture, ColorReservation, EffectSuggestion
     * @interface VideoSessionForSys
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface VideoSessionForSys extends VideoSession, Beauty, ColorEffect, ColorManagement, Macro, Aperture, ColorReservation, EffectSuggestion {
    }
    
    /**
     * Enum for quality prioritization.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum QualityPrioritization {
        
        /**
         * High quality priority.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        HIGH_QUALITY = 0,
        
        /**
         * Power balance priority.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        POWER_BALANCE = 1
    }
    
    
    
    /**
     * Video session object.
     *
     * @extends Session, Flash, AutoExposure, WhiteBalance, Focus, Zoom, Stabilization, ColorManagement, AutoDeviceSwitch, Macro
     * @interface VideoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface VideoSession extends Session, Flash, AutoExposure, WhiteBalance, Focus, Zoom, Stabilization, ColorManagement, AutoDeviceSwitch, Macro {
        
        /**
         * Gets whether the choosed preconfig type can be used to configure video session.
         * Must choose preconfig type from {@link PreconfigType}.
         *
         * @param { PreconfigType } preconfigType - preconfig type.
         * @param { PreconfigRatio } preconfigRatio - the aspect ratio of surface for preconfig,
         *                                            default value {@link PreconfigRatio#PRECONFIG_RATIO_16_9}.
         * @returns { boolean } Whether the choosed preconfig type can be used.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        canPreconfig(preconfigType: PreconfigType, preconfigRatio?: PreconfigRatio): boolean;
        
        /**
         * Configure video session with the preconfig type.
         * Must choose preconfig type from {@link PreconfigType}.
         *
         * @param { PreconfigType } preconfigType - preconfig type.
         * @param { PreconfigRatio } preconfigRatio - the aspect ratio of surface for preconfig,
         *                                            default value {@link PreconfigRatio#PRECONFIG_RATIO_16_9}.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        preconfig(preconfigType: PreconfigType, preconfigRatio?: PreconfigRatio): void;
        /**
         * Gets session functions.
         *
         * @param { CameraOutputCapability } outputCapability - CameraOutputCapability to set.
         * @returns { Array<VideoFunctions> } List of session functions.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSessionFunctions(outputCapability: CameraOutputCapability): Array<VideoFunctions>;
        /**
         * Gets session conflict functions.
         *
         * @returns { Array<VideoConflictFunctions> } List of session conflict functions.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSessionConflictFunctions(): Array<VideoConflictFunctions>;
        
        /**
         * Sets quality prioritization.
         * Setting to power balance reduces video quality to conserve power, suitable for long-duration recordings where
         * video quality is less critical.
         *
         * @param { QualityPrioritization } quality - Target quality prioritization, with a default of HIGH_QUALITY.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types;
         * 3. Parameter verification failed.
         * @throws { BusinessError } 7400103 - Session not config. The session has not been committed or configured.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setQualityPrioritization(quality: QualityPrioritization): void;
        /**
        * @since 20
        */
        overload on {
            onError,
            onFocusStateChange,
            onSmoothZoomInfoAvailable,
            onMacroStatusChanged,
            onLcdFlashStatus,
            onAutoDeviceSwitchStatusChange,
            onFocusTrackingInfoAvailable,
            onEffectSuggestionChange,
            onLightStatusChange
        };
        /**
         * Registers a listener for error events in normal photo sessions to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Registers a listener for error events in normal photo sessions to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Registers a listener for state changes in the camera's smooth zoom to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Subscribes camera macro status event callback.
         *
         * @param { 'macroStatusChanged' } type - Event type.
         * @param { AsyncCallback<boolean> } callback - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onMacroStatusChanged(type: 'macroStatusChanged', callback: AsyncCallback<boolean>): void;
        /**
         * Subscribes to lcd flash status.
         *
         * @param { 'lcdFlashStatus' } type - Event type.
         * @param { AsyncCallback<LcdFlashStatus> } callback - Callback used to get the lcd flash status.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onLcdFlashStatus(type: 'lcdFlashStatus', callback: AsyncCallback<LcdFlashStatus>): void;
        /**
         * Registers a listener for the camera's automatic lens switching state changes to get the
         * result by registering a callback function. This API uses an asynchronous callback to
         * return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'autoDeviceSwitchStatusChange' } type - Event type.
         * @param { AsyncCallback<AutoDeviceSwitchStatus> } callback - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onAutoDeviceSwitchStatusChange(type: 'autoDeviceSwitchStatusChange', callback: AsyncCallback<AutoDeviceSwitchStatus>): void;
        /**
         * Subscribes to focus tracking info event callback.
         *
         * @param { 'focusTrackingInfoAvailable' } type - Event type.
         * @param { Callback<FocusTrackingInfo> } callback - Callback used to get the focus tracking info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusTrackingInfoAvailable(type: 'focusTrackingInfoAvailable', callback: Callback<FocusTrackingInfo>): void;
        /**
         * Subscribes to effect suggestion change events.
         * @param { 'effectSuggestionChange' } type - Event type.
         * @param { AsyncCallback<EffectSuggestionType> } callback - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.[object Object]
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onEffectSuggestionChange(type: 'effectSuggestionChange', callback: AsyncCallback<EffectSuggestionType>): void;
        /**
         * Subscribes camera light status event callback.
         *
         * @param { 'lightStatusChange' } type - Event type.
         * @param { AsyncCallback<LightStatus> } callback - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onLightStatusChange(type: 'lightStatusChange', callback: AsyncCallback<LightStatus>): void;
        /**
        * @since 20
        */
        overload off {
            offError,
            offFocusStateChange,
            offSmoothZoomInfoAvailable,
            offMacroStatusChanged,
            offLcdFlashStatus,
            offAutoDeviceSwitchStatusChange,
            offFocusTrackingInfoAvailable,
            offEffectSuggestionChange,
            offLightStatusChange
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Unsubscribes camera macro status event callback.
         *
         * @param { 'macroStatusChanged' } type - Event type.
         * @param { AsyncCallback<boolean> } [callback] - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offMacroStatusChanged(type: 'macroStatusChanged', callback?: AsyncCallback<boolean>): void;
        /**
         * Unsubscribes from lcd flash status.
         *
         * @param { 'lcdFlashStatus' } type - Event type.
         * @param { AsyncCallback<LcdFlashStatus> } [callback] - Callback used to get the lcd flash status.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offLcdFlashStatus(type: 'lcdFlashStatus', callback?: AsyncCallback<LcdFlashStatus>): void;
        /**
         * Unsubscribes to auto device switch status event callback.
         *
         * @param { 'autoDeviceSwitchStatusChange' } type - Event type.
         * @param { AsyncCallback<AutoDeviceSwitchStatus> } [callback] - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offAutoDeviceSwitchStatusChange(type: 'autoDeviceSwitchStatusChange', callback?: AsyncCallback<AutoDeviceSwitchStatus>): void;
        /**
         * Unsubscribes from focus tracking info event callback.
         *
         * @param { 'focusTrackingInfoAvailable' } type - Event type.
         * @param { Callback<FocusTrackingInfo> } [callback] - Callback used to get the focus tracking info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusTrackingInfoAvailable(type: 'focusTrackingInfoAvailable', callback?: Callback<FocusTrackingInfo>): void;
        /**
         * Unsubscribes from effect suggestion change events.
         * @param { 'effectSuggestionChange' } type - Event type.
         * @param { AsyncCallback<EffectSuggestionType> } [callback] - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.[object Object]
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offEffectSuggestionChange(type: 'effectSuggestionChange', callback?: AsyncCallback<EffectSuggestionType>): void;
        /**
         * Unsubscribes camera light status event callback.
         *
         * @param { 'lightStatusChange' } type - Event type.
         * @param { AsyncCallback<LightStatus> } [callback] - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offLightStatusChange(type: 'lightStatusChange', callback?: AsyncCallback<LightStatus>): void;
    }
    /**
     * Enumerates the system pressure levels of the current camera session. When the system pressure increases,
     * you are advised to reduce the load of the current camera session.
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum SystemPressureLevel {
        /**
         * Normal level. This level indicates that the system pressure is normal.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        SYSTEM_PRESSURE_NORMAL = 0,
        /**
         * Low level. This level indicates that the system pressure is slightly increased.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        SYSTEM_PRESSURE_MILD = 1,
        /**
         * Severity level. This level indicates that the system pressure is severely increased.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        SYSTEM_PRESSURE_SEVERE = 2,
        /**
         * Critical level. This level indicates that the system pressure has reached a critical threshold.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        SYSTEM_PRESSURE_CRITICAL = 3,
        /**
         * Shutdown level. This level indicates that the system pressure is fatal, and the camera session will be
         * shut down soon.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        SYSTEM_PRESSURE_SHUTDOWN = 4
    }
    /**
     * Enum for the camera light status.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum LightStatus {
        /**
         * Sufficient lighting.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        NORMAL = 0,
        /**
         * Insufficient lighting.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        INSUFFICIENT = 1
    }
    /**
     * Enumerates the camera portrait effects.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum PortraitEffect {
        /**
         * portrait effect off.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        OFF = 0,
        /**
         * circular blurring for portrait.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        CIRCLES = 1,
        /**
         * heart blurring for portrait.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        HEART = 2,
        /**
         * rotated blurring for portrait.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        ROTATED = 3,
        /**
         * studio blurring for portrait.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        STUDIO = 4,
        /**
         * theater blurring for portrait.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        THEATER = 5
    }
    /**
     * Portrait Query object.
     *
     * @interface PortraitQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface PortraitQuery {
        
        
        /**
         * Gets supported portrait effect.
         * Move to PortraitQuery interface from Portrait interface since 12.
         *
         * @returns { Array<PortraitEffect> } List of portrait effect.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedPortraitEffects(): Array<PortraitEffect>;
    }
    /**
     * Portrait object.
     *
     * @extends PortraitQuery
     * @interface Portrait
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface Portrait extends PortraitQuery {
        
        /**
         * Gets the portrait effect in use.
         * Move to Portrait interface from PortraitPhotoSession interface since 11.
         *
         * @returns { PortraitEffect } The portrait effect in use.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getPortraitEffect(): PortraitEffect;
        
        /**
         * Sets a portrait effect for a camera device.
         * Move to Portrait interface from PortraitPhotoSession interface since 11.
         *
         * @param { PortraitEffect } effect - Effect Portrait effect to set.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setPortraitEffect(effect: PortraitEffect): void;
    }
    /**
     * Zoom range.
     *
     * @typedef ZoomRange
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ZoomRange {
        /**
         * Min zoom value.
         *
         * @type { double }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly min: double;
        /**
         * Max zoom value.
         *
         * @type { double }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly max: double;
    }
    /**
     * Physical Aperture object
     *
     * @typedef PhysicalAperture
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface PhysicalAperture {
        /**
         * Zoom Range of the specific physical aperture.
         *
         * @type { ZoomRange }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        zoomRange: ZoomRange;
        /**
         * The supported physical apertures.
         *
         * @type { Array<double> }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        apertures: Array<double>;
    }
    /**
     * Aperture Query object.
     *
     * @interface ApertureQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ApertureQuery {
        
        /**
         * Gets the supported virtual apertures.
         * Move to ApertureQuery interface from Aperture since 12.
         *
         * @returns { Array<double> } The array of supported virtual apertures.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedVirtualApertures(): Array<double>;
        
        /**
        * Gets the supported physical apertures.
        * Move to ApertureQuery interface from Aperture since 12.
        *
        * @returns { Array<PhysicalAperture> } The array of supported physical apertures.
        * @throws { BusinessError } 202 - Not System Application.
        * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
        * @syscap SystemCapability.Multimedia.Camera.Core
        * @systemapi
        * @since 20
        */
        getSupportedPhysicalApertures(): Array<PhysicalAperture>;
    }
    /**
     * Aperture object.
     *
     * @extends ApertureQuery
     * @interface Aperture
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface Aperture extends ApertureQuery {
        /**
         * Gets current virtual aperture value.
         *
         * @returns { double } The current virtual aperture value.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getVirtualAperture(): double;
        /**
         * Sets virtual aperture value.
         *
         * @param { double } aperture - virtual aperture value
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setVirtualAperture(aperture: double): void;
        /**
         * Gets current physical aperture value.
         *
         * @returns { double } The current physical aperture value.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getPhysicalAperture(): double;
        /**
         * Sets physical aperture value.
         *
         * @param { double } aperture - physical aperture value
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setPhysicalAperture(aperture: double): void;
    }
    /**
     * Portrait Photo session object.
     *
     * @extends Session, Flash, AutoExposure, Focus, Zoom, Beauty, ColorEffect, ColorManagement, Portrait, Aperture
     * @interface PortraitPhotoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
       * @since 20
       */
    interface PortraitPhotoSession extends Session, Flash, AutoExposure, Focus, Zoom, Beauty, ColorEffect, ColorManagement, Portrait, Aperture {
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange,
            onSmoothZoomInfoAvailable,
            onLcdFlashStatus
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Subscribes zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Subscribes to lcd flash status.
         *
         * @param { 'lcdFlashStatus' } type - Event type.
         * @param { AsyncCallback<LcdFlashStatus> } callback - Callback used to get the lcd flash status.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onLcdFlashStatus(type: 'lcdFlashStatus', callback: AsyncCallback<LcdFlashStatus>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange,
            offSmoothZoomInfoAvailable,
            offLcdFlashStatus
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Unsubscribes from lcd flash status.
         *
         * @param { 'lcdFlashStatus' } type - Event type.
         * @param { AsyncCallback<LcdFlashStatus> } [callback] - Callback used to get the lcd flash status.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offLcdFlashStatus(type: 'lcdFlashStatus', callback?: AsyncCallback<LcdFlashStatus>): void;
        /**
         * Gets session functions.
         *
         * @param { CameraOutputCapability } outputCapability - CameraOutputCapability to set.
         * @returns { Array<PortraitPhotoFunctions> } List of session functions.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified. 2.Incorrect parameter types.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSessionFunctions(outputCapability: CameraOutputCapability): Array<PortraitPhotoFunctions>;
        /**
         * Gets session conflict functions.
         *
         * @returns { Array<PortraitPhotoConflictFunctions> } List of session conflict functions.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSessionConflictFunctions(): Array<PortraitPhotoConflictFunctions>;
    }
    /**
     * Aperture video session object.
     *
     * @extends Session, Flash, AutoExposure, Focus, Zoom, ColorEffect, Aperture
     * @interface ApertureVideoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ApertureVideoSession extends Session, Flash, AutoExposure, Focus, Zoom, ColorEffect, Aperture {
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange,
            onSmoothZoomInfoAvailable
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Subscribes zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange,
            offSmoothZoomInfoAvailable
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
    }
    /**
     * ManualExposure Query object.
     *
     * @interface ManualExposureQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ManualExposureQuery {
        
        /**
         * Gets the supported manual exposure range.
         * Move to ManualExposureQuery from ManualExposure since 12.
         *
         * @returns { Array<int> } The array of manual exposure range.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedExposureRange(): Array<int>;
    }
    /**
     * ManualExposure object.
     *
     * @extends ManualExposureQuery
     * @interface ManualExposure
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ManualExposure extends ManualExposureQuery {
        
        /**
         * Gets current exposure value.
         *
         * @returns { int } The current exposure value.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getExposure(): int;
        
        /**
         * Sets Exposure value.
         *
         * @param { int } exposure - Exposure value
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setExposure(exposure: int): void;
    }
    /**
     * Night photo session object.
     *
     * @extends Session, Flash, AutoExposure, Focus, Zoom, ColorEffect, Beauty, ColorManagement, ManualExposure
     * @interface NightPhotoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface NightPhotoSession extends Session, Flash, AutoExposure, Focus, Zoom, ColorEffect, Beauty, ColorManagement, ManualExposure {
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange,
            onSmoothZoomInfoAvailable,
            onLcdFlashStatus
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Subscribes zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Subscribes to lcd flash status.
         *
         * @param { 'lcdFlashStatus' } type - Event type.
         * @param { AsyncCallback<LcdFlashStatus> } callback - Callback used to get the lcd flash status.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onLcdFlashStatus(type: 'lcdFlashStatus', callback: AsyncCallback<LcdFlashStatus>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange,
            offSmoothZoomInfoAvailable,
            offLcdFlashStatus
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Unsubscribes from lcd flash status.
         *
         * @param { 'lcdFlashStatus' } type - Event type.
         * @param { AsyncCallback<LcdFlashStatus> } [callback] - Callback used to get the lcd flash status.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offLcdFlashStatus(type: 'lcdFlashStatus', callback?: AsyncCallback<LcdFlashStatus>): void;
    }
    /**
     * ISO info object
     *
     * @typedef IsoInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface IsoInfo {
        /**
         * ISO value.
         *
         * @type { ?int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly iso?: int;
    }
    /**
     * Exposure info object
     *
     * @typedef ExposureInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ExposureInfo {
        /**
         * Exposure time value.
         *
         * @type { ?int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly exposureTime?: int;
    }
    /**
     * Aperture info object
     *
     * @typedef ApertureInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ApertureInfo {
        /**
         * Aperture value.
         *
         * @type { ?double }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly aperture?: double;
    }
    /**
     * Lumination info object
     *
     * @typedef LuminationInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface LuminationInfo {
        /**
         * Lumination value.
         *
         * @type { ?double }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly lumination?: double;
    }
    /**
     * Professional photo session object.
     *
     * @interface ProfessionalPhotoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ProfessionalPhotoSession extends Session, AutoExposure, ManualExposure, Focus, ManualFocus, WhiteBalance, ManualIso, Flash, Zoom, ColorEffect, Aperture {
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange,
            onSmoothZoomInfoAvailable,
            onIsoInfoChange,
            onExposureInfoChange,
            onApertureInfoChange,
            onLuminationInfoChange
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Subscribes zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Subscribes ISO info event callback.
         *
         * @param { 'isoInfoChange' } type - Event type.
         * @param { AsyncCallback<IsoInfo> } callback - Callback used to get the ISO info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onIsoInfoChange(type: 'isoInfoChange', callback: AsyncCallback<IsoInfo>): void;
        /**
         * Subscribes exposure info event callback.
         *
         * @param { 'exposureInfoChange' } type - Event type.
         * @param { AsyncCallback<ExposureInfo> } callback - Callback used to get the exposure info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onExposureInfoChange(type: 'exposureInfoChange', callback: AsyncCallback<ExposureInfo>): void;
        /**
         * Subscribes aperture info event callback.
         *
         * @param { 'apertureInfoChange' } type - Event type.
         * @param { AsyncCallback<ApertureInfo> } callback - Callback used to get the aperture info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onApertureInfoChange(type: 'apertureInfoChange', callback: AsyncCallback<ApertureInfo>): void;
        /**
         * Subscribes lumination info event callback.
         *
         * @param { 'luminationInfoChange' } type - Event type.
         * @param { AsyncCallback<LuminationInfo> } callback - Callback used to get the lumination info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onLuminationInfoChange(type: 'luminationInfoChange', callback: AsyncCallback<LuminationInfo>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange,
            offSmoothZoomInfoAvailable,
            offIsoInfoChange,
            offExposureInfoChange,
            offApertureInfoChange,
            offLuminationInfoChange
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Unsubscribes from ISO info event callback.
         *
         * @param { 'isoInfoChange' } type - Event type.
         * @param { AsyncCallback<IsoInfo> } [callback] - Callback used to get the ISO info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offIsoInfoChange(type: 'isoInfoChange', callback?: AsyncCallback<IsoInfo>): void;
        /**
         * Unsubscribes from exposure info event callback.
         *
         * @param { 'exposureInfoChange' } type - Event type.
         * @param { AsyncCallback<ExposureInfo> } [callback] - Callback used to get the exposure info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offExposureInfoChange(type: 'exposureInfoChange', callback?: AsyncCallback<ExposureInfo>): void;
        /**
         * Unsubscribes from aperture info event callback.
         *
         * @param { 'apertureInfoChange' } type - Event type.
         * @param { AsyncCallback<ApertureInfo> } [callback] - Callback used to get the aperture info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offApertureInfoChange(type: 'apertureInfoChange', callback?: AsyncCallback<ApertureInfo>): void;
        /**
         * Unsubscribes from lumination info event callback.
         *
         * @param { 'luminationInfoChange' } type - Event type.
         * @param { AsyncCallback<LuminationInfo> } [callback] - Callback used to get the lumination info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offLuminationInfoChange(type: 'luminationInfoChange', callback?: AsyncCallback<LuminationInfo>): void;
    }
    /**
     * Professional video session object.
     *
     * @extends Session, AutoExposure, ManualExposure, Focus, ManualFocus, WhiteBalance, ManualIso, Flash, Zoom, ColorEffect, Aperture
     * @interface ProfessionalVideoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ProfessionalVideoSession extends Session, AutoExposure, ManualExposure, Focus, ManualFocus, WhiteBalance, ManualIso, Flash, Zoom, ColorEffect, Aperture {
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange,
            onSmoothZoomInfoAvailable,
            onIsoInfoChange,
            onExposureInfoChange,
            onApertureInfoChange,
            onLuminationInfoChange
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Subscribes zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Subscribes ISO info event callback.
         *
         * @param { 'isoInfoChange' } type - Event type.
         * @param { AsyncCallback<IsoInfo> } callback - Callback used to get the ISO info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onIsoInfoChange(type: 'isoInfoChange', callback: AsyncCallback<IsoInfo>): void;
        /**
         * Subscribes exposure info event callback.
         *
         * @param { 'exposureInfoChange' } type - Event type.
         * @param { AsyncCallback<ExposureInfo> } callback - Callback used to get the exposure info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onExposureInfoChange(type: 'exposureInfoChange', callback: AsyncCallback<ExposureInfo>): void;
        /**
         * Subscribes aperture info event callback.
         *
         * @param { 'apertureInfoChange' } type - Event type.
         * @param { AsyncCallback<ApertureInfo> } callback - Callback used to get the aperture info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onApertureInfoChange(type: 'apertureInfoChange', callback: AsyncCallback<ApertureInfo>): void;
        /**
         * Subscribes lumination info event callback.
         *
         * @param { 'luminationInfoChange' } type - Event type.
         * @param { AsyncCallback<LuminationInfo> } callback - Callback used to get the lumination info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onLuminationInfoChange(type: 'luminationInfoChange', callback: AsyncCallback<LuminationInfo>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange,
            offSmoothZoomInfoAvailable,
            offIsoInfoChange,
            offExposureInfoChange,
            offApertureInfoChange,
            offLuminationInfoChange
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Unsubscribes from ISO info event callback.
         *
         * @param { 'isoInfoChange' } type - Event type.
         * @param { AsyncCallback<IsoInfo> } [callback] - Callback used to get the ISO info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offIsoInfoChange(type: 'isoInfoChange', callback?: AsyncCallback<IsoInfo>): void;
        /**
         * Unsubscribes from exposure info event callback.
         *
         * @param { 'exposureInfoChange' } type - Event type.
         * @param { AsyncCallback<ExposureInfo> } [callback] - Callback used to get the exposure info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offExposureInfoChange(type: 'exposureInfoChange', callback?: AsyncCallback<ExposureInfo>): void;
        /**
         * Unsubscribes from aperture info event callback.
         *
         * @param { 'apertureInfoChange' } type - Event type.
         * @param { AsyncCallback<ApertureInfo> } [callback] - Callback used to get the aperture info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offApertureInfoChange(type: 'apertureInfoChange', callback?: AsyncCallback<ApertureInfo>): void;
        /**
         * Unsubscribes from lumination info event callback.
         *
         * @param { 'luminationInfoChange' } type - Event type.
         * @param { AsyncCallback<LuminationInfo> } [callback] - Callback used to get the lumination info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offLuminationInfoChange(type: 'luminationInfoChange', callback?: AsyncCallback<LuminationInfo>): void;
    }
    /**
     * Enum for slow motion status.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum SlowMotionStatus {
        /**
         * Slow motion disabled.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        DISABLED = 0,
        /**
         * Slow motion ready.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        READY = 1,
        /**
         * Slow motion video start.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        VIDEO_START = 2,
        /**
         * Slow motion video done.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        VIDEO_DONE = 3,
        /**
         * Slow motion finished.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        FINISHED = 4
    }
    /**
     * Slow motion video session object.
     *
     * @extends Session, Flash, AutoExposure, Focus, Zoom, ColorEffect
     * @interface SlowMotionVideoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface SlowMotionVideoSession extends Session, Flash, AutoExposure, Focus, Zoom, ColorEffect {
        
        /**
         * Determine whether camera slow motion detection is supported.
         *
         * @returns { boolean } Is camera slow motion detection supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isSlowMotionDetectionSupported(): boolean;
        
        /**
         * Set slow motion detection area.
         *
         * @param { Rect } area - Detection area.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setSlowMotionDetectionArea(area: Rect): void;
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange,
            onSmoothZoomInfoAvailable,
            onSlowMotionStatus
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Subscribes zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Subscribes slow motion status callback.
         *
         * @param { 'slowMotionStatus' } type - Event type.
         * @param { AsyncCallback<SlowMotionStatus> } callback - Callback used to get the slow motion status.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onSlowMotionStatus(type: 'slowMotionStatus', callback: AsyncCallback<SlowMotionStatus>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange,
            offSmoothZoomInfoAvailable,
            offSlowMotionStatus
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Unsubscribes slow motion status callback.
         *
         * @param { 'slowMotionStatus' } type - Event type.
         * @param { AsyncCallback<SlowMotionStatus> } [callback] - Callback used to get the slow motion status.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offSlowMotionStatus(type: 'slowMotionStatus', callback?: AsyncCallback<SlowMotionStatus>): void;
    }
    /**
     * High resolution session object.
     *
     * @extends Session, AutoExposure, Focus
     * @interface HighResolutionPhotoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface HighResolutionPhotoSession extends Session, AutoExposure, Focus {
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
    }
    
    
    /**
     * Macro photo session object.
     *
     * @extends Session, Flash, AutoExposure, Focus, Zoom, ColorEffect, ManualFocus, DepthFusion, ColorManagement
     * @interface MacroPhotoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MacroPhotoSession extends Session, Flash, AutoExposure, Focus, Zoom, ColorEffect, ManualFocus, DepthFusion, ColorManagement {
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange,
            onSmoothZoomInfoAvailable
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Subscribes zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange,
            offSmoothZoomInfoAvailable
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
    }
    
    /**
     * Macro video session object.
     *
     * @extends Session, Flash, AutoExposure, Focus, Zoom, ColorEffect, ManualFocus, ColorManagement
     * @interface MacroVideoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MacroVideoSession extends Session, Flash, AutoExposure, Focus, Zoom, ColorEffect, ManualFocus, ColorManagement {
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange,
            onSmoothZoomInfoAvailable
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Subscribes zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange,
            offSmoothZoomInfoAvailable
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
    }
    
    
    /**
     * Secure camera session object.
     *
     * @extends Session, Flash, AutoExposure, WhiteBalance, Focus, Zoom
     * @interface SecureSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface SecureSession extends Session, Flash, AutoExposure, WhiteBalance, Focus, Zoom {
        
        
        /**
         * Add Secure output for camera.
         *
         * @param { PreviewOutput } previewOutput - Specify the output as a secure flow.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        addSecureOutput(previewOutput: PreviewOutput): void;
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
    }
    /**
     * Light painting photo session object.
     *
     * @extends Session, Flash, Focus, Zoom, ColorEffect
     * @interface LightPaintingPhotoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface LightPaintingPhotoSession extends Session, Flash, Focus, Zoom, ColorEffect {
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange,
            onSmoothZoomInfoAvailable
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Subscribes zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange,
            offSmoothZoomInfoAvailable
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * Gets the light painting type in use.
         *
         * @returns { LightPaintingType } The light painting type in use.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getLightPaintingType(): LightPaintingType;
        /**
         * Sets a light painting type for a camera device.
         *
         * @param { LightPaintingType } type - Light painting type to set.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setLightPaintingType(type: LightPaintingType): void;
        /**
         * Gets supported light painting types.
         *
         * @returns { Array<LightPaintingType> } List of light painting types.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedLightPaintingTypes(): Array<LightPaintingType>;
    }
    /**
     * Quick shot photo session object.
     *
     * @extends Session, AutoExposure, ColorEffect, ColorManagement, EffectSuggestion, Flash, Focus, Zoom
     * @interface QuickShotPhotoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface QuickShotPhotoSession extends Session, AutoExposure, ColorEffect, ColorManagement, EffectSuggestion, Flash, Focus, Zoom {
        /**
         * @since 20
         */
        overload on {
            onError,
            onEffectSuggestionChange,
            onFocusStateChange,
            onSmoothZoomInfoAvailable
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes to effect suggestion event callback.
         *
         * @param { 'effectSuggestionChange' } type - Event type.
         * @param { AsyncCallback<EffectSuggestionType> } callback - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onEffectSuggestionChange(type: 'effectSuggestionChange', callback: AsyncCallback<EffectSuggestionType>): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Subscribes zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } callback - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback: AsyncCallback<SmoothZoomInfo>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offEffectSuggestionChange,
            offFocusStateChange,
            offSmoothZoomInfoAvailable
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from effect suggestion event callback.
         *
         * @param { 'effectSuggestionChange' } type - Event type.
         * @param { AsyncCallback<EffectSuggestionType> } [callback] - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offEffectSuggestionChange(type: 'effectSuggestionChange', callback?: AsyncCallback<EffectSuggestionType>): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from zoom info event callback.
         *
         * @param { 'smoothZoomInfoAvailable' } type - Event type.
         * @param { AsyncCallback<SmoothZoomInfo> } [callback] - Callback used to get the zoom info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offSmoothZoomInfoAvailable(type: 'smoothZoomInfoAvailable', callback?: AsyncCallback<SmoothZoomInfo>): void;
    }
    /**
     * Panorama photo session object.
     *
     * @extends Session, Focus, AutoExposure, WhiteBalance, ColorEffect
     * @interface PanoramaPhotoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface PanoramaPhotoSession extends Session, Focus, AutoExposure, WhiteBalance, ColorEffect {
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
    }
    /**
     * Fluorescence photo session object.
     *
     * @extends Session, AutoExposure, Focus, Zoom
     * @interface FluorescencePhotoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface FluorescencePhotoSession extends Session, AutoExposure, Focus, Zoom {
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
    }
    /**
     * Photo Functions object.
     *
     * @extends FlashQuery, AutoExposureQuery, ManualExposureQuery, FocusQuery, ZoomQuery, BeautyQuery, ColorEffectQuery, ColorManagementQuery, MacroQuery, SceneDetectionQuery
     * @interface PhotoFunctions
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface PhotoFunctions extends FlashQuery, AutoExposureQuery, ManualExposureQuery, FocusQuery, ZoomQuery, BeautyQuery, ColorEffectQuery, ColorManagementQuery, MacroQuery, SceneDetectionQuery {
    }
    /**
     * Video Functions object.
     *
     * @extends FlashQuery, AutoExposureQuery, ManualExposureQuery, FocusQuery, ZoomQuery, StabilizationQuery, BeautyQuery, ColorEffectQuery, ColorManagementQuery, MacroQuery, SceneDetectionQuery
     * @interface VideoFunctions
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface VideoFunctions extends FlashQuery, AutoExposureQuery, ManualExposureQuery, FocusQuery, ZoomQuery, StabilizationQuery, BeautyQuery, ColorEffectQuery, ColorManagementQuery, MacroQuery, SceneDetectionQuery {
    }
    /**
     * Portrait Photo Functions object.
     *
     * @extends FlashQuery, AutoExposureQuery, FocusQuery, ZoomQuery, BeautyQuery, ColorEffectQuery, ColorManagementQuery, PortraitQuery, ApertureQuery, SceneDetectionQuery
     * @interface PortraitPhotoFunctions
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface PortraitPhotoFunctions extends FlashQuery, AutoExposureQuery, FocusQuery, ZoomQuery, BeautyQuery, ColorEffectQuery, ColorManagementQuery, PortraitQuery, ApertureQuery, SceneDetectionQuery {
    }
    /**
     * Photo Conflict Functions object.
     *
     * @extends ZoomQuery, MacroQuery
     * @interface PhotoConflictFunctions
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface PhotoConflictFunctions extends ZoomQuery, MacroQuery {
    }
    /**
     * Video Conflict Functions object.
     *
     * @extends ZoomQuery, MacroQuery
     * @interface VideoConflictFunctions
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface VideoConflictFunctions extends ZoomQuery, MacroQuery {
    }
    /**
     * Portrait Photo Conflict Functions object.
     *
     * @extends ZoomQuery, PortraitQuery, ApertureQuery
     * @interface PortraitPhotoFunctions
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface PortraitPhotoConflictFunctions extends ZoomQuery, PortraitQuery, ApertureQuery {
    }
    
    /**
     * Camera output object.
     *
     * @interface CameraOutput
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface CameraOutput {
        /**
         * @since 20
         */
        overload release {
            releaseWithCallback,
            releaseReturnsPromise
        };
        /**
         * Release output instance.
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        releaseWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Release output instance.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        releaseReturnsPromise(): Promise<void>;
    }
    /**
     * SketchStatusData object
     *
     * @typedef SketchStatusData
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface SketchStatusData {
        /**
         * Status of the sketch stream.
         * 0 is stop, and 1 is start.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        status: int;
        /**
         * The zoom ratio of the sketch stream.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        sketchRatio: double;
    }
    
    /**
     * Preview output object.
     *
     * @extends CameraOutput
     * @interface PreviewOutput
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface PreviewOutput extends CameraOutput {
        
        /**
         * Get supported frame rates which can be set during session running.
         *
         * @returns { Array<FrameRateRange> } The array of supported frame rate range.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getSupportedFrameRates(): Array<FrameRateRange>;
        
        /**
         * The supported frame rate range can be queried via the getSupportedFrameRates interface before setting.
         *
         * @param { int } minFps - Minimum frame rate per second.
         * @param { int } maxFps - Maximum frame rate per second.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400110 - Unresolved conflicts with current configurations.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setFrameRate(minFps: int, maxFps: int): void;
        
        /**
         * Queryable after setting the frame rate for the preview stream using the setFrameRate interface.
         *
         * @returns { FrameRateRange } The active frame rate range.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getActiveFrameRate(): FrameRateRange;
        
        /**
         * Gets the current preconfig type if you had already call preconfig interface.
         *
         * @returns { Profile } The current preconfig type.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getActiveProfile(): Profile;
        
        /**
         * Gets the preview rotation angle.
         *
         * @param { int } displayRotation - The current display rotation angle.
         * @returns { ImageRotation } The preview rotation angle.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getPreviewRotation(displayRotation: int): ImageRotation;
        
        /**
         * Sets the preview rotation angle.
         *
         * @param { ImageRotation } previewRotation - Preview display rotation angle.
         * @param { boolean } isDisplayLocked - TRUE means the display is locked, if not set, the default is FALSE.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setPreviewRotation(previewRotation: ImageRotation, isDisplayLocked?: boolean): void;
        
        /**
         * Adds a deferred surface.
         *
         * @param { string } surfaceId - Surface object id used in camera photo output.
         * @throws { BusinessError } 202 - Permission verification failed. A non-system application calls a system API.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        addDeferredSurface(surfaceId: string): void;
        /**
         * Determine whether camera sketch is supported.
         *
         * @returns { boolean } Is camera sketch supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isSketchSupported(): boolean;
        /**
         * Gets the specific zoom ratio when sketch stream open.
         *
         * @returns { double } The specific zoom ratio of sketch.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSketchRatio(): double;
        
        /**
         * Enable sketch for camera.
         *
         * @param { boolean } enabled - enable sketch for camera if TRUE.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableSketch(enabled: boolean): void;
        
        /**
         * Attach surface to the sketch stream.
         *
         * @param { string } surfaceId - Surface object id used in sketch stream.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        attachSketchSurface(surfaceId: string): void;
        /**
        * @since 20
        */
        overload on {
            onFrameStart,
            onFrameEnd,
            onError,
            onSketchStatusChanged
        };
        /**
         * Registers a listener for the preview frame to start to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'frameStart' } type - Event type.
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onFrameStart(type: 'frameStart', callback: AsyncCallback<void>): void;
        /**
         * Registers a listener for the end of the preview frame to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'frameEnd' } type - Event type.
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onFrameEnd(type: 'frameEnd', callback: AsyncCallback<void>): void;
        /**
         * Registers a listener for error events on the preview output to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the preview output errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes sketch status changed event callback.
         *
         * @param { 'sketchStatusChanged' } type - Event type.
         * @param { AsyncCallback<SketchStatusData> } callback - Callback used to sketch status data.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onSketchStatusChanged(type: 'sketchStatusChanged', callback: AsyncCallback<SketchStatusData>): void;
        /**
        * @since 20
        */
        overload off {
            offFrameStart,
            offFrameEnd,
            offError,
            offSketchStatusChanged
        };
        /**
         * Unsubscribes from frame start event callback.
         *
         * @param { 'frameStart' } type - Event type.
         * @param { AsyncCallback<void> } [callback] - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offFrameStart(type: 'frameStart', callback?: AsyncCallback<void>): void;
        /**
         * Unsubscribes from frame end event callback.
         *
         * @param { 'frameEnd' } type - Event type.
         * @param { AsyncCallback<void> } [callback] - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offFrameEnd(type: 'frameEnd', callback?: AsyncCallback<void>): void;
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the preview output errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes sketch status changed event callback.
         *
         * @param { 'sketchStatusChanged' } type - Event type.
         * @param { AsyncCallback<SketchStatusData> } [callback] - Callback used to get sketch status data.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offSketchStatusChanged(type: 'sketchStatusChanged', callback?: AsyncCallback<SketchStatusData>): void;
    }
    /**
     * Enum for effect suggestion.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum EffectSuggestionType {
        /**
         * None.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        EFFECT_SUGGESTION_NONE = 0,
        /**
         * Portrait.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        EFFECT_SUGGESTION_PORTRAIT = 1,
        /**
         * Food.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        EFFECT_SUGGESTION_FOOD = 2,
        /**
         * Sky.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        EFFECT_SUGGESTION_SKY = 3,
        /**
         * Sunrise and sunset.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        EFFECT_SUGGESTION_SUNRISE_SUNSET = 4
    }
    /**
     * Effect suggestion status
     *
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    class EffectSuggestionStatus {
        /**
         * Effect Suggestion type.
         *
         * @type { EffectSuggestionType }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        type: EffectSuggestionType;
        /**
         * Effect Suggestion type status.
         *
         * @type { boolean }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        status: boolean;
    }
    
    /**
     * Enumerates the image rotation angles.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum ImageRotation {
        
        /**
         * The capture image rotates 0 degrees.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        ROTATION_0 = 0,
        
        /**
         * The capture image rotates 90 degrees.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        ROTATION_90 = 90,
        
        /**
         * The capture image rotates 180 degrees.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        ROTATION_180 = 180,
        
        /**
         * The capture image rotates 270 degrees.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        ROTATION_270 = 270
    }
    
    /**
     * Photo capture location
     *
     * @typedef Location
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
       */
    interface Location {
        
        /**
         * Latitude.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        latitude: double;
        
        /**
         * Longitude.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        longitude: double;
        
        /**
         * Altitude.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        altitude: double;
    }
    
    /**
     * Enumerates the image quality levels.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum QualityLevel {
        
        /**
         * High image quality.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        QUALITY_LEVEL_HIGH = 0,
        
        /**
         * Medium image quality.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        QUALITY_LEVEL_MEDIUM = 1,
        
        /**
         * Low image quality.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        QUALITY_LEVEL_LOW = 2
    }
    
    /**
     * Photo capture options to set.
     *
     * @typedef PhotoCaptureSetting
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface PhotoCaptureSetting {
        
        /**
         * Photo image quality.
         *
         * @type { ?QualityLevel }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        quality?: QualityLevel;
        
        /**
         * Photo rotation.
         *
         * @type { ?ImageRotation }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        rotation?: ImageRotation;
        
        /**
         * Photo location.
         *
         * @type { ?Location }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        location?: Location;
        
        /**
         * Mirror enable switch (default off).
         * It is necessary to utilize the function isMirrorSupported to ascertain whether it is supported
         * prior to its implementation.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        mirror?: boolean;
    }
    /**
     * Enumerates the delivery image types.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum DeferredDeliveryImageType {
        /**
         * Undefer image delivery.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        NONE = 0,
        /**
         * Defer photo delivery when capturing photos.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        PHOTO = 1,
        /**
         * Defer video delivery when capturing videos.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        VIDEO = 2
    }
    
    /**
     * Photo object
     *
     * @typedef Photo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface Photo {
        
        /**
         * Main image.
         *
         * @type { image.Image }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        main: image.Image;
        /**
         * Raw image.
         *
         * @type { ?image.Image }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        raw?: image.Image;
        /**
         * Depth data.
         *
         * @type { DepthData }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        depthData?: DepthData;
        
        /**
         * Release Photo object.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        release(): Promise<void>;
    }
    /**
     * DeferredPhotoProxy object
     *
     * @typedef DeferredPhotoProxy
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface DeferredPhotoProxy {
        /**
         * Thumbnail image.
         *
         * @returns { Promise<image.PixelMap> } Promise used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getThumbnail(): Promise<image.PixelMap>;
        /**
         * Release DeferredPhotoProxy object.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        release(): Promise<void>;
    }
    
    /**
     * Enumerates the camera video codec type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum VideoCodecType {
        
        /**
         * Video encoding type AVC.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        AVC = 0,
        
        /**
         * Video encoding type HEVC.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        HEVC = 1
    }
    
    /**
     * Photo output object.
     *
     * @extends CameraOutput
     * @interface PhotoOutput
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface PhotoOutput extends CameraOutput {
        /**
         * @since 20
         */
        overload capture {
            captureWithCallback,
            captureReturnsPromise,
            captureWithSettingCallback,
            captureWithSettingReturnsPromise
        };
        /**
         * Start capture output.
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        captureWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Start capture output.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        captureReturnsPromise(): Promise<void>;
        /**
         * Start capture output.
         *
         * @param { PhotoCaptureSetting } setting - Photo capture settings.
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        captureWithSettingCallback(setting: PhotoCaptureSetting, callback: AsyncCallback<void>): void;
        /**
         * Start capture output.
         * Remove optional param.
         *
         * @param { PhotoCaptureSetting } setting - Photo capture settings.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        captureWithSettingReturnsPromise(setting: PhotoCaptureSetting): Promise<void>;
        /**
         * Start burst capture.
         *
         * @param { PhotoCaptureSetting } setting - Photo capture settings.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        burstCapture(setting: PhotoCaptureSetting): Promise<void>;
        /**
         * Confirm if the raw image delivery is supported
         *
         * @returns { boolean } TRUE if the type of delivery image is support.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isRawDeliverySupported(): boolean;
        /**
         * Enable raw image image delivery.
         *
         * @param { boolean } enabled - Target state for raw image delivery.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableRawDelivery(enabled: boolean): void;
        /**
         * Confirm if the deferred image delivery supported in the specific device.
         *
         * @param { DeferredDeliveryImageType } type - Type of delivery image.
         * @returns { boolean } TRUE if the type of delivery image is support.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isDeferredImageDeliverySupported(type: DeferredDeliveryImageType): boolean;
        /**
         * Confirm if the deferred image delivery enabled.
         *
         * @param { DeferredDeliveryImageType } type - Type of delivery image.
         * @returns { boolean } TRUE if the type of delivery image is enable.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isDeferredImageDeliveryEnabled(type: DeferredDeliveryImageType): boolean;
        /**
         * Sets the image type for deferred image delivery.
         *
         * @param { DeferredDeliveryImageType } type - Type of delivery image.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        deferImageDelivery(type: DeferredDeliveryImageType): void;
        /**
         * Check if the depth data delivery is supported.
         *
         * @returns { boolean } TRUE if the type of delivery image is enabled.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isDepthDataDeliverySupported(): boolean;
        /**
         * Enable depth data delivery.
         *
         * @param { boolean } enabled - Target state for depth data delivery.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400104 - Session not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableDepthDataDelivery(enabled: boolean): void;
        
        /**
         * Get supported moving photo video codec types.
         *
         * @returns { Array<VideoCodecType> } An array of supported video codec types for moving photo.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getSupportedMovingPhotoVideoCodecTypes(): Array<VideoCodecType>;
        
        /**
         * Sets codec type for moving photo, default to AVC.
         *
         * @param { VideoCodecType } codecType - Codec type for moving photo.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setMovingPhotoVideoCodecType(codecType: VideoCodecType): void;
        
        /**
         * Check whether to support mirror photo.
         *
         * @returns { boolean } Is the mirror supported.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isMirrorSupported(): boolean;
        
        /**
         * Whether to enable moving photo mirroring.
         *
         * Prior to invoking this interface, it is necessary to determine whether the moving
         * photo function is supported through the isMovingPhotoSupported API and whether the
         * photo mirroring function is supported through the isMirrorSupported API.
         *
         * @param { boolean } enabled - enable moving photo mirror if TRUE.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        enableMirror(enabled: boolean): void;
        
        /**
         * Gets the current preconfig type if you had already call preconfig interface.
         *
         * @returns { Profile } The current preconfig type.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getActiveProfile(): Profile;
        
        /**
         * Checks whether PhotoOutput supports quick thumbnail.
         * This method is valid after Session.addInput() and Session.addOutput(photoOutput) are called.
         *
         * @returns { boolean } Whether quick thumbnail is supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400104 - session is not running.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isQuickThumbnailSupported(): boolean;
        
        /**
         * Enables or disables quick thumbnail.
         * The method must be called after Session.addInput() and Session.addOutput(photoOutput) are called.
         * To avoid stream reconfiguration and performance loss,
         * you are advised to call the method before Session.commitConfig().
         *
         * @param { boolean } enabled - The value TRUE means to enable quick thumbnail, and FALSE means the opposite.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400104 - session is not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableQuickThumbnail(enabled: boolean): void;
        /**
         * Confirm if the auto high quality photo supported.
         *
         * @returns { boolean } TRUE if the auto high quality photo is supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400104 - session is not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isAutoHighQualityPhotoSupported(): boolean;
        /**
         * Enable auto high quality photo.
         *
         * @param { boolean } enabled - Target state for auto high quality photo.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400104 - session is not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableAutoHighQualityPhoto(enabled: boolean): void;
        /**
         * Confirm if the auto cloud image enhancement is supported.
         *
         * @returns { boolean } TRUE if the auto cloud image enhancement is supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isAutoCloudImageEnhancementSupported(): boolean;
        
        /**
         * Confirm if moving photo supported.
         *
         * @returns { boolean } TRUE if the moving photo is supported.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isMovingPhotoSupported(): boolean;
        
        /**
         * Enable moving photo.
         *
         * @permission ohos.permission.MICROPHONE
         * @param { boolean } enabled - Target state for moving photo.
         * @throws { BusinessError } 201 - permission denied.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        enableMovingPhoto(enabled: boolean): void;
        
        /**
         * Gets the photo rotation angle.
         *
         * @param { int } deviceDegree - The current device rotation degree.
         * @returns { ImageRotation } The photo rotation angle.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getPhotoRotation(deviceDegree: int): ImageRotation;
        /**
         * Confirm if offline processing is supported.
         *
         * @returns { boolean } TRUE if the type of offline is supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isOfflineSupported(): boolean;
        /**
         * Enable offline processing.
         *
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400104 - session is not running.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableOffline(): void;
        /**
        * @since 20
        */
        overload on {
            onPhotoAvailable,
            onDeferredPhotoProxyAvailable,
            onPhotoAssetAvailable,
            onCaptureStartWithInfo,
            onFrameShutter,
            onFrameShutterEnd,
            onCaptureEnd,
            onCaptureReady,
            onEstimatedCaptureDuration,
            onError,
            onQuickThumbnailWithCallbackofImagePixelMap,
            onOfflineDeliveryFinished
        };
        /**
         * Registers a listener for full quality chart uploads to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'photoAvailable' } type - Event type.
         * @param { AsyncCallback<Photo> } callback - Callback used to get the Photo.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onPhotoAvailable(type: 'photoAvailable', callback: AsyncCallback<Photo>): void;
        /**
         * Subscribes deferred photo proxy available event callback.
         *
         * @param { 'deferredPhotoProxyAvailable' } type - Event type.
         * @param { AsyncCallback<DeferredPhotoProxy> } callback - Callback used to get the DeferredPhotoProxy.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onDeferredPhotoProxyAvailable(type: 'deferredPhotoProxyAvailable', callback: AsyncCallback<DeferredPhotoProxy>): void;
        /**
         * Registers a listener for photoAsset uploads to monitor the upload process. This API
         * uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * <p>This API processes deferred photo delivery data by quickly displaying low-quality images to give
         * users the impression of faster photo capture, while also generating high-quality images to maintain the
         * final output quality. For details about the design specifications, see {@link
        * https://developer.huawei.com/consumer/en/doc/best-practices/bpta-camera-shot2see}. </p>
        * @param { 'photoAssetAvailable' } type - Event type.
        * @param { AsyncCallback<photoAccessHelper.PhotoAsset> } callback - Callback used to get the asset.
        * @syscap SystemCapability.Multimedia.Camera.Core
        * @since 20
        */
        onPhotoAssetAvailable(type: 'photoAssetAvailable', callback: AsyncCallback<photoAccessHelper.PhotoAsset>): void;
        /**
         * Registers a listener for the start of the photo taking to get the CaptureStartInfo by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'captureStartWithInfo' } type - Event type.
         * @param { AsyncCallback<CaptureStartInfo> } callback - Callback used to get the capture start info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onCaptureStartWithInfo(type: 'captureStartWithInfo', callback: AsyncCallback<CaptureStartInfo>): void;
        /**
         * Subscribes frame shutter event callback.
         *
         * @param { 'frameShutter' } type - Event type.
         * @param { AsyncCallback<FrameShutterInfo> } callback - Callback used to get the frame shutter information.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onFrameShutter(type: 'frameShutter', callback: AsyncCallback<FrameShutterInfo>): void;
        /**
         * Registers a listener for the end of photo exposure capture to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'frameShutterEnd' } type - Event type.
         * @param { AsyncCallback<FrameShutterEndInfo> } callback - Callback used to get the frame shutter end information.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onFrameShutterEnd(type: 'frameShutterEnd', callback: AsyncCallback<FrameShutterEndInfo>): void;
        /**
         * Registers a listener for the end of the photo shoot to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'captureEnd' } type - Listens to the event, fixed to 'captureEnd', when photoOutput is
         *     created successfully. This event can be triggered when the photoOutput is created successfully.
         * @param { AsyncCallback<CaptureEndInfo> } callback - Callback used to get the capture end information.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onCaptureEnd(type: 'captureEnd', callback: AsyncCallback<CaptureEndInfo>): void;
        /**
         * Registers a listener for the next available shot to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'captureReady' } type - Event type.
         * @param { AsyncCallback<void> } callback - Callback used to notice capture ready.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onCaptureReady(type: 'captureReady', callback: AsyncCallback<void>): void;
        /**
         * Registers a listener for the estimated time to take a picture to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'estimatedCaptureDuration' } type - Event type.
         * @param { AsyncCallback<double> } callback - Callback used to notify the estimated capture duration (in milliseconds).
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onEstimatedCaptureDuration(type: 'estimatedCaptureDuration', callback: AsyncCallback<double>): void;
        /**
         * Registers a listener for errors in the photo output to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the photo output errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes to camera thumbnail events.
         * This method is valid only after enableQuickThumbnail(true) is called.
         *
         * @param { 'quickThumbnail' } type - Event type.
         * @param { AsyncCallback<image.PixelMap> } callback - Callback used to get the quick thumbnail.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onQuickThumbnailWithCallbackofImagePixelMap(type: 'quickThumbnail', callback: AsyncCallback<image.PixelMap>): void;
        /**
         * Subscribes offline Delivery finished events.
         * This method is valid only after enableOffline() is called.
         *
         * @param { 'offlineDeliveryFinished' } type - Event type.
         * @param { AsyncCallback<void> } callback - Callback used to get offline Delivery finished events.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onOfflineDeliveryFinished(type: 'offlineDeliveryFinished', callback: AsyncCallback<void>): void;
        /**
        * @since 20
        */
        overload off {
            offPhotoAvailable,
            offDeferredPhotoProxyAvailable,
            offPhotoAssetAvailable,
            offCaptureStartWithInfo,
            offFrameShutter,
            offFrameShutterEnd,
            offCaptureEnd,
            offCaptureReady,
            offEstimatedCaptureDuration,
            offError,
            offQuickThumbnailWithCallbackofImagePixelMap,
            offOfflineDeliveryFinished
        };
        /**
         * Unsubscribes photo available event callback.
         *
         * @param { 'photoAvailable' } type - Event type.
         * @param { AsyncCallback<Photo> } [callback] - Callback used to get the Photo.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offPhotoAvailable(type: 'photoAvailable', callback?: AsyncCallback<Photo>): void;
        /**
         * Unsubscribes deferred photo proxy available event callback.
         *
         * @param { 'deferredPhotoProxyAvailable' } type - Event type.
         * @param { AsyncCallback<DeferredPhotoProxy> } [callback] - Callback used to get the DeferredPhotoProxy.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offDeferredPhotoProxyAvailable(type: 'deferredPhotoProxyAvailable', callback?: AsyncCallback<DeferredPhotoProxy>): void;
        /**
         * Unsubscribes photo asset event callback.
         *
         * @param { 'photoAssetAvailable' } type - Event type.
         * @param { AsyncCallback<photoAccessHelper.PhotoAsset> } [callback] - Callback used to get the asset.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offPhotoAssetAvailable(type: 'photoAssetAvailable', callback?: AsyncCallback<photoAccessHelper.PhotoAsset>): void;
        /**
         * Unsubscribes from capture start event callback.
         *
         * @param { 'captureStartWithInfo' } type - Event type.
         * @param { AsyncCallback<CaptureStartInfo> } [callback] - Callback used to get the capture start info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offCaptureStartWithInfo(type: 'captureStartWithInfo', callback?: AsyncCallback<CaptureStartInfo>): void;
        /**
         * Unsubscribes from frame shutter event callback.
         *
         * @param { 'frameShutter' } type - Event type.
         * @param { AsyncCallback<FrameShutterInfo> } [callback] - Callback used to get the frame shutter information.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offFrameShutter(type: 'frameShutter', callback?: AsyncCallback<FrameShutterInfo>): void;
        /**
         * Unsubscribes from frame shutter end event callback.
         *
         * @param { 'frameShutterEnd' } type - Event type.
         * @param { AsyncCallback<FrameShutterEndInfo> } [callback] - Callback used to get the frame shutter end information.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offFrameShutterEnd(type: 'frameShutterEnd', callback?: AsyncCallback<FrameShutterEndInfo>): void;
        /**
         * Unsubscribes from capture end event callback.
         *
         * @param { 'captureEnd' } type - Event type.
         * @param { AsyncCallback<CaptureEndInfo> } [callback] - Callback used to get the capture end information.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offCaptureEnd(type: 'captureEnd', callback?: AsyncCallback<CaptureEndInfo>): void;
        /**
         * Unsubscribes from capture ready event callback.
         *
         * @param { 'captureReady' } type - Event type.
         * @param { AsyncCallback<void> } [callback] - Callback used to notice capture ready.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offCaptureReady(type: 'captureReady', callback?: AsyncCallback<void>): void;
        /**
         * Unsubscribes from estimated capture duration event callback.
         *
         * @param { 'estimatedCaptureDuration' } type - Event type.
         * @param { AsyncCallback<double> } [callback] - Callback used to notify the estimated
         *     capture duration (in milliseconds).
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offEstimatedCaptureDuration(type: 'estimatedCaptureDuration', callback?: AsyncCallback<double>): void;
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the photo output errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from camera thumbnail events.
         * This method is valid only after enableQuickThumbnail(true) is called.
         *
         * @param { 'quickThumbnail' } type - Event type.
         * @param { AsyncCallback<image.PixelMap> } [callback] - Callback used to get the quick thumbnail.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offQuickThumbnailWithCallbackofImagePixelMap(type: 'quickThumbnail', callback?: AsyncCallback<image.PixelMap>): void;
        /**
         * Unsubscribes offline Delivery finished events.
         * This method is valid only after enableOffline() is called.
         *
         * @param { 'offlineDeliveryFinished' } type - Event type.
         * @param { AsyncCallback<void>} [callback] - Callback used to get offline Delivery finished events.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offOfflineDeliveryFinished(type: 'offlineDeliveryFinished', callback?: AsyncCallback<void>): void;
    }
    
    /**
     * Frame shutter callback info.
     *
     * @typedef FrameShutterInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface FrameShutterInfo {
        
        /**
         * Capture id.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        captureId: int;
        
        /**
         * Timestamp for frame.
         *
         * @type { long }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        timestamp: long;
    }
    
    /**
     * Frame shutter end callback info.
     *
     * @typedef FrameShutterEndInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface FrameShutterEndInfo {
        
        /**
         * Capture id.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        captureId: int;
    }
    
    /**
     * Capture start info.
     *
     * @typedef CaptureStartInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface CaptureStartInfo {
        
        /**
         * Capture id.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        captureId: int;
        
        /**
         * Time(in milliseconds) is the shutter time for the photo.
         *
         * @type { long }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        time: long;
    }
    
    /**
     * Capture end info.
     *
     * @typedef CaptureEndInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface CaptureEndInfo {
        
        /**
         * Capture id.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        captureId: int;
        
        /**
         * Frame count.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        frameCount: int;
    }
    /**
     * Deferred video enhancement info.
     *
     * @typedef DeferredVideoEnhancementInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface DeferredVideoEnhancementInfo {
        /**
         * Check whether deferred video enhancement available.
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly isDeferredVideoEnhancementAvailable: boolean;
        /**
         * Video identifier.
         *
         * @type { ?string }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly videoId?: string;
    }
    
    /**
     * Video output object.
     *
     * @extends CameraOutput
     * @interface VideoOutput
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface VideoOutput extends CameraOutput {
        /**
         * @since 20
         */
        overload start {
            startWithCallback,
            startReturnsPromise
        };
        /**
         * Start video output.
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        startWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Start video output.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        startReturnsPromise(): Promise<void>;
        /**
         * @since 20
         */
        overload stop {
            stopWithCallback,
            stopReturnsPromise
        };
        /**
         * Stop video output.
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        stopWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Stop video output.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        stopReturnsPromise(): Promise<void>;
        
        
        /**
         * Determine whether video mirror is supported.
         *
         * @returns { boolean } Is video mirror supported.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        isMirrorSupported(): boolean;
        
        
        /**
         * Enable/disable mirror recording.
         *
         * Before calling this API, it is necessary to use isMirrorSupported to check whether
         * video mirroring is supported.
         *
         * When enabling or disabling video mirroring, you must first call getVideoRotation
         * to retrieve the current rotation value and then call updateRotation to apply the
         * updated rotation.
         *
         * @param { boolean } enabled - enable video mirror if TRUE.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        enableMirror(enabled: boolean): void;
        
        /**
         * Get supported frame rates which can be set during session running.
         *
         * @returns { Array<FrameRateRange> } The array of supported frame rate range.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getSupportedFrameRates(): Array<FrameRateRange>;
        
        /**
         * Set a frame rate range.
         *
         * @param { int } minFps - Minimum frame rate per second.
         * @param { int } maxFps - Maximum frame rate per second.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400110 - Unresolved conflicts with current configurations.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        setFrameRate(minFps: int, maxFps: int): void;
        
        /**
         * Get active frame rate range which has been set before.
         *
         * @returns { FrameRateRange } The active frame rate range.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getActiveFrameRate(): FrameRateRange;
        
        /**
         * Gets the video rotation angle.
         *
         * @param { int } deviceDegree - The current device rotation degree.
         * @returns { ImageRotation } The video rotation angle.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getVideoRotation(deviceDegree: int): ImageRotation;
        /**
         * Confirm if auto deferred video enhancement is supported in the specific device.
         *
         * @returns { boolean } TRUE if auto deferred video enhancement is supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isAutoDeferredVideoEnhancementSupported(): boolean;
        /**
         * Confirm if auto deferred video enhancement is enabled.
         *
         * @returns { boolean } TRUE if auto deferred video enhancement is enabled.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isAutoDeferredVideoEnhancementEnabled(): boolean;
        /**
         * Enable auto deferred video enhancement if needed.
         *
         * @param { boolean } enabled - Status of auto deferred video enhancement.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableAutoDeferredVideoEnhancement(enabled: boolean): void;
        /**
         * Get supported video rotations.
         *
         * @returns { Array<ImageRotation> } The array of supported video rotations.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedRotations(): Array<ImageRotation>;
        /**
         * Determine whether video rotation is supported.
         *
         * @returns { boolean } Is video rotation supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isRotationSupported(): boolean;
        /**
         * Set a video rotation.
         *
         * @param { ImageRotation } rotation - The rotation angle.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setRotation(rotation: ImageRotation): void;
        /**
         * Determine whether auto frame rate is supported.
         *
         * @returns { boolean } Is auto frame rate supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isAutoVideoFrameRateSupported(): boolean;
        /**
         * Enable auto frame rate for video capture.
         *
         * @param { boolean } enabled - enable auto frame rate if TRUE.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableAutoVideoFrameRate(enabled: boolean): void;
        /**
        * @since 20
        */
        overload on {
            onDeferredVideoEnhancementInfo,
            onFrameStart,
            onFrameEnd,
            onError
        };
        /**
         * Subscribes deferred video enhancement info callback.
         *
         * @param { 'deferredVideoEnhancementInfo' } type - Event type.
         * @param { AsyncCallback<DeferredVideoEnhancementInfo> } callback - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onDeferredVideoEnhancementInfo(type: 'deferredVideoEnhancementInfo', callback: AsyncCallback<DeferredVideoEnhancementInfo>): void;
        /**
         * Registers a listener for the start of the video recording to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'frameStart' } type - Event type.
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 19
         */
        onFrameStart(type: 'frameStart', callback: AsyncCallback<void>): void;
        /**
         * Subscribes frame end event callback.
         *
         * @param { 'frameEnd' } type - Event type.
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 19
         */
        onFrameEnd(type: 'frameEnd', callback: AsyncCallback<void>): void;
        /**
         * Registers a listener for errors in the metadata stream to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the video output errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 19
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
        * @since 20
        */
        overload off {
            offDeferredVideoEnhancementInfo,
            offFrameStart,
            offFrameEnd,
            offError
        };
        /**
         * Unsubscribes from deferred video enhancement info callback.
         *
         * @param { 'deferredVideoEnhancementInfo' } type - Event type.
         * @param { AsyncCallback<DeferredVideoEnhancementInfo> } [callback] - Callback used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offDeferredVideoEnhancementInfo(type: 'deferredVideoEnhancementInfo', callback?: AsyncCallback<DeferredVideoEnhancementInfo>): void;
        /**
         * Unsubscribes from frame start event callback.
         *
         * @param { 'frameStart' } type - Event type.
         * @param { AsyncCallback<void> } [callback] - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offFrameStart(type: 'frameStart', callback?: AsyncCallback<void>): void;
        /**
         * Unsubscribes from frame end event callback.
         *
         * @param { 'frameEnd' } type - Event type.
         * @param { AsyncCallback<void> } [callback] - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offFrameEnd(type: 'frameEnd', callback?: AsyncCallback<void>): void;
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the video output errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        
        /**
         * Gets the current preconfig type if you had already call preconfig interface.
         *
         * @returns { VideoProfile } The current preconfig type.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        getActiveProfile(): VideoProfile;
        /**
         * Get supported video meta types.
         * @returns { Array<VideoMetaType> } The array of supported video meta type.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedVideoMetaTypes(): Array<VideoMetaType>;
        /**
         * Attach a meta surface to VideoOutput.
         * @param { string } surfaceId - Surface object id used for receiving meta infos.
         * @param { VideoMetaType } type - Video meta type.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        attachMetaSurface(surfaceId: string, type: VideoMetaType): void;
    }
    /**
     * Video meta type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum VideoMetaType {
        /**
         * Video meta type for storing maker info.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        VIDEO_META_MAKER_INFO = 0
    }
    /**
     * Video capability object
     *
     * @typedef VideoCapability
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface VideoCapability {
        /**
         * Determine whether BFrame is supported.
         *
         * @returns { boolean } Is BFrame supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isBFrameSupported(): boolean;
    }
    /**
     * Movie settings object
     *
     * @typedef MovieSettings
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MovieSettings {
        /**
         * Movie codec type.
         *
         * @type { VideoCodecType }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        videoCodec: VideoCodecType;
        /**
         * Video rotation.
         *
         * @type { ?ImageRotation }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        rotation?: ImageRotation;
        /**
         * Movie location.
         *
         * @type { ?Location }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        location?: Location;
        /**
         * Configure whether to enable B-frame, default false.
         *
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isBFrameEnabled?: boolean;
    }
    /**
     * Movie info object
     *
     * @typedef MovieInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MovieInfo {
        /**
         * Capture identity value.
         *
         * @type { int }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        captureId: int;
        /**
         * ID of the photo taken.
         *
         * @type { ?photoAccessHelper.PhotoAsset }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        asset?: photoAccessHelper.PhotoAsset;
    }
    
    /**
     * Metadata object type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum MetadataObjectType {
        
        /**
         * Face detection type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        FACE_DETECTION = 0,
        /**
         * Human body detection type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        HUMAN_BODY = 1,
        /**
         * Cat face detection type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        CAT_FACE = 2,
        /**
         * Cat body detection type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        CAT_BODY = 3,
        /**
         * Dog face detection type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        DOG_FACE = 4,
        /**
         * Dog body detection type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        DOG_BODY = 5,
        /**
         * Salient detection type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        SALIENT_DETECTION = 6,
        /**
         * Barcode detection type.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        BAR_CODE_DETECTION = 7
    }
    /**
     * Enum for light painting tabletype.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum LightPaintingType {
        /**
         * Traffic trails effect.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        TRAFFIC_TRAILS = 0,
        /**
         * Star trails effect.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        STAR_TRAILS = 1,
        /**
         * Silky water effect.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        SILKY_WATER = 2,
        /**
         * Light graffiti effect.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        LIGHT_GRAFFITI = 3
    }
    
    /**
     * Rectangle definition.
     *
     * @typedef Rect
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface Rect {
        
        /**
         * X coordinator of top left point.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        topLeftX: double;
        
        /**
         * Y coordinator of top left point.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        topLeftY: double;
        
        /**
         * Width of this rectangle.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        width: double;
        
        /**
         * Height of this rectangle.
         *
         * @type { double }
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        height: double;
    }
    /**
     * Enum for emotion type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum Emotion {
        /**
         * Emotion type: Neutral.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        NEUTRAL = 0,
        /**
         * Emotion type: Sadness.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        SADNESS = 1,
        /**
         * Emotion type: Smile.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        SMILE = 2,
        /**
         * Emotion type: Surprise.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        SURPRISE = 3
    }
    
    /**
     * Metadata object basis.
     *
     * @typedef MetadataObject
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface MetadataObject {
        
        /**
         * Metadata object type.
         *
         * @type { MetadataObjectType }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly type: MetadataObjectType;
        
        /**
         * Metadata object timestamp in milliseconds.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly timestamp: int;
        
        /**
         * The axis-aligned bounding box of detected metadata object.
         *
         * @type { Rect }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        readonly boundingBox: Rect;
        /**
         * Metadata object id.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly objectId: int;
        /**
         * Confidence for the detected type.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly confidence: int;
    }
    /**
     * Metadata object for face.
     *
     * @extends MetadataObject
     * @typedef MetadataFaceObject
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MetadataFaceObject extends MetadataObject {
        /**
         * Bounding box for left eye.
         *
         * @type { Rect }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly leftEyeBoundingBox: Rect;
        /**
         * Bounding box for right eye.
         *
         * @type { Rect }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly rightEyeBoundingBox: Rect;
        /**
         * Emotion type for face.
         *
         * @type { Emotion }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly emotion: Emotion;
        /**
         * Emotion confidence.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly emotionConfidence: int;
        /**
         * Pitch angle for face.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly pitchAngle: int;
        /**
         * Yaw angle for face.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly yawAngle: int;
        /**
         * Roll angle for face.
         *
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly rollAngle: int;
    }
    /**
     * Metadata object for human body.
     *
     * @extends MetadataObject
     * @typedef MetadataHumanBodyObject
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MetadataHumanBodyObject extends MetadataObject {
    }
    /**
     * Metadata object for cat face.
     *
     * @extends MetadataObject
     * @typedef MetadataCatFaceObject
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MetadataCatFaceObject extends MetadataObject {
        /**
         * Bounding box for left eye.
         *
         * @type { Rect }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly leftEyeBoundingBox: Rect;
        /**
         * Bounding box for right eye.
         *
         * @type { Rect }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly rightEyeBoundingBox: Rect;
    }
    /**
     * Metadata object for cat body.
     *
     * @extends MetadataObject
     * @typedef MetadataCatBodyObject
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MetadataCatBodyObject extends MetadataObject {
    }
    /**
     * Metadata object for dog face.
     *
     * @extends MetadataObject
     * @typedef MetadataDogFaceObject
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MetadataDogFaceObject extends MetadataObject {
        /**
         * Bounding box for left eye.
         *
         * @type { Rect }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly leftEyeBoundingBox: Rect;
        /**
         * Bounding box for right eye.
         *
         * @type { Rect }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly rightEyeBoundingBox: Rect;
    }
    /**
     * Metadata object for dog body.
     *
     * @extends MetadataObject
     * @typedef MetadataDogBodyObject
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MetadataDogBodyObject extends MetadataObject {
    }
    /**
     * Metadata object for salient detection.
     *
     * @extends MetadataObject
     * @typedef MetadataSalientDetectionObject
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MetadataSalientDetectionObject extends MetadataObject {
    }
    /**
     * Metadata object for barcode.
     *
     * @extends MetadataObject
     * @typedef MetadataBarcodeObject
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface MetadataBarcodeObject extends MetadataObject {
    }
    /**
     * Camera Occlusion Detection Result.
     *
     * @typedef CameraOcclusionDetectionResult
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface CameraOcclusionDetectionResult {
        /**
         * Check whether camera is occluded.
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly isCameraOccluded: boolean;
        /**
         * Check whether camera lens is dirty.
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly isCameraLensDirty: boolean;
    }
    
    /**
     * Metadata Output object
     *
     * @extends CameraOutput
     * @interface MetadataOutput
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    interface MetadataOutput extends CameraOutput {
        /**
         * @since 20
         */
        overload start {
            startWithCallback,
            startReturnsPromise
        };
        /**
         * Start output metadata
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        startWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Start output metadata
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        startReturnsPromise(): Promise<void>;
        /**
         * @since 20
         */
        overload stop {
            stopWithCallback,
            stopReturnsPromise
        };
        /**
         * Stop output metadata
         *
         * @param { AsyncCallback<void> } callback - Callback used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        stopWithCallback(callback: AsyncCallback<void>): void;
        /**
         * Stop output metadata
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        stopReturnsPromise(): Promise<void>;
        /**
         * Add metadata object types.
         *
         * @param { Array<MetadataObjectType> } types - Object types to be added.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        addMetadataObjectTypes(types: Array<MetadataObjectType>): void;
        /**
         * Remove metadata object types.
         *
         * @param { Array<MetadataObjectType> } types - Object types to be removed.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        removeMetadataObjectTypes(types: Array<MetadataObjectType>): void;
        /**
         * @since 20
         */
        overload on {
            onMetadataObjectsAvailable,
            onError
        };
        /**
         * Registers a listener for the detected metadata object to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'metadataObjectsAvailable' } type - Event type.
         * @param { AsyncCallback<Array<MetadataObject>> } callback - Callback used to get the available metadata objects.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onMetadataObjectsAvailable(type: 'metadataObjectsAvailable', callback: AsyncCallback<Array<MetadataObject>>): void;
        /**
         * Registers a listener for errors in the video output to get the result by registering
         * a callback function. This API uses an asynchronous callback to return the result.
         *
         * Description: Currently, it is not allowed to use off() to unregister the callback
         * within the callback method of on().
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the video output errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * @since 20
         */
        overload off {
            offmetadataObjectsAvailable,
            offError
        };
        /**
         * Unsubscribes from metadata objects available event callback.
         *
         * @param { 'metadataObjectsAvailable' } type - Event type.
         * @param { AsyncCallback<Array<MetadataObject>> } [callback] - Callback used to get the available metadata objects.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offmetadataObjectsAvailable(type: 'metadataObjectsAvailable', callback?: AsyncCallback<Array<MetadataObject>>): void;
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the video output errors.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
    }
    
    /**
     * Enum for camera concurrent type.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @since 20
     */
    enum CameraConcurrentType {
        
        /**
         * Cameras concurrency with limited capabilities.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_LIMITED_CAPABILITY = 0,
        
        /**
         * Cameras concurrency with full capabilities.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @since 20
         */
        CAMERA_FULL_CAPABILITY = 1
    }
    /**
     * Enumerates the timelapse recording state.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum TimeLapseRecordState {
        /**
         * TimeLapse idle state.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        IDLE = 0,
        /**
         * TimeLapse recording state.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        RECORDING = 1
    }
    /**
     * Enumerates the timelapse preview type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum TimeLapsePreviewType {
        /**
         * TimeLapse dark preview.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        DARK = 1,
        /**
         * TimeLapse Light preview.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        LIGHT = 2
    }
    /**
     * Try AE information.
     *
     * @typedef TryAEInfo
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface TryAEInfo {
        /**
         * Determine whether try AE is done.
         *
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly isTryAEDone: boolean;
        /**
         * Determine whether AE hint is needed.
         *
         * @type { ?boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly isTryAEHintNeeded?: boolean;
        /**
         * Timelapse preview type.
         *
         * @type { ?TimeLapsePreviewType }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly previewType?: TimeLapsePreviewType;
        /**
         * Timelapse capture interval.
         *
         * @type { ?int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly captureInterval?: int;
    }
    /**
     * Timelapse photo session object.
     *
     * @extends Session, Focus, ManualFocus, AutoExposure, ManualExposure, ManualIso, WhiteBalance, Zoom, ColorEffect
     * @interface TimeLapsePhotoSession
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface TimeLapsePhotoSession extends Session, Focus, ManualFocus, AutoExposure, ManualExposure, ManualIso, WhiteBalance, Zoom, ColorEffect {
        /**
         * Check whether try AE is needed.
         *
         * @returns { boolean } Is try AE needed.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isTryAENeeded(): boolean;
        /**
         * Start try AE.
         *
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        startTryAE(): void;
        /**
         * Stop try AE.
         *
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        stopTryAE(): void;
        /**
         * @since 20
         */
        overload on {
            onError,
            onFocusStateChange,
            onIsoInfoChange,
            onExposureInfoChange,
            onLuminationInfoChange,
            onTryAEInfoChange
        };
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } callback - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onFocusStateChange(type: 'focusStateChange', callback: AsyncCallback<FocusState>): void;
        /**
         * Subscribes ISO info event callback.
         *
         * @param { 'isoInfoChange' } type - Event type.
         * @param { AsyncCallback<IsoInfo> } callback - Callback used to get the ISO info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onIsoInfoChange(type: 'isoInfoChange', callback: AsyncCallback<IsoInfo>): void;
        /**
         * Subscribes exposure info event callback.
         *
         * @param { 'exposureInfoChange' } type - Event type.
         * @param { AsyncCallback<ExposureInfo> } callback - Callback used to get the exposure info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onExposureInfoChange(type: 'exposureInfoChange', callback: AsyncCallback<ExposureInfo>): void;
        /**
         * Subscribes lumination info event callback.
         *
         * @param { 'luminationInfoChange' } type - Event type.
         * @param { AsyncCallback<LuminationInfo> } callback - Callback used to get the lumination info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onLuminationInfoChange(type: 'luminationInfoChange', callback: AsyncCallback<LuminationInfo>): void;
        /**
         * Subscribes try AE info event callback.
         *
         * @param { 'tryAEInfoChange' } type - Event type.
         * @param { AsyncCallback<TryAEInfo> } callback - Callback used to get the try AE info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onTryAEInfoChange(type: 'tryAEInfoChange', callback: AsyncCallback<TryAEInfo>): void;
        /**
         * @since 20
         */
        overload off {
            offError,
            offFocusStateChange,
            offIsoInfoChange,
            offExposureInfoChange,
            offLuminationInfoChange,
            offTryAEInfoChange
        };
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the capture session errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from focus state change event callback.
         *
         * @param { 'focusStateChange' } type - Event type.
         * @param { AsyncCallback<FocusState> } [callback] - Callback used to get the focus state change.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offFocusStateChange(type: 'focusStateChange', callback?: AsyncCallback<FocusState>): void;
        /**
         * Unsubscribes from ISO info event callback.
         *
         * @param { 'isoInfoChange' } type - Event type.
         * @param { AsyncCallback<IsoInfo> } [callback] - Callback used to get the ISO info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offIsoInfoChange(type: 'isoInfoChange', callback?: AsyncCallback<IsoInfo>): void;
        /**
         * Unsubscribes from exposure info event callback.
         *
         * @param { 'exposureInfoChange' } type - Event type.
         * @param { AsyncCallback<ExposureInfo> } [callback] - Callback used to get the exposure info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offExposureInfoChange(type: 'exposureInfoChange', callback?: AsyncCallback<ExposureInfo>): void;
        /**
         * Unsubscribes from lumination info event callback.
         *
         * @param { 'luminationInfoChange' } type - Event type.
         * @param { AsyncCallback<LuminationInfo> } [callback] - Callback used to get the lumination info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offLuminationInfoChange(type: 'luminationInfoChange', callback?: AsyncCallback<LuminationInfo>): void;
        /**
         * Unsubscribes from try AE info event callback.
         *
         * @param { 'tryAEInfoChange' } type - Event type.
         * @param { AsyncCallback<TryAEInfo> } [callback] - Callback used to get the try AE info.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offTryAEInfoChange(type: 'tryAEInfoChange', callback?: AsyncCallback<TryAEInfo>): void;
        /**
         * Gets supported timelapse interval range.
         *
         * @returns { Array<int> } Timelapse interval range.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedTimeLapseIntervalRange(): Array<int>;
        /**
         * Gets the timelapse interval in use.
         *
         * @returns { int } the timelapse interval in use.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getTimeLapseInterval(): int;
        /**
         * Sets a timelapse interval for a camera device.
         *
         * @param { int } interval The timelapse interval.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setTimeLapseInterval(interval: int): void;
        /**
         * Sets a timelapse recording state.
         *
         * @param { TimeLapseRecordState } state The timelapse recording state.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setTimeLapseRecordState(state: TimeLapseRecordState): void;
        /**
         * Sets a timelapse preview type.
         *
         * @param { TimeLapsePreviewType } type The timelapse preview type.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setTimeLapsePreviewType(type: TimeLapsePreviewType): void;
    }
    /**
     * Enum for Depth Data Accuracy.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum DepthDataAccuracy {
        /**
         * Relative accuracy depth data.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        DEPTH_DATA_ACCURACY_RELATIVE = 0,
        /**
         * Absolute accuracy depth data.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        DEPTH_DATA_ACCURACY_ABSOLUTE = 1
    }
    /**
     * Enum for Depth Data Quality Level.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum DepthDataQualityLevel {
        /**
         * Depth data quality is bad.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        DEPTH_DATA_QUALITY_BAD = 0,
        /**
         * Depth data quality is fair.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        DEPTH_DATA_QUALITY_FAIR = 1,
        /**
         * Depth data quality is good.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        DEPTH_DATA_QUALITY_GOOD = 2
    }
    /**
     * Depth Profile.
     *
     * @interface DepthProfile
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface DepthProfile {
        /**
         * Depth data format.
         *
         * @type { CameraFormat }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly format: CameraFormat;
        /**
         * Depth data accuracy.
         *
         * @type { DepthDataAccuracy }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly dataAccuracy: DepthDataAccuracy;
        /**
         * Depth data resolution.
         *
         * @type { Size }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly size: Size;
    }
    /**
     * Depth Data.
     *
     * @interface DepthData.
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface DepthData {
        /**
         * Depth data format.
         *
         * @type { CameraFormat }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly format: CameraFormat;
        /**
         * Depth data map.
         *
         * @type { image.PixelMap }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly depthMap: image.PixelMap;
        /**
         * Depth data quality level.
         *
         * @type { DepthDataQualityLevel }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly qualityLevel: DepthDataQualityLevel;
        /**
         * Depth data accuracy.
         *
         * @type { DepthDataAccuracy }
         * @readonly
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        readonly dataAccuracy: DepthDataAccuracy;
        /**
         * Release depth data object.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        release(): Promise<void>;
    }
    /**
     * Depth Data Output object
     *
     * @extends CameraOutput
     * @interface DepthDataOutput
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface DepthDataOutput extends CameraOutput {
        /**
         * Start depth data output.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        start(): Promise<void>;
        /**
         * Stop depth data output.
         *
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        stop(): Promise<void>;
        /**
         * @since 20
         */
        overload on {
            onDepthDataAvailable,
            onError
        };
        /**
         * Subscribes to depth data objects available event callback.
         *
         * @param { 'depthDataAvailable' } type - Event type.
         * @param { AsyncCallback<DepthData> } callback - Callback used to get the available DepthData objects.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onDepthDataAvailable(type: 'depthDataAvailable', callback: AsyncCallback<DepthData>): void;
        /**
         * Subscribes to error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } callback - Callback used to get the video output errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        onError(type: 'error', callback: ErrorCallback): void;
        /**
         * @since 20
         */
        overload off {
            offDepthDataAvailable,
            offError
        };
        /**
         * Unsubscribes from depth data objects available event callback.
         *
         * @param { 'depthDataAvailable' } type - Event type.
         * @param { AsyncCallback<DepthData> } [callback] - Callback used to get the available DepthData objects.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offDepthDataAvailable(type: 'depthDataAvailable', callback?: AsyncCallback<DepthData>): void;
        /**
         * Unsubscribes from error events.
         *
         * @param { 'error' } type - Event type.
         * @param { ErrorCallback } [callback] - Callback used to get the video output errors.
         * @throws { BusinessError } 202 - Not System Application.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        offError(type: 'error', callback?: ErrorCallback): void;
    }
    /**
     * Depth Fusion Query object.
     *
     * @interface DepthFusionQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface DepthFusionQuery {
        /**
         * Checks whether a depth fusion is supported.
         *
         * @returns { boolean } Is the depth fusion supported.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isDepthFusionSupported(): boolean;
        /**
         * Query the depth fusion threshold.
         *
         * @returns { Array<double> } The depth fusion threshold.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getDepthFusionThreshold(): Array<double>;
    }
    /**
     * Depth Fusion object.
     *
     * @extends DepthFusionQuery
     * @interface DepthFusion
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface DepthFusion extends DepthFusionQuery {
        /**
         * Confirm if the depth fusion enabled.
         *
         * @returns { boolean } TRUE if the depth fusion is enable.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        isDepthFusionEnabled(): boolean;
        /**
         * Enable depth fusion.
         *
         * @param { boolean } enabled - Target state for depth fusion.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400101 - Parameter missing or parameter type incorrect.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        enableDepthFusion(enabled: boolean): void;
    }
    /**
     * Enum for auxiliary type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum AuxiliaryType {
        /**
         * Contract lens.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        CONTRACT_LENS = 0
    }
    /**
     * Enum for auxiliary status.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum AuxiliaryStatus {
        /**
         * Auxiliary locked.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        LOCKED = 0,
        /**
         * Turn on auxiliary.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        ON = 1,
        /**
         * Turn off auxiliary.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        OFF = 2
    }
    /**
     * Enum for color reservation type.
     *
     * @enum { int }
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    enum ColorReservationType {
        /**
         * None.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        NONE = 0,
        /**
         * Portrait color reservation.
         *
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        PORTRAIT = 1
    }
    /**
     * Color Reservation Query object.
     *
     * @interface ColorReservationQuery
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ColorReservationQuery {
        /**
         * Gets supported color reservation types.
         *
         * @returns { Array<ColorReservationType> } Array of supported color reservation types.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getSupportedColorReservationTypes(): Array<ColorReservationType>;
    }
    /**
     * Color Reservation object.
     *
     * @extends ColorReservationQuery
     * @interface ColorReservation
     * @syscap SystemCapability.Multimedia.Camera.Core
     * @systemapi
     * @since 20
     */
    interface ColorReservation extends ColorReservationQuery {
        /**
         * Gets the current color reservation type.
         *
         * @returns { ColorReservationType } The current color reservation type.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 7400103 - Session not config, only throw in session usage.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        getColorReservation(): ColorReservationType;
        /**
         * Sets the color reservation type.
         *
         * @param { ColorReservationType } type - The color reservation type.
         * @throws { BusinessError } 202 - Not System Application.
         * @throws { BusinessError } 401 - Parameter error. Possible causes:
         * 1. Mandatory parameters are left unspecified; 2. Incorrect parameter types;
         * 3. Parameter verification failed.
         * @throws { BusinessError } 7400102 - Operation not allowed.
         * @throws { BusinessError } 7400103 - Session not config.
         * @throws { BusinessError } 7400201 - Camera service fatal error.
         * @syscap SystemCapability.Multimedia.Camera.Core
         * @systemapi
         * @since 20
         */
        setColorReservation(type: ColorReservationType): void;
    }
}
export default camera;
