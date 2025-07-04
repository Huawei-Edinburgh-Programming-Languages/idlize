import * as core from "@idlizer/core"
import { Declarations, Visitor } from "./Visitor"
import { PeerGenerator, Body, Resolver, Importer } from "./PeerGenerator";
import { Config } from "./general/Config"
import { baseName, parent } from "./utils/idl";
import { PeersConstructions } from "./constuctions/PeersConstructions";

export class PeerVisitor extends Visitor {
    constructor(
        private config: Config,
        decls?: Declarations
    ) {
        super(decls)
    }

    override onEnterNamespace(node: core.IDLNamespace): boolean {
        console.log(`namespace: ${node.name}`);
        return ['', 'ir'].includes(node.name)
    }

    override onEnterInterface(node: core.IDLInterface): boolean{
        const allowed = ['VariableDeclaration', 'NumberLiteral', 'Identifier']
        if (!allowed.includes(node.name)) return false

        const importer = new ImporterResolverProxy(this.resolver, [node.name])
        const peerGenerator = new PeerGenerator(importer, importer)
        const writer = new core.TSLanguageWriter(
            new core.IndentedPrinter(),
            peerGenerator.resolver,
            peerGenerator.converter
        )

        peerGenerator.writeClass(node, writer, (body: Body) => {
            // factory.ts
            const creates = body.creates?.concat(...body.updates)
            creates?.forEach(m => this.writeFactoryCreateImpl(node, m, this.factoryWriter))
        })

        const out = writer.getOutput()
        console.log(`${out.join('\n')}`);

        const out2 = importer.asStrings()
        console.log(`${out2.join('\n')}`);

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

        isHeir(type: core.IDLReferenceType | core.IDLInterface, name: string) {
            return this.visitor.isHeir(type, name)
        },

        isPeer(ref: core.IDLReferenceType | core.IDLInterface) {
            return this.visitor.isPeer(ref)
        },

        visitor: this,
    }

    private factoryWriter = new core.TSLanguageWriter(
        new core.IndentedPrinter(),
        core.createEmptyReferenceResolver(),
        new core.TSTypeNameConvertor(core.createEmptyReferenceResolver())
    )
}

class ImporterResolverProxy implements Resolver, Importer {
    constructor(
        private resolver: Resolver,
        private _seen: string[]
    ) {}

    resolveTypeReference(
        type: core.IDLReferenceType,
        terminalImports?: boolean
    ): core.IDLEntry | undefined {
        const entry = this.resolver.resolveTypeReference(type, terminalImports)
        console.log(`importer=${type.name} => ${entry}`)
        if (!entry) {
            return undefined
        }

        if (core.isEnum(entry)) {
            this.importEnum(entry.name)

        } else if (core.isInterface(entry) && this.resolver.isPeer(entry)) {
            this.importPeer(entry.name)
        }

        return entry
    }

    toDeclaration(type: core.IDLNode): core.IDLNode {
        return this.resolver.toDeclaration(type)
    }

    isHeir(type: core.IDLReferenceType | core.IDLInterface, name: string): boolean {
        return this.resolver.isHeir(type, name)
    }

    isPeer(type: core.IDLReferenceType | core.IDLInterface): boolean {
        return this.resolver.isPeer(type)
    }

    importEnum(name: string): string {
        return this.import(name, '../Es2PandaEnums')
    }

    importPeer(name: string): string {
        return this.import(name, name)
    }

    importReexport(name: string): string {
        return this.import(name, '../reexport')
    }

    public asStrings(): string[] {
        return this.imports.sort()
    }

    private import(name: string, from: string): string {
        if (this.seen.has(name)) {
            return name
        }

        this.seen.add(name);
        this.imports.push(
            PeersConstructions.import(name, from)
        )
        return name
    }

    private seen = new Set<string>([
        Config.astNodeCommonAncestor,
        Config.defaultAncestor,
        ...this._seen
    ])

    private imports: string[] = []
}

