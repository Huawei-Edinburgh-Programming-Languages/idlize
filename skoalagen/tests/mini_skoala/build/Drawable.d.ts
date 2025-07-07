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

import { RefCounted } from "index"

export declare class Drawable extends RefCounted {
    constructor(ptr: pointer);
    draw(canvas: Canvas, matrix: Matrix33 | undefined): void;
    get generationId(): int32;
    notifyDrawingChanged(): void;
}

export declare abstract class CustomDrawable extends Drawable {
    boundsRect?: Rect;
    abstract onDraw(canvas: Canvas): void;
    abstract onGetBounds(): Rect;
    static make(): CustomDrawable
    constructor(ptr: pointer);
    onDrawCallback(thizz: CustomDrawable): void;
    onGetBoundsCallback(thizz: CustomDrawable): void;
    get bounds(): Rect | undefined;
    notifyDrawingChanged(): void;
}

declare class RectCustomDrawable extends CustomDrawable {
    public onDraw(canvas: Canvas): void
    public onGetBounds(): Rect
    static make(): RectCustomDrawable
}
//# sourceMappingURL=Drawable.d.ts.map