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
import { lw, processNPrintTS } from "lws";
import { EOL } from "node:os";
import { throwError } from "./library/utils";

export class IDLTypeResolver {
    private legacyLib = new PeerLibrary(Language.TS, new NativeModuleType('__NOT_USED__'), true)
    constructor(library: idl.IDLFile[]) {
        library.forEach(file => {
            this.legacyLib.files.push(file)
        })
    }

    toDeclaration(ref: idl.IDLReferenceType) {
        return this.legacyLib.resolveTypeReference(ref)
    }
}

export class EmptyGeneratorContext {
}

export class MakeResult {
    constructor(
        private result: ProducerDescription
    ) { }

    reference() {
        return isTerminal(this.result)
            ? this.result.artifact.reference as lw.LWType
            : throwError("WOW it is middle ware")
    }
}


export interface MiddlewareProducerDescription {
    go: () => void
}
export interface TerminalProducerDescription {
    artifact: {
        reference: lw.LWStatement | lw.LWExpression | lw.LWType
        implementationGenerator?: () => lw.LWDeclaration | undefined
    }
}
export interface RedirectProducerDescription {
    redirectTo: idl.IDLNode
}

type ProducerDescription =
    MiddlewareProducerDescription
    | TerminalProducerDescription
    | RedirectProducerDescription

function isMiddleware(desc: ProducerDescription): desc is MiddlewareProducerDescription {
    return "go" in desc
}
function isTerminal(desc: ProducerDescription): desc is TerminalProducerDescription {
    return "artifact" in desc
}
function isRedirect(desc: ProducerDescription): desc is RedirectProducerDescription {
    return "redirectTo" in desc
}

export interface Producer<N extends idl.IDLNode = idl.IDLNode> {
    (node: N, ctx: GeneratorContext): ProducerDescription
}

export interface ProducerBox<N extends idl.IDLNode> {
    predicate: (node: idl.IDLNode) => node is N
    producer: Producer<N>
}

export function createProducer<N extends idl.IDLNode>(predicate: (node: idl.IDLNode) => node is N, producer: Producer<N>): ProducerBox<N> {
    return {
        predicate,
        producer,
    }
}

export class MakeSelector {
    private readonly storage: ProducerBox<idl.IDLNode>[] = []

    register<N extends idl.IDLNode>(box: ProducerBox<N>) {
        this.storage.push(box as any)
    }

    select(node: idl.IDLNode): Producer {
        const record = this.storage.find(it => it.predicate(node))
        if (!record) {
            throw new Error(`Can not process "${idl.getFQName(node)}", ${idl.IDLKind[node.kind]}`)
        }
        return record.producer
    }

    static create() {
        return new MakeSelector()
    }
}

export class GeneratorContext {
    public resolver: IDLTypeResolver

    private storage = new Map<string, ProducerDescription>()
    private generatingQueue: TerminalProducerDescription['artifact']['implementationGenerator'][] = []
    private renderContext = false

    constructor(
        public library: idl.IDLFile[],
        private selector: MakeSelector,
    ) {
        this.resolver = new IDLTypeResolver(library)
    }

    private getUseKey(node: idl.IDLNode): string {
        if (idl.isFile(node)) {
            return node.fileName ?? 'no file???'
        }
        if (idl.isEntry(node)) {
            return idl.getFQName(node)
        }
        if (idl.isType(node)) {
            if (idl.isReferenceType(node)) {
                return node.name
            }
            if (idl.isPrimitiveType(node)) {
                return node.name
            }
            if (idl.isContainerType(node)) {
                return '#' + node.containerKind + '#' + node.elementType.map(t => this.getUseKey(t)).join('::')
            }
            throw new Error(`Can not process "${idl.DebugUtils.debugPrintType(node)}"`)
        }
        throw new Error("???")
    }
    private runUse(node: idl.IDLNode): ProducerDescription {
        if (!this.renderContext) {
            throw new Error("Can not use here!")
        }
        const key = this.getUseKey(node)
        if (this.storage.has(key)) {
            return this.storage.get(key)!
        }
        const producer = this.selector.select(node)
        this.renderContext = false
        const desc = producer(node, this)
        this.renderContext = true
        this.storage.set(key, desc)
        if (isTerminal(desc)) {
            if (desc.artifact.implementationGenerator) {
                this.generatingQueue.push(desc.artifact.implementationGenerator)
            }
        }
        if (isMiddleware(desc)) {
            desc.go()
        }
        if (isRedirect(desc)) {
            return this.runUse(desc.redirectTo)
        }
        return desc
    }

    use(node: idl.IDLNode): MakeResult {
        return new MakeResult(this.runUse(node))
    }

    generate(nodes: idl.IDLNode[]) {
        const declaration: lw.LWDeclaration[] = []
        this.renderContext = true
        nodes.forEach(node => this.runUse(node))
        this.renderContext = false
        while (this.generatingQueue.length) {
            const generator = this.generatingQueue.shift()!
            this.renderContext = true
            const decl = generator()
            this.renderContext = false
            if (decl) {
                declaration.push(decl)
            }
        }
        return declaration.map(processNPrintTS).join(EOL)
    }
}


