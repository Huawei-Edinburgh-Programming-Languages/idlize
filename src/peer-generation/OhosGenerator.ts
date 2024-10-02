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
import { IDLEntry, IDLInterface, IDLType, IDLVoidType, isClass, isInterface } from '../idl';
import { readLangTemplate } from './FileGenerators';
import { capitalize, Language } from '../util';
import { PrimitiveType } from './DeclarationTable';


class OHOSVisitor {
    hWriter = new CppLanguageWriter(new IndentedPrinter())
    cppWriter = new CppLanguageWriter(new IndentedPrinter())

    interfaces = new Array<IDLInterface>()

    constructor(
        protected library: IdlPeerLibrary
    ) { }

    private writeModifier(libraryName: string, clazz: IDLInterface) {
        let name = this.modifierName(libraryName, clazz.name)
        let handleType = this.handleType(libraryName, clazz.name)
        let _ = this.hWriter
        _.print(`typedef struct ${handleType}Opaque;`)
        _.print(`typedef struct ${handleType}Opaque* ${handleType};`)
        _.print(`typedef struct ${name} {`)
        _.pushIndent()
        clazz.constructors.forEach((_, index) => {
            let name = `construct${(index > 0) ? index.toString() : ""}`
            this.hWriter.print(`${handleType} (*${name})();`)
        })
        clazz.methods.forEach((method, index) => {
            let params = new Array<[string, Type]>()
            if (!method.isStatic) {
                params.push(["thiz", new Type(handleType)])
            }
            let returnType = _.mapIDLType(method.returnType)
            params = params.concat(method.parameters.map(it => [it.name, this.hWriter.mapIDLType(it.type!)]))
            this.hWriter.print(`${_.mapType(returnType)} (*${method.name})(${params.map(it => `${_.mapType(it[1])} ${it[0]}`).join(", ")});`)
        })
        this.hWriter.popIndent()
        this.hWriter.print(`} ${name};`)
    }

    private modifierName(libraryName: string, name: string): string {
        return `${PrimitiveType.Prefix}${libraryName}_${name}Modifier`
    }
    private handleType(libraryName: string, name: string): string {
        return `${PrimitiveType.Prefix}${libraryName}_${name}Handle`
    }

    private writeModifiers() {
        let libraryName = 'xml' // TODO: deduce from package/smth.

        this.interfaces.forEach(it => {
            this.writeModifier(libraryName, it)
        })
        let name = `${PrimitiveType.Prefix}${libraryName}_API`
        this.hWriter.print(`typedef struct ${name} {`)
        this.hWriter.pushIndent()
        this.hWriter.print(`${PrimitiveType.Prefix}Int32 version;`)
        this.interfaces.forEach(it => {
            let name = this.modifierName(libraryName, it.name)
            this.hWriter.print(`const ${name}* (*${capitalize(it.name)})();`)
        })
        this.hWriter.popIndent()
        this.hWriter.print(`} ${name};`)
    }

    private writeClass(clazz: IDLInterface) {
        this.cppWriter.writeClass(clazz.name, (writer) => {
            clazz.constructors.forEach(it => {
                writer.writeConstructorImplementation(clazz.name,
                    this.cppWriter.makeSignature(IDLVoidType, it.parameters), (writer) => {
                })
            })
            clazz.methods.forEach(it => {
                writer.writeMethodImplementation(new Method(it.name,
                    this.cppWriter.makeSignature(it.returnType, it.parameters)), (writer) => {
                })
            })
        })
    }

    visitDeclaration(entry: IDLEntry): void {
        if (isClass(entry)) {
            this.writeClass(entry)
        }
    }

    execute(outDir: string) {
        PrimitiveType.Prefix = "OH_"

        this.library.files.forEach(file => {
            file.entries.forEach(entry => {
                if (isInterface(entry) || isClass(entry)) this.interfaces.push(entry)
            })
        })

        this.hWriter.writeLines(readLangTemplate('ohos_api_prologue.h', Language.CPP))
        this.writeModifiers()
        this.library.files.forEach(file => {
            file.entries.forEach(entry => this.visitDeclaration(entry))
        })
        this.hWriter.writeLines(readLangTemplate('ohos_api_epilogue.h', Language.CPP))

        this.hWriter.printTo(path.join(outDir, "xml.h"))
        this.cppWriter.printTo(path.join(outDir, "xml.cc"))
    }
}

export function generateOhos(outDir: string, peerLibrary: IdlPeerLibrary): void {
    console.log("GENERATE OHOS API")

    if (!fs.existsSync(outDir)) fs.mkdirSync(outDir)

    const visitor = new OHOSVisitor(peerLibrary)
    visitor.execute(outDir)
}
