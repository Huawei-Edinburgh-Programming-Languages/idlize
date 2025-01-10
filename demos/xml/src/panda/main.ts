import { pullEvents } from "./compat"
import { run } from "../app"
import { XMLNativeModule } from "../../generated/arkts/xmlNative"

export function main() {
    loadLibrary("XML_NativeBridgeArk")
    XMLNativeModule.init(["xmlNative/XMLNativeModule", "xmlNative/ArkUINativeModule"])
    run()
    pullEvents()
}