import { IndentedPrinter } from "../IndentedPrinter";
import { PrimitiveType } from "./DeclarationTable";
import { completeImplementations, dummyImplementations, makeAPI, makeCDeserializer, modifierStructList, modifierStructs } from "./FileGenerators";
import { PeerClass } from "./PeerClass";
import { PeerLibrary } from "./PeerLibrary";
import { PeerMethod } from "./PeerMethod";

class HeaderVisitor {
    //private structs = new IndentedPrinter()
    //private typedefs = new IndentedPrinter()
    api = new IndentedPrinter()
    apiList = new IndentedPrinter()

    constructor(
        private library: PeerLibrary,
    ) { }

    private apiModifierHeader(clazz: PeerClass) {
        return `typedef struct ArkUI${clazz.componentName}Modifier {`
    }

    printClassProlog(clazz: PeerClass) {
        this.api.print(this.apiModifierHeader(clazz))
        this.api.pushIndent()
        this.apiList.pushIndent()
        this.apiList.print(`const ArkUI${clazz.componentName}Modifier* (*get${clazz.componentName}Modifier)();`)
    }
    /*
    printMethodProlog(printer: IndentedPrinter, method: PeerMethod) {
        const apiParameters = method.generateAPIParameters(method.argConvertors).join(", ")
        const signature = `${method.retType} ${method.implName}(${apiParameters}) {`
        printer.print(signature)
        printer.pushIndent()
    }
    */
    printMethodEpiog(printer: IndentedPrinter) {
        printer.popIndent()
        printer.print(`}`)
    }

    printMethod(method: PeerMethod) {
        const apiParameters = method.generateAPIParameters(method.argConvertors).join(", ")
        this.api.print(`${method.retType} (*${method.fullMethodName})(${apiParameters});`)
    }

    private printClassEpilog(clazz: PeerClass) {
        if (clazz.methods.length == 0) {
            this.api.print("int dummy;")
        }
        this.api.popIndent()
        this.api.print(`} ArkUI${clazz.componentName}Modifier;\n`)
        this.apiList.popIndent()
    }


    // TODO: have a proper Peer module visitor
    printApiAndDeserializer() {
        this.library.files.forEach(file => {
            file.peers.forEach(clazz => {
                this.printClassProlog(clazz)
                clazz.methods.forEach(method => {
                    this.printMethod(method)
                })
                this.printClassEpilog(clazz)

            })
        })
    }
}

export function printApiAndDeserializer(apiVersion: string|undefined, peerLibrary: PeerLibrary): {api: string, deserializer: string} {
    const visitor = new HeaderVisitor(peerLibrary)
    visitor.printApiAndDeserializer()

    const structs = new IndentedPrinter()
    const typedefs = new IndentedPrinter()

    const deserializer = makeCDeserializer(peerLibrary.declarationTable, structs, typedefs)
    const api = makeAPI(apiVersion ?? "0", visitor.api.getOutput(), visitor.apiList.getOutput(), structs, typedefs)

    return {api, deserializer}
}