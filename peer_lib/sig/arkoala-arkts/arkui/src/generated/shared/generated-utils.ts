/**
 * TODO: move to compat
 */

import { int32 } from "@koalaui/common" 

export class GestureName {
    static readonly Tap = 0
    static readonly LongPress = 1
    static readonly Pan = 2
    static readonly Pinch = 3
    static readonly Swipe = 4
    static readonly Rotation = 5
    static readonly Group = 6
}

export class GestureComponent<T> {
    public type?: int32
    public value?: T
    public hasEvent?: Int32Array
}

export type FunctionType0<R> = () => R
export type FunctionType1<T1, R> = (arg1: T1) => R
export type FunctionType2<T1, T2, R> = (arg1: T1, arg2: T2) => R
export type FunctionType3<T1, T2, T3, R> = (arg1: T1, arg2: T2, arg3: T3) => R
export type FunctionType4<T1, T2, T3, T4, R> = (arg1: T1, arg2: T2, arg3: T3, arg4: T4) => R
