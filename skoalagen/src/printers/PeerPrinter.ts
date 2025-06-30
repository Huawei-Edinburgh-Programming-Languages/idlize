import * as idl from '@idlizer/core'
import { LibraryInterface } from "@idlizer/core";
import { collectDeclDependencies, collectPeersForFile, componentToPeerClass, findComponentByName, findComponentByType, ImportsCollector, PrinterResult, TargetFile, writePeerMethod } from '@idlizer/libohos';

class PeerFileVisitor {
    constructor(
        protected readonly library: LibraryInterface,
        protected readonly file: idl.IDLFile,
        protected readonly dumpSerialized: boolean,
    ) { }

    protected generatePeerParentName(peer: idl.PeerClass): string {
        if (!peer.originalClassName)
            throw new Error(`${peer.componentName} is not supported, use 'uselessConstructorInterfaces' for now`)
        // const parentRole = idl.determineParentRole(peer.originalClassName, peer.parentComponentName)
        // if ([idl.InheritanceRole.Finalizable, idl.InheritanceRole.PeerNode].includes(parentRole)) {
        //     return idl.InheritanceRole[parentRole]
        // }
        const parent = peer.parentComponentName ?? idl.throwException(`Expected component to have parent`)
        // return componentToPeerClass(parent)
        return parent
    }

    protected printPeerMethod(method: idl.PeerMethod, printer: idl.LanguageWriter) {
        this.library.setCurrentContext(`${method.originalParentName}.${method.sig.name}`)
        writePeerMethod(this.library, printer, method, true, this.dumpSerialized, "Attribute", "this.peer.ptr")
        this.library.setCurrentContext(undefined)
    }

    private printBody(peer: idl.PeerClass, writer: idl.LanguageWriter) {
        // todo
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
