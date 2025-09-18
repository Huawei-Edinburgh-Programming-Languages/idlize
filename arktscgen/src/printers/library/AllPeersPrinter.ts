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

import { MultiFilePrinter, MultiFileOutput } from "../MultiFilePrinter"
import {
    createEmptyReferenceResolver,
    IDLFile,
    IDLInterface,
    IDLKind,
    IDLNamespace,
    IDLNode,
    IDLReferenceType,
    IDLType,
    IndentedPrinter,
    isInterface,
    TSLanguageWriter
} from "@idlizer/core"
import { Importer } from "./Importer"
import { PeerPrinter } from "./PeerPrinter"
import { Config } from "../../general/Config"
import { fqName } from "../../utils/idl"
import { dropPrefix } from "../../utils/string"
import { PeersConstructions } from "../../constuctions/PeersConstructions"
import { convertAndImport } from "../../type-convertors/top-level/ImporterTypeConvertor"
import { LibraryTypeConvertor } from "../../type-convertors/top-level/LibraryTypeConvertor"
import { Typechecker } from "../../general/Typechecker"

export class AllPeersPrinter extends MultiFilePrinter {
    private typechecker = new Typechecker(this.idl)

    constructor(private config: Config, idl: IDLFile) {
        super(idl)
    }

    protected filterInterface(node: IDLInterface): boolean {
        return !this.typechecker.isPeer(node) || this.config.ignore.isIgnoredPeer(fqName(node))
    }

    printInterface(node: IDLInterface): MultiFileOutput {
        const importer = new Importer(this.typechecker, '.', node.name)
        const printer = new PeerPrinter(this.config, this.typechecker, importer)
        const writer = this.makeWriter(importer)

        printer.printInterface(node, writer)
        return {
            fileName: PeersConstructions.fileName(node.name),
            output: [
                importer?.getOutput() ?? [],
                [''], // empty line
                writer.getOutput()
            ]
                .flat()
                .join(`\n`)
            }
    }

    private makeWriter(importer: Importer): TSLanguageWriter {
        const converter = {
            convert: (node: IDLType) => convertAndImport(
                importer,
                new class extends LibraryTypeConvertor {
                    convertTypeReference(type: IDLReferenceType): string {
                        return dropPrefix(super.convertTypeReference(type), Config.dataClassPrefix)
                    }
                } (this.typechecker),
                node
            )
        }

        return new TSLanguageWriter(new IndentedPrinter(), createEmptyReferenceResolver(), converter)
    }

}
