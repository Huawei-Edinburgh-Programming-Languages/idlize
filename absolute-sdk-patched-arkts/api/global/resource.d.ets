/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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
 * @kit LocalizationKit
 */

/**
 * Contains resource descriptor information.
 *
 * @interface Resource
 * @syscap SystemCapability.Global.ResourceManager
 * @since 20
 */
export interface Resource {
    
    /**
     * bundle name in hap
     *
     * @type { string }
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    bundleName: string;
    
    /**
     * module name in hap
     *
     * @type { string }
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    moduleName: string;
    
    /**
     * resource id in hap
     *
     * @type { long }
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    id: long;
    /**
     * Set params.
     *
     * @type { ?Array<string | int | long | double | Resource> }
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    params?: Array<string | int | long | double | Resource>;
    
    /**
     * Set type.
     *
     * @type { ?int }
     * @syscap SystemCapability.Global.ResourceManager
     * @since 20
     */
    type?: int;
}
