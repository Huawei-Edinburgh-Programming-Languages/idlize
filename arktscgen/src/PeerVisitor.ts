import * as core from "@idlizer/core"
import { Declarations, Visitor } from "./Visitor"
import { PeerGenerator, Body } from "./PeerGenerator";
import { Config } from "./general/Config"

export class PeerVisitor extends Visitor {
    constructor(
        private config: Config,
        private idl: core.IDLFile,
        decls?: Declarations
    ) {
        super(decls)
    }

    override onEnterNamespace(node: core.IDLNamespace): boolean {
        console.log(`namespace: ${node.name}`);
        return ['', 'ir'].includes(node.name)
    }

    override onEnterInterface(node: core.IDLInterface): boolean{
        const allowed = ['VariableDeclaration', 'NumberLiteral', 'LabelledStatement']
        if (!allowed.includes(node.name)) return false

        const writer = new core.TSLanguageWriter(
            new core.IndentedPrinter(),
            this.peerGenerator.resolver,
            this.peerGenerator.converter
        )

        writer.writeClass( // TODO: move to generator, call just a peer.write(...)
            node.name,
            () => {
                this.peerGenerator.writeBody(node, writer, (body: Body) => {
                    // factory.ts
                    const creates = body.creates?.concat(...body.updates)
                    creates?.forEach(m => this.writeFactoryCreateImpl(node, m, this.factoryWriter))
                })
            }
        )

        const out = writer.getOutput()
        console.log(`${out.join('\n')}`);
        return false
    }

    override onEnterMethodDecl(node: core.IDLMethod): boolean {
        // Another way to gnerate methods
        //console.log(`method: ${node.name}`);
        return true
    }

    private writeFactoryCreateImpl(
        iface: core.IDLInterface,
        methods: core.Method,
        writer: core.LanguageWriter): void {
            // TODO:
    }

    private resolver = {
        resolveTypeReference(
            type: core.IDLReferenceType,
            terminalImports?: boolean
        ): core.IDLEntry | undefined {
            return this.visitor.resolveReference(type)
        },

        toDeclaration(type: core.IDLNode): core.IDLNode {
            throw "Unused";
        },

        isHeir(type: core.IDLInterface, name: string) {
            return this.visitor.isHeir(type, name)
        },

        visitor: this,
    }

    private peerGenerator = new PeerGenerator(
        this.resolver
    )

    private factoryWriter = new core.TSLanguageWriter(
        new core.IndentedPrinter(),
        this.peerGenerator.resolver,
        this.peerGenerator.converter
    )
}

