import * as fs from "fs"
import { OptionValues } from "commander"
import { SkoalaLibrary } from "./SkoalaLibrary"
import { SkoalaInstall } from "./SkoalaInstall"
import { ARKOALA_PACKAGE_PATH, INTEROP_PACKAGE_PATH } from "../peer-generation/printers/lang/Java"
import { TSInterfacesVisitor } from "./printers/InterfacePrinter"
import { TSWrappersVisitor } from "./printers/WrappersPrinter"
import { TargetFile } from "../peer-generation/printers/TargetFile"
import { createLanguageWriter, LanguageWriter } from "../peer-generation/LanguageWriters"
import { Language } from "../util"

export function generateSkoala(outDir: string, skoalaLibrary: SkoalaLibrary, options: OptionValues) {
    const skoala = new SkoalaInstall(outDir, true)
    skoala.createDirs([ARKOALA_PACKAGE_PATH, INTEROP_PACKAGE_PATH])

    const skoalaFiles: string[] = []
    const interfaces = printSkoala(skoalaLibrary)
    for (const [targetFile, data] of interfaces) {
        const outComponentFile = skoala.interface(targetFile)
        writeFile(outComponentFile, data.getOutput().join('\n'), !options.onlyIntegrated)
        skoalaFiles.push(outComponentFile)
    }

    return
}

function writeFile(filename: string, content: string, integrated: boolean = true) {
    if (integrated)
        fs.writeFileSync(filename, content)
}

export function printSkoala(library: SkoalaLibrary): Map<TargetFile, LanguageWriter> {
    let intVis = new TSInterfacesVisitor()
    let wrVis = new TSWrappersVisitor()

    let result: Map<TargetFile, LanguageWriter> = new Map()

    for (let file of library.files) {
        const writer = createLanguageWriter(Language.TS)
        intVis.printImports(file, writer)
        wrVis.printImports(file, writer)
        
        intVis.printInterfaces(file, writer)
        wrVis.printWrappers(file, writer)
        result.set(
            new TargetFile(file.baseName.replace(".d.ts", ".ts")),
            writer
        )
    }

    return result
}
