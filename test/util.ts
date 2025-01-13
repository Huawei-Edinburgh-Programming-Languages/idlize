import * as fs from "fs"
import * as path from "path"
import * as webidl2 from "webidl2"
import { Language } from "../src/Language"
import { PeerLibrary } from "../src/peer-generation/PeerLibrary"
import { toIDLNode } from "../src/from-idl/deserialize"
import { PeerFile } from "../src/peer-generation/PeerFile"
import { createReferenceType, IDLEntry } from "../src/idl"

export class IDLTest {
    readonly peerLibrary: PeerLibrary

    constructor(file: string) {
        this.peerLibrary = new PeerLibrary(Language.TS)
        const content = fs.readFileSync(path.join(__dirname, file)).toString()
        const entries = webidl2.parse(content).map(it => toIDLNode(file, it))
        this.peerLibrary.files.push(new PeerFile(file, entries))
    }

    lookup(name: string): IDLEntry {
        return this.peerLibrary.resolveTypeReference(createReferenceType(name))!
    }
}
///add README