import * as path from "path"
import * as fs from "fs"
import { TargetFile } from "../peer-generation/printers/TargetFile"
import { Language } from "../util"

class Install {
    mkdir(path: string): string {
        fs.mkdirSync(path, { recursive: true })
        return path
    }
}

export class SkoalaInstall extends Install {
    constructor(private outDir: string, private test: boolean) {
        super()
    }
    langDir(): string {
        return this.tsDir
    }
    createDirs(dirs: string[]) {
        for (const dir of dirs) {
            this.mkdir(dir)
        }
    }
    sig = this.mkdir(this.test ? path.join(this.outDir, "sig") : this.outDir)
    tsDir = this.mkdir(path.join(this.sig, "arkoala/arkui/src/"))
    frameworkDir = this.mkdir(path.join(this.sig, "arkoala/framework"))
    tsSkoalaDir = this.mkdir(path.join(this.frameworkDir, "src/generated/"))
    nativeDir = this.mkdir(path.join(this.frameworkDir, "native/src/generated/"))
    // peer(targetFile: TargetFile): string {
    //     const peerDir = this.mkdir(path.join(this.langDir(), 'peers'))
    //     return path.join(peerDir, targetFile.path ?? "", targetFile.name + Language.TS.extension)
    // }
    // component(targetFile: TargetFile): string {
    //     return path.join(this.langDir(), targetFile.path ?? "", targetFile.name)
    // }
    // builderClass(targetFile: TargetFile): string {
    //     return path.join(this.langDir(), targetFile.path ?? "", targetFile.name)
    // }
    // materialized(targetFile: TargetFile): string {
    //     return path.join(this.langDir(), targetFile.path ?? "", targetFile.name)
    // }
    interface(targetFile: TargetFile): string {
        return path.join(this.langDir(), targetFile.path ?? "", targetFile.name)
    }
    langLib(targetFile: TargetFile) {
        return path.join(this.langDir(), targetFile.path ?? "", targetFile.name + Language.TS.extension)
    }
    tsLib(targetFile: TargetFile) {
        return path.join(this.tsDir, targetFile.path ?? "", targetFile.name + Language.TS.extension)
    }
    tsSkoalaLib(targetFile: TargetFile) {
        return path.join(this.tsSkoalaDir, targetFile.path ?? "", targetFile.name + Language.TS.extension)
    }
    native(targetFile: TargetFile) {
        return path.join(this.nativeDir, targetFile.path ?? "", targetFile.name)
    }
}