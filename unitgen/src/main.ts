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
import { hasExtAttribute, IDLExtendedAttributes, IDLNode, inplaceGenerics, inplaceNullsAsUndefined, inplaceTransformOnSerializeFromConfig, Language, NativeModuleType, parseIDLFile, PeerLibrary, setDefaultConfiguration } from "@idlizer/core"
import { Command } from "commander"
import { LibaceInstall } from "./ut/LibaceInstall"
import { printUnitTestsAsMultipleFiles } from './ut/UnittestPrinter'
import { readdirSync, statSync } from "node:fs"
import { join, resolve } from "node:path"
import { fillSyntheticDeclarations, IdlPeerProcessor, loadPeerConfiguration } from "@idlizer/libohos"

export function generateLibaceUnitTests(config: {
    libaceDestination: string | undefined,
    outDir: string,
    aceTypes?: string,
}, peerLibrary: PeerLibrary) {
    const libace = config.libaceDestination ?
        new LibaceInstall(config.libaceDestination, false) :
        new LibaceInstall(config.outDir, true)

    printUnitTestsAsMultipleFiles(peerLibrary, libace, config.aceTypes)
}

function scan(root:string): string[] {
    return statSync(root).isDirectory()
        ? readdirSync(root).flatMap(f => scan(join(root, f)))
        : [root]
}

function main() {
    const program = new Command('Unit test generator')
        .argument('<input-files...>', 'Input files or directories')
        .option('--libace-destination <directory>', 'Libace destination')
        .option('--options-file <file>', 'Some options files')
        .option('--options-file-unittest <file>', 'Some options files')
        .option('--output-dir <directory>', 'Output directory path', resolve('out'))

    const parsed = program
        .parse()
    const options = parsed.opts()
    const args = parsed.args

    const library = new PeerLibrary(Language.ARKTS, new NativeModuleType('__IGNORE_ME__'))
    args.map(f => resolve(f)).flatMap(scan).forEach(file => {
        library.files.push(parseIDLFile(file))
    })

    setDefaultConfiguration(loadPeerConfiguration(options.optionsFile, false))

    library.files.forEach(inplaceTransformOnSerializeFromConfig)
    library.files.forEach(inplaceNullsAsUndefined)
    inplaceArkoalaGenerics(library)
    fillSyntheticDeclarations(library)
    library.enableCache()
    new IdlPeerProcessor(library).process()

    generateLibaceUnitTests({
        libaceDestination: options.libaceDestination,
        outDir: options.outputDir,
        aceTypes: options.optionsFileUnittest
    }, library)
}
main()

function inplaceArkoalaGenerics(library: PeerLibrary): void {
    library.files.forEach(file => inplaceGenerics(file, library, { ignore: [
        ignoreComponentRule,
    ]}))
}


function ignoreComponentRule(node: IDLNode): boolean {
    return hasExtAttribute(node, IDLExtendedAttributes.Component) || hasExtAttribute(node, IDLExtendedAttributes.ComponentInterface)
}

