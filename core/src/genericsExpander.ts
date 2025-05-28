import { ReferenceResolver } from "./peer-generation/ReferenceResolver";
import * as idl from './idl'



export function expandGenerics(resolver: ReferenceResolver, ref: idl.IDLReferenceType): idl.IDLEntry | undefined {
    if (!ref.typeArguments?.length)
        return undefined
    const resolved = resolver.resolveTypeReference(ref)
    if (!resolved)
        throw new Error("Target entry was not found while expanding generics")
    if (idl.isInterface(resolved)) {
        resolved.typeParameters
    }
}