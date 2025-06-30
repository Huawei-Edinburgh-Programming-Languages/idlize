import * as idl from '@idlizer/core'
import { LibraryInterface } from "@idlizer/core";
import { collectDeclDependencies, collectDeclItself, collectPeersForFile, findComponentByName, findComponentByType, ImportsCollector, NativeModule, PrinterResult, TargetFile, writePeerMethod } from '@idlizer/libohos';

export function componentToPeerClass(component: string) {
    return `${component}Peer`
}

class PeerFileVisitor {
    constructor(
        protected readonly library: LibraryInterface,
        protected readonly file: idl.IDLFile,
        protected readonly dumpSerialized: boolean,
    ) { }

    protected generatePeerParentName(peer: idl.PeerClass): string {
        if (!peer.originalClassName)
            throw new Error(`${peer.componentName} is not supported, use 'uselessConstructorInterfaces' for now`)
        const parent = peer.parentComponentName ?? idl.throwException(`Expected component to have parent`)
        return parent
    }

    protected printPeerConstructor(peer: idl.PeerClass, printer: idl.LanguageWriter): void {
        const signature = new idl.NamedMethodSignature(
            idl.IDLVoidType,
            [idl.maybeOptional(idl.IDLPointerType, true), idl.IDLBooleanType],
            ['ptr', 'managed'],
            [undefined, "true"])

        const name = componentToPeerClass(peer.componentName)
        printer.writeConstructorImplementation(
            name, 
            signature, (writer) => { },
            { delegationArgs: [`ptr ?? ${name}.make()`, `${name}.getFinalizer()`, 'managed'].map(it => printer.makeString(it)), delegationName: peer.parentComponentName },
            [idl.MethodModifier.PROTECTED])
    }

    protected printFinalizerMethod(peer: idl.PeerClass, printer: idl.LanguageWriter): void {
        printer.writeMethodImplementation(
            new idl.Method('getFinalizer',
                new idl.MethodSignature(idl.IDLPointerType, []
                ), [idl.MethodModifier.STATIC], []),
            writer => writer.writeStatement(
                writer.makeReturn(
                    writer.makeNativeCall(NativeModule.Generated, `_${peer.componentName}_getFinalizer`, [])
                )
            )
        )
    }

    protected printPeerMethod(method: idl.PeerMethod, printer: idl.LanguageWriter) {
        this.library.setCurrentContext(`${method.originalParentName}.${method.sig.name}`)
        writePeerMethod(this.library, printer, method, true, this.dumpSerialized, "", "", method.returnType)
        this.library.setCurrentContext(undefined)
    }

    private printBody(peer: idl.PeerClass, writer: idl.LanguageWriter) {
        this.printPeerConstructor(peer, writer);
        this.printFinalizerMethod(peer, writer);

        (peer.methods as any[])
            .forEach(method => this.printPeerMethod(method, writer))
    }

    private printPeer(peer: idl.PeerClass, writer: idl.LanguageWriter): void {
        writer.writeClass(
            componentToPeerClass(peer.componentName),
            (writer) => this.printBody(peer, writer),
            this.generatePeerParentName(peer)
        )
    }

    protected printImports(peer: idl.PeerClass, imports: ImportsCollector): void {
        imports.addFeature('KPointer', "@koalaui/interop")

        collectDeclItself(this.library, idl.createReferenceType(NativeModule.Generated.name), imports)

        const component = findComponentByType(this.library, idl.createReferenceType(peer.originalClassName!))!
        collectDeclDependencies(this.library, component.attributeDeclaration, imports, { expandTypedefs: true })
        component.attributeDeclaration.methods.forEach(method => {
            method.parameters.map(p => p.type).concat([method.returnType]).forEach(type => {
                collectDeclDependencies(this.library, type, (dep) => {
                    collectDeclDependencies(this.library, dep, imports, { expandTypedefs: true })
                }, { expandTypedefs: true })
            })
        })
    }

    printFile(): PrinterResult[] {
        return collectPeersForFile(this.library, this.file)
            .filter(it => !idl.isRoot(it.componentName))
            .map(peer => {
                const component = findComponentByName(this.library, peer.componentName)
                const imports = new ImportsCollector()
                const content = this.library.createLanguageWriter(this.library.language)
                this.printImports(peer, imports)
                this.printPeer(peer, content)
                return {
                    over: {
                        node: component!.attributeDeclaration,
                        role: idl.LayoutNodeRole.PEER,
                    },
                    collector: imports,
                    content
                }
            })
    }
}

class PeersVisitor {
    readonly peers: Map<TargetFile, string[]> = new Map()

    constructor(
        private readonly library: LibraryInterface,
        private readonly dumpSerialized: boolean,
    ) { }

    printPeers(): PrinterResult[] {
        const results: PrinterResult[] = []
        for (const file of this.library.files.values()) {
            if (!collectPeersForFile(this.library, file).length)
                continue
            const visitor = new PeerFileVisitor(this.library, file, this.dumpSerialized)
            results.push(...visitor.printFile())
        }
        return results
    }
}

export function createPeersPrinter(dumpSerialized: boolean) {
    return (library: LibraryInterface) => new PeersVisitor(library, dumpSerialized).printPeers()
}
