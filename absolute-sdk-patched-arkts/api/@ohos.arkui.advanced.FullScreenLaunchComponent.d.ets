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
 * @file Defines the fullScreen launch component
 * @kit ArkUI
 * @arkts 1.2
 */

import AtomicServiceOptions from '@ohos.app.ability.AtomicServiceOptions';
import { Callback, ErrorCallback } from '@ohos.base';

/**
 * Defines RecordData.
 * 
 * @typedef { undefined | null | Object | Record<string, RecordData> | Array<RecordData> } RecordData
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 * @arkts 1.2
 */
export type RecordData = undefined | null | Object | Record<string, RecordData> | Array<RecordData>;

/**
 * Declares the FullScreenLaunchComponent, a component provided by ArkUI that allows
 * you to define and use it in your application through the ArkTS-based declarative
 * development paradigm.
 * @struct { FullScreenLaunchComponent }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@Component
export declare struct FullScreenLaunchComponent {
  /**
   * Sets the component content.
   * @type { Callback<void> }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  @BuilderParam content: Callback<void>;
  /**
   * Indicates atomic service appId.
   * @type { string }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  appId: string;
  /**
   * Indicates the atomic service start options.
   * @type { ?AtomicServiceOptions }
   * @syscap SystemCapability.ArkUI.ArkUI.Full
   * @since 20
   */
  options?: AtomicServiceOptions;
    /**
    * Callback triggered when an error occurs during running of the started ExtensionAbility.
    * It is supported only when the atomic service runs in embedded mode,
    * with the parameter being of type BusinessError.
    * @type { ?ErrorCallback }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    onError?: ErrorCallback;
    /**
    * Callback triggered when the EmbeddableUIAbility is terminated to receive the information
    * about the termination. It is supported only when the atomic service runs in embedded mode,
    * with the parameter being of type TerminationInfo.
    * @type { ?Callback<TerminationInfo> }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    onTerminated?: Callback<TerminationInfo>;
    /**
    * Indicates the callback of onReceive.
    * @type { ?Callback<Record<string, RecordData>> }
    * @syscap SystemCapability.ArkUI.ArkUI.Full
    * @since 20
    */
    onReceive?: Callback<Record<string, RecordData>>;
}