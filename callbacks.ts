type int32 = number

interface R {
    // anything, doesn't matter
}


interface A {
    foo(cb: (value: string, innerCallback: (innterValue: string) => boolean) => R): void
}

interface Z {
    callback: (value: string) => boolean
    // other fields
}

// Resources
type ResourceId = int32
type Resource<T> = {
    resource: T, 
    holdersCount: int32,
}

class ResourceHolder<T> {
    private static nextResourceId = 0 
    private resources: Map<ResourceId, Resource<T>> = new Map()

    public hold(resourceId: ResourceId) {
        this.resources.get(resourceId)!.holdersCount++
    }

    public release(resourceId: ResourceId) {
        const res = this.resources.get(resourceId)!
        res.holdersCount--
        if (res.holdersCount <= 0)
            this.resources.delete(resourceId)
    }

    public registerAndHold(resource: T): ResourceId {
        const resourceId = ResourceHolder.nextResourceId++
        this.resources.set(resourceId, {
            resource: resource,
            holdersCount: 1,
        })
        return resourceId
    }

    public get(resourceId: ResourceId): T {
        return this.resources.get(resourceId)!.resource
    } 
}

class ResourceManager extends ResourceHolder<object> {
    static readonly I = new ResourceManager()
}

interface SerializerResult {
    buffer: Uint8Array
    length: int32
    heldResources: ResourceId[]
}

class Serializer {
    writeInt32(value: int32) {
        // ...
    }
    writeString(value: string) {}
    writeResource(value: object): ResourceId {
        const resourceId = ResourceManager.I.registerAndHold(value)
        this.heldResources.push(resourceId)
        this.writeInt32(resourceId)
        return resourceId
    }
    private buffer = new Uint8Array()
    private position = 0
    // ...
    private heldResources: ResourceId[]
    writeZ(value: Z) {
        this.writeResource(value.callback)
        // write other value
    }
    writeR(value: R) {}

    finalize(): SerializerResult {
        return {
            buffer: this.buffer,
            length: this.position,
            heldResources: this.heldResources
        }
    }
}

class Deserializer {
    readInt32(): int32 {
        return 0
    }
    readString(): string {
        return ""
    }
    readBoolean(): boolean {
        return false
    }
    readZ(): Z {
        const callbackId = this.readInt32()
        return {
            callback: (value: string): boolean => {
                return callNativeCallback_string_ret_boolean(callbackId, value)
            }
        } as Z
    }
}

// Callbacks
interface NativeModule {
    callCallback_R_ret_void(callbackId: int32, buffer: Uint8Array, length: int32)
    callCallback_string_ret_boolean(callbackId: int32, buffer: Uint8Array, length: int32)
}
function nativeModule(): NativeModule {
    return {} as NativeModule
}

type NativeCallbackId = int32
type ManagedCallbackId = int32

type R_ret_void_NativeCallbackId = NativeCallbackId
function callNativeCallback_R_ret_void(callbackId: NativeCallbackId, value: R): void {
    const serializer = new Serializer()
    serializer.writeR(value)
    const serialized = serializer.finalize()
    nativeModule().callCallback_R_ret_void(callbackId, serialized.buffer, serialized.length)
    serialized.heldResources.forEach(resourceId => ResourceManager.I.release(resourceId))
}

type string_ret_boolean_NativeCallbackId = NativeCallbackId
function callNativeCallback_string_ret_boolean(callbackId: NativeCallbackId, value: string): boolean {
    const serializer = new Serializer()
    serializer.writeString(value)
    let continuationValue: boolean | undefined
    const continuation = (value: boolean) => {
        continuationValue = value
    } 
    serializer.writeResource(continuation)
    const serialized = serializer.finalize()
    nativeModule().callCallback_string_ret_boolean(callbackId, serialized.buffer, serialized.length)
    serialized.heldResources.forEach(resourceId => ResourceManager.I.release(resourceId))
    return continuationValue!
}

enum ManagedCallbackType {
    string_cb_string_ret_boolean_ret_R,
    boolean_ret_void,
    string_ret_boolean,
}

function deserializerAndCallManagedCallback(deserializer: Deserializer) {
    const callbackType = deserializer.readInt32() as ManagedCallbackType
    const callbackId = deserializer.readInt32()
    switch (callbackType) {
        case ManagedCallbackType.string_cb_string_ret_boolean_ret_R: {
            const value = deserializer.readString()
            const innerCallbackId = deserializer.readInt32()
            const innerCallback = (innerValue: string): boolean => {
                return callNativeCallback_string_ret_boolean(innerCallbackId, innerValue)
            }
            const continuationId = deserializer.readInt32()
            const callback = ResourceManager.I.get(callbackId) as (value: string, innerCallback: (innterValue: string) => boolean) => R
            const continuationValue = callback(value, innerCallback)
            callNativeCallback_R_ret_void(continuationId, continuationValue)
            break
        }
        case ManagedCallbackType.boolean_ret_void: {
            const value = deserializer.readBoolean()
            const callback = ResourceManager.I.get(callbackId) as (value: boolean) => void
            callback(value)
            break
        }
        case ManagedCallbackType.string_ret_boolean: {
            // ...
            break
        }
    }
}
