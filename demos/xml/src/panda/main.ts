import { runEventLoop } from "./compat"
import { run } from "../index"

export function main() {
    runEventLoop()
    run()
}