import * as idl from "./idl"
import { ReferenceResolver } from "./peer-generation/ReferenceResolver"

function equalsClause(a: string[], b: string[]): boolean {
    return a.length === b.length && a.every((it, index) => b[index] === it)
}

function iterateChildren(node: idl.IDLNode): idl.IDLNode[] {
    const children: idl.IDLNode[] = []
    idl.forEachChild(node, (child) => {
        children.push(child)
    })
    return children
}

function mutateRemoveEntries(node: idl.IDLNode, namesToRemove: Set<string>): void {
    if (idl.isFile(node)) {
        node.entries = node.entries.filter(it => !namesToRemove.has(it.name))
        node.entries.forEach(it => mutateRemoveEntries(it, namesToRemove))
    }
    if (idl.isNamespace(node)) {
        node.members = node.members.filter(it => !namesToRemove.has(it.name))
        node.members.forEach(it => mutateRemoveEntries(it, namesToRemove))
    }
}

export function optimizeSynthetics(files: idl.IDLFile[], resolver: ReferenceResolver, syntheticPackage: string[]): { syntheticFile: idl.IDLFile, mutatedFiles: idl.IDLFile[] } {
    let nameToSynthetics = new Map<string, idl.IDLEntry[]>()
    for (const file of files) {
        idl.forEachChild(file, (node) => {
            if (idl.isEntry(node) && idl.isSyntheticEntry(node)) {
                if (!nameToSynthetics.has(node.name))
                    nameToSynthetics.set(node.name, [])
                nameToSynthetics.get(node.name)!.push(node)
            }
        })
    }

    // TODO validate that same named synthetics has completely same structure

    const syntheticImports: idl.IDLImport[] = []
    const syntheticEntries: idl.IDLEntry[] = []
    const nameToSynthetic = new Map<string, idl.IDLEntry>(Array.from(nameToSynthetics.entries())
        .filter(it => it[1].length > 1) // keep synthetics with only one declaration
        .map(it => [it[0], it[1][0]]))
    for (const [syntheticName, synthetic] of nameToSynthetic.entries()) {
        const syntheticClone = idl.clone(synthetic)
        const syntheticCloneChildren = iterateChildren(syntheticClone)
        iterateChildren(synthetic).forEach((child, index) => {
            if (idl.isReferenceType(child)) {
                const cloneChild = syntheticCloneChildren[index] as idl.IDLReferenceType
                const resolved = resolver.resolveTypeReference(child)
                if (!resolved)
                    throw new Error(`Synthetic entry has unresolved dependencies: ${idl.getFQName(synthetic)}`)
                const resolvedFQN = idl.getFQName(resolved).split('.')
                const resolvedNamespace = idl.getNamespacesPathFor(resolved).at(-1)
                let resolvedImportClause: string[]
                let resolvedRelatireClause: string[]
                if (resolvedNamespace) {
                    resolvedImportClause = idl.getFQName(resolvedNamespace).split('.')
                    resolvedRelatireClause = resolvedFQN.slice(resolvedImportClause.length - 1)
                } else {
                    resolvedImportClause = resolvedFQN
                    resolvedRelatireClause = [resolvedFQN.at(-1)!]
                }
                if (!syntheticImports.some(it => equalsClause(it.clause, resolvedImportClause)))
                    syntheticImports.push(idl.createImport(resolvedImportClause, resolvedRelatireClause[0]))
                cloneChild.name = resolvedRelatireClause.join('.')
            }
        })
        syntheticEntries.push(syntheticClone)
    }

    const mutatedFiles = files.map(idl.clone)
    const syntheticNames = new Set(nameToSynthetic.keys())
    mutatedFiles.forEach((file, index) => {
        if (files[index].fileName?.includes("richEditor"))
            console.log("AAA")
        const requiredSynthetics = new Set<string>()
        idl.forEachChild(file, (node) => {
            if (idl.isEntry(node) && syntheticNames.has(node.name)) {
                requiredSynthetics.add(node.name)
            }
        })
        mutateRemoveEntries(file, syntheticNames)
        requiredSynthetics.forEach(requiredSynthetic => {
            if (!file.entries.some(entry => idl.isImport(entry) && entry.name === requiredSynthetic))
                file.entries.splice(0, 0, idl.createImport([...syntheticPackage, requiredSynthetic], requiredSynthetic))
        })
    })
    const syntheticFile = idl.createFile(
        [...syntheticImports, ...syntheticEntries],
        undefined,
        syntheticPackage,
    )
    return {
        mutatedFiles,
        syntheticFile,
    }
}