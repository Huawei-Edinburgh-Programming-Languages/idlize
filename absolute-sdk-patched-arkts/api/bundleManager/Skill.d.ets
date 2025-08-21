/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
 * @kit AbilityKit
 */
/**
 * Obtains configuration information about an skill
 *
 * @typedef Skill
 * @syscap SystemCapability.BundleManager.BundleFramework.Core
 * @since 20
 */
export interface Skill {
    /**
     * Indicates the actions of the skill
     *
     * @type { Array<string> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly actions: Array<string>;
    /**
     * Indicates the entities of the skill
     *
     * @type { Array<string> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly entities: Array<string>;
    /**
     * Indicates the uris of the skill
     *
     * @type { Array<SkillUri> }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly uris: Array<SkillUri>;
    /**
     * Indicates the domainVerify of the skill
     *
     * @type { boolean }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly domainVerify: boolean;
}
/**
 * Obtains configuration information about an skillUri
 *
 * @typedef SkillUri
 * @syscap SystemCapability.BundleManager.BundleFramework.Core
 * @since 20
 */
export interface SkillUri {
    /**
     * Indicates the scheme of the skillUri
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly scheme: string;
    /**
     * Indicates the host of the skillUri
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly host: string;
    /**
     * Indicates the port of the skillUri
     *
     * @type { int }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly port: int;
    /**
     * Indicates the path of the skillUri
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly path: string;
    /**
     * Indicates the pathStartWith of the skillUri
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly pathStartWith: string;
    /**
     * Indicates the pathRegex of the skillUri
     *
     * @type {string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly pathRegex: string;
    /**
     * Indicates the type of the skillUri
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly type: string;
    /**
     * Indicates the utd of the skillUri
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly utd: string;
    /**
     * Indicates the maxFileSupported of the skillUri
     *
     * @type { int }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly maxFileSupported: int;
    /**
     * Indicates the linkFeature of the skillUri
     *
     * @type { string }
     * @readonly
     * @syscap SystemCapability.BundleManager.BundleFramework.Core
     * @since 20
     */
    readonly linkFeature: string;
}
