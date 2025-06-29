import * as core from "@idlizer/core"
import { IDLEntry, IDLFile } from "@idlizer/core"

type NS = [string, number];

export abstract class IVisitor {
    onEnterNamespace(node: core.IDLNamespace): boolean { return true }
    onEnterInterface(node: core.IDLInterface): boolean { return true }
    onEnterMethodDecl(node: core.IDLMethod): boolean { return true }

    onExitNamespace(node: core.IDLNamespace): void {}

    visit(node: core.IDLNode): void {
        switch (node.kind) {
            case core.IDLKind.File: {
                (node as core.IDLFile).entries.forEach(n => this.visit(n))
            } break;

            case core.IDLKind.Namespace: {
                const result = node as core.IDLNamespace
                const shouldVisitChildren = this.onEnterNamespace(result);

                this.namespaces.push([result.name, result])
                this.declarations.get(result.name) ??
                    this.declarations.set(result.name, new Map<string, core.IDLEntry>())

                if (shouldVisitChildren) {
                    result.members.forEach(n => this.visit(n))
                }

                this.onExitNamespace(result);
                this.namespaces.pop()
            } break;

            case core.IDLKind.Interface: {
                const result = node as core.IDLInterface
                const shouldVisitChildren = this.onEnterInterface(result);

                this.registerInterface(result)

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
        console.log(`resolveReference: ${ref.name}`);
        return undefined
    }

    private registerInterface(node: core.IDLInterface) : void {
        const prefix = 'es2panda_'
        const name = node.name.startsWith(prefix) ? node.name.slice(prefix.length) : node.name
        const prev = this.declarations.get(name)

        if (prev) {
            console.log(`Already has a ${name}(${node.name})`);
        } else {
            const [ns, _] = this.namespaces[0]
            this.declarations.get(ns)!.set(name, node)
        }
    }

    protected namespaces: [string, core.IDLNamespace | undefined][]= [['', undefined]]
    protected declarations = new Map<string, Map<string, core.IDLEntry>>([['', new Map<string, core.IDLEntry>()]])
}

