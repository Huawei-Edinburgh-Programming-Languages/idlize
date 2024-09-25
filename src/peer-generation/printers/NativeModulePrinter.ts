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

import { generateEventsBridgeSignature } from "./EventsPrinter";
import { nativeModuleDeclaration, nativeModuleEmptyDeclaration } from "../FileGenerators";
import { FunctionCallExpression, LanguageExpression, LanguageWriter, Method, MethodModifier, MethodSignature, NamedMethodSignature, StringExpression, Type, createLanguageWriter } from "../LanguageWriters";
import { PeerClass, PeerClassBase } from "../PeerClass";
import { PeerLibrary } from "../PeerLibrary";
import { PeerMethod } from "../PeerMethod";
import { IdlPeerClass } from "../idl/IdlPeerClass";
import { IdlPeerLibrary } from "../idl/IdlPeerLibrary";
import { IdlPeerMethod } from "../idl/IdlPeerMethod";
import { Language } from "../../util";

interface NativeMethodDescriberBox {
    name:string
    signature: MethodSignature
    excludedLangs: Language[]
}

interface NativeMethodDescriberOptions {
    exclude?: Language[]
}

class NativeMethodDescriber {
    private readonly methods: NativeMethodDescriberBox[] = [];

    method(returnType: Type, name:string, args:Type[], options?:NativeMethodDescriberOptions) {
        this.methods.push({
            name,
            signature: new MethodSignature(returnType, args),
            excludedLangs: options?.exclude ?? []
        })
    }

    getMethods() {
        return this.methods;
    }
}

class NativeCommonDescriber {
    private readonly groups = new Map<string, NativeMethodDescriber>();

    private constructor() {}

    static make() {
        return new NativeCommonDescriber()
    }

    addGroup(name:string, f:(x:NativeMethodDescriber) => void) {
        const describer = new NativeMethodDescriber()
        f(describer)
        this.groups.set(name, describer)
        return this
    }

    getGroups(): [string, NativeMethodDescriberBox[]][] {
        return Array.from(this.groups.entries()).map(([key, desc]) => [key, desc.getMethods()])
    }

    getGroupNames(): string[] {
        return Array.from(this.groups.keys())
    }

    getAllFlatten(): NativeMethodDescriberBox[] {
        return Array.from(this.groups.values()).flatMap(e => e.getMethods())
    }
}

const t = {
    Int: new Type("KInt"),
    UInt: new Type("KUInt"),
    Long: new Type("KLong"),
    Float: new Type("KFloat"),
    Number: Type.Number,
    Pointer: Type.Pointer,
    This: Type.This,
    Void: Type.Void,
    Boolean: new Type("KBoolean"),
    String: new Type("string"),
    StringPtr: new Type("KStringPtr"),
    Uint8ArrayPtr: new Type("KUint8ArrayPtr"),
    Int32Array: new Type("KInt32ArrayPtr"),
    Float32ArrayPtr: new Type("KFloat32ArrayPtr"),
    NodePointer: new Type("NodePointer"),
    PipelineContext: new Type("PipelineContext")
}

const common = NativeCommonDescriber.make()

common.addGroup("InteropOps", w => {
    w.method(t.Void, "_StartNativeTest", [t.StringPtr, t.Int])
    w.method(t.Void, "_StopNativeTest", [t.Int])
    w.method(t.Pointer, "_GetGroupedLog", [t.Int])
    w.method(t.Void, "_StartGroupedLog", [t.Int])
    w.method(t.Void, "_StopGroupedLog", [t.Int])
    w.method(t.Pointer, "_GetStringFinalizer", [])
    w.method(t.Void, "_InvokeFinalizer", [t.Pointer, t.Pointer])
    w.method(t.Pointer, "_GetPtrVectorElement", [t.Pointer, t.Int])
    w.method(t.Pointer, "_GetNodeFinalizer", [])
    w.method(t.Int, "_StringLength", [t.Pointer])
    w.method(t.Void, "_StringData", [t.Pointer, t.Uint8ArrayPtr, t.Int], { exclude: [ Language.CJ ] })
    w.method(t.Pointer, "_StringMake", [t.StringPtr])
    w.method(t.Int, "_GetPtrVectorSize", [t.Pointer])
    w.method(t.Int, "_ManagedStringWrite", [t.StringPtr, t.Uint8ArrayPtr, t.Int])
    w.method(t.Void, "_Test_SetEventsApi", [])
    w.method(t.Void, "_Test_Common_OnChildTouchTest", [t.Uint8ArrayPtr, t.Int])
    w.method(t.Void, "_Test_List_OnScrollVisibleContentChange", [t.Uint8ArrayPtr, t.Int])
    w.method(t.Void, "_Test_TextPicker_OnAccept", [t.Uint8ArrayPtr, t.Int])
    w.method(t.Int, "_TestPerfNumber", [t.Int])
    w.method(t.Void, "_TestPerfNumberWithArray", [t.Uint8ArrayPtr, t.Int])
    w.method(t.Void, "_StartPerf", [t.StringPtr])
    w.method(t.Void, "_EndPerf", [t.StringPtr])
    w.method(t.Pointer, "_DumpPerf", [t.Int])
})

common.addGroup("GraphicsOps", _ => {
    // TODO fill me if needed
})

common.addGroup("LoaderOps", w => {
    w.method(t.Int, "_LoadVirtualMachine", [t.Int, t.String, t.String])
    w.method(t.Int, "_RunApplication", [t.Int, t.Int])
    w.method(t.Int, "_StartApplication", [])
})

common.addGroup("NodeOps", w => {
    w.method(t.NodePointer, "_CreateNode", [t.Int, t.Int, t.Int])
    w.method(t.NodePointer, "_GetNodeByViewStack", [])
    w.method(t.Void, "_DisposeNode", [t.NodePointer])
    w.method(t.Void, "_DumpTreeNode", [t.NodePointer])

    w.method(t.Void, "_SetCreateNodeDelay", [t.Int, t.Long])
    w.method(t.Void, "_SetMeasureNodeDelay", [t.Int, t.Long])
    w.method(t.Void, "_SetLayoutNodeDelay", [t.Int, t.Long])
    w.method(t.Void, "_SetDrawNodeDelay", [t.Int, t.Long])

    w.method(t.Int, "_AddChild", [t.NodePointer, t.NodePointer])
    w.method(t.Void, "_RemoveChild", [t.NodePointer, t.NodePointer])
    w.method(t.Int, "_InsertChildAfter", [t.NodePointer, t.NodePointer, t.NodePointer])
    w.method(t.Int, "_InsertChildBefore", [t.NodePointer, t.NodePointer, t.NodePointer])
    w.method(t.Int, "_InsertChildAt", [t.NodePointer, t.NodePointer, t.Int])
    w.method(t.Void, "_ApplyModifierFinish", [t.NodePointer])
    w.method(t.Void, "_MarkDirty", [t.NodePointer, t.UInt])
    w.method(t.Boolean, "_IsBuilderNode", [t.NodePointer])
    w.method(t.Float, "_ConvertLengthMetricsUnit", [t.Float, t.Int, t.Int])

    w.method(t.Void, "_SetCustomCallback", [t.NodePointer, t.Int])
    w.method(t.Void, "_MeasureLayoutAndDraw", [t.NodePointer])
    w.method(t.Int, "_MeasureNode", [t.NodePointer, t.Float32ArrayPtr])
    w.method(t.Int, "_LayoutNode", [t.NodePointer, t.Float32ArrayPtr])
    w.method(t.Int, "_DrawNode", [t.NodePointer, t.Float32ArrayPtr])

    w.method(t.Void, "_SetMeasureWidth", [t.NodePointer, t.Int])
    w.method(t.Int, "_GetMeasureWidth", [t.NodePointer])
    w.method(t.Void, "_SetMeasureHeight", [t.NodePointer, t.Int])
    w.method(t.Int, "_GetMeasureHeight", [t.NodePointer])
    w.method(t.Void, "_SetX", [t.NodePointer, t.Int])
    w.method(t.Int, "_GetX", [t.NodePointer])
    w.method(t.Void, "_SetY", [t.NodePointer, t.Int])
    w.method(t.Int, "_GetY", [t.NodePointer])
    
    w.method(t.Void, "_SetAlignment", [t.NodePointer, t.Int])
    w.method(t.Int, "_GetAlignment", [t.NodePointer])

    w.method(t.Int, "_IndexerChecker", [t.NodePointer])
    
    w.method(t.Void, "_SetRangeUpdater", [t.NodePointer, t.Int])
    w.method(t.Void, "_SetLazyItemIndexer", [t.NodePointer, t.Int])

    w.method(t.PipelineContext, "_GetPipelineContext", [t.NodePointer])

    w.method(t.Void, "_SetVsyncCallback", [t.PipelineContext, t.Int])
    w.method(t.Void, "_UnblockVsyncWait", [t.PipelineContext])

    w.method(t.Void, "_SetChildTotalCount", [t.NodePointer, t.Int])
    w.method(t.Void, "_ShowCrash", [t.StringPtr])
})

common.addGroup("TestOps", w => {
    w.method(t.Int, "_TestCallIntNoArgs", [t.Int])
    w.method(t.Int, "_TestCallIntIntArraySum", [t.Int, t.Int32Array, t.Int])
    w.method(t.Void, "_TestCallVoidIntArrayPrefixSum", [t.Int, t.Int32Array, t.Int])
    w.method(t.Int, "_TestCallIntRecursiveCallback", [t.Int, t.Uint8ArrayPtr, t.Int])
    w.method(t.Int, "_TestCallIntMemory", [t.Int, t.Int])
})

class NativeModuleVisitor {
    readonly nativeModule: LanguageWriter
    readonly nativeModuleEmpty: LanguageWriter
    readonly nativeModuleCommon: Map<string, LanguageWriter>
    nativeFunctions?: LanguageWriter

    constructor(
        protected readonly library: PeerLibrary | IdlPeerLibrary,
    ) {
        this.nativeModule = createLanguageWriter(library.language)
        this.nativeModuleEmpty = createLanguageWriter(library.language)
        this.nativeModuleCommon = new Map()
        common.getGroupNames().forEach(groupName => {
            this.nativeModuleCommon.set(groupName, createLanguageWriter(library.language))
        }) 
    }

    protected printPeerMethods(peer: PeerClass | IdlPeerClass) {
        peer.methods.forEach(it => this.printPeerMethod(peer, it, this.nativeModule, this.nativeModuleEmpty, undefined, this.nativeFunctions))
    }

    protected printMaterializedMethods(nativeModule: LanguageWriter, nativeModuleEmpty: LanguageWriter) {
        this.library.materializedToGenerate.forEach(clazz => {
            this.printPeerMethod(clazz, clazz.ctor, nativeModule, nativeModuleEmpty, Type.Pointer)
            this.printPeerMethod(clazz, clazz.finalizer, nativeModule, nativeModuleEmpty, Type.Pointer)
            clazz.methods.forEach(method => {
                const returnType = method.tsReturnType()
                this.printPeerMethod(clazz, method, nativeModule, nativeModuleEmpty,
                    returnType?.isPrimitive() ? returnType : Type.Pointer)
            })
        })
    }

    protected printEventMethods(nativeModule: LanguageWriter, nativeModuleEmpty: LanguageWriter) {
        let method = generateEventsBridgeSignature(nativeModule.language)
        method = new Method(`_${method.name}`, method.signature, method.modifiers)
        nativeModule.writeNativeMethodDeclaration(method.name, method.signature)
        nativeModuleEmpty.writeMethodImplementation(method, writer => {
            writer.writePrintLog(method.name)
            writer.writeStatement(writer.makeReturn(new StringExpression(`0`)))
        })
    }

    printPeerMethod(clazz: PeerClassBase, method: PeerMethod | IdlPeerMethod, nativeModule: LanguageWriter, nativeModuleEmpty: LanguageWriter,
        returnType?: Type,
        nativeFunctions?: LanguageWriter
    ) {
        const component = clazz.generatedName(method.isCallSignature)
        clazz.setGenerationContext(`${method.isCallSignature ? "" : method.overloadedName}()`)
        let serializerArgCreated = false
        let args: ({name: string, type: string})[] = []
        for (let i = 0; i < method.argConvertors.length; ++i) {
            let it = method.argConvertors[i]
            if (it.useArray) {
                if (!serializerArgCreated) {
                    const array = `thisSerializer`
                    args.push({ name: `thisArray`, type: 'Uint8Array' }, { name: `thisLength`, type: 'int32' })
                    serializerArgCreated = true
                }
            } else {
                // TODO: use language as argument of interop type.
                args.push({ name: `${it.param}`, type: it.interopType(nativeModule.language) })
            }
        }
        let maybeReceiver = method.hasReceiver() ? [{ name: 'ptr', type: 'KPointer' }] : []
        const parameters = NamedMethodSignature.make(returnType?.name ?? 'void', maybeReceiver.concat(args))
        let name = `_${component}_${method.overloadedName}`

        nativeModule.writeNativeMethodDeclaration(name, parameters)
        
        nativeModuleEmpty.writeMethodImplementation(new Method(name, parameters), (printer) => {
            printer.writePrintLog(name)
            if (returnType !== undefined && returnType.name !== Type.Void.name) {
                printer.writeStatement(printer.makeReturn(printer.makeString(getReturnValue(returnType))))
            }
        })
        clazz.setGenerationContext(undefined)
    }

    printCommonNativeFunction(method:Method, empty:LanguageWriter, signature:LanguageWriter) {
        signature.writeNativeMethodDeclaration(method.name, method.signature)
        empty.writeMethodImplementation(method, printer => {
            printer.writePrintLog(method.name)
            if (method.signature.returnType !== undefined && method.signature.returnType.name !== Type.Void.name) {
                printer.writeStatement(printer.makeReturn(printer.makeString(getReturnValue(method.signature.returnType))))
            }
        })
    }

    printCommonNativeFunctions() {
        this.nativeModuleEmpty.pushIndent()
        const groups = common.getGroups()
        for (const [ groupName, groupMethods ] of groups) {
            const printer = this.nativeModuleCommon.get(groupName)!
            printer.pushIndent()
            for (const method of groupMethods) {
                if (method.excludedLangs.includes(this.library.language)) {
                    continue
                }
                this.printCommonNativeFunction(
                    new Method(method.name, method.signature), 
                    this.nativeModuleEmpty, 
                    printer
                )
            }
            printer.popIndent()
        }
        this.nativeModuleEmpty.popIndent()
    }

    print(): void {
        console.log(`Materialized classes: ${this.library.materializedClasses.size}`)
        this.printCommonNativeFunctions()
        this.nativeModule.pushIndent()
        this.nativeModuleEmpty.pushIndent()
        for (const file of this.library.files) {
            for (const peer of file.peersToGenerate.values()) {
                this.printPeerMethods(peer)
            }
        }
        this.printMaterializedMethods(this.nativeModule, this.nativeModuleEmpty)
        if(!(this.nativeModule.language == Language.CJ)) this.printEventMethods(this.nativeModule, this.nativeModuleEmpty)
        this.nativeModule.popIndent()
        this.nativeModuleEmpty.popIndent()
    }
}

class CJNativeModuleVisitor extends NativeModuleVisitor {
    private arrayLikeTypes = new Set(['Uint8Array', 'KUint8ArrayPtr', 'KInt32ArrayPtr', 'KFloat32ArrayPtr'])
    private stringLikeTypes = new Set(['string', 'String', 'KStringPtr'])

    constructor(
        protected readonly library: PeerLibrary | IdlPeerLibrary,
    ) {
        super(library)
        this.nativeFunctions = createLanguageWriter(library.language)
    }

    override printCommonNativeFunction(originalMethod:Method, empty:LanguageWriter, signature:LanguageWriter) {
        
        const method = new Method(
            originalMethod.name, originalMethod.signature, 
            originalMethod.modifiers ?? [MethodModifier.PUBLIC, MethodModifier.STATIC], 
            originalMethod.generics
        )
        
        const nativeName = method.name.substring(1)

        this.nativeFunctions!.pushIndent()
        this.nativeFunctions!.writeNativeMethodDeclaration(nativeName, method.signature)
        this.nativeFunctions!.popIndent()

        signature.writeMethodImplementation(method, printer => {
            const functionCallArgs: Array<string> = []
            const freeResourcesLines: Array<string> = []
            printer.print('unsafe {')
            printer.pushIndent()
            method.signature.args.forEach((param, ordinal) => {
                const name = `arg${ordinal}`
                if (this.arrayLikeTypes.has(param.name)) {
                    const varName = `handle_${name}`
                    functionCallArgs.push(`${varName}.pointer`)
                    printer.print(`let ${varName} = acquireArrayRawData(${name}.toArray())`)
                    freeResourcesLines.push(`releaseArrayRawData(${varName})`)
                } else if (this.stringLikeTypes.has(param.name)) {
                    const varName = `cstring_${name}`
                    printer.print(`let ${varName} = LibC.mallocCString(${name})`)
                    functionCallArgs.push(`cstring_${name}`)
                    freeResourcesLines.push(`LibC.free(${varName})`)
                } else {
                    functionCallArgs.push(name)
                }
            })

            let shouldReturn = false
            const callText = `${new FunctionCallExpression(nativeName, functionCallArgs.map(it => printer.makeString(it))).asString()}`
            if (freeResourcesLines.length > 0 && method.signature.returnType.name !== t.Void.name) {
                printer.print(`let result = ${callText}`)
                shouldReturn = true
            } else {
                printer.print(callText)
            }
            for (const line of freeResourcesLines) {
                printer.print(line)
            }
            if (shouldReturn) {
                printer.writeStatement(
                    printer.makeReturn(printer.makeString("result"))
                )
            }
            printer.popIndent()
            printer.print('}')
        })
        empty.writeMethodImplementation(method, printer => {
            printer.writePrintLog(method.name)
            if (method.signature.returnType !== undefined && method.signature.returnType.name !== Type.Void.name) {
                printer.writeStatement(
                    printer.makeReturn(printer.makeString(getReturnValue(method.signature.returnType)))
                )
            }
        })
    }

    override printPeerMethod(clazz: PeerClassBase, method: PeerMethod | IdlPeerMethod, nativeModule: LanguageWriter, nativeModuleEmpty: LanguageWriter,
        returnType?: Type,
        nativeFunctions?: LanguageWriter
    ) {
        const component = clazz.generatedName(method.isCallSignature)
        clazz.setGenerationContext(`${method.isCallSignature ? "" : method.overloadedName}()`)
        let serializerArgCreated = false
        let args: ({name: string, type: string})[] = []
        for (let i = 0; i < method.argConvertors.length; ++i) {
            let it = method.argConvertors[i]
            if (it.useArray) {
                if (!serializerArgCreated) {
                    const array = `thisSerializer`
                    args.push({ name: `thisArray`, type: 'Uint8Array' }, { name: `thisLength`, type: 'int32' })
                    serializerArgCreated = true
                }
            } else {
                // TODO: use language as argument of interop type.
                args.push({ name: `${it.param}`, type: it.interopType(nativeModule.language) })
            }
        }
        let maybeReceiver = method.hasReceiver() ? [{ name: 'ptr', type: 'KPointer' }] : []
        const parameters = NamedMethodSignature.make(returnType?.name ?? 'void', maybeReceiver.concat(args))
        let name = `_${component}_${method.overloadedName}`
        let nativeName = name.substring(1)
        nativeModule.writeMethodImplementation(new Method(name, parameters, [MethodModifier.PUBLIC, MethodModifier.STATIC]), (printer) => {
            let functionCallArgs: Array<string> = []
            printer.print('unsafe {')
            printer.pushIndent()
            for(let param of parameters.args) {
                let ordinal = parameters.args.indexOf(param)
                if (this.arrayLikeTypes.has(param.name)) {
                    functionCallArgs.push(`handle_${ordinal}.pointer`)
                    printer.print(`let handle_${ordinal} = acquireArrayRawData(${parameters.argsNames[ordinal]}.toArray())`)
                } else if (this.stringLikeTypes.has(param.name)) {
                    printer.print(`let ${parameters.argsNames[ordinal]} =  LibC.mallocCString(${parameters.argsNames[ordinal]})`)
                    functionCallArgs.push(parameters.argsNames[ordinal])
                } else {
                    functionCallArgs.push(parameters.argsNames[ordinal])
                }
            }
            printer.print(`${new FunctionCallExpression(nativeName, functionCallArgs.map(it => printer.makeString(it))).asString()}`)
            for(let param of parameters.args) {
                let ordinal = parameters.args.indexOf(param)
                if (this.arrayLikeTypes.has(param.name)) {
                    printer.print(`releaseArrayRawData(handle_${ordinal})`)
                } else if (this.stringLikeTypes.has(param.name)) {
                    printer.print(`LibC.free(${parameters.argsNames[ordinal]})`)
                }
            }
            printer.popIndent()
            printer.print('}')
        })
        nativeFunctions!.pushIndent()
        nativeFunctions!.writeNativeMethodDeclaration(nativeName, parameters)
        nativeFunctions!.popIndent()

        nativeModuleEmpty.writeMethodImplementation(new Method(name, parameters), (printer) => {
            printer.writePrintLog(name)
            if (returnType !== undefined && returnType.name !== Type.Void.name) {
                printer.writeStatement(printer.makeReturn(printer.makeString(getReturnValue(returnType))))
            }
        })
        clazz.setGenerationContext(undefined)
    }
}


export function printNativeModule(peerLibrary: PeerLibrary | IdlPeerLibrary, nativeBridgePath: string): string {
    const lang = peerLibrary.language
    const visitor = (lang == Language.CJ) ? new CJNativeModuleVisitor(peerLibrary) : new NativeModuleVisitor(peerLibrary)
    visitor.print()
    return nativeModuleDeclaration(visitor.nativeModule, visitor.nativeModuleCommon, nativeBridgePath, false, lang, visitor.nativeFunctions)
}

export function printNativeModuleEmpty(peerLibrary: PeerLibrary | IdlPeerLibrary): string {
    const visitor = new NativeModuleVisitor(peerLibrary)
    visitor.print()
    return nativeModuleEmptyDeclaration(visitor.nativeModuleEmpty.getOutput())
}

function getReturnValue(type: Type): string {
    switch(type.name) {
        case Type.Boolean.name : return "false"
        case Type.Number.name: return "1"
        case Type.Pointer.name: return "-1"
        case "string": return `"some string"`

        case t.Boolean.name: return "false"
        case t.Float.name: return "0"
        case t.NodePointer.name: return "-1"
        case t.PipelineContext.name: return "-1"
        case t.Int.name: return "0"
    }
    throw new Error(`Unknown return type: ${type.name}`)
}
