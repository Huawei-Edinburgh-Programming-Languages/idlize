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
import * as path from "path"
import * as fs from "fs"
import { program } from "commander"
import {
    findVersion,
    setDefaultConfiguration,
    scanInputDirs,
    PeerLibrary,
    Language,
    toIDLFile,
    verifyIDLLinter,
    generatorConfiguration,
    IDLKind,
    IDLLinterError,
    optimizeSynthetics,
    linkParentBack,
    toIDLString
} from "@idlizer/core"
import { formatInputPaths, validatePaths, loadPeerConfiguration, libohosPredefinedFiles, peerGeneratorConfiguration } from "@idlizer/libohos"
import { generateFromSts } from "./generate"
import { readConfig } from "./config"
import { resolve } from "node:path"

const options = program
    .option('--ets2idl', 'Convert .d.ts to IDL definitions')
    .option('--idl2ets', 'Convert IDL to .d.sts definitions')
    .option('--input-dir <path>', 'Path to input dir(s), comma separated')
    .option('--base-dir <path>', 'Base directories, for the purpose of packetization of IDL modules, comma separated, defaulted to --input-dir if missing')
    .option('--output-dir <path>', 'Path to output dir')
    .option('--input-files <files...>', 'Comma-separated list of specific files to process')
    .option('--verify-idl', 'Verify produced IDL')
    .option('--docs [all|opt|none]', 'How to handle documentation: include, optimize, or skip')
    .option('--version')
    .option('--options-file <path>', 'Path to generator configuration options file (appends to defaults). Use --ignore-default-config to override default options.')
    .option('--ignore-default-config', 'Use with --options-file to override default generator configuration options.', false)
    .option('--group-synthetics', 'Group synthetics into single file')
    .parse()
    .opts()

if (process.env.npm_package_version) {
    console.log(`IDLize version ${findVersion()}`)
}

let didJob = false

const { baseDirs, inputDirs, auxInputDirs, inputFiles, auxInputFiles } = formatInputPaths(options)
validatePaths(baseDirs, "dir")
validatePaths(inputDirs, "dir")
validatePaths(auxInputDirs, "dir")
validatePaths(inputFiles, "file")
validatePaths(auxInputFiles, "file")

const detsInputFiles = scanInputDirs(inputDirs, (it) => it.endsWith("d.ets"), true).concat(inputFiles)

if (options.ets2idl) {
    const { inputDirs, inputFiles } = formatInputPaths(options)
    validatePaths(inputDirs, 'dir')
    validatePaths(inputFiles, 'file')
    generateFromSts({
        inputFiles: detsInputFiles,
        baseDir: options.baseDir,
        outDir: options.outputDir,
        etsConfigPath: options.etsConfig,
        config: readConfig(resolve(__dirname, '..', 'generator-config.json'))
    })
    didJob = true
}

function arkgenPredefinedFiles(): string[] {
    return scanInputDirs([path.join(__dirname, "../../arkgen/predefined")])
}

if (options.groupSynthetics) {
    const { inputFiles, inputDirs } = formatInputPaths(options)

    let idlLibrary = new PeerLibrary(Language.TS, options.useMemoM3)
    idlLibrary.disableFallback()
    const allInputFiles = scanInputDirs(inputDirs)
        .concat(inputFiles)
        .concat(libohosPredefinedFiles())
        .concat(arkgenPredefinedFiles())
    const idlInputFiles = allInputFiles.filter(it => it.endsWith('.idl'))
    idlInputFiles.forEach(idlFilename => {
        idlFilename = path.resolve(idlFilename)
        const [file] = toIDLFile(idlFilename)
        idlLibrary.files.push(file)
    })

    const { syntheticFile, mutatedFiles } = optimizeSynthetics(idlLibrary.files.filter(it => it.fileName?.startsWith(path.resolve(options.outputDir))), idlLibrary, "arkui.component.synthetic".split("."))

    mutatedFiles.forEach((mutatedFile, index) => {
        const filename = idlLibrary.files[index].fileName!
        fs.writeFileSync(filename, toIDLString(mutatedFile, {}), 'utf8')
    })
    const syntheticFilename = path.resolve(options.outputDir, "arkui.component.synthetic.idl")
    fs.writeFileSync(syntheticFilename, toIDLString(syntheticFile, {}), 'utf8')

    const newIdlLibrary = new PeerLibrary(Language.TS)
    newIdlLibrary.disableFallback()
    new Array(syntheticFile, ...mutatedFiles).forEach(it => {
        linkParentBack(it)
        newIdlLibrary.files.push(it)
    })
    idlLibrary = newIdlLibrary

    let totalErrors = 0
    const errorRecords: [string, number][] = []
    idlLibrary.files.forEach(file => {
        try {
            verifyIDLLinter(file, idlLibrary, {
                checkEnumsConsistency: true,
                checkReferencesResolved: true,
                validEntryAttributes: new Map([
                    [IDLKind.Import, ["Deprecated", "Documentation"]],
                    [IDLKind.Namespace, ["DefaultExport", "Deprecated", "Documentation", "VerbatimDts"]],
                    [IDLKind.Const, ["DefaultExport", "Deprecated", "Documentation"]],
                    [IDLKind.Property, ["DefaultExport", "Optional", "Accessor", "Deprecated", "CommonMethod", "Protected", "DtsName", "Documentation"]],
                    [IDLKind.Interface, ["DefaultExport", "Predefined", "TSType", "CPPType", "Entity", "Interfaces", "ParentTypeArguments", "Component", "Synthetic", "Deprecated", "HandWrittenImplementation", "Documentation", "TypeParameters", "ComponentInterface"]],
                    [IDLKind.Callback, ["DefaultExport", "Deprecated", "Async", "Synthetic", "Documentation", "TypeParameters"]],
                    [IDLKind.Method, ["DefaultExport", "Optional", "DtsTag", "DtsName", "Throws", "Deprecated", "IndexSignature", "Protected", "Documentation", "CallSignature", "TypeParameters"]],
                    [IDLKind.Callable, ["DefaultExport", "CallSignature", "Deprecated", "Documentation", "CallSignature"]],
                    [IDLKind.Typedef, ["DefaultExport", "Deprecated", "Import", "Documentation", "TypeParameters"]],
                    [IDLKind.Enum, ["DefaultExport", "Deprecated", "Documentation"]],
                    [IDLKind.EnumMember, ["OriginalEnumMemberName", "Deprecated", "Documentation"]],
                    [IDLKind.Constructor, ["Deprecated", "Documentation"]]
                ]),
            })
        } catch (error) {
            if (error instanceof IDLLinterError) {
                totalErrors += error.size
                errorRecords.push([file.fileName ?? '', error.size])
                console.error(error.message)
                return
            }
            throw error
        }
    })
    if (totalErrors > 0) {
        process.exitCode = -1
        console.error()
        errorRecords.forEach(([fileName, errorNumber]) => {
            console.error(`${errorNumber.toString().padStart(5, ' ')} ${fileName}`)
        })

        console.error('      ----------------------------')
        console.error(`      Total errors: ${totalErrors}`)
    }
    didJob = true
}

if (options.idl2sts) {
    throw new Error("Not yet implemented")
}

if (!didJob) {
    program.help()
}