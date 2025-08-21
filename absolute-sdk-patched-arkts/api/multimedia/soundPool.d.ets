/*
 * Copyright (c) 2021-2025 Huawei Device Co., Ltd.
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
import { ErrorCallback, AsyncCallback, Callback, BusinessError } from '../@ohos.base';
import type audio from '../@ohos.multimedia.audio';
import media from '../@ohos.multimedia.media';
import resourceManager from '../@ohos.resourceManager';
/**
 * Describes the playback parameters of the sound pool.
 *
 * These parameters are used to control the playback volume, number of loops, and priority.
 *
 * @typedef PlayParameters
 * @syscap SystemCapability.Multimedia.Media.SoundPool
 * @since 20
 */
export interface PlayParameters {
    /**
     * Number of loops.
     *
     * If this parameter is set to a value greater than or equal to 0, the number of times the content
     * is actually played is the value of **loop** plus 1.
     *
     * If this parameter is set to a value less than 0, the content is played repeatedly.
     *
     * The default value is **0**, indicating that the content is played only once.
     *
     * @type { ?int }
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    loop?: int;
    /**
     * Playback rate. For details, see [AudioRendererRate]{@link #audio.AudioRendererRate}. Default value: **0**.
     *
     * @type { ?int }
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    rate?: int;
    /**
     * Volume of the left channel. The value ranges from 0.0 to 1.0. Default value: **1.0**.
     *
     * @type { ?double }
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    leftVolume?: double;
    /**
     * Volume of the right channel. The value ranges from 0.0 to 1.0. (Currently, the volume cannot be set separately
     * for the left and right channels. The volume set for the left channel is used.) Default value: **1.0**.
     *
     * @type { ?double }
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    rightVolume?: double;
    /**
     * Playback priority. The value **0** means the lowest priority. A larger value indicates a higher priority.
     * The value is an integer greater than or equal to 0. Default value: **0**.
     *
     * @type { ?int }
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    priority?: int;
    /**
     * Whether the sound can be played in parallel with other active audio streams. The value **true** means that the
     * sound can be played in parallel with other active audio streams, without preempting the audio focus,
     * and **false** means the opposite. The default value is **false**.
     *
     * This is a system API.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @systemapi
     * @since 20
     */
    parallelPlayFlag?: boolean;
}
/**
 * Implements a sound pool that provides APIs for loading, unloading, playing, and stopping playing system sounds,
 * setting the volume, and setting the number of loops. Before using these APIs, you must call
 * [createSoundPool]{@link #media.createSoundPool} to create a **SoundPool** instance.
 *
 * **NOTE**
 *
 * When using the **SoundPool** instance, you are advised to register the following callbacks to proactively obtain
 * status changes:
 * - on('loadComplete'): listens for the event indicating that the resource loading is finished.
 * - on('playFinishedWithStreamId'): listens for the event indicating that the playback is finished and
 * returns the stream ID of the audio that finishes playing.
 * - on('playFinished'): listens for the event indicating that the playback is finished.
 * - on('error'): listens for error events.
 *
 * @typedef SoundPool
 * @syscap SystemCapability.Multimedia.Media.SoundPool
 * @since 20
 */
export declare interface SoundPool {
    /**
     * Loads a sound. This API uses an asynchronous callback to obtain the sound ID.
     * The input parameter **uri** is a string starting with fd://, which is generated based on the file descriptor (FD)
     * obtained. This API cannot be used to load resources in the **rawfile** directory.
     * Instead, use load(fd: number, offset: number, length: number, callback: AsyncCallback<number>): void or
     * load(fd: number, offset: number, length: number): Promise<number>.
     *
     * **NOTE**
     *
     * After the resource handle (in the form of an FD) or path description (in the form of a URI) is transferred to
     * the AVPlayer, do not use the resource handle or path description in read or write operations,
     * including but not limited to transferring it to multiple AVPlayers. Competition occurs when multiple AVPlayers use
     * the same resource handle or path description to read and write files at the same time, resulting in playback errors.
     *
     * @param {string} uri - URI of the audio file to load. Generally, the URI starts with fd://.
     * @param {AsyncCallback<int>} callback - Callback used to return the sound ID. A valid value must be
     * greater than 0.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
     * @throws { BusinessError } 5400103 - I/O error. Return by callback.
     * @throws { BusinessError } 5400105 - Service died. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    load(uri: string, callback: AsyncCallback<int>): void;
    /**
     * Loads a sound. This API uses a promise to obtain the sound ID. The input parameter **uri** is a starting with
     * fd://, which is generated based on the FD obtained. This API cannot be used to load resources in the **rawfile**
     * directory.
     * Instead, use load(fd: number, offset: number, length: number, callback: AsyncCallback<number>): void or
     * load(fd: number, offset: number, length: number): Promise<number>.
     *
     * **NOTE**
     *
     * After the resource handle (in the form of an FD) or path description (in the form of a URI)
     * is transferred to the AVPlayer, do not use the resource handle or path description in read or write operations,
     * including but not limited to transferring it to multiple AVPlayers. Competition occurs when multiple AVPlayers
     * use the same resource handle or path description to read and write files at the same time,
     * resulting in playback errors.
     *
     * @param {string} uri - URI of the audio file to load. Generally, the URI starts with fd://.
     * @returns {Promise<int>} Promise used to return the sound ID. A valid value must be greater than 0.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
     * @throws { BusinessError } 5400103 - I/O error. Return by promise.
     * @throws { BusinessError } 5400105 - Service died. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    load(uri: string): Promise<int>;
    /**
     * Loads a sound. This API uses an asynchronous callback to obtain the sound ID. The input parameter **fd** can be
     * manually input or automatically obtained by reading the embedded resource of the application.
     *
     * **NOTE**
     *
     * After the resource handle (in the form of an FD) or path description (in the form of a URI) is transferred to
     * the AVPlayer, do not use the resource handle or path description in read or write operations, including but not
     * limited to transferring it to multiple AVPlayers. Competition occurs when multiple AVPlayers use the same resource
     * handle or path description to read and write files at the same time, resulting in playback errors.
     *
     * @param {int} fd - Resource handle, which is obtained by calling
     * [resourceManager.getRawFd]{@link resourceManager.resourceManager.getRawFile}.
     * @param {long} offset - Resource offset, which needs to be entered based on the preset resource information.
     * An invalid value causes a failure to parse audio and video resources.
     * @param {long} length - Resource length, which needs to be entered based on the preset resource information.
     * An invalid value causes a failure to parse audio and video resources.
     * @param {AsyncCallback<int>} callback - Callback used to return the sound ID.
     * A valid value must be greater than 0.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
     * @throws { BusinessError } 5400103 - I/O error. Return by callback.
     * @throws { BusinessError } 5400105 - Service died. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    load(fd: int, offset: long, length: long, callback: AsyncCallback<int>): void;
    /**
     * Loads a sound. This API uses a promise to obtain the sound ID. The input parameter **fd** can be manually input or
     * automatically obtained by reading the embedded resource of the application.
     *
     * **NOTE**
     *
     * After the resource handle (in the form of an FD) or path description (in the form of a URI) is transferred to the
     * AVPlayer, do not use the resource handle or path description in read or write operations, including but not
     * limited to transferring it to multiple AVPlayers. Competition occurs when multiple AVPlayers use the same resource
     * handle or path description to read and write files at the same time, resulting in playback errors.
     *
     * @param {int} fd - Resource handle, which is obtained by calling
     * [resourceManager.getRawFd]{@link resourceManager.resourceManager.getRawFile}.
     * @param {long} offset - Resource offset, which needs to be entered based on the preset resource information.
     * An invalid value causes a failure to parse audio and video resources.
     * @param {long} length - Resource length, which needs to be entered based on the preset resource information.
     * An invalid value causes a failure to parse audio and video resources.
     * @returns {Promise<int>} Promise used to return the sound ID. A valid value must be greater than 0.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
     * @throws { BusinessError } 5400103 - I/O error. Return by promise.
     * @throws { BusinessError } 5400105 - Service died. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    load(fd: int, offset: long, length: long): Promise<int>;
    /**
     * Plays a sound. This API uses an asynchronous callback to obtain the audio stream ID.
     *
     * @param {int} soundID - Sound ID, which is obtained by calling **load()**.
     * @param {PlayParameters} params - Playback parameters.
     * @param {AsyncCallback<int>} callback - Callback used to return the audio stream ID.
     * A valid value must be greater than 0.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by callback.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
     * @throws { BusinessError } 5400105 - Service died. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    play(soundID: int, params: PlayParameters, callback: AsyncCallback<int>): void;
    /**
     * Plays a sound. This API uses an asynchronous callback to obtain the audio stream ID.
     *
     * @param {int} soundID - Sound ID, which is obtained by calling **load()**.
     * @param {AsyncCallback<int>} callback - Callback used to return the audio stream ID.
     * A valid value must be greater than 0.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by callback.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
     * @throws { BusinessError } 5400105 - Service died. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    play(soundID: int, callback: AsyncCallback<int>): void;
    /**
     * Plays a sound. This API uses a promise to obtain the audio stream ID.
     *
     * @param {int} soundID - Sound ID, which is obtained by calling **load()**.
     * @param {PlayParameters} params - Playback parameters.
     * @returns {Promise<int>} Promise used to return the audio stream ID. A valid value must be greater than 0.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by promise.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
     * @throws { BusinessError } 5400105 - Service died. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    play(soundID: int, params?: PlayParameters): Promise<int>;
    /**
     * Stops playing a sound. This API uses an asynchronous callback to return the result.
     *
     * @param {int} streamID - Audio stream ID, which is obtained by calling **play()**.
     * @param {AsyncCallback<void>} callback - Callback used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by callback.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
     * @throws { BusinessError } 5400105 - Service died. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    stop(streamID: int, callback: AsyncCallback<void>): void;
    /**
     * Stops playing a sound. This API uses a promise to return the result.
     *
     * @param {int} streamID - Audio stream ID, which is obtained by calling **play()**.
     * @returns {Promise<void>} Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by promise.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
     * @throws { BusinessError } 5400105 - Service died. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    stop(streamID: int): Promise<void>;
    /**
     * Sets the loop mode for an audio stream. This API uses an asynchronous callback to return the result.
     *
     * @param {int} streamID - Audio stream ID, which is obtained by calling **play()**.
     * @param {int} loop - Number of loops.
     *
     * If this parameter is set to a value greater than or equal to 0, the number of times the content is actually
     * played is the value of **loop** plus 1.
     *
     * If this parameter is set to a value less than 0, the content is played repeatedly.
     * @param {AsyncCallback<void>} callback - Callback used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by callback.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
     * @throws { BusinessError } 5400105 - Service died. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    setLoop(streamID: int, loop: int, callback: AsyncCallback<void>): void;
    /**
     * Sets the loop mode for an audio stream. This API uses a promise to return the result.
     *
     * @param {int} streamID - Audio stream ID, which is obtained by calling **play()**.
     * @param {int} loop - Number of loops.
     *
     * If this parameter is set to a value greater than or equal to 0, the number of times the content is actually
     * played is the value of **loop** plus 1.
     *
     * If this parameter is set to a value less than 0, the content is played repeatedly.
     * @returns {Promise<void>} Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by promise.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
     * @throws { BusinessError } 5400105 - Service died. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    setLoop(streamID: int, loop: int): Promise<void>;
    /**
     * Sets the priority for an audio stream. This API uses an asynchronous callback to return the result.
     *
     * @param {int} streamID - Audio stream ID, which is obtained by calling **play()**.
     * @param {int} priority - Priority. The value **0** means the lowest priority. The value is an integer
     * greater than or equal to 0.
     * @param {AsyncCallback<void>} callback - Callback used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by callback.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
     * @throws { BusinessError } 5400105 - Service died. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    setPriority(streamID: int, priority: int, callback: AsyncCallback<void>): void;
    /**
     * Sets the priority for an audio stream. This API uses a promise to return the result.
     *
     * @param {int} streamID - Audio stream ID, which is obtained by calling **play()**.
     * @param {int} priority - Priority. The value **0** means the lowest priority. The value is an integer
     * greater than or equal to 0.
     * @returns {Promise<void>} Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by promise.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
     * @throws { BusinessError } 5400105 - Service died. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    setPriority(streamID: int, priority: int): Promise<void>;
    /**
     * Sets the playback rate for an audio stream. This API uses an asynchronous callback to return the result.
     *
     * @param {int} streamID - Audio stream ID, which is obtained by calling **play()**.
     * @param {audio.AudioRendererRate} rate - Playback rate.
     * @param {AsyncCallback<void>} callback - Callback used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by callback.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
     * @throws { BusinessError } 5400105 - Service died. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    setRate(streamID: int, rate: audio.AudioRendererRate, callback: AsyncCallback<void>): void;
    /**
     * Sets the playback rate for an audio stream. This API uses a promise to return the result.
     *
     * @param {int} streamID - Audio stream ID, which is obtained by calling **play()**.
     * @param {audio.AudioRendererRate} rate - Playback rate.
     * @returns {Promise<void>} Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by promise.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
     * @throws { BusinessError } 5400105 - Service died. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    setRate(streamID: int, rate: audio.AudioRendererRate): Promise<void>;
    /**
     * Sets the volume for an audio stream. This API uses an asynchronous callback to return the result.
     *
     * @param {int} streamID - Audio stream ID, which is obtained by calling **play()**.
     * @param {double} leftVolume - Volume of the left channel. The value ranges from 0.0 to 1.0.
     * @param {double} rightVolume - Volume of the right channel. The value ranges from 0.0 to 1.0. Currently,
     * setting the volume for the right channel does not take effect. The volume set for the left channel is used.
     * @param {AsyncCallback<void>} callback - Callback used to return the result.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by callback.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
     * @throws { BusinessError } 5400105 - Service died. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    setVolume(streamID: int, leftVolume: double, rightVolume: double, callback: AsyncCallback<void>): void;
    /**
     * Sets the volume for an audio stream. This API uses a promise to return the result.
     *
     * @param {int} streamID - Audio stream ID, which is obtained by calling **play()**.
     * @param {double} leftVolume - Volume of the left channel. The value ranges from 0.0 to 1.0.
     * @param {double} rightVolume - Volume of the right channel. The value ranges from 0.0 to 1.0. Currently,
     * setting the volume for the right channel does not take effect. The volume set for the left channel is used.
     * @returns {Promise<void>} Promise that returns no value.
     * @throws { BusinessError } 401 - Parameter error. Possible causes: 1.Mandatory parameters are left unspecified.
     * 2.Incorrect parameter types. 3.Parameter verification failed. Return by promise.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
     * @throws { BusinessError } 5400105 - Service died. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    setVolume(streamID: int, leftVolume: double, rightVolume: double): Promise<void>;
    /**
     * Unloads a sound. This API uses an asynchronous callback to return the result.
     *
     * @param {int} soundID - Sound ID, which is obtained by calling **load()**.
     * @param {AsyncCallback<void>} callback - Callback used to return the result.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by callback.
     * @throws { BusinessError } 5400103 - I/O error. Return by callback.
     * @throws { BusinessError } 5400105 - Service died. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    unload(soundID: int, callback: AsyncCallback<void>): void;
    /**
     * Unloads a sound. This API uses a promise to return the result.
     *
     * @param {int} soundID - Sound ID, which is obtained by calling **load()**.
     * @returns {Promise<void>} Promise that returns no value.
     * @throws { BusinessError } 5400102 - Operation not allowed. Return by promise.
     * @throws { BusinessError } 5400103 - I/O error. Return by promise.
     * @throws { BusinessError } 5400105 - Service died. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    unload(soundID: int): Promise<void>;
    /**
     * Releases this **SoundPool** instance. This API uses an asynchronous callback to return the result.
     *
     * @param {AsyncCallback<void>} callback - Callback used to return the result.
     * @throws { BusinessError } 5400105 - Service died. Return by callback.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    release(callback: AsyncCallback<void>): void;
    /**
     * Releases this **SoundPool** instance. This API uses a promise to return the result.
     *
     * @returns {Promise<void>} Promise that returns no value.
     * @throws { BusinessError } 5400105 - Service died. Return by promise.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    release(): Promise<void>;
    /**
     * Subscribes to events indicating that a sound finishes loading.
     *
     * @param {'loadComplete'} type - Event type, which is **'loadComplete'** in this case.
     * This event is triggered when a sound is loaded.
     * @param {Callback<int>} callback - ID of the sound that has been loaded.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    on(type: 'loadComplete', callback: Callback<int>): void;
    /**
     * Unsubscribes from events indicating that a sound finishes loading.
     *
     * @param {'loadComplete'} type - Event type. The value is fixed at **'loadComplete'**.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    off(type: 'loadComplete'): void;
    /**
     * Subscribes to events indicating the completion of audio playback and returns the stream ID of the audio
     * that finishes playing.
     *
     * When only on('playFinished') or on('playFinishedWithStreamId') is subscribed to, the registered
     * callback is triggered when the audio playback is complete.
     *
     * When both on('playFinished') and on('playFinishedWithStreamId') are subscribed to,
     * the 'playFinishedWithStreamId' callback is triggered, but the 'playFinished' callback is not triggered,
     * when the audio playback is complete.
     *
     * @param {'playFinishedWithStreamId'} type - Event type, which is **'playFinishedWithStreamId'** in this case.
     *     This event is triggered when an audio stream finishes playing, and the stream ID is returned.
     * @param {Callback<int>} callback - Callback used to return the result. Stream ID of the audio that
     *     finishes playing.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    on(type: 'playFinishedWithStreamId', callback: Callback<int>): void;
    /**
     * Unsubscribes from events indicating that a sound finishes playing.
     *
     * @param {'playFinishedWithStreamId'} type - Event type. The value is fixed at **'playFinishedWithStreamId'**.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    off(type: 'playFinishedWithStreamId'): void;
    /**
     * Subscribes to events indicating that a sound finishes playing.
     *
     * @param {'playFinished'} type - Event type, which is **'playFinished'** in this case.
     * This event is triggered when a sound finishes playing.
     * @param {Callback<void>} callback - Callback used to return the result.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    on(type: 'playFinished', callback: Callback<void>): void;
    /**
     * Unsubscribes from events indicating that a sound finishes playing.
     *
     * @param {'playFinished'} type - Event type. The value is fixed at **'playFinished'**.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    off(type: 'playFinished'): void;
    /**
     * Subscribes to error events of this **SoundPool** instance. This event is used only for error prompt.
     *
     * @param {'error'} type - Event type, which is **'error'** in this case.
     * This event can be triggered by both user operations and the system.
     * @param {ErrorCallback} callback - Callback used to return the error code ID and error message.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    on(type: 'error', callback: ErrorCallback): void;
    /**
     * Unsubscribes from error events of this **SoundPool** instance.
     *
     * @param {'error'} type - Event type, which is **'error'** in this case.
     * @syscap SystemCapability.Multimedia.Media.SoundPool
     * @since 20
     */
    off(type: 'error'): void;
}
