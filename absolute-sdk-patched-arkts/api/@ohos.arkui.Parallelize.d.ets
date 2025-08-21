/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License"),
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
 */

import { ComponentBuilder } from './arkui/stateManagement/runtime'
import { CustomBuilder } from './arkui/component/builder';

/**
* Describe the options for the ParallelizeUI.
*
* @interface ParallelOption
* @syscap SystemCapability.ArkUI.ArkUI.Full
* @since 20
*/
export interface ParallelOption {
	/**
	* Whether ParallelizeUI create is enabled.
	*
	* @type { ?boolean }
	* @syscap SystemCapability.ArkUI.ArkUI.Full
	* @since 20
  	*/
	enable?: boolean,
}

/**
* Defines the ParallelizeUI attribute interface
*
* @interface UIParallelAttribute
* @syscap SystemCapability.ArkUI.ArkUI.Full
* @since 20
*/
export interface UIParallelAttribute {
}

/**
 * Define the constructor of ParallelizeUI.
 * 
 * @param { ParallelOption | undefined } [options] - ParallelizeUI Option
 * @param { CustomBuilder } [content] - tail closure for ParallelizeUI
 * @returns { UIParallelAttribute }
 * @syscap SystemCapability.ArkUI.ArkUI.Full
 * @since 20
 */
@ComponentBuilder
export declare function ParallelizeUI(
  options?: ParallelOption | undefined,
  content?: CustomBuilder,
): UIParallelAttribute
