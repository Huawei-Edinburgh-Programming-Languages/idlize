import { runEventLoop } from "./compat"
import { run } from "../app"

export function main() {
    runEventLoop()
    run()
}