/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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


import { program } from "commander"
import * as fs from "fs"
import * as path from "path"
import {
    fromIDL,
    toIDL,
    generate,
    defaultCompilerOptions,
    idlToDtsString,
    Language,
    findVersion,
    setDefaultConfiguration,
    PeerFile,
    PeerLibrary,
} from "@idlizer/core"
import {
    forEachChild,
    IDLEntry,
    isEnum,
    isInterface,
    isSyntheticEntry,
    toIDLString,
    transformMethodsAsync2ReturnPromise,
    verifyIDLString
} from "@idlizer/core/idl"
import { IDLVisitor, loadConfiguration, setFileGeneratorConfiguration,
    IDLInteropPredefinesVisitor, IdlPeerProcessor, IDLPredefinesVisitor,
    generateOhos, generateOhosOld, suggestLibraryName, loadPlugin, fillSyntheticDeclarations, DefaultConfig,
} from "@idlizer/libohos"

const options = program
    .option('--dts2idl', 'Convert .d.ts to IDL definitions')
    .option('--dts2peer', 'Convert .d.ts to peer drafts')
    .option('--input-dir <path>', 'Path to input dir(s), comma separated')
    .option('--output-dir <path>', 'Path to output dir')
    .option('--input-files <files...>', 'Comma-separated list of specific files to process')
    .option('--idl2dts', 'Convert IDL to .d.ts definitions')
    .option('--idl2peer', 'Convert IDL to peer drafts')
    .option('--verbose', 'Verbose processing')
    .option('--verify-idl', 'Verify produced IDL')
    .option('--api-version <version>', "API version for generated peers")
    .option('--dump-serialized', "Dump serialized data")
    .option('--call-log', "Call log")
    .option('--docs [all|opt|none]', 'How to handle documentation: include, optimize, or skip')
    .option('--language [ts|ts|java|cangjie]', 'Output language')
    .option('--api-prefix <string>', 'Cpp prefix to be compatible with manual arkoala implementation')
    .option('--version')
    .option('--plugin <file>', 'File with generator\'s plugin')
    .option('--default-idl-package <name>', 'Name of the default package for generated IDL')
    .option('--no-commented-code', 'Do not generate commented code in modifiers')
    .option('--use-new-ohos', 'Use new ohos generator')
    .option('--enable-log', 'Enable logging')
    .option('--split-files', 'Experemental feature to store declarations to different files for ohos generator')
    .option('--options-file <path>', 'Path to generator configuration options file (appends to defaults)')
    .option('--override-options-file <path>', 'Path to generator configuration options file (replaces defaults)')
    .parse()
    .opts()

let didJob = false
let apiVersion = options.apiVersion ?? 9999
setDefaultConfiguration(new DefaultConfig(apiVersion))
setFileGeneratorConfiguration(loadConfiguration(options.optionsFile, options.overrideOptionsFile))

if (process.env.npm_package_version) {
    console.log(`IDLize version ${findVersion()}`)
}

if (options.dts2idl) {

    const { inputDirs, inputFiles } = formatInputPaths(options)

    validatePaths(inputDirs, 'dir')
    validatePaths(inputFiles, 'file')

    generate(
        inputDirs,
        inputFiles,
        options.outputDir ?? "./idl",
        (sourceFile, typeChecker) => new IDLVisitor(sourceFile, typeChecker, options),
        {
            compilerOptions: defaultCompilerOptions,
            onSingleFile: (entries: IDLEntry[], outputDir, sourceFile) => {
                console.log('producing', path.basename(sourceFile.fileName))
                const outFile = path.join(
                    outputDir,
                    path.basename(sourceFile.fileName).replace(".d.ts", ".idl")
                )

                console.log("saved", outFile)

                if (options.skipDocs) {
                    entries.forEach(entry =>
                        forEachChild(entry, it => (it.documentation = undefined))
                    )
                }

                const generated = toIDLString(entries, {
                    disableEnumInitializers: options.disableEnumInitializers ?? false
                })

                if (options.verbose) {
                    console.log(generated)
                }

                if (!fs.existsSync(path.dirname(outFile))) {
                    fs.mkdirSync(path.dirname(outFile), { recursive: true })
                }
                fs.writeFileSync(outFile, generated)

                if (options.verifyIdl) {
                    verifyIDLString(generated)
                }
            }
        }
    )
    didJob = true
}

if (options.idl2peer) {
    const outDir = options.outputDir ?? "./out"
    const language = Language.fromString(options.language ?? "ts")

    const idlLibrary = new PeerLibrary(language)
    idlLibrary.files.push(...scanNotPredefinedDirectory(options.inputDir))
    new IdlPeerProcessor(idlLibrary).process()

    generateTarget(idlLibrary, outDir, language)

    didJob = true
}

if (options.idl2dts) {
    const generatedDtsDir = options.outputDir ?? "./generated/dts/"

    if (options.inputFiles && typeof options.inputFiles === 'string') {
        options.inputFiles = options.inputFiles
            .split(',')
            .map(file => file.trim())
            .filter(Boolean)
    }

    const inputDirs = options.inputDir

    if (typeof options.inputDir === 'string') {
        options.inputDir = options.inputDir.split(',')
            .map(dir => dir.trim())
            .filter(Boolean)
    }

    const inputFiles: string[] = options.inputFiles || []
    inputFiles.forEach(file => {
        if (!fs.existsSync(file)) {
            console.error(`Input file does not exist: ${file}`)
            process.exit(1)
        } else {
            console.log(`Input file exists: ${file}`)
        }
    })

    fromIDL(
        inputDirs,
        inputFiles,
        generatedDtsDir,
        ".d.ts",
        options.verbose ?? false,
        idlToDtsString
    )
    didJob = true
}


if (options.dts2peer) {
    const generatedPeersDir = options.outputDir ?? "./out/ts-peers/generated"
    const lang = Language.fromString(options.language ?? "ts")

    const PREDEFINED_PATH = path.join(__dirname, "..", "..", "predefined")

    if (options.inputFiles && typeof options.inputFiles === 'string') {
        options.inputFiles = options.inputFiles
            .split(',')
            .map(file => file.trim())
            .filter(Boolean)
    }

    if (options.inputDir && typeof options.inputDir === 'string') {
        options.inputDir = options.inputDir.split(',')
            .map(dir => dir.trim())
            .filter(Boolean)
    }

    const inputDirs: string[] = options.inputDir || []
    inputDirs.forEach(dir => {
        if (!fs.existsSync(dir)) {
            console.error(`Input directory does not exist: ${dir}`)
            process.exit(1)
        } else {
            console.log(`Input directory exists: ${dir}`)
        }
    })

    const inputFiles: string[] = options.inputFiles || []
    inputFiles.forEach(file => {
        if (!fs.existsSync(file)) {
            console.error(`Input file does not exist: ${file}`)
            process.exit(1)
        } else {
            console.log(`Input file exists: ${file}`)
        }
    })

    options.docs = "all"
    const idlLibrary = new PeerLibrary(lang)
    // collect predefined files
    scanPredefinedDirectory(PREDEFINED_PATH, "interop").forEach(file => {
        new IDLInteropPredefinesVisitor({
            sourceFile: file.originalFilename,
            peerLibrary: idlLibrary,
            peerFile: file,
        }).visitWholeFile()
    })

    scanPredefinedDirectory(PREDEFINED_PATH).forEach(file => {
        new IDLPredefinesVisitor({
            sourceFile: file.originalFilename,
            peerLibrary: idlLibrary,
            peerFile: file,
        }).visitWholeFile()
    })

    generate(
        inputDirs,
        inputFiles,
        generatedPeersDir,
        (sourceFile, typeChecker) => new IDLVisitor(sourceFile, typeChecker, options, idlLibrary),
        {
            compilerOptions: defaultCompilerOptions,
            onSingleFile(entries: IDLEntry[], outputDir, sourceFile) {
                entries = entries.filter(newEntry =>
                    !idlLibrary.files.find(peerFile => peerFile.entries.find(entry => {
                        if (([newEntry, entry].every(isInterface)
                            || [newEntry, entry].every(isEnum)
                            || [newEntry, entry].every(isSyntheticEntry))) {
                            if (newEntry.name === entry.name) {
                                return true
                            }
                        }
                        return false
                    }))
                )
                entries.forEach(it => {
                    transformMethodsAsync2ReturnPromise(it)
                })

                const baseFileName = path.resolve(sourceFile.fileName)
                const peerFile = new PeerFile(baseFileName, entries)

                idlLibrary.files.push(peerFile)
            },
            onEnd(outDir) {
///?
                // if (options.generatorTarget == "ohos") {
                //     // This setup code placed here because wrong prefix may be cached during library creation
                //     // TODO find better place for setup?
                //     setDefaultConfiguration(new DefaultConfig(apiVersion))
                // }
                fillSyntheticDeclarations(idlLibrary)
                const peerProcessor = new IdlPeerProcessor(idlLibrary)
                peerProcessor.process()

                generateTarget(idlLibrary, outDir, lang)
            }
        }
    )
    didJob = true
}

if (!didJob) {
    program.help()
}

function generateTarget(idlLibrary: PeerLibrary, outDir: string, lang: Language) {
    if (options.useNewOhos) {
        generateOhos(outDir, idlLibrary, new DefaultConfig(
            apiVersion, {
            LibraryPrefix: `${suggestLibraryName(idlLibrary)}_`,
            GenerateUnused: true
        }))
    } else {
        generateOhosOld(outDir, idlLibrary, apiVersion, options.defaultIdlPackage as string, options.splitFiles)
    }
    if (options.plugin) {
        loadPlugin(options.plugin)
            .then(plugin => plugin.process({outDir: outDir}, idlLibrary))
            .then(result => {
                console.log(`Plugin ${options.plugin} process returned ${result}`)
            })
            .catch(error => console.error(`Plugin ${options.plugin} not found: ${error}`))
    }
}

function scanNotPredefinedDirectory(dir: string, ...subdirs: string[]): PeerFile[] {
    return scanDirectory(false, dir, ...subdirs)
}

function scanPredefinedDirectory(dir: string, ...subdirs: string[]): PeerFile[] {
    return scanDirectory(true, dir, ...subdirs)
}

function scanDirectory(isPredefined: boolean, dir: string, ...subdirs: string[]): PeerFile[] {
    dir = path.join(dir, ...subdirs)
    return fs.readdirSync(dir)
        .filter(it => it.endsWith(".idl"))
        .map(it => {
            const idlFile = path.resolve(path.join(dir, it))
            const nodes = toIDL(idlFile)
            return new PeerFile(idlFile, nodes, isPredefined)
        })
}

function processInputOption(option: string | undefined): string[] {
    if (!option) return []
    if (typeof option === 'string') {
        return option.split(',')
            .map(item => item.trim())
            .filter(Boolean)
    }
    return []
}

function formatInputPaths(options: any): { inputDirs: string[]; inputFiles: string[] } {
    if (options.inputFiles && typeof options.inputFiles === 'string') {
        options.inputFiles = processInputOption(options.inputFiles)
    }

    if (options.inputDir && typeof options.inputDir === 'string') {
        options.inputDir = processInputOption(options.inputDir)
    }

    const inputDirs: string[] = options.inputDir || []
    const inputFiles: string[] = options.inputFiles || []

    return { inputDirs, inputFiles }
}

function validatePaths(paths: string[], type: 'file' | 'dir'): void {
    paths.forEach(pathItem => {
        if (!fs.existsSync(pathItem)) {
            console.error(`Input ${type} does not exist: ${pathItem}`)
            process.exit(1)
        } else {
            console.log(`Input ${type} exists: ${pathItem}`)
        }
    })
}
