import * as core from "@idlizer/core"
import { BridgesConstructions } from "./constuctions/BridgesConstructions"
import { Body, Resolver } from "./general/types"
import { PeerGenerator } from "./PeerGenerator"
import { splitCreateOrUpdate } from "./general/common";
import { Config } from "./general/Config";

const Literals = BridgesConstructions;

export class BridgesGenerator {
    constructor(
        private resolver: Resolver,
        private converter: core.IdlNameConvertor,
        private config: Config
    ) {
    }

    public write(iface: core.IDLInterface, body: Body, writer: core.CppLanguageWriter): void {
        // For clear diff
        const fixArgName = (name: string, prev?: string) =>
            name.endsWith('Len') ? (prev ?? name.slice(0, -3)) + 'SequenceLength' : name === 'ctx' ? 'context' : name

        PeerGenerator.sortInDeclarationOrder(Array.prototype.concat(body.creates ?? [], body.updates ?? []), iface)
            .forEach(method => {
                const parts = splitCreateOrUpdate(method.name)
                method.name = `${this.methodPrefix}${parts.createOrUpdate}${iface.name}${parts.rest}`
                method.signature.argNames = method.signature.argNames
                    ?.map((v, i) => fixArgName(v, i === 0 ? undefined : method.signature.argNames![i - 1]))

                this.writeCreate(iface, method, writer)
            })

        PeerGenerator.sortInDeclarationOrder(Array.prototype.concat(body.getters ?? [], body.regular ?? []), iface)
            .forEach(method => {
                method.name = `${this.methodPrefix}${iface.name}${method.name}`
                method.signature.argNames = method.signature.argNames
                    ?.map((v, i) => fixArgName(v, i === 0 ? undefined : method.signature.argNames![-i]))

                this.writeMethod(iface, method, writer)
            })
    }

    private hack_simplifyReturnType(method: core.Method): void {
        const ret = method.signature.returnType
        if (core.isContainerType(ret) && core.IDLContainerUtils.isSequence(ret)) {
            method.signature.returnType = ret.elementType[0]
        }

        if (method.signature.returnType === core.IDLStringType) {
            method.signature.returnType = core.IDLPointerType
        }
    }

    private writeCreate(iface: core.IDLInterface, method: Readonly<core.Method>, writer: core.CppLanguageWriter): void {
        const statements = this.makeArgumentStatements(iface, method, writer)
        const implementationCall = this.makeImplCall(iface, method, writer)

        this.hack_simplifyReturnType(method)

        writer.writeMethodImplementation(
            method,
            () => {
                writer.writeStatements(...statements,
                    writer.makeAssign(Literals.result, undefined, implementationCall, true, false),
                    writer.makeReturn(writer.makeString(Literals.result)),
                )
            }
        )
        writer.writeStatement(writer.makeStatement(this.makeMacro(iface, method, writer)))
        writer.writeLines('')
    }

    private writeMethod(iface: core.IDLInterface, method: Readonly<core.Method>, writer: core.CppLanguageWriter): void {
        this.insertReceiverArgument(iface, method)

        const [needExtraArg, returnValue] = this.makeAndCastReturnValue(iface, method, writer)
        const statements = this.makeArgumentStatements(iface, method, writer)
        const implementationCall = this.makeImplCall(iface, method, writer,
                                                 needExtraArg ? [Literals.sequenceLengthPass] : [])

        this.hack_simplifyReturnType(method)

        writer.writeMethodImplementation(
            method,
            () => {
                writer.writeStatements(...statements,
                    needExtraArg ?
                        //writer.makeAssign(Literals.sequenceLengthUsage, core.IDLU32Type, undefined, true, false) :
                        writer.makeStatement(writer.makeString(Literals.sequenceLengthDeclaration)) : // todo: Half a hack
                        writer.makeStatement(writer.makeString('')),
                    returnValue.asString().length ?
                        writer.makeAssign(Literals.result, undefined, implementationCall, true, false) :
                        writer.makeStatement(implementationCall),
                    writer.makeReturn(returnValue),
                )
            }
        )
        writer.writeStatement(writer.makeStatement(this.makeMacro(iface, method, writer)))
        writer.writeLines('')
    }

    private makeArgumentStatements(
        iface: core.IDLInterface, method: core.Method,  writer: core.CppLanguageWriter): core.LanguageStatement[] {
        const argFn = this.convertArg.bind(this)
        const makeCast = (method: core.Method, type: core.IDLType, index: number) => {
            const realType = core.isReferenceType(type) ? this.resolver.resolveTypeReference(type) ?? type : type
            const opts = {
                overrideTypeName: this.unwrap(iface, type),
                unsafe: !core.isPrimitiveType(realType) && !core.isEnum(realType)
            } as core.MakeCastOptions

            return writer.makeCast(
                writer.makeString(method.signature.argNames![index]), core.IDLUndefinedType, opts
            )
        }

        return method.signature.args
            .map((type, index) => {
                return type === core.IDLStringType ?  writer.makeFunctionCall(
                        Literals.stringCast, [writer.makeString(method.signature.argNames![index])]
                ) : makeCast(method, type, index)
            })
            .map((expr, index) => {
                return writer.makeAssign(
                    argFn(method.signature.argNames![index]), undefined, expr, true, true, {
                    } as core.MakeAssignOptions
                )
            })
    }

    private makeAndCastReturnValue(
        iface: core.IDLInterface, method: core.Method,  writer: core.CppLanguageWriter): [boolean, core.LanguageExpression] {
        const tuple = this.makeReturnValue(iface, method, writer)
        //const cast = (expr: core.LanguageExpression) => writer.makeString(
        //    writer.makeUnsafeCast_(expr, core.IDLVoidType, core.PrintHint.AsPointer))
        const castCompat = (expr: core.LanguageExpression) =>
            writer.makeString(`(void*)${expr.asString()}`)
        const needCast = (tuple[0] || core.isReferenceType(method.signature.returnType))
            && method.name.endsWith('Const')
        return needCast ? [tuple[0], castCompat(tuple[1])] : tuple
    }

    private makeReturnValue(
        iface: core.IDLInterface, method: core.Method,  writer: core.CppLanguageWriter): [boolean, core.LanguageExpression]{
        const returnType = method.signature.returnType

        if (core.isContainerType(returnType) && core.IDLContainerUtils.isSequence(returnType)) {
            return [true, writer.makeString(Literals.sequenceConstructor(
                Literals.result, Literals.sequenceLengthUsage))]

        } else if (returnType === core.IDLStringType) {
            return [false, writer.makeString(Literals.stringConstructor(Literals.result))]

        } else if (returnType === core.IDLVoidType) {
            return [false, writer.makeString('')]
        }

        return [false, writer.makeString(Literals.result)]
    }

    private makeImplCall(
        iface: core.IDLInterface, method: core.Method, writer: core.CppLanguageWriter, extraArgs?: string[]): core.LanguageExpression {
        const cap = core.capitalize
        const argNames = method.signature.argNames!.map(a => this.convertArg(a)).concat(extraArgs ?? [])
        let methodName = method.name.slice(this.methodPrefix.length)
        if (this.config.irHack.isIrHackInterface(iface.name)) {
            methodName = methodName.replace(iface.name, iface.name + 'Ir')
        }
        return writer.makeString(`GetImpl()->${cap(methodName)}(${argNames.join(', ')})`)
    }

    private makeMacro(
        iface: core.IDLInterface, method: core.Method,  writer: core.CppLanguageWriter): core.LanguageExpression {
        const isVoid = method.signature.returnType === core.IDLVoidType
        const args = (isVoid ? [] : [method.signature.returnType])
            .concat(method.signature.args)
            .map(a => {
                const value = this.converter.convert(a)
                return value.endsWith('&') ? value.slice(0, -1) : value // todo: only for kstringptr&
            })
        args.splice(0, 0, method.name.slice(this.methodPrefix.length))

        return writer.makeString(
            `${Literals.interopMacro(isVoid, method.signature.args.length)}(${args.join(', ')})`
        )
    }

    private insertReceiverArgument(iface: core.IDLInterface, method: core.Method): void {
        method.signature.args.splice(1, 0, core.createReferenceType(iface.name))
        method.signature.argNames!.splice(1, 0, 'receiver')
    }

    private convertArg(name: string): string {
        return `_${name}`
    }

    private unwrap(_: core.IDLInterface, ref: core.IDLType): string {
        if (core.isContainerType(ref) && core.IDLContainerUtils.isSequence(ref)) {
                return `${Literals.astNode}*`

         } else if (!core.isReferenceType(ref)) {
            return this.converter.convert(ref)
        }

        const type = this.resolver.resolveTypeReference(ref);
        if (type){
            if (core.isEnum(type)) {
                return type.name

            } else if (core.isInterface(type)) {
                let name = type.name.slice(0)
                const ctype = type.extendedAttributes?.find(v => v.name === 'c_type')
                if (ctype && ctype.value ) {
                    name = `${ctype.value}*`
                } else {
                    const short = name.startsWith(Config.dataClassPrefix) ? name.slice(Config.dataClassPrefix.length) : name
                    name = this.hack_ctype.has(short) ? `${Config.dataClassPrefix}${short}*` : Literals.astNode
                }
                //console.log(`${name} for ${type.name}`);
                return name
            }
        }
        return this.primitives.Undefined.getText()
    }

    private readonly methodPrefix = 'impl_'
    public readonly primitives = new core.PrimitiveTypeList
    private readonly hack_ctype = new Set<string>([
        'Context', // Do not remove!
        'AstVisitor',
        'CodeGen',
        'Context',
        'ErrorLogger',
        'LabelPair',
        'SourcePosition',
        'SourceRange',
        'VReg',
    ])
}
