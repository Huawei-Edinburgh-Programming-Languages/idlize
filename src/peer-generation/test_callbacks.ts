import * as idl from "../idl"
import { isBuilderClass, isMaterialized } from "./idl/IdlPeerGeneratorVisitor";
import { IdlPeerLibrary } from "./idl/IdlPeerLibrary";
import { convertDeclaration, convertType, DeclarationConvertor, TypeConvertor } from "./idl/IdlTypeConvertor";

interface TestInfo {
    name: string
    returnType: string
    hasUnion?: boolean
    hasInterface?: boolean,
    materialized?: boolean,
    skipped?: boolean,
}

function generateSignature(types: string[], returnType: string | undefined) {
    return `(${types.join(",")})=>${returnType ?? 'void'}`
}

class TestTypeConvertor implements TypeConvertor<TestInfo[]> {
    declConvertor: TestDeclConvertor | undefined

    constructor(private library: IdlPeerLibrary) {}    

    convertUnion(type: idl.IDLUnionType): TestInfo[] {
        return type.types.flatMap((type) => {
            return convertType(this, type).map(it => {
                it.name = `${this.library.mapType(type)}:${it.name}`
                it.hasUnion = true
                return it
            })
        })
    }
    convertContainer(type: idl.IDLContainerType): TestInfo[] {
        return type.elementType.flatMap(it => convertType(this, it))
    }
    convertEnum(type: idl.IDLEnumType): TestInfo[] {
        return []
    }
    convertImport(type: idl.IDLReferenceType, importClause: string): TestInfo[] {
        return []
    }
    public visited: (idl.IDLEntry | undefined)[] = []
    convertTypeReference(type: idl.IDLReferenceType): TestInfo[] {
        if (type.name === "Callback") {
            const typeArgs = idl.getExtAttribute(type, idl.IDLExtendedAttributes.TypeArguments)!.split(",")
            return [{
                name: generateSignature([typeArgs[0]], typeArgs[1]),
                returnType: typeArgs[1] ?? 'void'
            }]
        }
        const decl = this.library.resolveTypeReference(type)
        if (!this.visited.includes(decl)) {
            this.visited.push(decl)
            const result = decl ? convertDeclaration(this.declConvertor!, decl) : []
            this.visited.pop()
            return result
        }
        return []
    }
    convertTypeParameter(type: idl.IDLTypeParameterType): TestInfo[] {
        return []
    }
    convertPrimitiveType(type: idl.IDLPrimitiveType): TestInfo[] {
        return []
    }
}

class TestDeclConvertor implements DeclarationConvertor<TestInfo[]> {
    typeConvertor: TestTypeConvertor | undefined
    readonly visitedInterfaces: Set<string> = new Set()

    constructor(private library: IdlPeerLibrary) {}    

    convertInterface(node: idl.IDLInterface): TestInfo[] {
        this.visitedInterfaces.add(node.name)
        return node.properties.flatMap(property => {
            return convertType(this.typeConvertor!, property.type).map(it => {
                it.name = `${node.name}.${property.name}:${it.name}`
                it.hasInterface = true
                return it
            })
        })
    }
    convertEnum(node: idl.IDLEnum): TestInfo[] {
        return []
    }
    convertTypedef(node: idl.IDLTypedef): TestInfo[] {
        if (node.name == "CustomBuilder")
            return [{
                name: "CustomBuilder",
                returnType: "CustomBuilderRetType"
            }]
        return convertType(this.typeConvertor!, node.type)
    }
    convertCallback(node: idl.IDLCallback): TestInfo[] {
        return [{
            name: generateSignature(node.parameters.map(it => this.library.mapType(it.type)), this.library.mapType(node.returnType)),
            returnType: idl.isVoidType(node.returnType) ? "void" : this.library.mapType(node.returnType)
        }]
    }
}

function generateDescription(classname: string, methodName: string, callbackName: string) {
    return `${classname}:${methodName}`.padEnd(40, ' ') + ' ' + callbackName
}

export function TestCallbacks(library: IdlPeerLibrary) {
    let infos: TestInfo[] = []
    const typeConvertor = new TestTypeConvertor(library)
    const declConvertor = new TestDeclConvertor(library)
    typeConvertor.declConvertor = declConvertor
    declConvertor.typeConvertor = typeConvertor
    let prevName = ""
    for (const file of library.files) {
        for (const peer of file.peers.values()) {
            for (const method of peer.methods) {
                infos.push(...method.declarationTargets
                    .flatMap(it => idl.isCallback(it) ? convertDeclaration(declConvertor, it) : convertType(typeConvertor, it))
                    .map(it => {
                        const newName = peer.componentName + method.overloadedName
                        let prefix = ". "
                        if (newName ==prevName)
                            prefix = "| "
                        prevName=newName
                        it.name = generateDescription(prefix + peer.componentName, method.overloadedName, it.name)
                        return it
                    }))
            }
        }
    }
    for (const clazz of library.materializedClasses.values()) {
        for (const method of clazz.methods) {
            infos.push(...method.idlTargets
                .flatMap(it => idl.isCallback(it) ? convertDeclaration(declConvertor, it) : convertType(typeConvertor, it))
                .map(it => {
                    const newName = clazz.className + method.overloadedName
                    let prefix = ". "
                    if (newName ==prevName)
                        prefix = "| "
                    prevName=newName
                    it.name = generateDescription(prefix + clazz.className, method.overloadedName, it.name)
                    it.materialized = true
                    return it
                }))
        }
    }
    for (const file of library.files) {
        for (const interf of file.allInterfaces) {
            if (library.componentsDeclarations.some(it => it?.interfaceDeclaration?.name === interf.name)
                || isMaterialized(interf) || isBuilderClass(interf)
                || declConvertor.visitedInterfaces.has(interf.name)) {
                continue;
            }

            infos.push(...convertDeclaration(declConvertor, interf).map(it => {
                it.name = generateDescription("", "", it.name)
                it.skipped = true
                return it
            }))
        }
    }
    for (const info of infos) {
        console.log(
            info.materialized ? "material":info.skipped?"skipped ":"________",
            info.hasInterface ? "interface" : "_________",
            info.hasUnion ? "union":"_____",
            info.name,
        )
    }
    console.log(
        infos.filter(it => it.materialized).length.toString().padEnd(8,'_'),
        infos.filter(it => it.hasInterface).length.toString().padEnd(9,'_'),
        infos.filter(it => it.hasUnion).length.toString().padEnd(5,'_'),
    )
    console.log("Total", infos.length)
    console.log()
    const retStat = new Map<string, number>()
    for(const info of infos) {
        retStat.set(info.returnType, (retStat.get(info.returnType) ?? 0) + 1)
    }
    console.log('Return type stats:')
    for(const [retType, count] of retStat) {
        console.log(retType.toString().padEnd(45, ' '), count)
    }
    process.exit(1)
}