import * as fs from 'node:fs'
import * as path from 'node:path'
import { LayoutManagerStrategy, LayoutNodeRole } from './LayoutManager'
import { PeerLibrary } from './PeerLibrary'
import * as idl from '@idlizer/core'
import { isComponentDeclaration } from './ComponentsCollector'
import { isMaterialized } from './idl/IdlPeerGeneratorVisitor'

export function writeFile(filename: string, content: string, config: { // TODO make content a string or a writer only
        onlyIntegrated: boolean,
        integrated?: boolean,
        message?: string
    }): boolean {
    if (config.integrated || !config.onlyIntegrated) {
        if (config.message)
            console.log(config.message, filename)
        fs.mkdirSync(path.dirname(filename), { recursive: true })
        fs.writeFileSync(filename, content)
        return true
    }
    return false
}

export function writeIntegratedFile(filename: string, content: string, message?: string) {
    writeFile(filename, content, {
        onlyIntegrated: false,
        integrated: true,
        message
    })
}

////////////////////////////////////////////////////////

function toFileName(name:string) {
    return name.split('_').map(it => idl.capitalize(it)).join('')
}

abstract class CommonLayoutBase implements LayoutManagerStrategy {
    constructor(
        protected library: PeerLibrary
    ) {}
    abstract resolve(node: idl.IDLNode, role: LayoutNodeRole): string

}

class TsLayout extends CommonLayoutBase {
    resolve(node: idl.IDLNode, role: LayoutNodeRole): string {
        switch (role) {
            case LayoutNodeRole.INTERFACE: {
                if (idl.isEntry(node)) {
                    const ns = idl.getNamespaceName(node)
                    if (ns !== '') {
                        return `Ark${ns.split('.').map(it => idl.capitalize(it)).join('')}Namespace`
                    }
                }
                if (idl.isInterface(node)) {
                    if (isComponentDeclaration(this.library, node)) {
                        return `Ark${toFileName(node.name)}`
                    }
                    if (idl.isBuilderClass(node)) {
                        return `Ark${toFileName(node.name)}Builder`
                    }
                    if (isMaterialized(node, this.library)) {
                        return `Ark${toFileName(node.name)}Materialized`
                    }
                    return `Ark${toFileName(node.name)}Interface`
                }
                return `Common`
            }
            case LayoutNodeRole.PEER: {
                if (idl.isInterface(node)) {
                    if (isComponentDeclaration(this.library, node)) {
                        return `peers/Ark${toFileName(node.name)}Peer`
                    }
                }
                return `CommonPeer`
            }
        }
    }
}

class ArkTsLayout extends CommonLayoutBase {
    resolve(node: idl.IDLNode, role: LayoutNodeRole): string {
        switch (role) {
            case LayoutNodeRole.INTERFACE: {
                if (idl.isEntry(node)) {
                    const ns = idl.getNamespaceName(node)
                    if (ns !== '') {
                        return `Ark${ns.split('.').map(it => idl.capitalize(it)).join('')}Namespace`
                    }
                }
                if (idl.isInterface(node)) {
                    if (isComponentDeclaration(this.library, node)) {
                        return `Ark${toFileName(node.name)}`
                    }
                    if (idl.isBuilderClass(node)) {
                        return `Ark${toFileName(node.name)}Builder`
                    }
                    if (isMaterialized(node, this.library)) {
                        return `Ark${toFileName(node.name)}Materialized`
                    }
                    return `Ark${toFileName(node.name)}Interface`
                }
                return `Common`
            }
            case LayoutNodeRole.PEER: {
                if (idl.isInterface(node)) {
                    if (isComponentDeclaration(this.library, node)) {
                        return `peers/Ark${toFileName(node.name)}Peer`
                    }
                }
                return `CommonPeer`
            }
        }
    }
}

////////////////////////////////////////////////////////

export function layout(library: PeerLibrary): LayoutManagerStrategy {
    switch(library.language) {
        case idl.Language.TS: return new TsLayout(library)
        case idl.Language.ARKTS: return new ArkTsLayout(library)
    }
    throw new Error(`Unimplemented language "${library.language}"`)
}
