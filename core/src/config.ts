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
export class ConfigurationValueHolder {
    constructor(
        private value: unknown
    ) {}

    private fail(expected:string, actual?:string): never {
        this.failWithMsg(`Value was "${actual ?? typeof this.value}", but required "${expected}"`)
        
    }
    private failWithMsg(msg:string): never {
        throw new Error(msg)
    }

    isUndefined(): boolean {
        return this.value === undefined
    }
    isNull(): boolean {
        return this.value === null
    }
    isDefined(): boolean {
        return this.value !== undefined && this.value !== null
    }

    asString(): string {
        if (typeof this.value === 'string') {
            return this.value
        } 
        this.fail('string')
    }
    asNumber(): number {
        if (typeof this.value === 'number') {
            return this.value
        }
        this.fail('number')
    }
    asBoolean(): boolean {
        if (typeof this.value === 'boolean') {
            return this.value
        }
        this.fail('boolean')
    }
    asBigInt(): bigint {
        if (typeof this.value === 'bigint') {
            return this.value
        }
        this.fail('bigint')
    }
    asObjectOrNull(): object | null {
        if (typeof this.value === 'object') {
            return this.value
        }
        this.fail('object | null')
    }
    asObject(): object {
        if (typeof this.value === 'object') {
            if (this.value) {
                return this.value
            }
            this.fail('object', 'null')
        }
        this.fail('object')
    }
    asArray(): unknown[] {
        if (Array.isArray(this.value)) {
            return this.value
        }
        this.fail('array')
    }
    asMap(): Map<unknown, unknown> {
        const obj = this.asObject()
        if (obj instanceof Map) {
            return obj
        }
        this.fail('Map')
    }

    array(): ConfigurationValueHolder[] {
        if (Array.isArray(this.value)) {
            return this.value.map(it => new ConfigurationValueHolder(it))
        }
        this.fail('array')
    }
    param(key:string): ConfigurationValueHolder {
        const obj = this.asObject() as Record<string, unknown>
        if (obj instanceof Map) {
            if (obj.has(key)) {
                return new ConfigurationValueHolder(obj.get(key))
            }
            this.failWithMsg(`Value was Map, but key "${key}" was not found`)
        }
        if (key in obj) {
            return new ConfigurationValueHolder(obj[key])
        }
        this.failWithMsg(`Field "${key}" not found in object`)
    }
}

export interface GeneratorConfiguration {
    param<T>(name: string): T
    paramArray<T>(name: string): T[]
    configSafe(): ConfigurationValueHolder
}

class EmptyGeneratorConfiguration implements GeneratorConfiguration {
    param<T>(name: string): T {
        throw new Error(`${name} is unknown`)
    }
    paramArray<T>(name: string): T[] {
        throw new Error(`array ${name} is unknown`)
    }
    configSafe(): ConfigurationValueHolder {
        return new ConfigurationValueHolder(undefined)
    }
}

let currentConfig: GeneratorConfiguration = new EmptyGeneratorConfiguration()

export function setDefaultConfiguration(config: GeneratorConfiguration): void {
    currentConfig = config
}

export function generatorConfiguration(): GeneratorConfiguration {
    return currentConfig
}

export function generatorConfigurationSafe(): ConfigurationValueHolder {
    return currentConfig.configSafe()
}

export function generatorTypePrefix() {
    const conf = generatorConfigurationSafe()
    return `${conf.param("TypePrefix").asString()}${conf.param("LibraryPrefix").asString()}`
}
