import * as core from "@idlizer/core"
import { BridgesConstructions } from "./constuctions/BridgesConstructions"
import { Body, Resolver } from "./general/types"
import { PeerGenerator } from "./PeerGenerator"

const Literals = BridgesConstructions;

export class BridgesGenerator {
    constructor(
        private resolver: Resolver,
        private converter: core.IdlNameConvertor
    ) {
    }

    public write(iface: core.IDLInterface, body: Body, writer: core.CppLanguageWriter): void {
        body.creates?.forEach(m => this.writeCreate(iface, m, writer))
        body.updates?.forEach(m => this.writeCreate(iface, m, writer))
        const methods = Array.prototype.concat(body.getters ?? [], body.regular ?? [])
        //console.log(`${body.getters?.length}, ${body.regular?.length} => ${methods.length}`);
        PeerGenerator.sortInDeclarationOrder(methods, iface)
            .forEach(m => this.writeMethod(iface, m, writer))
    }

    private writeCreate(iface: core.IDLInterface, method: Readonly<core.Method>, writer: core.CppLanguageWriter): void {
        const statements = this.makeArgumentStatements(iface, method, writer)
        const implementationCall = this.makeImplMethodCall(iface, method, writer)
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
        const implementationCall = this.makeImplGetterCall(iface, method, writer,
                                                 needExtraArg ? [Literals.sequenceLengthPass] : [])

        writer.writeMethodImplementation(
            method,
            () => {
                writer.writeStatements(...statements,
                    needExtraArg ?
                        writer.makeAssign(Literals.sequenceLengthUsage, undefined, undefined, true) :
                        writer.makeStatement(writer.makeString('')),
                    writer.makeAssign(Literals.result, undefined, implementationCall, true),
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
        return method.signature.args
            .map((type, index) => {
                const opts = {
                    overrideTypeName: this.unwrap(iface, type),
                    unsafe: !core.isPrimitiveType(type)
                } as core.MakeCastOptions

                return writer.makeCast(
                    writer.makeString(method.signature.argNames![index]), core.IDLUndefinedType, opts
                )
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
        const cast = (expr: core.LanguageExpression) => writer.makeString(
            writer.makeUnsafeCast_(expr, core.IDLVoidType, core.PrintHint.AsPointer))

        return method.name.endsWith('Const') && tuple[1].asString().length ? [tuple[0], cast(tuple[1])] : tuple
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

    private makeImplMethodCall(
        iface: core.IDLInterface, method: core.Method,  writer: core.CppLanguageWriter): core.LanguageExpression {
        const cap = core.capitalize
        const argNames = method.signature.argNames!.map(a => this.convertArg(a))
        return writer.makeString(`GetImpl()->${cap(method.name)}${iface.name}(${argNames.join(', ')})`)
    }

    private makeImplGetterCall(
        iface: core.IDLInterface, method: core.Method, writer: core.CppLanguageWriter, extraArgs: string[]): core.LanguageExpression {
        const cap = core.capitalize
        const argNames = method.signature.argNames!.map(a => this.convertArg(a)).concat(extraArgs)
        return writer.makeString(`GetImpl()->${iface.name}${cap(method.name)}(${argNames.join(', ')})`)
    }

    private makeMacro(
        iface: core.IDLInterface, method: core.Method,  writer: core.CppLanguageWriter): core.LanguageExpression {
        const isVoid = method.signature.returnType === core.IDLVoidType
        const args = method.signature.args
            .map(a => this.converter.convert(a))
        return writer.makeString(
            `${Literals.interopMacro(isVoid, args.length)}(${args.join(', ')})`
        )
    }

    private insertReceiverArgument(iface: core.IDLInterface, method: core.Method): void {
        method.signature.args.splice(1, 0, core.createReferenceType(iface.name))
        method.signature.argNames!.splice(1, 0, 'reciever')
    }

    private convertArg(name: string): string {
        if (name.endsWith('Len')) {
            name = name.slice(0, -3) + 'SequnceLength'
        }
        return `_${name}`
    }

    private unwrap(iface: core.IDLInterface, ref: core.IDLType): string {
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
                if (name.includes('Context')) {
                    name = 'es2panda_Context*'
                } else {
                    const ctype = iface.extendedAttributes?.find(v => v.name === 'c_type')
                    name = ctype && ctype.value ? `${ctype.value}*` : Literals.astNode
                }
                return name
            }
        }
        return this.primitives.Undefined.getText()
    }

    public readonly primitives = new core.PrimitiveTypeList
}
