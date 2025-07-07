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

export enum Access {
    READ = 1, // 1 << 0,
    WRITE = 2, // 1 << 1,
    READWRITE = 3, // READ | WRITE
}

export declare class Point {
    coordinates: Float32Array;
    constructor(x: float32, y: float32);
    get x(): float32;
    get y(): float32;
    offsetXY(dx: float32, dy: float32): Point;
    offset(vec: Point): Point;
    scale(scale: float32): Point;
    scaleXY(sx: float32, sy: float32): Point;
    static ZERO: Point;
    toArray(): Float32Array;
    static flattenArray(points: Array<Point>): Float32Array;
    static fromArray(points: Float32Array): Array<Point>;
}

export declare class Matrix33 {
    readonly array: Float32Array;
    constructor(array?: Float32Array);
    static zero(): Matrix33;
    static makeTranslate(dx: float32, dy: float32): Matrix33;
    static makeScale(dx: float32, dy?: float32): Matrix33;
    static makeRotate(degrees: float32, pivotX?: float32, pivotY?: float32): Matrix33;
    static makeSkew(sx: float32, sy: float32): Matrix33;
    makeConcat(rhs: Matrix33): Matrix33;
    makeTranspose(): Matrix33;
}
