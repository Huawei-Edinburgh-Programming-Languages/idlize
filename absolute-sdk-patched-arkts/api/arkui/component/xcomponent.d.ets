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
import { ImageAIOptions, ImageAnalyzerConfig } from "./imageCommon";
import { CommonMethod, AttributeModifier, Callback } from "./common";
import { XComponentType } from "./enums";
import { VoidCallback } from "./units";
import { memo, ComponentBuilder } from "./../stateManagement/runtime";

/**
 * Surface Rectangle information.
 *
 * @interface SurfaceRect
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SurfaceRect {
    /**
     * The horizontal offset of the surface relative to XComponent.
     *
     * @type { ?double }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offsetX?: double;
    /**
     * The vertical offset of the surface relative to XComponent.
     *
     * @type { ?double }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    offsetY?: double;
    /**
     * The width of the surface created by XComponent
     *
     * @type { double }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    surfaceWidth: double;
    /**
     * The height of the surface created by XComponent
     *
     * @type { double }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    surfaceHeight: double;
}

/**
 * Defines the NativeXComponent Pointer type.
 *
 * @typedef { long } NativeXComponentPointer
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export type NativeXComponentPointer = long;

/**
 * Surface rotation options.
 *
 * @interface SurfaceRotationOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface SurfaceRotationOptions {
    /**
     * Lock property of the surface rotation.
     *
     * @type { ?boolean }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    lock?: boolean;
}

/**
 * Defines XComponentController
 *
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare class XComponentController {
    /**
     * Constructor.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    constructor();
    /**
     * Get the id of surface created by XComponent.
     *
     * @returns { string } The id of surface created by XComponent.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getXComponentSurfaceId(): string;
    /**
     * Set the rectangle information of surface created by XComponent.
     *
     * @param { SurfaceRect } rect - The surface rectangle information.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setXComponentSurfaceRect(rect: SurfaceRect): void;
    /**
     * Get the rectangle information of Surface created by XComponent.
     *
     * @returns { SurfaceRect } The surface rectangle information.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getXComponentSurfaceRect(): SurfaceRect;
    /**
     * Set the rotation options of the Surface created by XComponent.
     *
     * @param { SurfaceRotationOptions } rotationOptions - The surface rotation options.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    setXComponentSurfaceRotation(rotationOptions: SurfaceRotationOptions): void;
    /**
     * Get the rotation options result of the Surface created by XComponent.
     *
     * @returns { Required<SurfaceRotationOptions> } The surface rotation options result.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    getXComponentSurfaceRotation(): Required<SurfaceRotationOptions>;
    /**
     * Called after the surface is first created.
     *
     * @param { string } surfaceId - The id of the surface created by XComponent.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onSurfaceCreated(surfaceId: string): void;
    /**
     * Called after the surface rectangle information is changed.
     *
     * @param { string } surfaceId - The id of the surface created by XComponent.
     * @param { SurfaceRect } rect - The rectangle information of the surface created by XComponent.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onSurfaceChanged(surfaceId: string, rect: SurfaceRect): void;
    /**
     * Called when the surface is about to be destroyed.
     *
     * @param { string } surfaceId - The id of the surface created by XComponent.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    onSurfaceDestroyed(surfaceId: string): void;
    /**
     * Start image analyzer.
     *
     * @param { ImageAnalyzerConfig } config - Image analyzer config.
     * @returns { Promise<void> } The promise returned by the function.
     * @throws { BusinessError } 110001 - Image analysis feature is unsupported.
     * @throws { BusinessError } 110002 - Image analysis is currently being executed.
     * @throws { BusinessError } 110003 - Image analysis is stopped.
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    startImageAnalyzer(config: ImageAnalyzerConfig): Promise<void>;
    /**
     * Stop image analyzer.
     *
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    stopImageAnalyzer(): void;
}

/**
 * Defines the xcomponent options.
 *
 * @interface XComponentOptions
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface XComponentOptions {
    /**
     * The type of xcomponent
     *
     * @type { XComponentType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type: XComponentType;
    /**
     * The controller of xcomponent.
     *
     * @type { XComponentController }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    controller: XComponentController;
    /**
     * Image ai options.
     *
     * @type { ?ImageAIOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    imageAIOptions?: ImageAIOptions;
    /**
    * Identifier of a screen.
    *
    * @type { ?long }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @systemapi
    * @since 20
    */
    screenId?: long;
}

/**
 * Defines the native xcomponent parameters.
 *
 * @interface NativeXComponentParameters
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface NativeXComponentParameters {
    /**
     * The type of xcomponent
     *
     * @type { XComponentType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type: XComponentType;
    /**
     * Image ai options.
     *
     * @type { ?ImageAIOptions }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    imageAIOptions?: ImageAIOptions;
}

/**
 * Defines the XComponent attribute.
 *
 * @extends CommonMethod
 * @interface XComponentAttribute
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface XComponentAttribute extends CommonMethod {
    /**
     * Called when judging whether the xcomponent surface is created.
     *
     * @param { VoidCallback | undefined } callback - Called when judging whether the xcomponent surface is created.
     * @returns { XComponentAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onLoad(callback: VoidCallback | undefined): this;
    /**
     * Called when judging whether the xcomponent is destroyed.
     *
     * @param { VoidCallback | undefined } event - Called when judging whether the xcomponent is destroyed.
     * @returns { XComponentAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default onDestroy(event: VoidCallback | undefined): this;
    /**
     * Enable image analyzer for XComponent.
     *
     * @param { boolean | undefined } enable
     * @returns { XComponentAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableAnalyzer(enable: boolean | undefined): this;
    /**
     * Enable privacy protection for XComponent.
     *
     * @param { boolean | undefined } isSecure
     * @returns { XComponentAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default enableSecure(isSecure: boolean | undefined): this;
    /**
     * Set hdrBrightness for XComponent.
     *
     * @param { double | undefined } brightness - control the brightness of HDR video
     * @returns { XComponentAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default hdrBrightness(brightness: double | undefined): this;
    /**
     * Call attributeModifier.
     *
     * @param { AttributeModifier<XComponentAttribute> | AttributeModifier<CommonMethod> | undefined } modifier
     * @returns { XComponentAttribute }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    default attributeModifier(modifier: AttributeModifier<XComponentAttribute> | AttributeModifier<CommonMethod> | undefined): this;
}

/**
 * Defines the XComponent parameter interface.
 *
 * @interface XComponentParameters
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export declare interface XComponentParameters {
    /**
     * The id of xcomponent
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    id: string;
    /**
     * The type of xcomponent
     *
     * @type { XComponentType }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    type: XComponentType;
    /**
     * The callback to handle NativeXComponent Pointer.
     *
     * @type { Callback<NativeXComponentPointer> }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    nativeXComponentHandler: Callback<NativeXComponentPointer>;
    /**
     * The controller of xcomponent.
     *
     * @type { ?XComponentController }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */
    controller?: XComponentController;
}

/**
 * XComponent is returned when the parameter is transferred.
 *
 * @param { XComponentParameters | XComponentOptions | NativeXComponentParameters } params -
 *     The options to create an XComponent
 * @param { function } [content_]
 * @returns { XComponentAttribute } The attribute of the XComponent
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@memo
@ComponentBuilder
export declare function XComponent(
    params: XComponentParameters | XComponentOptions | NativeXComponentParameters, 
    @memo
    content_?: () => void,
): XComponentAttribute
