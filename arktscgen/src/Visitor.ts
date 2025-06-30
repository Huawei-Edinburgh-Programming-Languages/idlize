import * as core from "@idlizer/core"
import { IDLEntry, IDLFile } from "@idlizer/core"

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
    onEnterMethodDecl(node: core.IDLMethod): boolean { return true }

    onExitNamespace(node: core.IDLNamespace): void {}

    visit(node: core.IDLNode): void {
        switch (node.kind) {
            case core.IDLKind.File: {
                this.namespaces = [["", undefined]];
                this.declarations.set('', new Map<string, core.IDLEntry>());

                (node as core.IDLFile).entries.forEach(n => this.visit(n))

                const decls = new Set<string>()
                for (let [v, m] of this.declarations.entries()) {
                    console.log(`in map ${v}: ${m.size}`);
                    [...m.keys()].forEach(k => decls.add(v + '.' + k))
                }

                const str = [...this.unresolved.values()].filter(v => {
                    const parts = v.split('.')
                    const [ns, name] = parts.length == 1 ? ['', parts.at(0)] : parts
                    return this.declarations.get(ns)?.has(name!) !== undefined
                }).join('\n')
                console.log(`unresolved: ${str}`);
                console.log(`resolved: ${[...decls.keys()].join('\n')}`);

            } break;

            case core.IDLKind.Namespace: {
                const result = node as core.IDLNamespace

                this.namespaces.push([result.name, result])
                this.declarations.get(result.name) ??
                    this.declarations.set(result.name, new Map<string, core.IDLEntry>())

                const shouldVisitChildren = this.onEnterNamespace(result);
                if (shouldVisitChildren) {
                    result.members.forEach(n => this.visit(n))
                }

                this.onExitNamespace(result);
                this.namespaces.pop()
            } break;

            case core.IDLKind.Interface: {
                const result = node as core.IDLInterface

                this.registerInterface(result)
                const shouldVisitChildren = this.onEnterInterface(result);
                if (shouldVisitChildren) {
                    result.constructors.forEach(n => this.visit(n))
                    result.methods.forEach(n => this.visit(n))
                }
            } break;

            case core.IDLKind.Method: {
                const result = node as core.IDLMethod
                this.onEnterMethodDecl(result);
            } break;
        }
    }

    protected resolveReference(ref: core.IDLReferenceType): core.IDLEntry | undefined {
        const parts = ref.name.split('.')
        const [ns, name] = parts.length == 1 ? ['', parts.at(0)] : parts

        const table = this.declarations.get(ns)
        const symbol = table?.get(name!)
        if (!symbol) {
            console.log(`resolveReference: ${name} from '${ns}' => ${symbol}`);
            this.unresolved.add(ref.name)
        }
        return symbol //?? core.createInterface(ref.name, core.IDLInterfaceSubkind.Class)
    }

    private registerInterface(node: core.IDLInterface) : void {
        const prefix = 'es2panda_'
        const name = node.name.startsWith(prefix) ? node.name.slice(prefix.length) : node.name
        const prev = this.declarations.get(name)

        if (prev) {
            console.log(`Already has a ${name}(${node.name})`);
        } else {
            const ns = this.namespaces[this.namespaces.length - 1]
            console.log(`Registering a '${ns}'.${name}`);
            for (let [v, m] of this.declarations.entries()) {
                console.log(`in map ${v}: ${m.size}`);
            }
            this.declarations.get(ns[0])!.set(name, node)
        }
    }

    private namespaces: Namespace[]= []
    public declarations: Declarations = new Map()
    public unresolved: Set<string> = new Set<string>()
}

