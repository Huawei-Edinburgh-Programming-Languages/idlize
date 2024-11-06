import * as idl from "../idl";
import { IdlPeerLibrary } from "./idl/IdlPeerLibrary";

export interface ReferenceResolver {
    resolveTypeReference(type: idl.IDLReferenceType, entries?: idl.IDLEntry[]): idl.IDLEntry | undefined
    toDeclaration(type: idl.IDLType | idl.IDLCallback): idl.IDLNode
}

export function createEmptyReferenceResolver(): ReferenceResolver {
    return {
        resolveTypeReference() {
            return undefined
        },
        toDeclaration(type) {
            return type
        }
    }
}

export function getReferenceResolver(library: IdlPeerLibrary): ReferenceResolver {
    return library
}
