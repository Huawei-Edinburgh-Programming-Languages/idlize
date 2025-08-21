/*
 * Copyright (c) 2021-2025 Huawei Device Co., Ltd.
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

import { AsyncCallback } from './@ohos.base';
import Want from './@ohos.app.ability.Want';

/**
 * Plugin component template property.
 *
 * @interface PluginComponentTemplate
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
export interface PluginComponentTemplate {
  /**
   * Defines the source
   *
   * @type { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  source: string;

  /**
   * Defines the ability
   *
   * @type { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  ability: string;
}

/**
 * Plugin component manager interface.
 *
 * @namespace pluginComponentManager
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
declare namespace pluginComponentManager {
  /**
   * Defines KVObject
   *
   * @typedef { object } KVObject
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  /**
   * Defines KVObject
   *
   * @typedef { Record<string, int | long | double | string | boolean | Array<KVObject> | KVObject> } KVObject
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export type KVObject = Record<string, int | long | double | string | boolean | Array<KVObject> | KVObject>  
  /**
   * Plugin component push parameters.
   *
   * @interface PushParameters
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export interface PushParameters {
    /**
     * Defines want.
     *
     * @type { Want }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */    
    want: Want;

    /**
     * Defines name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    name: string;

    /**
     * Defines data.
     *
     * @type { KVObject }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    data: KVObject;

    /**
     * Defines extraData.
     *
     * @type { KVObject }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    extraData: KVObject;

    /**
     * Defines jsonPath.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    jsonPath?: string;
  }

  /**
   * Plugin component push parameters which is used in push function.
   *
   * @interface PushParameterForStage
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  export interface PushParameterForStage {
    /**
     * Defines owner.
     *
     * @type { Want }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */  
    owner: Want;

    /**
     * Defines target.
     *
     * @type { Want }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */  
    target: Want;

    /**
     * Defines name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */  
    name: string;

    /**
     * Defines data.
     *
     * @type { KVObject }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */  
    data: KVObject;

    /**
     * Defines extraData.
     *
     * @type { KVObject }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */  
    extraData: KVObject;

    /**
     * Defines jsonPath.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */  
    jsonPath?: string;
  }

  /**
   * Plugin component request parameters.
   *
   * @interface RequestParameters
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export interface RequestParameters {
    /**
     * Defines want.
     *
     * @type { Want }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */  
    want: Want;

    /**
     * Defines name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */  
    name: string;

    /**
     * Defines data.
     *
     * @type { KVObject }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */  
    data: KVObject;

    /**
     * Defines jsonPath.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    jsonPath?: string;
  }

  /**
   * Plugin component request parameters which is used in request function.
   *
   * @interface RequestParameterForStage
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  export interface RequestParameterForStage {
    /**
     * Defines owner.
     *
     * @type { Want }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */    
    owner: Want;

    /**
     * Defines target.
     *
     * @type { Want }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */  
    target: Want;
    /**
     * Defines name.
     *
     * @type { string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */  
    name: string;

    /**
     * Defines data.
     *
     * @type { KVObject }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */  
    data: KVObject;

    /**
     * Defines jsonPath.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @systemapi
     * @since 20
     */  
    jsonPath?: string;
  }

  /**
   * Plugin component request callback parameters.
   *
   * @interface RequestCallbackParameters
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export interface RequestCallbackParameters {

    /**
     * Defines componentTemplate.
     *
     * @type { PluginComponentTemplate }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    componentTemplate: PluginComponentTemplate;

    /**
     * Defines data.
     *
     * @type { KVObject }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    data: KVObject;

    /**
     * Defines extraData.
     *
     * @type { KVObject }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    extraData: KVObject;
  }

  /**
   * Plugin component request event result value.
   *
   * @interface RequestEventResult
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export interface RequestEventResult {
    /**
     * Defines template.
     *
     * @type { ?string }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    template?: string;

    /**
     * Defines data.
     *
     * @type { ?KVObject }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    data?: KVObject;

    /**
     * Defines extraData.
     *
     * @type { ?KVObject }
     * @syscap SystemCapability.ArkUI.ArkUI.Full
     * @since 20
     */ 
    extraData?: KVObject;
  }

  /**
   * Plugin component push event callback.
   *
   * @typedef { function } OnPushEventCallback
   * @param { Want } source - Push request sender's relevant information.
   * @param { PluginComponentTemplate } template - Request component template name.
   * @param { KVObject } data - data info.
   * @param { KVObject } extraData - extra data info.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export type OnPushEventCallback = (source: Want, template: PluginComponentTemplate, data: KVObject,
    extraData: KVObject) => void;

  /**
   * Plugin component request event callback.
   *
   * @typedef { function } OnRequestEventCallback
   * @param { Want } source - Request the sender to provide relevant information.
   * @param { string } name - Template name.
   * @param { KVObject } data - data info.
   * @returns { RequestEventResult }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export type OnRequestEventCallback = (source: Want, name: string, data: KVObject) => RequestEventResult;

  /**
   * Plugin component push method.
   *
   * @param { PushParameters } param
   * @param { AsyncCallback<void> } callback
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function push(param: PushParameters, callback: AsyncCallback<void>): void;

  /**
   * Plugin component request method.
   *
   * @param { RequestParameters } param
   * @param { AsyncCallback<RequestCallbackParameters> } callback
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function request(param: RequestParameters, callback: AsyncCallback<RequestCallbackParameters>): void;

  /**
   * Plugin component push method used to send the information of the template it provides.
   *
   * @param { PushParameterForStage } param - Plugin component push parameters for stage.
   * @param { AsyncCallback<void> } callback - Plugin component push event callback.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  export function push(param: PushParameterForStage, callback: AsyncCallback<void>): void;

  /**
   * Plugin component request method used to send a request for the information of the template it wants.
   *
   * @param { RequestParameterForStage } param - Plugin component request parameters for stage.
   * @param { AsyncCallback<RequestCallbackParameters> } callback - Plugin component request event callback.
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @systemapi
   * @since 20
   */
  export function request(param: RequestParameterForStage, callback: AsyncCallback<RequestCallbackParameters>): void;

  /**
   * Plugin component event listener.
   *
   * @param { string } eventType
   * @param { OnPushEventCallback | OnRequestEventCallback } callback
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  export function on(eventType: string, callback: OnPushEventCallback | OnRequestEventCallback): void;
}

export default pluginComponentManager;