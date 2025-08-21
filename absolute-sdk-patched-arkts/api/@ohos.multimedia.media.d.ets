/*
* Copyright (C) 2021-2024 Huawei Device Co., Ltd.
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
 * @kit MediaKit
 */
import { ErrorCallback, AsyncCallback, Callback } from './@ohos.base';
import audio from './@ohos.multimedia.audio';
import photoAccessHelper from './@ohos.file.photoAccessHelper';
import type image from './@ohos.multimedia.image';
import type { SoundPool as _SoundPool } from './multimedia/soundPool';
import type { PlayParameters as _PlayParameters } from './multimedia/soundPool';
import type drm from './@ohos.multimedia.drm';


/**
 * The multimedia subsystem provides a set of simple and easy-to-use APIs for you to access the system and
 * use media resources.
 *
 * @namespace media
 * @syscap SystemCapability.Multimedia.Media.Core
 * @since 20
 */
declare namespace media {
    /**
     * Creates an **AVPlayer** instance. This API uses an asynchronous callback to return the result.
     * <br>**NOTE:**<br>
     * You are advised to create a maximum of 16 **AVPlayer** instances for an application in both audio and video
     * playback scenarios.
     *
     * The actual number of instances that can be created may be different.
     * It depends on the specifications of the device chip in use.
     *
     * @param { AsyncCallback<AVPlayer | undefined> } callback - used to return the result. If the operation is successful, an
     * **AVPlayer** instance is returned; otherwise, **null** is returned. The instance can be used to play
     * audio and video.
     * @throws { BusinessError } 5400101 - No memory. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.AVPlayer
     * @since 20
     */
    function createAVPlayer(callback: AsyncCallback<AVPlayer | undefined>): void;
    /**
     * Creates an **AVPlayer** instance. This API uses a promise to return the result.
     * <br>**NOTE:**<br>
     * You are advised to create a maximum of 16 **AVPlayer** instances for an application in both audio and video
     * playback scenarios.
     *
     * The actual number of instances that can be created may be different. It depends on the specifications of
     * the device chip in use.
     *
     * @returns { Promise<AVPlayer | undefined> } A Promise instance used to return the result. If the operation is successful, an
     * **AVPlayer** instance is returned; **null** is returned otherwise. The instance can be used to play
     * audio and video.
     * @throws { BusinessError } 5400101 - No memory. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.AVPlayer
     * @since 20
     */
    function createAVPlayer(): Promise<AVPlayer | undefined>;
    /**
     * Creates an **AVRecorder** instance. This API uses an asynchronous callback to return the result.
     * @param { AsyncCallback<AVRecorder | undefined> } callback - Callback used to return the result.
     * If the operation is successful, an **AVRecorder** instance is returned;
     * otherwise, **null** is returned. The instance can be used to record audio and video.
     * @throws { BusinessError } 5400101 - No memory. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    function createAVRecorder(callback: AsyncCallback<AVRecorder | undefined>): void;
    /**
     * Creates an **AVRecorder** instance. This API uses a promise to return the result.
     * @returns { Promise<AVRecorder | undefined> } Promise used to return the result. If the operation is successful,
     * an **AVRecorder** instance is returned; otherwise, **null** is returned.
     * The instance can be used to record audio and video.
     * @throws { BusinessError } 5400101 - No memory. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    function createAVRecorder(): Promise<AVRecorder | undefined>;
    /**
     * Creates a media source for streaming media to be pre-downloaded.
     * @param { string } url : Url of the media source. The following streaming media formats are supported: HLS,
     *  HTTP-FLV, DASH, and HTTPS.
     * @param { Record<string, string> } [headers] : Headers attached to network request while player request data.
     * @returns { MediaSource | undefined } MediaSource instance if the operation is successful; returns null otherwise.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * <br>2. Incorrect parameter types. 3.Parameter verification failed.
     * @throws { BusinessError } 5400101 - No memory.
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    function createMediaSourceWithUrl(url: string, headers?: Record<string, string>): MediaSource | undefined;
    /**
     * Creates a multi-bitrate media source for streaming media. Currently, only the HTTP-FLV multi-bitrate
     * media source is supported.
     * @param { Array<MediaStream> } streams - Array of MediaStream objects.
     * The supported streaming media format is HTTP-FLV.
     * @returns { MediaSource | undefined } MediaSource instance if the operation is successful; returns null otherwise.
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    function createMediaSourceWithStreamData(streams: Array<MediaStream>): MediaSource | undefined;
    /**
     * The maintenance of this interface has been stopped since version api 9. Please use AVRecorder
     * Creates an VideoRecorder instance.
     * @param { AsyncCallback<VideoRecorder | undefined> } callback - used to return AudioPlayer instance if the operation is successful; returns null otherwise.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 5400101 - No memory. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.VideoRecorder
     * @systemapi
     * @since 20
     */
    function createVideoRecorder(callback: AsyncCallback<VideoRecorder | undefined>): void;
    /**
     * The maintenance of this interface has been stopped since version api 9. Please use AVRecorder
     * Creates an VideoRecorder instance.
     * @returns { Promise<VideoRecorder | undefined> } A Promise instance used to return VideoRecorder instance if the operation is successful; returns null otherwise.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 5400101 - No memory. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.VideoRecorder
     * @systemapi
     * @since 20
     */
    function createVideoRecorder(): Promise<VideoRecorder | undefined>;
    /**
     * Creates a **SoundPool** instance. This API uses an asynchronous callback to return the result.
     *
     * **NOTE**
     * - In versions earlier than API version 18, the bottom layer of the created **SoundPool** object is in singleton
     * mode. Therefore, an application process can create only one **SoundPool** instance.
     * - In API version 18 and later versions, the bottom layer of the created **SoundPool** object is in multiton mode.
     * Therefore, an application process can create a maximum of 128 **SoundPool** instances.
     *
     * @param {int} maxStreams - Maximum number of streams that can be played by the **SoundPool** instance.
     * The value is an integer ranging from 1 to 32.
     * @param {audio.AudioRendererInfo} audioRenderInfo - Audio renderer parameters. When the **usage** parameter
     * in **audioRenderInfo** is set to **STREAM_USAGE_UNKNOWN**, **STREAM_USAGE_MUSIC**, **STREAM_USAGE_MOVIE**, or
     * **STREAM_USAGE_AUDIOBOOK**, the SoundPool uses the audio mixing mode when playing a short sound, without
     * interrupting the playback of other audios.
     * @param {AsyncCallback<SoundPool | undefined>} callback - Callback used to return the result. If the operation is successful, a
     * **SoundPool** instance is returned; otherwise, **null** is returned.
     * The instance is used for loading and playback.
     * @throws { BusinessError } 5400101 - No memory. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    function createSoundPool(maxStreams: int, audioRenderInfo: audio.AudioRendererInfo, callback: AsyncCallback<SoundPool | undefined>): void;
    /**
     * Creates a **SoundPool** instance. This API uses a promise to return the result.
     *
     * **NOTE**
     * - In versions earlier than API version 18, the bottom layer of the created **SoundPool** object is in singleton
     * mode. Therefore, an application process can create only one **SoundPool** instance.
     * - In API version 18 and later versions, the bottom layer of the created **SoundPool** object is in multiton mode.
     * Therefore, an application process can create a maximum of 128 **SoundPool** instances.
     *
     * @param {int} maxStreams - Maximum number of streams that can be played by the **SoundPool** instance.
     * The value is an integer ranging from 1 to 32.
     * @param {audio.AudioRendererInfo} audioRenderInfo - Audio renderer parameters.
     * @returns {Promise<SoundPool | undefined>} Promise used to return the result. If the operation is successful,
     * a **SoundPool** instance is returned; otherwise, **null** is returned.
     * The instance is used for loading and playback.
     * @throws { BusinessError } 5400101 - No memory. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    function createSoundPool(maxStreams: int, audioRenderInfo: audio.AudioRendererInfo): Promise<SoundPool | undefined>;
    /**
     * Creates an **AVScreenCaptureRecorder** instance. This API uses a promise to return the result.
     * @returns { Promise<AVScreenCaptureRecorder | undefined> } Promise used to return the result. If the operation is successful,
     * an **AVScreenCaptureRecorder** instance is returned; otherwise, **null** is returned.
     * The instance can be used for screen capture.
     * @throws { BusinessError } 5400101 - No memory. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
     * @since 20
     * @example
     * import { BusinessError } from '@kit.BasicServicesKit';
     *
     * let avScreenCaptureRecorder: media.AVScreenCaptureRecorder;
     * media.createAVScreenCaptureRecorder().then((captureRecorder: media.AVScreenCaptureRecorder) => {
     *   if (captureRecorder != null) {
     *     avScreenCaptureRecorder = captureRecorder;
     *     console.info('Succeeded in createAVScreenCaptureRecorder');
     *   } else {
     *     console.error('Failed to createAVScreenCaptureRecorder');
     *   }
     * }).catch((error: BusinessError) => {
     *   console.error(`createAVScreenCaptureRecorder catchCallback, error message:${error.message}`);
     * });
     */
    function createAVScreenCaptureRecorder(): Promise<AVScreenCaptureRecorder | undefined>;
    /**
     * Reports the user selection result in the screen capture privacy dialog box to the AVScreenCapture server to
     * determine whether to start screen capture. Screen capture starts only when the user touches a button to
     * continue the operation.
     * This API is called by the system application that creates the dialog box.
     *
     * @param {int} sessionId Session ID of the AVScreenCapture service, which is sent to the application when
     * the AVScreenCapture server starts the privacy dialog box.
     * @param {string} choice User choice, including whether screen capture is agreed, selected display ID,
     * and window ID. For details, see JsonData in the example below.
     * @returns { Promise<void> } Promise used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
     * 2. Incorrect parameter types. 3.Parameter verification failed.
     * @throws { BusinessError } 5400101 - No memory. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
     * @systemapi
     * @since 20
     * @example
     * import { BusinessError } from '@kit.BasicServicesKit';
     * import { media } from '@kit.MediaKit';
     *
     * class JsonData {
     *   public choice: string = 'true'
     *   public displayId: number | null = -1
     *   public missionId: number | null = -1
     * }
     * let sessionId: number = 0; // Use the ID of the session that starts the process.
     *
     * try {
     *   const jsonData: JsonData = {
     *     choice: 'true',  // Replace it with the user choice.
     *     displayId: -1, // Replace it with the ID of the display selected by the user.
     *     missionId: -1,   // Replace it with the ID of the window selected by the user.
     *   }
     *   await media.reportAVScreenCaptureUserChoice(sessionId, JSON.stringify(jsonData));
     * } catch (error: BusinessError) {
     *   console.error(`reportAVScreenCaptureUserChoice error, error message: ${error.message}`);
     * }
     */
    function reportAVScreenCaptureUserChoice(sessionId: int, choice: string): Promise<void>;
    /**
     * Creates an **AVTranscoder** instance. This API uses a promise to return the result.
     *
     * **NOTE**
     *
     * A maximum of 2 **AVTranscoder** instances can be created.
     *
     * @returns {Promise<AVTranscoder | undefined>} Promise used to return the result. If the operation is successful, an
     * **AVTranscoder** instance is returned; otherwise, **null** is returned. The instance can be used for video
     * transcoding.
     * @throws { BusinessError } 5400101 - No memory. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.AVTranscoder
     * @since 20
     */
    function createAVTranscoder(): Promise<AVTranscoder | undefined>;
    /**
     * Obtains a **ScreenCaptureMonitor** instance. This API uses a promise to return the result.
     *
     * @returns { Promise<ScreenCaptureMonitor | undefined> } Promise used to return the result. The instance can be used to query
     * and monitor the status of the system screen recorder.<br>If the operation is successful,
     * a **ScreenCaptureMonitor** instance is returned; otherwise, **null** is returned.
     * @throws { BusinessError } 202 - Not System App.
     * @throws { BusinessError } 5400101 - No memory. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
     * @systemapi
     * @since 20
     * @example
     * let screenCaptureMonitor: media.ScreenCaptureMonitor;
     * try {
     *   screenCaptureMonitor = await media.getScreenCaptureMonitor();
     * } catch (err) {
     *   console.error(`getScreenCaptureMonitor failed, error message:${err.message}`);
     * }
     */
    function getScreenCaptureMonitor(): Promise<ScreenCaptureMonitor | undefined>;
    /**
     * Provides APIs for loading, unloading, playing, and stopping playing system sounds, setting the volume,
     * and setting the number of loops.
     *
     * @typedef { _SoundPool }
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    type SoundPool = _SoundPool;
    /**
     * Playback parameters of the sound pool.
     *
     * @typedef { _PlayParameters }
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    type PlayParameters = _PlayParameters;
    
    
    /**
     * Enumerates the reasons for the state transition of the **AVPlayer** or **AVRecorder** instance.
     * The enum value is reported together with **state**.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum StateChangeReason {
        
        
        /**
         * State transition triggered by user behavior. It happens when a user or the client calls an API.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        USER = 1,
        
        
        /**
         * State transition caused by background system behavior. For example, if an application does not have the permission of
         * Media Controller, the application is forcibly suspended or stopped by the system when it switches to the background.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        BACKGROUND = 2
    }
    /**
     * Creates an **AVMetadataExtractor** instance. This API uses a promise to return the result.
     * @returns { Promise<AVMetadataExtractor | undefined> } A Promise instance used to return AVMetadataExtractor instance
     * if the operation is successful; returns null otherwise.
     * @throws { BusinessError } 5400101 - No memory. Returned by promise.
     * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
     * @since 20
     */
    function createAVMetadataExtractor(): Promise<AVMetadataExtractor | undefined>;
    /**
     * Creates an **AVMetadataExtractor** instance. This API uses an asynchronous callback to return the result.
     * @param { AsyncCallback<AVMetadataExtractor | undefined> } callback - Callback used to return the result. If the operation is
     * successful, **err** is **undefined** and **data** is the **AVMetadataExtractor** instance created;
     * otherwise, **err** is an error object.
     * @throws { BusinessError } 5400101 - No memory. Returned by callback.
     * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
     * @since 20
     */
    function createAVMetadataExtractor(callback: AsyncCallback<AVMetadataExtractor | undefined>): void;
    /**
     * Creates an **AVImageGenerator** instance. This API uses a promise to return the result.
     * @returns { Promise<AVImageGenerator | undefined> } Promise used to return the result. If the operation is successful,
     * an **AVImageGenerator** instance is returned; otherwise, **null** is returned.
     * The API can be used to obtain a video thumbnail.
     * @throws { BusinessError } 5400101 - No memory. Returned by promise.
     * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
     * @since 20
     */
    function createAVImageGenerator(): Promise<AVImageGenerator | undefined>;
    /**
     * Creates an **AVImageGenerator** instance. This API uses an asynchronous callback to return the result.
     * @param { AsyncCallback<AVImageGenerator | undefined> } callback - Callback used to return the result.
     * If the operation is successful, an **AVImageGenerator** instance is returned; otherwise, **null** is returned.
     * The API can be used to obtain a video thumbnail.
     * @throws { BusinessError } 5400101 - No memory. Returned by callback.
     * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
     * @since 20
     */
    function createAVImageGenerator(callback: AsyncCallback<AVImageGenerator | undefined>): void;
    
    /**
     * Fetch media meta data or audio art picture from source. Before calling an **AVMetadataExtractor** method,
     * you must use [createAVMetadataExtractor()]{@link #createAVMetadataExtractor} to create an
     * **AVMetadataExtractor** instance.
     *
     * @typedef AVMetadataExtractor
     * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
     * @since 20
     */
    interface AVMetadataExtractor {
        
        /**
         * Media file descriptor, which specifies the data source. Before obtaining metadata,
         * you must set the data source through either **fdSrc** or **dataSrc**.
         *
         * **Example:**
         *
         * There is a media file that stores continuous assets, the address offset is 0, and the byte length is 100.
         * Its file descriptor is **AVFileDescriptor { fd = resourceHandle; offset = 0; length = 100; }**.
         *
         * **NOTE**
         * - After the resource handle (FD) is transferred to an **AVMetadataExtractor** instance,
         * do not use the resource handle to perform other read and write operations, including but not limited to
         * transferring this handle to other **AVPlayer**, **AVMetadataExtractor**, **AVImageGenerator**,
         * or **AVTranscoder** instance. Competition occurs when multiple **AVMetadataExtractor** use the same resource
         * handle to read and write files at the same time, resulting in errors in obtaining data.
         * @type { ?AVFileDescriptor }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        fdSrc?: AVFileDescriptor;
        
        /**
         * Streaming media resource descriptor, which specifies the data source. Before obtaining metadata,
         * you must set the data source through either **fdSrc** or **dataSrc**.
         *
         * When an application obtains a media file from the remote, you can set **dataSrc** to obtain the metadata before
         * the application finishes the downloading.
         * @type { ?AVDataSrcDescriptor }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        dataSrc?: AVDataSrcDescriptor;
        /**
         * Obtains media metadata. This API uses an asynchronous callback to return the result.
         * @param { AsyncCallback<AVMetadata | undefined> } callback - Callback used to return the result,
         * which is an **AVMetadata** instance.
         * @throws { BusinessError } 5400102 - Operation not allowed. Returned by callback.
         * @throws { BusinessError } 5400106 - Unsupported format. Returned by callback.
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        fetchMetadata(callback: AsyncCallback<AVMetadata | undefined>): void;
        /**
         * Obtains media metadata. This API uses a promise to return the result.
         * @returns { Promise<AVMetadata | undefined> } Promise used to return the result, which is an **AVMetadata** instance.
         * @throws { BusinessError } 5400102 - Operation not allowed. Returned by promise.
         * @throws { BusinessError } 5400106 - Unsupported format. Returned by promise.
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        fetchMetadata(): Promise<AVMetadata | undefined>;
        /**
         * Obtains the cover of the audio album. This API uses an asynchronous callback to return the result.
         * @param { AsyncCallback<image.PixelMap | undefined> } callback - Callback used to return the album cover.
         * to return when fetchAlbumCover completed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @throws { BusinessError } 5400106 - Unsupported format. Returned by callback.
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        fetchAlbumCover(callback: AsyncCallback<image.PixelMap | undefined>): void;
        /**
         * Obtains the cover of the audio album. This API uses a promise to return the result.
         * @returns { Promise<image.PixelMap | undefined> } Promise used to return the album cover.
         * @throws { BusinessError } 5400102 - Operation not allowed. Returned by promise.
         * @throws { BusinessError } 5400106 - Unsupported format. Returned by promise.
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        fetchAlbumCover(): Promise<image.PixelMap | undefined>;
        /**
         * Obtains the video timestamp corresponding to a video frame number. Only MP4 video files are supported.
         * @param { int } index - Video frame number.
         * @returns { Promise<long> } Promise used to return the timestamp, in microseconds.
         * @throws { BusinessError } 401 - The parameter check failed. Return by promise.
         * @throws { BusinessError } 5400102 - Operation not allowed. Returned by promise.
         * @throws { BusinessError } 5400106 - Unsupported format. Returned by promise.
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @systemapi
         * @since 20
         */
        getTimeByFrameIndex(index: int): Promise<long>;
        /**
         * Obtains the video frame number corresponding to a video timestamp. Only MP4 video files are supported.
         * @param { long } timeUs - Video timestamp, in microseconds.
         * @returns { Promise<int> } Promise used to return the video frame number.
         * @throws { BusinessError } 401 - The parameter check failed. Return by promise.
         * @throws { BusinessError } 5400102 - Operation not allowed. Returned by promise.
         * @throws { BusinessError } 5400106 - Unsupported format. Returned by promise.
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @systemapi
         * @since 20
         */
        getFrameIndexByTime(timeUs: long): Promise<int>;
        
        /**
         * Releases this **AVMetadataExtractor** instance. This API uses an asynchronous callback to return the result.
         * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
         * **err** is **undefined**; otherwise, **err** is an error object.
         * @throws { BusinessError } 5400102 - Operation not allowed. Returned by callback.
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        release(callback: AsyncCallback<void>): void;
        
        /**
         * Releases this **AVMetadataExtractor** instance. This API uses a promise to return the result.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400102 - Operation not allowed. Returned by promise.
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        release(): Promise<void>;
    }
    
    /**
     * Defines the audio and video metadata. Parameters that are not declared as read-only in
     * [AVRecorderConfig]{@link #AVRecorderConfig} can be used as input parameters for recording of
     * [AVRecorder]{@link #AVRecorder}.
     * @typedef AVMetadata
     * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
     * @since 20
     */
    interface AVMetadata {
        
        /**
         * Title of the album. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        album?: string;
        
        /**
         * Artist of the album. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        albumArtist?: string;
        
        /**
         * Artist of the media asset. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        artist?: string;
        
        /**
         * Author of the media asset. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        author?: string;
        
        /**
         * Time when the media asset is created. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        dateTime?: string;
        
        /**
         * Time when the media asset is created. The value is in the YYYY-MM-DD HH:mm:ss format.
         * This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        dateTimeFormat?: string;
        
        /**
         * Composer of the media asset. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        composer?: string;
        
        /**
         * Duration of the media asset. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        duration?: string;
        
        /**
         * Type or genre of the media asset.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        genre?: string;
        
        /**
         * Whether the media asset contains audio. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        hasAudio?: string;
        
        /**
         * Whether the media asset contains a video. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        hasVideo?: string;
        
        /**
         * MIME type of the media asset. This parameter is read-only in the current version.
         * Some example mime types include: "video/mp4", "audio/mp4", "audio/amr-wb".
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        mimeType?: string;
        
        /**
         * Number of tracks of the media asset. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        trackCount?: string;
        
        /**
         * Audio sampling rate, in Hz. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        sampleRate?: string;
        
        /**
         * Title of the media asset. This parameter is read-only in the current version.
         * This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        title?: string;
        
        /**
         * Video height, in px. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        videoHeight?: string;
        
        /**
         * Video width, in px. This parameter is read-only in the current version.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        videoWidth?: string;
        
        /**
         * Video rotation direction, in degrees.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        videoOrientation?: string;
        /**
        * HDR type of the media asset. This parameter is read-only in the current version.
        * @type { ?HdrType }
        * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
        * @since 20
        */
        hdrType?: HdrType;
        /**
         * Geographical location of the media asset.
         * @type { ?Location }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        location?: Location;
        /**
         * Custom key-value mappings obtained from **moov.meta.list**.
         * @type { ?Record<string, string> }
         * @syscap SystemCapability.Multimedia.Media.AVMetadataExtractor
         * @since 20
         */
        customInfo?: Record<string, string>;
    }
    /**
     * Enumerates options about the HDR Type of the video.
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum HdrType {
        /**
         * This option is used to mark none HDR type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AV_HDR_TYPE_NONE = 0,
        /**
         * This option is used to mark HDR Vivid type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AV_HDR_TYPE_VIVID = 1
    }
    /**
     * Provides APIs to obtain a thumbnail from a video. Before calling any API of **AVImageGenerator**,
     * you must use [createAVImageGenerator()]{@link #createAVImageGenerator} to create an **AVImageGenerator** instance.
     *
     * @typedef AVImageGenerator
     * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
     * @since 20
     */
    interface AVImageGenerator {
        /**
         * Media file descriptor, which specifies the data source.
         *
         * **Example:**
         *
         * There is a media file that stores continuous assets, the address offset is 0, and the byte length is 100.
         * Its file descriptor is **AVFileDescriptor { fd = resourceHandle; offset = 0; length = 100; }**.
         *
         * **NOTE**
         * - After the resource handle (FD) is transferred to an **AVImageGenerator** instance,
         * do not use the resource handle to perform other read and write operations, including but not limited to
         * transferring this handle to other **AVPlayer**, **AVMetadataExtractor**, **AVImageGenerator**,
         * or **AVTranscoder** instance. Competition occurs when multiple **AVImageGenerator**
         * use the same resource handle to read and write files at the same time, resulting in errors in obtaining data.
         * @type { ?AVFileDescriptor }
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @since 20
         */
        fdSrc?: AVFileDescriptor;
        /**
       * Obtains a video thumbnail. This API uses an asynchronous callback to return the result.
       * @param { long } timeUs - Time of the video for which a thumbnail is to be obtained, in μs.
       * @param { AVImageQueryOptions } options - Relationship between the time passed in and the video frame.
       * @param { PixelMapParams } param - Format parameters of the thumbnail to be obtained.
       * @param { AsyncCallback<image.PixelMap | undefined> } callback - Callback used to return the result.
       *     If the operation is successful, **err** is **undefined** and **data** is the **PixelMap** instance obtained;
       *     otherwise, **err** is an error object.
       * @throws { BusinessError } 5400102 - Operation not allowed. Returned by callback.
       * @throws { BusinessError } 5400106 - Unsupported format. Returned by callback.
       * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
       * @since 20
       */
        fetchFrameByTime(timeUs: long, options: AVImageQueryOptions, param: PixelMapParams, callback: AsyncCallback<image.PixelMap | undefined>): void;
        /**
         * Obtains a video thumbnail. This API uses a promise to return the result.
         * @param { long } timeUs - Time of the video for which a thumbnail is to be obtained, in μs.
         * @param { AVImageQueryOptions } options - Relationship between the time passed in and the video frame.
         * @param { PixelMapParams } param - Format parameters of the thumbnail to be obtained.
         * @returns { Promise<image.PixelMap | undefined> } Promise used to return the video thumbnail.
         * @throws { BusinessError } 5400102 - Operation not allowed. Returned by promise.
         * @throws { BusinessError } 5400106 - Unsupported format. Returned by promise.
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @since 20
         */
        fetchFrameByTime(timeUs: long, options: AVImageQueryOptions, param: PixelMapParams): Promise<image.PixelMap | undefined>;
        /**
         * Releases this **AVImageGenerator** instance. This API uses an asynchronous callback to return the result.
         * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
         * **err** is **undefined**; otherwise, **err** is an error object.
         * @throws { BusinessError } 5400102 - Operation not allowed. Returned by callback.
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @since 20
         */
        release(callback: AsyncCallback<void>): void;
        /**
         * Releases this **AVImageGenerator** instance. This API uses a promise to return the result.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400102 - Operation not allowed. Returned by promise.
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @since 20
         */
        release(): Promise<void>;
    }
    /**
     * Enumerates the relationship between the video frame and the time at which the video thumbnail is obtained.
     *
     * The time passed in for obtaining the thumbnail may be different from the time of the video frame for which
     * the thumbnail is actually obtained. Therefore, you need to specify their relationship.
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
     * @since 20
     */
    enum AVImageQueryOptions {
        /**
         * The key frame at or next to the specified time is selected.
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @since 20
         */
        AV_IMAGE_QUERY_NEXT_SYNC,
        /**
         * The key frame at or prior to the specified time is selected.
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @since 20
         */
        AV_IMAGE_QUERY_PREVIOUS_SYNC,
        /**
         * The key frame closest to the specified time is selected.
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @since 20
         */
        AV_IMAGE_QUERY_CLOSEST_SYNC,
        /**
         * The frame (not necessarily a key frame) closest to the specified time is selected.
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @since 20
         */
        AV_IMAGE_QUERY_CLOSEST
    }
    /**
     * Defines the format parameters of the video thumbnail to be obtained.
     * @typedef PixelMapParams
     * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
     * @since 20
     */
    interface PixelMapParams {
        /**
         * Width of the thumbnail. The value must be greater than 0 and less than or equal to the width of the original
         * video. Otherwise, the returned thumbnail will not be scaled.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @since 20
         */
        width?: int;
        /**
         * Height of the thumbnail. The value must be greater than 0 and less than or equal to the height of the original
         * video. Otherwise, the returned thumbnail will not be scaled.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @since 20
         */
        height?: int;
        /**
         * Color format of the thumbnail.
         *
         * **System API**: This is a system API.
         * @type { ?PixelFormat }
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @systemapi
         * @since 20
         */
        colorFormat?: PixelFormat;
    }
    /**
     * Enumerates the color formats supported by the video thumbnail.
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
     * @systemapi
     * @since 20
     */
    enum PixelFormat {
        /**
         * RGB_565.
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @systemapi
         * @since 20
         */
        RGB_565 = 2,
        /**
         * RGBA_8888.
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @systemapi
         * @since 20
         */
        RGBA_8888 = 3,
        /**
         * RGB_888.
         * @syscap SystemCapability.Multimedia.Media.AVImageGenerator
         * @systemapi
         * @since 20
         */
        RGB_888 = 5
    }
    
    
    /**
     * Enumerates the media error codes, return in BusinessError::code.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum AVErrorCode {
        
        
        /**
         * Operation success.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_OK = 0,
        
        
        /**
         * Permission denied.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_NO_PERMISSION = 201,
        
        
        /**
         * Invalid parameter.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_INVALID_PARAMETER = 401,
        
        
        /**
         * The api is not supported in the current version.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_UNSUPPORT_CAPABILITY = 801,
        
        
        /**
         * The system memory is insufficient or the number of services reaches the upper limit.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_NO_MEMORY = 5400101,
        
        
        /**
         * Current status does not allow or do not have permission to perform this operation.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_OPERATE_NOT_PERMIT = 5400102,
        
        
        /**
         * Data flow exception information.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO = 5400103,
        
        
        /**
         * System or network response timeout.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_TIMEOUT = 5400104,
        
        
        /**
         * Service process died.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_SERVICE_DIED = 5400105,
        
        
        /**
         * Unsupported media format.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_UNSUPPORT_FORMAT = 5400106,
        
        /**
         * Audio interrupted.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_AUDIO_INTERRUPTED = 5400107,
        /**
         * The address of server is incorrect, and IO can not find host.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO_HOST_NOT_FOUND = 5411001,
        /**
         * Network connection timeout.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO_CONNECTION_TIMEOUT = 5411002,
        /**
         * Failed link due to abnormal network.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO_NETWORK_ABNORMAL = 5411003,
        /**
         * Failed link due to unavailable network.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO_NETWORK_UNAVAILABLE = 5411004,
        /**
         * Network permission dennied.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO_NO_PERMISSION = 5411005,
        /**
         * The client request parameters are incorrect or exceed the processing capacity.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO_REQUEST_DENIED = 5411006,
        /**
         * Cannot find available network resources.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO_RESOURCE_NOT_FOUND = 5411007,
        /**
         * The server failS to verify the client certificate because the certificate is not carried,
         * the certificate is invalid, or the certificate is expired.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO_SSL_CLIENT_CERT_NEEDED = 5411008,
        /**
         * The client fails to verify the server certificate because the certificate is not carried,
         * the certificate is invalid, or the certificate is expired.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO_SSL_CONNECTION_FAILED = 5411009,
        /**
         * IO SSL server cert untrusted.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO_SSL_SERVER_CERT_UNTRUSTED = 5411010,
        /**
         * Unsupported request due to network protocols.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_IO_UNSUPPORTED_REQUEST = 5411011,
        /**
         * Seek continuous unsupported.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_SEEK_CONTINUOUS_UNSUPPORTED = 5410002,
        /**
         * Super-resolution unsupported.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_SUPER_RESOLUTION_UNSUPPORTED = 5410003,
        /**
         * No PlaybackStrategy set to enable super-resolution feature.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVERR_SUPER_RESOLUTION_NOT_ENABLED = 5410004
    }
    
    
    /**
     * Enumerates the states of the AVPlayer. Your application can proactively obtain the AVPlayer state through the
     * **state** attribute or obtain the reported AVPlayer state by subscribing to the
     * [stateChange]{@link #stateChange} event.
     * @typedef {'idle' | 'initialized' | 'prepared' | 'playing' | 'paused' | 'completed' | 'stopped' | 'released' | 'error'}
     * @syscap SystemCapability.Multimedia.Media.AVPlayer
     * @since 20
     */
    type AVPlayerState = 'idle' | 'initialized' | 'prepared' | 'playing' | 'paused' | 'completed' | 'stopped' | 'released' | 'error';
    /**
     * Describes the callback invoked for the track change event.
     * @typedef { function } OnTrackChangeHandler
     * @param { int } index - index number for change Track.
     * @param { boolean } isSelected - Status of the track, that is, whether the track is selected.
     * @syscap SystemCapability.Multimedia.Media.AVPlayer
     * @since 20
     */
    type OnTrackChangeHandler = (index: int, isSelected: boolean) => void;
    /**
     * Describes the callback invoked for the AVPlayer state change event.
     *
     * @typedef { function } OnAVPlayerStateChangeHandle
     * @param { AVPlayerState } state - state for AVPlayer.
     * @param { StateChangeReason } reason - reason for state change.
     * @syscap SystemCapability.Multimedia.Media.AVPlayer
     * @since 20
     */
    type OnAVPlayerStateChangeHandle = (state: AVPlayerState, reason: StateChangeReason) => void;
    /**
     * Describes the callback invoked for the buffering update event.
     *
     * @typedef { function } OnBufferingUpdateHandler
     * @param { BufferingInfoType } infoType - define the Buffering info Type.
     * @param { int } value - define the value of buffering info type if exist.
     * @syscap SystemCapability.Multimedia.Media.AVPlayer
     * @since 20
     */
    type OnBufferingUpdateHandler = (infoType: BufferingInfoType, value: int) => void;
    /**
     * Describes the callback invoked for the video size change event.
     *
     * @typedef { function } OnVideoSizeChangeHandler
     * @param { int } width - Value of video Width.
     * @param { int } height - Value of video Height.
     * @syscap SystemCapability.Multimedia.Media.AVPlayer
     * @since 20
     */
    type OnVideoSizeChangeHandler = (width: int, height: int) => void;
    /**
     * Describes the callback used to listen for video super resolution status changes. If super resolution is enabled by
     * using PlaybackStrategy, this callback is invoked to report the super resolution status changes. It is also invoked
     * to report the initial status when the video starts. However, this callback is not invoked when super resolution is
     * not enabled.
     *
     * Super resolution is automatically disabled in either of the following cases:
     *
     * 1.The current super resolution algorithm only works with videos that have a frame rate of 30 fps or lower. If the
     * video frame rate exceeds 30 fps, or if the input frame rate exceeds the processing capability of the super
     * resolution algorithm in scenarios such as fast playback, super resolution is automatically disabled.
     *
     * 2.The current super resolution algorithm supports input resolutions from 320 x 320 to 1920 x 1080, in px. If the
     * input video resolution exceeds the range during playback, super resolution is automatically disabled.
     *
     * @typedef { function } OnSuperResolutionChanged
     * @param { boolean } enabled - Whether super resolution is enabled. The value **true** means that it is enabled,
     * and **false** means the opposite.
     * @syscap SystemCapability.Multimedia.Media.AVPlayer
     * @since 20
     */
    type OnSuperResolutionChanged = (enabled: boolean) => void;
    /**
     * Describes the information of an SEI message.
     *
     * @typedef SeiMessage
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    interface SeiMessage {
        /**
         * Payload type of SEI message.
         * @type { int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        payloadType: int;
        /**
         * Payload data of SEI message.
         * @type { ArrayBuffer }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        payload: ArrayBuffer;
    }
    /**
     * Describes the handle used to obtain SEI messages. This is used when in subscriptions to SEI message events,
     * and the callback returns detailed SEI information.
     *
     * @typedef { function } OnSeiMessageHandle
     * @param { Array<SeiMessage> } messages - SEI messages.
     * @param { ?int } [playbackPosition] - playback position.
     * @syscap SystemCapability.Multimedia.Media.AVPlayer
     * @since 20
     */
    type OnSeiMessageHandle = (messages: Array<SeiMessage>, playbackPosition?: int) => void;
    
    
    /**
     * Manages and plays media. Before calling an AVPlayer method, you must use createAVPlayer()
     * to create an **AVPlayer** instance.
     * <br>For details about the audio and video playback demo, see Audio Playback and Video Playback.
     * <br>**NOTE:**<br>
     * When using the **AVPlayer** instance, you are advised to register the following callbacks to proactively
     * obtain status changes:
     *
     * on('stateChange'): listens for AVPlayer state changes.
     *
     * on('error'): listens for error events.
     *
     * @typedef AVPlayer
     * @syscap SystemCapability.Multimedia.Media.AVPlayer
     * @since 20
     */
    interface AVPlayer {
        
        
        /**
         * Prepare audio/video playback, it will request resource for playing. This API can be called only
         * when the AVPlayer is in the initialized state.
         *
         * <p>If your application frequently switches between short videos, you can create multiple AVPlayer
         * objects to prepare the next video in advance, thereby improving the switching performance.
         * For details, see [Smooth Switchover Between Online Short Videos]{@link
         * https://developer.huawei.com/consumer/en/doc/best-practices/bpta-smooth-switching}.</p>
         *
         * @param { AsyncCallback<void> } callback used to return the result when prepare completed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @throws { BusinessError } 5400106 - Unsupported format. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        prepare(callback: AsyncCallback<void>): void;
        
        
        /**
         * Prepare audio/video playback, it will request resource for playing. This API can be called
         * only when the AVPlayer is in the initialized state.
         *
         * <p>If your application frequently switches between short videos, you can create multiple AVPlayer
         * objects to prepare the next video in advance, thereby improving the switching performance.
         * For details, see [Smooth Switchover Between Online Short Videos]{@link
         * https://developer.huawei.com/consumer/en/doc/best-practices/bpta-smooth-switching}.</p>
         *
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400106 - Unsupported format. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        prepare(): Promise<void>;
        
        
        /**
         * Play audio/video playback. This API can be called only when the AVPlayer is in the prepared, paused or completed state.
         * @param { AsyncCallback<void> } callback used to return the result when play completed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        play(callback: AsyncCallback<void>): void;
        
        
        /**
         * Play audio/video playback. This API can be called only when the AVPlayer is in the prepared, paused or completed state.
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        play(): Promise<void>;
        
        
        /**
         * Pause audio/video playback. This API can be called only when the AVPlayer is in the playing state.
         * @param { AsyncCallback<void> } callback used to return the result when pause completed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        pause(callback: AsyncCallback<void>): void;
        
        
        /**
         * Pause audio/video playback. This API can be called only when the AVPlayer is in the playing state.
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        pause(): Promise<void>;
        
        
        /**
         * Stop audio/video playback. This API can be called only when the AVPlayer is in the prepared,
         * playing, paused or completed state.
         * @param { AsyncCallback<void> } callback used to return the result when stop completed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        stop(callback: AsyncCallback<void>): void;
        
        
        /**
         * Stop audio/video playback. This API can be called only when the AVPlayer is in the prepared,
         * playing, paused or completed state.
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        stop(): Promise<void>;
        
        
        /**
         * Reset AVPlayer, it will be set to idle state and can set src again. This API can be called only when
         * the AVPlayer is in the initialized, prepared, playing, paused, completed, stopped or error state.
         * @param { AsyncCallback<void> } callback used to return the result when reset completed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        reset(callback: AsyncCallback<void>): void;
        
        
        /**
         * Reset AVPlayer, it will be set to idle state and can set src again. This API can be called only when
         * the AVPlayer is in the initialized, prepared, playing, paused, completed, stopped or error state.
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        reset(): Promise<void>;
        
        
        /**
         * Releases resources used for AVPlayer. This API can be called when the AVPlayer is in any state except released.
         * @param { AsyncCallback<void> } callback used to return the result when release completed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        release(callback: AsyncCallback<void>): void;
        
        
        /**
         * Releases resources used for AVPlayer. This API can be called when the AVPlayer is in any state except released.
         * @returns { Promise<void> } A Promise instance used to return the operation result.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        release(): Promise<void>;
        
        
        /**
         * Jumps to the specified playback position. This API can be called only when the AVPlayer is in the prepared,
         * playing, paused, or completed state.
         * You can check whether the seek operation takes effect by subscribing to the [seekDone]{@link #seekDone} event.
         * This API is not supported in live mode.
         * @param { int } timeMs - Playback position to jump, should be in [0, duration]. In SEEK_CONTINUOU mode,
         * the value -1 can be used to indicate the end of SEEK_CONTINUOUS mode.
         * @param { SeekMode } mode - See @SeekMode . The default value is **SEEK_PREV_SYNC**.
         * Set this parameter only for video playback.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        seek(timeMs: int, mode?: SeekMode): void;
        
        /**
         * Sets the volume. This API can be called only when the AVPlayer is in the prepared, playing,
         * paused, or completed state.
         * You can check whether the setting takes effect by subscribing to the volumeChange event.
         * @param { double } volume - Relative volume. The value ranges from 0.00 to 1.00.
         * The value **1.00** indicates the maximum volume (100%).
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        setVolume(volume: double): void;
        
        
        /**
         * Obtains the audio and video track information. This API can be called only when the AVPlayer is in the prepared,
         * playing, or paused state. To obtain information about all audio and video tracks, this API must be called after
         * the data loading callback is triggered. This API uses an asynchronous callback to return the result.
         * @param { AsyncCallback<Array<MediaDescription>> } callback - Async callback return track info in MediaDescription.
         * If the operation is successful, err is undefined and data is the MediaDescription array obtained;
         * otherwise, err is an error object.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        getTrackDescription(callback: AsyncCallback<Array<MediaDescription>>): void;
        
        
        /**
         * Obtains the audio and video track information. This API can be called only when the AVPlayer is in the prepared,
         * playing, or paused state. This API uses a promise to return the result.
         * @returns { Promise<Array<MediaDescription>> } A Promise instance used to return the track info in MediaDescription.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        getTrackDescription(): Promise<Array<MediaDescription>>;
        /**
         * Obtains the indexes of the selected audio or video tracks. This API can be called only when the AVPlayer
         * is in the prepared, playing, or paused state. This API uses a promise to return the result.
         * @returns { Promise<Array<int>> } A Promise instance used to return selected track index.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        getSelectedTracks(): Promise<Array<int>>;
        /**
         * Selects a track when the AVPlayer is used to play a resource with multiple audio and video tracks.
         * This API uses a promise to return the result.
         * @param { int } index - Track index returned by getTrackDescription#MD_KEY_TRACK_INDEX
         * @param { SwitchMode } mode - set switchmode for track select behavior. The default mode is SMOOTH.
         * This parameter takes effect only for the switch of a video track for DASH streams.
         * @returns { Promise<void> } A Promise instance used to return when select track completed.
         * @throws { BusinessError } 401 - The parameter check failed. Return by promise.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        selectTrack(index: int, mode?: SwitchMode): Promise<void>;
        /**
         * Deselects a track when the AVPlayer is used to play a resource with multiple audio and video tracks.
         * This API uses a promise to return the result.
         * @param { int } index : Track index returned by getTrackDescription#MD_KEY_TRACK_INDEX
         * @returns { Promise<void> } A Promise instance used to return when deselect track completed.
         * @throws { BusinessError } 401 - The parameter check failed. Return by promise.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        deselectTrack(index: int): Promise<void>;
        /**
         * Sets a source of streaming media that can be pre-downloaded, downloads the media data, and temporarily stores
         * the data in the memory. For details about how to use the API, see Video Playback This API uses a promise to
         * return the result.
         * @param { MediaSource } src : Source of the streaming media to pre-download.
         * @param { PlaybackStrategy } strategy : strategy for playing the pre-downloaded streaming media.
         * @returns { Promise<void> } A Promise instance used to return when setMediaSource completed.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        setMediaSource(src: MediaSource, strategy?: PlaybackStrategy): Promise<void>;
        /**
         * Add subtitle resource represented by FD to the player. Currently, the external subtitle must be set after
         * fdSrc of the video resource is set in an AVPlayer instance. This API uses a promise to return the result.
         * @param { int } fd : The file descriptor of subtitle source from file system, which is obtained by
         * calling resourceManager.getRawFd.
         * The caller is responsible to close the file descriptor.
         * @param { long } offset : The offset into the file where the data to be read, in bytes.
         * By default, the offset is zero.
         * @param { long } length : The length in bytes of the data to be read.
         * By default, the length is the rest of bytes in the file from the offset.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 401 - The parameter check failed. Return by promise.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        addSubtitleFromFd(fd: int, offset?: long, length?: long): Promise<void>;
        /**
         * Add subtitle resource represented by url to the player. Currently, the external subtitle must be set
         * after fdSrc of the video resource is set in an AVPlayer instance. After the Promise returns,
         * subtitle info can be obtained by @getTrackDescription
         * @param { string } url : Address of external subtitle file.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 401 - The parameter check failed. Return by promise.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        addSubtitleFromUrl(url: string): Promise<void>;
        /**
         * Get statistic infos of current player. This API can be called only when the AVPlayer is in the prepared,
         * playing, or paused state.
         * @returns { Promise<PlaybackInfo> } Statistic infos of current player.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        getPlaybackInfo(): Promise<PlaybackInfo>;
        /**
         * Set playback strategy to AVPlayer. This API can be called only when the AVPlayer is in the initialized state.
         * @param { PlaybackStrategy } strategy : specified strategy of the AVPlayer.
         * @returns { Promise<void> }  A Promise instance used to return when setPlaybackStrategy completed.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Incorrect parameter types. 2. Parameter verification failed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        setPlaybackStrategy(strategy: PlaybackStrategy): Promise<void>;
        /**
         * Mute specified media stream. This API can be called only when the AVPlayer is in the prepared, playing,
         * paused, or completed state.
         * @param { MediaType } mediaType - specified media Type, see [MediaType]{@link #MediaType}.
         * @param { boolean } muted - true for mute, false for unmute.
         * @returns { Promise<void> } A Promise instance used to return when setMediaMuted completed.
         * @throws { BusinessError } 401 - The parameter check failed. Return by promise.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        setMediaMuted(mediaType: MediaType, muted: boolean): Promise<void>;
        /**
         * Set playback start position and end position. After the setting, only the content in the specified range of
         * the audio or video file is played. This API uses a promise to return the result. It can be used in the
         * initialized, prepared, paused, stopped, or completed state.
         * @param { int } startTimeMs - Playback start position, should be in [0, duration),
         *                                 -1 means that the start position is not set,
         *                                 and the playback will start from 0.
         * @param { int } endTimeMs - Playback end position, which should usually be in (startTimeMs, duration],
         *                               -1 means that the end position is not set,
         *                               and the playback will be ended at the end of the stream.
         * @param { SeekMode } [mode] - Use the specified seek mode to jump to the playback start position,
         *                             currently support SeekMode.SEEK_PREV_SYNC and SeekMode.SEEK_CLOSEST,
         *                             other values are invalid, the default value is SeekMode.SEEK_PREV_SYNC.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 401 - The parameter check failed. Return by promise.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        setPlaybackRange(startTimeMs: int, endTimeMs: int, mode?: SeekMode): Promise<void>;
        /**
         * Checks whether the media source supports seek in SEEK_CONTINUOUS mode ([SeekMode]{@link #SeekMode}).
         * The actual value is returned when this API is called in the prepared, playing, paused, or completed state.
         * The value **false** is returned if it is called in other states. For devices that do not support the seek
         * operation in SEEK_CONTINUOUS mode, false is returned.
         * Should be called after {@link #prepare}.
         * @returns { boolean } true: seek continuous is supported;
         * false: seek continuous is not supported or the support status is uncertain.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        isSeekContinuousSupported(): boolean;
        /**
         * Get current playback position. This API can be used in the prepared, playing, paused, or completed state.
         * @returns { int } return the time of current playback position - millisecond(ms)
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        getPlaybackPosition(): int;
        /**
         * Enable or disable super-resolution dynamically. This API can be called when the AVPlayer is in the
         * initialized, prepared, playing, paused, completed, or stopped state.
         * Must enable super-resolution feature in {@link PlaybackStrategy} before calling {@link #prepare}.
         * See {@link #setPlaybackStrategy}, {@link #setMediaSource}.
         * @param { boolean } enabled - true: super-resolution enabled; false: super-resolution disabled.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5410003 - Super-resolution not supported. Return by promise.
         * @throws { BusinessError } 5410004 - Missing enable super-resolution feature in {@link PlaybackStrategy}.
         *                                     Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        setSuperResolution(enabled: boolean): Promise<void>;
        /**
         * Set video window size for super-resolution. This API can be called when the AVPlayer is in the initialized,
         * prepared, playing, paused, completed, or stopped state. The input parameter values s must be in the range
         * of 320 x 320 to 1920 x 1080 (in px).
         *
         * Must enable super-resolution feature in {@link PlaybackStrategy} before calling {@link #prepare}.
         * See {@link #setPlaybackStrategy}, {@link #setMediaSource}.
         * @param { int } width - width of the window. The value range is [320-1920], in px.
         * @param { int } height - height of the window. The value range is [320-1080], in px.
         * @returns { Promise<void> } Promise used to return the result.
         * @throws { BusinessError } 401 - Parameter error. Return by promise.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5410003 - Super-resolution not supported. Return by promise.
         * @throws { BusinessError } 5410004 - Missing enable super-resolution feature in {@link PlaybackStrategy}.
         *                                     Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        setVideoWindowSize(width: int, height: int): Promise<void>;
        
        
        /**
         * Media URI. It can be set only when the AVPlayer is in the idle state.
         * The video formats MP4, MPEG-TS, and MKV are supported.
         * The audio formats M4A, AAC, MP3, OGG, WAV, FLAC, and AMR are supported.
         *
         * <br>**NOTE:**<br>
         * To set a network playback path, you must declare the ohos.permission.INTERNET permission by following the
         * instructions provided in Declaring Permissions. The error code 201 may be reported.
         *
         * WebM is no longer supported since API version 11.
         *
         * After the resource handle (FD) is transferred to an **AVPlayer** instance, do not use the resource handle to
         * perform other read and write operations, including but not limited to transferring this handle to other
         * **AVPlayer**, **AVMetadataExtractor**, **AVImageGenerator**, or **AVTranscoder** instance. Competition
         * occurs when multiple AVPlayers use the same resource handle to read and write files at the same time,
         * resulting in errors in obtaining data.
         *
         * Network:http://xxx
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        url?: string;
        
        
        /**
         * Media file descriptor. It can be set only when the AVPlayer is in the idle state.
         * This attribute is required when media assets of an application are continuously stored in a file.
         * The video formats MP4, MPEG-TS, and MKV are supported.
         * The audio formats M4A, AAC, MP3, OGG, WAV, FLAC, and AMR are supported.
         *
         * <br>**NOTE:**<br>
         * WebM is no longer supported since API version 11.
         *
         * @type { ?AVFileDescriptor }
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        fdSrc?: AVFileDescriptor;
        
        
        /**
         * DataSource descriptor. It can be set only when the AVPlayer is in the idle state. Use scenario: An application
         * starts playing a media file while the file is still being downloaded from the remote to the local host.
         * The video formats MP4, MPEG-TS, and MKV are supported.
         * The audio formats M4A, AAC, MP3, OGG, WAV, FLAC, and AMR are supported.
         * @type { ?AVDataSrcDescriptor }
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        dataSrc?: AVDataSrcDescriptor;
        
        /**
         * Whether to loop media playback. The value true means to loop playback, and false (default) means the opposite.
         * It is a dynamic attribute and can be set only when the AVPlayer is in the prepared, playing, paused,
         * or completed state. This setting is not supported in live mode.
         * @type { boolean }
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        loop: boolean;
        
        /**
         * Describes audio interrupt mode. If it is not set, the default mode will be used. The default value is
         * **SHARE_MODE**. It is a dynamic attribute and can be set only when the AVPlayer is in the prepared,
         * playing, paused, or completed state. Set it before calling the {@link #play()} in the first time in order
         * for the interrupt mode to become effective thereafter.
         * @type { ?audio.InterruptMode }
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        audioInterruptMode?: audio.InterruptMode;
        
        /**
         * Describes audio renderer info. If the media source contains videos, the default value of usage is
         * **STREAM_USAGE_MOVIE**. Otherwise, the default value of usage is **STREAM_USAGE_MUSIC**. This parameter can
         * be set only when the AVPlayer is in the initialized state.
         * Set it before calling the {@link #prepare()} in the first time in order for the audio renderer info to
         * become effective thereafter.
         * @type { ?audio.AudioRendererInfo }
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        audioRendererInfo?: audio.AudioRendererInfo;
        
        /**
         * Obtains the current audio effect mode. The audio effect mode is a dynamic attribute and is restored
         * to the default value **EFFECT_DEFAULT** when usage of audioRendererInfo is changed.
         * It can be set only when the AVPlayer is in the prepared, playing, paused, or completed state.
         * @type { ?audio.AudioEffectMode }
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        audioEffectMode?: audio.AudioEffectMode;
        
        /**
         * Current playback position, in ms. It can be used as a query parameter when the AVPlayer is in the prepared,
         * playing, paused, or completed state. The value -1 indicates an invalid value.
         * In live mode, -1 is returned by default.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        readonly currentTime: int;
        
        
        /**
         * Playback duration, in ms. It can be used as a query parameter when the AVPlayer is in the prepared,
         * playing, paused, or completed state.
         * When the data source does not support seek, it returns - 1, such as a live broadcast scenario.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        readonly duration: int;
        
        /**
         * Playback state. It can be used as a query parameter when the AVPlayer is in any state.
         * @type { AVPlayerState }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        readonly state: AVPlayerState;
        
        
        /**
         * Video player will use this id get a surface instance. This parameter can be set when the AVPlayer
         * is in the initialized state. It can be set again when the AVPlayer is in the prepared, playing, paused,
         * completed, or stopped state, in the prerequisite that the video window ID has been set in the initialized state.
         * After the new setting is performed, the video is played in the new window. It is used to render the window
         * for video playback and therefore is not required in audio-only playback scenarios.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        surfaceId?: string;
        
        /**
         * Video width, in px, valid after prepared. It can be used as a query parameter when the AVPlayer is in the
         * prepared, playing, paused, or completed state.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        readonly width: int;
        
        /**
         * Video height, in px, valid after prepared. It can be used as a query parameter when the AVPlayer is in the
         * prepared, playing, paused, or completed state.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        readonly height: int;
        
        /**
         * Video scale type. By default, the {@link #VIDEO_SCALE_TYPE_FIT} will be used, for more
         * information, refer to {@link #VideoScaleType} .
         * @type { ?VideoScaleType }
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        videoScaleType?: VideoScaleType;
        
        /**
         * Set payback speed. This API can be called only when the AVPlayer is in the prepared, playing, paused,
         * or completed state. You can check whether the setting takes effect by subscribing to the speedDone event.
         * This API is not supported in live mode.
         * @param { PlaybackSpeed } speed - playback speed, see @PlaybackSpeed .
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        setSpeed(speed: PlaybackSpeed): void;
        
        /**
         * Select a specified bitrate to playback, only valid for HLS protocol network stream. By default, the
         * player will select the appropriate bitrate according to the network connection speed. The
         * available bitrate list reported by {@link #on('availableBitrates')}. Set it to select
         * a specified bitrate. If the specified bitrate is not in the list of available bitrate, the player
         * will select the minimal and closest one from the available bitrate list.This API can be called
         * only when the AVPlayer is in the prepared, playing, paused, or completed state.
         * @param { int } bitrate - 	Bit rate to set. Obtain the available bit rates of the current HLS/DASH
         * stream by subscribing to the {@link #on('availableBitrates')} event. If the bit rate to set is not in
         * the list of the available bit rates, the AVPlayer selects from the list the bit rate that is closed
         * to the bit rate to set. If the length of the available bit rate list obtained through the event is 0,
         * no bit rate can be set and the bitrateDone callback will not be triggered.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        setBitrate(bitrate: int): void;
        
        /**
         * Set decryption session to codec module. When receiving a mediaKeySystemInfoUpdate event, create the related
         * configuration and set the decryption configuration based on the information in the reported event.
         * Otherwise, the playback fails.
         * @param { drm.MediaKeySession } mediaKeySession - Handle of MediaKeySession to decrypt encrypted media.
         * @param { boolean } secureVideoPath - Secure video path required or not. The value true means that a secure
         * video channel is selected, and false means that a non-secure video channel is selected.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        setDecryptionConfig(mediaKeySession: drm.MediaKeySession, secureVideoPath: boolean): void;
        
        /**
         * Get media key system info from media source.
         * @returns { Array<drm.MediaKeySystemInfo> } MediaKeySystemInfo with PSSH.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        getMediaKeySystemInfos(): Array<drm.MediaKeySystemInfo>;
        
        /**
         * Register listens for mediaKeySystemInfoUpdate events.
         * @param { 'mediaKeySystemInfoUpdate' } type - Event type, which is **'mediaKeySystemInfoUpdate'** in this case.
         * This event is triggered when the copyright protection information of the media asset being played changes.
         * @param { Callback<Array<drm.MediaKeySystemInfo>> } callback - Callback invoked when the event is triggered.
         * It reports a **MediaKeySystemInfo** array.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'mediaKeySystemInfoUpdate', callback: Callback<Array<drm.MediaKeySystemInfo>>): void;
        
        /**
         * Unregister listens for mediaKeySystemInfoUpdate events.
         * @param { 'mediaKeySystemInfoUpdate' } type - Type of the event to listen for.
         * @param { Callback<Array<drm.MediaKeySystemInfo>> } callback - Callback for event.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'mediaKeySystemInfoUpdate', callback?: Callback<Array<drm.MediaKeySystemInfo>>): void;
        
        
        /**
         * Register listens for media playback stateChange event.
         * @param { 'stateChange' } type - Event type, which is **'stateChange'** in this case.
         * This event can be triggered by both user operations and the system.
         * @param { OnAVPlayerStateChangeHandle } callback - Callback invoked when the event is triggered.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'stateChange', callback: OnAVPlayerStateChangeHandle): void;
        
        
        /**
         * Unregister listens for media playback stateChange event.
         * @param { 'stateChange' } type - Type of the playback event to listen for.
         * @param { OnAVPlayerStateChangeHandle } callback - Callback invoked when the event is triggered.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'stateChange', callback?: OnAVPlayerStateChangeHandle): void;
        
        /**
         * Subscribes to the event to check whether the volume is successfully set.
         * @param { 'volumeChange' } type - This event is triggered each time **setVolume()** is called.
         * @param { Callback<double> } callback - Callback invoked when the event is triggered.
         * It reports the effective volume.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'volumeChange', callback: Callback<double>): void;
        
        
        /**
         * Unsubscribes from the event that checks whether the volume is successfully set.
         * @param { 'volumeChange' } type - Type of the playback event to listen for.
         * @param { Callback<double> } callback - Callback invoked when the event is triggered.
         * It reports the effective volume.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'volumeChange', callback?: Callback<double>): void;
        
        /**
         * Subscribes to the event that indicates the end of the stream being played. If {@link #loop} = true is set,
         * the AVPlayer seeks to the beginning of the stream and plays the stream again. If loop is not set,
         * the completed state is reported through the {@link #stateChange} event.
         * @param { 'endOfStream' } type - Type of the playback event to listen for. This event is triggered
         * when the AVPlayer finishes playing the media asset.
         * @param { Callback<void> } callback - Callback invoked when the event is triggered.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'endOfStream', callback: Callback<void>): void;
        
        
        /**
         * Unregister listens for media playback endOfStream event.
         * @param { 'endOfStream' } type - Type of the playback event to listen for.
         * @param { Callback<void> } [callback] - Callback used to listen for the playback end of stream.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'endOfStream', callback?: Callback<void>): void;
        
        
        /**
         * Subscribes to the event to check whether the seek operation takes effect.
         * @param { 'seekDone' } type - Type of the playback event to listen for. This event is triggered each time
         * **seek()** is called, except in SEEK_CONTINUOUS mode.
         * @param { Callback<int> } callback - Callback invoked when the event is triggered.
         * It reports the time position requested by the user.
         *
         * For video playback, {@link #SeekMode} may cause the actual position to be different from that requested by
         * the user.The exact position can be obtained from the currentTime attribute. The time in this callback
         * only means that the requested seek operation is complete.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'seekDone', callback: Callback<int>): void;
        
        
        /**
         * Unsubscribes from the event that checks whether the seek operation takes effect.
         * @param { 'seekDone' } type - Type of the playback event to listen for.
         * @param { Callback<int> } callback - Callback invoked when the event is triggered.
         * It reports the time position requested by the user.
         *
         * For video playback, SeekMode may cause the actual position to be different from that requested by the user.
         * The exact position can be obtained from the currentTime attribute. The time in this callback only means
         * that the requested seek operation is complete.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'seekDone', callback?: Callback<int>): void;
        
        /**
         * Subscribes to the event to check whether the playback speed is successfully set.
         * @param { 'speedDone' } type - Type of the playback event to listen for.
         * This event is triggered each time **setSpeed()** is called.
         * @param { Callback<int> } callback - Callback used to return the result. When the call of
         * setSpeed is successful, the effective speed mode is reported. For details, see {@link #PlaybackSpeed}.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'speedDone', callback: Callback<int>): void;
        
        
        /**
         * Unsubscribes from the event that checks whether the playback speed is successfully set.
         * @param { 'speedDone' } type - Type of the playback event to listen for.
         * @param { Callback<int> } callback - Callback used to return the result. When the call of
         * setSpeed is successful, the effective speed mode is reported. For details, see {@link #PlaybackSpeed}.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'speedDone', callback?: Callback<int>): void;
        
        /**
         * Subscribes to the event to check whether the bit rate is successfully set.
         * @param { 'bitrateDone' } type - Type of the playback event to listen for.
         * This event is triggered each time **setBitrate()** is called.
         * @param { Callback<int> } callback - Callback invoked when the event is triggered.
         * It reports the effective bit rate.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'bitrateDone', callback: Callback<int>): void;
        
        
        /**
         * Unsubscribes from the event that checks whether the bit rate is successfully set.
         * @param { 'bitrateDone' } type - Type of the playback event to listen for.
         * @param { Callback<int> } callback - Callback invoked when the event is triggered.
         * It reports the effective bit rate.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'bitrateDone', callback?: Callback<int>): void;
        
        
        /**
         * Subscribes to playback position changes. It is used to refresh the current position of the progress bar.
         * By default, this event is reported every 100 ms. However, it is reported immediately upon
         * a successful seek operation.
         * @param { 'timeUpdate' } type - Type of the playback event to listen for.
         * @param { Callback<int> } callback - Callback used to return the current time.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'timeUpdate', callback: Callback<int>): void;
        
        
        /**
         * Unsubscribes from playback position changes.
         * @param { 'timeUpdate' } type - Type of the playback event to listen for.
         * @param { Callback<int> } callback - Callback used to return the current time.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'timeUpdate', callback?: Callback<int>): void;
        
        /**
         * Subscribes to media asset duration changes. It is used to refresh the length of the progress bar. By
         * default, this event is reported once in the prepared state. However, it can be repeatedly reported for
         * special streams that trigger duration changes. The **'durationUpdate'** event is not supported in live mode.
         * @param { 'durationUpdate' } type - Type of the playback event to listen for.
         * @param { Callback<int> } callback - Callback used to return the resource duration.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'durationUpdate', callback: Callback<int>): void;
        
        
        /**
         * Unsubscribes from media asset duration changes.
         * @param { 'durationUpdate' } type - Type of the playback event to listen for.
         * @param { Callback<int> } callback - Callback used to return the resource duration.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'durationUpdate', callback?: Callback<int>): void;
        
        /**
         * Subscribes to audio and video buffer changes. This subscription is supported only in network
         * playback scenarios.
         * @param { 'bufferingUpdate' } type - Type of the playback buffering update event to listen for.
         * @param { OnBufferingUpdateHandler } callback - Callback invoked when the event is triggered,
           * and return BufferingInfoType and the value.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'bufferingUpdate', callback: OnBufferingUpdateHandler): void;
        
        /**
         * Unsubscribes from audio and video buffer changes.
         * @param { 'bufferingUpdate' } type - Type of the playback buffering update event to listen for.
         * @param { OnBufferingUpdateHandler } callback - Callback invoked when the event is triggered.,
           * and return BufferingInfoType and the value.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'bufferingUpdate', callback?: OnBufferingUpdateHandler): void;
        
        /**
         * Subscribes to the event that indicates rendering starts for the first frame. This subscription is
         * supported only in video playback scenarios. This event only means that the playback service sends
         * the first frame to the display module. The actual rendering effect depends on the rendering performance
         * of the display service.
         * @param { 'startRenderFrame' } type - Type of the playback event to listen for.
         * @param { Callback<void> } callback - Callback invoked when the event is triggered.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'startRenderFrame', callback: Callback<void>): void;
        
        
        /**
         * Unregister listens for start render video frame events.
         * @param { 'startRenderFrame' } type - Type of the playback event to listen for.
         * @param { Callback<void> } [callback] - Callback used to listen for the playback event return .
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'startRenderFrame', callback?: Callback<void>): void;
        
        /**
         * Subscribes to video size (width and height) changes. This subscription is supported only in video playback
         * scenarios. By default, this event is reported only once in the prepared state. However, it is also reported
         * upon resolution changes in the case of HLS streams.
         * @param { 'videoSizeChange' } type - Type of the playback event to listen for.
         * @param { OnVideoSizeChangeHandler } callback - Callback invoked when the event is triggered.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'videoSizeChange', callback: OnVideoSizeChangeHandler): void;
        
        /**
         * Unsubscribes from video size changes.
         * @param { 'videoSizeChange' } type - Type of the playback event to listen for.
         * @param { OnVideoSizeChangeHandler } callback - Callback invoked when the event is triggered.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'videoSizeChange', callback?: OnVideoSizeChangeHandler): void;
        
        /**
         * Register listens for audio interrupt event, refer to {@link #audio.InterruptEvent}.
         * The application needs to perform corresponding processing based on different audio interruption events.
         * For details, see Handling Audio Interruption Events.
         * @param { 'audioInterrupt' } type - Type of the playback event to listen for.
         * @param { Callback<audio.InterruptEvent> } callback - Callback used to listen for the playback event return audio interrupt info.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'audioInterrupt', callback: Callback<audio.InterruptEvent>): void;
        
        /**
         * Unregister listens for audio interrupt event, refer to {@link #audio.InterruptEvent}
         * @param { 'audioInterrupt' } type - Type of the playback event to listen for.
         * @param { Callback<audio.InterruptEvent> } callback - Callback used to listen for the playback event return audio interrupt info.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'audioInterrupt', callback?: Callback<audio.InterruptEvent>): void;
        
        /**
         * Register listens for available bitrate list collect completed events for HLS protocol stream playback.
         * This event will be reported after the {@link #prepare} called.
         * @param { 'availableBitrates' } type - Type of the playback event to listen for.
         * This event is triggered once after the AVPlayer switches to the prepared state.
         * @param { Callback<Array<int>> } callback - Callback used to listen for the playback event return available bitrate list.
         * It returns an array that holds the available bit rates. If the array length is 0, no bit rate can be set.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'availableBitrates', callback: Callback<Array<int>>): void;
        
        /**
         * Unregister listens for available bitrate list collect completed events for HLS protocol stream playback.
         * This event will be reported after the {@link #prepare} called.
         * @param { 'availableBitrates' } type - Type of the playback event to listen for.
         * @param { Callback<Array<int>> } callback - Callback used to listen for the playback event return available bitrate list.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'availableBitrates', callback?: Callback<Array<int>>): void;
        
        
        
        /**
         * Subscribes to AVPlayer errors. This event is used only for error prompt and does not require the user to stop
         * playback control. If AVPlayerState is also switched to error, call {@link #reset()} or {@link #release()}
         * to exit the playback.
         * @param { 'error' } type - Event type, which is **'error'** in this case. This event can be triggered by
         * both user operations and the system.
         * @param { ErrorCallback } callback - Callback used to listen for the playback error event.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - The parameter check failed.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 5400101 - No memory.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @throws { BusinessError } 5400104 - Time out.
         * @throws { BusinessError } 5400105 - Service died.
         * @throws { BusinessError } 5400106 - Unsupported format.
         * @throws { BusinessError } 5411001 - IO can not find host.
         * @throws { BusinessError } 5411002 - IO connection timeout.
         * @throws { BusinessError } 5411003 - IO network abnormal.
         * @throws { BusinessError } 5411004 - IO network unavailable.
         * @throws { BusinessError } 5411005 - IO no permission.
         * @throws { BusinessError } 5411006 - IO request denied.
         * @throws { BusinessError } 5411007 - IO resource not found.
         * @throws { BusinessError } 5411008 - IO SSL client cert needed.
         * @throws { BusinessError } 5411009 - IO SSL connect fail.
         * @throws { BusinessError } 5411010 - IO SSL server cert untrusted.
         * @throws { BusinessError } 5411011 - IO unsupported request.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'error', callback: ErrorCallback): void;
        
        
        /**
         * Unsubscribes from AVPlayer errors.
         * @param { 'error' } type - Event type, which is **'error'** in this case.
         * @param { ErrorCallback } callback - Callback used to return the error code ID and error message.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'error', callback?: ErrorCallback): void;
        
        /**
         * Subscribes to audio stream output device changes and reasons. This API uses an asynchronous callback
         * to return the result.
         *
         * When subscribing to this event, you are advised to implement the player behavior when the device is
         * connected or disconnected by referring to Responding to Audio Output Device Changes.
         * @param { 'audioOutputDeviceChangeWithInfo' } type - Type of the event to listen for.
         * The event is triggered when the output device is changed.
         * @param { Callback<audio.AudioStreamDeviceChangeInfo> } callback - Callback used to return the output device
         * descriptor of the current audio stream and the change reason.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'audioOutputDeviceChangeWithInfo', callback: Callback<audio.AudioStreamDeviceChangeInfo>): void;
        
        /**
         * Unsubscribes from audio stream output device changes and reasons. This API uses an asynchronous callback
         * to return the result.
         * @param { 'audioOutputDeviceChangeWithInfo' } type - Type of the event to listen for.
         * @param { Callback<audio.AudioStreamDeviceChangeInfo> } callback - Callback used to return the output device
         * descriptor of the current audio stream and the change reason.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'audioOutputDeviceChangeWithInfo', callback?: Callback<audio.AudioStreamDeviceChangeInfo>): void;
        /**
         * Subscribes to subtitle update events. When external subtitles exist, the system notifies the application
         * through the subscribed-to callback. An application can subscribe to only one subtitle update event. When
         * the application initiates multiple subscriptions to this event, the last subscription is applied.
         * @param { 'subtitleUpdate' } type - Type of the event to listen for.
         * The event is triggered when the external subtitle is updated.
         * @param { Callback<SubtitleInfo> } callback - Callback invoked when the subtitle is updated.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'subtitleUpdate', callback: Callback<SubtitleInfo>): void;
        /**
         * Unsubscribes from subtitle update events.
         * @param { 'subtitleUpdate' } type - Type of the event to listen for.
         * @param { Callback<SubtitleInfo> } callback - Callback that has been registered to listen for subtitle
         * update events.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'subtitleUpdate', callback?: Callback<SubtitleInfo>): void;
        /**
         * Subscribes to track change events. When the track changes, the system notifies the application through
         * the subscribed-to callback. An application can subscribe to only one track change event. When the
         * application initiates multiple subscriptions to this event, the last subscription is applied.
         * @param { 'trackChange' } type - Type of the event to listen for.
         * The event is triggered when the track changes.
         * @param { OnTrackChangeHandler } callback - Callback invoked when the event is triggered.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'trackChange', callback: OnTrackChangeHandler): void;
        /**
         * Unsubscribes from track change events.
         * @param { 'trackChange' } type - Type of the event to listen for.
         * The event is triggered when the track changes.
         * @param { OnTrackChangeHandler } callback - Callback that has been registered to listen for track changes.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'trackChange', callback?: OnTrackChangeHandler): void;
        /**
         * Subscribes to track information update events. When the track information is updated, the system notifies the
         * application through the subscribed-to callback. An application can subscribe to only one track change event.
         * When the application initiates multiple subscriptions to this event, the last subscription is applied.
         * @param { 'trackInfoUpdate' } type - Type of the event to listen for.
         * The event is triggered when the track information is updated.
         * @param { Callback<Array<MediaDescription>> } callback - Callback invoked when the event is triggered.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'trackInfoUpdate', callback: Callback<Array<MediaDescription>>): void;
        /**
         * Unsubscribes from track information update events.
         * @param { 'trackInfoUpdate' } type - Type of the event to listen for.
         * The event is triggered when the track information is updated.
         * @param { Callback<Array<MediaDescription>> } callback - Callback that has been registered to listen for track
         * information updates.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'trackInfoUpdate', callback?: Callback<Array<MediaDescription>>): void;
        /**
         * Subscribes to update events of the maximum audio level value, which is periodically reported when audio
         * resources are played.
         * @param { 'amplitudeUpdate' } type - Type of the event to listen for.
         * The event is triggered when the amplitude changes.
         * @param { Callback<Array<double>> } callback - Callback invoked when the event is triggered.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'amplitudeUpdate', callback: Callback<Array<double>>): void;
        /**
         * Unsubscribes from update events of the maximum amplitude.
         * @param { 'amplitudeUpdate' } type - Type of the event to listen for.
         * The event is triggered when the amplitude changes.
         * @param { Callback<Array<double>> } callback - Callback that has been registered to listen for amplitude updates.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'amplitudeUpdate', callback?: Callback<Array<double>>): void;
        /**
         * Subscribes to events indicating that a Supplemental Enhancement Information (SEI) message is received. This
         * applies only to HTTP-FLV live streaming and is triggered when SEI messages are present in the video stream.
         * You must initiate the subscription before calling {@link #prepare}. If you initiate multiple subscriptions
         * to this event, the last subscription is applied.
         * @param { 'seiMessageReceived' } type - Type of the playback event to listen for.
         * The event is triggered when an SEI message is received.
         * @param { Array<int> } payloadTypes - Array of subscribed-to payload types of SEI messages. Currently,
         * only payloadType = 5 is supported.
         * @param { OnSeiMessageHandle } callback - Callback used to listen for SEI message events and receive the
         * subscribed-to payload types.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'seiMessageReceived', payloadTypes: Array<int>, callback: OnSeiMessageHandle): void;
        /**
         * Unsubscribes from the events indicating that an SEI message is received.
         * @param { 'seiMessageReceived' } type - Type of the playback event to listen for.
         * The event is triggered when an SEI message is received.
         * @param { Array<int> } [payloadTypes] - The payload types of the SEI message.
         *                                        Null means unsubscribe all payload types.
    
         * @param { OnSeiMessageHandle } [callback] -	Callback used to listen for SEI message events and receive the
         * subscribed-to payload types.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'seiMessageReceived', payloadTypes?: Array<int>, callback?: OnSeiMessageHandle): void;
        /**
         * Subscribes to the event indicating that super resolution is enabled or disabled.
         * @param { 'superResolutionChanged' } type - Type of the super-resolution event to listen for.
         * The event is triggered when super resolution is enabled or disabled.
         * @param { OnSuperResolutionChanged } callback - Callback used to listen for the super-resolution changed event.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        on(type: 'superResolutionChanged', callback: OnSuperResolutionChanged): void;
        /**
         * Unsubscribes from the event indicating that super resolution is enabled or disabled.
         * @param { 'superResolutionChanged' } type - Type of the super-resolution event to listen for.
         * The event is triggered when super resolution is enabled or disabled.
         * @param { OnSuperResolutionChanged } callback - Callback used to listen for the super-resolution changed event.
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        off(type: 'superResolutionChanged', callback?: OnSuperResolutionChanged): void;
    }
    /**
     * Provides the container definition for media description key-value pairs.
     *
     * @typedef { Record<string, Object> }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    type PlaybackInfo = Record<string, Object>;
    /**
     * Enumerates statistics info keys for player.
     *
     * @enum { string }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum PlaybackInfoKey {
        /**
         * IP address of current network stream.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        SERVER_IP_ADDRESS = 'server_ip_address',
        /**
         * Average download rate during playing except for suspend downloading.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AVG_DOWNLOAD_RATE = 'average_download_rate',
        /**
         * Current download rate of the last second except for suspend downloading.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        DOWNLOAD_RATE = 'download_rate',
        /**
         * Boolean value, true for current is downloading, false for suspend downloading.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        IS_DOWNLOADING = 'is_downloading',
        /**
         * Cached duration in milliseconds.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        BUFFER_DURATION = 'buffer_duration'
    }
    
    /**
     * Enumerates buffering info type, for network playback.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum BufferingInfoType {
        
        /**
         * begin to buffering
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        BUFFERING_START = 1,
        
        /**
         * end to buffering
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        BUFFERING_END = 2,
        
        /**
         * buffering percent
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        BUFFERING_PERCENT = 3,
        
        /**
         * cached duration in milliseconds
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        CACHED_DURATION = 4
    }
    /**
     * Defines the SourceOpenCallback function which is called by the service. client should process the incoming request
     * and return the unique handle to the open resource.
     * <br>**NOTE:**<br>
     * The client must return the handle immediately after processing the request.
     *
     * @typedef { function } SourceOpenCallback
     * @param { MediaSourceLoadingRequest } request - Parameters for the resource open request, including detailed
     * information about the requested resource and the data push method.
     * @returns { long } - return the handle of current resource open request.
     *                        A value greater than 0 means the request is successful.
     *                        A value less than or equal to 0 means it fails.
     *                     - The handle for the request object is unique.
     *                     - client should return immediately.
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    type SourceOpenCallback = (request: MediaSourceLoadingRequest) => long;
    /**
     * Defines the SourceReadCallback function which is called by the service. Client should record the read requests
     * and push the data through the {@link #response} method of the request object when there is sufficient data.
     * <br>**NOTE:**<br>
     * The client must return the handle immediately after processing the request.
     * @typedef { function } SourceReadCallback
     * @param { long } uuid - ID for the resource handle.
     * @param { long } requestedOffset - Offset of the current media data relative to the start of the resource.
     * @param { long } requestedLength - Length of the current request.
     *                                   - -1 means reaching the end of the source, need to inform the player
     *                                     of the end of the push through the {@link #finishLoading} method.
     * @returns { void } - client should return immediately.
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    type SourceReadCallback = (uuid: long, requestedOffset: long, requestedLength: long) => void;
    /**
     * Defines the SourceCloseCallback function which is called by the service. Client should release related resources.
     * <br>**NOTE:**<br>
     * The client must return the handle immediately after processing the request.
     * @typedef { function } SourceCloseCallback
     * @param { long } uuid - ID for the resource handle.
     * @returns { void } - client should return immediately.
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    type SourceCloseCallback = (uuid: long) => void;
    /**
     * Defines a media data loader, which needs to be implemented by applications.
     * @typedef MediaSourceLoader
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    interface MediaSourceLoader {
        /**
         * Callback function is implemented by application, which is used to handle resource opening requests.
         * @type { SourceOpenCallback }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        open: SourceOpenCallback;
        /**
         * Callback function is implemented by application, which is used to handle resource read requests.
         * @type { SourceReadCallback }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        read: SourceReadCallback;
        /**
         * Callback function is implemented by application, which is used to handle resource close request.
         * @type { SourceCloseCallback }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        close: SourceCloseCallback;
    }
    /**
     * Enumerates state change reason.
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum LoadingRequestError {
        /**
         * If reach the resource end, client should return.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        LOADING_ERROR_SUCCESS = 0,
        /**
         * If resource not ready for access, client should return.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        LOADING_ERROR_NOT_READY = 1,
        /**
         * If resource url not exist, client should return.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        LOADING_ERROR_NO_RESOURCE = 2,
        /**
         * If the uuid of resource handle is valid, client should return.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        LOADING_ERROR_INVAID_HANDLE = 3,
        /**
         * If client has no right to request the resource, client should return.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        LOADING_ERROR_ACCESS_DENIED = 4,
        /**
         * If access time out, client should return.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        LOADING_ERROR_ACCESS_TIMEOUT = 5,
        /**
         * If authorization failed, client should return.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        LOADING_ERROR_AUTHORIZE_FAILED = 6
    }
    /**
     * Loading Request object. Application obtains the requested resource location through this object
     * and send data to AVPlayer.
     * @typedef MediaSourceLoadingRequest
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    interface MediaSourceLoadingRequest {
        /**
         * Location for resource to be opened by the application.
         * @type { string }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        url: string;
        /**
         * HTTP request header. If the header exists, the application should set the header information in
         * the HTTP request when downloading data.
         * @type { ?Record<string, string> }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        header?: Record<string, string>;
        /**
         * The interface for application used to send requested data to AVPlayer.
         * @param { long } uuid - ID for the resource handle.
         * @param { long } offset - Offset of the current media data relative to the start of the resource.
         * @param { ArrayBuffer } buffer - Media data sent to the player.
         * @returns { int | undefined } - accept bytes for current read. The value less than zero means failed.
         *                    -2, means player need current data any more, the client should stop current read process.
         *                    -3, means player buffer is full, the client should wait for next read.
         * @syscap  SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        respondData(uuid: long, offset: long, buffer: ArrayBuffer): int | undefined;
        /**
         * The interface for application used to send respond header to AVPlayer
         * should be called before calling the {@link #respondData()} for the first time.
         * @param { long } uuid - ID for the resource handle.
         * @param { Record<string, string> } [header] - header info in the http response.
         * The application can intersect the header fields with the fields supported by the underlying layer for
         * parsing or directly pass in all corresponding header information.
         * @param { string } [redirectUrl] - redirect url from the http response if exist.
         * @syscap  SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        respondHeader(uuid: long, header?: Record<string, string>, redirectUrl?: string): void;
        /**
         * Notifies the player of the current request status. After pushing all the data for a single resource, the
         * application should send the **LOADING_ERROR_SUCCESS** state to notify the player that the resource push is
         * complete.
         * @param { long } uuid - ID for the resource handle.
         * @param { LoadingRequestError } state - Request status.
         * @syscap  SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        finishLoading(uuid: long, state: LoadingRequestError): void;
    }
    /**
     * Media Stream. AVPlayer use this for mediaData access, current version only support live stream.
     * @typedef MediaStream
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    interface MediaStream {
        /**
         * url for this mediaStream
         * @type { string }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        url: string;
        /**
         * video width.
         * @type { int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        width: int;
        /**
         * video height.
         * @type { int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        height: int;
        /**
         * biterate of this mediaStream.
         * @type { int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        bitrate: int;
    }
    /**
     * Media source descriptor. User can set media data information
  
     * @typedef MediaSource
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    interface MediaSource {
        /**
         * Set Media Mime Type to help player handle extended Media source.
         * @param { AVMimeTypes } mimeType - for MediaSource define. see @ AVMimeTypes.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        setMimeType(mimeType: AVMimeTypes): void;
        /**
         * Set Media source loader to help player access MediaData.
         * @param { MediaSourceLoader } resourceLoader - callback function interface set for player use.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        setMediaResourceLoaderDelegate(resourceLoader: MediaSourceLoader): void;
    }
    /**
     * Enumerates Media Mime types, used for MediaSource define;
     * @enum { string }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum AVMimeTypes {
        /**
         * Indicate current file is index file for hls Media.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        APPLICATION_M3U8 = 'application/m3u8'
    }
    /**
     * Provides preferred playback settings for player.
     *
     * @typedef PlaybackStrategy
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    interface PlaybackStrategy {
        /**
         * Choose a stream with width close to it.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        preferredWidth?: int;
        /**
         * Choose a stream with height close to it.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        preferredHeight?: int;
        /**
         * Chooses a preferred buffer duration.
         *
         * <p>The preferred buffer duration in the playback policy, is used to set the buffer size. For details,
         * see [Online Video Frame Freezing Optimization Practice]{@link
         * https://developer.huawei.com/consumer/cn/doc/best-practices/bpta-online-video-playback-lags-practice}.</p>
         *
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        preferredBufferDuration?: int;
        /**
         * If true, the player should choose HDR stream if exist.
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        preferredHdr?: boolean;
        /**
         * mute the specified media stream when playing.
         * @type { ?MediaType }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        mutedMediaType?: MediaType;
        /**
         * Audio language.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        preferredAudioLanguage?: string;
        /**
         * Subtitle language.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        preferredSubtitleLanguage?: string;
        /**
         * Show first frame on prepare.
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        showFirstFrameOnPrepare?: boolean;
        /**
         * Customize the buffering threshold for start or restart playing. The unit is second.
         * @type { ?double }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        preferredBufferDurationForPlaying?: double;
        /**
         * Enable super-resolution feature. default is false.
         * Must enable super-resolution feature before calling {@link #setSuperResolution} and {@link #setVideoWindowSize}.
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        enableSuperResolution?: boolean;
        /**
         * set max buffering threshold for liveStreaming or avplayer while change the speed.
         * It is recommended that the value be 2 seconds greater than the starting waterline.
         * @type { ?double }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        thresholdForAutoQuickPlay?: double;
    }
    
    
    /**
     * Media file descriptor. The caller needs to ensure that the fd is valid and
     * the offset and length are correct.
     *
     * @typedef AVFileDescriptor
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    interface AVFileDescriptor {
        
        
        /**
         * The file descriptor of audio or video source from file system. The caller
         * is responsible to close the file descriptor.
         * @type { int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        fd: int;
        
        
        /**
         * The offset into the file where the data to be read, in bytes. By default,
         * the offset is zero.
         * @type { ?long }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        offset?: long;
        
        
        /**
         * The length in bytes of the data to be read. By default, the length is the
         * rest of bytes in the file from the offset.
         * @type { ?long }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        length?: long;
    }
    
    
    /**
     * Defines the descriptor of an audio and video file, which is used in DataSource playback mode.
     * Use scenario: An application can create a playback instance and start playback before it finishes
     * downloading the audio and video resources.
     *
     * @typedef AVDataSrcDescriptor
     * @syscap SystemCapability.Multimedia.Media.AVPlayer
     * @since 20
     */
    interface AVDataSrcDescriptor {
        
        
        /**
         * Size of the file, -1 means the file size is unknown, in this case,
         * seek and setSpeed can't be executed, loop can't be set, and can't replay.
         * @type { long }
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        fileSize: long;
        
        
        /**
         * Callback function implemented by users, which is used to fill data.
         * buffer - The buffer need to fill.
         * length - The stream length player want to get.
         * pos - The stream position player want get start, and is an optional parameter.
         * When fileSize set to -1, this parameter is not used.
         * Returns length of the data to be filled, Return -1 to indicate that the end of the stream is reached,
         * Return -2 to indicate that an unrecoverable error has been encountered.
         * @type { function }
         * @syscap SystemCapability.Multimedia.Media.AVPlayer
         * @since 20
         */
        callback: (buffer: ArrayBuffer, length: long, pos?: long) => int;
    }
    /**
     * Provides subtitle information. When a subtitle update event is subscribed to, the information about the
     * external subtitle is returned through a callback.
     * Can be synchronized to the time reported by AVPlayer#timeUpdate event
     *
     * @typedef SubtitleInfo
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    interface SubtitleInfo {
        /**
         * Duration of the text to be displayed, as milliseconds.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        duration?: int;
        /**
         * Display start time of the text, as milliseconds.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        startTime?: int;
        /**
         * Text information of current update event.
         * @type { ?string }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        text?: string;
    }
    
    /**
     * Describes media recorder states.
     * @typedef {'idle' | 'prepared' | 'started' | 'paused' | 'stopped' | 'released' | 'error'}
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    type AVRecorderState = 'idle' | 'prepared' | 'started' | 'paused' | 'stopped' | 'released' | 'error';
    /**
     * Defines the onMove callback.
     *
     * @typedef { function } OnAVRecorderStateChangeHandler
     * @param { AVRecorderState } state - state value for AVRecorder.
     * @param { StateChangeReason } reason - reason for state change.
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    type OnAVRecorderStateChangeHandler = (state: AVRecorderState, reason: StateChangeReason) => void;
    
    /**
     * Manages and record audio/video. Before calling an AVRecorder method, you must use createAVRecorder()
     * to create an AVRecorder instance.
     *
     * @typedef AVRecorder
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    interface AVRecorder {
        
        /**
         * Sets audio and video recording parameters. This API uses an asynchronous callback to return the result.
         * @permission ohos.permission.MICROPHONE
         * @param { AVRecorderConfig } config - Audio and video recording parameters to set.
         * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
         * **err** is **undefined**; otherwise, **err** is an error object.
         * @throws { BusinessError } 201 - Permission denied. Return by callback.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types. 3.Parameter verification failed.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * // Configure the parameters based on those supported by the hardware device.
         * let avRecorderProfile: media.AVRecorderProfile = {
         *   audioBitrate : 48000,
         *   audioChannels : 2,
         *   audioCodec : media.CodecMimeType.AUDIO_AAC,
         *   audioSampleRate : 48000,
         *   fileFormat : media.ContainerFormatType.CFT_MPEG_4,
         *   videoBitrate : 2000000,
         *   videoCodec : media.CodecMimeType.VIDEO_AVC,
         *   videoFrameWidth : 640,
         *   videoFrameHeight : 480,
         *   videoFrameRate : 30
         * }
         * let avRecorderConfig: media.AVRecorderConfig = {
         *   audioSourceType : media.AudioSourceType.AUDIO_SOURCE_TYPE_MIC,
         *   videoSourceType : media.VideoSourceType.VIDEO_SOURCE_TYPE_SURFACE_YUV,
         *   profile : avRecorderProfile,
         *   url : 'fd://', // Before passing in an FD to this parameter, the file must be created by the caller and granted with the read and write permissions. Example value: fd://45.
         *   rotation: 0, // The value can be 0, 90, 180, or 270. If any other value is used, prepare() reports an error.
         *   location : { latitude : 30, longitude : 130 }
         * }
         *
         * avRecorder.prepare(avRecorderConfig, (err: BusinessError) => {
         *   if (err) {
         *     console.error('Failed to prepare and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in preparing');
         *   }
         * })
         */
        prepare(config: AVRecorderConfig, callback: AsyncCallback<void>): void;
        
        /**
         * Sets audio and video recording parameters. This API uses a promise to return the result.
         * @permission ohos.permission.MICROPHONE
         * This permission is required only if audio recording is involved.
         * @param { AVRecorderConfig } config - Recording parameters.
         * @returns { Promise<void> } A Promise instance used to return when prepare completed.
         * @throws { BusinessError } 201 - Permission denied. Return by promise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * // Configure the parameters based on those supported by the hardware device.
         * let avRecorderProfile: media.AVRecorderProfile = {
         *   audioBitrate : 48000,
         *   audioChannels : 2,
         *   audioCodec : media.CodecMimeType.AUDIO_AAC,
         *   audioSampleRate : 48000,
         *   fileFormat : media.ContainerFormatType.CFT_MPEG_4,
         *   videoBitrate : 2000000,
         *   videoCodec : media.CodecMimeType.VIDEO_AVC,
         *   videoFrameWidth : 640,
         *   videoFrameHeight : 480,
         *   videoFrameRate : 30
         * }
         * let avRecorderConfig: media.AVRecorderConfig = {
         *   audioSourceType : media.AudioSourceType.AUDIO_SOURCE_TYPE_MIC,
         *   videoSourceType : media.VideoSourceType.VIDEO_SOURCE_TYPE_SURFACE_YUV,
         *   profile : avRecorderProfile,
         *   url : 'fd://', // Before passing in an FD to this parameter, the file must be created by the caller and granted with the read and write permissions. Example value: fd://45.
         *   rotation: 0, // The value can be 0, 90, 180, or 270. If any other value is used, prepare() reports an error.
         *   location : { latitude : 30, longitude : 130 }
         * }
         *
         * avRecorder.prepare(avRecorderConfig).then(() => {
         *   console.info('Succeeded in preparing');
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to prepare and catch error is ' + err.message);
         * });
         */
        prepare(config: AVRecorderConfig): Promise<void>;
        /**
         * Obtains the real-time configuration of this AVRecorder.
         * This API uses an asynchronous callback to return the result.
         * This API can be called only after prepare() is called.
         * @param { AsyncCallback<AVRecorderConfig | undefined> } callback - Callback used to return the result.
         * If the operation is successful, **err** is **undefined** and **data** is the real-time configuration obtained;
         * otherwise, **err** is an error object.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by callback.
         * @throws { BusinessError } 5400103 - IO error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * let avConfig: media.AVRecorderConfig;
         *
         * avRecorder.getAVRecorderConfig((err: BusinessError, config: media.AVRecorderConfig) => {
         *   if (err) {
         *     console.error('Failed to get avConfig and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in getting AVRecorderConfig');
         *     avConfig = config;
         *   }
         * });
         */
        getAVRecorderConfig(callback: AsyncCallback<AVRecorderConfig | undefined>): void;
        /**
         * Obtains the real-time configuration of this AVRecorder. This API uses a promise to return the result.
         * This API can be called only after prepare() is called.
         * @returns { Promise<AVRecorderConfig | undefined> } Promise used to return the real-time configuration.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * let avConfig: media.AVRecorderConfig;
         *
         * avRecorder.getAVRecorderConfig().then((config: media.AVRecorderConfig) => {
         *   console.info('Succeeded in getting AVRecorderConfig');
         *   avConfig = config;
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to get AVRecorderConfig and catch error is ' + err.message);
         * });
         */
        getAVRecorderConfig(): Promise<AVRecorderConfig | undefined>;
        /**
         * Obtains the surface required for recording. This API uses an asynchronous callback to return the result.
         * The caller obtains the **surfaceBuffer** from this surface and fills in the corresponding video data.
         *
         * Note that the video data must carry the timestamp (in ns) and buffer size, and the start time of the timestamp
         * must be based on the system startup time.
         *
         * This API can be called only after the prepare() API is called.
         * @param { AsyncCallback<string | undefined> } callback - Callback used to return the result.
         * If the operation is successful, **err** is **undefined** and **data** is the surface ID obtained;
         * otherwise, **err** is an error object.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by callback.
         * @throws { BusinessError } 5400103 - IO error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         * let surfaceID: string; // The surfaceID is transferred to the camera API to create a videoOutput instance.
         *
         * avRecorder.getInputSurface((err: BusinessError, surfaceId: string) => {
         *   if (err) {
         *     console.error('Failed to do getInputSurface and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in doing getInputSurface');
         *     surfaceID = surfaceId;
         *   }
         * });
         */
        getInputSurface(callback: AsyncCallback<string | undefined>): void;
        /**
         * Obtains the surface required for recording. This API uses a promise to return the result. The caller obtains the **surfaceBuffer** from this surface and fills in the corresponding video data.
         *
         * Note that the video data must carry the timestamp (in ns) and buffer size, and the start time of the timestamp must be based on the system startup time.
         *
         * This API can be called only after the prepare() API is called.
         * @returns { Promise<string | undefined> } Promise used to return the result.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         * let surfaceID: string; // The surfaceID is transferred to the camera API to create a videoOutput instance.
         *
         * avRecorder.getInputSurface().then((surfaceId: string) => {
         *   console.info('Succeeded in getting InputSurface');
         *   surfaceID = surfaceId;
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to get InputSurface and catch error is ' + err.message);
         * });
         */
        getInputSurface(): Promise<string | undefined>;
        /**
         * Get input meta surface for specified meta source type. it must be called between prepare completed and start.
         * @param { MetaSourceType } type - Meta source type.
         * @returns { Promise<string | undefined> } A Promise instance used to return the input surface id in string.
         * @throws { BusinessError } 202 - Called from Non-System applications. Return by promise.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @systemapi
         * @since 20
         */
        getInputMetaSurface(type: MetaSourceType): Promise<string | undefined>;
        /**
         * Sets a watermark for the AVRecorder. This API uses a promise to return the result.
         *
         * This API can be called only after the prepare() event is triggered and before
         * the start() event is triggered.
         * @param { image.PixelMap } watermark : Watermark image.
         * @param { WatermarkConfig } config : Configures of the watermark.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 401 - The parameter check failed.
         * @throws { BusinessError } 801 - Capability not supported.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @systemapi
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         * import { image } from '@kit.ImageKit';
         *
         * let watermark: image.PixelMap|undefined = undefined; // need data.
         * let watermarkConfig: media.WatermarkConfig = { top: 100, left: 100 }
         *
         * avRecorder.setWatermark(watermark, watermarkConfig).then(() => {
         *   console.info('Succeeded in setWatermark');
         * }).catch((error: BusinessError) => {
         *   console.error(`Failed to setWatermark and catch error is ${error.message}`);
         * });
         */
        setWatermark(watermark: image.PixelMap, config: WatermarkConfig): Promise<void>;
        /**
         * Updates the video rotation angle. This API uses a promise to return the result.
         *
         * This API can be called only after the prepare() event is triggered and before the start() API is called.
         * @param { int } rotation - Rotation angle, which can only be 0, 90, 180, or 270 degrees.
         * @returns { Promise<void> } A Promise instance used to return when the function is finished.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * let rotation = 90
         *
         * avRecorder.updateRotation(rotation).then(() => {
         *   console.info('Succeeded in updateRotation');
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to updateRotation and catch error is ' + err.message);
         * });
         */
        updateRotation(rotation: int): Promise<void>;
        
        /**
         * Starts recording. This API uses an asynchronous callback to return the result.
         *
         * For audio-only recording, this API can be called only after the prepare() API is called.
         * For video-only recording, this API can be called only after the getInputSurface() API is called.
         * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
         * **err** is **undefined**; otherwise, **err** is an error object.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by callback.
         * @throws { BusinessError } 5400103 - IO error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.start((err: BusinessError) => {
         *   if (err) {
         *     console.error('Failed to start AVRecorder and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in starting AVRecorder');
         *   }
         * });
         */
        start(callback: AsyncCallback<void>): void;
        
        /**
         * Starts recording. This API uses a promise to return the result.
         *
         * For audio-only recording, this API can be called only after the prepare() API is called.
         * For video-only recording, this API can be called only after the getInputSurface() API is called.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.start().then(() => {
         *   console.info('Succeeded in starting AVRecorder');
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to start AVRecorder and catch error is ' + err.message);
         * });
         */
        start(): Promise<void>;
        
        /**
         * Pauses recording. This API uses an asynchronous callback to return the result.
         *
         * This API can be called only after the start() API is called. You can call resume() to resume recording.
         * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
         * **err** is **undefined**; otherwise, **err** is an error object.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by callback.
         * @throws { BusinessError } 5400103 - IO error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.pause((err: BusinessError) => {
         *   if (err) {
         *     console.error('Failed to pause AVRecorder and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in pausing');
         *   }
         * });
         */
        pause(callback: AsyncCallback<void>): void;
        
        /**
         * Pauses recording. This API uses a promise to return the result.
         *
         * This API can be called only after the start()API is called. You can call resume() to resume recording.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.pause().then(() => {
         *   console.info('Succeeded in pausing');
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to pause AVRecorder and catch error is ' + err.message);
         * });
         */
        pause(): Promise<void>;
        
        /**
         * Resumes recording. This API uses an asynchronous callback to return the result.
         *
         * This API can be called only after the pause() API is called.
         * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
         * **err** is **undefined**; otherwise, **err** is an error object.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by callback.
         * @throws { BusinessError } 5400103 - IO error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.resume((err: BusinessError) => {
         *   if (err) {
         *     console.error('Failed to resume AVRecorder and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in resuming AVRecorder');
         *   }
         * });
         */
        resume(callback: AsyncCallback<void>): void;
        
        /**
         * Resumes recording. This API uses a promise to return the result.
         *
         * This API can be called only after the pause() API is called.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.resume().then(() => {
         *   console.info('Succeeded in resuming AVRecorder');
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to resume  AVRecorder failed and catch error is ' + err.message);
         * });
         */
        resume(): Promise<void>;
        
        /**
         * Stops recording. This API uses an asynchronous callback to return the result.
         *
         * This API can be called only after the start() or pause() API is called.
         *
         * For audio-only recording, you can call prepare() again for re-recording.
         * For video-only recording or audio and video recording, you can call prepare() and getInputSurface() again for re-recording.
         * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
         * **err** is **undefined**; otherwise, **err** is an error object.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by callback.
         * @throws { BusinessError } 5400103 - IO error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.stop((err: BusinessError) => {
         *   if (err) {
         *     console.error('Failed to stop AVRecorder and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in stopping AVRecorder');
         *   }
         * });
         */
        stop(callback: AsyncCallback<void>): void;
        
        /**
         * Stops recording. This API uses a promise to return the result.
         *
         * This API can be called only after the start() or pause() API is called.
         *
         * For audio-only recording, you can call prepare() again for re-recording.
         * For video-only recording or audio and video recording,
         * you can call prepare() getInputSurface() again for re-recording.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400102 - Operate not permit. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.stop().then(() => {
         *   console.info('Succeeded in stopping AVRecorder');
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to stop AVRecorder and catch error is ' + err.message);
         * });
         */
        stop(): Promise<void>;
        
        /**
         * Resets audio and video recording. This API uses an asynchronous callback to return the result.
         *
         * For audio-only recording, you can call prepare() again for re-recording.
         * For video-only recording or audio and video recording,
         * you can call prepare() and getInputSurface() again for re-recording.
         * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
         * **err** is **undefined**; otherwise, **err** is an error object.
         * @throws { BusinessError } 5400103 - IO error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.reset((err: BusinessError) => {
         *   if (err) {
         *     console.error('Failed to reset AVRecorder and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in resetting AVRecorder');
         *   }
         * });
         */
        reset(callback: AsyncCallback<void>): void;
        
        /**
         * Resets audio and video recording. This API uses a promise to return the result.
         *
         * For audio-only recording, you can call prepare() again for re-recording.
         * For video-only recording or audio and video recording,
         * you can call prepare() and getInputSurface() again for re-recording.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.reset().then(() => {
         *   console.info('Succeeded in resetting AVRecorder');
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to reset and catch error is ' + err.message);
         * });
         */
        reset(): Promise<void>;
        
        /**
         * Releases the audio and video recording resources. This API uses an asynchronous callback to return the result.
         *
         * After the resources are released, you can no longer perform any operation on the **AVRecorder** instance.
         * @param { AsyncCallback<void> } callback - Callback used to return the result. If the operation is successful,
         * **err** is **undefined**; otherwise, **err** is an error object.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.release((err: BusinessError) => {
         *   if (err) {
         *     console.error('Failed to release AVRecorder and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in releasing AVRecorder');
         *   }
         * });
         */
        release(callback: AsyncCallback<void>): void;
        
        /**
         * Releases the audio and video recording resources. This API uses a promise to return the result.
         *
         * After the resources are released, you can no longer perform any operation on the **AVRecorder** instance.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avRecorder.release().then(() => {
         *   console.info('Succeeded in releasing AVRecorder');
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to release AVRecorder and catch error is ' + err.message);
         * });
         */
        release(): Promise<void>;
        /**
         * Obtains the information about the current audio capturer.
         * This API uses an asynchronous callback to return the result.
         *
         * This API can be called only after the **prepare()** API is called.
         * If this API is called after **stop()** is successfully called, an error is reported.
         * @param { AsyncCallback<audio.AudioCapturerChangeInfo> } callback - Callback used to return the result.
         * If the operation is successful, **err** is **undefined** and **data** is the
         * **audio.AudioCapturerChangeInfo** object obtained; otherwise, **err** is an error object.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @throws { BusinessError } 5400103 - I/O error.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { audio } from '@kit.AudioKit';
         *
         * let currentCapturerInfo: audio.AudioCapturerChangeInfo;
         *
         * avRecorder.getCurrentAudioCapturerInfo((err: BusinessError, capturerInfo: audio.AudioCapturerChangeInfo) => {
         *   if (err) {
         *     console.error('Failed to get CurrentAudioCapturerInfo and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in getting CurrentAudioCapturerInfo');
         *     currentCapturerInfo = capturerInfo;
         *   }
         * });
         */
        getCurrentAudioCapturerInfo(callback: AsyncCallback<audio.AudioCapturerChangeInfo>): void;
        /**
         * Obtains the information about the current audio capturer. This API uses a promise to return the result.
         *
         * This API can be called only after the **prepare()** API is called.
         * If this API is called after **stop()** is successfully called, an error is reported.
         * @returns { Promise<audio.AudioCapturerChangeInfo> } Promise used to return the audio capturer information.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @throws { BusinessError } 5400103 - I/O error.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * import { audio } from '@kit.AudioKit';
         *
         * let currentCapturerInfo: audio.AudioCapturerChangeInfo;
         *
         * avRecorder.getCurrentAudioCapturerInfo().then((capturerInfo: audio.AudioCapturerChangeInfo) => {
         *   console.info('Succeeded in getting CurrentAudioCapturerInfo');
         *   currentCapturerInfo = capturerInfo;
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to get CurrentAudioCapturerInfo and catch error is ' + err.message);
         * });
         */
        getCurrentAudioCapturerInfo(): Promise<audio.AudioCapturerChangeInfo>;
        /**
         * Obtains the maximum amplitude of the current audio capturer.
         * This API uses an asynchronous callback to return the result.
         *
         * This API can be called only after the **prepare()** API is called.
         * If this API is called after **stop()** is successfully called, an error is reported.
         *
         * The return value is the maximum amplitude within the duration from the time the maximum amplitude
         * is obtained last time to the current time. For example, if you have obtained the maximum amplitude at 1s
         * and you call this API again at 2s, then the return value is the maximum amplitude
         * within the duration from 1s to 2s.
         * @param { AsyncCallback<int> } callback - Callback used to return the result. If the operation is successful,
         * **err** is **undefined** and **data** is the maximum amplitude obtained; otherwise, **err** is an error object.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * let maxAmplitude: number;
         *
         * avRecorder.getAudioCapturerMaxAmplitude((err: BusinessError, amplitude: number) => {
         *   if (err) {
         *     console.error('Failed to get AudioCapturerMaxAmplitude and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in getting AudioCapturerMaxAmplitude');
         *     maxAmplitude = amplitude;
         *   }
         * });
         */
        getAudioCapturerMaxAmplitude(callback: AsyncCallback<int>): void;
        /**
         * Obtains the maximum amplitude of the current audio capturer. This API uses a promise to return the result.
         *
         * This API can be called only after the **prepare()** API is called.
         * If this API is called after **stop()** is successfully called, an error is reported.
         *
         * The return value is the maximum amplitude within the duration from the time the maximum amplitude
         * is obtained last time to the current time. For example, if you have obtained the maximum amplitude
         * at 1s and you call this API again at 2s, then the return value is the maximum amplitude
         * within the duration from 1s to 2s.
         * @returns { Promise<int> } Promise used to return the maximum amplitude obtained.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * let maxAmplitude: number;
         *
         * avRecorder.getAudioCapturerMaxAmplitude().then((amplitude: number) => {
         *   console.info('Succeeded in getting AudioCapturerMaxAmplitude');
         *   maxAmplitude = amplitude;
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to get AudioCapturerMaxAmplitude and catch error is ' + err.message);
         * });
         */
        getAudioCapturerMaxAmplitude(): Promise<int>;
        /**
         * Obtains available encoders. This API uses an asynchronous callback to return the result.
         * @param { AsyncCallback<Array<EncoderInfo>> } callback - Callback used to return the result.
         * If the operation is successful, **err** is **undefined** and **data** is the available encoders obtained; otherwise, **err** is an error object.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * let encoderInfo: media.EncoderInfo;
         *
         * avRecorder.getAvailableEncoder((err: BusinessError, info: media.EncoderInfo[]) => {
         *   if (err) {
         *     console.error('Failed to get AvailableEncoder and error is ' + err.message);
         *   } else {
         *     console.info('Succeeded in getting AvailableEncoder');
         *     encoderInfo = info[0];
         *   }
         * });
         */
        getAvailableEncoder(callback: AsyncCallback<Array<EncoderInfo>>): void;
        /**
         * Obtains available encoders. This API uses an asynchronous callback to return the result.
         * @returns { Promise<Array<EncoderInfo>> } Promise used to return the information about the available encoders.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         * @example
         * let encoderInfo: media.EncoderInfo;
         *
         * avRecorder.getAvailableEncoder().then((info: media.EncoderInfo[]) => {
         *   console.info('Succeeded in getting AvailableEncoder');
         *   encoderInfo = info[0];
         * }).catch((err: BusinessError) => {
         *   console.error('Failed to get AvailableEncoder and catch error is ' + err.message);
         * });
         */
        getAvailableEncoder(): Promise<Array<EncoderInfo>>;
        
        /**
         * Enumerates the AVRecorder states. You can obtain the state through the **state** attribute.
         * @type { AVRecorderState }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        readonly state: AVRecorderState;
        /**
         * Subscribes to audio capturer configuration changes. Any configuration change triggers the callback that
         * returns the entire configuration information.
         *
         * When the application initiates multiple subscriptions to this event, the last subscription is applied.
         * @param { 'audioCapturerChange' } type - Event type, which is **'audioCapturerChange'** in this case.
         * @param { Callback<audio.AudioCapturerChangeInfo> } callback - Callback used to return the entire configuration
         * information about the audio capturer.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * 2. Incorrect parameter types. 3.Parameter verification failed.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        on(type: 'audioCapturerChange', callback: Callback<audio.AudioCapturerChangeInfo>): void;
        /**
         * Subscribes to media asset callback events. When FileGenerationMode is used during media file creation,
         * the PhotoAsset object is called back to the application after the stop operation is complete.
         *
         * When the application initiates multiple subscriptions to this event, the last subscription is applied.
         * @param { 'photoAssetAvailable' } type - Event type, which is **'photoAssetAvailable'** in this case.
         * The event is triggered when a photo asset is available.
         * @param { Callback<photoAccessHelper.PhotoAsset> } callback - Callback used to return the
         * **PhotoAsset** object corresponding to the resource file created by the system.
         * @throws { BusinessError } 5400103 - IO error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        on(type: 'photoAssetAvailable', callback: Callback<photoAccessHelper.PhotoAsset>): void;
        
        /**
         * Subscribes to AVRecorder state changes. An application can subscribe to only one AVRecorder state change event.
         * When the application initiates multiple subscriptions to this event, the last subscription is applied.
         * @param { 'stateChange' } type - Event type, which is **'stateChange'** in this case.
         * This event can be triggered by both user operations and the system.
         * @param { OnAVRecorderStateChangeHandler } callback - Callback invoked when the event is triggered.
         * @throws { BusinessError } 5400103 - IO error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        on(type: 'stateChange', callback: OnAVRecorderStateChangeHandler): void;
        
        
        /**
         * Subscribes to AVRecorder errors. This event is used only for error prompt and does not require the user to
         * stop recording control. If the AVRecorderState is also switched to error, call reset() or release()
         * to exit the recording.
         *
         * An application can subscribe to only one AVRecorder error event.
         * When the application initiates multiple subscriptions to this event, the last subscription is applied.
         * @param { 'error' } type - Event type, which is **'error'** in this case.
         * This event is triggered when an error occurs during recording.
         * @param { ErrorCallback } callback - Callback invoked when the event is triggered.
         * @throws { BusinessError } 201 - Permission denied.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 5400101 - No memory.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @throws { BusinessError } 5400103 - I/O error.
         * @throws { BusinessError } 5400104 - Time out.
         * @throws { BusinessError } 5400105 - Service died.
         * @throws { BusinessError } 5400106 - Unsupported format.
         * @throws { BusinessError } 5400107 - Audio interrupted.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        on(type: 'error', callback: ErrorCallback): void;
        
        /**
         * Unsubscribes from AVRecorder state changes.
         * @param { 'stateChange' } type - Event type, which is **'stateChange'** in this case.
         * This event can be triggered by both user operations and the system.
         * @param { OnAVRecorderStateChangeHandler } callback - Callback invoked when the event is triggered.
         * This parameter is supported since API version 12.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        off(type: 'stateChange', callback?: OnAVRecorderStateChangeHandler): void;
        
        /**
         * Unsubscribes from AVRecorder errors. After the unsubscription,
         * your application can no longer receive AVRecorder errors.
         * @param { 'error' } type - Event type, which is **'error'** in this case.<br>This event is triggered when
         * an error occurs during recording.
         * @param { ErrorCallback } callback - Callback invoked when the event is triggered.
         * This parameter is supported since API version 12.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        off(type: 'error', callback?: ErrorCallback): void;
        
        /**
         * Subscribes to audio capturer configuration changes.
         * @param { 'audioCapturerChange' } type - Event type, which is **'audioCapturerChange'** in this case.
         * @param { Callback<audio.AudioCapturerChangeInfo> } callback - Callback used to return the entire configuration
         * information about the audio capturer.
         * This parameter is supported since API version 12.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        off(type: 'audioCapturerChange', callback?: Callback<audio.AudioCapturerChangeInfo>): void;
        /**
         * Unsubscribes from media asset callback events.
         * @param { 'photoAssetAvailable' } type - Event type, which is **'photoAssetAvailable'** in this case.
         * @param { Callback<photoAccessHelper.PhotoAsset> } callback - Callback used to return the **PhotoAsset** object
         * corresponding to the resource file created by the system.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        off(type: 'photoAssetAvailable', callback?: Callback<photoAccessHelper.PhotoAsset>): void;
    }
    
    /**
     * Provides the geographical location definitions for media resources.
     *
     * @typedef Location
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    interface Location {
        
        /**
         * Latitude.
         * @type { double }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        latitude: double;
        
        /**
         * Longitude.
         * @type { double }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        longitude: double;
    }
    /**
     * Set configures of a watermark to AVRecorder. The position starts at top left corner.
     *
     * @typedef WatermarkConfig
     * @syscap SystemCapability.Multimedia.Media.Core
     * @systemapi
     * @since 20
     */
    interface WatermarkConfig {
        /**
         * Offset of the watermark to the top line of pixel.
         * @type { int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @systemapi
         * @since 20
         */
        top: int;
        /**
         * Offset of the watermark to the left line of pixel.
         * @type { int }
         * @syscap SystemCapability.Multimedia.Media.Core
         * @systemapi
         * @since 20
         */
        left: int;
    }
    /**
    * The maintenance of this interface has been stopped since version api 9. Please use AVRecorderState.
    * Describes video recorder states.
    *
    * @typedef { 'idle' | 'prepared' | 'playing' | 'paused' | 'stopped' | 'error' }
    * @syscap SystemCapability.Multimedia.Media.VideoRecorder
    * @systemapi
    * @since 20
    */
    type VideoRecordState = 'idle' | 'prepared' | 'playing' | 'paused' | 'stopped' | 'error';
    /**
     * The maintenance of this interface has been stopped since version api 9. Please use AVRecorder.
     * Manages and record video. Before calling an VideoRecorder method, you must use createVideoRecorder()
     * to create an VideoRecorder instance.
     *
     * @typedef VideoRecorder
     * @syscap SystemCapability.Multimedia.Media.VideoRecorder
     * @systemapi
     * @since 20
     */
    interface VideoRecorder {
        
        /**
         * Prepares for recording.
         * @permission ohos.permission.MICROPHONE
         * @param { VideoRecorderConfig } config - Recording parameters.
         * @param { AsyncCallback<void> } callback - A callback instance used to return when prepare completed.
         * @throws { BusinessError } 201 - Permission denied. Return by callback.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        prepare(config: VideoRecorderConfig, callback: AsyncCallback<void>): void;
        
        /**
         * Prepares for recording.
         * @permission ohos.permission.MICROPHONE
         * @param { VideoRecorderConfig } config - Recording parameters.
         * @returns { Promise<void> } A Promise instance used to return when prepare completed.
         * @throws { BusinessError } 201 - Permission denied. Return by promise.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3.Parameter verification failed.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        prepare(config: VideoRecorderConfig): Promise<void>;
        /**
         * get input surface.it must be called between prepare completed and start.
         * @param { AsyncCallback<string | undefined> } callback - Callback used to return the input surface id in string.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @throws { BusinessError } 5400103 - I/O error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        getInputSurface(callback: AsyncCallback<string | undefined>): void;
        /**
         * get input surface. it must be called between prepare completed and start.
         * @returns { Promise<string | undefined> } A Promise instance used to return the input surface id in string.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400103 - I/O error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        getInputSurface(): Promise<string | undefined>;
        
        /**
         * Starts video recording.
         * @param { AsyncCallback<void> } callback - A callback instance used to return when start completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @throws { BusinessError } 5400103 - I/O error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        start(callback: AsyncCallback<void>): void;
        
        /**
         * Starts video recording.
         * @returns { Promise<void> } A Promise instance used to return when start completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400103 - I/O error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        start(): Promise<void>;
        
        /**
         * Pauses video recording.
         * @param { AsyncCallback<void> } callback - A callback instance used to return when pause completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @throws { BusinessError } 5400103 - I/O error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        pause(callback: AsyncCallback<void>): void;
        
        /**
         * Pauses video recording.
         * @returns { Promise<void> } A Promise instance used to return when pause completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400103 - I/O error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        pause(): Promise<void>;
        
        /**
         * Resumes video recording.
         * @param { AsyncCallback<void> } callback - A callback instance used to return when resume completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @throws { BusinessError } 5400103 - I/O error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        resume(callback: AsyncCallback<void>): void;
        
        /**
         * Resumes video recording.
         * @returns { Promise<void> } A Promise instance used to return when resume completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400103 - I/O error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        resume(): Promise<void>;
        
        /**
         * Stops video recording.
         * @param { AsyncCallback<void>  } callback A callback instance used to return when stop completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
         * @throws { BusinessError } 5400103 - I/O error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        stop(callback: AsyncCallback<void>): void;
        
        /**
         * Stops video recording.
         * @returns { Promise<void> } A Promise instance used to return when stop completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400103 - I/O error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        stop(): Promise<void>;
        
        /**
         * Releases resources used for video recording.
         * @param { AsyncCallback<void> } callback - A callback instance used to return when release completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        release(callback: AsyncCallback<void>): void;
        
        /**
         * Releases resources used for video recording.
         * @returns { Promise<void> } A Promise instance used to return when release completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        release(): Promise<void>;
        
        /**
         * Resets video recording.
         * Before resetting video recording, you must call stop() to stop recording. After video recording is reset,
         * you must call prepare() to set the recording configurations for another recording.
         * @param { AsyncCallback<void> } callback - A callback instance used to return when reset completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400103 - I/O error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        reset(callback: AsyncCallback<void>): void;
        
        /**
         * Resets video recording.
         * Before resetting video recording, you must call stop() to stop recording. After video recording is reset,
         * you must call prepare() to set the recording configurations for another recording.
         * @returns { Promise<void> } A Promise instance used to return when reset completed.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400103 - I/O error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        reset(): Promise<void>;
        
        /**
         * Listens for video recording error events.
         * @param { 'error' } type - Type of the video recording error event to listen for.
         * @param { ErrorCallback } callback - Callback used to listen for the video recording error event.
         * @throws { BusinessError } 201 - permission denied.
         * @throws { BusinessError } 202 - Not System App.
         * @throws { BusinessError } 5400103 - I/O error. Return by callback.
         * @throws { BusinessError } 5400105 - Service died. Return by callback.
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        on(type: 'error', callback: ErrorCallback): void;
        /**
         * video recorder state.
         * @type { VideoRecordState }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        readonly state: VideoRecordState;
    }
    
    /**
     * Enumerates playback speed.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.VideoPlayer
     * @since 20
     */
    enum PlaybackSpeed {
        
        /**
         * playback at 0.75x normal speed
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        SPEED_FORWARD_0_75_X = 0,
        
        /**
         * playback at normal speed
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        SPEED_FORWARD_1_00_X = 1,
        
        /**
         * playback at 1.25x normal speed
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        SPEED_FORWARD_1_25_X = 2,
        
        /**
         * playback at 1.75x normal speed
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        SPEED_FORWARD_1_75_X = 3,
        
        /**
         * playback at 2.0x normal speed
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        SPEED_FORWARD_2_00_X = 4,
        /**
         * playback at 0.5x normal speed
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        SPEED_FORWARD_0_50_X = 5,
        /**
         * playback at 1.5x normal speed
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        SPEED_FORWARD_1_50_X = 6,
        /**
         * playback at 3.0x normal speed
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        SPEED_FORWARD_3_00_X = 7,
        /**
         * playback at 0.25x normal speed
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        SPEED_FORWARD_0_25_X = 8,
        /**
         * playback at 0.125x normal speed
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        SPEED_FORWARD_0_125_X = 9
    }
    
    /**
     * Enumerates video scale type.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.VideoPlayer
     * @since 20
     */
    enum VideoScaleType {
        
        /**
         * The content is stretched to the fit the display surface rendering area. When
         * the aspect ratio of the content is not same as the display surface, the aspect
         * of the content is not maintained. This is the default scale type.
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        VIDEO_SCALE_TYPE_FIT = 0,
        
        /**
         * The content is stretched to the fit the display surface rendering area. When
         * the aspect ratio of the content is not the same as the display surface, content's
         * aspect ratio is maintained and the content is cropped to fit the display surface.
         * @syscap SystemCapability.Multimedia.Media.VideoPlayer
         * @since 20
         */
        VIDEO_SCALE_TYPE_FIT_CROP = 1
    }
    
    /**
     * Enumerates container format type(The abbreviation for 'container format type' is CFT).
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum ContainerFormatType {
        
        /**
         * A video container format type mp4.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        CFT_MPEG_4 = 'mp4',
        
        /**
         * A audio container format type m4a.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        CFT_MPEG_4A = 'm4a',
        /**
         * A audio container format type mp3.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        CFT_MP3 = 'mp3',
        /**
         * A audio container format type wav.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        CFT_WAV = 'wav',
        /**
         * A audio container format type amr.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        CFT_AMR = 'amr'
    }
    
    
    /**
     * Enumerates media data type.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum MediaType {
        
        
        /**
         * track is audio.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MEDIA_TYPE_AUD = 0,
        
        
        /**
         * track is video.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MEDIA_TYPE_VID = 1,
        /**
         * Track is subtitle.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MEDIA_TYPE_SUBTITLE = 2
    }
    
    
    /**
     * Enumerates media description key.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum MediaDescriptionKey {
        
        
        /**
         * key for track index, value type is number.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_TRACK_INDEX = 'track_index',
        
        
        /**
         * key for track type, value type is number, see @MediaType.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_TRACK_TYPE = 'track_type',
        
        
        /**
         * key for codec mime type, value type is string.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_CODEC_MIME = 'codec_mime',
        
        
        /**
         * key for duration, value type is number.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_DURATION = 'duration',
        
        
        /**
         * key for bitrate, value type is number.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_BITRATE = 'bitrate',
        
        
        /**
         * key for video width, value type is number.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_WIDTH = 'width',
        
        
        /**
         * key for video height, value type is number.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_HEIGHT = 'height',
        
        
        /**
         * key for video frame rate, value type is number.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_FRAME_RATE = 'frame_rate',
        
        
        /**
         * key for audio channel count, value type is number
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_AUD_CHANNEL_COUNT = 'channel_count',
        
        
        /**
         * key for audio sample rate, value type is number
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_AUD_SAMPLE_RATE = 'sample_rate',
        /**
         * key for audio bit depth, value type is number
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_AUD_SAMPLE_DEPTH = 'sample_depth',
        /**
         * Key for language.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_LANGUAGE = 'language',
        /**
         * Key for track name, value is string.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_TRACK_NAME = 'track_name',
        /**
         * Key for video hdr type, value type is number.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        MD_KEY_HDR_TYPE = 'hdr_type'
    }
    /**
     * Provides the video recorder profile definitions.
     *
     * @typedef VideoRecorderProfile
     * @syscap SystemCapability.Multimedia.Media.VideoRecorder
     * @systemapi
     * @since 20
     */
    interface VideoRecorderProfile {
        /**
         * Indicates the audio bit rate.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        readonly audioBitrate: int;
        /**
         * Indicates the number of audio channels.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        readonly audioChannels: int;
        /**
         * Indicates the audio encoding format.
         * @type { CodecMimeType }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        readonly audioCodec: CodecMimeType;
        /**
         * Indicates the audio sampling rate.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        readonly audioSampleRate: int;
        /**
         * Indicates the output file format.
         * @type { ContainerFormatType }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        readonly fileFormat: ContainerFormatType;
        /**
         * Indicates the video bit rate.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        readonly videoBitrate: int;
        /**
         * Indicates the video encoding format.
         * @type { CodecMimeType }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        readonly videoCodec: CodecMimeType;
        /**
         * Indicates the video width.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        readonly videoFrameWidth: int;
        /**
         * Indicates the video height.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        readonly videoFrameHeight: int;
        /**
         * Indicates the video frame rate.
         * @type { int }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        readonly videoFrameRate: int;
    }
    
    /**
     * Enumerates the audio source types for video recording.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    enum AudioSourceType {
        
        /**
         * Default audio input source.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        AUDIO_SOURCE_TYPE_DEFAULT = 0,
        
        /**
         *  Microphone audio input source.
         *  <br>**Atomic service API**: This API can be used in atomic services since API version 12.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        AUDIO_SOURCE_TYPE_MIC = 1,
        /**
         * Audio source in speech recognition scenarios.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        AUDIO_SOURCE_TYPE_VOICE_RECOGNITION = 2,
        /**
         * Voice communication source.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        AUDIO_SOURCE_TYPE_VOICE_COMMUNICATION = 7,
        /**
         * Voice message source.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        AUDIO_SOURCE_TYPE_VOICE_MESSAGE = 10,
        /**
         * Audio source in camera recording scenarios.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        AUDIO_SOURCE_TYPE_CAMCORDER = 13
    }
    
    /**
     * Enumerates the video source types for video recording.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    enum VideoSourceType {
        
        /**
         * The input surface carries raw data.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        VIDEO_SOURCE_TYPE_SURFACE_YUV = 0,
        
        /**
         * The input surface carries ES data.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        VIDEO_SOURCE_TYPE_SURFACE_ES = 1
    }
    /**
     * Enumerates meta source type for recorder.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @systemapi
     * @since 20
     */
    enum MetaSourceType {
        /**
         * Maker info for video.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @systemapi
         * @since 20
         */
        VIDEO_MAKER_INFO = 0
    }
    /**
     * Enumerates the modes for creating media files.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    enum FileGenerationMode {
        /**
         * The application creates a media file in the sandbox.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        APP_CREATE = 0,
        /**
         * The system creates a media file. Currently, this mode takes effect only in camera recording scenarios.
         * The URL set by the application is ignored.
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        AUTO_CREATE_CAMERA_SCENE = 1
    }
    /**
     * Provides the video recorder configuration definitions.
     *
     * @typedef VideoRecorderConfig
     * @syscap SystemCapability.Multimedia.Media.VideoRecorder
     * @systemapi
     * @since 20
     */
    interface VideoRecorderConfig {
        /**
         * audio source type, details see @AudioSourceType .
         * @type { ?AudioSourceType }
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        audioSourceType?: AudioSourceType;
        /**
         * video source type, details see @VideoSourceType .
         * @type { VideoSourceType }
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        videoSourceType: VideoSourceType;
        /**
         * video recorder profile, can get by "getVideoRecorderProfile", details see @VideoRecorderProfile .=
         * @type { VideoRecorderProfile }
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        profile: VideoRecorderProfile;
        /**
         * video output uri.support two kind of uri now.
         * format like: scheme + "://" + "context".
         * fd:    fd://fd
         * @type { string }
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        url: string;
        /**
         * Sets the video rotation angle in output file, and for the file to playback. mp4 support.
         * the range of rotation angle should be {0, 90, 180, 270}, default is 0.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        rotation?: int;
        /**
         * geographical location information.
         * @type { ?Location }
         * @syscap SystemCapability.Multimedia.Media.VideoRecorder
         * @systemapi
         * @since 20
         */
        location?: Location;
    }
    /**
     * Describes the information about an encoder.
     *
     * @typedef EncoderInfo
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    interface EncoderInfo {
        /**
         * MIME type of the encoder.
         * @type { CodecMimeType }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        mimeType: CodecMimeType;
        /**
         * Encoder type. The value **audio** means an audio encoder, and **video** means a video encoder.
         * @type { string }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        type: string;
        /**
         * Bit rate range of the encoder, with the minimum and maximum bit rates specified.
         * @type { ?Range }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        bitRate?: Range;
        /**
         * Video frame rate range, with the minimum and maximum frame rates specified.
         * This parameter is available only for video encoders.
         * @type { ?Range }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        frameRate?: Range;
        /**
         * Video frame width range, with the minimum and maximum widths specified.
         * This parameter is available only for video encoders.
         * @type { ?Range }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        width?: Range;
        /**
         * Video frame height range, with the minimum and maximum heights specified.
         * This parameter is available only for video encoders.
         * @type { ?Range }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        height?: Range;
        /**
         * Number of audio channels for the audio capturer, with the minimum and maximum numbers of audio channels specified.
         * This parameter is available only for audio encoders.
         * @type { ?Range }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        channels?: Range;
        /**
         * Audio sampling rate, including all available audio sampling rates. The value depends on the encoder type,
         * and this parameter is available only for audio encoders.
         * @type { ?Array<int> }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        sampleRate?: Array<int>;
    }
    /**
     * Provides Range with lower and upper limit.
     *
     * @typedef Range
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    interface Range {
        /**
         * Minimum value.
         * @type { int }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        min: int;
        /**
         * Maximum value.
         * @type { int }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        max: int;
    }
    
    /**
     * Describes the audio and video recording profile.
     *
     * @typedef AVRecorderProfile
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    interface AVRecorderProfile {
        
        /**
         * Audio encoding bit rate. This parameter is mandatory for audio recording.<br>Supported bit rate ranges:
         * <br>- Range [32000 - 500000] for the AAC encoding format.<br>- Range [64000] for the G.711 μ-law encoding format.
         * <br>- Range [8000, 16000, 32000, 40000, 48000, 56000, 64000, 80000, 96000, 112000, 128000, 160000, 192000,
         * 224000, 256000, 320000] for the MP3 encoding format.<br>When the MP3 encoding format is used,
         * the mapping between the sampling rate and bit rate is as follows:<br>- When the sampling rate is lower than
         * 16 kHZ, the bit rate range is [8000 - 64000].<br>- When the sampling rate ranges from 16 kHz to 32 kHz,
         * the bit rate range is [8000 - 160000].<br>- When the sampling rate is greater than 32 kHz, the bit rate range
         * is [32000 - 320000].<br>- Range [4750, 5150, 5900, 6700, 7400, 7950, 10200, 12200] for
         * the AMR-NB encoding format.<br>- Range [6600, 8850, 12650, 14250, 15850, 18250, 19850, 23050, 23850] for the
         * AMR-WB encoding format.<br>**Atomic service API**: This API can be used in atomic services since API version 12.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        audioBitrate?: int;
        
        /**
         * Number of audio channels. This parameter is mandatory for audio recording.<br>- Range [1 - 8] for the
         * AAC encoding format.<br>- Range [1] for the G.711 μ-law encoding format.<br>- Range [1 - 2] for the MP3 encoding
         * format.<br>- Range [1] for the AMR-NB and AMR-WB encoding formats.<br>**Atomic service API**: This API can be
         * used in atomic services since API version 12.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        audioChannels?: int;
        
        /**
         * Audio encoding format. This parameter is mandatory for audio recording. Currently, AUDIO_AAC, AUDIO_MP3,
         * AUDIO_G711MU, AUDIO_AMR_NB, and AUDIO_AMR_WB are supported.<br>**Atomic service API**: This API can be used in
         * atomic services since API version 12.
         * @type { ?CodecMimeType }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        audioCodec?: CodecMimeType;
        
        /**
         * Audio sampling rate. This parameter is mandatory for audio recording.<br>Supported sampling rate ranges:
         * <br>- Range [8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000, 64000, 88200, 96000] for the AAC
         * encoding format.<br>- Range [8000] for the G.711 μ-law encoding format.<br>- Range [8000, 11025, 12000, 16000,
         * 22050, 24000, 32000, 44100, 48000] for the MP3 encoding format.<br>- Range [8000] for the AMR-NB encoding format.
         * <br>- Range [16000] for the AMR-WB encoding format.<br>Variable bit rate. The bit rate is for reference only.
         * <br>**Atomic service API**: This API can be used in atomic services since API version 12.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        audioSampleRate?: int;
        
        /**
         * Container format of a file. This parameter is mandatory. Currently, the MP4, M4A, MP3, WAV, and AMR container
         * formats are supported. The AUDIO_MP3 encoding format cannot be used in the MP4 container format.<br>**Atomic
         * service API**: This API can be used in atomic services since API version 12.
         * @type { ContainerFormatType }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        fileFormat: ContainerFormatType;
        
        /**
         * Video encoding bit rate. This parameter is mandatory for video recording. The value range is [10000 - 100000000].
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        videoBitrate?: int;
        
        /**
         * Video encoding format. This parameter is mandatory for video recording. Currently, VIDEO_AVC is supported.
         * @type { ?CodecMimeType }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        videoCodec?: CodecMimeType;
        
        /**
         * Width of a video frame. This parameter is mandatory for video recording. The value range is [176 - 4096].
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        videoFrameWidth?: int;
        
        /**
         * Height of a video frame. This parameter is mandatory for video recording. The value range is [144 - 4096].
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        videoFrameHeight?: int;
        
        /**
         * Video frame rate. This parameter is mandatory for video recording. The value range is [1 - 60].
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        videoFrameRate?: int;
        
        /**
         * HDR encoding. This parameter is optional for video recording. The default value is **false**, and there is no
         * requirement on the encoding format. When **isHdr** is set to **true**, the encoding format must be **video/hevc**.
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        isHdr?: boolean;
        /**
         * Whether temporal layered encoding is supported. This parameter is optional for video recording. The default value
         * is **false**. If this parameter is set to **true**, some frames in the video output streams can be skipped
         * without being encoded.
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        enableTemporalScale?: boolean;
        /**
         * Whether to enable video encoding policy to quality stable encoding.
         * @type { ?boolean }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @systemapi
         * @since 20
         */
        enableStableQualityMode?: boolean;
    }
    
    /**
     * Describes the audio and video recording parameters.
     *
     * The **audioSourceType** and **videoSourceType** parameters are used to distinguish audio-only recording,
     * video-only recording, and audio and video recording. For audio-only recording, set only **audioSourceType**.
     * For video-only recording, set only **videoSourceType**. For audio and video recording, set both **audioSourceType**
     * and **videoSourceType**.
     *
     * @typedef AVRecorderConfig
     * @syscap SystemCapability.Multimedia.Media.AVRecorder
     * @since 20
     */
    interface AVRecorderConfig {
        
        /**
         * Type of the audio source to record. This parameter is mandatory for audio recording.<br>**Atomic service API**:
         * This API can be used in atomic services since API version 12.
         * @type { ?AudioSourceType }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        audioSourceType?: AudioSourceType;
        
        /**
         * Type of the video source to record. This parameter is mandatory for video recording.
         * @type { ?VideoSourceType }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        videoSourceType?: VideoSourceType;
        /**
         * Meta source types, details see @MetaSourceType .
         * @type { ?Array<MetaSourceType> }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @systemapi
         * @since 20
         */
        metaSourceTypes?: Array<MetaSourceType>;
        
        /**
         * Recording profile. This parameter is mandatory.<br>**Atomic service API**: This API can be used in atomic
         * services since API version 12.
         * @type { AVRecorderProfile }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        profile: AVRecorderProfile;
        
        /**
         * Recording output URL: fd://xx (fd number).<br>This parameter is mandatory.<br>**Atomic service API**:
         * This API can be used in atomic services since API version 12.
         * @type { string }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        url: string;
        /**
         * Mode for creating the file, which is used together with on('photoAssetAvailable').
         * @type { ?FileGenerationMode }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        fileGenerationMode?: FileGenerationMode;
        /**
         * Metadata. For details, see @AVMetadata.
         * @type { ?AVMetadata }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        metadata?: AVMetadata;
        /**
         * Maximum recording duration, in seconds. The value range is [1, 2^31-1]. If an invalid value is provided,
         * it is reset to the maximum allowed duration. Once the recording reaches the specified duration,
         * it stops automatically and notifies via the **stateChange** callback that the recording has stopped:
         * AVRecorderState = 'stopped', StateChangeReason = BACKGROUND.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVRecorder
         * @since 20
         */
        maxDuration?: int;
    }
    /**
     * Provides the container definition for media description key-value pairs.
     *
     * The media description consists of key-value pairs where keys reference @MediaDescriptionKey.
     * @typedef { Record<string, Object> }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    type MediaDescription = Record<string, Object>;
    
    
    /**
     * Enumerates seek mode.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum SeekMode {
        
        
        /**
         * seek to the next sync frame of the given timestamp
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        SEEK_NEXT_SYNC = 0,
        
        
        /**
         * seek to the previous sync frame of the given timestamp
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        SEEK_PREV_SYNC = 1,
        /**
         * Seek to the closest frame of the given timestamp.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        SEEK_CLOSEST = 2,
        /**
         * Seek in continuous mode.
         * Seek continuous can provide a smoother dragging experience, but the device needs to support
         * the current stream to execute seek continuous. Before calling seek continuous,
         * check whether it is supported, see {@link #isSeekContinuousSupported}.
         * If an unsupported scenario occurs, seek continuous will report an error({@link #AVERR_SEEK_CONTINUOUS_UNSUPPORTED})
         * through the on error callback.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        SEEK_CONTINUOUS = 3
    }
    /**
     * Enumerates switch mode.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum SwitchMode {
        /**
         * switch to the next sync frame of the given timestamp
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        SMOOTH = 0,
        /**
         * switch to the previous sync frame of the given timestamp
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        SEGMENT = 1,
        /**
         * switch to the closest frame of the given timestamp.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        CLOSEST = 2
    }
    
    /**
     * Enumerates Codec MIME types.
     *
     * @enum { string }
     * @syscap SystemCapability.Multimedia.Media.Core
     * @since 20
     */
    enum CodecMimeType {
        
        /**
         * H.263 codec MIME type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        VIDEO_H263 = 'video/h263',
        
        /**
         * H.264 codec MIME type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        VIDEO_AVC = 'video/avc',
        
        /**
         * MPEG2 codec MIME type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        VIDEO_MPEG2 = 'video/mpeg2',
        
        /**
         * MPEG4 codec MIME type
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        VIDEO_MPEG4 = 'video/mp4v-es',
        
        /**
         * VP8 codec MIME type
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        VIDEO_VP8 = 'video/x-vnd.on2.vp8',
        
        /**
         * AAC codec MIME type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AUDIO_AAC = 'audio/mp4a-latm',
        
        /**
         * vorbis codec MIME type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AUDIO_VORBIS = 'audio/vorbis',
        
        /**
         * flac codec MIME type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AUDIO_FLAC = 'audio/flac',
        
        /**
         * H.265 codec MIME type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        VIDEO_HEVC = 'video/hevc',
        /**
         * mp3 codec MIME type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AUDIO_MP3 = 'audio/mpeg',
        /**
         * G711-mulaw codec MIME type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AUDIO_G711MU = 'audio/g711mu',
        /**
         * AMR_NB codec MIME type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AUDIO_AMR_NB = 'audio/3gpp',
        /**
         * AMR_WB codec MIME type.
         * @syscap SystemCapability.Multimedia.Media.Core
         * @since 20
         */
        AUDIO_AMR_WB = 'audio/amr-wb'
    }
    /**
     *  Enumerates the encoding and container formats used during screen capture.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
     * @since 20
     */
    enum AVScreenCaptureRecordPreset {
        /**
         * The H.264 video encoding format, AAC audio encoding format, and MP4 container format are used.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREEN_RECORD_PRESET_H264_AAC_MP4 = 0,
        /**
         * The H.265 video encoding format, AAC audio encoding format, and MP4 container format are used.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREEN_RECORD_PRESET_H265_AAC_MP4 = 1
    }
    /**
     *  Enumerates the video fill modes during screen capture.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
     * @since 20
     */
    enum AVScreenCaptureFillMode {
        /**
         * Keeps the original aspect ratio, matching the aspect ratio of the physical screen.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        PRESERVE_ASPECT_RATIO = 0,
        /**
         * Stretches the image to fit the specified dimensions.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCALE_TO_FILL = 1
    }
    /**
     *  Enumerates the screen capture states used in callbacks.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
     * @since 20
     */
    enum AVScreenCaptureStateCode {
        /**
         * Screen capture is started.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREENCAPTURE_STATE_STARTED = 0,
        /**
         * Screen capture is canceled.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREENCAPTURE_STATE_CANCELED = 1,
        /**
         * Screen capture is manually stopped by the user.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREENCAPTURE_STATE_STOPPED_BY_USER = 2,
        /**
         * Screen capture is interrupted by another screen capture.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREENCAPTURE_STATE_INTERRUPTED_BY_OTHER = 3,
        /**
         * Screen capture is interrupted by an incoming call.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREENCAPTURE_STATE_STOPPED_BY_CALL = 4,
        /**
         * The microphone is unavailable during screen capture.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREENCAPTURE_STATE_MIC_UNAVAILABLE = 5,
        /**
         * The microphone is muted by the user.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREENCAPTURE_STATE_MIC_MUTED_BY_USER = 6,
        /**
         * The microphone is unmuted by the user.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREENCAPTURE_STATE_MIC_UNMUTED_BY_USER = 7,
        /**
         * The system enters a privacy page during screen capture.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREENCAPTURE_STATE_ENTER_PRIVATE_SCENE = 8,
        /**
         * The system exits a privacy page during screen capture.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREENCAPTURE_STATE_EXIT_PRIVATE_SCENE = 9,
        /**
         * Screen capture is interrupted by system user switchover.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        SCREENCAPTURE_STATE_STOPPED_BY_USER_SWITCHES = 10
    }
    /**
     * Defines the screen capture parameters.
     *
     * @typedef AVScreenCaptureRecordConfig
     * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
     * @since 20
     */
    interface AVScreenCaptureRecordConfig {
        /**
         * FD of the file output.
         * @type { int }
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        fd: int;
        /**
         * Video width, in px. The default value varies according to the display in use.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        frameWidth?: int;
        /**
         * Video height, in px. The default value varies according to the display in use.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        frameHeight?: int;
        /**
         * Video bit rate. The default value is **10000000**.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        videoBitrate?: int;
        /**
         * Audio sampling rate. This value is used for both internal capture and external capture (using microphones).
         * Only **48000** (default value) and **16000** are supported.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        audioSampleRate?: int;
        /**
         * Number of audio channels. This value is used for both internal capture and external capture (using microphones).
         * Only **1** and **2** (default) are supported.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        audioChannelCount?: int;
        /**
         * Audio bit rate. This value is used for both internal capture and external capture (using microphones).
         * The default value is **96000**.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        audioBitrate?: int;
        /**
         * Encoding and container format used. The default value is **SCREEN_RECORD_PRESET_H264_AAC_MP4**.
         * @type { ?AVScreenCaptureRecordPreset }
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        preset?: AVScreenCaptureRecordPreset;
        /**
         * ID of the display used for screen capture. By default, the main screen is captured.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        displayId?: int;
        /**
         * Video fill mode during screen capture.
         * @type { ?AVScreenCaptureFillMode }
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         */
        fillMode?: AVScreenCaptureFillMode;
    }
    /**
     * Provides APIs to manage screen capture. Before calling any API in **AVScreenCaptureRecorder**,
     * you must use createAVScreenCaptureRecorder() to create an **AVScreenCaptureRecorder** instance.
     *
     * @typedef AVScreenCaptureRecorder
     * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
     * @since 20
     */
    interface AVScreenCaptureRecorder {
        /**
         * Initializes screen capture and sets screen capture parameters. This API uses a promise to return the result.
         * @param { AVScreenCaptureRecordConfig } config - Screen capture parameters to set.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 401 - Parameter error. Possible causes: 1. Mandatory parameters are left unspecified.
         * <br>2. Incorrect parameter types. 3. Parameter verification failed. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * let avCaptureConfig: media.AVScreenCaptureRecordConfig = {
         *     fd: 0, // Before passing in an FD to this parameter, the file must be created by the caller and granted with the write permissions.
         *     frameWidth: 640,
         *     frameHeight: 480
         *     // Add other parameters.
         * }
         *
         * avScreenCaptureRecorder.init(avCaptureConfig).then(() => {
         *     console.info('Succeeded in initing avScreenCaptureRecorder');
         * }).catch((err: BusinessError) => {
         *     console.info('Failed to init avScreenCaptureRecorder, error: ' + err.message);
         * })
         */
        init(config: AVScreenCaptureRecordConfig): Promise<void>;
        /**
         * Starts screen capture. This API uses a promise to return the result.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avScreenCaptureRecorder.startRecording().then(() => {
         *     console.info('Succeeded in starting avScreenCaptureRecorder');
         * }).catch((err: BusinessError) => {
         *     console.info('Failed to start avScreenCaptureRecorder, error: ' + err.message);
         * })
         */
        startRecording(): Promise<void>;
        /**
         * Stops screen capture. This API uses a promise to return the result.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avScreenCaptureRecorder.stopRecording().then(() => {
         *     console.info('Succeeded in stopping avScreenCaptureRecorder');
         * }).catch((err: BusinessError) => {
         *     console.info('Failed to stop avScreenCaptureRecorder, error: ' + err.message);
         * })
         */
        stopRecording(): Promise<void>;
        /**
         * During screen capture, the application can exempt its privacy windows from security purposes.
         * This API uses a promise to return the result.
         * For example, if a user enters a password in this application during screen capture,
         * the application will not display a black screen.
         * @param { Array<int> } windowIDs - IDs of windows that require privacy exemption, including the main window
         * IDs and subwindow IDs. For details about how to obtain window properties.
         * @returns { Promise<void> } Promise used to return the window IDs.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * let windowIDs = [];
         * avScreenCaptureRecorder.skipPrivacyMode(windowIDs).then(() => {
         *     console.info('Succeeded in skipping privacy mode');
         * }).catch((err: BusinessError) => {
         *     console.info('Failed to skip privacy mode, error: ' + err.message);
         * })
         */
        skipPrivacyMode(windowIDs: Array<int>): Promise<void>;
        /**
         * Enables or disables the microphone. This API uses a promise to return the result.
         * @param { boolean } enable - Whether to enable or disable the microphone. The value **true** means to enable
         * the microphone, and **false** means the opposite.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avScreenCaptureRecorder.setMicEnabled(true).then(() => {
         *     console.info('Succeeded in setMicEnabled avScreenCaptureRecorder');
         * }).catch((err: BusinessError) => {
         *     console.info('Failed to setMicEnabled avScreenCaptureRecorder, error: ' + err.message);
         * })
         */
        setMicEnabled(enable: boolean): Promise<void>;
        /**
         * Releases this **AVScreenCaptureRecorder** instance. This API uses a promise to return the result.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         * @example
         * import { BusinessError } from '@kit.BasicServicesKit';
         *
         * avScreenCaptureRecorder.release().then(() => {
         *     console.info('Succeeded in releasing avScreenCaptureRecorder');
         * }).catch((err: BusinessError) => {
         *     console.info('Faile to release avScreenCaptureRecorder, error: ' + err.message);
         * })
         */
        release(): Promise<void>;
        /**
         * Subscribes to screen capture state changes. An application can subscribe to only one screen capture
         * state change event. When the application initiates multiple subscriptions to this event,
         * the last subscription is applied.
         * @param { 'stateChange' } type - Event type, which is **'stateChange'** in this case.
         * @param { Callback<AVScreenCaptureStateCode> } callback - Callback invoked when the event is triggered.
         * AVScreenCaptureStateCode indicates the new state.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         * @example
         * avScreenCaptureRecorder.on('stateChange', (state: media.AVScreenCaptureStateCode) => {
         *     console.info('avScreenCaptureRecorder stateChange to ' + state);
         * })
         */
        on(type: 'stateChange', callback: Callback<AVScreenCaptureStateCode>): void;
        /**
         * Subscribes to AVScreenCaptureRecorder errors. You can handle the errors based on the application logic.
         * An application can subscribe to only one AVScreenCaptureRecorder error event.
         * When the application initiates multiple subscriptions to this event, the last subscription is applied.
         * @param { 'error' } type - Event type, which is **'error'** in this case.
         * @param { ErrorCallback } callback - Callback invoked when the event is triggered.
         * @throws { BusinessError } 201 - permission denied.
         * @throws { BusinessError } 5400103 - IO error. Return by ErrorCallback.
         * @throws { BusinessError } 5400105 - Service died. Return by ErrorCallback.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         * @example
         * avScreenCaptureRecorder.on('error', (err: BusinessError) => {
         *     console.error('avScreenCaptureRecorder error:' + err.message);
         * })
         */
        on(type: 'error', callback: ErrorCallback): void;
        /**
         * Unsubscribes from screen capture state changes. You can specify a callback to cancel the specified subscription.
         * @param { 'stateChange' } type - Event type, which is **'stateChange'** in this case.
         * @param { Callback<AVScreenCaptureStateCode> } callback - Callback used for unsubscription.
         * AVScreenCaptureStateCode indicates the new state. If this parameter is not specified,
         * the last subscription is canceled.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         * @example
         * avScreenCaptureRecorder.off('stateChange');
         */
        off(type: 'stateChange', callback?: Callback<AVScreenCaptureStateCode>): void;
        /**
         * Unsubscribes from AVScreenCaptureRecorder errors. You can specify a callback to cancel
         * the specified subscription.
         * @param { 'error' } type - Event type, which is **'error'** in this case.
         * @param { ErrorCallback } callback - Callback used for unsubscription. If this parameter is not specified,
         * the last subscription is canceled.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @since 20
         * @example
         * avScreenCaptureRecorder.off('error');
         */
        off(type: 'error', callback?: ErrorCallback): void;
    }
    /**
     * Describes the video transcoding parameters.
     *
     * @typedef AVTranscoderConfig
     * @syscap SystemCapability.Multimedia.Media.AVTranscoder
     * @since 20
     */
    interface AVTranscoderConfig {
        /**
         * Bitrate of the output audio, in bit/s. The value range is [1-500000]. The default value is 48 kbit/s.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        audioBitrate?: int;
        /**
         * Encoding format of the output audio. Currently, only AAC is supported. The default value is **AAC**.
         * @type { ?CodecMimeType }
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        audioCodec?: CodecMimeType;
        /**
         * Container format of the output video file. Currently, only MP4 is supported.
         * @type { ContainerFormatType }
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        fileFormat: ContainerFormatType;
        /**
         * Bitrate of the output video, in bit/s. The default bitrate depends on the resolution of the output video.
         * The default bitrate is 1 Mbit/s for the resolution in the range [240p, 480P],
         * 2 Mbit/s for the range (480P,720P], 4 Mbit/s for the range (720P,1080P], and 8 Mbit/s for 1080p or higher.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        videoBitrate?: int;
        /**
         * Encoding format of the output video. Currently, only AVC and HEVC are supported.
         * If the source video is in HEVC format, the default value is **HEVC**. Otherwise, the default value is **AVC**.
         * @type { ?CodecMimeType }
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        videoCodec?: CodecMimeType;
        /**
         * Width of the output video frame, in px. The value range is [240 - 3840].
         * The default value is the width of the source video frame.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        videoFrameWidth?: int;
        /**
         * Height of the output video frame, in px. The value range is [240 - 2160].
         * The default value is the height of the source video frame.
         * @type { ?int }
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        videoFrameHeight?: int;
    }
    /**
     * A transcoding management class that provides APIs to transcode videos. Before calling any API in **AVTranscoder**,
     * you must use [createAVTranscoder()]{@link #createAVTranscoder} to create an **AVTranscoder** instance.
     *
     * @typedef AVTranscoder
     * @syscap SystemCapability.Multimedia.Media.AVTranscoder
     * @since 20
     */
    interface AVTranscoder {
        /**
         * Source media file descriptor, which specifies the data source.
         *
         * **Example:**
         *
         * There is a media file that stores continuous assets, the address offset is 0, and the byte length is 100.
         * Its file descriptor is **AVFileDescriptor { fd = resourceHandle; offset = 0; length = 100; }**.
         *
         * **NOTE**
         * - After the resource handle (FD) is transferred to an **AVTranscoder** instance, do not use the resource handle
         * to perform other read and write operations, including but not limited to transferring this handle to other
         * **AVPlayer**, **AVMetadataExtractor**, **AVImageGenerator**, or **AVTranscoder** instance.
         * Competition occurs when multiple **AVTranscoders** use the same resource handle to read and write files
         * at the same time, resulting in errors in obtaining data.
         * @type { AVFileDescriptor }
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        fdSrc: AVFileDescriptor;
        /**
         * Destination media file descriptor, which specifies the data source. After creating an **AVTranscoder** instance,
         * you must set both **fdSrc** and **fdDst**.
         *
         * **NOTE**
         * - After the resource handle (FD) is transferred to an **AVTranscoder** instance, do not use the resource handle
         * to perform other read and write operations, including but not limited to transferring this handle to other
         * **AVPlayer**, **AVMetadataExtractor**, **AVImageGenerator**, or **AVTranscoder** instance.
         * Competition occurs when multiple AVTranscoders use the same resource handle to read and write files
         * at the same time, resulting in errors in obtaining data.
         * @type { int }
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        fdDst: int;
        /**
         * Sets video transcoding parameters. This API uses a promise to return the result.
         * @param { AVTranscoderConfig } config - Video transcoding parameters to set.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 401 - The parameter check failed. Return by promise.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @throws { BusinessError } 5400106 - Unsupported format. Returned by promise.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        prepare(config: AVTranscoderConfig): Promise<void>;
        /**
         * Starts transcoding. This API uses a promise to return the result.
         *
         * This API can be called only after the [prepare()]{@link AVTranscoder.prepare} API is called.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        start(): Promise<void>;
        /**
         * Pauses transcoding. This API uses a promise to return the result.
         *
         * This API can be called only after the [start()]{@link AVTranscoder.start} API is called.
         * You can call [resume()]{@link AVTranscoder.resume} to resume transcoding.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        pause(): Promise<void>;
        /**
         * Resumes transcoding. This API uses a promise to return the result.
         *
         * This API can be called only after the [pause()]{@link AVTranscoder.pause} API is called.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        resume(): Promise<void>;
        /**
         * Cancels transcoding. This API uses a promise to return the result.
         * This API can be called only after the [prepare()]{@link AVTranscoder.prepare}, [start()]{@link AVTranscoder.start},
         * [pause()]{@link AVTranscoder.pause}, or [resume()]{@link AVTranscoder.resume} API is called.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400103 - IO error. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        cancel(): Promise<void>;
        /**
         * Releases the video transcoding resources. This API uses a promise to return the result.
         *
         * After the resources are released, you can no longer perform any operation on the **AVTranscoder** instance.
         * @returns { Promise<void> } Promise that returns no value.
         * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
         * @throws { BusinessError } 5400105 - Service died. Return by promise.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        release(): Promise<void>;
        /**
         * Subscribes to the event indicating that transcoding is complete.
         * An application can subscribe to only one transcoding completion event.
         * When the application initiates multiple subscriptions to this event, the last subscription is applied.
         *
         * When this event is reported, the current transcoding operation is complete.
         * You need to call [release()]{@link AVTranscoder.release} to exit the transcoding.
         * @param { 'complete' } type - Event type, which is **'complete'** in this case.
         * This event is triggered by the system during transcoding.
         * @param { Callback<void> } callback - Callback that has been registered to listen for
         * transcoding completion events.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        on(type: 'complete', callback: Callback<void>): void;
        /**
         * Subscribes to AVTranscoder errors. If this event is reported, call [release()]{@link AVTranscoder.release}
         * to exit the transcoding.
         *
         * An application can subscribe to only one AVTranscoder error event.
         * When the application initiates multiple subscriptions to this event, the last subscription is applied.
         * @param { 'error' } type - Event type, which is **'error'** in this case.
         *
         * This event is triggered when an error occurs during transcoding.
         * @param { ErrorCallback } callback - Callback invoked when the event is triggered.
         * @throws { BusinessError } 401 - The parameter check failed.
         * @throws { BusinessError } 801 - Capability not supported.
         * @throws { BusinessError } 5400101 - No memory.
         * @throws { BusinessError } 5400102 - Operation not allowed.
         * @throws { BusinessError } 5400103 - I/O error.
         * @throws { BusinessError } 5400104 - Time out.
         * @throws { BusinessError } 5400105 - Service died.
         * @throws { BusinessError } 5400106 - Unsupported format.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        on(type: 'error', callback: ErrorCallback): void;
        /**
         * Subscribes to transcoding progress updates. An application can subscribe to only one transcoding progress update
         * event. When the application initiates multiple subscriptions to this event, the last subscription is applied.
         * @param { 'progressUpdate' } type - Event type, which is **'progressUpdate'** in this case.
         * This event is triggered by the system during transcoding.
         * @param { Callback<int> } callback - Callback invoked when the event is triggered.
         * **progress** is a number that indicates the current transcoding progress.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        on(type: 'progressUpdate', callback: Callback<int>): void;
        /**
         * Unsubscribes from the event indicating that transcoding is complete.
         * @param { 'complete' } type - Event type, which is **'complete'** in this case.
         * This event can be triggered by both user operations and the system.
         * @param { Callback<void> } callback - Callback that has been registered to listen for
         * transcoding completion events.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        off(type: 'complete', callback?: Callback<void>): void;
        /**
         * Unsubscribes from AVTranscoder errors. After the unsubscription, your application can no longer
         * receive AVTranscoder errors.
         * @param { 'error' } type - 	Event type, which is **'error'** in this case.
         *
         * This event is triggered when an error occurs during transcoding.
         * @param { ErrorCallback } callback - Callback that has been registered to listen for AVTranscoder errors.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        off(type: 'error', callback?: ErrorCallback): void;
        /**
         * Unsubscribes from transcoding progress updates.
         * @param { 'progressUpdate' } type - Event type, which is **'progressUpdate'** in this case.
         * This event can be triggered by both user operations and the system.
         * @param { Callback<int> } callback - Called that has been registered to listen for progress updates.
         * You are advised to use the default value because only the last registered callback is retained in the current
         * callback mechanism.
         * @syscap SystemCapability.Multimedia.Media.AVTranscoder
         * @since 20
         */
        off(type: 'progressUpdate', callback?: Callback<int>): void;
    }
    /**
     * Enumerates the states available for the system screen recorder.
     *
     * @enum { number }
     * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
     * @systemapi
     * @since 20
     */
    enum ScreenCaptureEvent {
        /**
         * The system screen recorder starts screen capture.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @systemapi
         * @since 20
         */
        SCREENCAPTURE_STARTED = 0,
        /**
         * The system screen recorder stops screen capture.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @systemapi
         * @since 20
         */
        SCREENCAPTURE_STOPPED = 1
    }
    /**
     * A class that provides APIs to query and monitor the system screen recorder status. Before calling any API,
     * you must use getScreenCaptureMonitor() to obtain a ScreenCaptureMonitor instance.
     *
     * @typedef ScreenCaptureMonitor
     * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
     * @systemapi
     * @since 20
     */
    interface ScreenCaptureMonitor {
        /**
         * Subscribes to state change events of the system screen recorder. From the ScreenCaptureEvent event reported,
         * you can determine whether the system screen recorder is working.
         * @param { 'systemScreenRecorder' } type - Event type, which is **'systemScreenRecorder'** in this case.
         * This event is triggered when the state of the system screen recorder changes.
         * @param { Callback<ScreenCaptureEvent> } callback - Callback invoked when the event is triggered,
         * where ScreenCaptureEvent indicates the new state.
         * @throws { BusinessError } 202 - Not System App.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @systemapi
         * @since 20
         * @example
         * // This event is reported when the state of the system screen recorder changes.
         * screenCaptureMonitor.on('systemScreenRecorder', (event: media.ScreenCaptureEvent) => {
         *   // Set the 'systemScreenRecorder' event callback.
         *   console.info(`system ScreenRecorder event: ${event}`);
         * })
         */
        on(type: 'systemScreenRecorder', callback: Callback<ScreenCaptureEvent>): void;
        /**
         * Unsubscribes from state change events of the system screen recorder.
         * @param { 'systemScreenRecorder' } type - Event type, which is **'systemScreenRecorder'** in this case.
         * This event is triggered when the state of the system screen recorder changes.
         * @param { Callback<ScreenCaptureEvent> } callback - Callback invoked when the event is triggered,
         * where ScreenCaptureEvent indicates the new state. If this parameter is not specified, the last subscription event is canceled.
         * @throws { BusinessError } 202 - Not System App.
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @systemapi
         * @since 20
         * @example
         * screenCaptureMonitor.off('systemScreenRecorder');
         */
        off(type: 'systemScreenRecorder', callback?: Callback<ScreenCaptureEvent>): void;
        /**
         * Whether the system screen recorder is working.
         * @type { boolean }
         * @readonly
         * @syscap SystemCapability.Multimedia.Media.AVScreenCapture
         * @systemapi
         * @since 20
         */
        readonly isSystemScreenRecorderWorking: boolean;
    }
}
export default media;
