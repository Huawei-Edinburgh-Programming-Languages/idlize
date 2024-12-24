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
import { createConstructor, createContainerType, createOptionalType, createReferenceType, createTypeParameterReference, DebugUtils, forceAsNamedNode, getExtAttribute, hasExtAttribute, IDLBufferType, IDLCallback, IDLConstructor, IDLEntry, IDLEnum, IDLExtendedAttributes, IDLI32Type, IDLI64Type, IDLInterface, IDLInterfaceSubkind, IDLMethod, IDLParameter, IDLPointerType, IDLStringType, IDLType, IDLU8Type, IDLUint8ArrayType, IDLVoidType, isCallback, isConstructor, isContainerType, isEnum, isInterface, isMethod, isNamedNode, isReferenceType, isType, isUnionType } from '../idl'
import { IndentedPrinter } from "../IndentedPrinter"
import { Language } from '../Language'
import { capitalize, getOrPut } from '../util'
import { ArgConvertor, generateCallbackAPIArguments } from '../peer-generation/ArgConvertors'
import { PrimitiveType } from '../peer-generation/ArkPrimitiveType'
import { makeDeserializeAndCall, makeSerializerForOhos, readLangTemplate } from '../peer-generation/FileGenerators'
import { qualifiedName } from '../peer-generation/idl/common'
import { isMaterialized } from '../peer-generation/idl/IdlPeerGeneratorVisitor'
import { CppLanguageWriter, createLanguageWriter, ExpressionStatement, FieldModifier, LanguageExpression, LanguageWriter, Method, MethodModifier, MethodSignature, NamedMethodSignature } from '../peer-generation/LanguageWriters'
import { PeerLibrary } from '../peer-generation/PeerLibrary'
import { printBridgeCcForOHOS } from '../peer-generation/printers/BridgeCcPrinter'
import { printCallbacksKinds, printManagedCaller } from '../peer-generation/printers/CallbacksPrinter'
import { writeDeserializer, writeSerializer } from '../peer-generation/printers/SerializerPrinter'
import { CppSourceFile } from '../peer-generation/printers/SourceFile'
import { StructPrinter } from '../peer-generation/printers/StructPrinter'
import { NativeModuleType } from '../peer-generation/NativeModuleType'

class PluginApiVisitor {
    implementationStubsFile: CppSourceFile

    hWriter = new CppLanguageWriter(new IndentedPrinter(), this.library)
    cppWriter = new CppLanguageWriter(new IndentedPrinter(), this.library)

    peerWriter: LanguageWriter
    nativeWriter: LanguageWriter
    nativeFunctionsWriter: LanguageWriter
    arkUIFunctionsWriter: LanguageWriter

    libraryName: string = ""

    interfaces = new Array<IDLInterface>()
    data = new Array<IDLInterface>()
    enums = new Array<IDLEnum>()
    callbacks = new Array<IDLCallback>()
    callbackInterfaces = new Array<IDLInterface>()

    constructor(protected library: PeerLibrary) {
        if (this.library.files.length == 0)
            throw new Error("No files in library")

        this.libraryName = this.library.files.filter(f => !f.isPredefined)[0].packageName().toUpperCase()
        if (this.libraryName.startsWith("\"") && this.libraryName.endsWith("\"")) {
            this.libraryName = this.libraryName.slice(1, this.libraryName.length - 1)
        }
        this.library.name = this.libraryName

        this.peerWriter = createLanguageWriter(library.language, library)
        this.nativeWriter = createLanguageWriter(library.language, library)
        this.nativeFunctionsWriter = createLanguageWriter(library.language, library)
        this.arkUIFunctionsWriter = createLanguageWriter(library.language, library)

        const fileNamePrefix = this.libraryName.toLowerCase()
        this.implementationStubsFile = new CppSourceFile(`${fileNamePrefix}Impl_template${Language.CPP.extension}`, library)
        this.implementationStubsFile.addInclude(`${fileNamePrefix}.h`)
    }

    private static knownBasicTypes = new Set(['ArrayBuffer', 'DataView'])

    mapType(type: IDLType | IDLEnum): string {
        const typeName = isEnum(type)
            ? type.name
            : isContainerType(type) || isUnionType(type)
                ? ''
                : forceAsNamedNode(type).name
        if (PluginApiVisitor.knownBasicTypes.has(typeName))
            return `${PrimitiveType.Prefix}${typeName}`

        if (isReferenceType(type) || isEnum(type)) {
            return `${PrimitiveType.Prefix}${this.libraryName}_${qualifiedName(type, Language.CPP)}`
        }
        return this.hWriter.getNodeName(type)
    }

    makeSignature(returnType: IDLType, parameters: IDLParameter[]): MethodSignature {
        return new MethodSignature(returnType, parameters.map(it => it.type!))
    }

    private printPeer() {
        this.data.forEach(data => {
            this.peerWriter.writeInterface(data.name, writer => {
                data.properties.forEach(prop => {
                    writer.writeFieldDeclaration(prop.name, prop.type, [], prop.isOptional)
                })
            })
        })
        this.enums.forEach(e => {
            const writer = this.peerWriter
            writer.writeStatement(writer.makeEnumEntity(e, true))
        })
        this.interfaces.forEach(int => {
            this.peerWriter.writeInterface(`${int.name}Interface`, writer => {
                int.methods.forEach(method => {
                    const signature = writer.makeNamedSignature(method.returnType, method.parameters)
                    writer.writeMethodDeclaration(method.name, signature)
                })
            })
        })
        this.interfaces.forEach(int => {
            this.peerWriter.writeClass(`${int.name}`, writer => {
                let peerInitExpr: LanguageExpression | undefined = undefined
                // TODO Make peer private again
                writer.writeFieldDeclaration('peer', createReferenceType("Finalizable"), [/* FieldModifier.PRIVATE */], false, peerInitExpr)
                const ctors = int.constructors.map(it => ({ parameters: it.parameters, returnType: it.returnType }))
                ctors.forEach(ctor => {
                    const signature = writer.makeNamedSignature(ctor.returnType ?? IDLVoidType, ctor.parameters)
                    // TODO remove duplicated code from writePeerMethod (PeersPrinter.ts)
                    const argConvertors = ctor.parameters.map(param => generateArgConvertor(this.library, param))
                    let scopes = argConvertors.filter(it => it.isScoped)
                    scopes.forEach(it => {
                        writer.pushIndent()
                        writer.print(it.scopeStart?.(it.param, writer.language))
                    })

                    let serializerPushed = false
                    let params: LanguageExpression[] = []
                    argConvertors.forEach(it => {
                        if (it.useArray) {
                            if (!serializerPushed) {
                                params.push(writer.makeMethodCall(`thisSerializer`, 'asArray', []))
                                params.push(writer.makeMethodCall(`thisSerializer`, 'length', []))
                                serializerPushed = true
                            }
                        } else {
                            params.push(writer.makeString(it.convertorArg(it.param, writer)))
                        }
                    })

                    writer.writeConstructorImplementation(int.name, signature, writer => {
                        if (serializerPushed) {
                            writer.writeStatement(
                                writer.makeAssign(`thisSerializer`, createReferenceType('Serializer'),
                                    writer.makeMethodCall('Serializer', 'hold', []), true)
                            )
                        }
                        argConvertors.forEach((it) => {
                            if (it.useArray) {
                                it.convertorSerialize(`this`, it.param, writer)
                            }
                        })
                        
                        const createPeerExpression = writer.makeNewObject("Finalizable", [
                            writer.makeNativeCall(NativeModuleType.PluginApi, `_${int.name}_ctor`, params),
                            writer.makeString(`${int.name}.getFinalizer()`)
                        ])
                        writer.writeStatement(
                            writer.makeAssign('this.peer', undefined, createPeerExpression, false)
                        )

                        if (serializerPushed) {
                            writer.writeStatement(new ExpressionStatement(
                                writer.makeMethodCall('thisSerializer', 'release', [])))
                            scopes.reverse().forEach(it => {
                                writer.popIndent()
                                writer.print(it.scopeEnd!(it.param, writer.language))
                            })
                        }
                    })
                })

                // extra memebers from MaterializerPrinter.ts
                // TODO refactor MaterializedPrinter to generate OHOS peers

                // write getFinalizer() method
                const getFinalizerSig = new MethodSignature(IDLPointerType, [])
                writer.writeMethodImplementation(new Method("getFinalizer", getFinalizerSig, [MethodModifier.STATIC]), writer => {
                    const callExpression = writer.makeNativeCall(
                        NativeModuleType.PluginApi,
                        `_${int.name}_getFinalizer`, // TODO temporarily removed _${this.libraryName} prefix
                        []
                    );
                    writer.writeStatement(writer.makeReturn(callExpression))
                })

                // write getPeer() method
                const getPeerSig = new MethodSignature(createOptionalType(createReferenceType("Finalizable")),[])
                writer.writeMethodImplementation(new Method("getPeer", getPeerSig), writer => {
                    // TODO add better (platform-agnostic) way to return Finalizable
                    writer.writeStatement(writer.makeReturn(writer.makeString("this.peer")))
                })
                
                // write construct(ptr: number) method
                if (ctors.length === 0) {
                    const typeArguments = int.typeParameters
                    const clazzRefType = createReferenceType(int.name, typeArguments?.map(createTypeParameterReference))
                    const constructSig = new NamedMethodSignature(clazzRefType, [IDLPointerType], ["ptr"])
                    writer.writeMethodImplementation(new Method("construct", constructSig, [MethodModifier.STATIC], typeArguments), writer => {
                        const objVar = `obj${int.name}`
                        writer.writeStatement(writer.makeAssign(objVar, clazzRefType, writer.makeNewObject(int.name), true))
                        writer.writeStatement(
                            writer.makeAssign(`${objVar}.peer`, createReferenceType("Finalizable"),
                                writer.makeString(`new Finalizable(ptr, ${int.name}.getFinalizer())`), false),
                        )
                        writer.writeStatement(writer.makeReturn(writer.makeString(objVar)))
                    })
                }

                int.methods.forEach(method => {
                    const signature = writer.makeNamedSignature(method.returnType, method.parameters)
                    writer.writeMethodImplementation(new Method(method.name, signature), writer => {
                        // TODO remove duplicated code from writePeerMethod (PeersPrinter.ts)
                        const argConvertors = method.parameters.map(param => generateArgConvertor(this.library, param))
                        let scopes = argConvertors.filter(it => it.isScoped)
                        scopes.forEach(it => {
                            writer.pushIndent()
                            writer.print(it.scopeStart?.(it.param, writer.language))
                        })
                        let serializerCreated = false
                        argConvertors.forEach((it) => {
                            if (it.useArray) {
                                if (!serializerCreated) {
                                    writer.writeStatement(
                                        writer.makeAssign(`thisSerializer`, createReferenceType('Serializer'),
                                            writer.makeMethodCall('Serializer', 'hold', []), true)
                                    )
                                    serializerCreated = true
                                }
                                it.convertorSerialize(`this`, it.param, writer)
                            }
                        })
                        let serializerPushed = false
                        let params = [ writer.makeString('this.peer.ptr')]
                        argConvertors.forEach(it => {
                            if (it.useArray) {
                                if (!serializerPushed) {
                                    params.push(writer.makeMethodCall(`thisSerializer`, 'asArray', []))
                                    params.push(writer.makeMethodCall(`thisSerializer`, 'length', []))
                                    serializerPushed = true
                                }
                            } else {
                                params.push(writer.makeString(writer.escapeKeyword(it.convertorArg(it.param, writer))))
                            }
                        })
                        const callExpression = writer.makeNativeCall(
                            NativeModuleType.PluginApi,
                            `_${int.name}_${method.name}`, // TODO temporarily removed _${this.libraryName} prefix
                            params
                        )
                        if (method.returnType === IDLVoidType) {
                            writer.writeStatement(writer.makeStatement(callExpression))
                        } else {
                            writer.writeStatement(writer.makeAssign("result", undefined, callExpression, true, true))
                        }
                        if (serializerPushed) {
                            writer.writeStatement(new ExpressionStatement(
                                writer.makeMethodCall('thisSerializer', 'release', [])))
                            scopes.reverse().forEach(it => {
                                writer.popIndent()
                                writer.print(it.scopeEnd!(it.param, writer.language))
                            })
                        }
                        if (method.returnType !== IDLVoidType) {
                            writer.writeStatement(writer.makeReturn(writer.makeString("result")))
                        }
                    })
                })
            }, undefined, [`${int.name}Interface`])

            // TODO Migrate to MaterializedPrinter
            if (int.constructors.length === 0) {
                // Write MaterializedClass static
                this.peerWriter.writeClass(`${int.name}Internal`, writer => {
                    // write fromPtr(ptr: number):MaterializedClass method
                    const clazzRefType = createReferenceType(int.name, int.typeParameters?.map(createTypeParameterReference))
                    const fromPtrSig = new NamedMethodSignature(clazzRefType, [IDLPointerType], ["ptr"])
                    writer.writeMethodImplementation(new Method("fromPtr", fromPtrSig, [MethodModifier.PUBLIC, MethodModifier.STATIC], int.typeParameters), writer => {
                        const objVar = `obj`
                        writer.writeStatement(writer.makeAssign(objVar,
                            clazzRefType,
                            //TODO: Need to pass IDLType instead of string to makeNewObject
                            writer.makeNewObject(writer.getNodeName(clazzRefType)),
                            true)
                        )
                        writer.writeStatement(
                            writer.makeAssign(`${objVar}.peer`, createReferenceType("Finalizable"),
                                writer.makeString(`new Finalizable(ptr, ${int.name}.getFinalizer())`), false),
                        )
                        writer.writeStatement(writer.makeReturn(writer.makeString(objVar)))
                    })
                })
            }
        })
    }

    execute(outDir: string, managedOutDir: string) {
        console.log(`GENERATE PLUGIN API for ${this.libraryName}`)

        this.library.files.forEach(file => {
            file.entries.forEach(entry => {
                if (isInterface(entry)) {
                    if (isMaterialized(entry)) {
                        this.interfaces.push(entry)
                    } else {
                        this.data.push(entry)
                    }
                } else if (isEnum(entry)) {
                    this.enums.push(entry)
                }
                entry.scope?.forEach(it => {
                    if (isCallback(it))
                        this.callbacks.push(it)
                })
            })
        })

        this.printPeer()

        const fileNamePrefix = this.libraryName.toLowerCase()

        const peerTemplate = readLangTemplate(`PluginApiPeer_template.ts`, this.library.language)
        const peerText = peerTemplate
            .replaceAll('%PEER_CONTENT%', this.peerWriter.getOutput().join('\n'))

        fs.writeFileSync(path.join(managedOutDir, `${fileNamePrefix}.ts`), peerText, 'utf-8')
    }
}

export function generatePluginApi(outDir: string, peerLibrary: PeerLibrary): void {
    const managedOutDir = path.join(outDir, peerLibrary.language.name.toLocaleLowerCase())
    if (!fs.existsSync(outDir)) fs.mkdirSync(outDir)
    if (!fs.existsSync(managedOutDir)) fs.mkdirSync(managedOutDir)

    const visitor = new PluginApiVisitor(peerLibrary)
    visitor.execute(outDir, managedOutDir)
}

function generateArgConvertor(library: PeerLibrary, param: IDLParameter): ArgConvertor {
    if (!param.type) throw new Error("Type is needed")
    return library.typeConvertor(param.name, param.type, param.isOptional)
}
