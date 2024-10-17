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

import * as idl from '../../idl'
import { Language } from "../../Language";
import { PrimitiveType } from "../ArkPrimitiveType"
import { LanguageWriter, Method, NamedMethodSignature, Type } from "../LanguageWriters";
import { PeerGeneratorConfig } from '../PeerGeneratorConfig';
import { ImportsCollector } from '../ImportsCollector';
import { IdlPeerLibrary } from '../idl/IdlPeerLibrary';
import { isMaterialized } from '../idl/IdlPeerGeneratorVisitor';
import { makeSyntheticDeclarationsFiles } from '../idl/IdlSyntheticDeclarations';
import { collectProperties } from '../idl/StructPrinter';

class IdlSerializerPrinter {
    constructor(
        private readonly library: IdlPeerLibrary,
        private readonly writer: LanguageWriter,
    ) {}

    private generateSerializer(target: idl.IDLInterface, prefix: string = "") {
        const name = this.library.computeTargetName(target, false, prefix)
        const methodName = target.name
        this.library.setCurrentContext(`write${methodName}()`)
        this.writer.writeMethodImplementation(
            new Method(`write${methodName}`,
                new NamedMethodSignature(Type.Void, [new Type(name)], ["value"])),
            writer => {
                const properties = collectProperties(target, this.library)
                if (properties.length > 0) {
                    writer.writeStatement(
                        writer.makeAssign("valueSerializer", new Type(writer.makeRef("Serializer")), writer.makeThis(), true, false))
                }
                properties.forEach(it => {
                    let field = `value_${it.name}`
                    writer.writeStatement(writer.makeAssign(field, undefined, writer.makeString(`value.${writer.escapeKeyword(it.name)}`), true))
                    let typeConvertor = this.library.typeConvertor(`value`, it.type!, it.isOptional)
                    typeConvertor.convertorSerialize(`value`, field, writer)
                })
            })
        this.library.setCurrentContext(undefined)
    }

    print() {
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
                prefix = PrimitiveType.Prefix
                break;
            case Language.JAVA:
                ctorSignature = new NamedMethodSignature(Type.Void, [], [])
                break;
        }
        const serializerDeclarations = getSerializers(this.library)
        printIdlImports(this.library, this.writer)
        // just a separator
        this.writer.print("")
        this.writer.writeClass(className, writer => {
            if (ctorSignature) {
                const ctorMethod = new Method(superName, ctorSignature)
                writer.writeConstructorImplementation(className, ctorSignature, writer => {
                }, ctorMethod)
            }
            serializerDeclarations.forEach(decl => this.generateSerializer(decl, prefix))
            if (this.writer.language == Language.JAVA) {
                // TODO: somewhat ugly.
                this.writer.print(`static Serializer createSerializer() { return new Serializer(); }`)
            }
        }, superName)
    }
}

class IdlDeserializerPrinter {///converge w/ IdlSerP?
    constructor(
        private readonly library: IdlPeerLibrary,
        private readonly writer: LanguageWriter,
    ) {}

    private generateDeserializer(target: idl.IDLInterface, prefix: string = "") {
        const name = this.library.computeTargetName(target, false, prefix)
        const methodName = this.library.computeTargetName(target, false, "")
        const type = new Type(name)
        this.writer.writeMethodImplementation(new Method(`read${methodName}`, new NamedMethodSignature(type, [], [])), writer => {
            function declareDeserializer() {
                writer.writeStatement(
                    writer.makeAssign("valueDeserializer", new Type(writer.makeRef("Deserializer")), writer.makeThis(), true, false))
            }
            const properties = collectProperties(target, this.library)
            // using list initialization to prevent uninitialized value errors
            const valueType = writer.language !== Language.TS ? type /// refac into LW
                : new Type(`{${properties.map(it => `${it.name}?: ${this.library.mapType(it.type)}`).join(",")}}`)
            writer.writeStatement(writer.makeAssign("value", valueType, writer.makeString(`{}`), true, false))

            if (idl.isInterface(target) || idl.isClass(target)) {
                if (properties.length > 0) {
                    declareDeserializer()
                }
                properties.forEach(it => {
                    let typeConvertor = this.library.typeConvertor(`value`, it.type!, it.isOptional)
                    writer.writeStatement(typeConvertor.convertorDeserialize(`value`, `value.${writer.escapeKeyword(it.name)}`, writer))
                })
            } else {
                if (writer.language === Language.CPP) {
                    let typeConvertor = this.library.declarationConvertor("value", idl.createReferenceType((target as idl.IDLInterface).name), target)
                    declareDeserializer()
                    writer.writeStatement(typeConvertor.convertorDeserialize(`value`, `value`, writer))
                }
            }
            writer.writeStatement(writer.makeReturn(
                writer.makeCast(writer.makeString("value"), new Type(name))))
        })
    }

    print() {///converge w/ Ts printers
        const className = "Deserializer"
        const superName = `${className}Base`
        let ctorSignature: NamedMethodSignature | undefined = undefined
        let prefix = ""
        if (this.writer.language == Language.CPP) {
            ctorSignature = new NamedMethodSignature(Type.Void, [new Type("uint8_t*"), Type.Int32], ["data", "length"])
            prefix = PrimitiveType.Prefix
        }
        const serializerDeclarations = getSerializers(this.library)
        printIdlImports(this.library, this.writer)
        this.writer.print("")
        this.writer.writeClass(className, writer => {
            if (ctorSignature) {
                const ctorMethod = new Method(`${className}Base`, ctorSignature)
                writer.writeConstructorImplementation(className, ctorSignature, writer => {}, ctorMethod)
            }
            serializerDeclarations.forEach(decl => this.generateDeserializer(decl, prefix))
        }, superName)
    }
}

export function writeSerializer(library: IdlPeerLibrary, writer: LanguageWriter) {
    const printer = new IdlSerializerPrinter(library, writer)
    printer.print()
}

export function writeDeserializer(library: IdlPeerLibrary, writer: LanguageWriter) {
    const printer = new IdlDeserializerPrinter(library, writer)
    printer.print()
}

function getSerializers(library: IdlPeerLibrary): idl.IDLInterface[] {
    const seenNames = new Set<string>()
    return library.orderedDependenciesToGenerate
        .filter(it => !PeerGeneratorConfig.ignoreSerialization.includes(it.name!))
        .filter(it => (idl.isClass(it) || idl.isInterface(it)) && !isMaterialized(it))
        .filter(it => !isParameterized(it))
        .filter(it => {
            const seen = seenNames.has(it.name!)
            seenNames.add(it.name!)
            return !seen
        }) as idl.IDLInterface[]
}

function isParameterized(node: idl.IDLEntry) {
    return node.name !== "TransitionEffect"  // parameterized but we still need it
        && idl.hasExtAttribute(node, idl.IDLExtendedAttributes.TypeParameters)
        || ["Record", "Required"].includes(node.name!)
}

function printIdlImports(library: IdlPeerLibrary, writer: LanguageWriter) {
    if (writer.language === Language.TS) {
        const collector = new ImportsCollector()
        for (let [module, {dependencies, declarations}] of makeSyntheticDeclarationsFiles()) {
            declarations.forEach(it => collector.addFeature(it.name!, module))
        }
        for (let builder of library.builderClasses.keys()) {
            collector.addFeature(builder, `Ark${builder}Builder`)
        }
        collector.print(writer, `./peers/Serializer.${writer.language.extension}`)
    }
}