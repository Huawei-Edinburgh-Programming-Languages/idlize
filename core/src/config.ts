/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import { D, ConfigTypeInfer } from "./configDescriber"

const T = {
    stringArray: () => D.array(D.string())
}

export const CoreConfigurationSchema = D.object({
    TypePrefix: D.string(),
    LibraryPrefix: D.string(),
    OptionalPrefix: D.string(),

    rootComponents: T.stringArray(),
    standaloneComponents: T.stringArray(),
    parameterized: T.stringArray(),
    ignoreMaterialized: T.stringArray(),
    builderClasses: T.stringArray(),
    forceMaterialized: T.stringArray(),
    forceCallback: T.stringArray(),
})

export type CoreConfiguration = ConfigTypeInfer<typeof CoreConfigurationSchema>

export const defaultCoreConfiguration: CoreConfiguration = {
    TypePrefix: "",
    LibraryPrefix: "",
    OptionalPrefix: "",

    rootComponents: [],
    standaloneComponents: [],
    parameterized: [],
    ignoreMaterialized: [],
    builderClasses: [],
    forceMaterialized: [],
    forceCallback: [],
}

let currentConfig: CoreConfiguration = defaultCoreConfiguration

export function setCoreConfiguration(config: CoreConfiguration): void {
    currentConfig = config
}

export function patchCoreConfiguration(config: Partial<CoreConfiguration>): void {
    currentConfig = Object.assign({}, currentConfig, config)
}

export function coreConfiguration(): CoreConfiguration {
    return currentConfig
}

export function generatorTypePrefix(): string {
    const conf = coreConfiguration()
    return `${conf.TypePrefix}${conf.LibraryPrefix}`
}
