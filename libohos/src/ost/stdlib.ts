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

import { E, T } from "./builder"
import { Annotation, DecoratorKind, LWType, Modifier } from "./lws"

const knownAnnotations = {
    ptrVal: 'ptrVal',
    asStruct: 'asStruct',
    isType: 'isType',
    named: 'named',
    staticMethod: 'staticMethod',
    stackInstance: 'stackInstance',
}

const knownModifiers = {
    optional: 'optional',
    readonly: 'readonly',
    static: 'static',
}

const specialMemberNames = {
    ctor: '@constructor',
    deCtor: '@destructor',
}
const specialVariables = {
    self: '@self',
    base: '@base',
    null: '@null',
    undef: '@undefined',
    print: '@print'
}
const specialTypeNames = {
    constant: '@CONST',
    reference: '@REF',
    pointer: '@PTR',
    tag: '@TAG',

    hole: '@UNDEFINED',

    union: '@UNION',
    intersection: '@INTERSECTION',

    auto: '@LW.AUTO',

    bigint: '@LW.Bigint',
    boolean: '@LW.Boolean',
    buffer: '@LW.Buffer',
    f32: '@LW.Float32',
    f64: '@LW.Float64',
    i8: '@LW.Int8',
    i32: '@LW.Int32',
    i64: '@LW.Int64',
    object: '@LW.Object',
    number: '@LW.Number',
    serializerBuffer: '@LW.SerializerBuffer',
    string: '@LW.String',
    u8: '@LW.U8',
    u32: '@LW.U32',
    u64: '@LW.U64',
    void: '@LW.Void',
}

export const std = {
    names: {
        members: specialMemberNames,
        vars: specialVariables,
        types: specialTypeNames,
        annotations: knownAnnotations,
        modifiers: knownModifiers,
    }
}

export const An = {
    ptrVal: (): Annotation => ({ kind: DecoratorKind.Annotation, name: knownAnnotations.ptrVal }),
    asStruct: (): Annotation => ({ kind: DecoratorKind.Annotation, name: knownAnnotations.asStruct }),
    isType: (): Annotation => ({ kind: DecoratorKind.Annotation, name: knownAnnotations.isType }),
    named: (name:string): Annotation => ({ kind: DecoratorKind.Annotation, name: knownAnnotations.named, value: name }),
    staticMethod: (): Annotation => ({ kind: DecoratorKind.Annotation, name: knownAnnotations.staticMethod }),
    stackInstance: (): Annotation => ({ kind: DecoratorKind.Annotation, name: knownAnnotations.stackInstance })
}

export const Md = {
    optional: { kind: DecoratorKind.Modifier, name: knownModifiers.optional } as Modifier,
    readonly: { kind: DecoratorKind.Modifier, name: knownModifiers.readonly } as Modifier,
    static: { kind: DecoratorKind.Modifier, name: knownModifiers.static } as Modifier,
}

export const Vs = {
    self: E.v(specialVariables.self, [{ kind: DecoratorKind.Annotation, name: knownAnnotations.ptrVal }]),
    base: E.v(specialVariables.base),
    null: E.v(specialVariables.null),
    undef: E.v(specialVariables.undef),
    print: E.v(specialVariables.print),
}

const knownOperations = {
    // binary
    add: '+',
    sub: '-',
    mul: '*',
    div: '/',
    mod: '%',
    or: '||',
    and: '&&',
    le: '<=',
    lt: '<',
    eq: '==',
    gt: '>',
    ge: '>=',

    // unary
    neg: '-',
    not: '!',
    ref: 'ref',
    deref: 'deref',
}

export const Op = knownOperations

const primitiveTypes = {
    bigint: T.c(specialTypeNames.bigint),
    boolean: T.c(specialTypeNames.boolean),
    buffer: T.c(specialTypeNames.buffer),
    f32: T.c(specialTypeNames.f32),
    f64: T.c(specialTypeNames.f64),
    i8: T.c(specialTypeNames.i8),
    i32: T.c(specialTypeNames.i32),
    i64: T.c(specialTypeNames.i64),
    pointer: T.c(specialTypeNames.pointer),
    tag: T.c(specialTypeNames.tag),
    object: T.c(specialTypeNames.object),
    number: T.c(specialTypeNames.number),
    serializerBuffer: T.c(specialTypeNames.serializerBuffer),
    str: T.c(specialTypeNames.string),
    u8: T.c(specialTypeNames.u8),
    u32: T.c(specialTypeNames.u32),
    u64: T.c(specialTypeNames.u64),
    void: T.c(specialTypeNames.void),
}

export const Ts = {
    prim: primitiveTypes,

    ref: (type:LWType) => T.c(specialTypeNames.reference, type),
    ptr: (type:LWType) => T.c(specialTypeNames.pointer, type),
    const: (type:LWType) => T.c(specialTypeNames.constant, type),

    union: (types: LWType[]) => T.c(specialTypeNames.union, ...types),
    intersection: (types: LWType[]) => T.c(specialTypeNames.intersection, ...types),
}
