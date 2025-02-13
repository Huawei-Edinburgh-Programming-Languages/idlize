import { int32 } from "@koalaui/common"
import { KPointer, KInt, KStringPtr, pointer, nullptr, RuntimeType, runtimeType, NativeBuffer } from "@koalaui/interop"
import { Serializer } from "./uiabilitycontextSerializer"
import { Finalizable } from "@koalaui/interop"



export class Want {
    bundleName?: string
    abilityName?: string
    deviceId?: string
    uri?: string
    type?: string
    flags?: number
    action?: string
    parameters?: Map<string, Object>
    entities?: Array<string>
    moduleName?: string
    fds?: Map<string, number>
}
export interface WantInterface {
    bundleName: string
    abilityName: string
    deviceId: string
    uri: string
    type: string
    flags: number
    action: string
    parameters: Map<string, Object>
    entities: Array<string>
    moduleName: string
    fds: Map<string, number>
}
