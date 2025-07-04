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
import { Annotation, LWType } from "./lws"

const knownAnnotations = {
    ptrVal: 'ptrVal',
    asStruct: 'asStruct',
    named: 'named'
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

    hole: '@UNDEFINED',

    union: '@UNION',
    intersection: '@INTERSECTION',

    auto: '@LW.AUTO',

    int: '@LW.Int32',
    string: '@LW.String',
    void: '@LW.Void',
}

export const std = {
    names: {
        members: specialMemberNames,
        vars: specialVariables,
        types: specialTypeNames,
        annotations: knownAnnotations
    }
}

export const An = {
    ptrVal: (): Annotation => ({ name: knownAnnotations.ptrVal }),
    asStruct: (): Annotation => ({ name: knownAnnotations.asStruct }),
    named: (name:string): Annotation => ({ name: knownAnnotations.named, value: name })
}

export const Vs = {
    self: E.v(specialVariables.self, [{ name: knownAnnotations.ptrVal }]),
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
    int: T.c(specialTypeNames.int),
    str: T.c(specialTypeNames.string),
    void: T.c(specialTypeNames.void),
}

export const Ts = {
    prim: primitiveTypes,

    ref: (type:LWType) => T.c(specialTypeNames.reference, type),
    ptr: (type:LWType) => T.c(specialTypeNames.pointer, type),
    const: (type:LWType) => T.c(specialTypeNames.constant, type),
}
