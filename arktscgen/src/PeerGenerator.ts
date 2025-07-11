import * as core from "@idlizer/core"
import { Config } from "./general/Config"
import { Body, Importer, Resolver } from "./general/types"
import { isCreateOrUpdate, isDataClass, isReal, mangleIfKeyword, peerMethod } from "./general/common"
import { flattenType, nodeNamespace, nodeType, parent } from "./utils/idl";
import { InteropConstructions } from "./constuctions/InteropConstructions"
import { PeersConstructions } from "./constuctions/PeersConstructions"

export class PeerGenerator {
    constructor(
        public resolver: Resolver,
        public converter: core.IdlNameConvertor,
        public importer: Importer,
        public config: Config
    ) {
    }

    public writeClass(iface: core.IDLInterface, writer: core.LanguageWriter, written: (body: Body) => void) {
        const parentName = (node: core.IDLInterface) => {
            return this.importer.importPeer(parent(node) ?? Config.defaultAncestor)
        }

        writer.writeClass(
            iface.name,
            () => {
                this.writeBody(iface, writer, written)
            },
            parentName(iface)
        )

        if (!isDataClass(iface)) {
            this.writeTypeGuard(iface, writer)
        }

        if (isReal(iface)) {
            this.writeAddToNodeMap(iface, writer)
        }
    }

    private writeBody(iface: core.IDLInterface, writer: core.LanguageWriter, written: (body: Body) => void) {
        const methods = PeerGenerator.filterOutOverloads(
            PeerGenerator.splitMethods(iface, this.config), this.converter
        )

        // Make declarations. It is IMPORTANT to not modify its signatures here bc
        // we could not generate the correct binding calls.
        // A signature can be modified in generate methods only!

        const hack_params = (method: core.IDLMethod) => {
            // We can make this modifications before generation of binding call bc
            // context param is not used and length param is re-injected during generation
            // of native calls.
            return PeerGenerator.hack_makeNullableParameters(
                PeerGenerator.ts_removeArrayLengthParam(
                    PeerGenerator.hack_removeContextParam(method.parameters)
                ),
                this.resolver
            )
        }
        const hack_returnValue = (method: core.Method) => {
            method.signature.returnType =
                PeerGenerator.hack_makeNullable(method.signature.returnType, this.resolver)
        }

        const body = {
            creates: methods.Create
                ?.map(m => PeerGenerator.makeMethod(m, hack_params(m), [core.MethodModifier.STATIC])),
            updates: methods.Update
                ?.map(m => PeerGenerator.makeMethod(m, hack_params(m), [core.MethodModifier.STATIC])),
            getters: methods.Getter
                ?.map(m => PeerGenerator.makeMethod(m, hack_params(m), [core.MethodModifier.GETTER])),
            regular: methods.Regular
                ?.map(m => PeerGenerator.makeMethod(m, hack_params(m))) ?? [],
        }

        body.getters.forEach(hack_returnValue)
        body.regular.forEach(hack_returnValue)

        // 1. Writing ctors

        this.writeCtorImpl(iface, writer)

        // 2. Writing create and update methods

        for (const m of body.creates.concat(body.updates)) {
            this.writeCreateImpl(iface, m, writer)
        }

        // 3. Writing getters and regular

        const inFileOrder = PeerGenerator.ts_collapseDuplicates(
            PeerGenerator.filterOutIngnored(iface, this.config)
                .filter(m => !isCreateOrUpdate(m.name))
        ).map(m => m.name)

        let getIndex = 0, regIndex = 0
        for (const name of inFileOrder) {
            if (name === body.getters[getIndex]?.name) {
                this.writeGetterImpl(iface, body.getters[getIndex]!, writer)
                getIndex += 1
            } else if (name === body.regular[regIndex]?.name) {
                this.writeRegularImpl(iface, body.regular[regIndex]!, writer)
                regIndex += 1
            } else {
                console.warn(`Unknown method ${name}`);
            }
        }

        writer.writeProperty(PeersConstructions.brand(iface.name),
             core.IDLUndefinedType, [core.FieldModifier.PROTECTED, core.FieldModifier.READONLY]
        )

        // 4. Provide probably modified declarations to other generators

        written(body as Body)
    }

    // write/make methods were copy-pasted from PeerPrinter and modified to work with other types and
    // resolver

    private writeCreateImpl(iface: core.IDLInterface, method: core.Method, writer: core.LanguageWriter): void {
        const nativeCall = writer.makeFunctionCall(
            writer.makeString(
                PeersConstructions.callBinding(
                    iface.name,
                    method.name,
                    nodeNamespace(iface)
                )
            ),
            this.makeBindingArguments(method).map(p => writer.makeString(p)) ?? []
        )
        const newExpr = writer.makeNewObject(iface.name, [nativeCall])

        // Modify method name and signature (if needed)

        method.name = PeersConstructions.createOrUpdate(iface.name, method.name)

        // TODO: This was requested by Igor - add args to create/update methods and set/call corresponding
        // props/setters. Factory.ts needs updated declarations.
        //const extraArgs = PeerGenerator.hack_extraArgs(iface)
        //method.signature.args.push()
        //const extraStatements: core.LanguageStatement[] = []

        writer.writeMethodImplementation(method, () => {
            if (isReal(iface)) {
                const varName = 'result'
                writer.writeStatements(
                    writer.makeAssign(
                        varName, core.createReferenceType(iface.name), newExpr, true
                    ),
                    writer.makeStatement(
                        writer.makeMethodCall(varName, PeersConstructions.setChildrenParentPtrMethod, [])
                    ),
                    // Hacks
                    //...extraStatements,
                    writer.makeReturn(
                        writer.makeString(varName)
                    ),
                )
            } else {
                writer.writeStatement(
                    writer.makeReturn(newExpr)
                )
            }
        })
    }

    private writeCtorImpl(iface: core.IDLInterface, /*method: core.Method,*/ writer: core.LanguageWriter): void {
        writer.writeConstructorImplementation(
            iface.name,
            new core.MethodSignature(
                core.IDLVoidType,
                [core.IDLPointerType],
                undefined,
                undefined,
                undefined,
                [PeersConstructions.pointerParameter]
            ),
            () => {
                if (isReal(iface)) {
                    writer.writeExpressionStatement(
                        writer.makeFunctionCall(
                            PeersConstructions.validatePeer,
                            [
                                writer.makeString(PeersConstructions.pointerParameter),
                                writer.makeString(
                                    nodeType(iface)
                                        ?? core.throwException(`missing attribute node type: ${iface.name}`)
                                )
                            ]
                        )
                    )
                }
                writer.writeExpressionStatements(
                    writer.makeFunctionCall(
                        PeersConstructions.super,
                        [ writer.makeString(PeersConstructions.pointerParameter) ]
                    )
                )
            }
        ) // writeConstructor
    }

    private writeGetterImpl(iface: core.IDLInterface, method: core.Method, writer: core.LanguageWriter): void {
        const nativeCall = this.makeWrappedBindingCall(iface, method, writer, this.resolver)

        // Modify method name and signature (if needed)
        method.name = peerMethod(method.name)

        writer.writeMethodImplementation(method, () => {
            writer.writeStatement(writer.makeReturn(nativeCall))
        })
    }

    private writeRegularImpl(iface: core.IDLInterface, method: core.Method, writer: core.LanguageWriter): void {
        const nativeCall = this.makeWrappedBindingCall(iface, method, writer, this.resolver)

        // Modify method name and signature (if needed)

        method.name = peerMethod(method.name)
        method.signature.returnType = flattenType(PeersConstructions.this.type)

        writer.writeExpressionStatement(
            writer.makeString(`/** @deprecated */`)
        )
        writer.writeMethodImplementation(method, () => {
            writer.writeExpressionStatement(nativeCall)
            writer.writeStatement(
                writer.makeReturn(writer.makeString(PeersConstructions.this.name))
            )
        })
    }

    private writeTypeGuard(iface: core.IDLInterface, writer: core.LanguageWriter): void {
        writer.writeFunctionImplementation(
            PeersConstructions.typeGuard.name(iface.name),
            new core.MethodSignature(
                core.createReferenceType(PeersConstructions.typeGuard.returnType(iface.name)),
                [core.createReferenceType(PeersConstructions.typeGuard.parameter.type)],
                undefined, undefined, undefined,
                [PeersConstructions.typeGuard.parameter.name]
            ),
            () => {
                writer.writeStatement(
                    writer.makeReturn(writer.makeString(PeersConstructions.typeGuard.body(iface.name)))
                )
            }
        )
    }

    private writeAddToNodeMap(iface: core.IDLInterface, writer: core.LanguageWriter): void {
        const value = nodeType(iface)
        const idlEnum = this.resolver.resolveTypeReference(
            core.createReferenceType(Config.nodeTypeAttribute)
        )
        const enumValue = value && idlEnum && core.isEnum(idlEnum) &&
            idlEnum?.elements
                .find(e => e.initializer?.toString() === value)
                ?.name
        if (enumValue === undefined) {
            return
        }
        const qualified = `${this.importer.importEnum(Config.nodeTypeAttribute)}.${enumValue}`
        writer.writeExpressionStatements(
            writer.makeString(`if (!nodeByType.has(${qualified})) {`),
            writer.makeString(`    nodeByType.set(${qualified}, (peer: KNativePointer) => new ${iface.name}(peer))`),
            writer.makeString(`}`)
        )
    }

    public static splitMethods(iface: core.IDLInterface, config?: Config): Record<string, core.IDLMethod[]> {
        const methodTypes = ['Create', 'Update', 'Getter', 'Regular']
        const groupFn = (method: core.IDLMethod): string => {
            const [p1, p2, p3, p4] = methodTypes
            // checking return value to match the iface name needs some hacks
            if (isCreateOrUpdate(method.name)) {
                return method.name.startsWith(p1) ? p1 : p2

            } else if (PeerGenerator.isGetter(method)) {
                return p3
            }
            return p4
        }

        const methods = this.filterOutIngnored(iface, config)
            .reduce((acc, method) => {
                (acc[groupFn(method)] ??= []).push(method)
                return acc
            }, {} as Record<string, core.IDLMethod[]>);

        return methods
    }

    public static filterOutIngnored(iface: core.IDLInterface, config?: Config): core.IDLMethod[] {
        //return iface.methods.filter(m => config?.isIgnored(iface.name, m.name) !== true ?? true)
        return iface.methods
    }

    public static filterOutOverloads(
        methods: Record<string, core.IDLMethod[]>, converter: core.IdlNameConvertor): Record<string, core.IDLMethod[]> {
        methods.Create = this.ts_collapseOverloads(methods.Create ?? [], converter)
        methods.Update = this.ts_collapseOverloads(methods.Update ?? [], converter)
        methods.Getter = this.ts_collapseDuplicates(methods.Getter ?? [])
        methods.Regular = methods.Regular ?? []

        //const count = Object.values(methods).reduce((acc, v) => acc + v.length, 0)
        //console.log(`Methods ${count} out of ${iface.methods.length}`);
        return methods
    }

    public static sortInDeclarationOrder(methods: core.Method[], iface: core.IDLInterface): core.Method[] {
        const names = iface.methods.map(m => m.name)
        return methods.sort((a,b) => names.indexOf(a.name) - names.indexOf(b.name))
    }

    public static ts_collapseDuplicates(methods: readonly core.IDLMethod[]): core.IDLMethod[] {
        // Prefer non-const methods for native calls - from old filter.
        const isConst = (str: string) => str.endsWith(Config.constPostfix)
        const nonConst = new Set<string>()

        methods.forEach((m) => {
            if (!isConst(m.name)) {
                nonConst.add(peerMethod(m.name))
            }
        })

        const names = new Set<string>()
        // Keep input order
        return methods.filter((m) => {
            const str = peerMethod(m.name)
            if (nonConst.has(str) && isConst(m.name)) {
                return false
            }
            return !names.has(str) && (names.add(str), true)
        })
    }

    public static ts_collapseOverloads(methods: readonly core.IDLMethod[], converter: core.IdlNameConvertor): core.IDLMethod[] {
        const types = new Set<string>();
        return methods.filter((m) => {
            const str = m.parameters.map(p => converter.convert(p.type)).join('+')
            return !types.has(str) && (types.add(str), true)
        })
    }

    public makeWrappedBindingCall(
        iface: core.IDLInterface,
        method: core.Method,
        writer: core.LanguageWriter,
        resolver: Resolver): core.LanguageExpression {
        const methodName = method.name
        const nativeCall = writer.makeFunctionCall(
            PeersConstructions.callBinding(iface.name, methodName, nodeNamespace(iface)),
            PeerGenerator.convertBindingArguments([core.IDLPointerType, ...method.signature.args],
                [PeersConstructions.pointerUsage, ...method.signature.argNames ?? []],
                (a, b) => PeerGenerator.makeWrapperToNativeType(a, b, this.resolver)
            ).map(writer.makeString)
        )
        const wrapper = PeerGenerator.makeWrapperFromNativeType('', method.signature.returnType, resolver)
        return wrapper.length == 0 ? nativeCall : writer.makeFunctionCall(wrapper, [nativeCall])
    }

    public makeBindingArguments(method: core.Method) : string[] {
            return PeerGenerator.convertBindingArguments(
                method.signature.args,
                method.signature.argNames ?? [],
                (a, b) => PeerGenerator.makeWrapperToNativeType(a, b, this.resolver)
            )
    }

    public static makeWrapperToNativeType(name: string, type: core.IDLType, resolver: Resolver) : string | string[] {
        if (core.isReferenceType(type)) {
            const ref = type as core.IDLReferenceType
            if (ref.name === Config.context) {
                return PeersConstructions.context
            }
            const entry = resolver.resolveTypeReference(ref)
            return entry?.kind === core.IDLKind.Interface ? PeersConstructions.passNode(name) : name

        } else if (core.isOptionalType(type)) {
            return this.makeWrapperToNativeType(name, type.type, resolver)

        } else if (type.kind == core.IDLKind.ContainerType) {
            return [PeersConstructions.passNodeArray(name), PeersConstructions.arrayLength(name)]
        }

        return name
    }

    public static makeWrapperFromNativeType(name: string, type: core.IDLType, resolver: Resolver) : string {
        // todo: make it possible to fix that via LanguageWriter & converter
        const hack_removePrefix = (name: string) =>
            name.startsWith(Config.dataClassPrefix) ? name.slice(Config.dataClassPrefix.length) : name

        if (core.isReferenceType(type)) {
            const refType = resolver.resolveTypeReference(type)
            return refType && core.isInterface(refType) && resolver.isHeir(refType, Config.astNodeCommonAncestor) ?
                PeersConstructions.unpackNonNullable : name

        } else if (core.isContainerType(type)) {
            return PeersConstructions.arrayOfPointersToArrayOfPeers

        } else if (core.isOptionalType(type)) {
            if (core.isReferenceType(type.type)) {
                const refType = resolver.resolveTypeReference(type.type)
                return refType && core.isInterface(refType) && resolver.isHeir(refType, Config.astNodeCommonAncestor) ?
                    PeersConstructions.unpackNullable : PeersConstructions.newOf(hack_removePrefix(type.type.name))
            }
            core.throwException(`unexpected optional of non-reference type`)

        } else if (type == core.IDLStringType) {
            return PeersConstructions.receiveString
        }

        return name
    }

    public static convertBindingArguments(args: core.IDLType[], argNames: string[],
        converter: (name: string, type: core.IDLType) => string | string[]): string[]
    {
        const parameters = args.map((arg, index) => {
            return {
                name: argNames[index] ?? `arg${index}`,
                type: arg
            }
        })
        return [
            {
                name: InteropConstructions.context.name,
                type: InteropConstructions.context.type
            },
            ...parameters
        ]
            .flatMap((it) => {
                return converter(it.name, it.type)
            })
    }

    public static makeMethod(
        method: core.IDLMethod,
        replace?: core.IDLParameter[],
        modifiers?: core.MethodModifier[]
    ): core.Method {
        const parameters = replace ?? method.parameters
        const optionals = parameters.map(p => core.isOptionalType(p.type) ? core.ArgumentModifier.OPTIONAL : undefined)
        const index = optionals.lastIndexOf(undefined)
        const argsModifiers = index > 0 ? optionals.fill(undefined, 0, index) : optionals

        return new core.Method(
            method.name,
            new core.MethodSignature(
                flattenType(method.returnType),
                parameters
                    .map(p => flattenType(p.type)),
                undefined,
                argsModifiers,
                undefined,
                parameters
                    .map(p => p.name)
                    .map(mangleIfKeyword)
            ),
            modifiers ?? []
        )
    }

    public static cloneMethod(src: Readonly<core.Method>, name?: string, retType?: core.IDLType): core.Method {
        const sig = src.signature
        return new core.Method(
            name ?? src.name,
            new core.MethodSignature(
                retType ?? sig.returnType,
                [...sig.args],
                sig.defaults? [...sig.defaults] : undefined,
                sig.argsModifiers?.flatMap(a => a.length ? a.at(0) : undefined),
                sig.printHints ? [...sig.printHints] : undefined,
                sig.argNames ? [...sig.argNames] : undefined
            ),
            src.modifiers ? [...src.modifiers] : undefined
        )
    }

    public static isGetter(method: core.IDLMethod): boolean {
        if (method.extendedAttributes?.some((attr) => {
            return attr.name == 'get'
        })) return true

        // probably a hack
        if (method.returnType == core.IDLVoidType) return false
        if (method.parameters.length > 1) return false

        const param = method.parameters.at(0)
        return !param || this.hack_isContextParam(param!)
    }

    public static ts_removeArrayLengthParam(parameters: readonly core.IDLParameter[]): core.IDLParameter[] {
        return parameters.filter((_, index) => {
            if (index === 0) {
                return true
            }
            const prevType = parameters[index - 1].type
            const isPrevSeq = core.isContainerType(prevType) && core.IDLContainerUtils.isSequence(prevType)
            return !isPrevSeq
        })
    }

    public static hack_makeNullableParameters(parameters: readonly core.IDLParameter[], resolver: Resolver): core.IDLParameter[] {
        return parameters.map(p => core.createParameter(p.name, this.hack_makeNullable(p.type, resolver)))
    }

    public static hack_makeNullable(type: Readonly<core.IDLType>, resolver: Resolver): core.IDLType {
        // todo: Specify nullability conditions.
        // Heir of an AstNode and not of an ArktsObject?
        // todo: Use Config.
        if (core.isReferenceType(type) &&
            // FIXME: isPeer and heir of an ast node are duplicated conditions
            (resolver.isPeer(type) || resolver.isHeir(type, Config.astNodeCommonAncestor))) {
            return core.createOptionalType(type)
        }
        return type
}

    public static hack_isContextParam(param: core.IDLParameter): boolean {
        const iface = core.isReferenceType(param.type) ? (param.type as core.IDLReferenceType) : undefined
        return iface?.name == `${Config.dataClassPrefix}${Config.context}`
    }

    public static hack_removeContextParam(parameters: readonly core.IDLParameter[]): core.IDLParameter[] {
        const param = parameters.at(0)
        return param && this.hack_isContextParam(param!) ? parameters.slice(1) : [...parameters]
    }

    public static hack_extraArgs(node: core.IDLInterface): core.IDLParameter[]{
        return []
    }
}
