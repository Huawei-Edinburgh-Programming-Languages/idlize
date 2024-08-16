import * as ts from 'typescript'
import * as fs from "fs"
import * as path from "path"
import {
    dummyImplementations,
    makeArkuiModule,
    makeTSSerializer,
    makeTSDeserializer,
    libraryCcDeclaration,
} from "../peer-generation/FileGenerators"
import { printRealAndDummyAccessors } from "../peer-generation/printers/ModifierPrinter"
import { printRealAndDummyModifiers } from "../peer-generation/printers/ModifierPrinter"
import { PeerLibrary } from "../peer-generation/PeerLibrary"
import { printMaterialized } from "../peer-generation/printers/MaterializedPrinter"
import { printSerializers } from "../peer-generation/printers/HeaderPrinter"
import { printNodeTypes } from "../peer-generation/printers/NodeTypesPrinter"
import { printNativeModule, printNativeModuleEmpty } from "../peer-generation/printers/NativeModulePrinter"
import { printEvents, printEventsCArkoalaImpl } from "../peer-generation/printers/EventsPrinter"
import { printInterfaces } from "../peer-generation/printers/InterfacePrinter"
import { printConflictedDeclarations } from "../peer-generation/printers/ConflictedDeclarationsPrinter"
import { printFakeDeclarations } from "../peer-generation/printers/FakeDeclarationsPrinter"
import { ARKOALA_PACKAGE_PATH, INTEROP_PACKAGE_PATH } from "../peer-generation/printers/lang/Java"
import { TargetFile } from "../peer-generation/printers/TargetFile"
import { printBridgeCcCustom, printBridgeCcGenerated } from "../peer-generation/printers/BridgeCcPrinter"
import { createPrinterContext } from "../peer-generation/printers/PrinterContext/PrinterContextImpl"
import { defaultCompilerOptions, Language, toSet } from "../util"
import { OptionValues } from "commander"
import { PeerGeneratorConfig } from "../peer-generation/PeerGeneratorConfig"
import { generate } from "../idlize"
import { DeclarationTable } from "../peer-generation/DeclarationTable"
import { LocalPeerProcessor, SkoalaDeclLibrary, SkoalaGeneratorVisitor, SkoalaInstall } from "./SkoalaGeneratorVisitor"
import { PrinterContext } from "../peer-generation/printers/PrinterContext"
import { printSkoalaClasses } from './printers/SkoalaPrinter'

export function dtsToSkoala(options: OptionValues) {
    if (options.apiPrefix !== undefined) {
        PeerGeneratorConfig.cppPrefix = options.apiPrefix
    }
    PeerGeneratorConfig.needInterfaces = options.needInterfaces
    const declarationTable = new DeclarationTable(options.language ?? "ts")
    const peerLibrary = new SkoalaDeclLibrary(declarationTable, toSet(options.generateInterface))
    const generatedPeersDir = options.outputDir ?? "./out/ts-peers/generated"

    generate(
        options.inputDir,
        undefined,
        generatedPeersDir,
        (sourceFile, typeChecker) => new SkoalaGeneratorVisitor({
            sourceFile: sourceFile,
            typeChecker: typeChecker,
            declarationTable,
            skoaladeclLibrary: peerLibrary
        }),
        {
            compilerOptions: {
                ...defaultCompilerOptions,
                paths: {
                    "@koalaui/common": ["/home/huawei/idlize/external/incremental/common/src"],
                    "@koalaui/interop": ["/home/huawei/idlize/external/interop/src/interop"],
                    "@koalaui/arkoala": ["/home/huawei/idlize/external/arkoala/framework/src"],
                },
                traceResolution: true
            },
            onBegin(outDir, typeChecker) {
                declarationTable.typeChecker = typeChecker
            },
            onEnd(outDir: string) {
                let lang = declarationTable.language
                const peerProcessor = new LocalPeerProcessor(peerLibrary)
                peerProcessor.process()
                declarationTable.analyze(peerLibrary)

                generateSkoala(outDir, peerLibrary, lang, options)
            }
        }
    )
}

function writeFile(filename: string, content: string, integrated: boolean) {
    if (integrated)
        fs.writeFileSync(filename, content)
}

export function generateSkoala(outDir: string, skoalaDeclLibrary: SkoalaDeclLibrary, lang: Language, options: OptionValues) {
    const skoala = new SkoalaInstall(outDir, lang, true)
    skoala.createDirs([ARKOALA_PACKAGE_PATH, INTEROP_PACKAGE_PATH].map(dir => path.join(skoala.javaDir, dir)))
    skoala.createDirs(['', ''].map(dir => path.join(skoala.cjDir, dir)))

    const arkuiComponentsFiles: string[] = []
    const context = createPrinterContext(skoalaDeclLibrary.declarationTable)

    // const materialized = printMaterialized(skoalaDeclLibrary, context, options.dumpSerialized ?? false)
    const materialized = printSkoalaClasses(skoalaDeclLibrary, context, options.dumpSerialized ?? false)
    for (const [targetFile, materializedClass] of materialized) { // Paint, Canvas, Rect, RRect
        const outMaterializedFile = skoala.materialized(targetFile)
        console.log("producing", outMaterializedFile)
        writeFile(outMaterializedFile, materializedClass, !options.onlyIntegrated)
    }

    return

    // NativeModule
    if (lang === Language.TS) {
        writeFile(
            skoala.tsSkoalaLib(new TargetFile('NativeModuleEmpty')),
            printNativeModuleEmpty(skoalaDeclLibrary),
            true
        )
        writeFile(
            skoala.tsSkoalaLib(new TargetFile('NativeModule')),
            printNativeModule(skoalaDeclLibrary, options.nativeBridgeDir ?? "../../../../../../../native/NativeBridgeNapi"),
            true
        )
    }

    if (lang == Language.TS) {
        const interfaces = printInterfaces(skoalaDeclLibrary, context)
        for (const [targetFile, data] of interfaces) { // ArkCanvasInterfaces
            const outComponentFile = skoala.interface(targetFile)
            console.log("producing", outComponentFile)
            writeFile(outComponentFile, data, !options.onlyIntegrated)
            arkuiComponentsFiles.push(outComponentFile)
        }

        const fakeDeclarations = printFakeDeclarations(skoalaDeclLibrary)
        for (const [filename, data] of fakeDeclarations) { // SyntheticDeclarations
            const outComponentFile = skoala.interface(new TargetFile(filename))
            console.log("producing", outComponentFile)
            if (options.verbose) console.log(data)
            writeFile(outComponentFile, data, true)
            arkuiComponentsFiles.push(outComponentFile)
        }

        writeFile(
            skoala.tsLib(new TargetFile('ConflictedDeclarations')),
            printConflictedDeclarations(skoalaDeclLibrary),
            !options.onlyIntegrated
        )
        writeFile(
            skoala.peer(new TargetFile('ArkUINodeType')),
            printNodeTypes(skoalaDeclLibrary),
            !options.onlyIntegrated
        )
        writeFile(
            skoala.tsLib(new TargetFile('index')),
            makeArkuiModule(arkuiComponentsFiles),
            !options.onlyIntegrated
        )
        writeFile(
            skoala.tsLib(new TargetFile("peer_events")),
            printEvents(skoalaDeclLibrary),
            true
        )
        writeFile(skoala.peer(new TargetFile('Serializer')),
            makeTSSerializer(skoalaDeclLibrary),
            true,
        )
        writeFile(skoala.peer(new TargetFile('Deserializer')),
            makeTSDeserializer(skoalaDeclLibrary),
            true,
        )
    }
    ///////////////
    writeFile(skoala.native(new TargetFile('bridge_generated.cc')), printBridgeCcGenerated(skoalaDeclLibrary, options.callLog ?? false), true)
    writeFile(skoala.native(new TargetFile('bridge_custom.cc')), printBridgeCcCustom(skoalaDeclLibrary, options.callLog ?? false), !options.onlyIntegrated)

    const { api, serializers } = printSerializers(options.apiVersion, skoalaDeclLibrary)
    writeFile(skoala.native(new TargetFile('Serializers.h')), serializers, true)
    writeFile(skoala.native(new TargetFile('skoala_api_generated.h')), api, true)

    const modifiers = printRealAndDummyModifiers(skoalaDeclLibrary)
    const accessors = printRealAndDummyAccessors(skoalaDeclLibrary)
    writeFile(
        skoala.native(new TargetFile('dummy_impl.cc')),
        dummyImplementations(modifiers.dummy, accessors.dummy, 1, options.apiVersion, 6).getOutput().join('\n'),
        !options.onlyIntegrated
    )
    writeFile(
        skoala.native(new TargetFile('real_impl.cc')),
        dummyImplementations(modifiers.real, accessors.real, 1, options.apiVersion, 6).getOutput().join('\n'),
        true,
    )
    writeFile(skoala.native(new TargetFile('all_events.cc'),), printEventsCArkoalaImpl(skoalaDeclLibrary), true)
    writeFile(skoala.native(new TargetFile('library.cc')), libraryCcDeclaration(), !options.onlyIntegrated)
}
