import * as idl from "../idl"
import { IndentedPrinter } from "../IndentedPrinter";
import { Language } from "../util";
import { isBuilderClass, isMaterialized } from "./idl/IdlPeerGeneratorVisitor";
import { IdlPeerLibrary } from "./idl/IdlPeerLibrary";
import { convertDeclaration, convertType, DeclarationConvertor, TypeConvertor } from "./idl/IdlTypeConvertor";
import { createLanguageWriter, LanguageWriter } from "./LanguageWriters";
import { collectCallbacks } from "./printers/EventsPrinter";

interface TestInfo {
    name: string
    fullName?: string
    className?: string
    methodName?: string
    returnTypeName: string
    args: idl.IDLParameter[]
    returnType: idl.IDLType | undefined
    accessChain: string[],
    hasUnion?: boolean
    hasInterface?: boolean,
    materialized?: boolean,
    skipped?: boolean,
}

let refId = 0
const references = new Map<string, idl.IDLCallback>()
function createCallbackReference(parameters: idl.IDLParameter[], returnType: idl.IDLType): idl.IDLReferenceType {
    const name = `callback_${refId++}`
    references.set(name, idl.createCallback(name, parameters, returnType))
    return {
        kind: idl.IDLKind.ReferenceType,
        name: name,
    }   
}
function resolveReference(library: IdlPeerLibrary, type: idl.IDLReferenceType): idl.IDLEntry | undefined{
    return library.resolveTypeReference(type) ?? references.get(type.name) ?? undefined
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
                returnTypeName: typeArgs[1] ?? 'void',
                args: [idl.createParameter("event", idl.createReferenceType(typeArgs[0]))],
                returnType: typeArgs[1] ? idl.createReferenceType(typeArgs[1]) : undefined,
                accessChain: []
            }]
        }
        const decl = resolveReference(this.library, type)
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

    constructor(private library: IdlPeerLibrary) {}    

    convertInterface(node: idl.IDLInterface): TestInfo[] {
        if (idl.hasExtAttribute(node, idl.IDLExtendedAttributes.Component))
            return []
        if (idl.isClass(node) && 1==1) {
            console.log(node.name)
            return []
        }
        if (["TapGestureInterface", 
            "LongPressGestureInterface",
            "PanGestureInterface",
            "PinchGestureInterface",
            "SwipeGestureInterface",
            "RotationGestureInterface",
            "GestureGroupInterface"].includes(node.name))
            return []
        const parentCallbacks: TestInfo[] = []
        for (const parent of node.inheritance.filter(idl.isReferenceType)) {
            parentCallbacks.push(...convertType(this.typeConvertor!, parent))
        }
        return [
            ...parentCallbacks,
            ...node.properties.flatMap(property => {
                return convertType(this.typeConvertor!, property.type).map(it => {
                    it.name = `${node.name}.${property.name}:${it.name}`
                    it.hasInterface = true
                    it.accessChain = [property.name, ...it.accessChain]
                    return it
                })
            }),
            ...node.methods.map<TestInfo>(method => {
                return {
                    name: generateSignature(method.parameters.map(it => this.library.mapType(it.type)), this.library.mapType(method.returnType)),
                    returnTypeName: this.library.mapType(method.returnType),
                    args: method.parameters,
                    returnType: method.returnType,
                    accessChain: [method.name]
                }
            })
        ]
    }
    convertEnum(node: idl.IDLEnum): TestInfo[] {
        return []
    }
    convertTypedef(node: idl.IDLTypedef): TestInfo[] {
        if (node.name == "CustomBuilder")
            return [{
                name: "CustomBuilder",
                returnTypeName: "CustomBuilderRetType",
                args: [],
                returnType: undefined,
                accessChain: []
            }]
        return convertType(this.typeConvertor!, node.type)
    }
    convertCallback(node: idl.IDLCallback): TestInfo[] {
        return [{
            name: generateSignature(node.parameters.map(it => this.library.mapType(it.type)), this.library.mapType(node.returnType)),
            returnTypeName: idl.isVoidType(node.returnType) ? "void" : this.library.mapType(node.returnType),
            args: node.parameters,
            returnType: node.returnType,
            accessChain: []
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
                        it.fullName = generateDescription(prefix + peer.componentName, method.overloadedName, it.name)
                        it.className = peer.componentName
                        it.methodName = method.overloadedName
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
                    it.fullName = generateDescription(prefix + clazz.className, method.overloadedName, it.name)
                    it.className = clazz.className
                    it.methodName = method.overloadedName
                    it.materialized = true
                    return it
                }))
        }
    }
    // for (const file of library.files) {
    //     for (const interf of file.allInterfaces) {
    //         if (library.componentsDeclarations.some(it => it?.interfaceDeclaration?.name === interf.name)
    //             || isMaterialized(interf) || isBuilderClass(interf)
    //             || declConvertor.visitedInterfaces.has(interf.name)) {
    //             continue;
    //         }

    //         infos.push(...convertDeclaration(declConvertor, interf).map(it => {
    //             it.name = generateDescription("", "", it.name)
    //             it.skipped = true
    //             return it
    //         }))
    //     }
    // }

    const collectedCallbacks = new Set<string>()
    function storeCallbackName(info: TestInfo) {
        collectedCallbacks.add(
            info.args.map(it => library.mapType(it.type!)).join("_") + `__${info.returnTypeName}`
        )
    }
    const allCallbacksPrinter = createLanguageWriter(Language.TS)
    for (const info of infos) {
        console.log(
            info.materialized ? "material":info.skipped?"skipped ":"________",
            info.hasInterface ? "interface" : "_________",
            info.hasUnion ? "union":"_____",
            info.fullName,
        )
        storeCallbackName(info)

        const receiverPrinter = createLanguageWriter(Language.TS)
        const modifierPrinter = createLanguageWriter(Language.TS)
        function processCallback(className: string, methodName: string, info: TestInfo, fromArkoala: boolean) {
            const args = [...info.args]
            if (info.returnType && !idl.isVoidType(info.returnType) && !fromArkoala)
                args.push(idl.createParameter("continuation", createCallbackReference(
                    [idl.createParameter("value", info.returnType)], idl.createVoidType())))
            storeCallbackName(info)

            // printer.print(`> ${fromArkoala ? "from_ts " : "from_cpp "} ${info.accessChain.join("_")} ${info.name}`.padEnd(30, " "))
            const firstPrefix = fromArkoala
                ? `${className}Modifier()->${methodName}`
                : `${className}EventsReceiver()->${methodName}`
            const printer = fromArkoala ? modifierPrinter : receiverPrinter
            const returnTypePostfix = (fromArkoala && info.returnType && !idl.isVoidType(info.returnType))
                ? "=>"+library.mapType(info.returnType)
                : ""
            printer.print([firstPrefix, ...info.accessChain].join("_") + `(...)` + returnTypePostfix)
            for(const arg of args) {
                for(const cb of convertType(typeConvertor, arg.type!)) {
                    // printer.pushIndent()
                    // printer.print(`arg ${arg.name}`)
                    processCallback(className, methodName, {
                        ...cb,
                        accessChain: [
                            ...info.accessChain,
                            arg.name,
                            ...cb.accessChain,
                        ]
                    }, !fromArkoala)
                    // printer.popIndent()
                }
            }
        }
        processCallback(
            info.className!,
            info.methodName!, {
            ...info,
            accessChain: [
                // `${info.className}()->${info.methodName}()`,
                ...info.accessChain,
            ]
        }, false)
        // console.log(line)
        allCallbacksPrinter.print(`> ${info.className}.${info.methodName}`)
        allCallbacksPrinter.concat(modifierPrinter)
        allCallbacksPrinter.concat(receiverPrinter)
        // console.log(">>> EventHandler")
        // for (const line of arkoalaPrinter.getOutput()) {
        //     console.log(line)
        // }
        // console.log(">>> Modifier")
        // for (const line of modifiersPrinter.getOutput()) {
        //     console.log(line)
        // }

        console.log()
        console.log()
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
        retStat.set(info.returnTypeName, (retStat.get(info.returnTypeName) ?? 0) + 1)
    }
    console.log('Return type stats:')
    for(const [retType, count] of retStat) {
        console.log(retType.toString().padEnd(45, ' '), count)
    }

    console.log("All callbacks V1")
    for (const callback of collectedCallbacks)
        console.log(callback)

    console.log("All callbacks V2")
    for (const line of allCallbacksPrinter.getOutput())
        console.log(line)
    process.exit(1)
}