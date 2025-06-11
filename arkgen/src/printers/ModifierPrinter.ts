import * as idl from '@idlizer/core/idl'
import { BranchStatement, isHeir, LanguageWriter, LayoutNodeRole, Method, MethodModifier, MethodSignature, MultiBranchIfStatement, NamedMethodSignature, PeerClass, PeerLibrary, PeerMethod } from "@idlizer/core";
import { collapseIdlPeerMethods, componentToPeerClass, findComponentByName, groupOverloads, ImportsCollector, PrinterResult } from "@idlizer/libohos";
import { collectPeersForFile } from "@idlizer/libohos";

function capitalizeFirstLetter(str: string): string {
    return str.charAt(0).toUpperCase() + str.slice(1);
}

function getAttributeModifierClassName(method: PeerMethod): string {
    return `${capitalizeFirstLetter(method.method.name)}Modifier`
}

class ModifiersFileVisitor {
    constructor(
        protected readonly library: PeerLibrary,
        private readonly file: idl.IDLFile,
    ) { }

    visit(): PrinterResult[] {
        const result: PrinterResult[] = [];
        collectPeersForFile(this.library, this.file).forEach(peer => {
            result.push(...this.printModifiers(peer))
        })
        return result;
    }

    generateAttributeSetParentName(peer: PeerClass): string | undefined {
        if (!isHeir(peer.originalClassName!)) return undefined;
        return this.generateAttributeSetName(peer.parentComponentName!);
    }

    generateAttributeSetName(name: string): string {
        return `Ark${name}Set`
    }

    generateFiledName(name: string, subfix: string = ''): string {
        return `_${name}${subfix}_value`
    }

    generateFiledFlag(name: string, subfix: string = ''): string {
        return `_${name}${subfix}_flag`
    }

    printImports(): ImportsCollector {
        const importsCollector = new ImportsCollector
        return importsCollector
    }

    printModifierWithKeyBody(writer: LanguageWriter, peer: PeerClass, method: PeerMethod) {
        const argsNames = method.argConvertors.map((conv, index) => {
            const argName = conv.param
            const castedType = idl.maybeOptional(method.method.signature.args[index], method.method.signature.isArgOptional(index))
            return `${writer.escapeKeyword(argName)} as ${writer.getNodeName(castedType)}`
        })
        const call = writer.makeFunctionCall('modifierWithKey', [
            writer.makeString(`this._modifiersWithKeys`),
            writer.makeString(`${getAttributeModifierClassName(method)}.identity`),
            writer.makeString(`${getAttributeModifierClassName(method)}.factory`),
            ...argsNames.map((arg) => writer.makeString(`${arg}`))
        ])
        writer.writeExpressionStatement(call)
    }

    printModifierNullWidthKeyBody(writer: LanguageWriter, peer: PeerClass, method: PeerMethod) {
        const call = writer.makeFunctionCall('modifierNullWithKey', [
            writer.makeString(`this._modifiersWithKeys`),
            writer.makeString(`${getAttributeModifierClassName(method)}.identity`)
        ])
        writer.writeExpressionStatement(call)
    }

    printModifiers(peer: PeerClass): PrinterResult[] {
        const printer = this.library.createLanguageWriter();
        const component = findComponentByName(this.library, peer.componentName)!
        const componentAttribute = component.attributeDeclaration;
        const parentSet = this.generateAttributeSetParentName(peer)

        type attributeType = [PeerMethod, string[], idl.IDLType[]]
        const attributeTypes: Map<string, attributeType> = new Map

        groupOverloads(peer.methods).forEach(m => {
            const method = collapseIdlPeerMethods(this.library, m)
            const args: string[] = []
            const types = method.argConvertors.map((conv, index) => {
                args.push(conv.param)
                return idl.maybeOptional(method.method.signature.args[index], method.method.signature.isArgOptional(index))
            })
            attributeTypes.set(method.method.name, [method, args, types])
        })

        printer.writeClass(this.generateAttributeSetName(componentAttribute.name), (writer) => {
            writer.print("_instanceId: number = -1;")

            writer.writeMethodImplementation(new Method(
                `setInstanceId`,
                new MethodSignature(idl.IDLVoidType, [idl.IDLNumberType], [], [], [], ['instanceId'])),
                writer => {
                    writer.writeStatement(writer.makeAssign('this._instanceId', undefined, writer.makeString('instanceId'), false))
                }
            )

            attributeTypes.forEach(attribute => {
                writer.writeFieldDeclaration(this.generateFiledFlag(attribute[0].method.name), idl.IDLBooleanType, [], true)
                attribute[2].forEach((t, index) => {
                    writer.writeFieldDeclaration(this.generateFiledName(attribute[0].method.name, index.toString()), t, [], true)
                })
            })

            writer.writeMethodImplementation(new Method('applyModifierPatch',
                new MethodSignature(idl.IDLVoidType, [idl.createReferenceType(componentToPeerClass(peer.componentName))], [], [], [], ['peerNode'])),
                writer => {
                    const statements: BranchStatement[] = []
                    attributeTypes.forEach((attribute, name) => {
                        const expr = `this.${this.generateFiledFlag(attribute[0].method.name)}`
                        const params: string[] = attribute[1].map((_, index) => {
                            return `this.${this.generateFiledName(attribute[0].method.name, index.toString())}`
                        })

                        const statement = writer.makeMethodCall('peerNode', `${attribute[0].overloadedName}Attribute`, params.map(p => writer.makeString(p)))
                        statements.push({ expr: writer.makeString(expr), stmt: writer.makeStatement(statement) })
                    })
                    const mutli: MultiBranchIfStatement = new MultiBranchIfStatement(statements, undefined)
                    writer.writeStatement(mutli)
                }
            )


            attributeTypes.forEach(attribute => {
                printer.writeMethodImplementation(attribute[0].method, (writer) => {
                    writer.writeStatement(writer.makeAssign(`this.${this.generateFiledFlag(attribute[0].method.name)}`, idl.IDLBooleanType, writer.makeString(`true`), false))
                    attribute[2].forEach((t, index) => {
                        writer.writeStatement(writer.makeAssign(`this.${this.generateFiledName(attribute[0].method.name, index.toString())}`, t, writer.makeString(attribute[1][index]), false))
                    })
                    writer.writeStatement(writer.makeReturn(writer.makeThis()))
                })
            })
        }, parentSet, [`${componentAttribute.name}`])

        return [{
            collector: this.printImports(),
            content: printer,
            over: {
                node: component.attributeDeclaration,
                role: LayoutNodeRole.COMPONENT,
                hint: 'component.modfiier'
            }
        }]
    }
}

class ModifiersVisitor {
    constructor(
        private readonly peerLibrary: PeerLibrary
    ) { }

    printModifiers(): PrinterResult[] {
        const result: PrinterResult[] = []
        for (const file of this.peerLibrary.files.values()) {
            const visitor = new ModifiersFileVisitor(this.peerLibrary, file);
            result.push(...visitor.visit())
        }
        return result;
    }
}

export function printModifiers(peerLibrary: PeerLibrary): PrinterResult[] {
    return new ModifiersVisitor(peerLibrary).printModifiers()
}