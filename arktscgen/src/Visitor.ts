import * as core from "@idlizer/core"
import { IDLEntry, IDLFile, IDLReferenceType } from "@idlizer/core"
import { PeersConstructions } from "./constuctions/PeersConstructions";
import { Config } from "./general/Config";

export type Declarations = Map<string, Map<string, core.IDLEntry>>;
export type Namespace = [string, core.IDLNamespace | undefined]

export class Visitor {
    constructor(decls?: Declarations) {
        if (decls) {
            this.declarations = decls
        }
    }

    onEnterNamespace(node: core.IDLNamespace): boolean { return true }
    onEnterInterface(node: core.IDLInterface): boolean { return true }
    onEnterEnum(node: core.IDLEnum): boolean { return true }
    onEnterMethodDecl(node: core.IDLMethod): boolean { return true }
    onExitNamespace(node: core.IDLNamespace): void {}
    onDone(node: core.IDLFile): void {}

    visit(node: core.IDLNode): void {
        switch (node.kind) {
            case core.IDLKind.File: {
                // This is needed:
                // - to resolve declarations those are used
                // before being declared.
                // - to remove declarations those exist in 'ir' namespace
                // from global namespace as they have a es2panda prefix in
                // the file.
                this.prepare(node)
                this.namespaces = [['', undefined]];
                (node as core.IDLFile).entries.forEach(n => this.visit(n))
                this.onDone(node as core.IDLFile)
                this.printStatistics()
            } break;

            case core.IDLKind.Namespace: {
                const result = node as core.IDLNamespace
                this.namespaces.push([result.name, result])

                const shouldVisitChildren = this.onEnterNamespace(result);
                if (shouldVisitChildren) {
                    result.members.forEach(n => this.visit(n))
                }

                this.onExitNamespace(result);
                this.namespaces.pop()
            } break;

            case core.IDLKind.Interface: {
                const result = node as core.IDLInterface
                const shouldVisitChildren = this.onEnterInterface(result);
                if (shouldVisitChildren) {
                    result.constructors.forEach(n => this.visit(n))
                    result.methods.forEach(n => this.visit(n))
                }
            } break;

            case core.IDLKind.Enum: {
                const result = node as core.IDLEnum
                const shouldVisitChildren = this.onEnterEnum(result);
                if (shouldVisitChildren) {
                    result.elements.forEach(n => this.visit(n))
                }
            } break;

            case core.IDLKind.Method: {
                const result = node as core.IDLMethod
                this.onEnterMethodDecl(result);
            } break;
        }
    }

    private prepare(node: core.IDLNode): void {
        switch (node.kind) {
            case core.IDLKind.File: {
                this.namespaces = [['', undefined]];
                this.declarations.set('', new Map<string, core.IDLEntry>());

                (node as core.IDLFile).entries.forEach(n => this.prepare(n))
                this.printStatistics()
            } break;

            case core.IDLKind.Namespace: {
                const result = node as core.IDLNamespace

                this.namespaces.push([result.name, result])
                this.declarations.get(result.name) ??
                    this.declarations.set(result.name, new Map<string, core.IDLEntry>())

                result.members.forEach(n => this.prepare(n))
                this.namespaces.pop()
            } break;

            case core.IDLKind.Interface: {
                const result = node as core.IDLInterface
                this.registerEntry(result)
            } break;

            case core.IDLKind.Enum: {
                const result = node as core.IDLEnum
                this.registerEntry(result)
            } break;
        }
    }

    public isHeir(ref: core.IDLReferenceType | core.IDLInterface, name: string): boolean {
        if (core.isReferenceType(ref)) {
            const type = this.resolveReference(ref)
            if (!type || !core.isInterface(type)) {
                return false
            }
            ref = type
        }

        const queue: core.IDLInterface[] = [ref]
        while (queue.length) {
            const node = queue.shift()!
            if (node.name == name) {
                return true;
            }

             node.inheritance
                .map(i => this.resolveReference(i))
                .filter(p => p !== undefined && core.isInterface(p))
                .forEach(p => queue.push(p as core.IDLInterface))
        }

        return false
    }

    public isPeer(ref: core.IDLReferenceType | core.IDLInterface): boolean {
        if (ref.name === Config.astNodeCommonAncestor) return false // TODO: is handwritten
        if (ref.name === Config.context) return false // TODO: is handwritten
        if (this.isHeir(ref, Config.astNodeCommonAncestor)) return true
        if (this.isHeir(ref, Config.defaultAncestor)) return true
        // TODO: Nodes that do not have parents have to be in this list
        if (["ValidationInfo", "ArkTsConfig", "Program"].includes(ref.name)) return true // TODO: fix
        //if (core.isInterface(ref)) {
        //    throw `${ref.name}`
        //}
        return false
    }

    public resolveReference(ref: core.IDLReferenceType): core.IDLEntry | undefined {
        const parts = ref.name.split('.', 2) // this.hack_removeDataClassPrefix(ref).split('.', 2)
        const [ns, name] = parts.length == 1 ? ['', parts.at(0)] : parts
        const cns = this.namespaces[this.namespaces.length - 1][0]

        let symbol = this.declarations.get(ns || cns)?.get(name!)
        if (!symbol) {
            // Lookup in global namespace if no namespace was specified
            if (!ns.length) {
                symbol = this.declarations.get('')?.get(name!)
            }
            if (!symbol) {
                this.unresolved.add(ref.name)
                throw `1. resolveReference: ${name} from '${ns}' => ${symbol}`
                //console.log(`1. resolveReference: ${name} from '${ns}' => ${symbol}`);
            }
        }
        return symbol
    }

    private registerEntry(node: core.IDLEntry) : void {
        const name = node.name //this.hack_removeDataClassPrefix(node)
        const ns = this.namespaces[this.namespaces.length - 1]
        const table = this.declarations.get(ns[0])!

        if (table.get(name)) {
            console.warn(`Already has a ${name}(${node.name})`);
        } else {
            table.set(name, node)
            this.hack_removeDuplicateFromGlobalNamespace(ns[0], name)
        }
    }

    private hack_removeDuplicateFromGlobalNamespace(ns: string, name: string): void {
        if (ns == Config.irNamespace) {
            const removed = this.declarations.get('')?.delete(name)
            if (removed) {
                console.warn(`Declaraion of '${name}' was removed from global namespace`)
            }
        }
    }

    private hack_resolveInAliasedNamespace(ns: string, name: string): core.IDLEntry | undefined {
        const ns2 = ns == '' ? Config.irNamespace : (ns == Config.irNamespace ? '' : ns)
        return ns != ns2 ? this.declarations.get(ns2)?.get(name!) : undefined
    }

    private hack_removeDataClassPrefix(node: core.IDLNamedNode): string {
        const prefix = Config.dataClassPrefix
        return node.name.startsWith(prefix) ? node.name.slice(prefix.length) : node.name
    }

    private printStatistics(): void {
        const unresolved = [...this.unresolved.values()].filter(v => {
            const parts = v.split('.')
            const [ns, name] = parts.length == 1 ? ['', parts.at(0)] : parts
            const symbol = this.declarations.get(ns)?.get(name!)
            if (symbol) {
                console.log(`resolved later: ${name} => ${symbol.name}`);
            }
            return symbol === undefined
        })

        console.log(`unresolved:\n${unresolved.join('\n')}`);
        console.log('\nStatistics:');
        console.log(`unresolved: ${unresolved.length}`);
        for (const [k, v] of this.declarations) {
            console.log(`namespace '${k}': ${v.size}`);
        }
    }

    private namespaces: Namespace[]= []
    private declarations: Declarations = new Map()
    private unresolved: Set<string> = new Set<string>()
}

