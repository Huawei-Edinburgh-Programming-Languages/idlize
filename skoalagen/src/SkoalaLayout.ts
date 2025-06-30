/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import * as idl from "@idlizer/core"
import * as path from "path"
import {
    NativeModule,
    peerGeneratorConfiguration
} from "@idlizer/libohos"

export function HandwrittenModule(language: idl.Language) {
    switch (language) {
        case idl.Language.TS: return "../handwritten"
        // case Language.ARKTS: return "../handwritten"
        // case Language.KOTLIN: return "../handwritten"
        default: throw new Error("Not implemented")
    }
}

abstract class CommonLayoutBase implements idl.LayoutManagerStrategy {
    constructor(
        protected library: idl.LibraryInterface,
        protected prefix: string = "",
    ) {}
    abstract resolve(target: idl.LayoutTargetDescription): string
    handwrittenPackage(): string {
        return HandwrittenModule(this.library.language)
    }
}

class TsLayout extends CommonLayoutBase {
    private tsInternalPaths = new Map<string, string>([
        ["SerializerBase", "@koalaui/interop"],
        ["DeserializerBase", "@koalaui/interop"],
        ["CallbackKind", "peers/CallbackKind"],
        ["deserializeAndCallCallback", "peers/CallbackDeserializeCall"],
        ["checkArkoalaCallbacks", "../CallbacksChecker"],
        ["CallbackTransformer", "../CallbackTransformer"],
    ])

    resolve(target: idl.LayoutTargetDescription): string {
        if (this.tsInternalPaths.has(target.node.name))
            return this.tsInternalPaths.get(target.node.name)!
        if (target.node.name === NativeModule.Generated.name)
            return `peers/${NativeModule.Generated.name}`
        if (idl.isHandwritten(target.node) || peerGeneratorConfiguration().isHandWritten(target.node.name)) {
            return HandwrittenModule(this.library.language)
        }
        // if (idl.isSyntheticEntry(target.node)) {
        //     return SyntheticModule
        // }
        let pureFileName = idl.getFileFor(target.node)?.fileName
            ?.replaceAll('.d.ts', '')
            ?.replaceAll('.idl', '')
            ?.replaceAll('@', '')
        if (pureFileName) {
            pureFileName = path.basename(pureFileName)
        }
        const entryName = pureFileName ?? target.node.name
        return entryName
    }
}
////////////////////////////////////////////////////////

export function skoalaLayout(library: idl.LibraryInterface, prefix: string = ''): idl.LayoutManagerStrategy {
    switch(library.language) {
        case idl.Language.TS: return new TsLayout(library, prefix)
        // case idl.Language.ARKTS: return new ArkTsLayout(library, prefix)
        // case idl.Language.JAVA: return new JavaLayout(library, prefix, packagePath)
        // case idl.Language.CJ: return new CJLayout(library, prefix)
        // case idl.Language.KOTLIN: return new KotlinLayout(library, prefix)
    }
    throw new Error(`Unimplemented language "${library.language}"`)
}