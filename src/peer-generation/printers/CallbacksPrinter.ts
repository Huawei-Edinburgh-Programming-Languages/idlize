import * as idl from "../../idl"
import { IDLReferenceType, IDLEntry, IDLCallback } from "../../idl";
import { DeclarationDependenciesCollector, TypeDependenciesCollector } from "../idl/IdlDependenciesCollector";
import { isMaterialized } from "../idl/IdlPeerGeneratorVisitor";
import { IdlPeerLibrary } from "../idl/IdlPeerLibrary";

export function generateCallbackName(library: IdlPeerLibrary, args: idl.IDLType[], returnType: idl.IDLType): string {
    return `TESTTESTCallback_${args.concat(returnType).map(it => library.getTypeName(it)).join("_")}`
}

class TypeCallbackCollector extends TypeDependenciesCollector {
    convertTypeReference(type: IDLReferenceType): IDLEntry[] {
        return []
    }
}

class CallbacksCollector extends DeclarationDependenciesCollector {
    constructor(
        readonly library: IdlPeerLibrary,
    ) {
        super(new TypeCallbackCollector(library))
    }

    convertCallback(decl: IDLCallback): IDLEntry[] {
        return [decl]
    }

    convertInterface(decl: idl.IDLInterface): idl.IDLEntry[] {
        const res = super.convertInterface(decl)
        if (!isMaterialized(decl) && !this.library.isComponentDeclaration(decl)) {
            res.push(...decl.methods.map<idl.IDLCallback>(method => {
                const name = decl.kind === idl.IDLKind.AnonymousInterface
                    ? generateCallbackName(this.library, method.parameters.map(it => it.type!), method.returnType)
                    : `TESTTEST123Callback_${decl.name}_${method.name}`
                return idl.createCallback(
                    name,
                    method.parameters,
                    method.returnType
                )
            }))
        }
        return res
    }
}

function collectCallbacksScoped(library: IdlPeerLibrary, entry: idl.IDLEntry): idl.IDLCallback[] {
    let res: idl.IDLCallback[] = []
    if (idl.isCallback(entry)) {
        res.push(entry)
    }
    if ([idl.IDLKind.Interface, idl.IDLKind.AnonymousInterface].includes(entry.kind!)) {
        const decl = entry as idl.IDLInterface
        decl.methods.forEach(method => {
            const name = decl.kind === idl.IDLKind.AnonymousInterface
                    ? generateCallbackName(library, method.parameters.map(it => it.type!), method.returnType)
                    : `TESTTEST123Callback_${decl.name}_${method.name}`
            res.push(idl.createCallback(
                name,
                method.parameters,
                method.returnType,
            ))
        })
    }
    // if (idl.isAnonymousInterface(entry)) {
    //     entry.methods.forEach(method => {
    //         res.push(idl.createCallback(
    //             generateCallbackName(library, method.parameters.map(it => it.type!), method.returnType),
    //             method.parameters,
    //             method.returnType,
    //         ))
    //     })
    // }
    if (entry.scope)
        res.push(...entry.scope.flatMap(it => collectCallbacksScoped(library, it)))
    return res
}

export function printCallbacks(library: IdlPeerLibrary): string {
    const collector = new CallbacksCollector(library)
    const callbacks: idl.IDLCallback[] = []
    const testnames = new Set<string>()
    for (const file of library.files) {
        for (const decl of file.entries) {
            const collectedCallbacks = collectCallbacksScoped(library, decl) as idl.IDLCallback[]
            callbacks.push(...collectedCallbacks)
        }
    }
    const callbacksUniq = [...(new Set(callbacks.map(it => it.name))), ...testnames]
    return callbacksUniq.map(it => it).join("\n")
}