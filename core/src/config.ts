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

import * as fs from "fs"
export interface GeneratorConfiguration {
    param<T>(name: string): T
    paramArray<T>(name: string): T[]
}

class EmptyGeneratorConfiguration implements GeneratorConfiguration {
    param<T>(name: string): T {
        throw new Error(`${name} is unknown`)
    }
    paramArray<T>(name: string): T[] {
        throw new Error(`array ${name} is unknown`)
    }
}

let currentConfig: GeneratorConfiguration = new EmptyGeneratorConfiguration()

export function setDefaultConfiguration(config: GeneratorConfiguration): void {
    currentConfig = config
}

export function generatorConfiguration(): GeneratorConfiguration {
    return currentConfig
}

export function generatorTypePrefix() {
    const conf = generatorConfiguration()
    return `${conf.param("TypePrefix")}${conf.param("LibraryPrefix")}`
}

class FileGeneratorConfiguration implements GeneratorConfiguration {
    constructor(private json: any) {}
    param<T>(name: string): T {
        return this.json[name] as T
    }
    paramArray<T>(name: string): T[] {
        return this.json[name] as T[]
    }
}

export function loadConfiguration(path: string): GeneratorConfiguration {
    return new FileGeneratorConfiguration(JSON.parse(fs.readFileSync(path, 'utf-8')))
}

export class PeerGeneratorConfigImpl implements GeneratorConfiguration {
    constructor(private file: GeneratorConfiguration) {
    }
    param<T>(name: string): T {
        return this.file.param(name)
    }
    paramArray<T>(name: string): T[] {
        return this.file.paramArray(name)
    }
    handwrittenMethods(): string[] {
        return this.file.paramArray<string>("handwritten")
    }
}

const PeerGeneratorConfig = new PeerGeneratorConfigImpl(loadConfiguration(options.configFile))

PeerGeneratorConfig.handwrittenMethods().includes("")