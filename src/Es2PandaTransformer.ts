import { IDLContainerType, IDLInterface, IDLInterfaceSubkind, IDLKind, IDLReferenceType, IDLType, createConstructor, createContainerType, createInterface, forEachChild, isInterface, isModuleType, isParameter, isReferenceType, isType, toIDLString } from "./idl"
import { isMethod, printMethod } from "./idl"
import { PeerLibrary } from "./peer-generation/PeerLibrary"

let classes = new Map<string, IDLInterface>()

export class Es2PandaTransformer {
    static transform(idlLibrary: PeerLibrary) {

        const es2pandaFile = idlLibrary.files[0]
        const es2pandaInterface = es2pandaFile.entries[0]

        if (!isInterface(es2pandaInterface)) {
            throw new Error(`Expected a single es2panda module, got ${IDLKind[es2pandaInterface.kind]} ${es2pandaInterface.name}`)
        }

        idlLibrary.files.forEach(
            file => file.entries.forEach(
                entry => forEachChild(entry, node => {
                    if (isMethod(node)) {
                        if (node.name.startsWith("Create")) {
                            lookupInterface(node.name.substring("Create".length))
                        }
                    }
                })
            )
        )

        classes = new Map(
            Array.from(classes)
                .sort((a:any, b:any) =>
                    a[0].localeCompare(b[0])
                )
        )

        idlLibrary.files.forEach(
            file => file.entries.forEach(entry => {
                forEachChild(entry, node => {
                    if (isMethod(node)) {
                        const clazzName = isConstructor(node.name)
                        if (clazzName) {
                            lookupInterface(clazzName).constructors.push(
                                createConstructor(
                                    node.parameters,
                                    undefined
                                )
                            )
                        }
                        const clazzName2 = className(node.name)
                        if (clazzName2) {
                            node.name = methodName(clazzName2, node.name)!
                            lookupInterface(clazzName2).methods.push(
                                node
                            )
                        }
                    }
                })
            })
        )

        es2pandaFile.entries.push(...Array.from(classes.values()).flat())

        idlLibrary.files.forEach(
            file => file.entries.forEach(
                entry => forEachChild(entry, node => {
                    if (isParameter(node)) {
                        const type = node.type
                        if (type) {
                            node.type = processType(type)
                        }
                    }
                    if (isMethod(node)) {
                        const type = node.returnType
                        if (type) {
                            node.returnType = processType(type)
                        }

                        node.extendedAttributes = node.extendedAttributes?.filter(it =>
                            (it.name != "ptr_1") && (it.name != "ptr_2") && (it.name != "constant")
                        )

                        if (node.parameters && node.parameters.length > 0) {
                            if (node.parameters[node.parameters.length-1].name == "returnTypeLen") {
                                node.parameters.pop()
                            }
                        }
                    }
                })
            )
        )

        idlLibrary.files.forEach(
            file => file.entries.forEach(entry => {
                forEachChild(entry, node => {
                    if (isReferenceType(node) && node.name.startsWith("es2panda_")) {
                        node.name = node.name.substring("es2panda_".length)
                    }
                })
            })
        )

        // Drop the original interface
        es2pandaFile.entries.shift()

        idlLibrary.files.forEach(
            file => console.log(toIDLString(file.entries, {}))
        )
    }
}

function isConstructor(name: string): string|undefined {
    if (name.startsWith("Create")) {
        return name.substring("Create".length)
    }
    return undefined
}

function className(name: string): string|undefined {
    let found = undefined
    classes.forEach((value, clazz) => {
        if (name.startsWith(clazz)) {
            found = clazz
        }
    })
    return found
}

function methodName(clazzName: string, name: string): string|undefined {
    return name.substring(clazzName.length)
}

function lookupInterface(name: string): IDLInterface {
    if (classes.has(name)) return classes.get(name)!

    const iface = createInterface(
        name,
        IDLInterfaceSubkind.Interface,
        [],
        [],
        [],
        [],
        [],
        [],
        []
    )
    classes.set(name, iface)
    return iface
}

function processType(type: IDLType): IDLType {
    if (isReferenceType(type)) {
        if (type.extendedAttributes?.find(it => it.name == "ptr_1")) {
            if (type.name == "char") {
                type.name = "String"
            } else if (!type.name.startsWith("es2panda_")) {
                type.name = `${type.name}Ptr`
            }
            type.extendedAttributes = type.extendedAttributes?.filter(it => it.name != "ptr_1")

            return processType(type)
        }
        if (type.extendedAttributes?.find(it => it.name == "ptr_2")) {
            type.extendedAttributes = type.extendedAttributes?.filter(it => it.name != "ptr_2")

            return processType(createContainerType('sequence', [type]))
        }
        if (type.extendedAttributes?.find(it => it.name == "constant")) {
            type.extendedAttributes = type.extendedAttributes?.filter(it => it.name != "constant")
            //type.name = `${type.name}Const`

            return processType(type)
        }
    }
    return type
}
