/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
 * @kit ArkUI
 * @arkts 1.2
 */
import { Resource } from '../../global/resource';
import { ImageAIOptions, ImageAnalyzerConfig } from "./imageCommon";
import { ImageFit } from "./enums";
import { CommonMethod, Callback, PixelMap, AttributeModifier } from "./common";
import { VoidCallback } from "./units";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";

/**
 * Seek mode.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum SeekMode {
    /**
     * Sync to keyframes before the time point.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    PreviousKeyframe,
    /**
     * Sync to keyframes after the time point.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    NextKeyframe,
    /**
     * Sync to closest keyframes.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    ClosestKeyframe,
    /**
     * Seek to frames closest the time point.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Accurate
}

/**
 * playback speed.
 *
 * @enum { number }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare enum PlaybackSpeed {
    /**
     * 0.75x speed playback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Speed_Forward_0_75_X,
    /**
     * 1.00x speed playback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Speed_Forward_1_00_X,
    /**
     * 1.25x speed playback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Speed_Forward_1_25_X,
    /**
     * 1.75x speed playback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Speed_Forward_1_75_X,
    /**
     * 2.00x speed playback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    Speed_Forward_2_00_X
}

/**
 * Fullscreen information of the video.
 *
 * @typedef FullscreenInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface FullscreenInfo {
    /**
     * The flag whether play in full screen.
     *
     * @type { boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    fullscreen: boolean;
}

/**
 * Prepared information of the video.
 *
 * @typedef PreparedInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface PreparedInfo {
    /**
     * The duration of the current video, in seconds.
     *
     * @type { int }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    duration: int;
}

/**
 * Playback information of the video.
 *
 * @typedef PlaybackInfo
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface PlaybackInfo {
    /**
     * The current video playback progress, expressed in seconds.
     *
     * @type { int }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    time: int;
}

/**
 * Defines the video poster options.
 *
 * @interface PosterOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface PosterOptions {
    /**
     * Whether to display the first frame of video on prepared status of AVPlayer.
     *
     * @type { ?boolean }
     * @default false
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    showFirstFrame?: boolean;
}

/**
 * Defines the video options.
 *
 * @interface VideoOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface VideoOptions {
    /**
     * src of video.
     *
     * @type { ?(string | Resource) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    src?: string | Resource;
    /**
     * playback rate of video.
     *
     * @type { ?(double | string | PlaybackSpeed) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    currentProgressRate?: double | string | PlaybackSpeed;
    /**
     * preview uri of video.
     *
     * @type { ?(string | PixelMap | Resource) }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    previewUri?: string | PixelMap | Resource;
    /**
     * controller of video.
     *
     * @type { ?VideoController }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    controller?: VideoController;
    /**
     * image ai options of video.
     *
     * @type { ?ImageAIOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    imageAIOptions?: ImageAIOptions;
    /**
     * poster options of video.
     *
     * @type { ?PosterOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    posterOptions?: PosterOptions;
}

/**
 * Defines the video controller.
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class VideoController {
    /**
     * constructor.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor();
    /**
     * Provides events to play.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    start(): void;
    /**
     * Provides a pause event for playback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    pause(): void;
    /**
     * Provides an event to stop playback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stop(): void;
    /**
     * Provides a full screen playback method.
     *
     * @param { boolean } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    requestFullscreen(value: boolean): void;
    /**
     * Provides a method to exit full screen playback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    exitFullscreen(): void;
    /**
     * Provide the progress method of video playback without SeekMode.
     *
     * @param { double } value
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setCurrentTimeDefault(value: double): void;
    /**
     * Provide the progress method of video playback with SeekMode.
     *
     * @param { double } value
     * @param { SeekMode } seekMode
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setCurrentTimeWithMode(value: double, seekMode: SeekMode): void;
    /**
     * Provide the progress method of video playback.
     *
     * @overload { setCurrentTimeDefault, setCurrentTimeWithMode }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    overload setCurrentTime { setCurrentTimeDefault, setCurrentTimeWithMode };
    /**
     * Provide the reset method of video playback.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    reset(): void;
}

/**
 * Defines the Video attribute.
 *
 * @extends CommonMethod
 * @interface VideoAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface VideoAttribute extends CommonMethod {
    /**
     * Called when judging whether the video is muted.
     *
     * @param { boolean | undefined } value
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default muted(value: boolean | undefined): this;
    /**
     * Called when judging whether the video is played automatically.
     *
     * @param { boolean | undefined } value
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default autoPlay(value: boolean | undefined): this;
    /**
     * Called when judging whether the control bar is displayed.
     *
     * @param { boolean | undefined } value
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default controls(value: boolean | undefined): this;
    /**
     * Called when judging whether the video is played circular.
     *
     * @param { boolean | undefined } value
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default loop(value: boolean | undefined): this;
    /**
     * Called when determining the zoom type of the video source.
     *
     * @param { ImageFit | undefined } value
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default objectFit(value: ImageFit | undefined): this;
    /**
     * Called when the video is played.
     *
     * @param { VoidCallback | undefined } event
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onStart(event: VoidCallback | undefined): this;
    /**
     * Called when the video is paused.
     *
     * @param { VoidCallback | undefined } event
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onPause(event: VoidCallback | undefined): this;
    /**
     * Called when the video playback ends.
     *
     * @param { VoidCallback | undefined } event
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onFinish(event: VoidCallback | undefined): this;
    /**
     * Called when the video enters and exits the full screen.
     *
     * @param { Callback<FullscreenInfo> | undefined } callback
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onFullscreenChange(callback: Callback<FullscreenInfo> | undefined): this;
    /**
     * Called when the video preparation is complete.
     *
     * @param { Callback<PreparedInfo> | undefined } callback
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onPrepared(callback: Callback<PreparedInfo> | undefined): this;
    /**
     * Called when the time information is reported when the progress bar process is operated.
     *
     * @param { Callback<PlaybackInfo> | undefined } callback
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onSeeking(callback: Callback<PlaybackInfo> | undefined): this;
    /**
     * Called when the playback time information is reported after the operation progress bar is completed.
     *
     * @param { Callback<PlaybackInfo> | undefined } callback
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onSeeked(callback: Callback<PlaybackInfo> | undefined): this;
    /**
     * Called when the playback progress changes.
     *
     * @param { Callback<PlaybackInfo> | undefined } callback
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onUpdate(callback: Callback<PlaybackInfo> | undefined): this;
    /**
     * Called when playback fails.
     *
     * @param { (() => void) | undefined } event
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onError(event: (() => void) | undefined): this;
    /**
     * Called when the video is stopped.
     *
     * @param { VoidCallback | undefined } event
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onStop(event: VoidCallback | undefined): this;
    /**
     * Enable image analyzer.
     *
     * @param { boolean | undefined } enable
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableAnalyzer(enable: boolean | undefined): this;
    /**
     * Set image analyzer with config.
     *
     * @param { ImageAnalyzerConfig | undefined } config
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default analyzerConfig(config: ImageAnalyzerConfig | undefined): this;
    /**
     * Indicates whether to response shortcut key. The default value is false.
     * If the value is true, video will respond to the shortcut keys as follows:
     * Space key: play/pause the video.
     * Up/Down arrow key: turn up/down volume of the video.
     * Right/Left arrow key: fast forward/backward the video.
     *
     * @param { boolean | undefined } enabled
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableShortcutKey(enabled: boolean | undefined): this;
    /**
     * Call attributeModifier.
     *
     * @param { AttributeModifier<VideoAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { VideoAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<VideoAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Video is returned when the parameter is transferred.
 *
 * @param { VideoOptions } value - The options to create a Video
 * @param { function } [content_]
 * @returns { VideoAttribute } The attribute of the Video
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function Video(
    value: VideoOptions, 
    @memo
    content_?: () => void,
): VideoAttribute
