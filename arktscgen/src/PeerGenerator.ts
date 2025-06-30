import * as core from "@idlizer/core"
import { Config } from "./general/Config"
import { InteropConstructions } from "./constuctions/InteropConstructions"
import { PeersConstructions } from "./constuctions/PeersConstructions"
import { isCreateOrUpdate, isGetter, isReal, mangleIfKeyword, peerMethod, splitCreateOrUpdate } from "./general/common"
import { flattenType, nodeNamespace, nodeType } from "./utils/idl";
import { BranchStatement } from "@idlizer/core"

export interface Body {
    creates: core.Method[],
    updates: core.Method[],
    getters: core.Method[],
    regular: core.Method[],
}

export interface Resolver extends core.ReferenceResolver {
    isHeir(type: core.IDLInterface, name: string): boolean
}

export class PeerGenerator {
    constructor(
        public resolver: Resolver
    ) {
    }

    public writeBody(iface: core.IDLInterface, writer: core.LanguageWriter, written: (body: Body) => void) {
        const methodTypes = ['Create', 'Update', 'Getter', 'Regular']
        const groupFn = (method: core.IDLMethod): string => {
            const [p1, p2, p3, p4] = methodTypes
            if (method.name.startsWith(p1)) {
                return p1
            } else if (method.name.startsWith(p2)) {
                return p2
            }
            else if (PeerGenerator.isGetter(method)) {
                return p3
            }
            return p4
        }

        const methods = iface.methods.reduce((acc, method) => {
            (acc[groupFn(method)] ??= []).push(method)
            return acc
        }, {} as Partial<Record<string, core.IDLMethod[]>>);

        // Collapse overloads

        methods.Create = this.ts_collapseOverloads(methods.Create ?? [])
        methods.Update = this.ts_collapseOverloads(methods.Update ?? [])
        methods.Getter = this.ts_collapseDuplicates(methods.Getter ?? [])

        // Hacks section

        // TODO: This was requested by Igor - add args to create/update methods and set/call corresponding
        // props/setters. Factory.ts needs updated declarations.
        const extraArgs = PeerGenerator.hack_extraArgs(iface)
        const createOrUpdateName = (name: string) => PeersConstructions.createOrUpdate(iface.name, name)

        const body = {
            creates: methods.Create
                ?.map(m => PeerGenerator.makeMethod(
                    m, createOrUpdateName(m.name), [core.MethodModifier.STATIC], extraArgs
                )) ?? [],
            updates: methods.Update
                ?.map(m => PeerGenerator.makeMethod(
                    m, createOrUpdateName(m.name), [core.MethodModifier.STATIC], extraArgs
                )) ?? [],
            getters: methods.Getter
                ?.map(m => PeerGenerator.makeMethod(
                    m, peerMethod(m.name), [core.MethodModifier.GETTER]
                )) ?? [],
            regular: methods.Regular
                ?.map(m => PeerGenerator.makeMethod(
                    m, peerMethod(m.name)
                )) ?? [],
        }

        // See variable_declararion_old_vs_new.diff
        //
        // TODO: Major! Method's name is modified before generation of binding call so
        // we can call not a desired method (w/o Const suffix for example)
        // TODO: Some parameters are unions (| undefined) or optional,
        // there is no such flags in idl file for those parameteres
        // TODO: Probably, the separation for getters and regulars in body
        // is not needed.

        // 1. Writing ctors

        this.writeCtorImpl(iface, writer)

        // 2. Writing create and update methods

        for (const m of body.creates.concat(body.updates)) {
            this.writeCreateImpl(iface, m, writer)
        }

        // 3. Writing getters and regular

        const inFileOrder = iface.methods
            .filter(m => !isCreateOrUpdate(m.name))
            .map(m => peerMethod(m.name))
            .reduce((acc, cur) => {
                if (!acc.length || acc.at(-1) != cur) {
                    acc.push(cur)
                }
                return acc
            }, [] as string[])

        // FIXME: !!!
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

        // 4. Provide probably modified declarations to other generators

        written(body as Body)
    }

    // write/make methods were copy-pasted from PeerPrinter and modified to work with other types and
    // resolver
 
    private writeCreateImpl(iface: core.IDLInterface, method: core.Method, writer: core.LanguageWriter): void {
        const methodName = method.name.at(0)?.toUpperCase() + method.name.slice(1, 6)
        const nativeCall = writer.makeFunctionCall(
            writer.makeString(
                PeersConstructions.callBinding(
                    iface.name,
                    methodName,
                    nodeNamespace(iface)
                )
            ),
            this.makeBindingArguments(method).map(p => writer.makeString(p)) ?? []
        )
        const newExpr = writer.makeNewObject(iface.name, [nativeCall])

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
                                ),
                            ]
                        )
                    )
                }
                writer.writeExpressionStatements(
                    writer.makeFunctionCall(
                        PeersConstructions.super,
                        [
                            writer.makeString(PeersConstructions.pointerParameter)
                        ]
                    )
                )
            }
        ) // writeConstructor
    }

    private writeGetterImpl(iface: core.IDLInterface, method: core.Method, writer: core.LanguageWriter): void {
        writer.writeMethodImplementation(
            method,
            () => {
                writer.writeStatement(
                    writer.makeReturn(
                        this.makeWrappedBindingCall(iface, method, writer, this.resolver)
                    )
                )
            }
        )
    }

    private writeRegularImpl(iface: core.IDLInterface, method: core.Method, writer: core.LanguageWriter): void {
        writer.writeExpressionStatement(
            writer.makeString(`/** @deprecated */`)
        )
        method.signature.returnType = flattenType(PeersConstructions.this.type) // FIXME: put in writeBody
        writer.writeMethodImplementation(method, () => {
            writer.writeExpressionStatement(
                this.makeWrappedBindingCall(iface, method, writer, this.resolver)
            )
            writer.writeStatement(
                writer.makeReturn(
                    writer.makeString(
                        PeersConstructions.this.name
                    )
                )
            )
        })
    }

    public ts_collapseDuplicates(methods: readonly core.IDLMethod[]): core.IDLMethod[] {
        const names = new Set<string>();
        return methods.filter((m) => {
            const str = peerMethod(m.name)
            return !names.has(str) && (names.add(str), true)
        })
    }

    public ts_collapseOverloads(methods: readonly core.IDLMethod[]): core.IDLMethod[] {
        const types = new Set<string>();
        return methods.filter((m) => {
            const str = m.parameters.map(p => this.converter.convert(p.type)).join('+')
            return !types.has(str) && (types.add(str), true)
        })
    }

    public makeWrappedBindingCall(
        iface: core.IDLInterface,
        method: core.Method,
        writer: core.LanguageWriter,
        resolver: Resolver): core.LanguageExpression {
        const methodName = method.name.at(0)?.toUpperCase() + method.name.slice(1) // FIXME: move to callBinding
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
        if (type.kind == core.IDLKind.ReferenceType) {
            const ref = type as core.IDLReferenceType
            if (ref.name === Config.context) {
                return PeersConstructions.context
            }
            const entry = resolver.resolveTypeReference(ref)
            return entry?.kind === core.IDLKind.Interface ? PeersConstructions.passNode(name) : name
        } else if (type.kind == core.IDLKind.ContainerType) {
            return [
                PeersConstructions.passNodeArray(name),
                PeersConstructions.arrayLength(name)
            ]
        }
        return name
    }

    public static makeWrapperFromNativeType(name: string, type: core.IDLType, resolver: Resolver) : string {
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
                PeersConstructions.unpackNullable : PeersConstructions.newOf(type.type.name)
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

    private static makeMethod(
        method: core.IDLMethod,
        name?: string,
        modifiers?: core.MethodModifier[],
        extraParams?: core.IDLParameter[]
    ): core.Method {
        const parameters = this.ts_removeArrayLengthParam(this.hack_removeContextParam(method.parameters))
            .concat(...extraParams ?? [])
        const argsModifiers = undefined // TODO: fix

        return new core.Method(
            name ?? method.name,
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
        return parameters.reduce((prev, curr) => {
            const prevType = prev.at(-1)?.type
            if (!(prevType && core.IDLContainerUtils.isSequence(prevType))) {
                prev.push(curr)
            }
            return prev
        }, [] as core.IDLParameter[])
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
        //return [core.createParameter('extra1', core.createReferenceType('GlobalContext')),
        //    core.createParameter('extra2', core.createReferenceType('GlobalContext'))]
    }

    public converter = new SimpleConverter(this.resolver)
}

class SimpleConverter extends core.TSTypeNameConvertor {
    constructor(resolver: core.ReferenceResolver) {
        super(resolver)
    }

    override convertInterface(node: core.IDLInterface): string {
        // todo: copypaste
        const prefix = Config.dataClassPrefix
        const result = node.name.startsWith(prefix) ? node.name.slice(prefix.length) : node.name
        console.log(`convert ${node.name} => ${result}`);
        return result
    }

    override convertTypeReference(type: core.IDLReferenceType): string {
        // todo: copypaste
        const prefix = Config.dataClassPrefix
        let result = type.name.startsWith(prefix) ? type.name.slice(prefix.length) : type.name
        result = result.split('.').at(-1)!
        //console.log(`convert ${type.name} => ${result}(idl: ${super.convertTypeReference(type)})`);
        return result
    }

   override convertContainer(type: core.IDLContainerType): string {
       if (core.IDLContainerUtils.isSequence(type)) {
            return `readonly ${super.convert(type.elementType[0])}[]`
       }
       return super.convertContainer(type)
   }

    override convertPrimitiveType(type: core.IDLPrimitiveType): string {
        switch (type) {
            case core.IDLI8Type:
            case core.IDLU8Type:
            case core.IDLI16Type:
            case core.IDLU16Type:
            case core.IDLU32Type:
            case core.IDLI64Type:
            case core.IDLU64Type:
            case core.IDLF64Type:
            case core.IDLNumberType:
            case core.IDLI32Type:
            case core.IDLF32Type:
                return 'number'
            case core.IDLPointerType:
                return 'KNativePointer'
       }
       return super.convertPrimitiveType(type)
   }
}

