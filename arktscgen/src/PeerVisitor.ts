import * as core from "@idlizer/core"
import * as path from "node:path"
import { readFileSync } from "node:fs";
import { Config } from "./general/Config"
import { Visitor } from "./Visitor"
import { PeerGenerator } from "./PeerGenerator";
import { FactoryGenerator } from "./FactoryGenerator";
import { BridgesGenerator } from "./BridgesGenerator";
import { Body, ImporterResolverProxy, InteropConvertor, Resolver, SimpleConverter } from "./general/types"
import { BindingsConstructions } from "./constuctions/BindingsConstructions";
import { fixEnumPrefix, isCreateOrUpdate, splitCreateOrUpdate } from "./general/common";

export class PeerVisitor extends Visitor {
    constructor(
        private config: Config,
        private outDir: string,
    ) {
        super()
        Allowed.forEach(fqName => {
            const parts = fqName.split('.')
            const [ns, name] = parts.length === 1 ? ['', parts.at(0)] : parts
            if (!this.allowed.has(ns)) {
                this.allowed.set(ns, new Map<string, boolean>())
            }

            const [key, value] = name!.endsWith('-') ?
                [name!.slice(0, -1), false] : [name!, true]
            this.allowed.get(ns)!.set(key, value)
        })
    }

    override onEnterNamespace(node: core.IDLNamespace): boolean {
        //console.log(`namespace: ${node.name}`);
        return this.allowed.has(node.name)
    }

    override onEnterInterface(node: core.IDLInterface): boolean{
        if (this.isIgnored(node)) return false

        // Native bridges & bindings generation

        this.writeBridges(node)
        this.writeBindings(node)
        this.writeIndex(node)

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
            this.writeFactoryCreateImpl(node, body, this.factoryWriter)
        })
        this.writeFile(`src/generated/peers/${node.name}.ts`, writer, 'peer.ts', importer)

        return false
    }

   override onEnterEnum(node: core.IDLEnum): boolean {
       this.writeEnum(node)
       return false
   }

    override onDone(_: core.IDLFile): void {
        this.writeFile('src/generated/factory.ts', this.factoryWriter, undefined, this.factoryImporter)
        this.writeFile('src/generated/bridges.cc', this.bridgesWriter)
        this.writeFile('src/generated/Es2pandaNativeModule.ts', this.bindingsWriter)
        //this.writeFile('src/generated/index.ts', this.indexContent)
        this.writeFile('src/generated/Es2pandaEnums.ts', this.enumsWriter)
   }

    private writeFactoryCreateImpl(iface: core.IDLInterface, body: Body, writer: core.LanguageWriter): void {
        FactoryGenerator.write(iface, body, writer, this.converter)
    }

    private writeIndex(iface: core.IDLInterface): void {
        this.indexContent.push(`export * from "./peers/${iface}.name}"`)
    }

    private writeEnum(node: core.IDLEnum): void {
        const writer = this.enumsWriter
        writer.writeEnum(fixEnumPrefix(node.name),
            node.elements.map(elem => {
                if (typeof elem.initializer !== 'number') {
                    core.throwException(`unexpected initializer value: ${elem.initializer}`)
                }
                return { name: elem.name,
                    stringId: undefined,
                    numberId: elem.initializer,
                }
            }), {
                isExport: true
            }
        )
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

    private writeBindings(iface: core.IDLInterface): void {
        const writer = this.bindingsWriter
        iface.methods.forEach((m, index) => {
            const method = PeerGenerator.makeMethod(m)
            if (isCreateOrUpdate(m.name)) {
                const parts = splitCreateOrUpdate(m.name)
                method.name = `_${parts.createOrUpdate}${iface.name}${parts.rest}`
            } else {
                method.name = `_${iface.name}${m.name}`
                method.signature.args.splice(1, 0, core.createReferenceType(iface.name))
                method.signature.argNames!.splice(1, 0, 'reciever')
            }
            writer.writeMethodImplementation(method, () => {
                writer.writeExpressionStatement(
                    writer.makeString(BindingsConstructions.unimplemented)
                )
            })
        })
    }

    private writeFile(
        relativeFilePath: string, writer: core.LanguageWriter, templateName_?: string, importer?: ImporterResolverProxy,
        prologue?: string[], epilogue?: string[]): void {
        const filePath = path.join(this.outDir, relativeFilePath)
        const templateName = templateName_ ?? path.basename(relativeFilePath)
        const template = readFileSync(this.resolvePath(`../templates/${templateName}`), 'utf-8')
        const contents = [
            (prologue ?? []),
            (importer?.asStrings() ?? []),
            [''],
            writer.getOutput(),
            (epilogue ?? [])
        ]
            .filter(arr => arr.length)
            .map(arr => arr.join('\n'))
            .join('\n')

        //console.log(`${filePath}\n${contents}`);
        core.forceWriteFile(filePath, template.replaceAll('%GENERATED_PART%', contents))
    }

    private resolvePath(rel: string): string {
        return path.join(__dirname, rel)
    }

    private isIgnored(node: core.IDLInterface): boolean {
        const classes = this.allowed.get(this.namespaceName)
        return classes === undefined ||
            (classes.size !== 0 && !(classes.get(node.name) ?? (classes.get('*') ?? false)))
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

    private converter = new SimpleConverter(this.resolver)
    private interopConverter = new InteropConvertor(this.resolver)

    private factoryImporter = new ImporterResolverProxy(this.resolver)
    private factoryWriter = new core.TSLanguageWriter(
        new core.IndentedPrinter(),
        this.factoryImporter,
        this.converter
    )

    private bridgesGenerator = new BridgesGenerator(
        this.resolver,
        this.interopConverter,
        this.config
    )

    private bridgesWriter = new core.CppLanguageWriter(
        new core.IndentedPrinter(),
        this.resolver,
        this.interopConverter,
        this.bridgesGenerator.primitives
    )

    private bindingsWriter = new core.TSLanguageWriter(
        new core.IndentedPrinter(),
        this.resolver,
        this.interopConverter
    )

    private enumsWriter = new core.TSLanguageWriter(
        new core.IndentedPrinter(),
        this.resolver,
        this.converter
    )

    private indexContent: string[] = []
    private allowed = new Map<string, Map<string, boolean>>()
}

const Allowed = [
    'es2panda_Impl-',
    'es2panda_SourcePosition',
    'es2panda_SourceRange',
    'es2panda_LabelPair',
    'es2panda_ScriptFunctionData',
    'es2panda_ImportSource',
    'es2panda_SignatureInfo',
    'es2panda_IndexInfo',
    'es2panda_ObjectDescriptor',
    'es2panda_ScopeFindResult',
    'es2panda_BindingProps',
    'es2panda_Declaration',
    'es2panda_AstVisitor',
    'es2panda_AstVerifier',
    'es2panda_VerifierMessage',
    'es2panda_CodeGen',
    'es2panda_VReg',
    'es2panda_IRNode',
    'es2panda_ErrorLogger',
    'es2panda_VerificationContext',
    'es2panda_DynamicImportData',
    'es2panda_SuggestionInfo',
    'es2panda_DiagnosticInfo',
    'ir.*',
	'ir.Annotated-',
	'ir.AnnotationAllowed-',
	'ir.AstNode+', // XXX: has bridges but no peer
	'ir.JsDocAllowed-',
	'ir.Typed-',
	'ir.VectorIterationGuard-',
    'parser.Program',
    'es2panda.*',
    'varbinder.InterfaceDecl',
    'varbinder.FunctionDecl'
]
