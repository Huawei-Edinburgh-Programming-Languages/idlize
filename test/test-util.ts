import * as path from "path"
import { Language } from "@idlize/core"
import { createReferenceType, IDLEntry } from "@idlize/core/idl"
import { PeerLibrary } from "../src/peer-generation/PeerLibrary"
import { PeerFile } from "../src/peer-generation/PeerFile"

import { readIDLFile } from "../core/test/test-util"

export class IDLTestLibrary {
    readonly peerLibrary: PeerLibrary

    constructor(idlFiles: string[]) {
        this.peerLibrary = new PeerLibrary(Language.TS)
        idlFiles.forEach(file =>
            this.peerLibrary.files.push(new PeerFile(file, readIDLFile(path.join(__dirname, file)))))
    }

    lookup<T extends IDLEntry>(name: string): T {
        return this.peerLibrary.resolveTypeReference(createReferenceType(name)) as T
    }
}

export function withFiles(idlFiles: string[], testFunc: (data: IDLTestLibrary) => void) {
    testFunc(new IDLTestLibrary(idlFiles))
}