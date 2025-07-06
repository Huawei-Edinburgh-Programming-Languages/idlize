import * as core from "@idlizer/core"
import * as path from "node:path"
import { readFileSync } from "node:fs";
import { Declarations, Visitor } from "./Visitor"
import { PeerGenerator } from "./PeerGenerator";
import { Config } from "./general/Config"
import { Body, Importer, ImporterResolverProxy, Resolver, SimpleConverter } from "./general/types"
import { PeersConstructions } from "./constuctions/PeersConstructions";
import { FactoryConstructions } from "./constuctions/FactoryConstructions";
import { FactoryGenerator } from "./FactoryGenerator";

export class PeerVisitor extends Visitor {
    constructor(
        private config: Config,
        private outDir: string,
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
        const peerGenerator = new PeerGenerator(
            importer as Resolver,
            this.converter,
            importer,
            this.config
        )

        const writer = new core.TSLanguageWriter(
            new core.IndentedPrinter(),
            peerGenerator.resolver,
            peerGenerator.converter
        )

        peerGenerator.writeClass(node, writer, (body: Body) => {
            // factory.ts
            this.writeFactoryCreateImpl(node, body, this.factoryWriter)
            this.writeIndexFile(node, body)
        })

        const filePath = path.join(this.outDir, 'peer', `${node.name}.ts`)
        this.writeFile(filePath, 'peer.ts', writer, importer)

        return false
    }

    override onEnterMethodDecl(node: core.IDLMethod): boolean {
        // Another way to gnerate methods
        //console.log(`method: ${node.name}`);
        return true
    }

    private writeIndexFile(iface: core.IDLInterface, body: Body): void {
    }

    private writeFactoryCreateImpl(iface: core.IDLInterface, body: Body, writer: core.LanguageWriter): void {
        FactoryGenerator.write(iface, body, writer, this.converter)
    }

    private writeFile(
        filePath: string,
        templateName: string,
        writer: core.LanguageWriter,
        importer: ImporterResolverProxy,
        prologue?: string[],
        epilogue?: string[]): void
    {
        const template = readFileSync(this.resolvePath(`../templates/${templateName}`), 'utf-8')
        const contents = [
            (prologue ?? []),
            importer.asStrings(),
            writer.getOutput(),
            (epilogue ?? [])
        ]
            .map(arr => arr.join('\n'))
            .join('\n')

        console.log(`${filePath}\n${template.replaceAll('%GENERATED_PART%', contents)}`);
        // core.forceWriteFile(filePath, template.replaceAll('%GENERATED_PART%', contents))
    }

    private resolvePath(rel: string): string {
        return path.join(__dirname, rel)
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

    private converter = new SimpleConverter(
        this.resolver
    )

    private factoryImporter = new ImporterResolverProxy(
        this.resolver
    )

    private factoryWriter = new core.TSLanguageWriter(
        new core.IndentedPrinter(),
        this.factoryImporter,
        this.converter
    )

    private indexContent: string[] = []
}
