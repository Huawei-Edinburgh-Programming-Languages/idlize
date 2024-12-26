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
import { createConstructor, createContainerType, createOptionalType, createParameter, createReferenceType, createTypeParameterReference, DebugUtils, forceAsNamedNode, getExtAttribute, hasExtAttribute, IDLBufferType, IDLCallback, IDLConstructor, IDLEntry, IDLEnum, IDLExtendedAttributes, IDLI32Type, IDLI64Type, IDLInterface, IDLInterfaceSubkind, IDLMethod, IDLParameter, IDLPointerType, IDLStringType, IDLType, IDLU8Type, IDLUint8ArrayType, IDLVoidType, isCallback, isConstructor, isContainerType, isEnum, isInterface, isMethod, isNamedNode, isReferenceType, isType, isUnionType } from '../idl'
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

class NameType {
    constructor(public name: string, public type: string) {}
}

interface SignatureDescriptor {
    params: NameType[]
    returnType: string
    paramsCString?: string
}

class PluginApiVisitor {
    implementationStubsFile: CppSourceFile

    hWriter = new CppLanguageWriter(new IndentedPrinter(), this.library)
    cppWriter = new CppLanguageWriter(new IndentedPrinter(), this.library)

    peerWriter: LanguageWriter
    nativeWriter: LanguageWriter
    nativeFunctionsWriter: LanguageWriter
    // arkUIFunctionsWriter: LanguageWriter

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
        // this.arkUIFunctionsWriter = createLanguageWriter(library.language, library)

        const fileNamePrefix = this.libraryName.toLowerCase()
        this.implementationStubsFile = new CppSourceFile(`${fileNamePrefix}Impl_template${Language.CPP.extension}`, library)
        this.implementationStubsFile.addInclude(`${fileNamePrefix}.h`)
    }

    private static knownBasicTypes = new Set(['ArrayBuffer', 'DataView'])

    private static contextParam = createParameter("context", IDLPointerType)

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


    private writeCallback(callback: IDLCallback) {
        // TODO commonize with StructPrinter.ts
        const callbackTypeName = `${PrimitiveType.Prefix}${this.libraryName}_${callback.name}`;
        const args = generateCallbackAPIArguments(this.library, callback)
        let _ = this.hWriter
        _.print(`typedef struct ${callbackTypeName} {`)
        _.pushIndent()
        _.print(`${PrimitiveType.Prefix}CallbackResource resource;`)
        _.print(`void (*call)(${args.join(', ')});`)
        _.popIndent()
        _.print(`} ${callbackTypeName};`)
    }

    private impls = new Map<string, SignatureDescriptor>()

    private writeModifier(clazz: IDLInterface, writer: CppLanguageWriter) {
        let name = this.modifierName(clazz)
        let handleType = this.handleType(clazz.name)
        let _h = this.hWriter
        let _c = writer
        _h.print(`struct ${handleType}Opaque;`)
        _h.print(`typedef struct ${handleType}Opaque* ${handleType};`)
        _h.print(`typedef struct ${name} {`)
        _c.print(`const ${name}* ${name}Impl() {`)
        _c.pushIndent()
        _c.print(`const static ${name} instance = {`)
        _c.pushIndent()
        _h.pushIndent()
        let ctors = [...clazz.constructors]
        if (ctors.length == 0) {
            ctors.push(createConstructor([], undefined)) // Add empty fake constructor
        }
        ctors.forEach((ctor, index) => {
            let name = `construct${(index > 0) ? index.toString() : ""}`
            let params = ctor.parameters.map(it => new NameType(_h.escapeKeyword(it.name), this.mapType(it.type!)))
            let argConvertors = ctor.parameters.map(param => generateArgConvertor(this.library, param))
            let cppArgs = generateCParameters(ctor, argConvertors, _h)
            _h.print(`${handleType} (*${name})(${cppArgs});`) // TODO check
            let implName = `${clazz.name}_${name}Impl`
            _c.print(`&${implName},`)
            this.impls.set(implName, { params, returnType: handleType, paramsCString: cppArgs})
        })
        {
            let destructName = `${clazz.name}_destructImpl`
            let params = [new NameType("thiz", handleType)]
            _h.print(`void (*destruct)(${params.map(it => `${it.type} ${it.name}`).join(", ")});`)
            _c.print(`&${destructName},`)
            this.impls.set(destructName, { params, returnType: 'void'})
        }
        let isGlobalScope = hasExtAttribute(clazz, IDLExtendedAttributes.GlobalScope)
        clazz.methods.forEach(method => {
            let params = new Array<NameType>()
            if (!method.isStatic && !isGlobalScope) {
                params.push(new NameType("thiz", handleType))
            }
            params = params.concat(method.parameters.map(it => new NameType(_h.escapeKeyword(it.name), this.mapType(it.type!))))
            let returnType = this.mapType(method.returnType)
            const argConvertors = method.parameters.map(param => generateArgConvertor(this.library, param))
            const args = generateCParameters(method, argConvertors, _h)
            _h.print(`${returnType} (*${method.name})(${args});`)
            let implName = `${clazz.name}_${method.name}Impl`
            _c.print(`&${implName},`)
            this.impls.set(implName, { params, returnType, paramsCString: args })
        })
        clazz.properties.forEach(property => {
            let returnType = `${this.mapType(property.type)}`
            _h.print(`${returnType} (*get${capitalize(property.name)})(${handleType} thiz);`)
            let getImplName = `${clazz.name}get${capitalize(property.name)}Impl`
            _c.print(`&${getImplName},`)
            this.impls.set(getImplName, { params: [new NameType(`thiz`, returnType)], returnType })
            if (!property.isReadonly) {
                let setImplName = `${clazz.name}set${capitalize(property.name)}Impl`
                _h.print(`void (*set${capitalize(property.name)})(${handleType} thiz, ${returnType} value);`)
                _c.print(`&${setImplName},`)
                this.impls.set(setImplName, { params: [new NameType("thiz", handleType), new NameType("value", returnType)], returnType: "void" })
            }
        })
        _h.popIndent()
        _h.print(`} ${name};`)

        _c.popIndent()
        _c.print(`};`)
        _c.writeStatement(_c.makeReturn(_c.makeString("&instance")))
        _c.popIndent()
        _c.print(`}`)
    }

    private modifierName(clazz: IDLInterface): string {
        if (hasExtAttribute(clazz, IDLExtendedAttributes.GlobalScope)) {
            return `${PrimitiveType.Prefix}${this.libraryName}_Modifier`
        }
        return `${PrimitiveType.Prefix}${this.libraryName}_${clazz.name}Modifier`
    }
    private handleType(name: string): string {
        return `${PrimitiveType.Prefix}${this.libraryName}_${name}Handle`
    }

    private writeImpls() {
        let _ = this.cppWriter
        let _stubs = this.implementationStubsFile.content
        this.impls.forEach((signature, name) => {
            const declaration = `${signature.returnType} ${name}(${signature.paramsCString ?? signature.params.map(it => `${it.type} ${it.name}`).join(", ")})`
            _.print(`${declaration};`)
            _stubs.print(`${declaration} {`)
            _stubs.pushIndent()
            if (signature.returnType != "void") {
                _stubs.print('return {};')
            }
            _stubs.popIndent()
            _stubs.print(`}`)
        })
    }

    private writeModifiers(writer: CppLanguageWriter) {
        this.callbacks.forEach(it => {
            this.writeCallback(it)
        })
        this.interfaces.forEach(it => {
            this.writeModifier(it, writer)
        })
        // Create API.
        let api = this.libraryName
        let _c = writer
        _c.print(`const ${PrimitiveType.Prefix}${api}_API* Get${api}APIImpl(int version) {`)
        _c.pushIndent()
        _c.print(`const static ${PrimitiveType.Prefix}${api}_API api = {`)
        _c.pushIndent()
        _c.print(`1, // version`)
        this.interfaces.forEach(it => {
            _c.print(`&${this.modifierName(it)}Impl,`)
        })
        _c.popIndent()
        _c.print(`};`)
        _c.print(`if (version != api.version) return nullptr;`)
        _c.print(`return &api;`)
        _c.popIndent()
        _c.print(`}`)
        let name = `${PrimitiveType.Prefix}${api}_API`
        let _h = this.hWriter
        _h.print(`typedef struct ${name} {`)
        _h.pushIndent()
        _h.print(`${PrimitiveType.Prefix}Int32 version;`)
        this.interfaces.forEach(it => {
            _h.print(`const ${this.modifierName(it)}* (*${this.apiName(it)})();`)
        })
        _h.popIndent()
        _h.print(`} ${name};`)
    }

    private apiName(clazz: IDLInterface): string {
        if (hasExtAttribute(clazz, IDLExtendedAttributes.GlobalScope)) return capitalize(this.libraryName)
        return capitalize(clazz.name)
    }

    private printNative() {
        const className = `${this.libraryName}_NativeModule`
        NativeModuleType.PluginApi.name = className
        // this.callbacks.forEach(callback => {
        //     const params = callback.parameters.map(it => `${it.name}:${this.nativeWriter.getNodeName(it.type!)}`).join(', ')
        //     const returnTypeName = this.nativeWriter.getNodeName(callback.returnType)
        //     this.nativeWriter.print(`export type ${callback.name} = (${params}) => ${returnTypeName}`)
        // })
        // this.callbackInterfaces.forEach(int => {
        //     this.nativeWriter.writeInterface(int.name, writer => {
        //         int.methods.forEach(method => {
        //             writer.writeMethodDeclaration(
        //                 method.name,
        //                 writer.makeNamedSignature(method.returnType, method.parameters)
        //             )
        //         })
        //     })
        // })
        // printCallbacksKinds(this.library, this.nativeWriter)

        this.nativeFunctionsWriter.printer.pushIndent(this.nativeWriter.indentDepth() + 1)
        ;((writer: LanguageWriter) => {
            this.interfaces.forEach(it => {
                // TODO TBD do we need to provide declaration for "fake" constructor for interfaces?
                const ctors = it.constructors.map(it => ({ parameters: it.parameters, returnType: it.returnType }))
                ctors.forEach(ctor => {
                    const signature = makePeerCallSignature(this.library, ctor.parameters, IDLPointerType)
                    writer.writeNativeMethodDeclaration(`_Create${it.name}`, signature)
                })

                it.methods.forEach(method => {
                    const signature = makePeerCallSignature(this.library, method.parameters, method.returnType)
                    writer.writeNativeMethodDeclaration(`_${it.name}${method.name}`, signature)  // TODO temporarily removed _${this.libraryName} prefix
                })
            })
        })(this.nativeFunctionsWriter)

        // this.arkUIFunctionsWriter.printer.pushIndent(this.nativeWriter.indentDepth() + 1)
        // ;((writer: LanguageWriter) => {
        //     writer.writeNativeMethodDeclaration("_CheckArkoalaCallbackEvent",
        //         NamedMethodSignature.make(IDLI32Type, [
        //             { name: "buffer", type: IDLUint8ArrayType },
        //             { name: "bufferLength", type: IDLI32Type },
        //         ])
        //     )
        //     writer.writeNativeMethodDeclaration("_HoldArkoalaResource",
        //         NamedMethodSignature.make(IDLVoidType, [
        //             { name: "resourceId", type: IDLI32Type }
        //         ])
        //     )
        //     writer.writeNativeMethodDeclaration("_ReleaseArkoalaResource",
        //         NamedMethodSignature.make(IDLVoidType, [
        //             { name: "resourceId", type: IDLI32Type }
        //         ])
        //     )
        //     writer.writeNativeMethodDeclaration("_Utf8ToString",
        //         NamedMethodSignature.make(IDLStringType, [
        //             { name: "buffer", type: IDLUint8ArrayType },
        //             { name: "position", type: IDLI32Type },
        //             { name: "length", type: IDLI32Type },
        //         ])
        //     )
        //     if (writer.language === Language.TS) {
        //         writer.writeNativeMethodDeclaration("_MaterializeBuffer",
        //             NamedMethodSignature.make(IDLBufferType, [
        //                 { name: "data", type: IDLPointerType },
        //                 { name: "length", type: IDLI32Type },
        //                 { name: "resourceId", type: IDLI32Type },
        //                 { name: "holdPtr", type: IDLPointerType },
        //                 { name: "releasePtr", type: IDLPointerType },
        //             ])
        //         )
        //         writer.writeNativeMethodDeclaration("_GetNativeBufferPointer",
        //             NamedMethodSignature.make(IDLPointerType, [
        //                 { name: "data", type: IDLBufferType },
        //             ])
        //         )
        //     }
        //     if (writer.language === Language.ARKTS) {
        //         writer.writeNativeMethodDeclaration("_ManagedStringWrite", 
        //             NamedMethodSignature.make(IDLI32Type, [
        //                 { name: "str", type: IDLStringType },
        //                 { name: "arr", type: IDLUint8ArrayType },
        //                 { name: "len", type: IDLI32Type },
        //             ])
        //         )
        //     }
        // })(this.arkUIFunctionsWriter)
    }

    private printPeer() {
        this.peerWriter.print('import {')
            this.peerWriter.pushIndent()
            this.peerWriter.print(`${this.libraryName}_NativeModule,`)
            this.peerWriter.popIndent()
        this.peerWriter.print(`} from './${this.libraryName.toLocaleLowerCase()}_Native'`)
        this.peerWriter.print(``)

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
            this.peerWriter.writeInterface(`${int.name}_Interface`, writer => {
                int.methods.forEach(method => {
                    const signature = writer.makeNamedSignature(method.returnType, method.parameters)
                    writer.writeMethodDeclaration(method.name, signature)
                })
            })
            this.peerWriter.printer.print(``)
        })
        this.interfaces.forEach(int => {
            // -- export class Identifier {
            this.peerWriter.writeClass(`${int.name}`, writer => {
                // -- peer: KPointer
                writer.writeFieldDeclaration('peer', createReferenceType("KPointer"), [/* FieldModifier.PRIVATE */], false, undefined)
                // --
                writer.printer.print(``)
                const ctors = int.constructors.map(it => ({ parameters: it.parameters, returnType: it.returnType }))
                // -- <constructors>
                ctors.forEach(ctor => {
                    const signature = writer.makeNamedSignature(ctor.returnType ?? IDLVoidType, ctor.parameters)
                    // TODO remove duplicated code from writePeerMethod (PeersPrinter.ts)
                    const argConvertors = ctor.parameters.map(param => generateArgConvertor(this.library, param))
                    let scopes = argConvertors.filter(it => it.isScoped)
                    scopes.forEach(it => {
                        writer.pushIndent()
                        writer.print(it.scopeStart?.(it.param, writer.language))
                    })

                    // let serializerPushed = false
                    let params: LanguageExpression[] = []
                    argConvertors.forEach(it => {
                        // if (it.useArray) {
                        //     if (!serializerPushed) {
                        //         params.push(writer.makeMethodCall(`thisSerializer`, 'asArray', []))
                        //         params.push(writer.makeMethodCall(`thisSerializer`, 'length', []))
                        //         serializerPushed = true
                        //     }
                        // } else {
                            params.push(writer.makeString(it.convertorArg(it.param, writer)))
                        // }
                    })

                    writer.writeConstructorImplementation(int.name, signature, writer => {
                        // if (serializerPushed) {
                        //     writer.writeStatement(
                        //         writer.makeAssign(`thisSerializer`, createReferenceType('Serializer'),
                        //             writer.makeMethodCall('Serializer', 'hold', []), true)
                        //     )
                        // }
                        argConvertors.forEach((it) => {
                            if (it.useArray) {
                                it.convertorSerialize(`this`, it.param, writer)
                            }
                        })
                        
                        writer.writeStatement(
                            writer.makeAssign(
                                'this.peer',
                                undefined,
                                writer.makeNativeCall(
                                    NativeModuleType.PluginApi,
                                    `_Create${int.name}`,
                                    params
                                ),
                                false
                            )
                        )

                        // if (serializerPushed) {
                        //     writer.writeStatement(new ExpressionStatement(
                        //         writer.makeMethodCall('thisSerializer', 'release', [])))
                        //     scopes.reverse().forEach(it => {
                        //         writer.popIndent()
                        //         writer.print(it.scopeEnd!(it.param, writer.language))
                        //     })
                        // }
                    })
                    writer.printer.print(``)
                })

                // extra memebers from MaterializerPrinter.ts
                // TODO refactor MaterializedPrinter to generate OHOS peers

                // write getPeer() method
                const getPeerSig = new MethodSignature(createReferenceType("KPointer"),[])
                writer.writeMethodImplementation(new Method("getPeer", getPeerSig), writer => {
                    writer.writeStatement(writer.makeReturn(writer.makeString("this.peer")))
                })
                writer.printer.print(``)
                
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
                        let params: LanguageExpression[] = []
                        argConvertors.forEach(it => {
                            // if (it.useArray) {
                            //     if (!serializerPushed) {
                            //         params.push(writer.makeMethodCall(`thisSerializer`, 'asArray', []))
                            //         params.push(writer.makeMethodCall(`thisSerializer`, 'length', []))
                            //         serializerPushed = true
                            //     }
                            // } else {
                                params.push(writer.makeString(writer.escapeKeyword(it.convertorArg(it.param, writer))))
                            // }
                        })
                        const callExpression = writer.makeNativeCall(
                            NativeModuleType.PluginApi,
                            `_${int.name}${method.name}`, // TODO temporarily removed _${this.libraryName} prefix
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
                    writer.printer.print(``)
                })
            }, undefined, [`${int.name}_Interface`])
        })
    }

    private printC() {
        let callbackKindsPrinter = createLanguageWriter(Language.CPP, this.library);
        printCallbacksKinds(this.library, callbackKindsPrinter)

        this.cppWriter.writeLines(
            readLangTemplate('api_impl_prologue.cc', Language.CPP)
                .replaceAll("%INTEROP_MODULE_NAME%", `${this.libraryName.toUpperCase()}NativeModule`)
                .replaceAll("%API_HEADER_PATH%", `${this.libraryName.toLowerCase()}.h`)
                .replaceAll("%CALLBACK_KINDS%", callbackKindsPrinter.getOutput().join("\n"))
                .replaceAll("%LIBRARY_NAME%", this.libraryName.toUpperCase())
        )
        this.hWriter.writeLines(
            readLangTemplate('ohos_api_prologue.h', Language.CPP)
                .replaceAll("%INCLUDE_GUARD_DEFINE%", `OH_${this.libraryName.toUpperCase()}_H`)
                .replaceAll("%LIBRARY_NAME%", this.libraryName.toUpperCase())
        )

        let toStringsPrinter = createLanguageWriter(Language.CPP, this.library)
        new StructPrinter(this.library).generateStructs(this.hWriter, this.hWriter.printer, toStringsPrinter)
        this.cppWriter.concat(toStringsPrinter)
        const prefix = PrimitiveType.Prefix + this.library.libraryPrefix
        writeSerializer(this.library, this.cppWriter, prefix)
        writeDeserializer(this.library, this.cppWriter, prefix)

        let writer = new CppLanguageWriter(new IndentedPrinter(), this.library)
        this.writeModifiers(writer)
        this.writeImpls()
        this.cppWriter.concat(writer)
        this.cppWriter.concat(printBridgeCcForOHOS(this.library).generated)
        this.cppWriter.concat(makeDeserializeAndCall(this.library, Language.CPP, 'serializer.cc').content)
        this.cppWriter.concat(printManagedCaller(this.library).content)

        this.hWriter.writeLines(
            readLangTemplate('ohos_api_epilogue.h', Language.CPP)
                .replaceAll("%INCLUDE_GUARD_DEFINE%", `OH_${this.libraryName.toUpperCase()}_H`)
                .replaceAll("%LIBRARY_NAME%", this.libraryName.toUpperCase())
        )
        this.cppWriter.writeLines(
            readLangTemplate('api_impl_epilogue.cc', Language.CPP)
                .replaceAll("%LIBRARY_NAME%", this.libraryName.toUpperCase())
        )
    }

    execute(outDir: string, managedOutDir: string) {
        console.log(`GENERATE PLUGIN API for ${this.libraryName}`)

        this.library.files.forEach(file => {
            if (file.isPredefined) return
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

        // const callbackInterfaceNames = new Set<string>()
        // this.callbacks.forEach(it => {
        //     it.parameters.forEach(param => {
        //         if (this.interfaces.find(x => x.name === forceAsNamedNode(param.type!).name)) {
        //             callbackInterfaceNames.add(forceAsNamedNode(param.type!).name)
        //         }
        //     })
        // })

        const interfaces: IDLInterface[] = []
        this.interfaces.forEach(int => {
            // if (callbackInterfaceNames.has(int.name)) {
            //     this.callbackInterfaces.push(int)
            // } else {
                interfaces.push(int)
            // }
        })

        this.interfaces = interfaces

        // adding context param to ctors
        this.interfaces.forEach(int => {
            int.constructors.forEach(ctor => {
                ctor.parameters = [PluginApiVisitor.contextParam, ...ctor.parameters]
            })
        })
        // adding context param to methods
        this.interfaces.forEach(int => {
            int.methods.forEach(method => {
                method.parameters = [PluginApiVisitor.contextParam, ...method.parameters]
            })
        })

        this.printNative()
        this.printPeer()
        // this.printC()

        const fileNamePrefix = this.libraryName.toLowerCase()

        const managedCodeModuleInfo = {
            name: `${this.libraryName}_NativeModule`,
            path: `./${fileNamePrefix}_Native`,
            serializerPath: `./${fileNamePrefix}_Serializer`,
            finalizablePath: `./${fileNamePrefix}_Finalizable`,
        }

        const nativeModuleTemplate = readLangTemplate(`PluginApiNativeModule_template.ts`, this.library.language)
        const nativeModuleText = nativeModuleTemplate
            .replaceAll('%NATIVE_MODULE_NAME%', this.libraryName)
            .replaceAll('%NATIVE_FUNCTIONS%', this.nativeFunctionsWriter.getOutput().join('\n'))
            .replaceAll('%OUTPUT_FILE%', managedCodeModuleInfo.path.replace('./', ''))
        fs.writeFileSync(path.join(managedOutDir, `${managedCodeModuleInfo.path}.ts`), nativeModuleText, 'utf-8')

        const peerTemplate = readLangTemplate(`PluginApiPeer_template.ts`, this.library.language)
        const peerText = peerTemplate
            .replaceAll('%PEER_CONTENT%', this.peerWriter.getOutput().join('\n'))
            .replaceAll('%SERIALIZER_PATH%', managedCodeModuleInfo.serializerPath)
        fs.writeFileSync(path.join(managedOutDir, `${fileNamePrefix}.ts`), peerText, 'utf-8')

        // this.hWriter.printTo(path.join(outDir, `${fileNamePrefix}.h`))
        // this.cppWriter.printTo(path.join(outDir, `${fileNamePrefix}.cc`))
        // fs.writeFileSync(path.join(outDir, this.implementationStubsFile.name),
        //     this.implementationStubsFile.printToString()
        // )
        // fs.writeFileSync(path.join(outDir, `SerializerBase.h`),
        //     readLangTemplate(`ohos_SerializerBase.h`, Language.CPP)
        //         .replaceAll("%NATIVE_API_HEADER_PATH%", `${fileNamePrefix}.h`)
        // )
        // fs.writeFileSync(path.join(outDir, `DeserializerBase.h`),
        //     readLangTemplate(`ohos_DeserializerBase.h`, Language.CPP)
        //         .replaceAll("%NATIVE_API_HEADER_PATH%", `${fileNamePrefix}.h`)
        // )

        // const serializerText = makeSerializerForOhos(this.library, managedCodeModuleInfo, fileNamePrefix).printToString()
        // fs.writeFileSync(path.join(managedOutDir, `${fileNamePrefix}_Serializer.ts`), serializerText, 'utf-8')
        // fs.writeFileSync(path.join(managedOutDir, `SerializerBase.ts`),
        //     readLangTemplate(`SerializerBase.ts`, this.library.language)
        //         .replaceAll("%NATIVE_MODULE_ACCESSOR%", managedCodeModuleInfo.name)
        //         .replaceAll("%NATIVE_MODULE_PATH%", managedCodeModuleInfo.path)
        // )
        // fs.writeFileSync(path.join(managedOutDir, `DeserializerBase.ts`),
        //     readLangTemplate(`DeserializerBase.ts`, this.library.language)
        //         .replaceAll("%NATIVE_MODULE_ACCESSOR%", managedCodeModuleInfo.name)
        //         .replaceAll("%NATIVE_MODULE_PATH%", managedCodeModuleInfo.path)
        // )
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

// TODO drop this method
function generateCParameters(method: IDLMethod | IDLConstructor, argConvertors: ArgConvertor[], writer: LanguageWriter): string {
    let args = isConstructor(method) ? [] : [`${PrimitiveType.NativePointer} thisPtr`]
    for (let i = 0; i < argConvertors.length; ++i) {
        const typeName = writer.getNodeName(argConvertors[i].nativeType())
        const argName = writer.escapeKeyword(method.parameters[i].name)
        args.push(`const ${typeName}* ${argName}`)
    }
    return args.join(", ")
}

function makePeerCallSignature(library: PeerLibrary, parameters: IDLParameter[], returnType: IDLType, thisArg?: string) {
    // TODO remove duplicated code from NativeModuleVisitor::printPeerMethod (NativeModulePrinter.ts)
    const argConvertors = parameters.map(param => generateArgConvertor(library, param))
    const args: ({name: string, type: IDLType})[] = thisArg ? [{ name: thisArg, type: IDLPointerType }] : []
    let serializerArgCreated = false
    for (let i = 0; i < argConvertors.length; ++i) {
        let it = argConvertors[i]
        if (it.useArray) {
            if (!serializerArgCreated) {
                args.push(
                    { name: 'thisArray', type: createContainerType(/* 'buffer' */ 'sequence', [IDLU8Type]) },
                    { name: 'thisLength', type: IDLI32Type },
                )
                serializerArgCreated = true
            }
        } else {
            args.push({ name: `${it.param}`, type: parameters[i].type! })
        }
    }
    return NamedMethodSignature.make(returnType, args)
}
