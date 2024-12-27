import { IndentedPrinter } from "../IndentedPrinter"
import { PeerLibrary } from "../peer-generation/PeerLibrary"
import { IDLEntry, IDLInterface, isInterface } from "../idl"

export class LibPrinter {
    constructor(
        private library: PeerLibrary
    ) { }

    private printer = new IndentedPrinter()

    print(): string {
        this.library.files
            .flatMap(it => it.entries)
            .forEach(it => this.visit(it))
        return this.printer.getOutput().join('\n')
    }

    private visit(node: IDLEntry): void {
        console.log(node.name)
        if (isInterface(node)) return this.visitInterface(node)
    }

    private visitInterface(node: IDLInterface): void {

    }
}