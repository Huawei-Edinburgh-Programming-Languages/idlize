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

import { TypeProcessor } from "../../Library"
import { DeclarationTable, PrimitiveType } from "../../peer-generation/DeclarationTable"
import { createLanguageWriter, LanguageWriter, Method, NamedMethodSignature, Type } from "../../peer-generation/LanguageWriters"
import { TSTypeNodeNameConvertor, TypeNodeNameConvertor } from "../../peer-generation/TypeNodeNameConvertor"
import { Language } from "../../util"
import { ImportExport } from "../ImportExport"
import { SkoalaTypeProcessor } from "../SkoalaDeclarationTable"
import { SkoalaLibrary } from "../SkoalaLibrary"
import * as ts from "typescript"
import * as path from "path"

export function makeTSSerializer(library: SkoalaLibrary): string {
    let printer = createLanguageWriter(Language.TS)
    let typeProcessor = new SkoalaTypeProcessor(library.typeChecker)
    const serializorPrinter = new SerializerPrinter(library, printer, typeProcessor)
    serializorPrinter.print()
    return `
${printer.getOutput().join("\n")}

export function createSerializer(): Serializer { return new Serializer() }
`
}

class SerializerPrinter {
    constructor(
        private readonly library: SkoalaLibrary,
        private readonly writer: LanguageWriter,
        private readonly typeProcessor: TypeProcessor
    ) { }

    private generateSerializer(writer: LanguageWriter, target: ts.ClassDeclaration | ts.InterfaceDeclaration,
        typeNodeNameConvertor: TypeNodeNameConvertor) {
        const name = target.name?.text ?? ""

        writer.writeMethodImplementation(
            new Method(`write${name}`,
                new NamedMethodSignature(Type.Void, [new Type(name)], ["value"])),
            writer => {
                let struct = this.typeProcessor.targetStruct(target) // try Rect
                if (struct.getFields().length > 0) {
                    writer.writeStatement(
                        writer.makeAssign("valueSerializer", new Type(writer.makeRef("Serializer")), writer.makeThis(), true, false))
                }
                struct.getFields().forEach(it => {
                    let field = `value_${it.name}`
                    writer.writeStatement(writer.makeAssign(field, undefined, writer.makeString(`value.${writer.languageKeywordProtection(it.name)}`), true))
                    let typeConvertor = this.typeProcessor.typeConvertor(`value`, it.type!, it.optional, typeNodeNameConvertor)
                    typeConvertor.convertorSerialize(`value`, field, writer)
                })
            })
    }

    private printImports(writer: LanguageWriter, serializerDeclarations?: Set<ts.ClassDeclaration | ts.InterfaceDeclaration>) {
        writer.print(`import { SerializerBase, Tags, RuntimeType, runtimeType, isInstanceOf } from "./SerializerBase"`)
        writer.print(`import { int32 } from "@koalaui/common"`)
        writer.print(`import { unsafeCast } from "./utils"`)

        serializerDeclarations?.forEach(decl => {
            if (!ts.isSourceFile(decl.parent)) {
                throw "Expected parent of declaration to be a SourceFile"
            } else {
                const basename = path.basename(decl.parent.fileName)
                const basenameNoExt = basename.slice(0, basename.indexOf('.'))
                writer.print(`import { ${decl.name?.text} } from "./${basenameNoExt}"`)
            }
        })
    }

    print() {
        this.printImports(this.writer, this.library.serializerDeclarations)

        const className = "Serializer"
        const superName = `${className}Base`
        let prefix = ""
        let ctorSignature: NamedMethodSignature | undefined = undefined
        switch (this.writer.language) {
            case Language.ARKTS:
                ctorSignature = new NamedMethodSignature(Type.Void, [], [])
                break;
            case Language.CPP:
                ctorSignature = new NamedMethodSignature(Type.Void, [new Type("uint8_t*")], ["data"])
                prefix = PrimitiveType.ArkPrefix
                break;
            case Language.JAVA:
                ctorSignature = new NamedMethodSignature(Type.Void, [], [])
                break;
        }
        const serializerDeclarations = this.library.serializerDeclarations
        const serializerWriter = createLanguageWriter(this.writer.language)
        const typeNodeNameConvertor = new TSTypeNodeNameConvertor()
        // just a separator
        serializerWriter.print("")
        serializerWriter.writeClass(className, writer => {
            if (ctorSignature) {
                const ctorMethod = new Method(superName, ctorSignature)
                writer.writeConstructorImplementation(className, ctorSignature, _ => { }, ctorMethod)
            }
            serializerDeclarations.forEach(decl =>
                this.generateSerializer(serializerWriter, decl, typeNodeNameConvertor)) // 2.
        }, superName)

        this.writer.print(serializerWriter.printer.getOutput().join("\n"))
    }
}