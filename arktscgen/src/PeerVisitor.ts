import * as core from "@idlizer/core"
import * as path from "node:path"
import { readFileSync } from "node:fs";
import { Declarations, Visitor } from "./Visitor"
import { PeerGenerator } from "./PeerGenerator";
import { Config } from "./general/Config"
import { Body, ImporterResolverProxy, InteropConvertor, Resolver, SimpleConverter } from "./general/types"
import { FactoryGenerator } from "./FactoryGenerator";
import { BridgesGenerator } from "./BridgesGenerator";

export class PeerVisitor extends Visitor {
    constructor(
        private config: Config,
        private outDir: string,
    ) {
        super()
    }

    override onEnterNamespace(node: core.IDLNamespace): boolean {
        console.log(`namespace: ${node.name}`);
        return ['', 'ir'].includes(node.name)
    }

    override onEnterInterface(node: core.IDLInterface): boolean{
        const allowed = ['VariableDeclaration', 'NumberLiteral', 'Identifier']
        if (!allowed.includes(node.name)) return false

        // Native bridges generation

        this.writeBridges(node)

        // Peer & co generation

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
        this.writeFile(`src/generated/peers/${node.name}`, writer, 'peer.ts', importer)

        return false
    }

    override onDone(_: core.IDLFile): void {
        this.writeFile('src/generated/factory.ts', this.factoryWriter, undefined, this.factoryImporter)
        this.writeFile('src/generated/bridges.cc', this.bridgesWriter)
   }

    private writeFactoryCreateImpl(iface: core.IDLInterface, body: Body, writer: core.LanguageWriter): void {
        FactoryGenerator.write(iface, body, writer, this.converter)
    }

    private writeIndexFile(iface: core.IDLInterface, body: Body): void {
    }

    private writeBridges(iface: core.IDLInterface): void {
        const methods = PeerGenerator.splitMethods(iface)
        const body = {
            creates: methods.Create
                ?.map(m => PeerGenerator.makeMethod(m)),
            updates: methods.Update
                ?.map(m => PeerGenerator.makeMethod(m)),
            getters: methods.Getter
                ?.map(m => PeerGenerator.makeMethod(m)),
            regular: methods.Regular
                ?.map(m => PeerGenerator.makeMethod(m)),
        }
        this.bridgesGenerator.write(iface, body, this.bridgesWriter)
    }

    private writeFile( relativeFilePath: string, writer: core.LanguageWriter, templateName_?: string, importer?: ImporterResolverProxy,
        prologue?: string[], epilogue?: string[]): void {
        const filePath = path.join(this.outDir, relativeFilePath)
        const templateName = templateName_ ?? path.basename(relativeFilePath)
        const template = readFileSync(this.resolvePath(`../templates/${templateName}`), 'utf-8')
        const contents = [
            (prologue ?? []),
            (importer?.asStrings() ?? []),
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
            if (core.isType(type)) {
                if(core.isReferenceType(type)) {
                    return this.visitor.resolveReference(type) ?? type
                }
            } else {
                console.log(`toDeclaration: ${type.kind}`);
            }
            return type
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

    private interopConverter = new InteropConvertor(
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

    private bridgesGenerator = new BridgesGenerator(
        this.resolver,
        this.interopConverter
    )

    private bridgesWriter = new core.CppLanguageWriter(
        new core.IndentedPrinter(),
        this.resolver,
        this.interopConverter,
        this.bridgesGenerator.primitives
    )

    private indexContent: string[] = []
}
