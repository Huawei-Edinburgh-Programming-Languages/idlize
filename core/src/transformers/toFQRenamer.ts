import { ReferenceResolver } from "../peer-generation/ReferenceResolver"
import { IDLIdentityTransformer } from "../transformer"
import * as idl from "../idl"

export class FQReferenceMaker extends IDLIdentityTransformer {
    constructor(
        private resolver: ReferenceResolver
    ) { super() }

    private diagnosticsForType(type: idl.IDLReferenceType) {
        const names: string[] = []
        let current: idl.IDLNode | undefined = type
        while (current) {
            if (idl.isFile(current)) {
                names.push(current.fileName ?? '()')
            } else if (idl.isNamedNode(current)) {
                names.push(current.name)
            } else {
                names.push('()')
            }
            current = current.parent
        }
        console.error(`NOT FOUND REFERENCE "${type.name}" (${names.join(' => ')})`)
    }

    visitReferenceType(node: idl.IDLReferenceType): idl.IDLReferenceType {
        const transformed = super.visitReferenceType(node)
        const declaration = this.resolver.resolveTypeReference(node)
        if (!declaration) {
            this.diagnosticsForType(node)
            return node
        }
        transformed.name = idl.getFQName(declaration)
        return transformed
    }
}