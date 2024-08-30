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

import * as path from "path"
import { WrapperClass } from "./WrapperClass";
import { Language } from "../Language";
import { ImportsCollector } from "../peer-generation/ImportsCollector";

export class LibraryFile {
    readonly wrapperClasses: Map<string, [WrapperClass, any|undefined]> = new Map()
    readonly baseName: string
    readonly importsCollector: ImportsCollector
    constructor(
        public readonly originalFilename: string
    ) {
        this.baseName = path.basename(this.originalFilename)
        this.importsCollector = new ImportsCollector()
    }

    addImportFeature(module: string, ...features: string[]) {
        this.importsCollector.addFeatures(features, module)
    }
}

export class LibraryBase<T extends LibraryFile> {
    public readonly files: T[] = []
    get language(): Language {
        return Language.TS
    }
    findFileByOriginalFilename(filename: string): T | undefined {
        return this.files.find(it => it.originalFilename === filename)
    }
}
