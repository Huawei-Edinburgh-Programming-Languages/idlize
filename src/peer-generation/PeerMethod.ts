import { IndentedPrinter } from "../IndentedPrinter"
import { capitalize, dropSuffix, isDefined } from "../util"
import { ArgConvertor, RetConvertor } from "./Convertors"
import { PrimitiveType } from "./DeclarationTable"
import { PeerClass } from "./PeerClass"
import { Printers } from "./Printers"

export class PeerMethod {
    public readonly fullMethodName
    constructor(
        public originalParentName: string,
        public methodName: string,
        public argConvertors: ArgConvertor[],
        public retConvertor: RetConvertor,
        public hasReceiver: boolean,
        public isCallSignature: boolean,
        public mappedParams: string | undefined,
        public mappedParamValues: string | undefined,
        public mappedParamsTypes: string[] | undefined,
        private dumpSerialized: boolean
    ) {
        this.fullMethodName = isCallSignature ? methodName : this.peerMethodName()
    }

    peerMethodName() {
        const name = this.methodName
        if (!this.hasReceiver) return name
        if (name.startsWith("set") ||
            name.startsWith("get") ||
            name.startsWith("_set")
        ) return name
        return `set${capitalize(name)}`
    }

    generateCMacroSuffix(): string {
        let counter = this.hasReceiver ? 1 : 0
        this.argConvertors.forEach(it => {
            if (it.useArray) {
                counter += 2
            } else {
                counter += 1
            }
        })
        return `${this.retConvertor.macroSuffixPart()}${counter}`
    }

    printPeerMethod(printer: IndentedPrinter) {
        let maybeStatic = this.hasReceiver ? "" : `static `
        let genMethodName = this.hasReceiver ? `${this.methodName}Attribute` : this.methodName
        printer.print(`${maybeStatic}${genMethodName}(${this.mappedParams}) {`)
        
        printer.pushIndent()
        let scopes = this.argConvertors.filter(it => it.isScoped)
        scopes.forEach(it => {
            printer.pushIndent()
            printer.print(it.scopeStart?.(it.param))
        })
        this.argConvertors.forEach(it => {
            if (it.useArray) {
                let size = it.estimateSize()
                printer.print(`const ${it.param}Serializer = new Serializer(${size})`)
                it.convertorToTSSerial(it.param, it.param, printer)
            }
        })
        // Enable to see serialized data.
        if (this.dumpSerialized) {
            this.argConvertors.forEach((it, index) => {
                if (it.useArray) {
                    printer.print(`console.log("${it.param}:", ${it.param}Serializer.asArray(), ${it.param}Serializer.length())`)
                }
            })
        }
        let maybeThis = this.hasReceiver ? `this.ptr${this.argConvertors.length > 0 ? ", " : ""}` : ``
        printer.print(`nativeModule()._${this.originalParentName}_${this.methodName}(${maybeThis}`)
        printer.pushIndent()
        this.argConvertors.forEach((it, index) => {
            let maybeComma = index == this.argConvertors.length - 1 ? "" : ","
            if (it.useArray)
                printer.print(`${it.param}Serializer.asArray(), ${it.param}Serializer.length()`)
            else
                printer.print(it.convertorTSArg(it.param))
            printer.print(maybeComma)
        })
        printer.popIndent()
        printer.print(`)`)
        scopes.reverse().forEach(it => {
            printer.popIndent()
            printer.print(it.scopeEnd!(it.param))
        })
        printer.popIndent()

        printer.print(`}`)
    }

    printComponentMethod(printer: IndentedPrinter) {
        printer.print(`/** @memo */`)
        printer.print(`${this.methodName}(${this.mappedParams}): this {`)
        printer.pushIndent()
        printer.print(`if (this.checkPriority("${this.methodName}")) {`)
        printer.pushIndent()
        printer.print(`this.peer?.${this.methodName}Attribute(${this.mappedParamValues})`)
        printer.popIndent()
        printer.print(`}`)
        printer.print("return this")
        printer.popIndent()
        printer.print(`}\n`)
    }

    printGlobalMethod(printers: Printers) {
        const methodName = this.methodName
        const retConvertor = this.retConvertor
        const argConvertors = this.argConvertors
        const fullMethodName = this.fullMethodName

        const apiParameters = this.generateAPIParameters(argConvertors).join(", ")
        const implName = `${capitalize(this.originalParentName)}_${capitalize(fullMethodName)}Impl`
        const retType = this.maybeCRetType(retConvertor) ?? "void"

        printers.api.print(`${retType} (*${fullMethodName})(${apiParameters});`)
        printers.modifiers.print(`${implName},`)
        this.printImplFunction(printers, retType, implName, apiParameters, true) // dummy
        this.printImplFunction(printers, retType, implName, apiParameters, false) // real

        let cName = `${this.originalParentName}_${methodName}`
        printers.C.print(`${retConvertor.nativeType()} impl_${cName}(${this.generateCParameters(argConvertors).join(", ")}) {`)
        printers.C.pushIndent()
        this.generateNativeBody(printers, this)
        printers.C.popIndent()
        printers.C.print(`}`)
        let macroArgs = [cName, this.maybeCRetType(retConvertor)].concat(this.generateCParameterTypes(argConvertors, this.hasReceiver))
            .filter(isDefined)
            .join(", ")
        const suffix = this.generateCMacroSuffix()
        printers.C.print(`KOALA_INTEROP_${suffix}(${macroArgs})`)
        printers.C.print(` `)
    }


    printDummyImplFunctionBody(printers: Printers, retType: string, implName: string, apiParameters: string, printer: IndentedPrinter) {
        printer.print(`string out("${this.methodName}(");`)
        this.argConvertors.forEach((argConvertor, index) => {
            if (index > 0) printers.dummyImpl.print(`out.append(", ");`)
            printer.print(`WriteToString(&out, ${argConvertor.param});`)
        })
        printer.print(`out.append(")");`)
        printer.print(`appendGroupedLog(1, out);`)
        if (retType != "void") printer.print(`return 0;`)
    }

    printModifierImplFunctionBody(retType: string, implName: string, apiParameters: string, printer: IndentedPrinter) {
        printer.print(`// ${implName} `)
        if (retType != "void") printer.print(`return 0;`)
    }

    printImplFunction(printers: Printers, retType: string, implName: string, apiParameters: string, dummy: boolean) {
        const printer = dummy ? printers.dummyImpl : printers.modifierImpl

        printer.print(`${retType} ${implName}(${apiParameters}) {`)
        printer.pushIndent()
        if (dummy) {
            this.printDummyImplFunctionBody(printers, retType, implName, apiParameters, printer)
        } else {
            this.printModifierImplFunctionBody(retType, implName, apiParameters, printer)
        }
        printer.popIndent()
        printer.print(`}`)
    }

    generateCParameters(argConvertors: ArgConvertor[]): string[] {
        let maybeReceiver = this.hasReceiver ? [`${PrimitiveType.NativePointer.getText()} nodePtr`] : []
        return (maybeReceiver.concat(argConvertors.map(it => {
            if (it.useArray) {
                return `uint8_t* ${it.param}Array, int32_t ${it.param}Length`
            } else {
                let type = it.interopType(false)
                return `${type == "KStringPtr" ? "const KStringPtr&" : type} ${it.param}`
            }
        })))
    }

    generateCParameterTypes(argConvertors: ArgConvertor[], hasReceiver: boolean): string[] {
        const receiver = hasReceiver ? [PrimitiveType.NativePointer.getText()] : []
        return receiver.concat(argConvertors.map(it => {
            if (it.useArray) {
                return `uint8_t*, int32_t`
            } else {
                return it.interopType(false)
            }
        }))
    }

    maybeCRetType(retConvertor: RetConvertor): string | undefined {
        if (retConvertor.isVoid) return undefined
        return retConvertor.nativeType()
    }

    modifierSection(clazzName: string) {
        // TODO: may be need some translation tables?
        let clazz = dropSuffix(dropSuffix(dropSuffix(clazzName, "Method"), "Attribute"), "Interface")
        return `get${capitalize(clazz)}Modifier()`
    }

    generateAPIParameters(argConvertors: ArgConvertor[]): string[] {
        let maybeReceiver = this.hasReceiver ? [`${PrimitiveType.NativePointer.getText()} node`] : []
        return (maybeReceiver.concat(argConvertors.map(it => {
            let isPointer = it.isPointerType()
            return `${isPointer ? "const ": ""}${it.nativeType(false)}${isPointer ? "*": ""} ${it.param}`
        })))
    }

    // TODO: may be this is another method of ArgConvertor?
    apiArgument(argConvertor: ArgConvertor): string {
        const prefix = argConvertor.isPointerType() ? "&": "    "
        if (argConvertor.useArray) return `${prefix}${argConvertor.param}_value`
        return `${argConvertor.convertorCArg(argConvertor.param)}`
    }

    generateAPICall(printers: Printers, peerMethod: PeerMethod) {
        const clazzName = peerMethod.originalParentName
        const hasReceiver = peerMethod.hasReceiver
        const argConvertors = peerMethod.argConvertors
        const isVoid = peerMethod.retConvertor.isVoid
        const api = "GetNodeModifiers()"
        const modifier = this.modifierSection(clazzName)
        const method = peerMethod.peerMethodName()
        const receiver = hasReceiver ? ['node'] : []
        // TODO: how do we know the real amount of arguments of the API functions?
        // Do they always match in TS and in C one to one?
        const args = receiver.concat(argConvertors.map(it => this.apiArgument(it))).join(", ")
        printers.C.print(`${isVoid ? "" : "return "}${api}->${modifier}->${method}(${args});`)
    }

    generateNativeBody(printers: Printers, peerMethod: PeerMethod) {
        printers.C.pushIndent()
        if (peerMethod.hasReceiver) {
            printers.C.print("ArkUINodeHandle node = reinterpret_cast<ArkUINodeHandle>(nodePtr);")
        }
        peerMethod.argConvertors.forEach(it => {
            if (it.useArray) {
                printers.C.print(`Deserializer ${it.param}Deserializer(${it.param}Array, ${it.param}Length);`)
                let result = `${it.param}_value`
                printers.C.print(`${it.nativeType(false)} ${result};`)
                it.convertorToCDeserial(it.param, result, printers.C)
            }
        })
        this.generateAPICall(printers, peerMethod)
        printers.C.popIndent()
    }
}
