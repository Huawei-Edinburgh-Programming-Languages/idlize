import * as idl from '@idlizer/core/idl'
import { isHeir, LanguageWriter, LayoutNodeRole, Method, MethodModifier, MethodSignature, NamedMethodSignature, PeerClass, PeerLibrary, PeerMethod } from "@idlizer/core";
import { collapseIdlPeerMethods, componentToPeerClass, findComponentByName, groupOverloads, ImportsCollector, PrinterResult } from "@idlizer/libohos";
import { collectPeersForFile } from "@idlizer/libohos";

function capitalizeFirstLetter(str: string): string {
    return str.charAt(0).toUpperCase() + str.slice(1);
}

function getAttributeClassName(method: PeerMethod): string {
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
            result.push(...this.printAttrbiuteClass(peer))
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
            writer.makeString(`${getAttributeClassName(method)}.identity`),
            writer.makeString(`${getAttributeClassName(method)}.factory`),
            ...argsNames.map((arg) => writer.makeString(`${arg}`))
        ])
        writer.writeExpressionStatement(call)
    }

    printModifierNullWidthKeyBody(writer: LanguageWriter, peer: PeerClass, method: PeerMethod) {
        const call = writer.makeFunctionCall('modifierNullWithKey', [
            writer.makeString(`this._modifiersWithKeys`),
            writer.makeString(`${getAttributeClassName(method)}.identity`)
        ])
        writer.writeExpressionStatement(call)
    }

    printModifiers(peer: PeerClass): PrinterResult[] {
        const printer = this.library.createLanguageWriter();
        const component = findComponentByName(this.library, peer.componentName)!
        const componentAttribute = component.attributeDeclaration;
        const parentSet = this.generateAttributeSetParentName(peer)
        printer.writeClass(this.generateAttributeSetName(componentAttribute.name), (writer) => {
            writer.print("_modifiersWithKeys: ObservedMap = new ObservedMap();")
            writer.print("_instanceId: number = -1;")
            groupOverloads(peer.methods).forEach(m => {
                const method = collapseIdlPeerMethods(this.library, m)
                printer.writeMethodImplementation(method.method, (writer) => {
                    writer.print(`if (value) {`)
                    printer.pushIndent()
                    this.printModifierWithKeyBody(writer, peer, method)
                    printer.popIndent()
                    writer.print(`} else {`)
                    printer.pushIndent()
                    this.printModifierNullWidthKeyBody(writer, peer, method)
                    printer.popIndent()
                    writer.print(`}`)
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

    printAttrbiuteClass(peer: PeerClass): PrinterResult[] {
        const printer = this.library.createLanguageWriter();
        const component = findComponentByName(this.library, peer.componentName)!
        groupOverloads(peer.methods).forEach(m => {
            const method = collapseIdlPeerMethods(this.library, m)
            const args: string[] = []
            const types = method.argConvertors.map((conv, index) => {
                args.push(conv.param)
                return idl.maybeOptional(method.method.signature.args[index], method.method.signature.isArgOptional(index))
            })
            const parentClass = `ModifierWithKey${types.length}<${types.map(t => printer.getNodeName(t)).join(', ')}>`
            printer.writeClass(
                getAttributeClassName(method),
                (writer) => {
                    writer.print(`static identity: string = '${method.method.name}';`)
                    writer.writeConstructorImplementation('', new MethodSignature(
                        idl.IDLVoidType,
                        types,
                        undefined,
                        undefined,
                        undefined,
                        args
                    ), (w) => {
                        w.writeSuperCall(args)
                    })
                    writer.writeMethodImplementation(new Method(
                        'factory',
                        new MethodSignature(
                            idl.createReferenceType(getAttributeClassName(method)),
                            types,
                            undefined,
                            undefined,
                            undefined,
                            args
                        ),
                        [MethodModifier.STATIC]
                    ), (w) => {
                        w.writeStatement(writer.makeReturn(
                            w.makeNewObject(
                                getAttributeClassName(method),
                                args.map(a => w.makeString(a))
                            )
                        ))
                    })
                    writer.writeMethodImplementation(new Method(
                        'applyPeer',
                        new MethodSignature(
                            idl.createReferenceType(getAttributeClassName(method)),
                            [idl.createReferenceType(componentToPeerClass(peer.componentName)), ...types],
                            undefined,
                            undefined,
                            undefined,
                            ['node', ...args]
                        )),
                        w => {
                            
                        }
                    )
                },
                parentClass
            )

        })
        return [
            {
                collector: new ImportsCollector,
                content: printer,
                over: {
                    node: component.attributeDeclaration,
                    role: LayoutNodeRole.COMPONENT,
                    hint: 'component.modfiier'
                }
            }
        ]
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