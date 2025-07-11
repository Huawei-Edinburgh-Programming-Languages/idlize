import * as core from "@idlizer/core"
import { Body } from "./general/types"
import { PeerGenerator } from "./PeerGenerator"
import { PeersConstructions } from "./constuctions/PeersConstructions"
import { FactoryConstructions } from "./constuctions/FactoryConstructions"
import assert from "assert"
import { mangleIfKeyword } from "./general/common"

export class FactoryGenerator {
    // todo: split body into methods
    public static write(
        iface: core.IDLInterface,
        body: Body,
        writer: core.LanguageWriter,
        converter: core.IdlNameConvertor
    ): void {
        // Approximated logic from AttributeTransformer
        const getType = (type: core.IDLType) => converter.convert(type)
        const getReturnType = (method: core.Method) => getType(method.signature.returnType)

        const gettersNames = body.getters.map(m => m.name)
        const gettersTypes = body.getters.map(getReturnType)
        const methods = body.creates.filter(method => {
            const args = method.signature.args
            return args.length && args.every(
                (a, index) => gettersTypes.includes(getType(a)) &&
                    gettersNames.includes(method.signature.argNames![index]) )
        })

        if (methods.length !== 1) {
            return
        }

        const method = PeerGenerator.cloneMethod(
            methods[0],
            PeersConstructions.universalCreate(iface.name),
            core.createReferenceType(iface.name)
        )
        //method.signature.argNames = method.signature.argNames!.map(mangleIfKeyword)

        // Write create method

        const _str = writer.makeString.bind(writer)
        writer.writeMethodImplementation(method, () => writer.writeStatement(
            writer.makeReturn(writer.makeFunctionCall(
                PeersConstructions.callPeerMethod(iface.name, method.name),
                method.signature.argNames?.map(_str) ?? []
            ))
        ))
        writer.print(',')

        // Write update method

        const argsKind = method.signature.args.map(getType)
        const getters = body.getters
            .filter(m => argsKind.includes(getReturnType(m)) && method.signature.argNames?.includes(m.name))
            .sort((a, b) => argsKind.indexOf(getReturnType(a)) - argsKind.indexOf(getReturnType(b)))

        assert(getters.length === method.signature.argNames?.length, `Failed method: ${iface.name}.${method.name}`)

        const conditionStmt = writer.makeCondition(
            _str(FactoryConstructions.all(
                method.signature.argNames
                    ?.map((m, ind) => FactoryConstructions.isSame(m, getters.at(ind)!.name)) ?? []
            )),
            // then
            writer.makeReturn(
                _str(FactoryConstructions.original)
            )
        ) // condition

        method.name = PeersConstructions.universalUpdate(iface.name)
        method.signature.args.unshift(core.createReferenceType(iface))
        method.signature.argNames?.unshift(FactoryConstructions.original)

        writer.writeMethodImplementation(
            method,
            () => {
                writer.writeStatement(conditionStmt)
                writer.writeStatement(
                    writer.makeReturn(writer.makeFunctionCall(
                        FactoryConstructions.updateNodeByNode, [
                            writer.makeFunctionCall(
                                PeersConstructions.callPeerMethod(iface.name, method.name),
                                method.signature.argNames!.slice(1).map(_str) // removes original arg
                            ),
                            _str(FactoryConstructions.original)
                        ]
                    )) // return
                ) // stmt
            }
        )
        writer.print(',')
    }
}
