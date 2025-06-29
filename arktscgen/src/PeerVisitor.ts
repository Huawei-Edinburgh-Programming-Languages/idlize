import * as core from "@idlizer/core"
import { IVisitor } from "./Visitor"
import { PeerGenerator, Body } from "./PeerGenerator";
import { Config } from "./general/Config"
import * as pp from "./printers/library/PeerPrinter";
import { LanguageWriter } from "@idlizer/core";
import { isReal } from "./general/common";
import { PeersConstructions } from "./constuctions/PeersConstructions";

export class PeerVisitor extends IVisitor {
    constructor(
        private config: Config,
        private idl: core.IDLFile
    ) {
        super()
    }

    override onEnterNamespace(node: core.IDLNamespace): boolean {
        console.log(`namespace: ${node.name}`);
        return true
    }

    override onEnterInterface(node: core.IDLInterface): boolean{
        const writer = new core.TSLanguageWriter(
            new core.IndentedPrinter(),
            this.resolver,
            this.converter
        )

        writer.writeClass(
            node.name,
            () => {
                PeerGenerator.generateBody(node, (body: Body) => {
                    const creates = body.creates?.concat(...body.updates)
                    creates?.forEach(m => this.writePeerCreateImpl(node, m, writer))
                    creates?.forEach(m => this.writeFactoryCreateImpl(node, m, this.factoryWriter))
                })
            }
        )

        const out = writer.getOutput()
        console.log(`${out.join('\n')}`);

        return false
    }

    override onEnterMethodDecl(node: core.IDLMethod): boolean {
        //console.log(`method: ${node.name}`);
        return true
    }

    private writePeerCreateImpl(
        iface: core.IDLInterface,
        method: core.Method,
        writer: LanguageWriter): void {
        console.log(`method=${method}`);

        const nativeCall = writer.makeFunctionCall(
            writer.makeString('test'
                //PeersConstructions.callBinding(
                //    this.node.name,
                //    node.name,
                //    nodeNamespace(this.node)
                //)
            ),
            //this.makeBindingArguments(node.parameters)
            method.signature.argNames?.map(p => writer.makeString(p)) ?? []
        )
        const newExpr = writer.makeNewObject(iface.name, [nativeCall])

        writer.writeMethodImplementation(method, () => {
            if (isReal(iface)) {
                const varName = 'result'
                writer.writeStatements(
                    writer.makeAssign(
                        varName, core.createReferenceType(iface.name), newExpr, true
                    ),
                    writer.makeStatement(
                        writer.makeMethodCall(varName, PeersConstructions.setChildrenParentPtrMethod, [])
                    ),
                    writer.makeReturn(
                        writer.makeString(varName)
                    ),
                )
            } else {
                writer.writeStatement(
                    writer.makeReturn(newExpr)
                )
            }
        })
    }

    private writeFactoryCreateImpl(
        iface: core.IDLInterface,
        methods: core.Method,
        writer: LanguageWriter): void {
    }

    private resolver = {
            resolveTypeReference(
                type: core.IDLReferenceType,
                terminalImports?: boolean
            ): core.IDLEntry | undefined {
                return this.self.resolveReference(type)
            },
            toDeclaration(type: core.IDLNode): core.IDLNode {
                throw "Unused";
            },
            self : this,
        }

    private converter = new core.TSTypeNameConvertor(
        this.resolver
    )

    private factoryWriter = new core.TSLanguageWriter(
        new core.IndentedPrinter(),
        this.resolver,
        this.converter
    )
}

