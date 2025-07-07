import { Language, LanguageWriter, LibraryInterface, Method, MethodModifier, PeerMethod } from "@idlizer/core"
import { OvPr } from "@idlizer/libohos"
import * as idl from "@idlizer/core/idl"
import { componentToPeerClass } from "./PeerPrinter"
import { generateComponentName } from "./ComponentsPrinter"

function isMakeMethod(library: LibraryInterface, peerMethod: PeerMethod, isStatic?: boolean): boolean {
    let res = false
    if (!isStatic) return res

    const retType = peerMethod.returnType
    if (idl.isNamedNode(retType)) {
        res ||= retType.name == peerMethod.originalParentName

        if (idl.isReferenceType(retType)) {
            let decl = library.resolveTypeReference(retType)
            if (decl && idl.isInterface(decl)) {
                decl.inheritance.forEach(it => {
                    res ||= it.name == retType.name
                })
            }
        }
    }
    return res
}

export class OverloadsPrinter extends OvPr {
    constructor(library: LibraryInterface, printer: LanguageWriter, private isComponent: boolean) {
        super(library, printer)
    }

    override printPeerCallAndReturn(peer: string, collapsedMethod: Method, peerMethod: PeerMethod) {
        const argsNames = this.printCastedArguments(collapsedMethod, peerMethod)
        const isStatic = collapsedMethod.modifiers?.includes(MethodModifier.STATIC)
        this.printReturn(collapsedMethod, peerMethod, argsNames, isStatic ? componentToPeerClass(peer) : this.isComponent ? `this.getPeer()` : `this`)
    }

    override printReturn(collapsedMethod: Method, peerMethod: PeerMethod, argsNames: string[], receiver: string) {
        const isStatic = collapsedMethod.modifiers?.includes(MethodModifier.STATIC)
        const isMake = isMakeMethod(this.library, peerMethod, isStatic)
        const methodName = `${peerMethod.sig.name}`
        const returnType = collapsedMethod.signature.returnType

        if (this.isComponent && isMake) {
            const returnValue = `${methodName}_result`
            this.printer.writeStatement(
                this.printer.makeAssign(returnValue, undefined, this.printer.makeMethodCall(
                    receiver,
                    methodName,
                    argsNames.map(it => this.printer.makeString(it))
                ), true)
            )
            const comp = generateComponentName(idl.isNamedNode(returnType) ? returnType.name : peerMethod.originalParentName)
            this.printer.writeStatement(this.printer.makeReturn(this.printer.makeString(`new ${comp}(${returnValue})`)))
            return
        } 

        return super.printReturn(collapsedMethod, peerMethod, argsNames, receiver)
    }
}
