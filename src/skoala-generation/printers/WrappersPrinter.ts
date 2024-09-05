import * as path from "path"
import { createLanguageWriter, FieldModifier, LanguageExpression, LanguageWriter, Method, MethodModifier, MethodSignature, NamedMethodSignature, Type } from "../../peer-generation/LanguageWriters"
import { TargetFile } from "../../peer-generation/printers/TargetFile"
import { capitalize, Language, snakeCaseToCamelCase } from "../../util"
import { SkoalaFile, SkoalaLibrary } from "../SkoalaLibrary"
import { WrapperClass, WrapperField, WrapperMethod } from "../WrapperClass"
import { Skoala } from "../utils"


export class TSWrappersVisitor {
    constructor() { }

    printImports(file: SkoalaFile, writer: LanguageWriter): void {
        if (file.wrapperClasses.size) {
            writer.print(Skoala.NativeModuleImport)
            file.wrapperClasses.forEach(it => {
                it.importFeatures.forEach(feature => {
                    writer.print(`import { ${feature.feature} } from "${feature.module}"`)
                })
            })
        }
    }

    printWrappers(file: SkoalaFile, writer: LanguageWriter): void {
        if (!file.wrapperClasses.size) return
        for (let [name, clazz] of file.wrapperClasses) {
            this.printWrapper(clazz, writer)
        }
    }

    private printWrapper(clazz: WrapperClass, printer: LanguageWriter) {
        printer.writeClass(clazz.className, (writer) => {
            this.printCtor(clazz, writer)
            this.printFinalizer(clazz, writer)
            clazz.methods.forEach(method => {
                this.printMethod(clazz.className, method, writer)
            })
            clazz.fields.forEach(field => {
                this.printField(clazz.className, field, writer)
            })
        }, clazz.superClass.toString())
    }

    private printCtor(clazz: WrapperClass, writer: LanguageWriter) {
        // 1. TODO: handle clazz.ctor instead

        if (!clazz.ctor) return
        let argsNames = (clazz.ctor?.method.signature as NamedMethodSignature).argsNames
        writer.writeConstructorImplementation(clazz.className, clazz.ctor.method.signature, writer => {
            if (clazz.superClass.toString() == Skoala.Finalizable) {
                writer.writeSuperCall(["ptr", `${clazz.className}.getFinalizer()`])
            } else if (clazz.superClass.toString() == Skoala.RefCounted) {
                writer.writeSuperCall(argsNames)
            } else {
                writer.writeSuperCall(argsNames)
            }
        })
    }

    private printFinalizer(clazz: WrapperClass, writer: LanguageWriter) {
        if (!clazz.finalizer) return
        writer.writeMethodImplementation(clazz.finalizer.method, writer => {
            writer.writeStatement(
                writer.makeReturn(
                    writer.makeNativeCall(Skoala.nativeMethod(clazz.className, clazz.finalizer!.toStringName), [])))
        })
    }

    private printMethod(className: string, method: WrapperMethod, writer: LanguageWriter) {
        let returnType = method.method.signature.returnType
        let params: LanguageExpression[] = []
        let call = writer.makeNativeCall(Skoala.nativeMethod(method.originalParentName, method.toStringName), params)
        if (method.toStringName.startsWith('make') && returnType.name == className) {
            writer.writeMethodImplementation(method.method, writer => {
                writer.writeStatement(writer.makeAssign("ptr", undefined, call, true))
                writer.print(`if (isNullPtr(ptr)) throw new TypeError("can not create an instance of type ${className}")`)
                writer.writeStatement(writer.makeReturn(writer.makeString(`new ${className}(ptr)`)))
            })
            return
        }

        writer.writeMethodImplementation(method.method, writer => {
            if (returnType != Type.Void) {
                writer.writeStatement(writer.makeAssign("retval", undefined, call, true))
                writer.writeStatement(writer.makeReturn(writer.makeString("retval")))
            } else {
                writer.writeStatement(writer.makeStatement(call))
            }
        })
    }

    private printField(className: string, field: WrapperField, writer: LanguageWriter) {
        const getSignature = new MethodSignature(field.field.type, [])
        writer.writeGetterImplementation(new Method(field.field.name, getSignature), writer => {
            writer.writeStatement(
                writer.makeReturn(
                    writer.makeMethodCall("this", `get${capitalize(field.field.name)}`, [])))
        })

        const isReadOnly = field.field.modifiers.includes(FieldModifier.READONLY)
        if (!isReadOnly) {
            const setSignature = new NamedMethodSignature(Type.Void, [field.field.type], [field.field.name])
            writer.writeSetterImplementation(new Method(field.field.name, setSignature), writer => {
                writer.writeMethodCall("this", `set${capitalize(field.field.name)}`, [field.field.name])
            });
        }
    }
}
