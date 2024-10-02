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
import * as fs from 'fs'
import * as path from 'path'

import { IndentedPrinter } from "../IndentedPrinter";
import { MaterializedClass } from "./Materialized";
import { EnumEntity } from './PeerFile';
import { IdlPeerLibrary } from './idl/IdlPeerLibrary';
import { IdlPeerClass } from './idl/IdlPeerClass';
import { CppLanguageWriter, Method, MethodSignature, Type } from './LanguageWriters';
import { IDLEntry, IDLType, IDLVoidType, isClass } from '../idl';
import { readLangTemplate } from './FileGenerators';
import { Language } from '../util';


class OHOSVisitor {
    hWriter = new CppLanguageWriter(new IndentedPrinter())
    cppWriter = new CppLanguageWriter(new IndentedPrinter())

    constructor(
        protected library: IdlPeerLibrary
    ) { }

    visitDeclaration(entry: IDLEntry): void {
        if (isClass(entry)) {
            this.cppWriter.writeClass(entry.name, (writer) => {
                entry.constructors.forEach(it => {
                    writer.writeConstructorImplementation(entry.name,
                        this.cppWriter.makeSignature(IDLVoidType, it.parameters), (writer) => {
                    })
                })
                entry.methods.forEach(it => {
                    writer.writeMethodImplementation(new Method(it.name,
                        this.cppWriter.makeSignature(it.returnType, it.parameters)), (writer) => {
                    })
                })
            })
        }
    }

    execute(outDir: string) {
        this.hWriter.writeLines(readLangTemplate('ohos_api_prologue.h', Language.CPP))
        this.hWriter.writeLines(readLangTemplate('ohos_api_epilogue.h', Language.CPP))
        this.hWriter.printTo(path.join(outDir, "libxml.h"))

        this.library.files.forEach(file => {
            file.entries.forEach(entry => this.visitDeclaration(entry))

        })
        this.cppWriter.printTo(path.join(outDir, "libxml.cc"))
    }
}


export function generateOhos(outDir: string, peerLibrary: IdlPeerLibrary): void {
    console.log("GENERATE OHOS")

    if (!fs.existsSync(outDir)) fs.mkdirSync(outDir)

    const visitor = new OHOSVisitor(peerLibrary)
    visitor.execute(outDir)
}
