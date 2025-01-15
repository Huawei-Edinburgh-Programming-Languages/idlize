import * as fs from "fs"
import * as webidl2 from "webidl2"
import { toIDLNode } from "../src/from-idl/deserialize"
import { IDLEntry } from "../src/idl"

export function readIDLFile(file: string): IDLEntry[] {
    const content = fs.readFileSync(file).toString()
    return webidl2.parse(content).map(it => toIDLNode(file, it))
}
