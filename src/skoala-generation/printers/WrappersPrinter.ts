import * as path from "path"
import { createLanguageWriter, LanguageWriter, Method, MethodModifier, MethodSignature, Type } from "../../peer-generation/LanguageWriters"
import { TargetFile } from "../../peer-generation/printers/TargetFile"
import { Language, snakeCaseToCamelCase } from "../../util"
import { SkoalaFile, SkoalaLibrary } from "../SkoalaLibrary"
import { WrapperClass } from "../WrapperClass"


class TSWrappersVisitor {
    constructor(
        protected readonly library: SkoalaLibrary,
    ) { }

    protected readonly printer: LanguageWriter = createLanguageWriter(Language.TS)

    getOutput(): string[] {
        return this.printer.getOutput()
    }

    printWrappers(file: SkoalaFile): void {
        this.printer.printer.clearAll()
        if (!file.wrapperClasses.size) return
        for (let [name, clazz] of file.wrapperClasses) {
            this.printWrapper(clazz)
        }
    }

    private printWrapper(clazz: WrapperClass) {
        this.printer.print(`export class ${clazz.className} extends ${clazz.superClass.toString()} { \n`)
        if (clazz.superClass.toString() == "Finalizable") {
            this.printer.print(`constructor(ptr: KNativePointer) { super(ptr, ${clazz.className}.getFinalizer()) } \n`)

            const finalizer = new Method(
                "getFinalizer",
                new MethodSignature(Type.Pointer, []),
                // TODO: private static getFinalizer() method conflicts with its implementation in the parent class
                [MethodModifier.STATIC])
            this.printer.writeMethodImplementation(finalizer, writer => {
                writer.writeStatement(
                    writer.makeReturn(
                        writer.makeNativeCall(`_skoala_${clazz.className}_getFinalizer`, [])))
            })
        } else {
            this.printer.print('constructor(ptr: KNativePointer, allowClose = true) { super(ptr, allowClose) } \n')
        }

        clazz.methods.forEach(method => {
            if (method.implName.startsWith('make')) {
                this.printer.print(
                    `public static ${method.toStringName}(): ${method.retType} {
    const ptr = Module._skoala_${clazz.className}__Make()
    if (isNullPtr(ptr)) throw new TypeError("can not create an instance of type ${clazz.className}")
    return new ${clazz.className}(ptr)
}`
                )
                return
            }

            if (method.toStringName == "ctor" || method.toStringName == "getFinalizer") return

            this.printer.print(
                `public ${method.toStringName}(r?: Rect): ${method.retType} {
        return Module._skoala_${clazz.className}__${method.toStringName}(this.ptr, r)
    }`
            )

        })


        this.printer.print('}')
    }
}

export function getWrapperFileName(className: string) {
    const renamed = snakeCaseToCamelCase(className)
        // .concat("Wrapper")
        .replace(".d.ts", "")
    return renamed.concat(Language.TS.extension)
}

export function printWrappers(library: SkoalaLibrary): Map<TargetFile, string> {
    const visitor = new TSWrappersVisitor(library)
    if (!visitor) {
        return new Map()
    }

    const result = new Map<TargetFile, string>()
    for (let file of library.files) {
        visitor.printWrappers(file)
        let res = visitor.getOutput().join('\n')
        result.set(new TargetFile(getWrapperFileName(file.baseName)), res /** todo */)
    }
    return result
}