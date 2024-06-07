/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
import { float32, int32 } from "@koalaui/common"
import { Length, Resource } from "./dts-exports"
import { NativeModule } from "./NativeModule"

/**
 * Value representing possible JS runtime object type.
 * Must be synced with "enum RuntimeType" in C++.
 */
export enum RuntimeType {
    UNEXPECTED = -1,
    NUMBER = 1,
    STRING = 2,
    OBJECT = 3,
    BOOLEAN = 4,
    UNDEFINED = 5,
    BIGINT = 6,
    FUNCTION = 7,
    SYMBOL = 8,
    MATERIALIZED = 9,
}

/**
 * Value representing object type in serialized data.
 * Must be synced with "enum Tags" in C++.
 */
export enum Tags {
    UNDEFINED = 101,
    INT32 = 102,
    FLOAT32 = 103,
    STRING = 104,
    LENGTH = 105,
    RESOURCE = 106,
    OBJECT = 107,
}

export function runtimeType(value: Object|String|number|undefined|null|(() => object)): RuntimeType {
    let type = typeof value
    if (type == "number") return RuntimeType.NUMBER
    if (type == "string") return RuntimeType.STRING
    if (type == "undefined") return RuntimeType.UNDEFINED
    if (type == "object") return RuntimeType.OBJECT
    if (type == "boolean") return RuntimeType.BOOLEAN
    if (type == "bigint") return RuntimeType.BIGINT
    if (type == "function") return RuntimeType.FUNCTION
    if (type == "symbol") return RuntimeType.SYMBOL

    throw new Error(`bug: ${value} is ${type}`)
}

export type Function = object

function registerCallback(value: object|undefined): int32 {
    // TODO: fix me!
    return 42
}

function registerMaterialized(value: object|undefined): int32 {
    // TODO: fix me!
    return 42
}

export function isPixelMap(value: Object|undefined): boolean {
    // TODO: fix me!
    return false
}

export function isResource(value: Object|undefined): boolean {
    // TODO: fix me!
    return false
}

/* Serialization extension point */
export abstract class CustomSerializer {
    protected supported: Array<string>
    constructor(supported: Array<string>) {
        this.supported = supported
    }
    supports(kind: string): boolean { return this.supported.includes(kind) }
    abstract serialize(serializer: SerializerBase, value: object, kind: string): void
    next: CustomSerializer | undefined = undefined
}


class SerializersCache {
    cache: Array<SerializerBase|undefined>
    constructor(maxCount: number) {
        this.cache = new Array<SerializerBase|undefined>(maxCount)
    }
    get<T extends SerializerBase>(factory: () => T, index: int32): T {
        let result = this.cache[index]
        if (result) {
            result.resetCurrentPosition()
            return result as T
        }
        result = factory()
        this.cache[index] = result
        return result as T
    }
}

export class SerializerBase {
    private static cache = new SerializersCache(22)

    private position = 0
    private buffer: byte[]

    static get<T extends SerializerBase>(factory: () => T, index: int32): T {
        return SerializerBase.cache.get<T>(factory, index)
    }
    resetCurrentPosition(): void { this.position = 0 }

    private static customSerializers: CustomSerializer | undefined = undefined
    static registerCustomSerializer(serializer: CustomSerializer) {
        if (SerializerBase.customSerializers == undefined) {
            SerializerBase.customSerializers = serializer
        } else {
            /*
            let current = SerializerBase.customSerializers
            while (current.next != undefined) { current = current.next }
            current.next = serializer
            */
        }
    }
    constructor() {}
    asArray(): byte[] {
        return this.buffer
    }
    length(): int32 {
        return this.position
    }
    currentPosition(): int32 { return this.position }
    private checkCapacity(value: int32) {
        if (value < 1) {
            throw new Error(`${value} is less than 1`)
        }
        let buffSize = this.buffer.length
        if (this.position > buffSize - value) {
            const minSize = this.position + value
            const resizedSize = Math.max(minSize, Math.round(3 * buffSize / 2))
            let resizedBuffer = new byte[resizedSize]
            // TODO: make faster copy
            for (let i = 0; i < buffSize; i++) {
                resizedBuffer[i] = this.buffer[i]
            }
            this.buffer = resizedBuffer
        }
    }
    writeCustomObject(kind: string, value: object) {
        let current = SerializerBase.customSerializers
        while (current) {
            if (current.supports(kind)) {
                current!.serialize(this, value, kind)
                return
            }
        }
        console.log(`Unsupported custom serialization for ${kind}, write undefined`)
        this.writeInt8(Tags.UNDEFINED as int32)
    }
    writeFunction(value: object | undefined) {
        this.writeInt32(registerCallback(value))
    }
    writeNumber(value: number|undefined) {
        this.checkCapacity(5)
        if (value == undefined) {
            // this.view.setInt8(this.position, Tags.UNDEFINED)
            this.writeInt8(101 /* Tags.UNDEFINED */)
            this.position++
            return
        }
        if (value == Math.round(value)) {
            this.writeInt8(102 /* Tags.INT32 */)
            this.writeInt32(value as int32)
        } else {
            this.writeInt8(103 /* Tags.FLOAT32 */)         
            this.writeFloat32(value as float32)
        }
    }
    writeInt8(value: int32) {
        this.checkCapacity(1)
        this.buffer[this.position] = (value & 0xff) as byte
        this.position += 1
    }
    writeInt32(value: int32) {
        this.checkCapacity(4)
        this.buffer[this.position + 0] = ((value     )  & 0xff) as byte
        this.buffer[this.position + 1] = ((value >> 8)  & 0xff) as byte
        this.buffer[this.position + 2] = ((value >> 16) & 0xff) as byte
        this.buffer[this.position + 3] = ((value >> 24) & 0xff) as byte
        this.position += 4
    }
    writePointer(value: long) {
        this.checkCapacity(8)
        this.buffer[this.position + 0] = ((value     )  & 0xff) as byte
        this.buffer[this.position + 1] = ((value >> 8)  & 0xff) as byte
        this.buffer[this.position + 2] = ((value >> 16) & 0xff) as byte
        this.buffer[this.position + 3] = ((value >> 24) & 0xff) as byte
        this.buffer[this.position + 4] = ((value >> 32) & 0xff) as byte
        this.buffer[this.position + 5] = ((value >> 40) & 0xff) as byte
        this.buffer[this.position + 6] = ((value >> 48) & 0xff) as byte
        this.buffer[this.position + 7] = ((value >> 56) & 0xff) as byte
        this.position += 8
    }
    writeFloat32(value: float32) {
        this.checkCapacity(4)
        // TODO: wrong, provide operation!
        this.buffer[this.position + 0] = ((value      ) & 0xff) as byte
        this.buffer[this.position + 1] = ((value >>  8) & 0xff) as byte
        this.buffer[this.position + 2] = ((value >> 16) & 0xff) as byte
        this.buffer[this.position + 3] = ((value >> 24) & 0xff) as byte
        this.position += 4
    }
    writeBoolean(value: boolean|undefined) {
        this.checkCapacity(1)
        this.buffer[this.position] = (value == undefined) ? 5/* RuntimeType.UNDEFINED */ : (value ? 1 : 0)
        this.position++
    }
    writeMaterialized(value: object | undefined) {
        this.writePointer(registerMaterialized(value))
    }
    writeString(value: string) {
        this.checkCapacity(4 + value.length as int32 * 4) // length, data
        let encodedLength = NativeModule._ManagedStringWrite(value, this.buffer, this.position + 4)
        this.writeInt32(encodedLength)
        this.position += encodedLength
    }
    // Length is an important common case.
    writeLength(value: Length|undefined) {
        this.checkCapacity(1)
        let valueType = runtimeType(value)
        this.writeInt8(valueType as int32)
        if (valueType == RuntimeType.NUMBER) {
            this.writeFloat32(value as float32)
        } else if (valueType == RuntimeType.STRING) {
            this.writeString(value as string)
        } else if (valueType == RuntimeType.OBJECT) {
            this.writeInt32((value as Resource).id as int32)
        }
    }
}
