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
import { getOrPut, renameDtsToPeer, renameDtsToComponent, stringOrNone } from "../util"
import { PeerClass } from "./PeerClass"
import { Printers } from "./Printers"
import { ImportsCollector } from "./ImportsCollector"
import { IndentedPrinter } from "../IndentedPrinter"

export class PeerFile {
    private readonly peers: Map<string, PeerClass> = new Map()
    constructor(
        public readonly originalFilename: string,
    ) {}

    getOrPutPeer(componentName: string) {
        return getOrPut(this.peers, componentName, () => new PeerClass(componentName, this.originalFilename))
    }

    private printDefaultPeerImports(printer: IndentedPrinter) {
        [
            `import { runtimeType, withLength, withLengthArray, RuntimeType } from "./SerializerBase"`,
            `import { Serializer } from "./Serializer"`,
            `import { int32 } from "@koalaui/common"`,
            `import { KPointer } from "./types"`,
            `import { nativeModule } from "./NativeModule"`,
            `import { PeerNode, Finalizable, nullptr } from "./Interop"`,
            `import { ArkUINodeType } from "./ArkUINodeType"`,
            `import { ArkComponent } from "@arkoala/arkui/ArkComponent"`
        ].forEach(it => printer.print(it))
    }

    generatePeerFile(): stringOrNone[] {
        const printer = new IndentedPrinter()

        const peerImports = new ImportsCollector()
        peerImports.addFilterByBasename(renameDtsToPeer(path.basename(this.originalFilename)))
        this.peers.forEach(peer => peer.collectPeerImports(peerImports))
        peerImports.print(printer)
        this.printDefaultPeerImports(printer)

        this.peers.forEach(peer => peer.printPeer(printer))
        return printer.getOutput()
    }

    generateComponentFile(): stringOrNone[] {
        const printer = new IndentedPrinter()

        const componentImports = new ImportsCollector()
        componentImports.addFilterByBasename(renameDtsToComponent(path.basename(this.originalFilename)))
        this.peers.forEach(peer => peer.collectComponentImports(componentImports))
        componentImports.print(printer)

        this.peers.forEach(peer => peer.printComponent(printer))
        return printer.getOutput()
    }

    printGlobal(printers: Printers): void {
        this.peers.forEach(it => it.printGlobal(printers))
    }
}