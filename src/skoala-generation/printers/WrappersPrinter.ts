import * as path from "path"
import { createLanguageWriter, FieldModifier, LanguageExpression, LanguageWriter, Method, MethodModifier, MethodSignature, NamedMethodSignature, Type } from "../../peer-generation/LanguageWriters"
import { TargetFile } from "../../peer-generation/printers/TargetFile"
import { capitalize, Language, snakeCaseToCamelCase } from "../../util"
import { SkoalaFile, SkoalaLibrary } from "../SkoalaLibrary"
import { WrapperClass, WrapperField, WrapperMethod } from "../WrapperClass"


export class TSWrappersVisitor {
    constructor() { }

    printWrappers(file: SkoalaFile, writer: LanguageWriter): void {
        if (!file.wrapperClasses.size) return
        for (let [name, clazz] of file.wrapperClasses) {
            this.printWrapper(clazz, writer)
        }
    }

    private printWrapper(clazz: WrapperClass, printer: LanguageWriter) {
        printer.writeClass(clazz.className, (writer) => {
            this.printCtor(clazz, writer)
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
        // 2. TODO: handle clazz.finalizer instead

        if (clazz.superClass.toString() == "Finalizable") {
            writer.print(`constructor(ptr: KNativePointer) { super(ptr, ${clazz.className}.getFinalizer()) } \n`)

            const finalizer = new Method("getFinalizer", new MethodSignature(Type.Pointer, []), [MethodModifier.STATIC])
            writer.writeMethodImplementation(finalizer, writer => {
                writer.writeStatement(
                    writer.makeReturn(
                        writer.makeNativeCall(`_skoala_${clazz.className}_getFinalizer`, [])))
            })
        } else {
            writer.print('constructor(ptr: KNativePointer, allowClose = true) { super(ptr, allowClose) } \n')
        }
    }

    private printMethod(className: string, method: WrapperMethod, writer: LanguageWriter) {
        if (method.toStringName == "ctor" || method.toStringName == "getFinalizer") return

        if (method.toStringName.startsWith('make')) {
            writer.print(
                `public static ${method.toStringName}(): ${method.retType} {
    const ptr = Module._skoala_${className}__${method.toStringName}()
    if (isNullPtr(ptr)) throw new TypeError("can not create an instance of type ${className}")
    return new ${className}(ptr)
}`
            )
            return
        }

        writer.writeMethodImplementation(method.method, writer => {
            let params: LanguageExpression[] = []
            let returnType = method.method.signature.returnType
            let call = writer.makeNativeCall(`_skoala_${method.originalParentName}_${method.toStringName}`, params)
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