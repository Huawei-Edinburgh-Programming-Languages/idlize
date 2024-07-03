import { int32 } from "@koalaui/common";

// imports required intarfaces (now generation is disabled)
// import { Resource, Length, PixelMap } from "@arkoala/arkui"
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
    MATERIALIZED = 9
}

export function runtimeType(value: any): int32 {
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

export function isPixelMap(value: Object): value is PixelMap {
    // Object.hasOwn need es2022
    return value.hasOwnProperty('isEditable') && value.hasOwnProperty('isStrideAlignment')
}

export function isResource(value: Object): value is Resource {
    return value.hasOwnProperty("bundleName") && value.hasOwnProperty("moduleName")
}

// Poor man's instanceof, fails on subclasses
export function isInstanceOf(className: string, value: Object): boolean {
    return value.constructor.name === className
}

