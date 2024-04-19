import * as path from "path"
import { IndentedPrinter } from "../IndentedPrinter"
import { getOrPut, renameDtsToPeer } from "../util"
import { PeerClass } from "./PeerClass"
import { Printers } from "./Printers"

export class PeerFile {
    private readonly peers: Map<string, PeerClass> = new Map()
    constructor(
        public readonly originalFilename: string,
        private readonly printers: Printers,
    ) {}

    getOrPutPeer(componentName: string) {
        return getOrPut(this.peers, componentName, () => new PeerClass(componentName, this.printers))
    }

    private printTSImports(printer: IndentedPrinter): void {
        const filenameToImports = new Map<string, Set<String>>()
        this.peers.forEach(peer => {
            if (!peer.originalParentFilename) return
            if (peer.originalParentFilename == this.originalFilename) return
            const filename = renameDtsToPeer(path.basename(peer.originalParentFilename))
            const imports = getOrPut(filenameToImports, filename, () => new Set())
            imports.add(peer.peerParentName)
            if (peer.attributesParentName)
                imports.add(peer.attributesParentName)
        })

        filenameToImports.forEach((imports, filename) => {
            const filenameNoExt = filename.replaceAll(path.extname(filename), '')
            const uniqImports = Array.from(imports)
            printer.print(`import { ${uniqImports.join(', ')} } from "./${filenameNoExt}"`)
        })
    }

    print(): void {
        this.printTSImports(this.printers.TS)
        this.peers.forEach(it => it.print())
    }
}