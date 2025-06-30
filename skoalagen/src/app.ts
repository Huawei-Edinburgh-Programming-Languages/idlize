/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import * as fs from "fs"
import * as path from "path"
import * as ts from "typescript"
import { program } from "commander"
import {
    validatePaths,
    formatInputPaths,
    IDLVisitor,
    loadPeerConfiguration,
    NativeModule
} from "@idlizer/libohos"

import {
    createFile,
    createInterface,
    defaultCompilerOptions,
    generate,
    IDLFile,
    IDLInterfaceSubkind,
    Language,
    LibraryInterface,
    linkParentBack,
    PACKAGE_IDLIZE_INTERNAL,
    scanInputDirs,
    setDefaultConfiguration,
    toIDLFile,
    toIDLString
} from "@idlizer/core"
import { generateSkoalaFromIdl } from "./skoala"
import { PeerProcessor } from "./PeerGeneratorVisitor"
import { IdlSkoalaLibrary } from "./idlSkoalaLibrary"

const PREDEFINED_PATH = path.resolve(__dirname, '..', 'predefined')
export function skoalaPredefinedFiles(): string[] {
    return scanInputDirs([
        PREDEFINED_PATH
    ])
}

export function skoalagen(argv: string[]) {
    const options = program
        .option('--dts2skoala', 'Convert DTS to skoala definitions')
        .option('--options-file <path>', 'Path to generator configuration options file (appends to defaults). Use --ignore-default-config to override default options.')
        .option('--input-dir <path>', 'Path to input dir(s), comma separated')
        .option('--aux-input-dir <path>', 'Path to aux input dir(s), comma separated')
        .option('--base-dir <path>', 'Base directories, for the purpose of packetization of IDL modules, comma separated, defaulted to --input-dir if missing')
        .option('--output-dir <path>', 'Path to output dir')
        .option('--input-files <files...>', 'Comma-separated list of specific files to process')
        .option('--aux-input-files <files...>', 'Comma-separated list of specific aux files to process')
        .option('--library-packages <packages>', 'Comma separated list of packages included into library')
        .option('--enable-log', 'Enable logging')
        .parse(argv, { from: 'user' })
        .opts()

    setDefaultConfiguration(loadPeerConfiguration(options.optionsFile, options.ignoreDefaultConfig as boolean))

    if (options.dts2skoala) {
        const outputDir: string = options.outputDir ?? "./out/skoala"

        if (!fs.existsSync(outputDir)) {
            fs.mkdirSync(outputDir, { recursive: true })
        }

        const { baseDirs, inputDirs, auxInputDirs, inputFiles, auxInputFiles } = formatInputPaths(options)
        validatePaths(baseDirs, "dir")
        validatePaths(inputDirs, "dir")
        validatePaths(auxInputDirs, "dir")
        validatePaths(inputFiles, "file")
        validatePaths(auxInputFiles, "file")

        const allInputFiles = scanInputDirs(inputDirs)
            .concat(inputFiles)
            .concat(skoalaPredefinedFiles())

        const allAuxInputFiles = auxInputFiles
        const dtsInputFiles = allInputFiles.filter(it => it.endsWith('.d.ts'))
        const dtsAuxInputFiles = allAuxInputFiles.filter(it => it.endsWith('.d.ts'))
        const idlInputFiles = allInputFiles.filter(it => it.endsWith('.idl'))
        const idlAuxInputFiles = allAuxInputFiles.filter(it => it.endsWith('.idl'))

        const skoalaLibrary = new IdlSkoalaLibrary(Language.TS, NativeModule.Interop)

        {
            const pushOne = (idlFilename: string, resultFilesArray: IDLFile[]) => {
                idlFilename = path.resolve(idlFilename)
                const [file] = toIDLFile(idlFilename)
                resultFilesArray.push(file)
            }
            idlInputFiles.forEach(idlFilename => pushOne(idlFilename, skoalaLibrary.files))
            idlAuxInputFiles.forEach(auxIdlFilename => pushOne(auxIdlFilename, skoalaLibrary.auxFiles))
        }

        generate(
            baseDirs,
            [...inputDirs, ...auxInputDirs],
            dtsInputFiles,
            dtsAuxInputFiles,
            outputDir,
            path.resolve(__dirname, "../", "stdlib.d.ts"),
            (sourceFile, program, compilerHost) => new IDLVisitor(baseDirs, sourceFile, program, compilerHost, options, skoalaLibrary),
            {
                compilerOptions: defaultCompilerOptions,
                enableLog: options.enableLog,
                onSingleFile: (file: IDLFile, outputDirectory, sourceFile, isAux) => {
                    linkParentBack(file)

                    if (!isAux) {
                        skoalaLibrary.files.push(file)
                    } else {
                        skoalaLibrary.auxFiles.push(file)
                    }

                    saveIDL(file, baseDirs, path.join(outputDirectory, "./idl/"), sourceFile)
                },
                onEnd: (outDir) => {
                    fillGeneratedNativeModuleDeclaration(skoalaLibrary)

                    const peerProcessor = new PeerProcessor(skoalaLibrary)
                    peerProcessor.process()

                    generateSkoalaFromIdl({
                        outDir: outDir,
                        arkoalaDestination: options.arkoalaDestination,
                        nativeBridgeFile: options.nativeBridgePath,
                        apiVersion: 9999,
                        verbose: options.verbose ?? false,
                        onlyIntegrated: options.onlyIntegrated ?? false,
                        dumpSerialized: options.dumpSerialized ?? false,
                        callLog: options.callLog ?? false,
                        lang: Language.TS,
                        useTypeChecker: options.typeChecker ?? true,
                    }, skoalaLibrary)

                    console.log("All files processed.")
                }
            }
        )
    }

    function saveIDL(file: IDLFile, baseDirs: string[], outputDir: string, sourceFile: ts.SourceFile) {
        let fileName = sourceFile.fileName
        baseDirs.forEach(dir => {
            const nextFileName = path.relative(path.resolve(dir), sourceFile.fileName)
            if (nextFileName.length < fileName.length) {
                fileName = nextFileName
            }
        })

        const basename = fileName.replace(/^\.*(\/|\\)/, '').replaceAll(path.sep, '.')
        const outFile = path.join(
            outputDir,
            basename.replace(".d.ts", ".idl")
        )

        const generated = toIDLString(file, {
            disableEnumInitializers: options.disableEnumInitializers ?? false
        })

        if (!fs.existsSync(path.dirname(outFile))) {
            fs.mkdirSync(path.dirname(outFile), { recursive: true })
        }
        fs.writeFileSync(outFile, generated)
    }
}

function fillGeneratedNativeModuleDeclaration(library: LibraryInterface): void {
    const declaration = createInterface(NativeModule.Generated.name, IDLInterfaceSubkind.Interface)
    const file = linkParentBack(
        createFile([declaration], undefined, PACKAGE_IDLIZE_INTERNAL.split("."))
    )
    library.files.push(file)
}
