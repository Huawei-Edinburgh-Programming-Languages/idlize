import * as fs from "fs"
import { OptionValues } from "commander"
import { Language } from "../util"
import { SkoalaLibrary } from "./SkoalaLibrary"
import { printInterfaces } from "./printers/InterfacePrinter"
import { SkoalaInstall } from "./SkoalaInstall"
import { ARKOALA_PACKAGE_PATH, INTEROP_PACKAGE_PATH } from "../peer-generation/printers/lang/Java"
import { printWrappers } from "./printers/WrappersPrinter"

export function generateSkoala(outDir: string, skoalaDeclLibrary: SkoalaLibrary, options: OptionValues) {
    const skoala = new SkoalaInstall(outDir, true)
    skoala.createDirs([ARKOALA_PACKAGE_PATH, INTEROP_PACKAGE_PATH])

    const skoalaFiles: string[] = []
    // const context = createPrinterContext(skoalaDeclLibrary.declarationTable)

    // // const materialized = printMaterialized(skoalaDeclLibrary, context, options.dumpSerialized ?? false)
    // const materialized = printWrapperClasses(skoalaDeclLibrary, context, options.dumpSerialized ?? false)
    // for (const [targetFile, materializedClass] of materialized) { // Paint, Canvas, Rect, RRect
    //     const outMaterializedFile = skoala.materialized(targetFile)
    //     writeFile(outMaterializedFile, materializedClass, !options.onlyIntegrated)
    // }


    // // NativeModule
    // if (lang === Language.TS) {
    //     writeFile(
    //         skoala.tsSkoalaLib(new TargetFile('NativeModuleEmpty')),
    //         printNativeModuleEmpty(skoalaDeclLibrary),
    //     )
    //     writeFile(
    //         skoala.tsSkoalaLib(new TargetFile('NativeModule')),
    //         printNativeModule(skoalaDeclLibrary, options.nativeBridgeDir ?? "../../../../../../../native/NativeBridgeNapi"),
    //     )
    // }

    // if (lang == Language.TS) {
    const interfaces = printInterfaces(skoalaDeclLibrary)
    for (const [targetFile, data] of interfaces) {
        const outComponentFile = skoala.interface(targetFile)
        writeFile(outComponentFile, data, !options.onlyIntegrated)
        skoalaFiles.push(outComponentFile)
    }

    const wrappers = printWrappers(skoalaDeclLibrary)
    for (const [targetFile, data] of wrappers) { 
        const outComponentFile = skoala.interface(targetFile)
        // writeFile(outComponentFile, data, !options.onlyIntegrated)
        fs.appendFileSync(outComponentFile, data)
    }

    //     const fakeDeclarations = printFakeDeclarations(skoalaDeclLibrary)
    //     for (const [filename, data] of fakeDeclarations) { // SyntheticDeclarations
    //         const outComponentFile = skoala.interface(new TargetFile(filename))
    //         if (options.verbose) console.log(data)
    //         writeFile(outComponentFile, data)
    //         arkuiComponentsFiles.push(outComponentFile)
    //     }

    //     writeFile(
    //         skoala.tsLib(new TargetFile('ConflictedDeclarations')),
    //         printConflictedDeclarations(skoalaDeclLibrary),
    //         !options.onlyIntegrated
    //     )
    //     writeFile(
    //         skoala.tsLib(new TargetFile('index')),
    //         makeArkuiModule(arkuiComponentsFiles),
    //         !options.onlyIntegrated
    //     )
    //     writeFile(skoala.peer(new TargetFile('Serializer')),
    //         makeTSSerializer(skoalaDeclLibrary),
    //     )
    //     writeFile(skoala.peer(new TargetFile('Deserializer')),
    //         makeTSDeserializer(skoalaDeclLibrary),
    //     )
    // }

    // copyToSkoala(path.join(__dirname, '..', 'skoala_lib'), skoala)

    return
}

function writeFile(filename: string, content: string, integrated: boolean = true) {
    if (integrated)
        fs.writeFileSync(filename, content)
}

function appendToFile(filename: string, content: string) {
        fs.appendFileSync(filename, content)
}