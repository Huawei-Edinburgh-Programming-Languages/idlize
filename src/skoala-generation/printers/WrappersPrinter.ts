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

import { FieldModifier, LanguageExpression, LanguageWriter, Method, MethodModifier, MethodSignature, NamedMethodSignature, Type } from "../../peer-generation/LanguageWriters"
import { capitalize, Language, snakeCaseToCamelCase } from "../../util"
import { SkoalaFile } from "../SkoalaLibrary"
import { WrapperClass, WrapperField, WrapperMethod } from "../WrapperClass"
import { Skoala } from "../utils"


export class TSWrappersVisitor {
    constructor() { }

    printImports(file: SkoalaFile, writer: LanguageWriter): void {
        file.importFeatures.forEach((features, module) => {
            writer.print(`import { ${[...features].join(', ')} } from "${module}"`)
        })
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
        }, clazz.superClassName)
    }

    private printCtor(clazz: WrapperClass, writer: LanguageWriter) {
        if (!clazz.ctor) return
        let argsNames = (clazz.ctor?.method.signature as NamedMethodSignature).argsNames
        writer.writeConstructorImplementation(clazz.className, clazz.ctor.method.signature, writer => {
            if (clazz.superClassName == Skoala.BaseClasses.Finalizable) {
                if (argsNames.length) {
                    argsNames = [argsNames[0], `${clazz.className}.getFinalizer()`, ...argsNames.slice(1)]
                } else {
                    // todo: case not used?
                    argsNames.push(`${clazz.className}.getFinalizer()`)
                }
            }
            writer.writeSuperCall(argsNames)
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
        let params: LanguageExpression[] = []
        if (method.hasReceiver()) {
            params.push(writer.makeString('this.ptr'))
        }
        let serializerPushed = false
        method.argConvertors.forEach(it => {
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

        let call = writer.makeNativeCall(Skoala.nativeMethod(method.originalParentName, method.toStringName), params)
        let returnType = method.method.signature.returnType

        writer.writeMethodImplementation(method.method, writer => {
            let serializerCreated = false
            method.argConvertors.forEach((it, index) => {
                if (it.useArray) {
                    if (!serializerCreated) {
                        writer.writeStatement(
                            writer.makeAssign(`thisSerializer`, new Type('Serializer'),
                                writer.makeMethodCall('SerializerBase', 'get', [
                                    writer.makeSerializerCreator(), writer.makeString(index.toString())
                                ]), true)
                        )
                        serializerCreated = true
                    }
                    it.convertorSerialize(`this`, it.param, writer)
                }
            })

            if (returnType != Type.Void) {
                if (method.isMakeMethod()) {
                    writer.writeStatement(writer.makeAssign("ptr", undefined, call, true))
                    writer.print(`if (isNullPtr(ptr)) throw new TypeError("can not create an instance of type ${className}")`)
                    writer.writeStatement(writer.makeReturn(writer.makeString(`new ${className}(ptr)`)))
                } else {
                    writer.writeStatement(writer.makeAssign("retval", undefined, call, true))
                    writer.writeStatement(writer.makeReturn(writer.makeString("retval")))
                }
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
