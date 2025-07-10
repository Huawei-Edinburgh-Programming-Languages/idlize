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

import { Language, NativeModuleType, PeerLibrary } from "@idlizer/core";
import * as idl from "@idlizer/core/idl"

export class IDLTypeResolver {
    private legacyLib = new PeerLibrary(Language.TS, new NativeModuleType('__NOT_USED__'), true)
    constructor(library: idl.IDLFile[]) {
        library.forEach(file => {
            this.legacyLib.files.push(file)
        })
    }

    toDeclaration(ref:idl.IDLReferenceType) {
        return this.legacyLib.resolveTypeReference(ref)
    }
}

export class EmptyGeneratorContext {
}

export class MakeResult {

}

interface Producer {
    produce(): void
}

export class MakeSelector {
    private readonly storage: {
        predicate: (node:idl.IDLNode) => boolean,
        producer: Producer,
    }[] = []

    register(predicate:(node:idl.IDLNode) => boolean, producer:Producer) {
        this.storage.push({
            predicate,
            producer
        })
    }

    select(node:idl.IDLNode): Producer {
        const record = this.storage.find(it => it.predicate(node))
        if (!record) {
            throw new Error(`Can not process "${idl.getFQName(node)}"`)
        }
        return record.producer
    }
}

export class GeneratorContext {
    public resolver: IDLTypeResolver
    constructor(
        public library: idl.IDLFile[]
    ) {
        this.resolver = new IDLTypeResolver(library)
    }

    make(node:idl.IDLNode): MakeResult {
        return new MakeResult()
    }
}


