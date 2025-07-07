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

export * from "./Bitmap"
export * from "./Canvas"
export * from "./Drawable"
export * from "./Paint"
export * from "./PixelGeometry"
export * from "./Rect"
export * from "./SurfaceProps"
export * from "./utils"

export class Finalizable {}
export class RefCounted {}

export function testFun(): void
export function rgbColor(r: uint8, g: uint8, b: uint8, a: uint8): void