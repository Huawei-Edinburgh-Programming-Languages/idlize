import * as core from "@idlizer/core"
import { createParameter, IDLInterface, MethodSignature } from "@idlizer/core"
import { PeersConstructions } from "./constuctions/PeersConstructions"
import { mangleIfKeyword } from "./general/common"
import { flattenType } from "./utils/idl"
import { IVisitor } from "./Visitor"

export interface Body {
    creates: core.Method[],
    updates: core.Method[]
}

export class PeerGenerator {
    constructor(
        private node: core.IDLInterface
    ){
    }

    public static generateBody(iface: core.IDLInterface, write: (body: Body) => void) {
        const groupFn = (name: string): string => {
            const [p1, p2, p3, p4] = ['Create', 'Update', 'Getter', 'Regular']
            if (name.startsWith(p1)) {
                return p1
            } else if (name.startsWith(p2)) {
                return p2
            }
            return p4
        }

        const methods = iface.methods.reduce((acc, method) => {
            (acc[method.name] ??= []).push(method)
            return acc
        }, {} as Partial<Record<string, core.IDLMethod[]>>);

        //methods.Create?.forEach((v: core.IDLMethod) => {
        //    console.log(`${this.node.name}.${v.name}`);
        //})

        const createOrUpdateName = (name: string) =>
            PeersConstructions.createOrUpdate(iface.name, name)
        const extraArgs = PeerGenerator.hack_extraArgs(iface)

        const body = {
            creates: methods.Create
                ?.map(m => this.makeMethod(
                    m, createOrUpdateName(m.name), [core.MethodModifier.STATIC], extraArgs
                )) ?? [],
            updates: methods.Update
                ?.map(m => this.makeMethod(
                    m, createOrUpdateName(m.name), [core.MethodModifier.STATIC], extraArgs
                )) ?? [],
        }

        write(body as Body)
    }

    public static hack_extraArgs(node: IDLInterface): core.IDLParameter[]{
        return [core.createParameter('extra1', core.createReferenceType('GlobalContext')),
            core.createParameter('extra2', core.createReferenceType('GlobalContext'))]
    }

    private static makeMethod(
        method: core.IDLMethod,
        name?: string,
        modifiers?: core.MethodModifier[],
        extraParams?: core.IDLParameter[]
    ): core.Method {
        const parameters = method.parameters.concat(...extraParams ?? [])
        const argsModifiers = undefined

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
                    .map(mangleIfKeyword))
            ,
            modifiers ?? []
        )
    }
}

