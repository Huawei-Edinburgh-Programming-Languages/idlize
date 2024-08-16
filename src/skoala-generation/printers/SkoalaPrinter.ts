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

import { Language, renameClassToMaterialized, capitalize, removeExt } from "../../util";

import {
    LanguageWriter,
    MethodModifier,
    NamedMethodSignature,
    Method,
    Type,
    createLanguageWriter,
    FieldModifier,
    MethodSignature,
    copyMethod,
    BlockStatement, LanguageStatement
} from "../../peer-generation/LanguageWriters";
import { copyMaterializedMethod, MaterializedClass, MaterializedMethod } from "../../peer-generation/Materialized"
import { makeMaterializedPrologue, tsCopyrightAndWarning } from "../../peer-generation/FileGenerators";


import { writePeerMethod } from "../../peer-generation/printers/PeersPrinter"
import { ImportsCollector } from "../../peer-generation/ImportsCollector";

import { createInterfaceDeclName } from "../../peer-generation/PeerGeneratorVisitor";
import { SkoalaDeclLibrary } from "../SkoalaGeneratorVisitor";
import { TargetFile } from "../../peer-generation/printers/TargetFile";
import { PrinterContext } from "../../peer-generation/printers/PrinterContext";

interface MaterializedFileVisitor {
    visit(): void
    getTargetFile(): TargetFile
    getOutput(): string[]
}

abstract class MaterializedFileVisitorBase implements MaterializedFileVisitor {
    protected readonly printer: LanguageWriter = createLanguageWriter(this.printerContext.language)

    constructor(
        protected readonly library: SkoalaDeclLibrary,
        protected readonly printerContext: PrinterContext,
        protected readonly clazz: MaterializedClass,
    ) {}

    abstract visit(): void
    abstract getTargetFile(): TargetFile

    getOutput(): string[] {
        return this.printer.getOutput()
    }
}

class TSMaterializedFileVisitor extends MaterializedFileVisitorBase {

    constructor(
        protected readonly library: SkoalaDeclLibrary,
        protected readonly printerContext: PrinterContext,
        protected readonly clazz: MaterializedClass,
        protected readonly dumpSerialized: boolean,
    ) {
        super(library, printerContext, clazz)
    }

    private printImports() {
        const imports = new ImportsCollector()
        this.clazz.importFeatures.forEach(it => imports.addFeature(it.feature, it.module))
        const currentModule = removeExt(renameClassToMaterialized(this.clazz.className, this.library.declarationTable.language))
        imports.print(this.printer, currentModule)
    }

    private printMaterializedClass(clazz: MaterializedClass) {
        this.printImports()
        const printer = this.printer
        printer.print(makeMaterializedPrologue(this.printerContext.language))

        const superClass = clazz.superClass
        let superClassName = superClass ? `${superClass.name}${superClass.generics ? `<${superClass.generics.join(", ")}>` : ""}` : undefined
        let selfInterface = clazz.isInterface ? `${clazz.className}${clazz.generics ? `<${clazz.generics.join(", ")}>` : `` }` : undefined

        const interfaces: string[] = []
        if (clazz.isInterface) {
            // self-interface is not supported ArkTS
            if (this.library.declarationTable.language == Language.ARKTS) {
                selfInterface = createInterfaceDeclName(selfInterface!)
            }
            if (selfInterface) interfaces.push(selfInterface)
            if (superClassName && !this.library.materializedClasses.has(superClassName)) {
                interfaces.push(superClassName)
                superClassName = undefined
            }
        }

        printer.writeClass(clazz.className, writer => {

            const finalizableType = new Type("Finalizable")
            writer.writeFieldDeclaration("peer", finalizableType, undefined, true)

            // getters and setters for fields
            clazz.fields.forEach(f => {
                const field = f.field

                // TBD: use deserializer to get complex type from native
                const isSimpleType = !f.argConvertor.useArray // type needs to be deserialized from the native
                if (isSimpleType) {
                    const getSignature = new MethodSignature(field.type, [])
                    writer.writeGetterImplementation(new Method(field.name, getSignature), writer => {
                        writer.writeStatement(
                            writer.makeReturn(
                                writer.makeMethodCall("this", `get${capitalize(field.name)}`, [])))
                    });
                }

                const isReadOnly = field.modifiers.includes(FieldModifier.READONLY)
                if (!isReadOnly) {
                    const setSignature = new NamedMethodSignature(Type.Void, [field.type], [field.name])
                    writer.writeSetterImplementation(new Method(field.name, setSignature), writer => {
                        writer.writeMethodCall("this", `set${capitalize(field.name)}`, [field.name])
                    });
                }
            })

            // write constructor
            const pointerType = Type.Pointer
            this.library.declarationTable.setCurrentContext(`${clazz.className}.constructor`)
            writeSkoalaMethod(writer, clazz.ctor, this.printerContext, this.dumpSerialized, "", "", pointerType)
            this.library.declarationTable.setCurrentContext(undefined)

            const ctorSig = clazz.ctor.method.signature as NamedMethodSignature
            const sigWithPointer = new NamedMethodSignature(
                ctorSig.returnType,
                ctorSig.args.map(it => new Type(it.name, true)),
                ctorSig.argsNames,
                ctorSig.defaults)

            // write constructor implementation
            writer.writeConstructorImplementation(clazz.className, sigWithPointer, writer => {
                if (superClassName) {
                    writer.writeSuperCall(["ptr", `${clazz.className}.getFinalizer()`]);
                }

                const allOptional = ctorSig.args.every(it => it.nullable)
                const hasStaticMethods = clazz.methods.some(it => it.method.modifiers?.includes(MethodModifier.STATIC))
                if (hasStaticMethods && allOptional) {
                    if (ctorSig.args.length == 0) {
                        writer.print(`// Constructor does not have parameters.`)
                    } else {
                        writer.print(`// All constructor parameters are optional.`)
                    }
                    writer.print(`// It means that the static method call invokes ctor method as well`)
                    writer.print(`// when all arguments are undefined.`)
                }
                let ctorStatements: LanguageStatement = new BlockStatement([
                    writer.makeAssign("ctorPtr", Type.Pointer,
                        writer.makeMethodCall(clazz.className, "ctor",
                            ctorSig.args.map((it, index) => writer.makeString(`${ctorSig.argsNames[index]}`))),
                        true),
                    writer.makeAssign(
                        "this.peer",
                        finalizableType,
                        writer.makeString(`new Finalizable(ctorPtr, ${clazz.className}.getFinalizer())`),
                        false
                    )
                ], false)
                if (!allOptional) {
                    ctorStatements =
                        writer.makeCondition(
                            ctorSig.args.length === 0 ? writer.makeString("true") :
                                writer.makeNaryOp('&&', ctorSig.argsNames.map(it =>
                                    writer.makeNaryOp('!==', [writer.makeString(it), writer.makeUndefined()]))
                                ),
                            ctorStatements
                        )
                }
                writer.writeStatement(ctorStatements)
            })

            // write finalizer
            printSkoalaFinalizer(clazz, writer)

            // write methods
            clazz.methods.forEach(method => {
                let privateMethod = method
                if (!privateMethod.method.modifiers?.includes(MethodModifier.PRIVATE))
                    privateMethod = copyMaterializedMethod(method, {
                        method: copyMethod(method.method, {
                            modifiers: (method.method.modifiers ?? []).concat([MethodModifier.PRIVATE])
                        })
                    })
                const returnType = privateMethod.tsReturnType()
                this.library.declarationTable.setCurrentContext(`${privateMethod.originalParentName}.${privateMethod.overloadedName}`)
                writeSkoalaMethod(writer, privateMethod, this.printerContext, this.dumpSerialized, "_serialize", "this.peer!.ptr", returnType)
                this.library.declarationTable.setCurrentContext(undefined)
            })
        }, superClassName, interfaces.length === 0 ? undefined : interfaces, clazz.generics)
    }

    visit(): void {
        this.printMaterializedClass(this.clazz)
    }

    getTargetFile(): TargetFile {
        return new TargetFile(renameClassToMaterialized(this.clazz.className, this.printerContext.language))
    }
}

// TODO: check
function printSkoalaFinalizer(clazz: MaterializedClass, writer: LanguageWriter) {
    const className = clazz.getComponentName()
    const finalizer = new Method(
        "getFinalizer",
        new MethodSignature(Type.Pointer, []),
        // TODO: private static getFinalizer() method conflicts with its implementation in the parent class
        [MethodModifier.STATIC])
    writer.writeMethodImplementation(finalizer, writer => {
        writer.writeStatement(
            writer.makeReturn(
                writer.makeNativeCall(`_skoala_${className}__1nGetFinalizer`, [])))
    })
}

// TODO: rewrite
function writeSkoalaMethod(printer: LanguageWriter, method: MaterializedMethod, printerContext: PrinterContext, dumpSerialized: boolean,
    methodPostfix: string, ptr: string, returnType: Type = Type.Void, generics?: string[]) {
    writePeerMethod(printer, method, printerContext, dumpSerialized, methodPostfix, ptr, returnType, generics)
}

export function printSkoalaClasses(library: SkoalaDeclLibrary, printerContext: PrinterContext, dumpSerialized: boolean): Map<TargetFile, string> {

    // TODO: support other output languages
    if (![Language.ARKTS, Language.TS, Language.JAVA, Language.CJ].includes(printerContext.language))
        return new Map()

    // const visitor = new MaterializedVisitor(peerLibrary, printerContext, dumpSerialized)
    // visitor.printMaterialized()
    let skoalaFiles = new Map<TargetFile, string[]>()
    console.log(`Materialized classes: ${library.materializedClasses.size}`)
    for (const clazz of library.materializedToGenerate) {
        let visitor: MaterializedFileVisitor
        if ([Language.ARKTS, Language.TS].includes(printerContext.language)) {
            visitor = new TSMaterializedFileVisitor(
                library, printerContext, clazz, dumpSerialized)
        } else {
            throw new Error(`Unsupported language ${printerContext.language} in MaterializedPrinter.ts`)
        }

        visitor.visit()
        skoalaFiles.set(visitor.getTargetFile(), visitor.getOutput())
    }

    const result = new Map<TargetFile, string>()
    for (const [file, content] of skoalaFiles) {
        if (content.length === 0) continue
        const text = tsCopyrightAndWarning(content.join('\n'))
        result.set(file, text)
    }
    return result
}